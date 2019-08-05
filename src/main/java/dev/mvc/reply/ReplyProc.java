package  dev.mvc.reply;
 
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc implements ReplyProcInter {

  @Autowired
  private ReplyDAOInter replyDAO;

  @Override
  public int create(ReplyVO replyVO) {
    int count = replyDAO.create(replyVO);
    return count;
  }
  @Override
  public int create_reply(ReplyVO replyVO) {
    int count = replyDAO.create_reply(replyVO);
    return count;
  }
  
  @Override
  public ArrayList<ReplyVO> list(int contentsno) {
    ArrayList<ReplyVO> list = replyDAO.list(contentsno);
    return list;
  }

  @Override
  public int update(ReplyVO replyVO) {
    int count = replyDAO.update(replyVO);
    return count;
  }

  @Override
  public ReplyVO update_seq(int parent_replyno) {
    ReplyVO replyVO = new ReplyVO();
    // 부모글(답변을 붙일글) 관련 정보 조회
    ReplyVO parent_replyVO = replyDAO.read(parent_replyno);
    
    //HashMap 
    HashMap<String, Integer> map = new HashMap<String, Integer>();
    map.put("grpno", parent_replyVO.getGrpno()); //parent_grpno
    map.put("indent", parent_replyVO.getIndent()+1);//parent_indent + 1
    map.put("contentsno", parent_replyVO.getContentsno());//parent_contentsno
    map.put("ansnum", parent_replyVO.getAnsnum());//parent_ansnum
    //indent가 같고 grpno도 같은 것의 개수를 세고
    // 그 개수가 0이면 부모 바로 하단에 위치 시키도록 함.
    // 그 개수가 0이 아니면 같은 indent 그룹 하단에 위치 시키도록 
    // 어느 댓글 밑에 순서에 달을지 정해준다.
    // 단! 부모의 ansnum보다 작은 ansnum을 가진 것은 개수를 세지 않도록 한다.
    // 그냥 대댓글에 다시 댓글을 달 수 없도록 한다.
    //앞쪽에 있는 거까지는 걸를수 있는데 뒤쪽에 있는 건 걸를 수가 없어서, 컬럼이 하나 더 필요함. 그냥 이렇게 할래...
    int seq = parent_replyVO.getAnsnum()+ replyDAO.count_grp_ind(map);
    
    
    // 답변임으로 부모의 grpno를 가져와 등록될 VO 객체에 저장
    replyVO.setGrpno(parent_replyVO.getGrpno());
    // 답변임으로 부모보다 들여쓰기를 1 증가 시킴
    replyVO.setIndent(parent_replyVO.getIndent() + 1);
    // seq번호를 가진 댓글 바로 밑에 댓글을 달아준다.
    replyVO.setAnsnum(seq+1);
	  
    //HashMap 
    map = new HashMap<String, Integer>();
    map.put("grpno", parent_replyVO.getGrpno()); //parent_grpno
    map.put("ansnum", seq);//parent_ansnum 
    // 부모ansnum보다 큰 ansnum값을 가진 기존에 등록된 댓글들의 ansnum을 1씩 증가
    int count = replyDAO.update_ans(map);
    //System.out.println("update_ans: " + count);

    return replyVO;
  }

  @Override
  public int delete(int replyno) {
    int count = replyDAO.delete(replyno);
    return count;
  }

  @Override
  public int count_all(int contentsno) {
    int count = replyDAO.count_all(contentsno);
    return count;
  }

  @Override
  public ReplyVO read(int replyno) {
    ReplyVO replyVO = replyDAO.read(replyno);
    return replyVO;
  }

}
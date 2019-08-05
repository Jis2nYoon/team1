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
    // �θ��(�亯�� ���ϱ�) ���� ���� ��ȸ
    ReplyVO parent_replyVO = replyDAO.read(parent_replyno);
    
    //HashMap 
    HashMap<String, Integer> map = new HashMap<String, Integer>();
    map.put("grpno", parent_replyVO.getGrpno()); //parent_grpno
    map.put("indent", parent_replyVO.getIndent()+1);//parent_indent + 1
    map.put("contentsno", parent_replyVO.getContentsno());//parent_contentsno
    map.put("ansnum", parent_replyVO.getAnsnum());//parent_ansnum
    //indent�� ���� grpno�� ���� ���� ������ ����
    // �� ������ 0�̸� �θ� �ٷ� �ϴܿ� ��ġ ��Ű���� ��.
    // �� ������ 0�� �ƴϸ� ���� indent �׷� �ϴܿ� ��ġ ��Ű���� 
    // ��� ��� �ؿ� ������ ������ �����ش�.
    // ��! �θ��� ansnum���� ���� ansnum�� ���� ���� ������ ���� �ʵ��� �Ѵ�.
    // �׳� ���ۿ� �ٽ� ����� �� �� ������ �Ѵ�.
    //���ʿ� �ִ� �ű����� �ɸ��� �ִµ� ���ʿ� �ִ� �� �ɸ� ���� ���, �÷��� �ϳ� �� �ʿ���. �׳� �̷��� �ҷ�...
    int seq = parent_replyVO.getAnsnum()+ replyDAO.count_grp_ind(map);
    
    
    // �亯������ �θ��� grpno�� ������ ��ϵ� VO ��ü�� ����
    replyVO.setGrpno(parent_replyVO.getGrpno());
    // �亯������ �θ𺸴� �鿩���⸦ 1 ���� ��Ŵ
    replyVO.setIndent(parent_replyVO.getIndent() + 1);
    // seq��ȣ�� ���� ��� �ٷ� �ؿ� ����� �޾��ش�.
    replyVO.setAnsnum(seq+1);
	  
    //HashMap 
    map = new HashMap<String, Integer>();
    map.put("grpno", parent_replyVO.getGrpno()); //parent_grpno
    map.put("ansnum", seq);//parent_ansnum 
    // �θ�ansnum���� ū ansnum���� ���� ������ ��ϵ� ��۵��� ansnum�� 1�� ����
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
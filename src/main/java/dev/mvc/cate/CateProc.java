package  dev.mvc.cate;
 
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cate.CateProc")
public class CateProc implements CateProcInter {

  @Autowired
  private CateDAOInter cateDAO;
  
  @Override
  public int create(CateVO cateVO) {
    // 스프링이 자동으로 구현한 빈을 사용함.
    int count = cateDAO.create(cateVO);
    return count;
  }
  @Override
  public ArrayList<CateVO> list_cateno_asc(){
    ArrayList<CateVO> list = cateDAO.list_cateno_asc();
    
    return list;
  }
  
  @Override
  public ArrayList<CateVO> list_seqno_asc(){
    ArrayList<CateVO> list = cateDAO.list_seqno_asc();
    
    return list;
  }
  
  @Override
  public CateVO read(int cateno){
    CateVO cateVO = cateDAO.read(cateno);
    
    return cateVO;
  }
  
  @Override
  public int update(CateVO cateVO){
    int count = cateDAO.update(cateVO);
    
    return count;
  }
  @Override
  public int delete(int cateno) {
    int count = cateDAO.delete(cateno);
    return count;
  }

  @Override
  public int seqno_inc(int cateno) {
    int count = cateDAO.seqno_inc(cateno);
    return count;
  }

  @Override
  public int seqno_dec(int cateno) {
    int count = cateDAO.seqno_dec(cateno);
    return count;
  }
  @Override
  public int cnt_inc(int cateno) {
    int count = cateDAO.cnt_inc(cateno);
    return count;
  }
  @Override
  public int cnt_dec(int cateno) {
    int count = cateDAO.cnt_dec(cateno);
    return count;
  }
  @Override
  public int fk_delete(int cateno) {
    int count = cateDAO.fk_delete(cateno);
    return count;
  }
  @Override
  public int fk_zero(int cateno) {
    int count = cateDAO.fk_zero(cateno);
    return count;
  }
}
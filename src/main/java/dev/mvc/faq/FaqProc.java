package dev.mvc.faq;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.faq.FaqProc")
public class FaqProc implements FaqProcInter {
  @Autowired
  private FaqDAOInter faqDAO;
  
  public FaqProc () {
    System.out.println("--> FaqProc created.");
  }

  @Override
  public int create(FaqVO faqVO) {
    int count = faqDAO.create(faqVO);
    return count;
  }

  @Override
  public ArrayList<FaqVO> list() {
    ArrayList<FaqVO> list = faqDAO.list();
    return list;
  }

  @Override
  public FaqVO read(int faqno) {
    FaqVO faqVO =faqDAO.read(faqno);
    return faqVO;
  }

  @Override
  public int update(FaqVO faqVO) {
    int count = faqDAO.update(faqVO);
    return count;
  }

  @Override
  public int delete(int faqno) {
    int count = faqDAO.delete(faqno);
    return count;
  }
  
}

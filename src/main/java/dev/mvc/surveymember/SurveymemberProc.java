package dev.mvc.surveymember;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.surveymember.SurveymemberProc")
public class SurveymemberProc implements SurveymemberProcInter{
  @Autowired
  private SurveymemberDAOInter surveymemberDAO;
  
    public SurveymemberProc() {
        System.out.println("--> SurveymemberProc created.");
    }

    @Override
    public int create(SurveymemberVO surveymemberVO) {
      int count = surveymemberDAO.create(surveymemberVO);
      return count;
    }
}

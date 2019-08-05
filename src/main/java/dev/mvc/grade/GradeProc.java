package dev.mvc.grade;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.grade.GradeProc")
    public class GradeProc implements GradeProcInter {
  @Autowired
  private GradeDAOInter gradeDAO;
  
  public GradeProc() {
    
  }

  @Override
  public int create(int memberno) {
    int count = gradeDAO.create(memberno);
    
    return count;
  }

  @Override
  public ArrayList<Member_GradeVO> list() {
    ArrayList<Member_GradeVO> list = gradeDAO.list();
    
    return list;
  }

  @Override
  public GradeVO read(int memberno) {
    GradeVO gradeVO = gradeDAO.read(memberno);
    
    return gradeVO;
  }

  @Override
  public int update(GradeVO gradeVO) {
    int count = gradeDAO.update(gradeVO);
    
    return count;
  }

  @Override
  public int delete(int memberno) {
    int count = gradeDAO.delete(memberno);
    
    return count;
  }

  @Override
  public int count_memno(int memberno) {
    int count = gradeDAO.count_memno(memberno);
    
    return count;
  }

  @Override
  public int update_manner(int manner, int mno) {
    int count = gradeDAO.update_manner(manner, mno);
    
    return count;
  }
}

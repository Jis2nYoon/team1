package dev.mvc.login;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.login.LoginProc")
public class LoginProc implements LoginProcInter {
  @Autowired
  private LoginDAOInter loginDAO;
  
  public LoginProc () {
    //System.out.println("--> LoginProc created.");
  }

  @Override
  public int create(LoginVO loginVO) {
    int count = loginDAO.create(loginVO);
    return count;
  }

  @Override
  public ArrayList<Member_LoginVO> list() {
    ArrayList<Member_LoginVO> list = loginDAO.list();
    
    return list;
  }

  @Override
  public ArrayList<LoginVO> list_memberno(int memberno) {
    ArrayList<LoginVO> list = loginDAO.list_memberno(memberno);
    
    return list;
  }

  @Override
  public int delete(int memberno) {
    int count = loginDAO.delete(memberno);
    return count;
  }

  @Override
  public int count_memno(int memberno) {
    int count = loginDAO.count_memno(memberno);
    
    return count;
  }
  
  
}
  
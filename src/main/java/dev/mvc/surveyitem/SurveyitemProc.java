package dev.mvc.surveyitem;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.surveyitem.SurveyitemProc")
public class SurveyitemProc implements SurveyitemProcInter {
	@Autowired
  private SurveyitemDAOInter surveyitemDAO;
	
    public SurveyitemProc() {
        System.out.println("--> SurveyitemProc created.");
    }

    @Override
    public int create(SurveyitemVO surveyitemVO) {
      int count = surveyitemDAO.create(surveyitemVO);
      return count;
    }

    @Override
    public ArrayList<SurveyitemVO> list(int surveyno) {
      ArrayList<SurveyitemVO> list = surveyitemDAO.list(surveyno);
      return list;
    }
    
    @Override
    public SurveyitemVO read(int surveyitemno) {
      SurveyitemVO surveyitemVO = surveyitemDAO.read(surveyitemno);
      return surveyitemVO;
    }

    @Override
    public int update(SurveyitemVO surveyitemVO) {
      int count = surveyitemDAO.update(surveyitemVO);
      return count;
    }

    @Override
    public int delete_item(int surveyitemno) {
      int count = surveyitemDAO.delete_item(surveyitemno);
      return count;
    }

    @Override
    public int countByItem(int surveyno) {
      int cnt = surveyitemDAO.countByItem(surveyno);
      return cnt;
    }



}

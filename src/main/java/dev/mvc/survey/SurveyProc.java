package dev.mvc.survey;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.survey.SurveyProc")
public class SurveyProc implements SurveyProcInter {
	@Autowired
  private SurveyDAOInter surveyDAO;
	
    public SurveyProc() {
      System.out.println("--> SurveyProc created.");
    }

    @Override
    public int create(SurveyVO surveyVO) {
      int count = surveyDAO.create(surveyVO);
      return count;
    }

    @Override
    public ArrayList<SurveyVO> list_user() {
      ArrayList<SurveyVO> list = surveyDAO.list_user();
      return list;
    }

    @Override
    public ArrayList<SurveyVO> list_admin() {
      ArrayList<SurveyVO> list = surveyDAO.list_admin();
      return list;
    }

    @Override
    public Survey_ItemVO read_join(int surveyno) {
      Survey_ItemVO survey_ItemVO = surveyDAO.read_join(surveyno);
      return survey_ItemVO;
    }

    @Override
    public int update(SurveyVO surveyVO) {
      int count = surveyDAO.update(surveyVO);
      return count;
    }

    @Override
    public int delete(int surveyno) {
      int count = surveyDAO.delete(surveyno);
      return count;
    }

    @Override
    public SurveyVO read(int surveyno) {
      SurveyVO surveyVO = surveyDAO.read(surveyno);
      return surveyVO;
    }

}

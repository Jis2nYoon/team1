package dev.mvc.content;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import nation.web.tool.Tool;



@Component("dev.mvc.content.ContentProc")
public class ContentProc implements ContentProcInter {
  @Autowired
  private ContentDAOInter contentDAO;
  
  public ContentProc () {
    System.out.println("--> ContentsProc created.");
  }

  @Override
  public int create(ContentVO contentVO) {
    int count = contentDAO.create(contentVO);
    return count;
  }

  @Override
  public ContentVO read(int contentsno) {
    ContentVO contentVO = contentDAO.read(contentsno);
    return contentVO;
  }

  @Override
  public int update(ContentVO contentVO) {
    int count = contentDAO.update(contentVO);
    return count;
  }
  @Override
  public int deletefile(ContentVO contentVO) {
    int count = contentDAO.deletefile(contentVO);
    return count;
  }
  @Override
  public int delete(int contentno) {
    int count = contentDAO.delete(contentno);
    return count;
  }

  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param contentsVO
   * @return
   */
  @Override
  public ArrayList<FileVO> getThumbs(ContentVO contentVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String files = contentVO.getPicture();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = contentVO.getPicsize();        // 272558/404087... 
    
    String[] files_array = files.split("/");   // 파일명 추출
    String[] sizes_array = sizes.split("/"); // 파일 사이즈

    int count = sizes_array.length;

    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
        FileVO fileVO = new FileVO();
        fileVO.setFile(files_array[index]);
        fileVO.setSize(sizes_array[index]);
        file_list.add(fileVO);
      }
    } 

    return file_list;
  }

  @Override
  public ArrayList<Cate_ContentVO> search_list_all(HashMap map) {
    ArrayList<Cate_ContentVO> list = contentDAO.search_list_all(map);
    return list;
  }

  @Override
  public ArrayList<ContentVO> search_list_by_cateno(HashMap map) {
    ArrayList<ContentVO> list = contentDAO.search_list_by_cateno(map);
    return list;
  }

  @Override
  public int search_count_all(HashMap map) {
    int count = contentDAO.search_count_all(map);
    return count;
  }

  @Override
  public int search_count_by_cateno(HashMap map) {
    int count = contentDAO.search_count_by_cateno(map);
    return count;
  }
  /** 
   * Bootstrap Paging을 이용
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param listFile 목록 파일명 
   * @param cateno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(String listFile, int cateno, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Content.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Content.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Content.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Content.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Content.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<ul class='pagination'>");
   //  str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Content.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<li><a href='"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&cateno="+cateno+"'>이전</a></li>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<li class='active'><a href='#'>"+i+"</a></li>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<li><a href='"+listFile+"?word="+word+"&nowPage="+i+"&cateno="+cateno+"'>"+i+"</a></li>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Content.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<li><a href='"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&cateno="+cateno+"'>다음</a></li>"); 
    }      
    return str.toString(); 
  }
 
  @Override
  public ArrayList<Cate_ContentVO> search_list_all_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Content.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Content.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
   ArrayList<Cate_ContentVO> list = contentDAO.search_list_all_paging(map);
    
    return list;
  }  
  @Override
  public ArrayList<ContentVO> search_list_by_cateno_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Content.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Content.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<ContentVO> list = contentDAO.search_list_by_cateno_paging(map);
    
    return list;
  }

  @Override
  public int views(int contentsno) {
    int count = contentDAO.views(contentsno);
    return count;
  }

  @Override
  public int sale(int contentsno) {
    int count = contentDAO.sale(contentsno);
    return count;
  }
  
}

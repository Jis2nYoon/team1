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
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param contentsVO
   * @return
   */
  @Override
  public ArrayList<FileVO> getThumbs(ContentVO contentVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String files = contentVO.getPicture();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = contentVO.getPicsize();        // 272558/404087... 
    
    String[] files_array = files.split("/");   // ���ϸ� ����
    String[] sizes_array = sizes.split("/"); // ���� ������

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
   * Bootstrap Paging�� �̿�
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param listFile ��� ���ϸ� 
   * @param cateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(String listFile, int cateno, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Content.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Content.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Content.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Content.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Content.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<ul class='pagination'>");
   //  str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Content.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<li><a href='"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&cateno="+cateno+"'>����</a></li>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<li class='active'><a href='#'>"+i+"</a></li>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<li><a href='"+listFile+"?word="+word+"&nowPage="+i+"&cateno="+cateno+"'>"+i+"</a></li>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Content.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<li><a href='"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&cateno="+cateno+"'>����</a></li>"); 
    }      
    return str.toString(); 
  }
 
  @Override
  public ArrayList<Cate_ContentVO> search_list_all_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Content.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Content.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
   ArrayList<Cate_ContentVO> list = contentDAO.search_list_all_paging(map);
    
    return list;
  }  
  @Override
  public ArrayList<ContentVO> search_list_by_cateno_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Content.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Content.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
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

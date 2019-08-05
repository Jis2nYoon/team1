package dev.mvc.msg;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.content.FileVO;
import dev.mvc.content.ContentVO;

import nation.web.tool.Tool;



@Component("dev.mvc.msg.MsgProc")
public class MsgProc implements MsgProcInter {
  @Autowired
  private MsgDAOInter msgDAO;
  
  public MsgProc () {
    System.out.println("--> MsgProc created.");
  }

  /**
   * ���� ������ (���/����)
   */
  @Override
  public int create(MsgVO msgVO) {
    int count = msgDAO.create(msgVO);
    return count;
  }
  
  /**
   * �Ǹ����ΰ�� ���
   */
  @Override
  public ArrayList<ContentVO> list_seller(int msgreceiver) {
    ArrayList<ContentVO> list = msgDAO.list_seller(msgreceiver);
    
    return list;
  }
  /**
   * �������� ��� ���
   */
  @Override
  public ArrayList<Mem_ContentVO> list_buyer(int memberno) {
    ArrayList<Mem_ContentVO> list = msgDAO.list_buyer(memberno);
    
    return list;
  }
  
  /**
   * Join 1�� ��ȸ
   */
  @Override
  public Mem_ContentVO read_by_join(int contentsno) {
    Mem_ContentVO mem_ContentVO = msgDAO.read_by_join(contentsno);
    return mem_ContentVO;
  }

  /**
   * ���� ���� ���
   */
  @Override
  public ArrayList<Mem_MsgVO> list_send(HashMap<String, Object> map) {
    ArrayList<Mem_MsgVO> list = msgDAO.list_send(map);
    
    return list;
  }

  /**
   * ���� ���� ���
   */
  @Override
  public ArrayList<Mem_MsgVO> list_receive(HashMap<String, Object> map) {
    ArrayList<Mem_MsgVO> list = msgDAO.list_receive(map);
    
    return list;
  }

  /**
   * ���� 1�� �б�
   */
  @Override
  public MsgVO read_msg(int msgno) {
    MsgVO msgVO = msgDAO.read_msg(msgno);
    return msgVO;
  }
  
  /**
   * ���� ������ Ȯ��
   */
  @Override
  public int check_msg(HashMap<String, Object> map) {
    int count = msgDAO.check_msg(map);
    return count;
  }

  /**
   * ���� �����ϱ�
   */
  @Override
  public int delete_msg(int msgno) {
    int count = msgDAO.delete_msg(msgno);
    return count;
  }
  
  /**
   * ����
   */
  @Override
  public int search_count(HashMap<String, Object> map) {
    int count = msgDAO.search_count(map);
    return count;
  }
  
  /**
   * ����
   */
  @Override
  public int search_count2(HashMap<String, Object> map) {
    int count = msgDAO.search_count2(map);
    return count;
  }
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   * @param listFile ��� ���ϸ�
   * @param cateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(String listFile, int search_count, int nowPage, String word, String col, int contentsno, int memberno){
    int totalPage = (int)(Math.ceil((double)search_count/Msg.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Msg.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Msg.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Msg.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Msg.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Msg.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+ listFile +"?&word="+word+"&nowPage="+_nowPage+"&col="+col+"&contentsno="+contentsno+"&memberno="+memberno+"'>����</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./"+ listFile +"?word="+word+"&nowPage="+i+"&col="+col+"&contentsno="+contentsno+"&memberno="+memberno+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Msg.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+ listFile +"?&word="+word+"&nowPage="+_nowPage+"&col="+col+"&contentsno="+contentsno+"&memberno="+memberno+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  /**
   * ���� ���� ��� + �˻� + ����¡
   */
  @Override
  public ArrayList<Mem_MsgVO> send_list_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Msg.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Msg.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
    
    ArrayList<Mem_MsgVO> list = msgDAO.send_list_search_paging(map);
    
/*    int count = list.size();
    for(int i=0; i<count; i++) {
      ContentsVO contentsVO = list.get(i);
      String thumb = getThumb(contentsVO);
      contentsVO.setThumb(thumb);  // ��ǥ �̹��� ����
    }*/
    
    return list;
  }

  /**
   * ���� ���� ��� + �˻� + ����¡
   */
  @Override
  public ArrayList<Mem_MsgVO> receive_list_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Msg.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Msg.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
    
    ArrayList<Mem_MsgVO> list = msgDAO.receive_list_search_paging(map);
    
/*    int count = list.size();
    for(int i=0; i<count; i++) {
      ContentsVO contentsVO = list.get(i);
      String thumb = getThumb(contentsVO);
      contentsVO.setThumb(thumb);  // ��ǥ �̹��� ����
    }*/
    
    return list;
  }

  /**
   * �Խñ� �ȿ� ��� ���� �����ϱ�
   */
  @Override
  public int delete_all_msg(int contentsno) {
    int count = msgDAO.delete_all_msg(contentsno);
    return count;
  }
  
  /**
   * �̹��� ����߿� ù��° �̹��� ���ϸ��� �����Ͽ� ����
   * @param contentsVO
   * @return
   */
  public String getThumb(MsgVO msgVO) {
    String thumbs = msgVO.getThumbs();
    String thumb = "";
    
    if (thumbs != null) {
      String[] thumbs_array = thumbs.split("/");
      int count = thumbs_array.length;
      
      if (count > 0) {
        thumb = thumbs_array[0];    
      }
    }
    // System.out.println("thumb: " + thumb);
    return thumb;
  }
  
  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param contentsVO
   * @return
   */
    public ArrayList<FileVO> getThumbs(MsgVO msgVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String thumbs = msgVO.getThumbs(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String files = msgVO.getFiles();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = msgVO.getSizes();        // 272558/404087... 
    
    String[] thumbs_array = thumbs.split("/");  // Thumbs
    String[] files_array = files.split("/");   // ���ϸ� ����
    String[] sizes_array = sizes.split("/"); // ���� ������
 
    int count = sizes_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);
 
    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
      
        FileVO fileVO = new FileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
 
    return file_list;
  }
  
}

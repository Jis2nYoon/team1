package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import nation.web.tool.Tool;

@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter {
  @Autowired
  private QnaDAOInter qnaDAO;
  
  public QnaProc () {
    System.out.println("--> QnaProc created.");
  }

  @Override
  public int create(QnaVO qnaVO) {
    int count = qnaDAO.create(qnaVO);
    return count;
  }

  @Override
  public ArrayList<Mem_QnaVO> list() {
    ArrayList<Mem_QnaVO> list = qnaDAO.list();
    return list;
  }
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param qnaVO
   * @return
   */
  public ArrayList<QnaFileVO> getThumbs(Mem_QnaVO mem_QnaVO) {
    ArrayList<QnaFileVO> file_list = new ArrayList<QnaFileVO>();
    
    String thumbs = mem_QnaVO.getQnathumb(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String files = mem_QnaVO.getFiles();          // xmas01_2.jpg/xmas02_2.jpg...
    String filesizes = mem_QnaVO.getFilesizes();        // 272558/404087... 
    
    if (thumbs != null) {
      String[] thumbs_array = thumbs.split("/");  // Thumbs
      String[] files_array = files.split("/");   // 파일명 추출
      String[] filesizes_array = filesizes.split("/"); // 파일 사이즈

      int count = filesizes_array.length;
      // System.out.println("sizes_array.length: " + sizes_array.length);
      // System.out.println("sizes: " + sizes);
      // System.out.println("files: " + files);

      if (files.length() > 0) {
        for (int index = 0; index < count; index++) {
          filesizes_array[index] = Tool.unit(new Integer(filesizes_array[index]));  // 1024 -> 1KB
               
          QnaFileVO fileVO = new QnaFileVO(thumbs_array[index], 
                                            files_array[index], 
                                            filesizes_array[index]);
          file_list.add(fileVO);
        }
      } 
    } else {
      thumbs = "";
      files = "";  
      filesizes = "";
    }

    return file_list;
  }

  @Override
  public Mem_QnaVO read(int qnano) {
    Mem_QnaVO mem_QnaVO = qnaDAO.read(qnano);
    return mem_QnaVO;
  }

  @Override
  public int update(QnaVO qnaVO){
    int count = qnaDAO.update(qnaVO);
    return count;
  }
  
  @Override
  public int delete(int qnano) {
    int count = qnaDAO.delete(qnano);
    return count;
  }

  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    int count = qnaDAO.increaseAnsnum(map);
    return count;
  }

  @Override
  public int reply(QnaVO qnaVO) {
    int count = qnaDAO.reply(qnaVO);
    return count;
  }

}

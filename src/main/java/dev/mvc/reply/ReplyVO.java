package dev.mvc.reply;

public class ReplyVO {
  private int replyno; //����� �߰� �����Ǹ鼭 ��� ���� �ĺ�Ű��
  private String replycont; //��� ���� ������� �ĺ��� �� ��ȣ
  private int contentsno; //��� �Է��� �ĺ��� ��� ��ȣ
  private int memberno; //��� ����
  private String rdate; //��� �Է� �ð�
  private int grpno; //����� ����
  private int indent; //����� ���� ǥ���Ҷ� indent �̿�. 0~1�� ǥ���ϵ�����.
  private int ansnum; //������ ����
  public int getReplyno() {
    return replyno;
  }
  public void setReplyno(int replyno) {
    this.replyno = replyno;
  }
  public String getReplycont() {
    return replycont;
  }
  public void setReplycont(String replycont) {
    this.replycont = replycont;
  }
  public int getContentsno() {
    return contentsno;
  }
  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getGrpno() {
    return grpno;
  }
  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }
  public int getIndent() {
    return indent;
  }
  public void setIndent(int indent) {
    this.indent = indent;
  }
  public int getAnsnum() {
    return ansnum;
  }
  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }

  
}


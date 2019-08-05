<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

    <title>Bootstrap datepicket demo</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>

<script src="../js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" type="text/css" href="../css/datetimepickerstyle.css" />

    <script type='text/javascript'>
    $(document).ready(function(){
      $('.dateTimePicker').datetimepicker({format:"YYYY-MM-DD",minDate : moment()});
             $('#startdate').datetimepicker({
                 useCurrent: false
             });
             $('#enddate').datetimepicker({
                 useCurrent: false
             });
             $('#datepicker3').datetimepicker({
                 useCurrent: false
             });
             $('#datepicker4').datetimepicker({
                 useCurrent: false
             });
            
            // 함수 호출 순서가 4,3,2 순서이다.
            // 4가 바뀌어야 3이 바뀌고 3이 바뀌어야 2가 바뀐다.
             $("#startdate").on("dp.change", function (e) {
                 $('#enddate').data("DateTimePicker").minDate(e.date);
             });
            
             $("#enddate").on("dp.change", function (e) {
                 $('#startdate').data("DateTimePicker").maxDate(e.date);
             });
     }); 
</script>

</head>
<body>

    <div class="container">
    
    
        <div class="form-group">
            <div class="col-sm-9">
              <div class='col-sm-5'>
                <div class="form-group">
                시작일
                  <div class='input-group date dateTimePicker' id="startdate">
                    <input type='text' class="form-control" name="startdate" required="required"/>
                      <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                  </div>
                </div>
              </div>
            <div class='col-sm-1'>
            <br>
              <h4 align="center"><b>~</b></h4>
            </div>
              <div class='col-sm-5'>
                <div class="form-group">
                종료일
                  <div class='input-group date dateTimePicker' id="enddate">
                    <input type='text' class="form-control" name="enddate" required="required"/>
                      <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                      </span>
                  </div>
                </div>
              </div>
            </div>
        </div>
    </div>


</body>

</html>
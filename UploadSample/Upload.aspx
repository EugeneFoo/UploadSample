<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="UploadSample.Upload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Sample</title>

    <script src="/jqueryUI/jquery-2.2.3.min.js" type="text/javascript"></script>
    <script src="/jqueryUI/jquery.js" type="text/javascript"></script>
    <script src="/jqueryUI/jquery-ui.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/jqueryUI/jquery-ui.min.css" />
    <script src="/formstone/core.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/formstone/upload.css" />
    <script src="/formstone/upload.js" type="text/javascript"></script>
    <script src="/Scripts/bootstrap.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Content/bootstrap.min.css" />

    
   <script type="text/javascript">

       var allfile_list = [];
       var gridrow_index;
       var part_listindex = 0;

     
       function onFileComplete(e, file, response) {

           console.log("File Complete");
           obj = JSON.parse(response);


           if (obj.type == 'part') { 

               var partlistdiv = '#GridView1_part_file_ls_';
               $(partlistdiv + gridrow_index).append('<li id="part#' + temp_parts_uid + '#' + part_listindex + '">' + '<button type="Button" style="margin-right: 5px" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></button> <span>' + file.name + '</span></li>');

               var obj_part = {

                   part_uid: temp_parts_uid,
                   lsindex: part_listindex, //use part_list index
                   filename: obj.filename,
                   filepath: obj.filepath,
                   filesize: obj.filesize,
                   type: 'part'

               };

               allfile_list.push(obj_part);
               part_listindex += 1; //added 1        
           }

 

       }

       function onStart(e, files) {

         debugger
           var fullstring = $(this).attr('id'); // get row uploadpanel id (contains contentplaceholder + quoteuid, quoteno, partuid, index)

           var values = fullstring.split('|'); //split | to get below
           var partialstring = values[1]; // contains contentplaceholder + quoteuid, quoteno, partuid, index)

       
           var v = partialstring.split('_');
         

           //set all value
           temp_parts_uid = v[0];
           gridrow_index = v[1];


           rownumber = gridrow_index;
           //rownumber = $(this).attr('id').substr(-1); //last digit (for display uploaded files,remove file)

           console.log("Start");
           // All done!

       }

       function onBeforeSend(formData, file) {


               // Cancel request if it's not png format
               if (file.name.indexOf(".png") < 0) {

                   showAlert("Incorrect file format. Only accepted .png", "danger", 3000);

             
                   return false;
               }

               //// Modify and return form data
               //formdata.append("input_name", "input_value");

               return formData;
           }
     
       function showAlert(message, type, closeDelay) {

           if ($("#alerts-container").length == 0) {
               // alerts-container does not exist, add it
               $("body")
                   .append($('<div id="alerts-container" style="position: fixed; width: 50%; left: 25%; bottom: 3px;">'));
           }

           // default to alert-info; other options include success, warning, danger
           type = type || "info";

           // create the alert div
           var alert = $('<div class="alert alert-' + type + ' fade in">')
               .append(
                   $('<button type="button" class="close" data-dismiss="alert">')
                   //.append("&times;")
               )
               .append('<strong>' + message + '</strong>');

           // add the alert div to top of alerts-container, use append() to add to bottom
           $("#alerts-container").prepend(alert);

           // if closeDelay was passed - set a timeout to close the alert
           if (closeDelay)
               window.setTimeout(function () { alert.alert("close") }, closeDelay);
       }



       $(document).ready(function () {
       
           //Initial Formstone JS upload
           $(".partfile").upload({
               action: 'FileUploadHandler.ashx?upload=' + 'part',
               autoUpload: true,
               multiple: true,
               maxSize: 2147483647,
               beforeSend: onBeforeSend,
               label: 'Drag And Drop Or Select Parts File',
           }).on("filecomplete.partfile", onFileComplete)
           .on("start.partfile", onStart);
             //.on("fileprogress.partfile", onFileProgress)



           //For delete
           $("ul").on("click", "button", function (e) {


               e.preventDefault();
               var v = $(this).parent().attr('id');

               var type = v.split('#')[0];
               var uid = v.split('#')[2];
               var listindex = v.split('#')[3];  // parts file index

               //alert(listindex);

               if (type == 'part') {   


                   for (var z = 0; z < allfile_list.length; z++) {
                       if (Number(allfile_list[z].lsindex) == Number(listindex) && allfile_list[z].type == 'part') {

                           allfile_list.splice(z, 1); //remove that part at selected index
                           $(this).parent().remove();

                       }
                   }

               }
           });


           //Initial date picker
           $('#datepicker1').datepicker({
               dateFormat: "yy-mm-dd"
           });
       });


       function postfile() {
             $.ajax({

                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    type: 'POST',
                    url: 'Upload.aspx/PassFile',
                    data: JSON.stringify({
                        'uploadfile': allfile_list
                    }),
                    success: function () {

                        showAlert('All File Has Been Uploaded', "success", 2000);
                     
                      
                    },
                    error: function (response) {

                        showAlert(JSON.stringify(response), "danger", 3000);
                    }
                });
       }

   
        function pageLoad() {

            $('#datepicker1').datepicker({
                dateFormat: "yy-mm-dd"
            });

        }

      

   </script>


    <style type="text/css">

        li {
            margin: 0 0 10px 0;
        }

        .container {
            margin-right: auto;
            margin-left: auto;
        }

        .ulclass {
            margin: 0; padding: 0; list-style-type: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
        <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-striped" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="False" DataKeyNames="rowid">
            <Columns>
                <asp:BoundField DataField="rowid" HeaderText="rowid" InsertVisible="False" ReadOnly="True" SortExpression="rowid" />
                <asp:BoundField DataField="partuid" HeaderText="partuid" SortExpression="partuid" />
                <asp:BoundField DataField="partzone" HeaderText="partzone" />
            </Columns>
        </asp:GridView>

        <div class="col-md-2">
        <input type="text" class="form-control" id="datepicker1" />
            </div>
        <div class="col-md-10">
        <button type="button" class="btn btn-primary col-md-2 pull-right" onclick="postfile()">Save File</button>
   </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="UploadSample.Upload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Sample</title>

    <script src="/jqueryUI/jquery-2.2.3.min.js" type="text/javascript"></script>
    <script src="/jqueryUI/jquery.js" type="text/javascript"></script>
    <script src="/jqueryUI/jquery-ui.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/jqueryUI/jquery-ui.min.css">
    <script src="/formstone/core.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/formstone/upload.css">
    <script src="/formstone/upload.js" type="text/javascript"></script>
   
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound"></asp:GridView>


    </div>
    </form>
</body>
</html>

##如何使用Formstone JS 上傳圖片 & Jquery UI DatePicker

Formstone JS網址: https://formstone.it/

簡介: Formstone JS 是一款前端開發的插件，能幫助開發者更快速的處理前端介面上的問題如:  圖片顯示，cookies設置， 自適應顯示大小比例(類似bootstrap)，上傳圖片等等。

Formstone 是以Jquery + Javascript語言編寫，適用於各種開發語言環境。

***
### Formstone JS - Upload Panel

 - 創建 Formstone Upload Panel

在html的 `<head>` 內建立


```sh
     <script src="/jqueryUI/jquery-2.2.3.min.js" type="text/javascript"></script>
    <script src="/jqueryUI/jquery.js" type="text/javascript"></script>
    <script src="/jqueryUI/jquery-ui.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/jqueryUI/jquery-ui.min.css" />
    <script src="/formstone/core.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/formstone/upload.css" />
    <script src="/formstone/upload.js" type="text/javascript"></script>
    <script src="/Scripts/bootstrap.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/Content/bootstrap.min.css" />
```

在 `$(document).ready` 時創建upload panel

``` sh
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
```


   

在 `.upload({` 後可以 define你想要使用的options

之後還能再define 這插件的event, 

eg: `.on("filecomplete.partfile", onFileComplete)`
為當文件傳輸完畢時，呼叫`onFileComplete`  function.


----------

##Gridview Row 綁定 Upload Panel

這Sample為使用Aspx Gridview 創建時把 FS-Upload插件綁定在每個row裡，在 `GridView1_RowDataBound` 加入創建html的code.


```sh
protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)

```




創建 `div`, 在裡面加入 `partfile` css class
```sh
                HtmlGenericControl part_div = new HtmlGenericControl("div");
                part_div.ID = "|" + index + '#' + guid; //added
                part_div.Attributes["class"] = "partfile col-xs-12";

```


以下兩段主要說明為在Upload Panel下創建一個 `div` ,然後在 `div` 內創建一個 `ul` list,  這就是當上傳完畢後，把文件名字和刪除button顯示在這裡。
```sh
                HtmlGenericControl part_filediv = new HtmlGenericControl("div"); //after upload file list div
                part_filediv.ID = "part_filediv";
                part_filediv.Attributes["style"] = "margin-top: 10px";

```
```sh

                HtmlGenericControl part_ul = new HtmlGenericControl("ul"); // uploaded file list div
                part_ul.ID = "part_file_ls";
                part_ul.Attributes["class"] = "ulclass";

```

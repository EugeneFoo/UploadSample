##如何使用Formstone JS 上傳圖片 & Jquery UI DatePicker

Formstone JS網址: https://formstone.it/

簡介: Formstone JS 是一款前端開發的插件，能幫助開發者更快速的處理前端介面上的問題如:  圖片顯示，cookies設置， 自適應顯示大小比例(類似bootstrap)，上傳圖片等等。

Formstone 是以Jquery + Javascript語言編寫，適用於各種開發語言環境。

***
## Formstone Upload Panel 建立

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






```sh
                HtmlGenericControl part_div = new HtmlGenericControl("div");
                part_div.ID = "|" + index + '#' + guid; //added
                part_div.Attributes["class"] = "partfile col-xs-12";

```

創建 `div`, 在裡面加入 `partfile` css class
*創建div時請務必把  `int index = e.Row.RowIndex;` 的index綁進創建div, 這樣就能區分上傳完畢後的文件屬於哪一個row.


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
以上兩段主要說明為在Upload Panel下創建一個 `div` ,然後在 `div` 內創建一個 `ul` list,  這就是當上傳完畢後，把文件名字和刪除button顯示在這裡。

----------
##Formstone Upload 上傳

    function onStart(e, files)

當開始上傳時，我們能夠先取得此Upload Panel的ID, 然後從它的ID拆出row index來指定是哪一個row上傳的，當上傳完畢後把文件綁定在指定row的`ul` list裡。

    function onBeforeSend(formData, file)
在傳輸文件前，可在此function檢查文件類別。

    function onFileComplete(e, file, response)
文件傳輸完畢時，把文件和刪除button綁定在指定的gridrow裡面, 然後再把文件訊息儲存在一個 javascript array.


----------

#JQuery DatePicker

使用Jquery DatePicker時，需載入Jquery + Jquery UI 的插件。
```sh
<script src="/jqueryUI/jquery-2.2.3.min.js" type="text/javascript"></script>

<script src="/jqueryUI/jquery.js" type="text/javascript"></script>

<script src="/jqueryUI/jquery-ui.min.js" type="text/javascript"></script>

<link rel="stylesheet" href="/jqueryUI/jquery-ui.min.css" />
```


在`$(document).ready` 時define

     $('#datepicker1').datepicker({
               dateFormat: "yy-mm-dd"
           });


如果你的page有postback, 請記得把這initialize code加在 `pageLoad()`，不然postback後插件會無法顯示:

     function pageLoad()

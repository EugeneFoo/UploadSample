<%@ WebHandler Language="C#" Class="FileUploadHandler" %>

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using Newtonsoft.Json;
using System.Linq;

public class FileUploadHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        try
        {
            if (context.Request.QueryString["upload"] != null)
            {
                string uploadtype = context.Request.QueryString["upload"];
                string partvirtual = "~/upload/"; 
              
                string pathrefer = context.Request.UrlReferrer.ToString();
                string Serverpath = "";
                string finaljsonpath = "";


                if(uploadtype == "part") //Part File
                {
                    Serverpath = HttpContext.Current.Server.MapPath(partvirtual);
                    finaljsonpath = partvirtual;
                }


                var postedFile = context.Request.Files[0];
                var postedFileSize = postedFile.ContentLength;

                string file;

                //In case of IE
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                {
                    string[] files = postedFile.FileName.Split(new char[] {
                '\\'
            });
                    file = files[files.Length - 1];
                }
                else // In case of other browsers
                {
                    file = postedFile.FileName;
                }


                if (!Directory.Exists(Serverpath))
                    Directory.CreateDirectory(Serverpath);

                string fileDirectory = Serverpath;
                if (context.Request.QueryString["fileName"] != null)
                {
                    file = context.Request.QueryString["fileName"];
                    if (File.Exists(fileDirectory + "\\" + file))
                    {
                        File.Delete(fileDirectory + "\\" + file);
                    }
                }

                string ext = Path.GetExtension(fileDirectory + "\\" + file);
                file = Guid.NewGuid() + ext; // Creating a unique name for the file 

                fileDirectory = Serverpath + "\\" + file;

                postedFile.SaveAs(fileDirectory);

                context.Response.AddHeader("Vary", "Accept");
                try
                {
                    if (context.Request["HTTP_ACCEPT"].Contains("application/json"))
                        context.Response.ContentType = "application/json";
                    else
                        context.Response.ContentType = "text/plain";
                }
                catch
                {
                    context.Response.ContentType = "text/plain";
                }


                //context.Response.Write("Success");
                context.Response.Write(

          JsonConvert.SerializeObject(
              new
              {
                  filename = postedFile.FileName,
                  filepath = finaljsonpath + file,
                  filesize = postedFileSize,
                  type = context.Request.QueryString["upload"],
                  mappath = ConfigurationManager.AppSettings["CommentImagePath"] + file,
              }
          )
          );

            }
        }
        catch (Exception exp)
        {
            context.Response.Write(exp.Message);
        }


    }

    public bool IsReusable {
        get {
            return false;
        }
    }



}
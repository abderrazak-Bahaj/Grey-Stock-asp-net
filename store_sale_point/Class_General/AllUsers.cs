using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

public class AllUsers
{

    static public string usersSession()
    {

        //return "1";
        string userid = HttpContext.Current.Session["user_id"].ToString();
        return userid;
    }
    static public string branchSession()
    {
        //return "5";

        string branch_id = HttpContext.Current.Session["branch_id"].ToString();
        return branch_id;
    }

    static public string userNames()
    {
        //return "5";

        string user_name = HttpContext.Current.Session["user_name"].ToString();
        return user_name;
    }
}
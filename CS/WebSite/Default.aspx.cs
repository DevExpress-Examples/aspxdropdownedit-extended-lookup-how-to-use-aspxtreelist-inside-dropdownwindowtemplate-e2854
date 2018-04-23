using System;
using System.Web.UI;
using System.Collections;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxTreeList;

public partial class _Default : System.Web.UI.Page {
    protected void TreeList_DataBound(object sender, EventArgs e) {
        if (!IsCallback && !IsPostBack) {
            ASPxTreeList tree = sender as ASPxTreeList;
            tree.ExpandAll();
        }
    }
    protected void TreeList_CustomJSProperties(object sender, DevExpress.Web.ASPxTreeList.TreeListCustomJSPropertiesEventArgs e) {
        ASPxTreeList tree = sender as ASPxTreeList;
        Hashtable employeeNames = new Hashtable();
        foreach (TreeListNode node in tree.GetVisibleNodes())
            employeeNames.Add(node.Key, node["FirstName"] + " " + node["LastName"]);
        e.Properties["cpEmployeeNames"] = employeeNames;
    }
}
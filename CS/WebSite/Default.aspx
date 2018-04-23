<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v10.2, Version=10.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v10.2, Version=10.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
            function ButtonClickHandler(s, e) {
                if (e.buttonIndex == 0) {
                    DropDownEdit.SetKeyValue(null);
                    SynchronizeFocusedNode();
                }
            }
            function DropDownHandler(s, e) {
                SynchronizeFocusedNode();
            }
            function TreeListInitHandler(s, e) {
                SynchronizeFocusedNode();
            }
            function TreeListEndCallbackHandler(s, e) {
                DropDownEdit.SetKeyValue(TreeList.GetFocusedNodeKey())
                DropDownEdit.AdjustDropDownWindow();
                UpdateEditBox();
            }
            function TreeListNodeClickHandler(s, e) {
                DropDownEdit.SetKeyValue(e.nodeKey);
                DropDownEdit.SetText(TreeList.cpEmployeeNames[e.nodeKey]);
                DropDownEdit.HideDropDown();
            }
            function SynchronizeFocusedNode() {
                var keyValue = DropDownEdit.GetKeyValue();
                TreeList.SetFocusedNodeKey(keyValue);
                UpdateEditBox();
            }
            function UpdateEditBox() {
                var focusedEmployeeName = '';
                var nodeKey = TreeList.GetFocusedNodeKey();
                if (nodeKey != 'null' && nodeKey != '')
                    focusedEmployeeName = TreeList.cpEmployeeNames[nodeKey];
                var employeeNameInEditBox = DropDownEdit.GetText();
                if(employeeNameInEditBox != focusedEmployeeName)
                    DropDownEdit.SetText(focusedEmployeeName);
            }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxDropDownEdit ID="DropDownEdit" runat="server" ClientInstanceName="DropDownEdit"
            Width="170px" AllowUserInput="False" EnableAnimation="False">
            <DropDownWindowStyle>
                <Border BorderWidth="0px" />
            </DropDownWindowStyle>
            <DropDownWindowTemplate>
                <dx:ASPxTreeList ID="TreeList" runat="server" AutoGenerateColumns="False" ClientInstanceName="TreeList"
                    OnCustomJSProperties="TreeList_CustomJSProperties" OnDataBound="TreeList_DataBound"
                    DataSourceID="dataSource" KeyFieldName="EmployeeID" ParentFieldName="ReportsTo">
                    <Border BorderStyle="Solid" />
                    <SettingsBehavior AllowFocusedNode="true" />
                    <SettingsEditing ConfirmDelete="true" />
                    <SettingsPager Mode="ShowAllNodes">
                    </SettingsPager>
                    <Columns>
                        <dx:TreeListTextColumn FieldName="FirstName" VisibleIndex="0">
                        </dx:TreeListTextColumn>
                        <dx:TreeListTextColumn FieldName="LastName" VisibleIndex="1">
                        </dx:TreeListTextColumn>
                        <dx:TreeListDateTimeColumn FieldName="HireDate" VisibleIndex="2">
                        </dx:TreeListDateTimeColumn>
                        <dx:TreeListTextColumn FieldName="ReportsTo" VisibleIndex="3" Visible="false">
                        </dx:TreeListTextColumn>
                    </Columns>
                    <ClientSideEvents Init="TreeListInitHandler" EndCallback="TreeListEndCallbackHandler"
                        NodeClick="TreeListNodeClickHandler" />
                </dx:ASPxTreeList>
            </DropDownWindowTemplate>
            <Buttons>
                <dx:EditButton Text="X"></dx:EditButton>
            </Buttons>
            <ClientSideEvents DropDown="DropDownHandler" ButtonClick="ButtonClickHandler" />
        </dx:ASPxDropDownEdit>
        <asp:AccessDataSource ID="dataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [EmployeeID], [LastName], [FirstName], [HireDate], [ReportsTo] FROM [Employees]">
        </asp:AccessDataSource>
    </form>
</body>
</html>
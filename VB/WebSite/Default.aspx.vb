Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports System.Collections
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxTreeList

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub TreeList_DataBound(ByVal sender As Object, ByVal e As EventArgs)
		If (Not IsCallback) AndAlso (Not IsPostBack) Then
			Dim tree As ASPxTreeList = TryCast(sender, ASPxTreeList)
			tree.ExpandAll()
		End If
	End Sub
	Protected Sub TreeList_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxTreeList.TreeListCustomJSPropertiesEventArgs)
		Dim tree As ASPxTreeList = TryCast(sender, ASPxTreeList)
		Dim employeeNames As New Hashtable()
		For Each node As TreeListNode In tree.GetVisibleNodes()
			employeeNames.Add(node.Key, node("FirstName") & " " & node("LastName"))
		Next node
		e.Properties("cpEmployeeNames") = employeeNames
	End Sub
End Class
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test3.aspx.cs" Inherits="test3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
    function myFunction() {
        var x = document.getElementById("<%=txttinnhan.ClientID%>");
        var y = document.getElementById("<%=lblCount.ClientID%>");
        y.innerHTML = x.value.length;
    }
</script>
</head>
<body>
<form id="form1" runat="server">
    <div>
        <asp:TextBox ID="txttinnhan" runat="server" onkeyup="myFunction()"></asp:TextBox><asp:Label ID="lblCount" runat="server"></asp:Label>
    </div>
</form>
</body>
</html>

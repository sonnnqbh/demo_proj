<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="NhanTin.aspx.cs" Inherits="Administrator_NhanTin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/treeview/style.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
      <li><a href="#">Home</a></li>
      <li class="active">Dashboard</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Dashboard</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
            KHÁCH HÀNG NHẮN TIN
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-5">
                    <div id="ajaxtree"></div>
                </div>
                <div class="col-sm-7">
                    <div id="frmNhantin">
                        <div style="margin-bottom: 10px;">
                            <asp:TextBox ID="txttinnhan" runat="server" TextMode="MultiLine" Height="150px" CssClass="form-control" placeholder="Nhập tin nhắn ..." onkeyup="CheckLength()"></asp:TextBox>
                            <asp:Label ID="label1" runat="server">Đếm ký tự: </asp:Label><asp:Label ID="lblCount" runat="server" ForeColor="red">0</asp:Label><asp:Label ID="lb3" runat="server" ForeColor="red">/450</asp:Label>
                        </div>
                        <div class="form-inline" style="margin-bottom: 10px;">
                            <label for="txtNgayBD" class="control-label">Ngày bắt đầu:</label>
                            <asp:TextBox ID="txtNgayBD" runat="server" CssClass="form-control"></asp:TextBox>
                            <label for="txtNgayKT" class="control-label">Ngày kết thúc:</label>
                            <asp:TextBox ID="txtNgayKT" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-inline" style="margin-bottom: 10px;">
                            <asp:ScriptManager ID="scr1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
                            <button id="btnGuiTin" class="btn btn-primary" onclick="GuiTinNhanSMS()"><i class="fa fa-send-o"></i>&nbsp;Gửi tin nhắn</button>
                            <button id="btnXuatNT" runat="server" class="btn btn-primary" onclick="XuatNTQC()" visible="false"><i class="fa fa-file-excel-o"></i>&nbsp;Xuất nhắn tin QC</button>
                            <asp:HiddenField ID="hfSelected" runat="server" />
                            <asp:Button ID="btnXuatBCNT" runat="server" CssClass="btn btn-success" OnClick="btnXuatBCNT_Click" Text="Xuất BC nhắn tin" />
                        </div>
                    </div>
                    <div class="table-primary" style="OVERFLOW: scroll; HEIGHT:450px; width:100%">
                        <asp:GridView ID="gvGroups" CssClass="table table-striped table-bordered"
                            runat="server" AutoGenerateColumns="False"
                            DataKeyNames="ID" >
                            <Columns>
                                <asp:BoundField DataField="Ten" HeaderText="Họ và tên" Visible="False" >
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField="NguoiCapNhat" HeaderText="Người nhắn" >
                                    <ItemStyle Width="60px" />
                                </asp:BoundField>                                
                                <asp:BoundField DataField="DienThoai" HeaderText="Điện thoại" >
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                                    <asp:BoundField DataField="Noidung" HeaderText="Nội dung" >
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NgayCapNhat" HeaderText="Ngày tạo" 
                                    DataFormatString="{0:dd/MM/yyyy HH:mm}" >
                                    <ItemStyle Width="80px" />
                                </asp:BoundField>
                                
                                    <asp:BoundField DataField="TrangThai" HeaderText="Trạng thái" >
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                        
                        
                            </Columns>
                            <EmptyDataTemplate>Không có dữ liệu</EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/jstree.min.js"></script>
    <script src="assets/js/bootstrapvalidator.min.js"></script>
    <script type="text/javascript">
        function CheckLength()
        {
            var x = document.getElementById("<%=txttinnhan.ClientID%>");
            var y = document.getElementById("<%=lblCount.ClientID%>");
            y.innerHTML = x.value.length;
            if(x.value.length > 450) y.innerHTML = 450;
        }
        $(document).ready(function () {
           $('#frmNhantin').bootstrapValidator({
                    submitButtons: 'btnGuiTin',
                    message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    <%=txttinnhan.UniqueID%>: {
                        validators: {
                            stringLength: {
                                max: 450,
                                message: 'TIN NHẮN PHẢI NHỎ HƠN 450 KÝ TỰ!'
                            }
                        }
                    }
                }
            });
            $('#btnGuiTin').click(function(){
                var validatorObj = $('#frmNhantin').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
            $('#ajaxtree').jstree({
                'plugins': ["checkbox", "search"],
                "search": {
                    "fuzzy": true,
		            "show_only_matches": true
                },
                "checkbox": { "three_state" : true },
		        'core': {
		            'data': {
		                "themes": {
		                    "responsive": true
		                },
		                "url": "TreeViewCustomer.ashx?isAdmin=<%=isAdmin%>&idDoanhNghiep=<%=idDoanhNghiep%>&roleid=<%=idrole%>&nguoidungid=<%=idnguoidung%>",
		                "dataType": "json"
		            }
		        }
            });
            var to = null;
            $('#search').keyup(function () {
                if (to) { clearTimeout(to); }
                to = setTimeout(function () {
                    var v = $('#search').val();
                    $('#ajax').jstree(true).search(v);
                }, 250);
            });
		
            $('#<%=txtNgayBD.ClientID%>').datepicker({
                format: 'dd/mm/yyyy',
                clearBtn: true
            });
            $('#<%=txtNgayKT.ClientID%>').datepicker({
                format: 'dd/mm/yyyy',
                clearBtn: true,
                todayHighlight: true
            });
            $('#<%=txtNgayBD.ClientID%>').mask('99/99/9999');
	        $('#<%=txtNgayKT.ClientID%>').mask('99/99/9999');
	    });
        
        function XuatNTQC()
        {
            var result = $('#ajaxtree').jstree('get_selected');
            document.getElementById("<%=hfSelected.ClientID%>").value = result;
            PageMethods.XuatNhanTinQC(document.getElementById("<%=hfSelected.ClientID%>").value, OnSuccess);
        }


        function GuiTinNhan()
        {
            setTimeout(GuiTinNhanSMS(), 2000);
        }

        function GuiTinNhanSMS()
        {
            var result = $('#ajaxtree').jstree('get_selected');
            document.getElementById("<%=hfSelected.ClientID%>").value = result;
            PageMethods.SendMessage(document.getElementById("<%=hfSelected.ClientID%>").value, document.getElementById("<%=txttinnhan.ClientID%>").value, OnSuccess);
        }

        function OnSuccess(response, userContext, methodName) {
            alert(response);
        }
	</script>
</asp:Content>


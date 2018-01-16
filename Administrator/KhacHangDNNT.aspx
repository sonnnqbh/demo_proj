<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="KhacHangDNNT.aspx.cs" Inherits="Administrator_KhacHangDNNT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/jasny/jasny-bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="#">Administrator</a></li>
        <li class="active">Khách hàng DNNT</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>KHDN NHẮN TIN</h1>
        </div>
        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading">
            <button type="button" id="btnExportToExxcel" class="btn btn-primary" runat="server" onserverclick="btnExportToExxcel_ServerClick"><i class="fa fa-save"></i>&nbsp;Nhắn tin </button>
            <button type="button" id="btnExportToExxcel0" class="btn btn-primary" runat="server" onserverclick="btnExportToExxcel0_ServerClick"><i class="fa fa-save"></i>&nbsp;File mẫu nhắn tin </button>
            <div class="fileinput fileinput-new" data-provides="fileinput">
                <div class="input-append">
                    <span class="btn btn-outline btn-primary btn-file"><span class="fileinput-new"><i class="fa fa-cloud-upload"></i>&nbsp;Chọn tệp</span>
                    <span class="fileinput-exists">Thay đổi</span><asp:FileUpload ID="FileUpload1" runat="server" /></span>
                    <span class="fileinput-filename"></span>
                    <a href="#" class="close fileinput-exists" data-dismiss="fileinput" style="float: none">×</a>
                </div>
            </div>
        </div>
        <div class="panel-body">
            <div class="table-primary" style="OVERFLOW: scroll; HEIGHT:450px; width:100%">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="GvgroupUser" CssClass="table table-striped table-bordered"
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/plugins/jasny/jasny-bootstrap.min.js"></script>
</asp:Content>


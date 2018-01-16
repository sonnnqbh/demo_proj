<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="NhomXe.aspx.cs" Inherits="Administrator_NhomXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <style>
        .dataTable > thead > tr > th[class*="sort"]::before{display: none}
        .dataTable > thead > tr > th[class*="sort"]::after{display: none}
    </style>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
      <li><a href="#">Adminstrator</a></li>
      <li class="active">Nhóm khách hàng</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Nhóm khách hàng</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
    <div class="panel">
      <div class="panel-heading">
        <div class="panel-title">THÔNG TIN NHÓM KHÁCH HÀNG</div>
      </div>
      <div class="panel-body form-horizontal" id="UFormValidator">
          <div class="form-group">
            <label for="txttendonvi" class="col-md-3 control-label">Chọn doanh nghiệp:</label>
            <div class="col-md-9">
              <asp:DropDownList ID="DrpDoanhNghiep" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
          </div>
          <div class="form-group" style="display:none;">
            <label for="txtdienthoai" class="col-md-3 control-label">Chọn cấu hình nhắn tin cho nhóm:</label>
            <div class="col-md-9">
              <asp:DropDownList ID="DrpCauHinh" runat="server" CssClass="form-control">
                  </asp:DropDownList>
            </div>
          </div>
          <div class="form-group">
            <label for="txttennhom" class="col-md-3 control-label">Tên nhóm:</label>
            <div class="col-md-9">
              <asp:TextBox ID="txttennhom" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtghichu" class="col-md-3 control-label">Ghi chú thông tin:</label>
            <div class="col-md-9">
              <asp:TextBox ID="txtghichu" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-3 control-label"></label>
            <div class="col-md-9">
              <label class="custom-control custom-checkbox" style="display:none;">
                <input type="checkbox" id="chkNhanTinDK" class="custom-control-input" runat="server" />
                <span class="custom-control-indicator"></span>
                Nhắn tin định kỳ
              </label>
              <label class="custom-control custom-checkbox">
                <input type="checkbox" id="CheckBox1" class="custom-control-input" runat="server" checked="checked" />
                <span class="custom-control-indicator"></span>
                Hoạt động
              </label>
            </div>
          </div>
          <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
              <asp:HiddenField ID="hfPopupUpdate" runat="server" />
              <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Lưu" OnClick="btnSave_Click" />
              <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" Text="Hủy bỏ" OnClick="btnCancel_Click" />
            </div>
          </div>
      </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
            <b>DANH SÁCH NHÓM KHÁCH HÀNG</b>
        </div>
        <div class="panel-body form-horizontal">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="GvgroupUser" CssClass="table table-striped table-bordered"
                    runat="server" AutoGenerateColumns="False" OnRowCommand="GvgroupUser_RowCommand"
                    DataKeyNames="ID" >
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="Mã Nhóm KH">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="tennhom" HeaderText="Tên nhóm">
                        <ItemStyle Width="250px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="IDDoanhNghiep" HeaderText="Doanh Nghiệp ID">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="IDCauHinh" HeaderText="Cấu Hình ID" Visible="false">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Ghichu" HeaderText="Ghi chú">
                        <ItemStyle Width="250px" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="Nhantindk" HeaderText="Nhắn tin định kỳ" Visible="false" />
                    <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnEdit" runat="server" CommandName="editRecord" CommandArgument='<%# Eval("ID") %>' ToolTip="Sửa" CssClass="fa fa-lg fa-edit"></asp:LinkButton>
                            <asp:LinkButton ID="lbtnDelete" runat="server" CommandName="deleteRecord" CommandArgument='<%# Eval("ID") %>' ToolTip="Xóa" CssClass="fa fa-lg fa-trash"></asp:LinkButton>
                            <asp:LinkButton ID="lbtnDetail" runat="server" CommandName="detailRecord" CommandArgument='<%# Eval("ID") %>' ToolTip="Chi tiết khách hàng" CssClass="fa fa-lg fa-tasks"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                    <EmptyDataTemplate>Không có dữ liệu</EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
    <%-- Popup xác nhận --%>
    <asp:HiddenField ID="hfPopupDelete" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeDelete" runat="server" PopupControlID="pnlDelete" TargetControlID="hfPopupDelete"
        CancelControlID="btnXoaHuy" BackgroundCssClass="modalBackground">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlDelete" runat="server" CssClass="modal-dialog" Style="display: none">
			<div class="modal-content">
                <div class="modal-header">
					<h4>Xác nhận</h4>               
                </div>
                <div class="modal-body" id="formValidator">

                    <div style="padding-left: 20px; padding-right: 20px">

                        <div class="form-group">
                            <asp:Label ID="lbxacnhanxoa" runat="server" />           
                        </div>
                                                    
                        <div class="form-group">
                            <asp:Button ID="btnXoadongy" CssClass="btn btn-sm btn-primary" runat="server" Text="Đồng ý" OnClick="btnXoadongy_Click" />
                            <asp:Button ID="btnXoaHuy" runat="server" CssClass="btn btn-sm btn-danger" Text="Đóng" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                 
    </asp:Panel>
    <%-- Popup Detail --%>
    <asp:HiddenField ID="hfPopUpDetail" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeDetail" runat="server" PopupControlID="pnlDetail" TargetControlID="hfPopUpDetail"
        CancelControlID="btnXoaHuyD" BackgroundCssClass="modalBackground">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlDetail" runat="server" CssClass="modal-dialog" Style="display: none">
			<div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <b>KHÁCH HÀNG THUỘC NHÓM</b>
                </div>
                <asp:UpdatePanel ID="upEdit" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <asp:GridView ID="GvKhachHang" CssClass="table table-striped table-bordered table-hover"
                                     runat="server" AutoGenerateColumns="False"
                                     DataKeyNames="ID">
                                <Columns>
                                    <asp:TemplateField HeaderText="STT">
                                          <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Tenkhachhang" HeaderText="Họ và tên" >
                                        <ItemStyle Width="300px" />
                        
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Dienthoai" HeaderText="Điện thoại" >
                                        <ItemStyle Width="100px" />
                        
                                    </asp:BoundField>

                                    <asp:BoundField DataField="ngaysinh" HeaderText="Ngày sinh" >
                                    <ItemStyle Width="110px" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="ngaymuaxe" HeaderText="Ngày mua xe" Visible="false" >
                                    <ItemStyle Width="110px" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="nhanxe" HeaderText="Nhãn xe" Visible="false" >
                                    <ItemStyle Width="200px" />
                                        </asp:BoundField>
                                    <asp:BoundField DataField="ghichu" HeaderText="Mô tả" >
                                        <ItemStyle Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="KhungXe" HeaderText="Khung Xe" Visible="false" >
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                </Columns><EmptyDataTemplate>Không có khách hàng</EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnXoaHuyD" runat="server" CssClass="btn btn-sm btn-danger" Text="Đóng" CausesValidation="false" />
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <%--<asp:AsyncPostBackTrigger ControlID="GvUser" EventName="RowCommand" />
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            </div>                 
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/bootstrapvalidator.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#UFormValidator').bootstrapValidator({
                    submitButtons: '<%=btnSave.ClientID%>',
                    message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    <%=DrpDoanhNghiep.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa chọn doanh nghiệp!'
                            }
                        }
                    },
                    <%--<%=DrpCauHinh.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa chọn cấu hình!'
                            }
                        }
                    },--%>
                    <%=txttennhom.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập tên nhóm!'
                            }
                        }
                    }
                }
            });
            $('#<%=btnSave.ClientID%>').click(function(){
                var validatorObj = $('#UFormValidator').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
        });
        loadTable();
        function loadTable() {
            $('#MainContent_GvgroupUser').prepend($("<thead></thead>").append($('#MainContent_GvgroupUser').find("tr:first"))).dataTable({
                pageLength: 10,
                "language": {
                    "sProcessing":   "Đang xử lý...",
                    "sLengthMenu":   "_MENU_ dòng/trang",
                    "sZeroRecords":  "Không tìm thấy dòng nào phù hợp",
                    "sInfo":         "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ mục",
                    "sInfoEmpty":    "Đang xem 0 đến 0 trong tổng số 0 mục",
                    "sInfoFiltered": "(được lọc từ _MAX_ mục)",
                    "sInfoPostFix":  "",
                    "sSearch":       "Search:",
                    "sUrl":          "",
                    "oPaginate": {
                        "sFirst":    "Đầu",
                        "sPrevious": "Trước",
                        "sNext":     "Tiếp",
                        "sLast":     "Cuối"
                    }
                }
            });
            $('#MainContent_GvgroupUser_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
        loadTableKH();
        function loadTableKH() {
            $('#MainContent_GvKhachHang').prepend($("<thead></thead>").append($('#MainContent_GvKhachHang').find("tr:first"))).dataTable({
                pageLength: 10,
                "language": {
                    "sProcessing":   "Đang xử lý...",
                    "sLengthMenu":   "_MENU_ dòng/trang",
                    "sZeroRecords":  "Không tìm thấy dòng nào phù hợp",
                    "sInfo":         "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ mục",
                    "sInfoEmpty":    "Đang xem 0 đến 0 trong tổng số 0 mục",
                    "sInfoFiltered": "(được lọc từ _MAX_ mục)",
                    "sInfoPostFix":  "",
                    "sSearch":       "Search:",
                    "sUrl":          "",
                    "oPaginate": {
                        "sFirst":    "Đầu",
                        "sPrevious": "Trước",
                        "sNext":     "Tiếp",
                        "sLast":     "Cuối"
                    }
                }
            });
            $('#MainContent_GvKhachHang_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>


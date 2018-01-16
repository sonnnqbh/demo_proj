<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="UserGroup.aspx.cs" Inherits="Administrator_UserGroup" %>

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
      <li class="active">Nhóm người dùng</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Nhóm người dùng</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
    <div class="panel">
      <div class="panel-heading">
        <div class="panel-title">THÔNG TIN NHÓM NGƯỜI DÙNG</div>
      </div>
      <div class="panel-body form-horizontal" id="UFormValidator">
          <div class="form-group">
            <label for="txtTenQuyen" class="col-md-3 control-label">Tên nhóm:</label>
            <div class="col-md-9">
              <asp:TextBox ID="txtTenQuyen" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtGhiChu" class="col-md-3 control-label">Ghi chú thông tin:</label>
            <div class="col-md-9">
              <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label class="col-md-3 control-label"></label>
            <div class="col-md-9">
              <label class="custom-control custom-checkbox">
                <input type="checkbox" id="cbxNhomQL" class="custom-control-input" runat="server" />
                <span class="custom-control-indicator"></span>
                Nhóm quản lý
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
            DANH SÁCH NHÓM NGƯỜI DÙNG
        </div>
        <div class="panel-body form-horizontal">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="GvgroupUser" CssClass="table table-striped table-bordered"
                    runat="server" AutoGenerateColumns="False" OnRowCommand="GvgroupUser_RowCommand"
                    DataKeyNames="NhomID" >
                <Columns>
                    <asp:BoundField DataField="Nhomid" HeaderText="Nhomid" Visible="False" >
                    <ItemStyle Width="20px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TenNhom" HeaderText="Tên nhóm" >
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Mota" HeaderText="Mô tả" />
                    <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-primary"
                                            ButtonType="Button" Text="Sửa" HeaderText="">
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-danger"
                                            ButtonType="Button" Text="Xóa" HeaderText="">
                    </asp:ButtonField>
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
                    <%=txtTenQuyen.UniqueID%>: {
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
            $('#MainContent_GvgroupUser_wrapper .table-caption').text('Danh sách nhóm người dùng');
            $('#MainContent_GvgroupUser_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>


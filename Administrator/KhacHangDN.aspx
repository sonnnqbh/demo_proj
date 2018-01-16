<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="KhacHangDN.aspx.cs" Inherits="Administrator_KhacHangDN" MaintainScrollPositionOnPostback="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/jasny/jasny-bootstrap.min.css" rel="stylesheet" />
    <style>
        .dataTable > thead > tr > th[class*="sort"]::before{display: none}
        .dataTable > thead > tr > th[class*="sort"]::after{display: none}
        /*gridview*/
        .table table  tbody  tr  td a ,
        .table table  tbody  tr  td  span {
        position: relative;
        float: left;
        padding: 6px 12px;
        margin-left: -1px;
        line-height: 1.42857143;
        color: #337ab7;
        text-decoration: none;
        background-color: #fff;
        border: 1px solid #ddd;
        }

        .table table > tbody > tr > td > span {
        z-index: 3;
        color: #fff;
        cursor: default;
        background-color: #337ab7;
        border-color: #337ab7;
        }

        .table table > tbody > tr > td:first-child > a,
        .table table > tbody > tr > td:first-child > span {
        margin-left: 0;
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
        }

        .table table > tbody > tr > td:last-child > a,
        .table table > tbody > tr > td:last-child > span {
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
        }

        .table table > tbody > tr > td > a:hover,
        .table   table > tbody > tr > td > span:hover,
        .table table > tbody > tr > td > a:focus,
        .table table > tbody > tr > td > span:focus {
        z-index: 2;
        color: #23527c;
        background-color: #eee;
        border-color: #ddd;
        }
        /*end gridview */
    </style>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="#">Administrator</a></li>
        <li class="active">Khách hàng</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>KHÁCH HÀNG</h1>
        </div>
        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading">
            THÔNG TIN KHÁCH HÀNG
        </div>
        <div class="panel-body form-horizontal" id="UFormValidator">
            <div class="form-group">
                <label for="DrpDoanhNghiep" class="col-sm-2 control-label">Doanh nghiệp/tổ chức:</label>
                <div class="col-sm-4">
                    <asp:DropDownList ID="DrpDoanhNghiep" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <label for="txthovaten" class="col-sm-2 control-label">Họ và tên:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txthovaten" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtdienthoai" class="col-sm-2 control-label">Điện thoại nhắn tin:</label>
                <div class="col-sm-2">
                    <asp:TextBox ID="txtdienthoai" runat="server" CssClass="form-control" />
                </div>
                <div class="col-sm-2">
                    <label class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" runat="server" id="Checkbox1" />
                    <span class="custom-control-indicator"></span>
                    Hoạt động
                    </label>
                </div>
                <label for="txtGhiChu" class="col-sm-2 control-label">Ghi chú:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="Drpnhomxe" class="col-sm-2 control-label">Nhóm khách hàng:</label>
                <div class="col-sm-4">
                    <asp:DropDownList ID="Drpnhomxe" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <label for="txtNgay" class="col-sm-2 control-label">Ngày sinh:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtNgay" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group" style="display:none;">
                <label for="txtnhanxe" class="col-sm-2 control-label">Nhãn hiệu xe:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtnhanxe" runat="server" CssClass="form-control" />
                </div>
                <label for="txtNgayMuaXe" class="col-sm-2 control-label">Ngày mua xe:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtNgayMuaXe" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group" style="display:none;">
                <label for="txtkhungxe" class="col-sm-2 control-label">Khung xe:</label>
                <div class="col-sm-10">
                <asp:TextBox ID="txtkhungxe" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="panel-footer">
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-10">
                        <asp:HiddenField ID="hfPopupUpdate" runat="server" />
                        <asp:Button ID="btnUSave" CssClass="btn btn-primary" runat="server" Text="Lưu" OnClick="btnUSave_Click" />
                        <button type="button" id="btnBoQua" class="btn btn-warning" runat="server" onserverclick="btnBoQua_ServerClick"><i class="fa fa-plus"></i>&nbsp;Xóa trắng</button>
                        <%--<button type="button" id="btnXoa" class="btn btn-danger" runat="server" onserverclick="btnXoa_ServerClick"><i class="fa fa-times"></i>&nbsp;Xóa</button>--%>
                        <div class="fileinput fileinput-new" data-provides="fileinput">
                            <div class="input-append">
                                <span class="btn btn-outline btn-primary btn-file"><span class="fileinput-new"><i class="fa fa-cloud-upload"></i>&nbsp;Chọn tệp Import</span>
                                <span class="fileinput-exists">Thay đổi</span><asp:FileUpload ID="FileUpload1" runat="server" /></span>
                                <span class="fileinput-filename"></span>
                                <button type="button" id="btnExportToExxcel" class="btn btn-primary" runat="server" onserverclick="btnExportToExxcel_ServerClick"><i class="fa fa-download"></i>&nbsp;Import Khách hàng </button>
                                <a href="#" class="close fileinput-exists" data-dismiss="fileinput" style="float: none">×</a>
                            </div>
                        </div>
                        <button type="button" id="btnExportToExxcel0" class="btn btn-primary" runat="server" onserverclick="btnExportToExxcel0_ServerClick"><i class="fa fa-save"></i>&nbsp;File mẫu khách hàng </button>
                        <button type="button" id="btnCheckByNS" class="btn btn-success" runat="server" onserverclick="btnCheckByNS_ServerClick" visible="false"><i class="fa fa-search"></i>&nbsp;Kiểm tra ngày sinh</button>
                        <button type="button" id="btnCheckByNM" class="btn btn-success" runat="server" onserverclick="btnCheckByNM_ServerClick" visible="false"><i class="fa fa-search"></i>&nbsp;Kiểm tra ngày mua</button>
                        <button type="button" id="btnCheckByPhone" class="btn btn-success" runat="server" onserverclick="btnCheckByPhone_ServerClick"><i class="fa fa-search"></i>&nbsp;Kiểm tra số ĐT</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading">
            <div class="form-inline">
            <div class="form-group"></div>
            <asp:TextBox ID="txtSearch" Width="300px" runat="server" CssClass="form-control" placeholder="Nhập KH, nhóm KH hoặc số ĐT ..."></asp:TextBox>
            <button id="btnSearch" runat="server" class="btn btn-primary" onserverclick="btnSearch_ServerClick"><i class="fa fa-search"></i>&nbsp;Tìm kiếm</button>
            <button id="btnExportAllKH" runat="server" class="btn btn-primary" onserverclick="btnExportAllKH_ServerClick"><i class="fa fa-file-excel-o"></i>&nbsp;Xuất Excel Khách hàng</button>
            Khách hàng tìm kiếm được: <b><asp:Label ID="lbnhomid0" runat="server"></asp:Label></b>
            </div>
        </div>
        <div class="panel-body form-horizontal">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="GvgroupUser" CssClass="table table-striped table-bordered"
                    runat="server" AutoGenerateColumns="False" OnRowCommand="GvgroupUser_RowCommand"
                    AllowPaging="true" OnPageIndexChanging="GvgroupUser_PageIndexChanging" PageSize="15"
                    DataKeyNames="ID" >
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
                    <asp:BoundField DataField="DoanhnghiepID" HeaderText="Doanh nghiệp ID" 
                        Visible="False" >
                        <ItemStyle Width="10px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NhomKH" HeaderText="Nhóm khách hàng" Visible="true" />
                    <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-minier btn-primary"
                                            ButtonType="Button" Text="Sửa" HeaderText="">
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-minier btn-danger"
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
    <script src="assets/js/plugins/jasny/jasny-bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#UFormValidator').bootstrapValidator({
                    submitButtons: '<%=btnUSave.ClientID%>',
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
                    <%=txthovaten.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập họ tên!'
                            }
                        }
                    },
                    <%=txtdienthoai.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập số điện thoại!'
                            }
                        }
                    },
                    <%=txtnhanxe.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập nhãn xe!'
                            }
                        }
                    },
                    <%=Drpnhomxe.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa chọn nhóm khách hàng!'
                            }
                        }
                    },
                    <%=txtkhungxe.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập khung xe!'
                            }
                        }
                    },
                    <%=txtNgay.UniqueID%>: {
                        validators: {
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'Nhập đúng định dạng ngày DD/MM/YYYY'
                            }
                        }
                    }
                    <%--<%=txtNgayMuaXe.UniqueID%>: {
                        validators: {
                            date: {
                                format: 'DD/MM/YYYY',
                                message: 'Nhập đúng định dạng ngày DD/MM/YYYY'
                            }
                        }
                    }--%>
                }
            });
            $('#<%=btnUSave.ClientID%>').click(function(){
                var validatorObj = $('#UFormValidator').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
        });
        //loadTable();
        function loadTable() {
            $('#MainContent_GvgroupUser').prepend($("<thead></thead>").append($('#MainContent_GvgroupUser').find("tr:first"))).dataTable({
                pageLength: 50,
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
            $('#MainContent_GvgroupUser_wrapper .table-caption').text('Danh sách doanh nghiệp');
            $('#MainContent_GvgroupUser_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
        $('#<%=txtNgay.ClientID%>').datepicker({
            format: 'dd/mm/yyyy',
            calendarWeeks: true,
            todayBtn: 'linked',
            clearBtn: true,
            todayHighlight: true
        });
        $('#<%=txtNgayMuaXe.ClientID%>').datepicker({
            format: 'dd/mm/yyyy',
            calendarWeeks: true,
            todayBtn: 'linked',
            clearBtn: true,
            todayHighlight: true
        });
        $('#<%=txtNgay.ClientID%>').mask('99/99/9999');
        $('#<%=txtNgayMuaXe.ClientID%>').mask('99/99/9999');
    </script>
</asp:Content>


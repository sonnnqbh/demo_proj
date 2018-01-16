<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="CauHinhNT.aspx.cs" Inherits="Administrator_CauHinhNT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="#">Administrator</a></li>
        <li class="active">Cấu hình nhắn tin</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>CẤU HÌNH NHẮN TIN</h1>
        </div>
        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
        </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
            <b>CẤU HÌNH THAM SỐ NHẮN TIN ĐỊNH KỲ CHĂM SÓC KHÁCH HÀNG</b>
        </div>
        <div class="panel-body">
            <div class="panel-body form-horizontal" id="UFormValidator">
              <div class="form-group">
                <label for="txtlan1" class="col-md-2 control-label">Lần 1:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtlan1" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label for="txtlan2" class="col-md-2 control-label">Lần 2:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtlan2" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label for="txtlan3" class="col-md-2 control-label">Lần 3:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtlan3" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label for="txtlan4" class="col-md-2 control-label">Lần 4:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtlan4" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label for="txtlan5" class="col-md-2 control-label">Lần 5:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtlan5" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label for="txtlan6" class="col-md-2 control-label">Lần 6:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtlan6" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label for="txtdiachi" class="col-md-2 control-label">Ghi chú thông tin:</label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtghichu" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                </div>
              </div>
              <div class="form-group" style="display: none;">
                <label for="txtgionhantindk" class="col-md-2 control-label"></label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtgionhantindk" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group" style="display: none;">
                <label for="txtgionhantinsn" class="col-md-2 control-label"></label>
                <div class="col-md-10">
                  <asp:TextBox ID="txtgionhantinsn" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
              </div>
              <div class="form-group">
                <label class="col-md-2 control-label"></label>
                <div class="col-md-10">
                  <label class="custom-control custom-checkbox">
                    <input type="checkbox" id="CheckBox1" class="custom-control-input" runat="server" />
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
    </div>
    <div class="panel">
        <div class="panel-heading">
            <b>DANH SÁCH THAM SỐ</b>
        </div>
        <div class="panel-body">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="GvgroupCH" CssClass="table table-striped table-bordered"
                    runat="server" AutoGenerateColumns="False" OnRowCommand="GvgroupCH_RowCommand"
                    DataKeyNames="ID" >
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Lan1" HeaderText="Lan 1">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Lan2" HeaderText="Lan 2">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="lan3" HeaderText="Lan 3">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="lan4" HeaderText="Lan 4">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Lan5" HeaderText="lan 5">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="lan6" HeaderText="lan 6">
                        <ItemStyle Width="80px" />
                    </asp:BoundField>
                       
                    <asp:BoundField DataField="GhiChu" HeaderText="Ghi chú">
                        <ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-minier btn-primary"
                                            ButtonType="Button" Text="Sửa" HeaderText="">
                    </asp:ButtonField>
                    <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-minier btn-danger"
                                            ButtonType="Button" Text="Xóa" HeaderText="" Visible="false">
                    </asp:ButtonField>
                </Columns>
                    <EmptyDataTemplate>Không có dữ liệu</EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
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
                    <%=txtlan1.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Lỗi chưa nhập lan nhan tin !!!!'
                            },
                            integer: {
                                message: 'Nhập số nguyên!!!'
                            }
                        }
                    },
                    <%=txtlan2.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Lỗi chưa nhập lan nhan tin !!!'
                            },
                            integer: {
                                message: 'Nhập số nguyên!!!'
                            }
                        }
                    },
                    <%=txtlan3.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Lỗi chưa nhập lan nhan tin !!!'
                            },
                            integer: {
                                message: 'Nhập số nguyên!!!'
                            }
                        }
                    },
                    <%=txtlan4.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Lỗi chưa nhập lan nhan tin !!!'
                            },
                            integer: {
                                message: 'Nhập số nguyên!!!'
                            }
                        }
                    },
                    <%=txtlan5.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Lỗi chưa nhập lan nhan tin !!!'
                            },
                            integer: {
                                message: 'Nhập số nguyên!!!'
                            }
                        }
                    },
                    <%=txtlan6.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Lỗi chưa nhập lan nhan tin !!!'
                            },
                            integer: {
                                message: 'Nhập số nguyên!!!'
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
            $('#MainContent_GvgroupCH').prepend($("<thead></thead>").append($('#MainContent_GvgroupCH').find("tr:first"))).dataTable({
                pageLength: 10,
                "language": {
                    "sProcessing":   "Đang xử lý...",
                    "sLengthMenu":   "_MENU_ dòng/trang",
                    "sZeroRecords":  "Không tìm thấy dòng nào phù hợp",
                    "sInfo":         "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ trang",
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
            $('#MainContent_GvgroupCH_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>


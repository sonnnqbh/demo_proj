<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="Thietlap.aspx.cs" Inherits="Administrator_Thietlap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
      <li><a href="#">Adminstrator</a></li>
      <li class="active">Thiết lập</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Thêm thông tin</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
    <div class="panel">
      <div class="panel-heading">
        <div class="panel-title">Thiết lập thông tin đơn vị cung cấp dịch vụ sms brandname</div>
      </div>
      <div class="panel-body form-horizontal" id="UFormValidator">
          <div class="form-group">
            <label for="txttendonvi" class="col-md-2 control-label">Tên đơn vị cung cấp:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txttendonvi" CssClass="form-control" runat="server" placeholder="Đơn vị cung cấp"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtdienthoai" class="col-md-2 control-label">Điện thoại:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txtdienthoai" runat="server" CssClass="form-control" placeholder="Điện thoại"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtusername" class="col-md-2 control-label">Username:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txtusername" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtagentid" class="col-md-2 control-label">AGENTID:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txtagentid" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtapiuser" class="col-md-2 control-label">APIUSER:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txtapiuser" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtapipass" class="col-md-2 control-label">APIPASS:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txtapipass" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtdiachi" class="col-md-2 control-label">Địa chỉ:</label>
            <div class="col-md-10">
              <asp:TextBox ID="txtdiachi" runat="server" CssClass="form-control"></asp:TextBox>
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
              <asp:Label ID="lbnhomid" runat="server" Visible="False"></asp:Label>
              <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Lưu" OnClick="btnSave_Click" />
              <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-danger" Text="Hủy bỏ" OnClick="btnCancel_Click" />
            </div>
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
                    <%=txttendonvi.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập tên đơn vị!'
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
                    <%=txtusername.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập Username đăng nhập hệ thống nhắn tin vinaphone !!!'
                            }
                        }
                    },
                    <%=txtagentid.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập AGENTID!'
                            }
                        }
                    },
                    <%=txtapiuser.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập APIUSER!'
                            }
                        }
                    },
                    <%=txtapipass.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập APIPASS!'
                            }
                        }
                    },
                    <%=txtdiachi.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập địa chỉ!'
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
    </script>
</asp:Content>


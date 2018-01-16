<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="ChangePass.aspx.cs" Inherits="Administrator_ChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
      <li><a href="#">Adminstrator</a></li>
      <li class="active">Thay đổi mật khẩu</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>THAY ĐỔI MẬT KHẨU</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
    <div class="panel">
      <div class="panel-body form-horizontal" id="UFormValidator">
          <div class="form-group">
            <label for="txtOldPass" class="col-md-2 control-label">Mật khẩu cũ:</label>
            <div class="col-md-4">
              <asp:TextBox ID="txtOldPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtNewPass" class="col-md-2 control-label">Mật khẩu mới:</label>
            <div class="col-md-4">
              <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
          </div>
          <div class="form-group">
            <label for="txtConfirm" class="col-md-2 control-label">Xác nhận:</label>
            <div class="col-md-4">
              <asp:TextBox ID="txtConfirm" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
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
                    <%=txtOldPass.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Mật khẩu cũ không được để trống!'
                            }
                        }
                    },
                    <%=txtNewPass.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Mật khẩu mới không được để trống!'
                            }
                        }
                    },
                    <%=txtConfirm.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Confirm pass required!'
                            },
                            identical: {
                                field: '<%=txtNewPass.UniqueID%>',
                                message: 'Xác nhận mật khẩu mới chưa đúng!'
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


<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="UserDetail.aspx.cs" Inherits="Administrator_UserDetail" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="px-content">
    <div class="page-header m-b-0 p-b-0 b-b-0">
      <h1>Account <span class="text-muted font-weight-light">Settings</span></h1>
      <ul class="nav nav-tabs page-block m-t-4" id="account-tabs">
        <li class="active">
          <a href="#account-profile" data-toggle="tab">
            Profile
          </a>
        </li>
        <li>
          <a href="#account-password" data-toggle="tab">
            Password
          </a>
        </li>
      </ul>
    </div>

    <div class="tab-content p-y-4">

      <!-- Profile tab -->

      <div class="tab-pane fade in active" id="account-profile">
        <div class="row">
          <div class="col-md-8 col-lg-9" id="frmUserDetail">
            <div class="p-x-1">
              <fieldset class="form-group form-group-lg">
                <label for="txtUserEmail">UserEmail</label>
                <asp:TextBox runat="server" ID="txtUserEmail" CssClass="form-control" Enabled="false"></asp:TextBox>
              </fieldset>
              <fieldset class="form-group form-group-lg">
                <div class="col-lg-6" style="padding-left:0;">
                    <label for="txtFirstName">First Name</label>
                    <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-lg-6" style="padding-right:0;">
                    <label for="txtLastName">Last Name</label>
                    <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
                </div>
              </fieldset>
              <fieldset class="form-group form-group-lg">
                <label for="txtUserAddress">Address</label>
                <asp:TextBox runat="server" ID="txtUserAddress" CssClass="form-control"></asp:TextBox>
              </fieldset>
              <fieldset class="form-group form-group-lg">
                <div class="col-lg-6" style="padding-left:0;">
                    <label class="custom-control custom-checkbox pull-xs-left">
                    <input type="checkbox" class="custom-control-input" runat="server" id="txtUserActived" />
                    <span class="custom-control-indicator"></span>
                    Actived
                    </label>
                </div>
                <div class="col-lg-6" style="padding-left:0;">
                    <label class="custom-control custom-checkbox pull-xs-left">
                    <input type="checkbox" class="custom-control-input" runat="server" id="txtAdministrator" />
                    <span class="custom-control-indicator"></span>
                    Is Administrator
                    </label>
                </div>
              </fieldset>
              <fieldset class="form-group form-group-lg">
                <label for="txtUserIP">IP</label>
                <asp:TextBox runat="server" ID="txtUserIP" CssClass="form-control"></asp:TextBox>
              </fieldset>
              <fieldset class="form-group form-group-lg">
                <label for="txtUserPhone">Phone</label>
                <asp:TextBox runat="server" ID="txtUserPhone" CssClass="form-control"></asp:TextBox>
              </fieldset>
              <asp:Button ID="btnUpdateProfile" CssClass="btn btn-md btn-primary m-t-3" runat="server" Text="Update profile" OnClick="btnUpdateProfile_Click" />
              
              <a href="#" class="pull-xs-right text-muted p-t-4">Deactivate account</a>
            </div>
          </div>

          <!-- Spacer -->
          <div class="m-t-4 visible-xs visible-sm"></div>

          <!-- Avatar -->
          <div class="col-md-4 col-lg-3">
            <div class="panel bg-transparent">
              <div class="panel-body text-xs-center">
                <img src="assets/demo/avatars/1.jpg" alt="" class="" style="max-width: 100%;">
              </div>
              <hr class="m-y-0">
              <div class="panel-body text-xs-center">
                <button type="button" class="btn btn-primary">Change</button>&nbsp;
                <button type="button" class="btn"><i class="fa fa-trash"></i></button>
                <div class="m-t-2 text-muted font-size-12">JPG, GIF or PNG. Max size of 1MB</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- / Profile tab -->
      <!-- Password tab -->

      <div class="tab-pane fade" id="account-password">
        <div class="p-x-1" id="frmChangePassword">
          <fieldset class="form-group form-group-lg">
            <label for="txtOldPassword">Old password</label>
            <asp:TextBox ID="txtOldPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            <span id="spnMsg"></span>
          </fieldset>
          <fieldset class="form-group form-group-lg">
            <label for="txtNewPassword">New password</label>
            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            <small class="text-muted">Minimum 6 characters</small>
          </fieldset>
          <fieldset class="form-group form-group-lg">
            <label for="txtReNewPassword">Verify password</label>
            <asp:TextBox ID="txtReNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
          </fieldset>
          <asp:Button ID="btnChangePass" CssClass="btn btn-md btn-primary m-t-3" runat="server" Text="Change Password" OnClick="btnChangePass_Click" />
        </div>
      </div>
      <!-- / Password tab -->
    </div>
</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/bootstrapvalidator.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#frmUserDetail').bootstrapValidator({
                    submitButtons: '<%=btnUpdateProfile.ClientID%>',
                    message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    <%=txtFirstName.UniqueID%>: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The first name is required'
                            }
                        }
                    },
                    <%=txtLastName.UniqueID%>: {
                        row: '.col-xs-4',
                        validators: {
                            notEmpty: {
                                message: 'The last name is required'
                            }
                        }
                    },
                    <%=txtUserIP.UniqueID%>: {
                        validators: {
                            ip: {
                                message: 'Please enter a valid IP address'
                            }
                        }
                    }
                }
            });
            $('#<%=btnUpdateProfile.ClientID%>').click(function(){
                var validatorObj = $('#frmUserDetail').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });

            $('#frmChangePassword').bootstrapValidator({
                    submitButtons: '<%=btnChangePass.ClientID%>',
                    message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    <%=txtOldPassword.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'The Old Password is required'
                            }
                        }
                    },
                    <%=txtNewPassword.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'The New Password is required'
                            },
                            stringLength: {
                                min: 6,
                                message: 'The New Password must be more than 6 characters long'
                            },
                            identical: {
                                field: '<%=txtReNewPassword.UniqueID%>',
                                message: 'The password and its confirm are not the same'
                            }
                        }
                    },
                    <%=txtReNewPassword.UniqueID%>: {
                        validators: {
                            identical: {
                                field: '<%=txtNewPassword.UniqueID%>',
                                message: 'The password and its confirm are not the same'
                            }
                        }
                    }
                }
            });
            $('#<%=btnChangePass.ClientID%>').click(function(){
                var validatorObj = $('#frmChangePassword').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
        });
    </script>
</asp:Content>


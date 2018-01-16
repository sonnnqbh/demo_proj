<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Administrator_Login"%>
<%@ Register src="~/Administrator/usercontrol/head_css.ascx" tagname="head_css" tagprefix="uc1" %>
<%@ Register src="~/Administrator/usercontrol/footer_js.ascx" tagname="footer_js" tagprefix="uc5" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <title>Login</title>
    <uc1:head_css ID="head_css1" runat="server" />
    <!-- Custom styling -->
    <style>
    .page-signin-modal {
        position: relative;
        top: auto;
        right: auto;
        bottom: auto;
        left: auto;
        z-index: 1;
        display: block;
    }

    .page-signin-form-group { position: relative; }

    .page-signin-icon {
        position: absolute;
        line-height: 21px;
        width: 36px;
        border-color: rgba(0, 0, 0, .14);
        border-right-width: 1px;
        border-right-style: solid;
        left: 1px;
        top: 9px;
        text-align: center;
        font-size: 15px;
    }

    html[dir="rtl"] .page-signin-icon {
        border-right: 0;
        border-left-width: 1px;
        border-left-style: solid;
        left: auto;
        right: 1px;
    }

    html:not([dir="rtl"]) .page-signin-icon + .page-signin-form-control { padding-left: 50px; }
    html[dir="rtl"] .page-signin-icon + .page-signin-form-control { padding-right: 50px; }

    #page-signin-forgot-form {
        display: none;
    }

    .px-demo-bgs {
        display: none;
    }

    /* Margins */

    .page-signin-modal > .modal-dialog { margin: 30px 10px; }

    @media (min-width: 544px) {
        .page-signin-modal > .modal-dialog { margin: 60px auto; }
    }
    </style>
    <!-- / Custom styling -->
    <link href="assets/css/plugins/sweetalert/sweetalert.css" rel="stylesheet" />
</head>
<body>
  <div class="page-signin-modal modal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="box m-a-0">
          <div class="box-row">
            <div class="box-cell col-md-5 p-a-4">
              <%--<div class="text-xs-center text-md-left">
                <a class="px-demo-brand px-demo-brand-lg" href="index.html"><span class="px-demo-logo bg-primary m-t-0"><span class="px-demo-logo-1"></span><span class="px-demo-logo-2"></span><span class="px-demo-logo-3"></span><span class="px-demo-logo-4"></span><span class="px-demo-logo-5"></span><span class="px-demo-logo-6"></span><span class="px-demo-logo-7"></span><span class="px-demo-logo-8"></span><span class="px-demo-logo-9"></span></span><span class="font-size-20 line-height-1">PixelAdmin</span></a>
                <div class="font-size-15 m-t-1 line-height-1">Simple. Flexible. Powerful.</div>
              </div>
              <ul class="list-group m-t-3 m-b-0 visible-md visible-lg visible-xl">
                <li class="list-group-item p-x-0 p-b-0 b-a-0"><i class="list-group-icon fa fa-sitemap text-white"></i> Flexible modular structure</li>
                <li class="list-group-item p-x-0 p-b-0 b-a-0"><i class="list-group-icon fa fa-file-text-o text-white"></i> SCSS source files</li>
                <li class="list-group-item p-x-0 p-b-0 b-a-0"><i class="list-group-icon fa fa-outdent text-white"></i> RTL direction support</li>
                <li class="list-group-item p-x-0 p-b-0 b-a-0"><i class="list-group-icon fa fa-heart text-white"></i> Crafted with love</li>
              </ul>--%>
              <img src="assets/img/Logo-VNPT.jpg" width="190" height="220" alt="no image" runat="server" />
            </div>
            <div class="box-cell col-md-7">

              <!-- Sign In form -->

              <form class="p-a-4" runat="server">
                <h4 class="m-t-0 m-b-4 text-xs-center font-weight-semibold">Sign In to your Account</h4>
                <div id="frmLogin">
                    <fieldset class="page-signin-form-group form-group form-group-lg">
                      <div class="page-signin-icon text-muted"><i class="ion-person"></i></div>
                      <asp:TextBox runat="server" placeholder="Username or Email" CssClass="page-signin-form-control form-control" ID="txtUserNameOrEmail"></asp:TextBox>
                    </fieldset>

                    <fieldset class="page-signin-form-group form-group form-group-lg">
                      <div class="page-signin-icon text-muted"><i class="ion-asterisk"></i></div>
                      <asp:TextBox ID="txtPassWord" runat="server" CssClass="page-signin-form-control form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                    </fieldset>
                
                    <div class="clearfix">
                      <label class="custom-control custom-checkbox pull-xs-left">
                        <input type="checkbox" class="custom-control-input" />
                        <span class="custom-control-indicator"></span>
                        Remember me
                      </label>
                      <a href="#" class="font-size-12 text-muted pull-xs-right" id="page-signin-forgot-link">Forgot your password?</a>
                    </div>
                    <fieldset class="page-signin-form-group form-group form-group-lg">
                        <asp:Label ID="lblError" Visible="false" runat="server"></asp:Label>
                    </fieldset>
                    <asp:Button runat="server" ID="btnSignIn" CssClass="btn btn-block btn-lg btn-primary m-t-3" Text="Sign In" OnClick="btnSignIn_Click" />
                </div>
              </form>

              <%--<div class="p-y-3 p-x-4 b-t-1 bg-white darken" id="page-signin-social">
                <a href="#" class="btn btn-block btn-lg btn-info font-size-13"><span class="btn-label-icon left fa fa-twitter"></span>Sign In with <strong>Twitter</strong></a>
              </div>--%>

              <!-- / Sign In form -->

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <uc5:footer_js ID="footer_js1" runat="server" />
  <script>
    // -------------------------------------------------------------------------
    // Initialize page components

    $(function() {
      pxDemo.initializeBgsDemo('body', 0, '#000', function(isBgSet) {
        $('#px-demo-signup-link, #px-demo-signup-link a')
          .addClass(isBgSet ? 'text-white' : 'text-muted')
          .removeClass(isBgSet ? 'text-muted' : 'text-white');
      });

      $('#page-signin-forgot-link').on('click', function(e) {
        e.preventDefault();

        $('#page-signin-form, #page-signin-social')
          .css({ opacity: '1' })
          .animate({ opacity: '0' }, 200, function() {
            $(this).hide();

            $('#page-signin-forgot-form')
              .css({ opacity: '0', display: 'block' })
              .animate({ opacity: '1' }, 200)
              .find('.form-control').first().focus();

            $(window).trigger('resize');
          });
      });

      $('#page-signin-forgot-back').on('click', function(e) {
        e.preventDefault();

        $('#page-signin-forgot-form')
          .animate({ opacity: '0' }, 200, function() {
            $(this).css({ display: 'none' });

            $('#page-signin-form, #page-signin-social')
              .show()
              .animate({ opacity: '1' }, 200)
              .find('.form-control').first().focus();

            $(window).trigger('resize');
          });
      });
    });
  </script>
  <script src="assets/js/bootstrapvalidator.min.js"></script>
  <script src="assets/js/plugins/sweetalert/sweetalert.min.js"></script>
  <script>
        $(document).ready(function () {
            $('#frmLogin').bootstrapValidator({
                    submitButtons: '<%=btnSignIn.ClientID%>',
                    message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    <%=txtUserNameOrEmail.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Tên đăng nhập không được để trống'
                            }
                            //emailAddress: {
                            //    message: 'The input is not a valid email address'
                            //}
                        }
                    },
                    <%=txtPassWord.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Mật khẩu không được để trống'
                            }
                        }
                    }
                }
            });
            $('#<%=btnSignIn.ClientID%>').click(function(){
                var validatorObj = $('#frmLogin').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
        });
        function alertMessage(iTitle, iType, iMesage) {
            swal({
                title: "" + iTitle + "",
                text: "" + iMesage + "",
                type: "" + iType + ""
            });
        }
  </script>
</body>
</html>

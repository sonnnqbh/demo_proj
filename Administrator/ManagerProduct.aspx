<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="ManagerProduct.aspx.cs" Inherits="Administrator_ManagerProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/sweetalert/sweetalert.css" rel="stylesheet" />
    <link href="assets/css/plugins/jasny/jasny-bootstrap.min.css" rel="stylesheet" />
    <link href="assets/css/plugins/blueimp/blueimp-gallery.min.css" rel="stylesheet" />
    <style>
        .dataTable > thead > tr > th[class*="sort"]::before{display: none}
        .dataTable > thead > tr > th[class*="sort"]::after{display: none}
    </style>
    <script src="assets/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        function alertMessage(iTitle, iType, iMesage) {
            swal({
                title: "" + iTitle + "",
                text: "" + iMesage + "",
                type: "" + iType + ""
            });
        }
    </script>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="Default.aspx">Dashboard</a></li>
        <li class="active">Products</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Sản phẩm</h1>
        </div>
        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
        </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
        <button type="button" id="btnInsert" class="btn btn-primary" runat="server" onserverclick="btnInsert_ServerClick"><i class="fa fa-plus"></i>&nbsp;Thêm mới</button>
        </div>
        <div class="panel-body form-horizontal">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="gvProducts" CssClass="table table-striped table-bordered"
                        runat="server" AutoGenerateColumns="False" OnRowCommand="gvProducts_RowCommand"
                        DataKeyNames="ProductID" >
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" Visible="true" >
                            <ItemStyle Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ProductSKU" HeaderText="Mã sản phẩm" HeaderStyle-CssClass="control-label bolder blue" >
                        </asp:BoundField>
                        <asp:BoundField DataField="ProductName" HeaderText="Tên sản phẩm" HeaderStyle-CssClass="control-label bolder blue" >
                        </asp:BoundField>
                        <asp:ImageField DataImageUrlField="URLImage" HeaderText="Hình ảnh" ControlStyle-Width="100px" ControlStyle-Height="100px">
                        </asp:ImageField>
                        <asp:BoundField DataField="ProductPrice" HeaderText="Giá" HeaderStyle-CssClass="control-label bolder blue" >
                        </asp:BoundField>
                        <asp:BoundField DataField="ProductShortDesc" HeaderText="Mô tả ngắn" HeaderStyle-CssClass="control-label bolder blue"/>
                        <asp:ButtonField CommandName="addPicture" ControlStyle-CssClass="btn btn-info btn-rounded" ButtonType="Button" Text="Add image" HeaderText="" />
                        <asp:ButtonField CommandName="showAlbum" ControlStyle-CssClass="btn btn-warning btn-rounded" ButtonType="Button" Text="Show album" HeaderText="" />
                        <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-primary btn-rounded"
                                                ButtonType="Button" Text="Edit" HeaderText="">
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-danger btn-rounded"
                                                ButtonType="Button" Text="Delete" HeaderText="">
                        </asp:ButtonField>
                    </Columns>
                    <EmptyDataTemplate>Không có dữ liệu</EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
    <%-- Popup Danh mục  --%>
    <asp:HiddenField ID="hfPopupUpdate" runat="server" />
    <asp:HiddenField ID="hfID" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeUpdate" runat="server" PopupControlID="pnlUpdate" TargetControlID="hfPopupUpdate"
        CancelControlID="btnUClose" BackgroundCssClass="modalBackground" X="220" Y="0">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlUpdate" runat="server" CssClass="modal-dialog modal-lg" Style="display: none">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title" id="myModalLabel">Thông tin sản phẩm</h4>
                </div>
                <div id="UFormValidator" class="modal-body form-horizontal">
                    <div class="form-group">
                        <label for="txtProductName" class="col-sm-3 control-label">Tên sản phẩm:</label>
                        <div class="col-sm-9">
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="drlProductCategory" class="col-sm-3 control-label">Hạng mục:</label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="drlProductCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtProductPrice" class="col-sm-3 control-label">Giá:</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtProductPrice" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtProductShortDesc" class="col-sm-3 control-label">Mô tả ngắn:</label>
                        <div class="col-sm-9">
                        <asp:TextBox ID="txtProductShortDesc" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtProductLongDesc" class="col-sm-3 control-label">Mô tả dài:</label>
                        <div class="col-sm-9">
                        <asp:TextBox ID="txtProductLongDesc" runat="server" CssClass="form-control" TextMode="MultiLine" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="form-group">
                            <asp:Button ID="btnUSave" CssClass="btn btn-primary" runat="server" Text="Save changes" OnClick="btnUSave_Click" />
                            <asp:Button ID="btnUClose" runat="server" CssClass="btn btn-danger" Text="Close" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                
    </asp:Panel>
    <%-- Popup xác nhận --%>
    <asp:HiddenField ID="hfPopupDelete" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeDelete" runat="server" PopupControlID="pnlDelete" TargetControlID="hfPopupDelete"
        CancelControlID="btnXoaHuy" BackgroundCssClass="modalBackground" X="370" Y="0">
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
    <%-- Popup thêm hình ảnh sản phẩm --%>
    <asp:HiddenField ID="hfPopupAddImage" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeAddImage" runat="server" PopupControlID="pnlAddImage" TargetControlID="hfPopupAddImage"
        CancelControlID="btnUCloseImage" BackgroundCssClass="modalBackground">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlAddImage" runat="server" CssClass="modal-dialog" Style="display: none">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title">Thêm ảnh cho sản phẩm</h4>
                </div>
                <div id="frmAddImage" class="modal-body form-horizontal">
                    <div class="form-group">
                        <label for="txtProName" class="col-sm-4 control-label">Tên sản phẩm:</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtProName" runat="server" CssClass="form-control" Enabled="false" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtProductImage" class="col-sm-4 control-label">Đường dẫn ảnh:</label>
                        <div class="col-sm-8">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="input-append">
                                    <span class="btn btn-outline btn-primary btn-file"><span class="fileinput-new"><i class="fa fa-cloud-upload"></i>&nbsp;Chọn file ảnh</span>
                                    <span class="fileinput-exists">Thay đổi</span><asp:FileUpload ID="myFileUpload" runat="server" /></span>
                                    <span class="fileinput-filename"></span>
                                    <button type="button" id="btnUpload" class="btn btn-primary" runat="server" onserverclick="btnUpload_ServerClick"><i class="fa fa-download"></i>&nbsp;Upload</button>
                                    <a href="#" class="close fileinput-exists" data-dismiss="fileinput" style="float: none">×</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-4"></div>
                        <label class="col-sm-4 custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" runat="server" id="cbxIsPresentImage" />
                        <span class="custom-control-indicator"></span>
                        Ảnh đại diện
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="txtImagePosition" class="col-sm-4 control-label">Vị trí:</label>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtImagePosition" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="form-group">
                            <asp:Button ID="btnAddImage" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="btnAddImage_Click" />
                            <asp:Button ID="btnAddAndContinue" CssClass="btn btn-primary" runat="server" Text="Save and continue" OnClick="btnAddAndContinue_Click" />
                            <asp:Button ID="btnUCloseImage" runat="server" CssClass="btn btn-danger" Text="Close" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                
    </asp:Panel>
    <%-- Popup Album  --%>
    <asp:HiddenField ID="hfAlbum" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeShowAlbum" runat="server" PopupControlID="pnlAlbum" TargetControlID="hfAlbum"
        CancelControlID="btnUCloseAlbum" BackgroundCssClass="modalBackground" X="220" Y="0">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlAlbum" runat="server" CssClass="modal-dialog modal-lg" Style="display: none">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title">Album ảnh</h4>
                </div>
                <div class="modal-body form-horizontal">
                    <div class="lightBoxGallery">
                        <%if (totalPic > 0)
                                {
                                    for (int i = 0; i < imgUrls.Length; i++)
                                    {
                                %>
                        <a href="<%=imgUrls[i] %>" title="Image from Unsplash" data-gallery=""><img src="<%=imgUrls[i] %>" width="125" height="125" /></a>
                        <% }
                                }
                             %>
                        <!-- The Gallery as lightbox dialog, should be a child element of the document body -->
                        <div id="blueimp-gallery" class="blueimp-gallery">
                            <div class="slides"></div>
                            <h3 class="title"></h3>
                            <a class="prev">‹</a>
                            <a class="next">›</a>
                            <a class="close">×</a>
                            <a class="play-pause"></a>
                            <ol class="indicator"></ol>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="form-group">
                            <asp:Button ID="btnUCloseAlbum" runat="server" CssClass="btn btn-danger" Text="Close" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/plugins/jasny/jasny-bootstrap.min.js"></script>
    <script src="assets/js/plugins/blueimp/jquery.blueimp-gallery.min.js"></script>
    <script src="assets/js/bootstrapvalidator.min.js"></script>
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
                    <%=txtProductName.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Tên sản phẩm không được để trống!'
                            }
                        }
                    },
                    <%=drlProductCategory.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chọn hạng mục sản phẩm!'
                            }
                        }
                    },
                    <%=txtProductPrice.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Nhập giá cho sản phẩm!'
                            },
                            integer: {
                                message: 'Nhập số!'
                            }
                        }
                    }
                }
            });
            $('#<%=btnUSave.ClientID%>').click(function(){
                var validatorObj = $('#UFormValidator').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
        });
        loadTable();
        function loadTable() {
            $('#MainContent_gvProducts').prepend($("<thead></thead>").append($('#MainContent_gvProducts').find("tr:first"))).dataTable({
                pageLength: 10
            });
            $('#MainContent_gvProducts_wrapper .table-caption').text('Danh sách sản phẩm');
            $('#MainContent_gvProducts_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>


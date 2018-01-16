<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Administrator_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/treeview/style.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
      <li><a href="#">Home</a></li>
      <li class="active">Dashboard</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Dashboard</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
</asp:Content>


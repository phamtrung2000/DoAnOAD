﻿#pragma checksum "..\..\frmThongTinCaNhan.xaml" "{8829d00f-11b8-4213-878b-770e8597ac16}" "0FA5DEADD8823B959A4457B61666565FD1DD230BEB34D95BC29B06CE8CD2E631"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using MaterialDesignThemes.Wpf;
using MaterialDesignThemes.Wpf.Converters;
using MaterialDesignThemes.Wpf.Transitions;
using QuanLyCinema;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace QuanLyCinema {
    
    
    /// <summary>
    /// frmThongTinCaNhan
    /// </summary>
    public partial class frmThongTinCaNhan : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 9 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Grid Grid_ThongTinCaNhan;
        
        #line default
        #line hidden
        
        
        #line 12 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button Btn_Search;
        
        #line default
        #line hidden
        
        
        #line 18 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtMaKH;
        
        #line default
        #line hidden
        
        
        #line 23 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtHoTen;
        
        #line default
        #line hidden
        
        
        #line 28 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtSDT;
        
        #line default
        #line hidden
        
        
        #line 33 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtEmail;
        
        #line default
        #line hidden
        
        
        #line 38 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtDiaChi;
        
        #line default
        #line hidden
        
        
        #line 43 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtNgaySinh;
        
        #line default
        #line hidden
        
        
        #line 48 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtNgayDK;
        
        #line default
        #line hidden
        
        
        #line 53 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.RadioButton rdbNam;
        
        #line default
        #line hidden
        
        
        #line 57 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.RadioButton rdbNu;
        
        #line default
        #line hidden
        
        
        #line 62 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button Complete;
        
        #line default
        #line hidden
        
        
        #line 67 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBlock txtTongChiTieu;
        
        #line default
        #line hidden
        
        
        #line 70 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ProgressBar barTongChiTieu;
        
        #line default
        #line hidden
        
        
        #line 151 "..\..\frmThongTinCaNhan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox txtLoaiKH;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/QuanLyCinema;component/frmthongtincanhan.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\frmThongTinCaNhan.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.Grid_ThongTinCaNhan = ((System.Windows.Controls.Grid)(target));
            
            #line 9 "..\..\frmThongTinCaNhan.xaml"
            this.Grid_ThongTinCaNhan.Loaded += new System.Windows.RoutedEventHandler(this.Grid_ThongTinCaNhan_Loaded);
            
            #line default
            #line hidden
            return;
            case 2:
            this.Btn_Search = ((System.Windows.Controls.Button)(target));
            return;
            case 3:
            this.txtMaKH = ((System.Windows.Controls.TextBox)(target));
            return;
            case 4:
            this.txtHoTen = ((System.Windows.Controls.TextBox)(target));
            
            #line 23 "..\..\frmThongTinCaNhan.xaml"
            this.txtHoTen.KeyDown += new System.Windows.Input.KeyEventHandler(this.txtHoTen_KeyDown);
            
            #line default
            #line hidden
            return;
            case 5:
            this.txtSDT = ((System.Windows.Controls.TextBox)(target));
            
            #line 28 "..\..\frmThongTinCaNhan.xaml"
            this.txtSDT.KeyDown += new System.Windows.Input.KeyEventHandler(this.txtSDT_KeyDown);
            
            #line default
            #line hidden
            return;
            case 6:
            this.txtEmail = ((System.Windows.Controls.TextBox)(target));
            return;
            case 7:
            this.txtDiaChi = ((System.Windows.Controls.TextBox)(target));
            
            #line 38 "..\..\frmThongTinCaNhan.xaml"
            this.txtDiaChi.KeyDown += new System.Windows.Input.KeyEventHandler(this.txtDiaChi_KeyDown);
            
            #line default
            #line hidden
            return;
            case 8:
            this.txtNgaySinh = ((System.Windows.Controls.TextBox)(target));
            
            #line 43 "..\..\frmThongTinCaNhan.xaml"
            this.txtNgaySinh.KeyDown += new System.Windows.Input.KeyEventHandler(this.txtNgaySinh_KeyDown);
            
            #line default
            #line hidden
            return;
            case 9:
            this.txtNgayDK = ((System.Windows.Controls.TextBox)(target));
            
            #line 48 "..\..\frmThongTinCaNhan.xaml"
            this.txtNgayDK.KeyDown += new System.Windows.Input.KeyEventHandler(this.txtNgayDK_KeyDown);
            
            #line default
            #line hidden
            return;
            case 10:
            this.rdbNam = ((System.Windows.Controls.RadioButton)(target));
            
            #line 53 "..\..\frmThongTinCaNhan.xaml"
            this.rdbNam.Click += new System.Windows.RoutedEventHandler(this.rdbNam_Click);
            
            #line default
            #line hidden
            return;
            case 11:
            this.rdbNu = ((System.Windows.Controls.RadioButton)(target));
            
            #line 57 "..\..\frmThongTinCaNhan.xaml"
            this.rdbNu.Click += new System.Windows.RoutedEventHandler(this.rdbNu_Click);
            
            #line default
            #line hidden
            return;
            case 12:
            this.Complete = ((System.Windows.Controls.Button)(target));
            return;
            case 13:
            this.txtTongChiTieu = ((System.Windows.Controls.TextBlock)(target));
            return;
            case 14:
            this.barTongChiTieu = ((System.Windows.Controls.ProgressBar)(target));
            return;
            case 15:
            this.txtLoaiKH = ((System.Windows.Controls.TextBox)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}


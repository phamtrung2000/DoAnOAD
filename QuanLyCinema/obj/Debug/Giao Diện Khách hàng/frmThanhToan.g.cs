﻿#pragma checksum "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml" "{8829d00f-11b8-4213-878b-770e8597ac16}" "DF2235F59220463101880E8D3756CCD022B4CF0B133F0FAC7973C0663E2D92CD"
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
using QuanLyCinema.Giao_Diện_Khách_hàng;
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


namespace QuanLyCinema.Giao_Diện_Khách_hàng {
    
    
    /// <summary>
    /// frmThanhToan
    /// </summary>
    public partial class frmThanhToan : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 10 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Grid GridThanhToan;
        
        #line default
        #line hidden
        
        
        #line 12 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button bt_back;
        
        #line default
        #line hidden
        
        
        #line 24 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.WrapPanel gridChiTietThanhToan;
        
        #line default
        #line hidden
        
        
        #line 38 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button btnXacNhan;
        
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
            System.Uri resourceLocater = new System.Uri("/QuanLyCinema;component/giao%20di%e1%bb%87n%20kh%c3%a1ch%20h%c3%a0ng/frmthanhtoan" +
                    ".xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
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
            this.GridThanhToan = ((System.Windows.Controls.Grid)(target));
            
            #line 10 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
            this.GridThanhToan.Loaded += new System.Windows.RoutedEventHandler(this.GridThanhToan_Loaded);
            
            #line default
            #line hidden
            return;
            case 2:
            this.bt_back = ((System.Windows.Controls.Button)(target));
            
            #line 12 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
            this.bt_back.Click += new System.Windows.RoutedEventHandler(this.bt_back_Click);
            
            #line default
            #line hidden
            return;
            case 3:
            this.gridChiTietThanhToan = ((System.Windows.Controls.WrapPanel)(target));
            return;
            case 4:
            this.btnXacNhan = ((System.Windows.Controls.Button)(target));
            
            #line 38 "..\..\..\Giao Diện Khách hàng\frmThanhToan.xaml"
            this.btnXacNhan.Click += new System.Windows.RoutedEventHandler(this.btnXacNhan_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}


   M S B A M L   `   `   `  ����G  CQuanLyCinema, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullO,clr-namespace:QuanLyCinema.DangNhapKhachHangQuanLyCinema.DangNhapKhachHang  5   	   .    (QuanLyCinema.DangNhapKhachHang.frmDangKy   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   >local,clr-namespace:QuanLyCinema.DangNhapKhachHang     5   	   V RMaterialDesignThemes.Wpf, Version=3.1.2.1465, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	     � Title$  Thêm Khách Hàng��5
   
   $	��450��6#   $	��800��60    � WindowStartupLocation$ CenterScreen=�6<   .��5      � .+�5   
   �� -   5         ��Name$ lbTitle��5      $��Đăng Ký tài khoản��6!   $��Time new roman)�6>   $��20(�6Z      MaterialDesignLabel#��[  6h   $��312,85,268.6,295q�6�    J� RenderTransformOrigin$ 
0.483,0.35&�6�   ���	#DD0B0A0A$��Stretch=�6�   $��Stretch=�6  �� 5   
   -   5        $ 
lb_hotenkh��5      $��
Họ Tên:��6$   $��48,208,633.6,182q�66   ���	#DD0B0A0A$��30��6g   �� 5   
   -   5         ��Name$ 
txtHoTenKH��5      $
��Left=�6&   $��30��6A   $��165,208,0,0q�6M    �� TextWrapping$
 Wrap=�6b   $	��Top=�6v   $	��195��6�   $��0��6�   �� 5   
   -   5        $ lbSDT��5      $
��SDT:��6   $��398,270,294.6,120q�6.   ���	#DD0B0A0A$��30��6`   �� 5   
   -   5        $ txtSDT��5      $
��Left=�6"   $��30��6=   $��504,270,0,0q�6I   $
 Wrap=�6^   $	��Top=�6s   $	��233��6�   ���	#FF140202$��2��6�   �� 5   
   -   5        $ 
lbGioitinh��5      $��Giới tính:��6$   $��395,156,317.6,234q�69   ���	#DD0B0A0A$��30��6k   $ 0.488,0.433&�6w   	� 5   
   -   5         	�Name$ rdbNam��5      $	��Nam��6&   $
��Left=�64   $��504,163,0,0q�6O   $	��Top=�6d   $��3��6|   	� 5   
   -   5        $ rdbNu��5      $
��Nữ��6%   $
��Left=�62   $��580,163,0,0q�6M   $	��Top=�6b   $��4��6z   �� 5   
   -	   5        $ 
lbNgaysinh��5      $��Ngày sinh:��6$   $��395,208,308.6,182q�69   ���	#DD0B0A0A$��30��6k   $ 0.814,0.775&�6w   (  "System.Windows.Controls.DatePicker  5   
   -
   5          Name$ dtpNgaySinh��5      $��704,208,57,181q�6*   $��Stretch=�6B   $��5��6�   �� 5   
   -   5        $ txtNgaySinh��5      $��504,208,88,181q�6'   $
 Wrap=�6?   $��	222222222��6S   $	��210��6h   �� 5   
   -   5        $ lbDiachi��5      $��Địa chỉ:��6"   $��48,270,683.6,120q�65   ���	#DD0B0A0A$��30��6g   �� 5   
   -   5        $ 	txtDiaChi��5      $��165,264,431.6,120q�6%   $
 Wrap=�6@   ���	#FF140202 K� ZIndex$ 6��6k   $��1��6|   '  !MaterialDesignThemes.Wpf.PackIcon  5#   
   	   Kind$	 AccountsAdd=�6"   $��50��65   $��50��6@   $��
376,30,0,0q�6L   6b   �� 5$   
   -   5        
 ��Name$
 	btnLamMoi��5$       . *MaterialDesignFloatingActionMiniDarkButton#��[ 5%      $��530,68,207.6,295q�5&      ���	#FF141315$��45��6d   $��45��6p   ��6M   Z� .��5'        $	 Refresh=�5(      $��24��5)      $��24��5*      5+      �� 5,   
   -   5        $
 btnHuy��5,      #��[ 5-      $��653,68,85.6,295q�5.      ���	#FF0D0C0F$��45��6i   $��45��6u   ��6R   Z� .��5/        $	 Cancel=�50      $��24��51      $��24��52      53      �� 54   
   -   5        $
 btnLuu��54      #��[ 55      $��591,68,145.6,295q�56      ���	#FF0E0D11$ -1.763,2.382&�6T   $��45��6�   $��45��6�   ��6y   Z� .��57        $	 ContentSave=�58      $��24��59      $��24��5:      5;      5<      5=      
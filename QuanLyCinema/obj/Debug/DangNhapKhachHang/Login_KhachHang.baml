   M S B A M L   `   `   `  ����G  CQuanLyCinema, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullO,clr-namespace:QuanLyCinema.DangNhapKhachHangQuanLyCinema.DangNhapKhachHang  5   	   4    .QuanLyCinema.DangNhapKhachHang.Login_KhachHang   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   >local,clr-namespace:QuanLyCinema.DangNhapKhachHang     5   	   V RMaterialDesignThemes.Wpf, Version=3.1.2.1465, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   -   5          � Title$  Login_KhachHang��5	   	    � WindowStyle$
 None=�6!   $	��478��64   $	��499��6A    � WindowStartupLocation$ CenterScreen=�5
   	   ���	#FF0B47EE��5      �� 5   
    �� ImageSource$O I/QuanLyCinema;component/Resources/mau-background-don-gian-27-1024x681.png��6   .��5      � $	��200��6   $��40��6   $��Center=�6#    � ColumnDefinitions 5   
   �� 5      $��60 �6   �� 5      $	��140 �6   �� 5      $
��Auto �6   .+�5   
   �� $
��Left=�6   $��-62,-89,-73,-115q�6/   $	��335��6I    J� RenderTransformOrigin$ 0.503,0.496&�6U   $��3��6y   ��5      �� 5      5      �� 5   
   $��Tài khoản: ��6   $��16(�6&   $��Time new roman)�64   $��40��6P   $��-39,-75,119,75q�6\   $��Bottom=�6t   $��2��6�   #��� ��6�   ��6�   Z� 6�   �� 5   
   -   5         ��Name$ txtPassword��5      $��Mật khẩu: ��6&   $��16(�6;   $��Time new roman)�6I   #��� ��6e   $��99��6�   $��40��6�   $��-39,17,0,-17q�6�   $��Center=�6�   $
��Left=�6�   �� 5   
   -   5         ��Name$ txtTaiKhoan��5      $��thanhphuong��6'    *  &MaterialDesignOutlinedTextFieldTextBox#��[  6;    �� 	MaxLength$ 20��6{   )  #MaterialDesignThemes.Wpf.HintAssist	   Hint$	 Nhập tài khoản��6�   $��3��6�   $
��Left=�6�   $��40��6�   $��-38,-42,-50,0q�6�   $
��11.5(�6  $��Time new roman)�6  
 �� TextWrapping$

 Wrap=�68  $	��Top=�6M  $	��288��6e  ���	#FF221F1F���	#FFEF0909���	#FFFCFCFC J� Opacity$	 0.9Q�6�  $��1,1,1,1q�6�   �� TextAlignment$ Justify=�6�  #��� ��6�  $	 1,1&�6G  $��1��6c  .��6p  z�5      V� 5      .~�5      �� �� 5       �� 5!       �� Angle$ 0.235Q�6&   T� 5"      5#      .��5$   '   5%      �� 5'   
   -   5         ��Name$ btTaoTaikhoan��5'      $��Đăng ký tài khoản��6(   $��10(�6E   $��29��6S   $��42,146,35,-135q�6_   ���	#DD14ACDA$��2��6�   ��6w   Z� ��6�   Z� 6�   G� 5)   
   -   5         G�Name$ 
txtMatKhau��5)       G� Password$ thanhphuong��6*   $	 Nhập mật khẩu��6A   $��3��6p    2 .MaterialDesignOutlinedPasswordFieldPasswordBox#��[ 6�   $
��Left=�6�   $��45��6�   $��-39,55,-50,-64q�6�   $
��11.5(�6  $��Time new roman)�6  $	��Top=�67  $	��289��6O  ���	#FF221F1F���	#FFDA1919���	#FFFCFCFC$	 0.9Q�6�  $��1,1,1,1q�6�  $��2��6�  '  !MaterialDesignThemes.Wpf.PackIcon  5*   
      Kind$ Cinema=�6"   $
��Auto��60   $��61��6=   $��20,-196,35,0q�6I   $��Stretch=�6_   $��2��6}   
���   �6�     5+   
   $	 Key=�6"   $��21��6-   $��30��68   $��-58,15,0,-5q�6D   #��� ��6Y     5,   
   $
 User=�6"   $��26��6.   $��21��69   $��-62,-75,96,0q�6E   $��Right=�6[   #��� ��6w   �� 5-   
   $��Time new roman)�6   $��24(�6,   $��Center=�6:   $��Đăng Nhập��6W   $��37,-135,-35,0q�6k   $	��Top=�6�   $	��198��6�   $��3��6�   $��41��6�   9� 5.   
   $��Expander��6   $
��Left=�6%   $��8��6@   $��-62,-168,0,0q�6K   $	��Top=�6a   $��25��6y   �� 5/   
   -   5        $ txtPW��5/      ���	#FFFCFCFC$��10(�68   $	 Enter the password��6F   $
��Left=�6z   $��37��6�   $��-39,55,-35,-52q�6�   $

 Wrap=�6�   #��[  6�   $	��Top=�6  $	��274��6%  $��3��61  ���	#89F21A1A$y�Hidden=�6]  #��� ��6q  �� 50   
   -   5        $ 
btDangnhap��50      $��Đăng nhập��6%    # MaterialDesignFlatLightBgButton#��[ 6R   $��Time new roman)�6�   $��18(�6�   $��-39,109,-50,-101q�6�   #��� ��6�   #��� ��6   $��3��6p  ���	#FF569DF5 �� 	IsDefault . $��3��6�  �� 51   
   -   5        $ btExit��51      $��2��6!   $
��Left=�61   $��50��6L   $��34,-190,-90,0q�6X   $	��Top=�6o   $��56��6�   ��6�   Z� ��6�   Z� .��52        $ Shutdown=�6&   $
��Left=�66   $��41��6Q   $	��Top=�6]   $��23��6u   #��� ��6�   53      54      55      
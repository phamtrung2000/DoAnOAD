   M S B A M L   `   `   `  ����G  CQuanLyCinema, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:QuanLyCinemaQuanLyCinema  5   	       QuanLyCinema.Login   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:QuanLyCinema     5   	   V RMaterialDesignThemes.Wpf, Version=3.1.2.1465, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5   	   -   5        $��loginWindow��5   	      MaterialDesignBody#���   5	   	   $��Regular"�5
   	   $��13(�5   	   &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5   	      TextRenderingMode$
 Auto=�5   	     MaterialDesignFont#���  5   	    � 
ResizeMode$ NoResize=�5   	    � WindowStyle$
 None=�5   	    � WindowStartupLocation$ CenterScreen=�5   	    � Title$ Đăng nhập��5   	   $	��478��6   $	��499��6(    � AllowsTransparency . ��5      �� 5   
    �� ImageSource$7 1Resources\mau-background-don-gian-27-1024x681.png��6   .��5      � $	��200��6   $��40��6   $��Center=�6#    � ColumnDefinitions 5    
   �� 5!      $��60 �6   �� 5"      $	��140 �6   �� 5#      $
��Auto �6   .+�5%   
   �� $
��Left=�6   $��-62,-89,-73,-115q�6/   $	��335��6I   	 J� RenderTransformOrigin$	 0.503,0.496&�6U   $��3��6y   ��5&      �� 5'      5)      �� 5*   
   $��Tài khoản: ��6   $��16(�6&   $��Time new roman)�64   $��40��6P   $��-39,-75,119,75q�6\   $��Bottom=�6t   $��2��6�   #��� ��6�   ��6�   Z� 6�   �� 5+   
   -   5        
 ��Name$
 txtPassword��5+      $��Mật khẩu: ��6%   $��16(�6:   $��Time new roman)�6H   #��� ��6d   $��99��6�   $��40��6�   $��-39,17,0,-17q�6�   $��Center=�6�   $
��Left=�6�   �� 5,   
   -   5         ��Name$ txtTaiKhoan��5,       * &MaterialDesignOutlinedTextFieldTextBox#��[ 6(    �� 	MaxLength$ 20��6h   )  #MaterialDesignThemes.Wpf.HintAssist   Hint$ Nhập tài khoản��6w   $��3��6�   $
��Left=�6�   $��40��6�   $��-38,-42,-50,0q�6�   $
��11.5(�6�   $��Time new roman)�6	   �� TextWrapping$
 Wrap=�6%  $	��Top=�6:  $	��288��6R  ���	#FF221F1F���	#FFEF0909���	#FFFCFCFC J� Opacity$	 0.9Q�6�  $��1,1,1,1q�6�   �� TextAlignment$ Justify=�6�  #��� ��6�  $		 1,1&�64  $��1��6P  .��6]  z�5-      V� 5.      .~�5/      �� �� 50      �� 51       �� Angle$ 0.235Q�6&   T� 52      53      .��54   '   55      �� 56   
   -   5         ��Name$ tb��56      $��20��6    $��67,10,-35,10q�6,   $y�Visible=�6B   $��1��6W   $��2��6g   �� 57      $��http://www.google.com?�6   .�6=   Forgot password?6Q   58      G� 59   
   -   5         G�Name$ 
txtMatKhau��59      $ Nhập mật khẩu��6*   $��3��6Y    2 .MaterialDesignOutlinedPasswordFieldPasswordBox#��[ 6m   $
��Left=�6�   $��45��6�   $��-39,55,-50,-64q�6�   $
��11.5(�6�   $��Time new roman)�6  $	��Top=�6   $	��289��68  ���	#FF221F1F���	#FFDA1919���	#FFFCFCFC$	 0.9Q�6�  $��1,1,1,1q�6�  $��2��6�  '  !MaterialDesignThemes.Wpf.PackIcon  5:   
      Kind$ Cinema=�6"   $
��Auto��60   $��61��6=   $��20,-196,35,0q�6I   $��Stretch=�6_   $��2��6}   
���   �6�     5;   
   $	 Key=�6"   $��21��6-   $��30��68   $��-58,15,0,-5q�6D   #��� ��6Y     5<   
   $
 User=�6"   $��26��6.   $��21��69   $��-62,-75,96,0q�6E   $��Right=�6[   #��� ��6w   �� 5=   
   $��Time new roman)�6   $��24(�6,   $��Center=�6:   $��Đăng Nhập��6W   $��37,-135,-35,0q�6k   $	��Top=�6�   $	��198��6�   $��3��6�   $��41��6�   9� 5>   
   $��Expander��6   $
��Left=�6%   $��8��6@   $��-62,-168,0,0q�6K   $	��Top=�6a   $��25��6y   �� 5?   
   -   5        $ txtPW��5?      ���	#FFFCFCFC$��10(�68   $ Enter the password��6F   $
��Left=�6z   $��37��6�   $��-39,55,-35,-52q�6�   $
 Wrap=�6�   #��[ 6�   $	��Top=�6  $	��274��6%  $��3��61  ���	#89F21A1A$y�Hidden=�6]  #��� ��6q  �� 5@   
   -   5         ��Name$ rdoCheck��5@      $��CheckBox��6%   $��2��68   $
��Left=�6H   $��30��6c   $��27,62,-50,-52q�6o   $	��Top=�6�   $��23��6�    d� 	IsChecked$ FalseY�6�   �� 5A   
   -   5         ��Name$ 
btDangnhap��5A      $��Đăng nhập��6%    # MaterialDesignFlatLightBgButton#��[ 69   $��Time new roman)�6r   $��18(�6�   $��-39,109,-50,-101q�6�   #��� ��6�   #��� ��6  $��3��6q  ���	#FF569DF5 �� 	IsDefault . $��3��6�  �� 5B   
   -	   5        $ btExit��5B      $��2��6!   $
��Left=�61   $��50��6L   $��34,-190,-90,0q�6X   $	��Top=�6o   $��56��6�   ��6�   Z� ��6�   Z� .��5C        $ Shutdown=�6&   $
��Left=�66   $��41��6Q   $	��Top=�6]   $��23��6u   #��� ��6�   5D      �� 5E   
   -
   5        $ btTaoTaikhoan��5E      $��Đăng ký tài khoản��6(   $��10(�6E   $��29��6S   $��42,146,35,-135q�6_   ���	#DD14ACDA$��2��6�   ��6w   Z� ��6�   Z� 6�   5G      5H      
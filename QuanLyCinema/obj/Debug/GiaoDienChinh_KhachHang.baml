   M S B A M L   `   `   `  ����G  CQuanLyCinema, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null+clr-namespace:QuanLyCinemaQuanLyCinema  5   	   *    $QuanLyCinema.GiaoDienChinh_KhachHang   5   	   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   ,localclr-namespace:QuanLyCinema     5   	   V RMaterialDesignThemes.Wpf, Version=3.1.2.1465, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   c _System.Windows.Interactivity, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5   	      MaterialDesignBody#���   5	   	   $��Regular"�5
   	   $��13(�5   	   &   System.Windows.Media.TextOptions    TextFormattingMode$  Ideal=�5   	      TextRenderingMode$
 Auto=�5   	     MaterialDesignPaper#���  5   	     MaterialDesignFont#���  5   	    � Title$0 *Phần mềm quản lý rạp chiếu phim��5   	   $	��800��5   	   $
��1210��5   	    � WindowStyle$ SingleBorderWindow=�5   	    � 
ResizeMode$ CanMinimize=�5   	    � WindowStartupLocation$ CenterScreen=�5   	   .��5      � ���	#FFFBF2F2.+�5    
   �� -   5         ��Name$ panelToolBar��5       $��240,0,0,610q�6+   .+�5!      � $	��150��6    � ColumnDefinitions 5"      �� 5#      6)   �� 5$      6)   �� 5%      6)   .+�5'      � $��0��6   .+�5(      �� $��Resources\Acoustic.jpg��6   $
��Fill=�6<   5)      � 5*      $��1��6   .+�5+      �� $"��Resources\cinema_toolbar.png��6   $
��Fill=�6B   5,      � 5-      $��2��6   .+�5.      �� $��Resources\Acoustic.jpg��6   $
��Fill=�6<   5/      50      51      � 54   
   $��240,150,0,0q�6   $	��950��6$   $	��620��60   .+�55      � -   5         �Name$ GridHienThi��55      $��Center=�56      $��Center=�60   57      � 5:   
   -   5        $ GridMenu��5:      $	��770��6!   $��0,0,0.2,0.4q�6.   .+�5;      �� $	��240��6   ���	#FF656161$
��Left=�6>   $	��771��6Y   .+�5<      �� $��Button��6   $
��Left=�6*   $	��150��6E   $	��Top=�6R   $	��240��6j   ��5=      �� 5>      	 �� ImageSource$�	 �Resources\film-movie-industry-creative-symbol-concept-play-stop-pause-button-cinema-abstract-business-logo-vintage-video-camera-media-137072254.jpg��6%   
 j� Stretch$
 UniformToFill=�6�   5@      � 5A      $	��240��6   $
��Left=�6#   ���	#FF222222.+�5B      ?  9MaterialDesignThemes.Wpf.Transitions.TransitioningContent  -   5          Name$ TrainsitionigContentSlide��5B   :   C  =MaterialDesignThemes.Wpf.Transitions.TransitioningContentBase   OpeningEffect 5C   :   D  >MaterialDesignThemes.Wpf.Transitions.TransitionEffectExtension  *SlideInFromLeft+   Duration$ 0:0:0.2X��� 5D      $
��Auto=�6#   .��5E      �� -   5         ��Name$ ListViewMenu��5E   #   $	��619��5F      $	��240��5G      
�������$��Champagne & Limousines)�5H   6   $��18(�6^    �� SelectedIndex$ 0��6�   ���	#FFEAE2E2.@�5K      �� -   5         ��Name$ btnPhongchieu��5K   ^   $��60��6+   $	��240��67   $
��Left=�6C   .��5L   "   ��  �� Orientation$ 
Horizontal=�6-   $	��220��6F   .+�5M   &   '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ Theater=�6>   $
��Left=�6M   $��35��6h   $	��Top=�6t   $��40��6�   �� 5N   &   $��Xem Thông tin phim��60   $��16(�6J   $��Center=�6X   $
��20 0q�6s   5O   #   5P      �� 5R      -   5        $ btnLoaiphim��5R   ^   $��60��6+   $	��240��67   $
��Left=�6C   .��5S   "   �� $ 
Horizontal=�6-   $	��220��6F   .+�5T   &     $ MovieSearch=�6>   $
��Left=�6Q   $��35��6l   $	��Top=�6x   $��40��6�   �� 5U   &   $��Xem Lịch chiếu��60   $��16(�6F   $��Center=�6T   $
��20 0q�6o   5V   #   5W      �� 5Y      -   5        $ btnPhim��5Y   ^   $��60��6+   $	��240��67   $
��Left=�6C   .��5Z   "   �� $ 
Horizontal=�6-   $	��220��6F   .+�5[   &     $ 	MovieOpen=�6>   $
��Left=�6O   $��35��6j   $	��Top=�6v   $��40��6�   �� 5\   &   $��
Đặt vé��60   $��16(�6>   $��Center=�6L   $
��20 0q�6g   5]   #   5^      �� 5`      -	   5        $ btnThongTinCaNhan��5`   +   $��60��6F   $	��240��6R   $
��Left=�6^   .��5a   "   �� $ 
Horizontal=�6-   $	��220��6F   .+�5b   &     $ Account=�6>   $
��Left=�6M   $��35��6h   $	��Top=�6t   $��40��6�   �� 5c   &   $��Thông tin cá nhân��60   $��16(�6I   $��Center=�6W   $
��20 0q�6r   5d   #   5e      �� 5g      -
   5        $ btnLichSuDatVe��5g   +   $��60��6C   $	��240��6O   $
��Left=�6[   .��5h   "   �� $ 
Horizontal=�6-   $	��220��6F   .+�5i   &     $ CalendarClock=�6>   $
��Left=�6S   $��35��6n   $	��Top=�6z   $��40��6�   �� 5j   &   $��Lịch sử đặt vé��60   $��16(�6F   $��Center=�6T   $
��20 0q�6o   5k   #   5l      5n      5o      5p      5q      �� 5r      -   5         ��Name$ bt_shutdown��5r      $
��Left=�6*   $��32��6E     MaterialDesignToolButton#��[ 6Q   $��1147,115,0,0q�6�   $	��Top=�6�   $��33��6�   ��6�   Z� ��6�   Z� .��5s        $ Shutdown=�6*   $
��Left=�6:   $��23��6U   $	��Top=�6a   $��25��6y   ���	#FFFCF4F46�   5t      �� 5u      -   5        $ 
bt_setting��5u      $
��Left=�6)   $��32��6D   #��[ 6P   $��1101,115,0,0q�6�   $	��Top=�6�   $��41��6�   ��6�   Z� ��6�   Z� .��5v        $ Settings=�6*   $
��Left=�6:   $��23��6U   $	��Top=�6a   $��25��6y   ���	#FFFCF4F46�   5w      �� 5x      -   5        $ 	bt_logout��5x      $
��Left=�6(   $��32��6C   #��[ 6O   $��1060,115,0,0q�6�   $	��Top=�6�   $��36��6�   ��6�   Z� ��6�   Z� .��5y        $ Logout=�6*   $
��Left=�68   $��23��6S   $	��Top=�6_   $��25��6w   ���	#FFFCF4F46�   5z      5|      5~      5      
   M S B A M L   `   `   `  ����G  CQuanLyCinema, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]3clr-namespace:QuanLyCinema.Giao_Diện_Khách_hàng%QuanLyCinema.Giao_Diện_Khách_hàng  5      ;    5QuanLyCinema.Giao_Diện_Khách_hàng.frmXemLichChieu   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      Elocal3clr-namespace:QuanLyCinema.Giao_Diện_Khách_hàng     5      V RMaterialDesignThemes.Wpf, Version=3.1.2.1465, Culture=neutral, PublicKeyToken=nullFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5      .��5
      � -   5        $��GridLichChieu��5
      ��5   
   �� 5        �� ImageSource$a  [/QuanLyCinema;component/Resources/brick-wall-room-background-neon-light-vector-27852413.jpg��6    j� Stretch$ UniformToFill=�6�   .+�5   
   �� $��Danh sách lịch chiếu��6   $��20,140,20,20q�61   ���	#FFF5EFEF.��5      � .+�5      &   System.Windows.Controls.DataGrid  -   5          Name$ dtgDSLichChieu��5      $	��400��63   $	��Top=�6@      
IsReadOnly . $��Stretch=�5      $��Stretch=�6<   ���	#FFF3EEEE$��226,0,111,0q�6v      Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ Giờ chiếu��6-   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6@   �� *
ThoiGian+6_   5      �� 5      -   5         ��Name$ txtNgayChieu��5       �� TextAlignment$
 Left=�62   $	��100��6G   $��117,147,671,161q�6T   $
��Wrap=�6m   �� 5      -   5        $ lblNgayChieu��5      $��  Ngày chiếu��62   $
 Left=�6F   $��17(�6[   $��105,92,683,279q�6i   �� 5      -   5        	 ��Name$	 btnNgayTiepTheo��5      $
��Left=�64   $��801,147,0,0q�6O   $	��Top=�6d   $��81��6|   $��85��6�   .��5      '  !MaterialDesignThemes.Wpf.PackIcon  $��30��6.   $��38��6:   
   Kind$
 ArrowForward=�6E   6[   5      �� 5      -   5        $	 btnNgayTruocDo��5      $
��Left=�62   $��
10,147,0,0q�6M   $	��Top=�6a   $��86��6y   $��85��6�   .��5        $��38��6.   $��30��69   $
 	ArrowBack=�6E   6X   5       5"      5#        5$   
   
�������$
 Calendar=�65   $��77��6E   $��75��6P   $��
296,30,0,0q�6\   6r   �� 5%   
   $��40(�6   
�������$��Lịch chiếu phim��61   $��Center=�6K   $��Center=�6o   $
��Left=�6�   $	��112��6�   $��
373,10,0,0q�6�   $	��Top=�6�   $	��307��6�   5&      5'      
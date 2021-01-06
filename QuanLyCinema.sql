create database DOAN
GO
use DOAN

GO
CREATE TABLE NHANVIEN 
(
    STT INT IDENTITY,
	MANV VARCHAR(10) PRIMARY KEY ,
	HOTEN NVARCHAR(40),
	CHUCVU NVARCHAR(100),
	SDT VARCHAR(20),
	GIOITINH NVARCHAR(4) CHECK (GIOITINH IN('Nam',N'NỮ')),
	NGAYSINH DATE,
	DIACHI NVARCHAR(100),
	LUONG MONEY ,
	NGAYVL DATE
)
--DROP TABLE NHANVIEN

go
CREATE TABLE DANGNHAP_NHANVIEN
(
MANV VARCHAR(10),
TAIKHOAN VARCHAR(50),
MATKHAU VARCHAR(50),
CONSTRAINT PK_DANGNHAP_NHANVIEN PRIMARY KEY(MANV,MATKHAU),
CONSTRAINT FK_DANGNHAP_NHANVIEN_MANV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV) ON DELETE CASCADE
)
go
CREATE TABLE KHACHHANGTHANTHIET
(
    STT INT IDENTITY,
	MAKH VARCHAR(10) PRIMARY KEY ,
	HOTEN NVARCHAR(40) ,
	DIACHI NVARCHAR(100) ,
	NGAYSINH DATE,
	GIOITINH NVARCHAR(4) check (GIOITINH IN ('Nam',N'Nữ')),
	SDT VARCHAR(20),
	LOAIKH NVARCHAR(50), 
	NGAYDK DATE
)

--CREATE TABLE LOAIKHACHHANG
--(
--    MALOAIKH NVARCHAR(50),
--	TENLOAIKH NVARCHAR(50),
--	MUCGIAMGIA INT -- PHAN TRAM
--)


go
CREATE TABLE DANGNHAP_KHACHHANG
(
MAKH VARCHAR(10),
TAIKHOAN VARCHAR(50),
MATKHAU VARCHAR(50),
CONSTRAINT PK_DANGNHAP_KHACHHANG PRIMARY KEY(MAKH,MATKHAU),
CONSTRAINT FK_DANGNHAP_KHACHHANG_MAKH FOREIGN KEY(MAKH) REFERENCES KHACHHANGTHANTHIET(MAKH) ON DELETE CASCADE
)

go
CREATE TABLE NGUOIDUNG
(
    STT INT IDENTITY,
	MAND VARCHAR(10) PRIMARY KEY ,
	HOTEN NVARCHAR(40),
	CHUCVU NVARCHAR(100),
	PHANQUYEN NVARCHAR(100),
	CONSTRAINT FK_NGUOIDUNG_MAND FOREIGN KEY(MAND) REFERENCES NHANVIEN(MANV) ON DELETE CASCADE
)

GO
CREATE TABLE PHONGCHIEU
(
    STT INT IDENTITY,
	MAPC VARCHAR(10) PRIMARY KEY ,
	TENPC NVARCHAR(40),
	SOCHO INT, --số chỗ
	MAYCHIEU NVARCHAR(100),
	-- Viewsonic PX727 4K HDR (US)
	-- Viewsonic PX747 4K (US)
	-- Optoma HT27LV
	-- Optoma HT27LV-4K HDR
	-- Sony VZ1000ES
	-- Optoma HD29H 4K
	LOA NVARCHAR(100),
	-- Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-299
	-- Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-196
	DIENTICH INT,
	TINHTRANG NVARCHAR(20),
	-- Tốt / Khá / Trung Bình
	TRANGTHIETBIKHAC NVARCHAR(100)
)

go
CREATE TABLE LOAIPHIM
(
    STT INT IDENTITY,
	MALP VARCHAR(10) PRIMARY KEY ,
	TENLP NVARCHAR(40),
	MOTA NVARCHAR(1000) --MÔ TẢ
)
-- drop table LOAIPHIM

 go
CREATE TABLE PHIM
(
    STT INT IDENTITY,
	MAPHIM VARCHAR(10) PRIMARY KEY ,
	TENPHIM NVARCHAR(100),
	DAODIEN NVARCHAR(100),
	DIENVIEN NVARCHAR(1000),
	--MALP VARCHAR(10),
	NOIDUNG NVARCHAR(4000),
	NAMSX VARCHAR(10),
	NUOCSX NVARCHAR(100),
	THOILUONG NVARCHAR(100)
	-- DANHGIA INT (SỐ SAO)
	--CONSTRAINT FK_PHIM_MALP FOREIGN KEY(MALP) REFERENCES LOAIPHIM(MALP) ON DELETE CASCADE
)
-- drop table phim

go
  CREATE TABLE THELOAI
(
	MAPHIM VARCHAR(10),
	MALP VARCHAR(10),
	CONSTRAINT PK_THELOAI PRIMARY KEY(MAPHIM,MALP),
	CONSTRAINT FK_THELOAI_MAPHIM FOREIGN KEY(MAPHIM) REFERENCES PHIM(MAPHIM) ON DELETE CASCADE,
	CONSTRAINT FK_THELOAI_MALP FOREIGN KEY(MALP) REFERENCES LOAIPHIM(MALP) ON DELETE CASCADE
)


GO
CREATE TABLE CACHIEU
(
    STT INT IDENTITY,
	MACC VARCHAR(10) PRIMARY KEY,
	TENCC NVARCHAR(100),
	BATDAU TIME,
	KETHUC TIME
	--BATDAU <= THOILUONG <= KETTHUC
)
-- DROP TABLE CACHIEU

GO
CREATE TABLE LICHCHIEU
(
    STT INT IDENTITY,
	NGAYBATDAU DATE,
	NGAYKETTHUC DATE,
	MAPHIM VARCHAR(10),
	MACC VARCHAR(10), -- CA CHIẾU
	MAPC VARCHAR(10),
	CONSTRAINT PK_LICHCHIEU PRIMARY KEY(NGAYBATDAU,MAPHIM,MACC,MAPC),
	CONSTRAINT FK_LICHCHIEU_MAPHIM FOREIGN KEY(MAPHIM) REFERENCES PHIM(MAPHIM) ON DELETE CASCADE,
	CONSTRAINT FK_LICHCHIEU_MACACHIEU FOREIGN KEY(MACC) REFERENCES CACHIEU(MACC) ON DELETE CASCADE,
	CONSTRAINT FK_LICHCHIEU_MAPC FOREIGN KEY(MAPC) REFERENCES PHONGCHIEU(MAPC) ON DELETE CASCADE
)

GO
CREATE TABLE LOAIVE
(
STT INT IDENTITY,
MALV VARCHAR(10) PRIMARY KEY,
TENLV NVARCHAR(100),
--MALP VARCHAR(10),
LOAICHONGOI NVARCHAR(100), -- LOAI CHO NGOI
GIA MONEY
)

GO
CREATE TABLE VE
(
STT INT IDENTITY,
-- MAVE VARCHAR(10) PRIMARY KEY
-- KHÔNG CẦN MÃ VÉ VÌ MỖI KHI COI XONG SẼ K DÙNG VÉ NÀY NỮA, MẤT CÔNG
MAPHIM VARCHAR(10),
MAPC VARCHAR(10),
MALV VARCHAR(10),
SOLUONG INT
CONSTRAINT PK_VE PRIMARY KEY(MAPHIM,MAPC,MALV),
CONSTRAINT FK_VE_MAPHIM FOREIGN KEY(MAPHIM) REFERENCES PHIM(MAPHIM) ON DELETE CASCADE,
CONSTRAINT FK_VE_MALV FOREIGN KEY(MALV) REFERENCES LOAIVE(MALV) ON DELETE CASCADE,
CONSTRAINT FK_VE_MAPC FOREIGN KEY(MAPC) REFERENCES PHONGCHIEU(MAPC) ON DELETE CASCADE
)

go
CREATE TABLE CHONGOI -- CHỖ NGỒI
(
	MAPC VARCHAR(10),
	SOLUONGGHE INT,
	SOLUONGGHE_CONLAI INT
	CONSTRAINT PK_CHONGOI PRIMARY KEY(MAPC,SOLUONGGHE),
	CONSTRAINT FK_CHONGOI_MAPC FOREIGN KEY(MAPC) REFERENCES PHONGCHIEU(MAPC) ON DELETE CASCADE
)

-- table chỗ ngồi : có trạng thái ( đặt, chưa đặt)
go
CREATE TABLE CHITIETCHONGOI -- CHỖ NGỒI
(
    STT INT IDENTITY,
	MAGHE VARCHAR(10),
	TENGHE NVARCHAR(40),
	MAPC VARCHAR(10),
	MALV VARCHAR(10),
	TRANGTHAI NVARCHAR(10) CHECK (TRANGTHAI IN(N'Đặt',N'Chưa đặt')),
	CONSTRAINT PK_CHITIETCHONGOI_MAGHE_MAPC PRIMARY KEY(MAGHE,MAPC),
	CONSTRAINT FK_CHITIETCHONGOI_MAPC FOREIGN KEY(MAPC) REFERENCES PHONGCHIEU(MAPC) ON DELETE CASCADE,
	CONSTRAINT FK_CHITIETCHONGOI_LOAICHONGOI FOREIGN KEY(MALV) REFERENCES LOAIVE(MALV) ON DELETE CASCADE
)
-- drop table CHITIETCHONGOI

GO
CREATE TABLE HOADON
(
STT INT IDENTITY,
SOHD VARCHAR(10) PRIMARY KEY,
NGAY_GIO_HD DATETIME,
MAKH VARCHAR(10),
TONGCONG MONEY,
CONSTRAINT FK_HOADON_MAKH FOREIGN KEY(MAKH) REFERENCES KHACHHANGTHANTHIET(MAKH) ON DELETE CASCADE
)
-- DROP TABLE HOADON

GO
CREATE TABLE CTHD
(
SOHD VARCHAR(10),
MAGHE VARCHAR(10),
MAPC VARCHAR(10),
THANHTIEN MONEY,
CONSTRAINT PK_CTHD PRIMARY KEY(SOHD,MAGHE),
CONSTRAINT FK_CTHD_SOHD FOREIGN KEY(SOHD) REFERENCES HOADON(SOHD) ON DELETE CASCADE,
CONSTRAINT FK_CTHD_MAGHE FOREIGN KEY(MAGHE,MAPC) REFERENCES CHITIETCHONGOI(MAGHE,MAPC) ON DELETE CASCADE
)
-- DROP TABLE CTHD

-- TỰ ĐỘNG CẬP NHẬT THÀNH TIỀN CTHD SAU KHI INSERT
GO
CREATE TRIGGER TRIGGER_UPDATE_THANHTIEN_CTHD ON CTHD
FOR INSERT AS
BEGIN
UPDATE CTHD
SET CTHD.THANHTIEN=(SELECT LV.GIA
                                    FROM LOAIVE LV JOIN CHITIETCHONGOI CTCN ON CTCN.MALV=LV.MALV
									JOIN CTHD ON CTHD.MAGHE = CTCN.MAGHE AND CTHD.MAPC=CTCN.MAPC
									JOIN inserted I ON I.MAGHE=CTCN.MAGHE 
									WHERE CTHD.SOHD=I.SOHD AND CTHD.MAPC=I.MAPC AND I.MAGHE=CTHD.MAGHE)
WHERE EXISTS (SELECT *
               FROM INSERTED 
		       WHERE INSERTED.SOHD=CTHD.SOHD AND CTHD.MAPC=INSERTED.MAPC AND INSERTED.MAGHE=CTHD.MAGHE)-- CHỈ SELECT NHỮNG SP ĐƯỢC XUẤT
END
-- DROP TRIGGER TRIGGER_UPDATE_THANHTIEN_CTHD

GO
CREATE TRIGGER TRIGGER_UPDATE_TONGCONG_HOADON_AFTER_CTHD ON CTHD
-- TĂNG TIỀN TỔNG CỘNG MỖI KHI NHẬP 1 CTHD
AFTER INSERT AS
BEGIN
 UPDATE HOADON
 SET HOADON.TONGCONG=HOADON.TONGCONG+(SELECT CTHD.THANHTIEN
            FROM CTHD, inserted I
			WHERE CTHD.SOHD=HOADON.SOHD AND CTHD.MAGHE=I.MAGHE AND CTHD.MAPC=I.MAPC)
-- AND CTHD.MAGHE=I.MAGHE AND CTHD.MAPC=I.MAPC : tránh lỗi trả về nhiều kết quả khi SOHD='HD1'
 WHERE EXISTS (SELECT *
               FROM INSERTED I,CTHD
		       WHERE I.SOHD=HOADON.SOHD AND CTHD.MAGHE=I.MAGHE AND CTHD.MAPC=I.MAPC)-- CHỈ SELECT NHỮNG SP ĐƯỢC XUẤT
END


GO
create PROC LoadNhanVien
as
begin
SELECT * FROM NHANVIEN ORDER BY STT ASC
end

GO
----PROC THEMNHANVIEN
create PROC Themnhanvien(@manv varchar(10),@hoten NVARCHAR(40),@chucvu NVARCHAR(100),@sdt VARCHAR(20),@gioitinh NVARCHAR(4),
@ngaysinh DATE,@diachi NVARCHAR(100),@luong MONEY,@ngayvl DATE)
as
begin
 insert into NHANVIEN(MANV,HOTEN,CHUCVU,SDT,GIOITINH,NGAYSINH,DIACHI,LUONG,NGAYVL) VALUES (@manv,@hoten,@chucvu,@sdt,@gioitinh,@ngaysinh,@diachi,@luong,@ngayvl)
end

 -----PROC XOANHANVIEN

GO
 CREATE PROC Xoanhanvien(@manv varchar(10) )
 as
 DELETE FROM NHANVIEN 
  WHERE NHANVIEN.MANV=@manv

  GO
  ---PROC SUANHANVIEN
  CREATE PROC Suanhanvien(@manv varchar(10),@hoten NVARCHAR(40),@chucvu NVARCHAR(100),@sdt VARCHAR(20),@gioitinh NVARCHAR(4),
  @ngaysinh DATE,@diachi NVARCHAR(100),@luong MONEY,@ngayvl DATE)
  as
  begin
  update NHANVIEN
  set MANV=@manv,
  HOTEN=@hoten,
  CHUCVU=@chucvu,
  SDT=@sdt,
  GIOITINH=@gioitinh,
  NGAYSINH=@ngaysinh, DIACHI=@diachi,LUONG=@luong,NGAYVL=@ngayvl
  WHERE MANV=@manv
  end

  GO
   -----PROC TIMTHEOMANV
  CREATE PROC Timtheo_manv(@manv varchar(10))
  as
  begin
  select *from NHANVIEN where MANV like '%'+ @manv +'%'
  end
  -- drop PROC Timtheo_manv
  -- exec Timtheo_manv 'NV'

  GO
  ---PROC TIMTHEOHOTEN
  CREATE PROC Timtheo_hoten(@hoten nvarchar(40))
  as
  begin
  select *from NHANVIEN where HOTEN like '%'+ @hoten +'%'
  end

  -- drop proc Timtheo_hoten
  --select *from NHANVIEN where HOTEN like N''
 -- exec Timtheo_hoten N'Trần'
  GO
  -------PROC TIMTHEOSDT
  CREATE PROC Timtheo_sdt(@sdt varchar(20))
  as
  select *from NHANVIEN where SDT like '%'+ @sdt +'%'


GO
  CREATE PROC Dangnhapnhanvien(@user varchar(50),@pass varchar(50))
as SELECT NV.HOTEN,NV.CHUCVU,NV.SDT,DN.TAIKHOAN,DN.MATKHAU FROM DANGNHAP_NHANVIEN DN INNER JOIN NHANVIEN NV ON DN.MANV=NV.MANV
   WHERE DN.TAIKHOAN =@user and DN.MATKHAU=@pass
GO
-- exec Dangnhapnhanvien 'thanhphuong','thanhphuong'

GO
CREATE PROC PhanQuyen(@user varchar(50),@pass varchar(50))
as 
begin
SELECT ND.PHANQUYEN FROM DANGNHAP_NHANVIEN DN INNER JOIN NHANVIEN NV ON DN.MANV=NV.MANV INNER JOIN NGUOIDUNG ND ON ND.MAND=NV.MANV 
WHERE DN.TAIKHOAN =@user and DN.MATKHAU=@pass
end
-- exec PhanQuyen 'thanhphuong','thanhphuong'
GO

GO
create PROC LoadKhachHang
as
begin
SELECT * FROM KHACHHANGTHANTHIET ORDER BY STT ASC
end

GO
---PROC THEMKHACHHANG
create PROC Them_khachhang( @makh varchar(10),@hoten NVARCHAR(40),@diachi NVARCHAR(100),@ngaysinh DATE,@gioitinh nvarchar(4), @sdt varchar(20) ,@loaikh NVARCHAR(50),@ngaydk date)
as
begin
 insert into KHACHHANGTHANTHIET(MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES (@makh,@hoten,@diachi,@sdt,@ngaysinh,@gioitinh,@loaikh,@ngaydk)
end

 GO
 ---EXEC Them_khachhang 'KH101',N'Trần Anh Tuấn',N'142/8/3 Lê Lợi, P.4, Gò Vấp, TP.HCM','0987685085','5/1/1994','Nữ',N'Bạch kim','15/5/2018'
----PROC XOAKHACHAHANG
 CREATE PROC Xoakhachhang(@makh varchar(10) )
 as
 DELETE FROM KHACHHANGTHANTHIET
  WHERE KHACHHANGTHANTHIET.MAKH=@makh

  GO
  ---PROC SUANHANVIEN
  CREATE PROC Suakhachhang(@makh varchar(10),@hoten NVARCHAR(40),@diachi NVARCHAR(100),@ngaysinh DATE,@gioitinh nvarchar(4), @sdt varchar(20) ,@loaikh NVARCHAR(50),@ngaydk date)
as
begin
update KHACHHANGTHANTHIET
  set MAKH=@makh,
  HOTEN=@hoten,
  DIACHI=@diachi,
  NGAYSINH=@ngaysinh,
  NGAYDK=@ngaydk,
  GIOITINH=@gioitinh,
  SDT=@sdt,
  LOAIKH=@loaikh
  WHERE MAKH=@makh
end

 GO
---PROC TIMTHEOHOTEN
  CREATE PROC Timkhachhang_hoten(@hoten nvarchar(40))
  as
begin
 select * from KHACHHANGTHANTHIET where HOTEN like '%'+ @hoten +'%'
end

-- drop proc Timkhachhang_hoten
-- exec Timkhachhang_hoten N'Nguyễn'
GO
----PROC TIMTHEOsdt
CREATE PROC Timkhachhang_sdt(@sdt varchar(20))
as 
begin
 select *from KHACHHANGTHANTHIET where SDT like '%'+ @sdt +'%'
 end

GO
----PROC TIMTHEOmakh
CREATE PROC Timkhachhang_makh(@makh varchar(10))
as begin
select *from KHACHHANGTHANTHIET where MAKH like '%'+ @makh +'%'
end

GO
CREATE PROC PhanLoaiKH(@user varchar(50),@pass varchar(50))
as 
begin
 SELECT KH.LOAIKH,DN.TAIKHOAN,DN.MATKHAU FROM DANGNHAP_KHACHHANG DN INNER JOIN KHACHHANGTHANTHIET KH ON DN.MAKH=KH.MAKH
   WHERE DN.TAIKHOAN =@user and DN.MATKHAU=@pass
end
 
GO
CREATE PROC Dangnhapkhachhang(@user varchar(50),@pass varchar(50))
as
begin
 SELECT KH.MAKH,KH.HOTEN,KH.LOAIKH,KH.SDT,DN.TAIKHOAN,DN.MATKHAU FROM DANGNHAP_KHACHHANG DN INNER JOIN KHACHHANGTHANTHIET KH ON DN.MAKH=KH.MAKH
   WHERE DN.TAIKHOAN =@user and DN.MATKHAU=@pass
end
-- drop proc Dangnhapkhachhang
GO
CREATE PROC TaoTaiKhoanKH(@makh varchar(10),@user varchar(50),@pass varchar(50))
as
begin
insert into DANGNHAP_KHACHHANG VALUES (@makh,@user,@pass)
end
-- EXEC TaoTaiKhoanKH 'KH6','thanhphuong','thanhphuong'
-- SELECT * FROM DANGNHAP_KHACHHANG

go
----PROC THEMNGUOIDUNG
create PROC ThemNguoiDung(@mand varchar(10),@hoten NVARCHAR(40),@chucvu NVARCHAR(100),@phanquyen NVARCHAR(100))
as
begin
 insert into NGUOIDUNG(MAND,HOTEN,CHUCVU,PHANQUYEN) VALUES (@mand,@hoten,@chucvu,@phanquyen)
 end

 go
 -----PROC XOANGUOIDUNG
 CREATE PROC XoaNguoiDung(@mand varchar(10))
 as
 begin
 DELETE FROM NGUOIDUNG 
  WHERE NGUOIDUNG.MAND=@mand
end

-- exec XoaNguoiDung 'NV1'

  go
  ---PROC SUANGUOIDUNG
  CREATE PROC SuaNguoiDung(@mand varchar(10),@hoten NVARCHAR(40),@chucvu NVARCHAR(100),@phanquyen NVARCHAR(100))
  as
  begin
  update NGUOIDUNG
  set MAND=@mand,
  HOTEN=@hoten,
  CHUCVU=@chucvu,
  PHANQUYEN=@phanquyen
  WHERE MAND=@mand
  end

  go
   -----PROC TIMTHEOMAND
  CREATE PROC TimTheoMaND(@mand varchar(10))
  as
  begin
  select *from NGUOIDUNG where MAND like '%'+ @mand +'%'
  end
  -- drop PROC Timtheo_manv
  -- exec TimTheoMaND 'NV1'

  go
  ---PROC TIMTHEOHOTENNGUOIDUNG
  CREATE PROC TimTheoHoTenNguoiDung(@hoten nvarchar(40))
  as
  begin
  select *from NGUOIDUNG where HOTEN like '%'+ @hoten +'%'
  --select * from NHANVIEN where lower(HOTEN) like '%' + lower(RTRIM(@hoten)) + '%'
  end

 go
create proc LoadDSPhongChieu
as 
begin 
select * from PHONGCHIEU ORDER BY STT ASC
end

go
----PROC ThemPhongChieu
create PROC ThemPhongChieu(@mapc varchar(10),@tenpc NVARCHAR(40),@socho INT,@maychieu NVARCHAR(100), @loa NVARCHAR(100), @dientich INT, @tinhtrang NVARCHAR(20), @trangthietbikhac NVARCHAR(100))

as
begin
 insert into PhongChieu(MAPC,TENPC,SOCHO,MAYCHIEU,LOA,DIENTICH,TINHTRANG,TRANGTHIETBIKHAC) VALUES (@mapc,@tenpc,@socho,@maychieu,@loa,@dientich,@tinhtrang,@trangthietbikhac)
 end

 go
 -----PROC XoaPhongChieu
 CREATE PROC XoaPhongChieu(@mapc varchar(10))
 as
 begin
 DELETE FROM PHONGCHIEU
  WHERE PHONGCHIEU.MAPC=@mapc
end

-- exec XoaPhongChieu 'NV1'

  go
  ---PROC SuaPhongChieu
  CREATE PROC SuaPhongChieu(@mapc varchar(10),@tenpc NVARCHAR(40),@socho INT,@maychieu NVARCHAR(100), @loa NVARCHAR(100), @dientich INT, @tinhtrang NVARCHAR(20), @trangthietbikhac NVARCHAR(100))
  as
  begin
  update PHONGCHIEU
  set MAPC=@mapc,
  TENPC=@tenpc,
  SOCHO=@socho,
  MAYCHIEU=@maychieu,
  LOA=@loa,
  DIENTICH=@dientich,
  TINHTRANG=@tinhtrang,
  TRANGTHIETBIKHAC=@trangthietbikhac
  WHERE MAPC=@mapc
  end

  go
   -----PROC TIMTHEOMAPC
  CREATE PROC TimTheoMaPC(@mapc varchar(10))
  as
  begin
  select * from PHONGCHIEU where MAPC like '%'+ @mapc +'%'
  end
  -- drop PROC Timtheo_manv
  -- exec TimTheomapc 'NV1'

  go
  ---PROC TIMTHEOtenpc
  CREATE PROC TimTheoTenPhongChieu(@tenpc nvarchar(40))
  as
  begin
  select * from PhongChieu where TENPC like '%'+ @tenpc +'%'
  --select * from NHANVIEN where lower(tenpc) like '%' + lower(RTRIM(@tenpc)) + '%'
  end

  go
create proc LoadLoaiPhim
as 
begin 
select * from LOAIPHIM ORDER BY STT ASC
end

--  exec LoadLoaiPhim
go
CREATE PROC Themloaiphim(@malp varchar(10),@tenlp nvarchar(40),@mota nvarchar(1000))
as
begin 
insert into LOAIPHIM(MALP,TENLP,MOTA) values (@malp,@tenlp,@mota)
end
go
---PROC SUALOAIPHIM
CREATE PROC Sualoaiphim(@malp varchar(10),@tenlp nvarchar(40),@mota nvarchar(1000))
as
begin
update LOAIPHIM
set MALP=@malp,TENLP=@tenlp,MOTA=@mota
where MALP=@malp
end 
go
---proc Xoaphongchieu
create proc Xoaloaiphim(@malp varchar(10))
as 
begin
delete from LOAIPHIM where MALP=@malp
end
go
---PROC TIMTHEOMALP
CREATE PROC TimTheoMaLP(@malp varchar(10))
  as
  begin
  select * from LOAIPHIM where MALP like '%'+ @malp +'%'
  end

  go
  ---proc tìm theo tên loại phim
CREATE PROC TimTheoTenlp(@tenlp nvarchar(40))
  as
  begin
  select * from LOAIPHIM where TENLP like '%'+ @tenlp +'%'
  end

go
create proc LoadPhim
as 
begin 
select *
from PHIM 
 ORDER BY STT ASC
end

go
create proc LoadTheLoaiPhim(@MAPHIM VARCHAR(10))
as 
begin 
select PHIM.MAPHIM,LP.TENLP
from PHIM JOIN THELOAI TL ON TL.MAPHIM=PHIM.MAPHIM
JOIN LOAIPHIM LP ON LP.MALP=TL.MALP
WHERE PHIM.MAPHIM=@MAPHIM
end
-- EXEC LoadTheLoaiPhim 'PHIM1'

go
---PROC Themphim
create proc Themphim(@map varchar(10) ,@tenphim nvarchar(40),@daodien nvarchar(100),@dienvien nvarchar(100),@noidung nvarchar(1000),@namsx varchar(10),@nuocsx nvarchar(100),@thoiluong nvarchar(100))
as
begin
insert into PHIM(MAPHIM,TENPHIM,DAODIEN,DIENVIEN,NOIDUNG,NAMSX,NUOCSX,THOILUONG) values(@map,@tenphim,@daodien,@dienvien,@noidung,@namsx,@nuocsx,@thoiluong)
end 
go
---proc Suaphim
create proc Suaphim(@map varchar(10) ,@tenphim nvarchar(40),@daodien nvarchar(100),@dienvien nvarchar(100),@malp varchar(10),@noidung nvarchar(1000),@namsx varchar(10),@nuocsx nvarchar(100),@thoiluong nvarchar(100))
as
begin
update PHIM
set MAPHIM=@map,TENPHIM=@tenphim,DAODIEN=@daodien,
DIENVIEN=@dienvien,NOIDUNG=@noidung,NAMSX=@namsx,NUOCSX=@nuocsx,THOILUONG=@thoiluong
where MAPHIM=@map
end 
go
--exec Suaphim 'PHIM1',N'Quái Vật Venomn',N'Ruben Fleischer',N'Tom Hardy, Michelle William, Riz Ahmed','LP1',N'Quái Vật Venom là một kẻ thù nguy hiểm và nặng ký của Người nhện trong loạt series của Marvel. Chàng phóng viên Eddie Brock (do Tom Hardy thủ vai) bí mật theo dõi âm mưu xấu xa của một tổ chức và đã không may mắn khi nhiễm phải loại cộng sinh trùng ngoài hành tinh (Symbiote) và từ đó đã không còn làm chủ bản thân về thể chất lẫn tinh thần. Điều này đã dần biến anh thành quái vật đen tối và nguy hiểm nhất chống lại người Nhện - Venom','2018',N'Mỹ','115 phút'
---proc Xoaphim
create proc Xoaphim(@map varchar(10))
as begin
delete from PHIM where MAPHIM=@map 
end
go
---proc Timtheo ma phim
CREATE PROC TimTheoMaP(@map varchar(10))
  as
  begin
  select * from PHIM where MAPHIM like '%'+ @map +'%'
  end
  go
  -- exec TimTheoMaP 'PHIM1'
  CREATE PROC TimTheoTenP(@tenp varchar(10))
  as
  begin
  select * from PHIM where TENPHIM like '%'+ @tenp +'%'
  end

go
  CREATE PROC LoadDSCaChieu
  as
  BEGIN
  select * from CACHIEU ORDER BY STT ASC
  END

go
--Thêm ca chiếu
CREATE PROC ThemCaChieu(@macc varchar(10),@tencc nvarchar(100),@batdau time,@kethuc time)
as
begin
insert into CACHIEU(MACC,TENCC,BATDAU,KETHUC) values(@macc,@tencc,@batdau,@kethuc)
end

GO
---Sửa ca chiếu
CREATE PROC SuaCaChieu(@macc varchar(10),@tencc nvarchar(100),@batdau time,@kethuc time)
as
begin
update CACHIEU
set MACC=@macc,TENCC=@tencc,BATDAU=@batdau,KETHUC=@kethuc where MACC=@macc
end

go
---Xóa ca chiếu
create proc XoaCaChieu(@macc varchar(10))
as
begin
delete from CACHIEU where MACC=@macc
end


go
---proc TIMTHEO MA CC
CREATE PROC TimTheoMacc(@macc varchar(10))
as
begin
select *from CACHIEU where MACC like '%'+ @macc +'%'
end

-- exec TimTheoMacc '2'

go
--proc Tim theo ten cc
create proc TimTheoTencc(@tencc nvarchar(100))
as 
begin
select* from CACHIEU where TENCC like '%'+ @tencc +'%'
end

go
CREATE PROC HienLichChieuPhim(@ngaychieu date,@macc varchar(10))
  as
  BEGIN
SELECT pc.TENPC,LC.NGAYBATDAU,CC.BATDAU,cc.KETHUC,TENPHIM
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
where lc.NGAYBATDAU=@ngaychieu  and CC.MACC=@macc
order by pc.MAPC asc
end
-- drop proc HienLichChieuPhim_8_10
-- exec LoadDSLichChieu
--  SET DATEFORMAT MDY 
--  EXEC HienLichChieuPhim '1/5/2020 12:00:00 AM','CC1'
--  EXEC HienLichChieuPhim '1/6/2020 12:00:00 AM','CC4'
-- EXEC LoadDSCaChieu
go
 CREATE PROC HienLichChieuPhim_NgayChieu_MaCC_MaPC(@ngaychieu date,@macc varchar(10),@mapc varchar(10))
  as
  BEGIN
SELECT pc.TENPC,LC.NGAYBATDAU,CC.BATDAU,cc.KETHUC,TENPHIM
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
where lc.NGAYBATDAU=@ngaychieu  and CC.MACC=@macc and pc.MAPC=@mapc
end

go
CREATE PROC DatVe_Phim_NgayChieu(@maphim varchar(10),@ngaychieu datetime)
as
BEGIN
SELECT pc.MAPC,PC.TENPC,LC.NGAYBATDAU,CC.MACC,CC.BATDAU,CC.KETHUC,CN.SOLUONGGHE_CONLAI
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
JOIN CHONGOI CN ON CN.MAPC=LC.MAPC
where LC.MAPHIM=@maphim AND LC.NGAYBATDAU=@ngaychieu
END
-- drop proc DatVe_Phim_NgayChieu
--  EXEC DatVe_Phim_NgayChieu 'PHIM1','5/1/2020 12:00:00 AM'

go
CREATE PROC DatVe_Load_ChonChoNgoi(@maphim varchar(10),@ngaychieu datetime,@macc varchar(10))
as
BEGIN
SELECT pc.TENPC,CC.BATDAU,CC.KETHUC,TENPHIM,PC.MAPC
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
JOIN CHONGOI CN ON CN.MAPC=LC.MAPC
where LC.MAPHIM=@maphim AND LC.NGAYBATDAU=@ngaychieu AND LC.MACC=@macc
END
-- drop proc DatVe_Load_ChonChoNgoi
--  EXEC DatVe_Load_ChonChoNgoi 'PHIM1','5/1/2020 12:00:00 AM','CC1'
-- select * from lichchieu
go
  CREATE PROC LoadDSLichChieu
  as
  BEGIN
  SELECT LC.STT,LC.NGAYBATDAU,TENPHIM,TENPC,TENCC,LC.MAPHIM,LC.MACC,LC.MAPC
 FROM LICHCHIEU LC INNER JOIN PHIM ON LC.MAPHIM=PHIM.MAPHIM
 INNER JOIN PHONGCHIEU PC ON LC.MAPC=PC.MAPC
 INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
 ORDER BY NGAYBATDAU ASC
END
-- drop proc LoadDSLichChieu
GO
CREATE PROC LoadDSNgayChieu
AS
BEGIN
 SELECT NGAYBATDAU
 FROM LICHCHIEU 
 GROUP BY NGAYBATDAU
 ORDER BY NGAYBATDAU ASC
END

go
---proc Them lich chieu
create proc ThemLichChieu(@ngaychieu date,@maphim varchar(10),@macc varchar(10),@mapc varchar(10))
as
begin
insert into LICHCHIEU(NGAYBATDAU,MAPHIM,MACC,MAPC) values (@ngaychieu,@maphim,@macc,@mapc)
end

go
---proc Sua lich chieu
create proc SuaLichChieu(@ngaychieu date,@maphim varchar(10),@macc varchar(10),@mapc varchar(10))
as
begin
update LICHCHIEU
set
NGAYBATDAU=@ngaychieu
where MACC=@macc and MAPHIM=@maphim and MAPC=@mapc
end

--update LICHCHIEU
--set
--NGAYBATDAU='4/5/2000'
--where MACC='CC1' and MAPHIM='PHIM1' and MAPC='PC1'
-- select * from Lichchieu
-- exec SuaLichChieu '10/10/2000','PHIM1','CC1','PC1'

go
create proc XoaLichChieu(@ngaychieu date,@maphim varchar(10),@macc varchar(10),@mapc varchar(10))
as 
begin
set dateformat mdy
delete from LICHCHIEU 
where NGAYBATDAU=@ngaychieu and MACC=@macc and MAPHIM=@maphim and MAPC=@mapc
end


-- exec XoaLichChieu '8/6/2020','PHIM1','CC1','PC1'
--delete from LICHCHIEU 
--where NGAYBATDAU='20/10/2000' and MACC='CC1' and MAPHIM='PHIM1' and MAPC='PC1'

go
create proc LichChieu_TimTheoNgayChieu(@tungay date,@denngay date)
as 
begin
set dateformat dmy
SELECT * FROM LICHCHIEU
WHERE NGAYBATDAU >= @tungay and NGAYBATDAU <= @denngay 
end
-- drop proc LichChieu_TimTheoNgayChieu
-- exec LichChieu_TimTheoNgayChieu '6/1/2020','6/3/2020'

go
  CREATE PROC LoadDSLoaiVe
  as
  BEGIN
  select *from LOAIVE ORDER BY STT ASC
  END
-- exec LoadDSLoaiVe
go
----PROC Them loai ve
create PROC ThemLoaiVe(@malv varchar(10),@tenlv NVARCHAR(100),@loaichongoi NVARCHAR(100),@gia MONEY)
as
begin
 insert into LOAIVE(malv,tenlv,loaichongoi,gia) VALUES (@malv,@tenlv,@loaichongoi,@gia)
end

go
----PROC Them loai ve
create PROC SuaLoaiVe(@malv varchar(10),@tenlv NVARCHAR(100),@loaichongoi NVARCHAR(100),@gia MONEY)
as
begin
 UPDATE LOAIVE 
 SET MALV=@malv,TENLV=@tenlv,LOAICHONGOI=@loaichongoi,GIA=@gia WHERE MALV=@malv
end 

GO
---proc Xoa loai ve
create proc XoaLoaiVe(@malv varchar(10))
as 
begin
delete from LOAIVE where MALV=@malv
end

go
   -----PROC tim theo ma loai ve
  CREATE PROC TimTheoMaLV(@malv varchar(10))
  as
  begin
  select * from LOAIVE where MALV like '%'+ @malv +'%'
  end
-- exec TimTheoMaLV 'LV1'
go
 -----PROC tim theo ma loai ve
  CREATE PROC TimTheoTenLV(@tenlv NVARCHAR(100))
  as
  begin
  select * from LOAIVE where TENLV like '%'+ @tenlv +'%'
  end

GO
 ------- LOAD DANH SÁCH VÉ
 CREATE PROC LoadDSVe
 as
 BEGIN
 SELECT VE.STT,TENPHIM,TENPC,TENLV,SOLUONG,VE.MAPHIM,VE.MAPC,VE.MALV
 FROM VE INNER JOIN PHIM ON VE.MAPHIM=PHIM.MAPHIM
 INNER JOIN PHONGCHIEU PC ON VE.MAPC=PC.MAPC
 INNER JOIN LOAIVE LV ON VE.MALV=LV.MALV
 END

 go
----THÊM VÉ
create PROC ThemVe(@maphim varchar(10),@mapc varchar(10),@malv varchar(10),@soluong int)
as
begin
insert into VE(MAPHIM,MAPC,MALV,SOLUONG) VALUES (@maphim,@mapc,@malv,@soluong)
end

go
----SỬA VÉ
create PROC SuaVe(@maphim varchar(10),@mapc varchar(10),@malv varchar(10),@soluong int)
as
begin
 UPDATE VE
 SET MAPHIM=@maphim, MAPC=@mapc, MALV=@malv,SOLUONG=@soluong
 WHERE MAPHIM=@maphim and MAPC=@mapc and MALV=@malv
end 

GO
---Xóa vé
create proc XoaVe(@maphim varchar(10),@mapc varchar(10),@malv varchar(10))
as 
begin
delete from VE where MAPHIM=@maphim and MAPC=@mapc and MALV=@malv
end

--EXEC XoaVe 'PHIM1','PC1','LV1'

---Vé: Tìm theo tên phim
GO
CREATE PROC Ve_TimTheoTenPhim(@tenphim nvarchar(1000))
  as
  begin
 SELECT VE.STT,TENPHIM,TENPC,TENLV,SOLUONG,VE.MAPHIM,VE.MAPC,VE.MALV
 FROM VE INNER JOIN PHIM ON VE.MAPHIM=PHIM.MAPHIM
 INNER JOIN PHONGCHIEU PC ON VE.MAPC=PC.MAPC
 INNER JOIN LOAIVE LV ON VE.MALV=LV.MALV
 where PHIM.TENPHIM like '%'+ @tenphim +'%'
  end

-- exec Ve_TimTheoTenPhim N'Quái'

---Vé: Tìm theo tên phòng chiếu
GO
CREATE PROC Ve_TimTheoTenPC(@tenpc nvarchar(100))
  as
  begin
 SELECT VE.STT,TENPHIM,TENPC,TENLV,SOLUONG,VE.MAPHIM,VE.MAPC,VE.MALV
 FROM VE INNER JOIN PHIM ON VE.MAPHIM=PHIM.MAPHIM
 INNER JOIN PHONGCHIEU PC ON VE.MAPC=PC.MAPC
 INNER JOIN LOAIVE LV ON VE.MALV=LV.MALV
 WHERE PC.TENPC like '%'+ @tenpc +'%'
  end
--  exec Ve_TimTheoTenPC N'1'

---Vé: Tìm theo tên loại vé
GO
CREATE PROC Ve_TimTheoTenLV(@tenlv nvarchar(100))
  as
  begin
 SELECT VE.STT,TENPHIM,TENPC,TENLV,SOLUONG,VE.MAPHIM,VE.MAPC,VE.MALV
 FROM VE INNER JOIN PHIM ON VE.MAPHIM=PHIM.MAPHIM
 INNER JOIN PHONGCHIEU PC ON VE.MAPC=PC.MAPC
 INNER JOIN LOAIVE LV ON VE.MALV=LV.MALV
 WHERE LV.TENLV like '%'+ @tenlv +'%'
  end
--  exec Ve_TimTheoTenLV N'vip'

---Vé: Tìm theo tên loại vé
GO
CREATE PROC Ve_TimTheoSoLuong(@soluong int)
  as
  begin
 SELECT VE.STT,TENPHIM,TENPC,TENLV,SOLUONG,VE.MAPHIM,VE.MAPC,VE.MALV
 FROM VE INNER JOIN PHIM ON VE.MAPHIM=PHIM.MAPHIM
 INNER JOIN PHONGCHIEU PC ON VE.MAPC=PC.MAPC
 INNER JOIN LOAIVE LV ON VE.MALV=LV.MALV
 WHERE VE.SOLUONG>= @soluong-100 AND VE.SOLUONG <= @soluong + 100
 end
--  exec Ve_TimTheoSoLuong '200'
GO
 CREATE PROC DatVe_LoadDSChoNgoi(@mapc varchar(10))
 as
 BEGIN
 SELECT *
 FROM CHITIETCHONGOI CTCN 
 WHERE CTCN.MAPC=@mapc
 ORDER BY STT ASC
 END
-- exec DatVe_LoadDSChoNgoi 'PC1'

GO
CREATE PROC LoadDSHoaDon
AS
BEGIN
 SELECT *
 FROM HOADON
 ORDER BY STT ASC
END

GO
CREATE PROC HienThiChiTietHoaDon(@sohd varchar(10))
AS
BEGIN
SELECT LV.TENLV,COUNT(CTHD.MAGHE)
--SELECT *
FROM CTHD JOIN CHITIETCHONGOI CTCN ON CTHD.MAGHE=CTCN.MAGHE AND CTHD.MAPC=CTCN.MAPC
JOIN LOAIVE LV ON LV.MALV=CTCN.MALV
WHERE CTHD.SOHD=@sohd
GROUP BY LV.TENLV
END

GO
SET DATEFORMAT DMY 
INSERT INTO NHANVIEN VALUES ('NV1',N'Trần Nguyễn Thanh Phương',N'Quản trị','098269245',N'Nữ','22/10/1960',N'1/4 Linh Xuân , Thủ Đức, TPHCM',100000000,'10/10/2017')
INSERT INTO NHANVIEN VALUES ('NV2',N'Nguyễn Thiên Hương',N'Nhân viên quản lý phim','0982692456',N'Nữ','22/1/1980',N'12/4 Linh Xuân , Thủ Đức, TPHCM',100000000,'10/10/2017')
INSERT INTO NHANVIEN VALUES ('NV3',N'Trần Nguyễn Trung Quân',N'Nhân viên quản lý phòng chiếu','0982692457','Nam',N'15/10/1982',N'16/4 Linh Xuân , Thủ Đức, TPHCM',100000000,'10/10/2017')
INSERT INTO NHANVIEN VALUES ('NV4',N'Trần Thanh',N'Nhân viên quản lý lịch chiếu','0982692458',N'Nữ','19/11/1972',N'199/4 Linh Trung , Thủ Đức, TPHCM',100000000,'11/10/2017')
INSERT INTO NHANVIEN VALUES ('NV5',N'Nguyễn Thanh Phương',N'Nhân viên quản lý vé','0982692459',N'Nữ','23/11/1990',N'100/7 Linh Trung , Thủ Đức, TPHCM',100000000,'12/8/2017')
INSERT INTO NHANVIEN VALUES ('NV6',N'Trần Thanh Nhàn',N'Nhân viên bán vé','0982692451',N'Nữ','13/6/1978',N'1/4 Linh Tây , Thủ Đức, TPHCM',100000000,'11/2/2017')
--INSERT INTO NHANVIEN VALUES ('NV7',N'Trần Đức Minh',N'Quản Lý','0982692145','Nam','3/4/1974',N'12/5 Linh Tây, Thủ Đức, TPHCM',20000000,'10/11/2017')
--INSERT INTO NHANVIEN VALUES ('NV8',N'Nguyễn Trung Kiên',N'Nhân Viên Bán Hàng','0982692124','Nam','12/6/1980',N'123A Q9 , TPHCM',100000000,'15/2/2017')
--INSERT INTO NHANVIEN VALUES ('NV9',N'Nguyễn Đức Quốc',N'Nhân Viên Bán Hàng','0982692123','Nam','9/3/1970',N'123/45 Linh Trung, Thủ Đức, TPHCM',10000000,'10/11/2017')
--INSERT INTO NHANVIEN VALUES ('NV10',N'Trần Thị Mai Tính',N'Nhân Viên Bán Hàng','0962482746',N'Nữ','10/3/1980',N'12/5 Linh Xuân, Thủ Đức, TPHCM',10000000,'10/8/2017')
--INSERT INTO NHANVIEN VALUES ('NV11',N'Lương Công Hải',N'Nhân Viên Vệ Sinh','0927384721','Nam','10/1/1981',N'13/4 Linh Tây, Thủ Đức, TPHCM',5000000,'10/1/2017')
--INSERT INTO NHANVIEN VALUES ('NV12',N'Trần Viễn',N'Nhân Viên Bán Hàng','0948693723',N'Nữ','3/9/1979',N'12A/45 Trảng Bom, Đồng Nai',10000000,'8/2/2017')
--INSERT INTO NHANVIEN VALUES ('NV13',N'Trần Nguyễn Thanh Trúc',N'Quản Lý','0927384951',N'Nữ','2/5/1983',N'123/45 Quận 1, TPHCM',20000000,'20/1/2017')
--INSERT INTO NHANVIEN VALUES ('NV14',N'Phạm Ngọc Anh Tín',N'Giám Đốc','09463859371','Nam','15/10/1985',N' Quận 1, TPHCM',0,'10/12/2017')
--INSERT INTO NHANVIEN VALUES ('NV15',N'Nguyễn Hà ',N'Thủ Kho','0985472849',N'Nữ','31/12/1981',N'100/35 Linh Tây, Thủ Đức, TPHCM',15000000,'17/11/2017')
--INSERT INTO NHANVIEN VALUES ('NV16',N'Phạm Thanh Thiên Trúc',N'Thủ Kho','0982285392',N'Nữ','6/4/1971',N'121/5 Lê Đại Hành , Quận Bình Thạnh, TPHCM',15000000,'15/12/2017')
--INSERT INTO NHANVIEN VALUES ('NV17',N'Phạm Ngọc Anh',N'Thủ Kho','0903958271','Nam','25/10/1995',N'119 Tôn Thất Đạm, P. Bến Nghé, Quận 1, TP. HCM',150000000,'13/6/2017')
--INSERT INTO NHANVIEN VALUES ('NV18',N'Nguyễn Ngọc Quý',N'Thủ Kho','0957263689','Nam','15/10/1996',N'12 Tôn Thất Tùng, P. Bến Nghé, Quận 3, TP. HCM',150000000,'8/7/2017')
--INSERT INTO NHANVIEN VALUES ('NV19',N'Ngô Thanh Trọng',N'Thủ Kho','0957676689','Nam','28/3/1993',N'67/4/118 Vũ Huy Tấn, P. 3,  Quận Bình Thạnh, TP. HCM',150000000,'12/7/2017')
--INSERT INTO NHANVIEN VALUES ('NV20',N'Nguyễn Duy Thành',N'Thủ Kho','0953857361','Nam','21/5/1991',N'181/2 Đường 3 Tháng 2,  Quận 10, TP. HCM',150000000,'22/1/2017')

go
INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV1','thanhphuong','thanhphuong')
INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV2','thienhuong','thienhuong')
INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV3','trungquan','trungquan')
INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV4','tranthanh','tranthanh')
INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV5','nthanhphuong','nthanhphuong')
INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV6','thanhnhan','thanhnhan')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV7','ducminh','ducminh')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV8','trungkien','trungkien')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV9','ducquoc','ducquoc')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV10','maitinh','maitinh')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV15','nguyenha','nguyenha')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV16','thientruc','thientruc')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV11','conghai','conghai')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV12','tranvien','tranvien')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV13','thanhtruc','thanhtruc')
--INSERT INTO DANGNHAP_NHANVIEN VALUES ('NV14','anhtin','anhtin')



GO
INSERT INTO KHACHHANGTHANTHIET (MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES 
('KH1',N'Nguyễn Văn An',N'731 Trần Hưng Đạo, Q5, TpHCM','08823451','22/10/1960','Nam',N'Bạc','22/07/2018'),
('KH2',N'Trần Ngọc Hân',N'23/5 Nguyễn Trãi, Q5, TpHCM','0908256478','3/4/1974',N'Nữ',N'Vàng','30/07/2018'),
('KH3',N'Trần Ngọc Linh',N'45 Nguyen Tất Thành, Q1, TpHCM','0938776266','12/6/1980',N'Nữ',N'Đồng','05/08/2018'),
('KH4',N'Trần Minh Long',N'50/34 Lê Đại Hành, Q10, TpHCM','0917325476','9/3/1965','Nam',N'Đồng','02/10/2017')
--('KH5',N'Lê Nhật Minh',N'34 Trương Định, Q3, TpHCM','08246108','10/3/1950','Nam',N'Bạc','28/10/2018'),
--('KH6',N'Lê Hoài Thương',N'227 Nguyễn Văn Cừ,Q5,TpHCM','08631738','31/12/1981',N'Nữ',N'Vàng','4/10/2018'),
--('KH7',N'Nguyễn Văn Tám',N'32/3 Trần Bình Trọng, Q5, TpHCM','0916783565','6/4/1971','Nam',N'Đồng','3/4/2018'),
--('KH8',N'Phan Thị Thanh',N'45/2 An Dương Vương, Q5, TpHCM','0938435756','10/1/1971',N'Nữ',N'Đồng','3/10/2017'),
--('KH9',N'Lê Hà Vinh',N'873 Lê Hồng Phong, Q5, TpHCM','08654763','3/9/1979','Nam',N'Bạc','2/10/2018'),
--('KH10',N'Hà Duy Lập',N'34/34B Nguyễn Trãi, Q1, TpHCM','08768904','2/5/1983','Nam',N'Đồng','28/1/2018'),
--('KH11',N'Qua Văn Cầu',N'50/34 Nguyễn Thị Minh Khai, Q10, TpHCM','0917325472','9/5/1975','Nam',N'Bạc','15/12/2018'),
--('KH12',N'Trương Minh Điền',N'36 Trương Định, Q5, TpHCM','082461089','10/3/1990','Nam',N'Bạch kim','5/9/2017'),
--('KH13',N'Lê Hoài Nam',N'227/2 Nguyễn Văn Cừ,Q5,TpHCM','086317380','31/10/1981','Nam',N'Kim cương','21/4/2018'),
--('KH14',N'Nguyễn Văn Long',N'32/3 Lương Định Của, Q5, TpHCM','0916735650','6/4/1980','Nam',N'Bạch kim','28/8/2018'),
--('KH15',N'Phan Thị Thanh Nhàn',N'12/2 An Dương Vương, Q6, TpHCM','0948435756','10/12/1972',N'Nữ',N'Bạc','5/10/2018'),
--('KH16',N'Trần Khôi Nguyên',N'873 Trần Đại Nghĩa, Q5, TpHCM','086547632','12/4/1997','Nam',N'Kim cương','15/4/2018')
--INSERT INTO KHACHHANGTHANTHIET (MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES 
--('KH17',N'Bùi Minh Hiếu',N'34 Phạm Ngũ Lão, Q10, TpHCM','087689304','24/9/1984','Nam',N'Bạch kim','11/12/2018'),
--('KH18',N'Lê Đức Thắng',N'104 CMT8, Q11, TpHCM','08654763','20/10/2000','Nam',N'Đồng','13/2/2018'),
--('KH19',N'Phạm Công Minh',N'1 Nguyễn Trãi, Q8, TpHCM','087689042','5/6/1977','Nam',N'Bạc','2/5/2018'),
--('KH20',N'Trần Trung Nghĩa',N'50 Nguyễn Thị Minh Khai, Q10, TpHCM','0917325272','12/1/1975','Nam',N'Đồng','31/12/2018'), ('KH21',N'Lê Trọng Hiếu',N'32 Võ Thị Sáu, Bình Thạnh, TpHCM','082431089','10/4/1995','Nam',N'Bạc','12/11/2018'),
--('KH22',N'Lê Hoài Nam',N'227/2 Nguyễn Thị Minh Khai,Q7,TpHCM','086323480','22/11/1982','Nam',N'Vàng','25/4/2018'),
--('KH23',N'Nguyễn Hồng Phương Nhi',N'25 Tôn Đức Thắng, Gò Vấp, TpHCM','091621350','5/6/1995',N'Nữ',N'Bạch kim','10/5/2018'),
--  ('KH24',N'Phan Thanh Nhàn',N'30/4 Bến Vân Đồn, Q6, TpHCM','0941233756','10/12/1982',N'Nữ',N'Đồng','22/7/2018'),
--  ('KH25',N'Trần Nguyễn Hoàng Quý',N'123 Linh Trung , Thủ Đức','0236547632','12/4/1997','Nam',N'Đồng','30/5/2018'),
--  ('KH26',N'Trần Long',N'12/4 Linh Tây, Thủ Đức, TpHCM','087689214','3/6/1978','Nam',N'Vàng','10/3/2018'),
--  ('KH27',N'Nguyễn Tự Long',N'3 Trần Đại Nghĩa, Q7, TpHCM','09167231650','3/6/1997','Nam',N'Bạch kim','20/5/2018'),
--  ('KH28',N'Đào Như ý',N'15/2 An Dương Vương, Q6, TpHCM','0943125756','12/10/1982',N'Nữ',N'Vàng','10/1/2018'),
--  ('KH29',N'Trần Khôi Ngô Tuấn Tú',N'231 Trần Đại Nghĩa, Q5, TpHCM','086521332','14/4/1997','Nam',N'Bạc','28/5/2018'),
--  ('KH30',N'Phan Hải Đăng',N'34/34 Lý Thái Tổ , Q10, TpHCM','097622104','20/5/1999','Nam',N'Đồng','29/4/2018'),
--  ('KH31',N'Hà Đức Huy',N'61 Quang Trung, P. 10, Gò Vấp, TP. HCM','0983295462','16/5/1999','Nam',N'Vàng','23/11/2018'),
--  ('KH32',N'Phạm Thị Quỳnh Mai',N'58 Hữu Nghị, P. Bình Thọ, Thủ Đức, TP. HCM','0916987276','20/2/1994',N'Nữ',N'Đồng','18/2/2018'),
--  ('KH33',N'Lê Hoài Thu',N'39A Gò Dưa, P. Tam Bình, Thủ Đức, TP. HCM','0907149571','26/4/1982',N'Nữ',N'Bạc','3/7/2018'),
--  ('KH34',N'Lê Bích Hường',N'5 Đường Số 5, Thủ Đức, TP. HCM','0963085555','13/7/1989',N'Nữ',N'Vàng','21/4/2018'),
--  ('KH35',N'Trần Thị Lan Hương',N'778 Kha Vạn Cân, P. Linh Đông, Thủ Đức, TP. HCM','0948020886','2/6/1983',N'Nữ',N'Bạc','10/9/2018'),
--  ('KH36',N'Nguyễn Thu Hương',N'6 Lưu Văn Lang, Quận 1, TP. HCM','0946126969','31/5/1995',N'Nữ',N'Bạch kim','13/4/2018'),
--  ('KH37',N'Nguyễn Thị Thu Hà',N'34 Đường Số 11, P. 11, Gò Vấp, TP. HCM','0915161646','16/9/1999',N'Nữ',N'Đồng','4/3/2018'),
--  ('KH38',N'Nguyễn Tiến Dũng',N'45 Hoàng Hoa Thám, P. 13, Tân Bình, TP. HCM','0973780808','7/10/1993','Nam',N'Bạc','15/4/2018'),
--  ('KH39',N'Nguyễn Văn Trường',N'40/3 Phạm Viết Chánh, P. 19, Bình Thạnh, TP. HCM','0975136968','26/12/1990','Nam',N'Kim cương','25/12/2018'),
--  ('KH40',N'Ngô Thị Quyết',N'63 Thống Nhất, P. Bình Thọ, Thủ Đức, TP. HCM','0912624767','8/11/1991','Nam',N'Đồng','18/2/2018'),
--  ('KH41',N'Nguyễn Thu Huyền',N'124 Nguyễn Xí, P. 26, Bình Thạnh, TP. HCM','0913259118','1/5/1987',N'Nữ',N'Vàng','5/12/2018'),
--  ('KH42',N'Nguyễn Anh Sơn',N'298 Nguyễn Văn Khối,(Cây Trâm) P. 8, Gò Vấp, TP. HCM','0988199968','10/3/1993','Nam',N'Bạc','13/7/2018')
--INSERT INTO KHACHHANGTHANTHIET (MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES 
--('KH43',N'Trần Thị Ngọc',N'115/20 Nguyễn Duy Cung, Gò Vấp, TP. HCM','0937560696','12/1/1987',N'Nữ',N'Đồng','24/2/2018'),
--('KH44',N'Nguyễn Thị Ngọc Diệp',N'Chung Cư An Lộc, Nguyễn Oanh, P. 17, Gò Vấp, TP. HCM','0983448686','27/8/1995',N'Nữ',N'Kim cương','15/4/2018'),
--('KH45',N'Triệu Thị Thức',N'36/2A Hoàng Xuân Nhị, P. Phú Trung, Tân Phú, TP. HCM','0988428080','26/7/1989',N'Nữ',N'Bạc','23/7/2018'),
--('KH46',N'Cao Trọng Việt',N'401 Lê Văn Thọ, P. 9, Gò Vấp, TP. HCM','0989674906','29/6/1991','Nam',N'Đồng','15/8/2018'),
--('KH47',N'Hoàng Đức Anh',N'236/19/13 Điện Biên Phủ, P. 17, Bình Thạnh, TP. HCM','0989455028','1/10/1997',N'Nữ',N'Bạch kim','20/1/2018'),
--('KH48',N'Hoàng Đức Anh',N'22A Đường Số 19, P. Hiệp Bình Chánh, Thủ Đức, TP. HCM','0987932912','20/5/1993',N'Nữ',N'Bạc','19/4/2018'),
--('KH49',N'Nguyễn Trung Hiếu',N'376 Lê Văn Thọ, P. 11, Gò Vấp, TP. HCM','0943548668','4/3/1994','Nam',N'Đồng','15/10/2018'),
--('KH50',N'Phạm Thị Tuyết Mai',N'14 Đường Số 12, P. 11, Gò Vấp, TP. HCM','01687890731','6/7/1990',N'Nữ',N'Vàng','5/4/2018'),
--('KH51',N'Bùi Huy Thiêm',N'2 Bùi Quang Là, P. 12, Gò Vấp, TP. HCM','0987064996','2/9/1985','Nam',N'Bạc','15/3/2018'),
--('KH52',N'Ngô Thị Hạnh',N'78/31 Đường Số 11, Gò Vấp, TP. HCM','0912177899','13/5/1998',N'Nữ',N'Kim cương','4/4/2018'),
--('KH53',N'Nguyễn Tiến Sơn',N'273/69/2/5 Nguyễn Văn Đậu, Bình Thạnh, TP. HCM','0906013344','24/6/1998','Nam',N'Đồng','15/9/2018'),
--('KH54',N'Nguyễn Văn Sáng',N'202 Nguyễn Văn Khối, P. 9, Gò Vấp, TP. HCM','0975056855','8/8/1998','Nam',N'Đồng','26/4/2018'),
--('KH55',N'Lương Quang Tuấn',N'50 Đường C18, P. 12, Tân Bình, TP. HCM','0976654109','29/5/1998','Nam',N'Bạc','11/2/2018'),
--('KH56',N'Nguyễn Thị Thúy',N'8C Nguyễn Ngọc Phương, P. 19, Bình Thạnh, TP. HCM','0936407737','14/9/1998',N'Nữ',N'Kim cương','15/11/2018'),
--('KH57',N'Nguyễn Thúy Ngân',N'Park 4, Vinhomes Central Park, 208 Nguyễn Hữu Cảnh, P. 22, Bình Thạnh, TP. HCM','0961109658','23/12/1998',N'Nữ',N'Đồng','3/4/2018'),
--('KH58',N'Nguyễn Thị Phượng',N'31 Điện Biên Phủ, P. 15, Bình Thạnh, TP. HCM','0944130684','15/1/1998',N'Nữ',N'Vàng','23/12/2018'),
--('KH59',N'Ngô Tùng Quân',N'350/1B Nguyễn Văn Khối, Gò Vấp, TP. HCM','0943805555','28/3/1998','Nam',N'Bạc','15/7/2018')
--INSERT INTO KHACHHANGTHANTHIET (MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES 
--('KH60',N'Nguyễn Trọng Tú',N'171 Calmette, Quận 1','0945290268','25/4/1998','Nam',N'Đồng','13/4/2018'),
--('KH61',N'Trương Sơn',N'94 Xuân Thủy, P. Thảo Điền, Quận 2','0913067704','26/8/1993','Nam',N'Đồng','15/5/2018'),
--('KH62',N'Nguyễn Thị Thanh Bình',N'306 Nguyễn Thượng Hiền, P. 5, Quận Phú Nhuận','0906200318','5/4/1995',N'Nữ',N'Đồng','18/4/2018'),
--('KH63',N'Nguyễn Khắc Hiếu',N'131 Hoàng Hoa Thám, P. 13, Quận Tân Bình','0915868634','13/9/1989','Nam',N'Bạc','15/10/2018'),
--('KH64',N'Nguyễn Thùy Dung',N'254 Điện Biên Phủ, P. 7, Quận 3','0972635295','10/10/1986',N'Nữ',N'Bạch kim','24/12/2018'),
--('KH65',N'Bùi Tuấn Dương',N'436 Nguyễn Thị Thập, P. Tân Quy, Quận 7','0968083038','4/2/1996','Nam',N'Đồng','15/11/2018'),
--('KH66',N'Trần Quốc Hưng',N' 20 Cộng Hòa, P. 12, Quận Tân Bình','0913280023','6/1/1998','Nam',N'Bạc','12/4/2018'),
--('KH67',N'Nguyễn Thị Hoan',N'32 Hoa Mai, P. 2, Quận Phú Nhuận','01648805576','11/9/1991',N'Nữ',N'Kim cương','15/10/2018'),
--('KH68',N'Võ Thị Phương Thảo',N'151E Hai Bà Trưng, P. 6, Quận 3','0932233220','23/3/1993',N'Nữ',N'Đồng','5/4/2018'),
--('KH69',N'Đặng Đức Long',N'200A Lý Tự Trọng (Ngã 4 Trương Định), Quận 1','0914371146','12/7/1992','Nam',N'Vàng','15/12/2018'),
--('KH70',N'Nguyễn Văn Lâm',N'52 Mạc Đĩnh Chi, P. Đakao, Quận 1','0945199968','15/5/1994','Nam',N'Bạc','29/4/2018'),
--('KH71',N'Lê Thị Kim Chi',N'14 Lê Quý Đôn, P. 6, Quận 3','0983388625','23/2/2000',N'Nữ',N'Đồng','15/8/2018'),
--('KH72',N'Huỳnh Thị Hải Vân',N'77 Cộng Hoà, P. 4, Quận Tân Bình','0989089606','9/3/1994',N'Nữ',N'Đồng','25/4/2018'),
--('KH73',N'Lê Minh Đức',N'476 Nguyễn Chí Thanh, Quận 10','0912261227','18/8/1995','Nam',N'Bạc','15/1/2018'),
--('KH74',N'Nguyễn Thị Thanh Hoa',N'15 Lê Quý Đôn, P. 6, Quận 3','0904595950','21/4/1997',N'Nữ',N'Đồng','17/4/2018'),
--('KH75',N'Trịnh Tuấn Anh',N'230 Nguyễn Tri Phương, P. 4, Quận 10','0988356206','27/2/1994','Nam',N'Kim cương','15/10/2018'),
--('KH76',N'Phùng Thị Hằng',N'19 Hồ Xuân Hương, P. 6, Quận 3','0944407968','25/5/1992',N'Nữ',N'Bạc','4/4/2018'),
--('KH77',N'Ngô Xuân Thanh',N'109 Lý Tự Trọng, Quận 1','0913518780','23/4/1991','Nam',N'Đồng','15/12/2018'),
--('KH78',N'Nguyễn Hải Yến',N'17/11 Lê Thánh Tôn (Mặt Tiền), Quận 1','01252791111','21/6/1989',N'Nữ',N'Đồng','29/5/2018'),
--('KH79',N'Dương Bích Hiền',N'Tầng 2 Estella Place, 88 Song Hành, P. An Phú, Quận 2','0902198052','11/8/1984',N'Nữ',N'Đồng','15/2/2018')
--INSERT INTO KHACHHANGTHANTHIET (MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES 
--('KH80',N'Nguyễn Anh Việt',N'745/13 Lạc Long Quân, P.14, Tân Bình, TP.HCM','01234669955','9/7/1981','Nam',N'Bạc','17/5/2018'),
--('KH81',N'Bùi Xuân Quang',N'52 Thạch Thị Thanh, P. Tân Định, Quận 1','0989992169','20/12/1989','Nam',N'Vàng','30/4/2018'),
--('KH82',N'Nguyễn Hoàng Hiếu',N'285 Cách Mạng Tháng 8, P. 12, Quận 10','01213146688','16/10/1988','Nam',N'Đồng','1/2/2018'),
--('KH83',N'Tạ Thị Thu Hương',N'92 Nam Kỳ Khởi Nghĩa, Quận 1','01693118338','11/8/1986',N'Nữ',N'Bạch kim','26/4/2018'),
--('KH84',N'Nguyễn Thị Tú Ngọc',N'345 Bến Bình Đông, P. 13, Quận 8, TP. HCM','0915551975','12/1/1994',N'Nữ',N'Bạc','15/1/2018'),
--('KH85',N'Nguyễn Mạnh Tùng',N'809/23G Trần Hưng Đạo, P. 1, Quận 5, TP. HCM','0969390899','26/2/1999','Nam',N'Đồng','16/3/2018'),
--('KH86',N'Vũ Thị Tuyết',N'C3/21T Phạm Hùng, Xã Bình Hưng, Bình Chánh, TP. HCM','0977110966','18/3/1992',N'Nữ',N'Kim cương','3/8/2018'),
--('KH87',N'Phạm Văn Sơn',N'219 Đề Thám, P. Phạm Ngũ Lão, Quận 1, TP. HCM','0912078292','10/2/1995','Nam',N'Bạc','6/4/2018'),
--('KH88',N'Nguyễn Thị Thu Trang',N'309/1 Nguyễn Văn Trỗi, P. 1, Tân Bình, TP. HCM','0983588082','18/8/1997',N'Nữ',N'Đồng','28/1/2018'),
--('KH89',N'Nguyễn Thu Phương',N'17A Nguyễn Thị Minh Khai, P. Bến Nghé, Quận 1, TP. HCM','0982903676','27/9/1998',N'Nữ',N'Kim cương','24/11/2018'),
--('KH90',N'Trịnh Thu Hồng',N'229/24 Tân Kỳ Tân Quý, P. Tân Sơn Nhì, Tân Phú, TP. HCM','0913564202','1/7/1992',N'Nữ',N'Đồng','17/4/2018'),
--('KH91',N'Bùi Thị Thu Thủy',N'449C Trần Hưng Đạo, P. Cầu Kho, Quận 1, TP. HCM','0914884257','26/2/1990',N'Nữ',N'Bạc','15/2/2018'),
--('KH92',N'Trần Bích Trâm',N'239 Đường Số 8, P. 11, Gò Vấp, TP. HCM','0983633890','18/8/1985',N'Nữ',N'Vàng','14/7/2018'),
--('KH93',N'Nguyễn Khánh Linh',N'836 Phạm Văn Đồng, P. Hiệp Bình Chánh, Thủ Đức, TP. HCM','0944476305','27/9/1994',N'Nữ',N'Đồng','9/12/2018'),
--('KH94',N'Nguyễn Thị Thanh',N'220/68/5 Âu Cơ, P. 9, Tân Bình, TP. HCM','0981230678','13/6/1993',N'Nữ',N'Đồng','15/6/2018'),
--('KH95',N'Trần Thế Anh',N'158/202 Phạm Văn Hai, P.3, Tân Bình , TP.HCM','0948200666','3/7/1996','Nam',N'Bạc','24/4/2018'),
--('KH96',N'Bùi Đăng Thắng',N'140/2 Phạm Văn Chiêu, P.9, Gò Vấp, TP.HCM','0966277447','25/8/1998','Nam',N'Đồng','15/3/2018'),
--('KH97',N'Nguyễn Đức Tá',N'229/25 Tuy Lý Vương, P.12, Quận 8, TP.HCM','0986456282','10/12/1999','Nam',N'Kim cương','20/6/2018'),
--('KH98',N'Đỗ Thị Bích Vân',N'95/29 Đinh Tiên Hoàng, P.3, Bình Thạnh, TP.HCM','0912758399','29/6/1996',N'Nữ',N'Bạc','1/12/2018'),
--('KH99',N'Hoàng Trọng Chính',N'320 Cộng Hòa, P.13, Tân Bình, TP.HCM','0986196068','12/4/1993','Nam',N'Đồng','21/4/2018'),
--('KH100',N'Trần Anh Tuấn',N'142/8/3 Lê Lợi, P.4, Gò Vấp, TP.HCM','0987685085','5/1/1994','Nam',N'Bạch kim','15/5/2018')

GO
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH1','thanhphuong','thanhphuong')
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH2','thienhuong','thienhuong')
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH3','trungquan','trungquan')
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH4','tranthanh','tranthanh')

INSERT INTO NGUOIDUNG( MAND,HOTEN,CHUCVU,PHANQUYEN) VALUES 
('NV1',N'Trần Nguyễn Thanh Phương',N'Quản trị',N'Quản trị'),
('NV2',N'Nguyễn Thiên Hương ',N'Nhân viên quản lý phim',N'Quản lý phim, Quản lý loại phim'),
('NV3',N'Trần Nguyễn Trung Quân',N'Nhân viên quản lý phòng chiếu',N'Quản lý phòng chiếu'),
('NV4',N'Trần Thanh',N'Nhân viên quản lý lịch chiếu',N'Quản lý lịch chiếu'),
('NV5',N'Nguyễn Thanh Phương',N'Nhân viên quản lý vé',N'Quản lý loại vé, Quản lý vé')
--drop table NGUOIDUNG

GO
INSERT INTO PHONGCHIEU(MAPC,TENPC,SOCHO,MAYCHIEU,LOA,DIENTICH,TINHTRANG,TRANGTHIETBIKHAC) VALUES 
('PC1',N'Phòng chiếu 1',200,N'Viewsonic PX727 4K HDR (US)',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-299',200,N'Tốt',N'Có'),
('PC2',N'Phòng chiếu 2',150,N'Viewsonic PX747 4K (US)',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-196',150,N'Tốt',N'Không'),
('PC3',N'Phòng chiếu 3',100,N'Optoma HT27LV',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-299',100,N'Tốt',N'Không'),
('PC4',N'Phòng chiếu 4',200,N'Optoma HT27LV-4K HDR',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-299',200,N'Tốt',N'Không'),
('PC5',N'Phòng chiếu 5',150,N'Sony VZ1000ES',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-196',150,N'Tốt',N'Không')

GO
INSERT INTO CHONGOI(MAPC,SOLUONGGHE,SOLUONGGHE_CONLAI) VALUES 
('PC1','100','100'),
('PC2','100','100'),
('PC3','100','100'),
('PC4','100','100'),
('PC5','100','100')

go
INSERT INTO LOAIPHIM(MALP,TENLP,MOTA) VALUES 
('LP1',N'Phim hành động',N'Là một thể loại điện ảnh trong đó một hoặc nhiều nhân vật anh hùng bị đẩy vào một loạt những thử thách, thường bao gồm những kì công vật lý, các cảnh hành động kéo dài, yếu tố bạo lực và những cuộc rượt đuổi điên cuồng. Phim hành động có xu hướng mô tả một nhân vật có tài xoay xở đấu tranh chống lại những xung đột không tưởng, bao gồm các tình huống đe dọa đến tính mạng, một phản diện hay một sự theo đuổi mà thường kết thúc trong thắng lợi cho anh hùng'),
('LP2',N'Phim phiêu lưu',N'Là một thể loại điện ảnh. Không giống như phim hành động, phim phiêu lưu thường sử dụng những cảnh quay hành động để diễn tả những địa điểm khác lạ một cách mạnh mẽ'),
('LP3',N'Phim bí ẩn',N'Là một thể loại phim xoay quanh việc giải quyết một vấn đề hoặc giải mã một tội phạm. Nó tập trung vào những nỗ lực của thám tử, thám tử tư hoặc thám tử nghiệp dư để giải quyết các tình huống bí ẩn bằng cách xem xét các dấu vết, điều tra và tư duy thông minh.'),
('LP4',N'Phim hài',N'Là thể loại phim nhấn mạnh về tính hài hước. Phim thường có kết thúc có hậu. Một trong những dòng phim lâu đời nhất, một trong số những bộ phim câm đầu tiên chính là phim hài. Nhiều phim là những câu chuyện không gì hơn ngoài mục đích giải trí thì cũng có những phim đề cập tới những vấn đề chính trị, xã hội.'),
('LP5',N'Phim kinh dị',N'Là một thể loại điện ảnh đưa đến cho khán giả xem phim những cảm xúc tiêu cực, gợi cho người xem nỗi sợ hãi nguyên thủy nhất thông qua cốt truyện, nội dung phim, những hình ảnh rùng rợn, bí hiểm, ánh sáng mờ ảo, những âm thanh rùng rợn, nhiều cảnh máu me, chết chóc... hay có những cảnh giật mình thông qua các phương tiện và siêu nhiên rùng rợn, do đó thể loại phim này đôi khi có chồng lấn với các thể loại phim giả tưởng, viễn tưởng.'),
('LP6',N'Phim giật gân',N'Là một thể loại phim gợi lên sự hứng thú và hồi hộp cho khán giả. Yếu tố hồi hộp, được tìm thấy trong hầu hết các mảng của phim, thường xuyên được các nhà làm phim trong thể loại này khai thác. Sự căng thẳng được tạo ra bằng cách trì hoãn những gì mà khán giả coi là không thể tránh khỏi và được xây dựng thông qua những tình huống mang tính đe dọa hoặc các tình thế mà việc thoát khỏi dường như là không thể.'),
('LP7',N'Phim kỳ ảo',N'Là các phim có chủ đề tưởng tượng, không có thực; thường gồm phép thuật, các sự việc hiện tượng siêu nhiên, các sinh vật giả tưởng, hay những thế giới tưởng tượng kỳ ảo. Thể loại phim này khác với phim khoa học viễn tưởng và phim kinh dị, mặc dù chúng có những điểm trùng lặp và chồng chéo. Phim tưởng tượng thường có các yếu tố phép thuật, thần thoại, những điều kỳ diệu, thoát li thực tế, và những thứ phi thường.'),
('LP8',N'Phim chính kịch',N'Là một thể loại hư cấu tự sự (hoặc nửa hư cấu) có xu hướng mang tinh thần nghiêm túc hơn là hài hước.'),
('LP9',N'Phim lãng mạn',N'Là những câu chuyện tình lãng mạn được ghi lại trên các phương tiện thị giác để phát sóng trên sân khấu và trên TV với nội dung tập trung vào đam mê, cảm xúc, và sự liên hệ tình cảm lãng mạn của các nhân vật chính và cuộc hành trình mà tình yêu mạnh mẽ, chân thực và thuần khiết của họ đã đưa họ đến việc hẹn hò, tán tỉnh và cuối cùng là hôn nhân.'),
('LP10',N'Phim tội phạm',N'Là một thể loại điện ảnh được lấy cảm hứng từ và tương tự như thể loại văn học giả tưởng về tội phạm. Các phim thuộc thể loại này thường bao gồm các khía cạnh khác nhau của tội phạm và việc điều tra nó.')

go
INSERT INTO PHIM(MAPHIM,TENPHIM,DAODIEN,DIENVIEN,NOIDUNG,NAMSX,NUOCSX,THOILUONG) VALUES 
('PHIM1',N'Quái Vật Venom',N'Ruben Fleischer',N'Tom Hardy, Michelle William, Riz Ahmed',N'Quái Vật Venom là một kẻ thù nguy hiểm và nặng ký của Người nhện trong loạt series của Marvel. Chàng phóng viên Eddie Brock (do Tom Hardy thủ vai) bí mật theo dõi âm mưu xấu xa của một tổ chức và đã không may mắn khi nhiễm phải loại cộng sinh trùng ngoài hành tinh (Symbiote) và từ đó đã không còn làm chủ bản thân về thể chất lẫn tinh thần. Điều này đã dần biến anh thành quái vật đen tối và nguy hiểm nhất chống lại người Nhện - Venom','2018',N'Mỹ',N'115 phút'),
('PHIM2',N'Sword Art Online: Đao Kiếm Thần Vực',N'Tomohiko Ito',N'Haruka Tomatsu, Bryce Papenbrook, Yoshitsugu Matsuoka, Kanae Ito, Ayana Taketatsu',N'Con đường sống duy nhất là đánh bại mọi kẻ thù. Cái chết trong game đồng nghĩa với cái chết ngoài đời thực. Bằng Nerve Gear, mười ngàn con người lao đầu vào một trò chơi bí ẩn "Sword Art Online", để rồi bị giam cầm trong đó, buộc phải dấn thân vào một đấu trường sinh tử. Anh main của chúng ta, Kirito, một trong số các game thủ, đã nhận ra được "sự thật" khủng khiếp này. Anh đơn thương độc mã, chiến đấu trong một lâu đài bay khổng lồ-mang tên "Aincrad" Để có thể hoàn thành trò chơi và trở về với thực tại, anh phải vượt qua đủ 100 thử thách. Liệu anh có thể làm được hay anh sẽ về với cát bụi?','2013',N'Nhật Bản',N'24 phút/tập'),
('PHIM3',N'Weathering With You: Đứa Con Của Thời Tiết',N'Makoto Shinkai',N'Kotaro Daigo, Sei Hiraizumi, Tsubasa Honda, Yuki Kaji, Ryunosuke Kamiki, Nana Mori',N'Đứa Con Của Thời Tiết xoay quanh hai nhân vật: Hodaka và Hina. Hodaka là cậu thiếu niên sống trên một hòn đảo nhỏ, đã rời khỏi quê hương để đến Tokyo sầm uất. Tại đây, cậu quen biết với Hina - một cô gái kì lạ có năng lực thanh lọc bầu trời mỗi khi "cầu nguyện". Cô có khả năng chặn đứng cơn mưa và xua tan mây đen theo ý muốn.','2019',N'Nhật Bản',N'114 phút'),
('PHIM4',N'Shokugeki no Souma ( Season 1): Vua Đầu Bếp Soma (Phần 1)',N'Yoshitomo Yonetani',N'Minami Takahashi, Ai Kayano, Risa Taneda, Saori Oonishi, Takahiro Sakurai, Natsuki Hanae',N'Yukihira Souma là đứa con trai duy nhất của một quán ăn bình dân, cậu có một khao khát cháy bỏng là vượt qua cha mình người đã đánh bại cậu liên tục 489 trận. Đến một ngày cậu nghe lời cha mình để vào trường đào tạo tài năng ẩm thực . Câu chuyện đời cậu sắp bước sang một ngã rẻ khác và nhìu thú vị hơn.','2015',N'Nhật Bản',N'24 phút/ tập')

GO
INSERT INTO THELOAI(MAPHIM,MALP) VALUES
('PHIM1','LP1'),
('PHIM1','LP2'),
('PHIM1','LP3'),
('PHIM1','LP4'),
('PHIM2','LP4'),
('PHIM2','LP5'),
('PHIM2','LP6'),
('PHIM2','LP7'),

('PHIM3','LP4'),
('PHIM3','LP5'),
('PHIM3','LP6'),
('PHIM3','LP7'),

('PHIM4','LP4'),
('PHIM4','LP5'),
('PHIM4','LP6'),
('PHIM4','LP7')

GO
INSERT INTO CACHIEU(MACC,TENCC,BATDAU,KETHUC) VALUES 
('CC1',N'Ca 1','8:00:00','10:00:00'),
('CC2',N'Ca 2','10:00:00','12:00:00'),
('CC3',N'Ca 3','12:00:00','14:00:00'),
('CC4',N'Ca 4','14:00:00','16:00:00'),
('CC5',N'Ca 5','16:00:00','18:00:00')

GO
SET DATEFORMAT DMY
INSERT INTO LICHCHIEU(NGAYBATDAU,NGAYKETTHUC,MAPHIM,MACC,MAPC) VALUES 
('05/01/2020','05/02/2020','PHIM1','CC1','PC1'),
('05/01/2020','05/02/2020','PHIM2','CC1','PC2'),
('05/01/2020','05/02/2020','PHIM3','CC1','PC3'),
('05/01/2020','05/02/2020','PHIM3','CC2','PC1'),
('05/01/2020','05/02/2020','PHIM2','CC2','PC2'),
('05/01/2020','05/02/2020','PHIM1','CC2','PC3'),
('05/01/2020','05/02/2020','PHIM1','CC3','PC4'),
('05/01/2020','05/02/2020','PHIM1','CC4','PC2'),
('05/01/2020','05/02/2020','PHIM1','CC5','PC1'),
('06/01/2020','06/02/2020','PHIM4','CC4','PC2'),
('09/01/2020','09/01/2020','PHIM3','CC4','PC3')

GO
INSERT INTO LOAIVE(MALV,TENLV,LOAICHONGOI,GIA) VALUES 
('LV1',N'Vé thường',N'Ghế thường',40000),
('LV2',N'Vé VIP',N'Ghế VIP',50000),
('LV3',N'Vé đôi',N'Ghế đôi',110000)
-- select * from loaive

GO
INSERT INTO VE(MAPHIM,MAPC,MALV,SOLUONG) VALUES 
('PHIM1','PC1','LV1','100'),
('PHIM2','PC2','LV2','100'),
('PHIM3','PC1','LV2','100'),
('PHIM1','PC3','LV1','100')

GO
INSERT INTO CHITIETCHONGOI VALUES 
('A1',N'Ghế A1','PC1','LV1',N'Chưa đặt'),
('A2',N'Ghế A2','PC1','LV1',N'Chưa đặt'),
('A3',N'Ghế A3','PC1','LV1',N'Chưa đặt'),
('A4',N'Ghế A4','PC1','LV1',N'Chưa đặt'),
('A5',N'Ghế A5','PC1','LV1',N'Chưa đặt'),
('A6',N'Ghế A6','PC1','LV1',N'Chưa đặt'),
('A7',N'Ghế A7','PC1','LV1',N'Chưa đặt'),
('A8',N'Ghế A8','PC1','LV1',N'Chưa đặt'),
('A9',N'Ghế A9','PC1','LV1',N'Chưa đặt'),
('A10',N'Ghế A10','PC1','LV1',N'Chưa đặt'),
('A11',N'Ghế A11','PC1','LV1',N'Chưa đặt'),

('B1',N'Ghế B1','PC1','LV1',N'Chưa đặt'),
('B2',N'Ghế B2','PC1','LV1',N'Chưa đặt'),
('B3',N'Ghế B3','PC1','LV1',N'Chưa đặt'),
('B4',N'Ghế B4','PC1','LV1',N'Chưa đặt'),
('B5',N'Ghế B5','PC1','LV1',N'Chưa đặt'),
('B6',N'Ghế B6','PC1','LV1',N'Chưa đặt'),
('B7',N'Ghế B7','PC1','LV1',N'Chưa đặt'),
('B8',N'Ghế B8','PC1','LV1',N'Chưa đặt'),
('B9',N'Ghế B9','PC1','LV1',N'Chưa đặt'),
('B10',N'Ghế B10','PC1','LV1',N'Chưa đặt'),
('B11',N'Ghế B11','PC1','LV1',N'Chưa đặt'),

('C1',N'Ghế C1','PC1','LV1',N'Chưa đặt'),
('C2',N'Ghế C2','PC1','LV1',N'Chưa đặt'),
('C3',N'Ghế C3','PC1','LV1',N'Chưa đặt'),
('C4',N'Ghế C4','PC1','LV1',N'Chưa đặt'),
('C5',N'Ghế C5','PC1','LV1',N'Chưa đặt'),
('C6',N'Ghế C6','PC1','LV1',N'Chưa đặt'),
('C7',N'Ghế C7','PC1','LV1',N'Chưa đặt'),
('C8',N'Ghế C8','PC1','LV1',N'Chưa đặt'),
('C9',N'Ghế C9','PC1','LV1',N'Chưa đặt'),
('C10',N'Ghế C10','PC1','LV1',N'Chưa đặt'),
('C11',N'Ghế C11','PC1','LV1',N'Chưa đặt'),

('D1',N'Ghế D1','PC1','LV1',N'Chưa đặt'),
('D2',N'Ghế D2','PC1','LV1',N'Chưa đặt'),
('D3',N'Ghế D3','PC1','LV1',N'Chưa đặt'),
('D4',N'Ghế D4','PC1','LV1',N'Chưa đặt'),
('D5',N'Ghế D5','PC1','LV1',N'Chưa đặt'),
('D6',N'Ghế D6','PC1','LV1',N'Chưa đặt'),
('D7',N'Ghế D7','PC1','LV1',N'Chưa đặt'),
('D8',N'Ghế D8','PC1','LV1',N'Chưa đặt'),
('D9',N'Ghế D9','PC1','LV1',N'Chưa đặt'),
('D10',N'Ghế D10','PC1','LV1',N'Chưa đặt'),
('D11',N'Ghế D11','PC1','LV1',N'Chưa đặt'),

('E1',N'Ghế E1','PC1','LV2',N'Chưa đặt'),
('E2',N'Ghế E2','PC1','LV2',N'Chưa đặt'),
('E3',N'Ghế E3','PC1','LV2',N'Chưa đặt'),
('E4',N'Ghế E4','PC1','LV2',N'Chưa đặt'),
('E5',N'Ghế E5','PC1','LV2',N'Chưa đặt'),
('E6',N'Ghế E6','PC1','LV2',N'Chưa đặt'),
('E7',N'Ghế E7','PC1','LV2',N'Chưa đặt'),
('E8',N'Ghế E8','PC1','LV2',N'Chưa đặt'),
('E9',N'Ghế E9','PC1','LV2',N'Chưa đặt'),
('E10',N'Ghế E10','PC1','LV2',N'Chưa đặt'),
('E11',N'Ghế E11','PC1','LV2',N'Chưa đặt'),

('F1',N'Ghế F1','PC1','LV2',N'Chưa đặt'),
('F2',N'Ghế F2','PC1','LV2',N'Chưa đặt'),
('F3',N'Ghế F3','PC1','LV2',N'Chưa đặt'),
('F4',N'Ghế F4','PC1','LV2',N'Chưa đặt'),
('F5',N'Ghế F5','PC1','LV2',N'Chưa đặt'),
('F6',N'Ghế F6','PC1','LV2',N'Chưa đặt'),
('F7',N'Ghế F7','PC1','LV2',N'Chưa đặt'),
('F8',N'Ghế F8','PC1','LV2',N'Chưa đặt'),
('F9',N'Ghế F9','PC1','LV2',N'Chưa đặt'),
('F10',N'Ghế F10','PC1','LV2',N'Chưa đặt'),
('F11',N'Ghế F11','PC1','LV2',N'Chưa đặt'),

('G1',N'Ghế G1','PC1','LV2',N'Chưa đặt'),
('G2',N'Ghế G2','PC1','LV2',N'Chưa đặt'),
('G3',N'Ghế G3','PC1','LV2',N'Chưa đặt'),
('G4',N'Ghế G4','PC1','LV2',N'Chưa đặt'),
('G5',N'Ghế G5','PC1','LV2',N'Chưa đặt'),
('G6',N'Ghế G6','PC1','LV2',N'Chưa đặt'),
('G7',N'Ghế G7','PC1','LV2',N'Chưa đặt'),
('G8',N'Ghế G8','PC1','LV2',N'Chưa đặt'),
('G9',N'Ghế G9','PC1','LV2',N'Chưa đặt'),
('G10',N'Ghế G10','PC1','LV2',N'Chưa đặt'),
('G11',N'Ghế G11','PC1','LV2',N'Chưa đặt'),
('H1',N'Ghế H1','PC1','LV3',N'Chưa đặt'),

('H2',N'Ghế H2','PC1','LV3',N'Chưa đặt'),
('H3',N'Ghế H3','PC1','LV3',N'Chưa đặt'),
('H4',N'Ghế H4','PC1','LV3',N'Chưa đặt'),
('H5',N'Ghế H5','PC1','LV3',N'Chưa đặt'),
('H6',N'Ghế H6','PC1','LV3',N'Chưa đặt'),
('H7',N'Ghế H7','PC1','LV3',N'Chưa đặt'),
('H8',N'Ghế H8','PC1','LV3',N'Chưa đặt'),
('H9',N'Ghế H9','PC1','LV3',N'Chưa đặt'),
('H10',N'Ghế H10','PC1','LV3',N'Chưa đặt'),
('H11',N'Ghế H11','PC1','LV3',N'Chưa đặt')

GO
--PC2
INSERT INTO CHITIETCHONGOI(MAGHE,TENGHE,MAPC,MALV,TRANGTHAI) VALUES 
('A1',N'Ghế A1','PC2','LV1',N'Chưa đặt'),
('A2',N'Ghế A2','PC2','LV1',N'Chưa đặt'),
('A3',N'Ghế A3','PC2','LV1',N'Chưa đặt'),
('A4',N'Ghế A4','PC2','LV1',N'Chưa đặt'),
('A5',N'Ghế A5','PC2','LV1',N'Chưa đặt'),
('A6',N'Ghế A6','PC2','LV1',N'Chưa đặt'),
('A7',N'Ghế A7','PC2','LV1',N'Chưa đặt'),
('A8',N'Ghế A8','PC2','LV1',N'Chưa đặt'),
('A9',N'Ghế A9','PC2','LV1',N'Chưa đặt'),
('A10',N'Ghế A10','PC2','LV1',N'Chưa đặt'),
('A11',N'Ghế A11','PC2','LV1',N'Chưa đặt'),

('B1',N'Ghế B1','PC2','LV1',N'Chưa đặt'),
('B2',N'Ghế B2','PC2','LV1',N'Chưa đặt'),
('B3',N'Ghế B3','PC2','LV1',N'Chưa đặt'),
('B4',N'Ghế B4','PC2','LV1',N'Chưa đặt'),
('B5',N'Ghế B5','PC2','LV1',N'Chưa đặt'),
('B6',N'Ghế B6','PC2','LV1',N'Chưa đặt'),
('B7',N'Ghế B7','PC2','LV1',N'Chưa đặt'),
('B8',N'Ghế B8','PC2','LV1',N'Chưa đặt'),
('B9',N'Ghế B9','PC2','LV1',N'Chưa đặt'),
('B10',N'Ghế B10','PC2','LV1',N'Chưa đặt'),
('B11',N'Ghế B11','PC2','LV1',N'Chưa đặt'),

('C1',N'Ghế C1','PC2','LV1',N'Chưa đặt'),
('C2',N'Ghế C2','PC2','LV1',N'Chưa đặt'),
('C3',N'Ghế C3','PC2','LV1',N'Chưa đặt'),
('C4',N'Ghế C4','PC2','LV1',N'Chưa đặt'),
('C5',N'Ghế C5','PC2','LV1',N'Chưa đặt'),
('C6',N'Ghế C6','PC2','LV1',N'Chưa đặt'),
('C7',N'Ghế C7','PC2','LV1',N'Chưa đặt'),
('C8',N'Ghế C8','PC2','LV1',N'Chưa đặt'),
('C9',N'Ghế C9','PC2','LV1',N'Chưa đặt'),
('C10',N'Ghế C10','PC2','LV1',N'Chưa đặt'),
('C11',N'Ghế C11','PC2','LV1',N'Chưa đặt'),

('D1',N'Ghế D1','PC2','LV1',N'Chưa đặt'),
('D2',N'Ghế D2','PC2','LV1',N'Chưa đặt'),
('D3',N'Ghế D3','PC2','LV1',N'Chưa đặt'),
('D4',N'Ghế D4','PC2','LV1',N'Chưa đặt'),
('D5',N'Ghế D5','PC2','LV1',N'Chưa đặt'),
('D6',N'Ghế D6','PC2','LV1',N'Chưa đặt'),
('D7',N'Ghế D7','PC2','LV1',N'Chưa đặt'),
('D8',N'Ghế D8','PC2','LV1',N'Chưa đặt'),
('D9',N'Ghế D9','PC2','LV1',N'Chưa đặt'),
('D10',N'Ghế D10','PC2','LV1',N'Chưa đặt'),
('D11',N'Ghế D11','PC2','LV1',N'Chưa đặt'),

('E1',N'Ghế E1','PC2','LV2',N'Chưa đặt'),
('E2',N'Ghế E2','PC2','LV2',N'Chưa đặt'),
('E3',N'Ghế E3','PC2','LV2',N'Chưa đặt'),
('E4',N'Ghế E4','PC2','LV2',N'Chưa đặt'),
('E5',N'Ghế E5','PC2','LV2',N'Chưa đặt'),
('E6',N'Ghế E6','PC2','LV2',N'Chưa đặt'),
('E7',N'Ghế E7','PC2','LV2',N'Chưa đặt'),
('E8',N'Ghế E8','PC2','LV2',N'Chưa đặt'),
('E9',N'Ghế E9','PC2','LV2',N'Chưa đặt'),
('E10',N'Ghế E10','PC2','LV2',N'Chưa đặt'),
('E11',N'Ghế E11','PC2','LV2',N'Chưa đặt'),

('F1',N'Ghế F1','PC2','LV2',N'Chưa đặt'),
('F2',N'Ghế F2','PC2','LV2',N'Chưa đặt'),
('F3',N'Ghế F3','PC2','LV2',N'Chưa đặt'),
('F4',N'Ghế F4','PC2','LV2',N'Chưa đặt'),
('F5',N'Ghế F5','PC2','LV2',N'Chưa đặt'),
('F6',N'Ghế F6','PC2','LV2',N'Chưa đặt'),
('F7',N'Ghế F7','PC2','LV2',N'Chưa đặt'),
('F8',N'Ghế F8','PC2','LV2',N'Chưa đặt'),
('F9',N'Ghế F9','PC2','LV2',N'Chưa đặt'),
('F10',N'Ghế F10','PC2','LV2',N'Chưa đặt'),
('F11',N'Ghế F11','PC2','LV2',N'Chưa đặt'),

('G1',N'Ghế G1','PC2','LV2',N'Chưa đặt'),
('G2',N'Ghế G2','PC2','LV2',N'Chưa đặt'),
('G3',N'Ghế G3','PC2','LV2',N'Chưa đặt'),
('G4',N'Ghế G4','PC2','LV2',N'Chưa đặt'),
('G5',N'Ghế G5','PC2','LV2',N'Chưa đặt'),
('G6',N'Ghế G6','PC2','LV2',N'Chưa đặt'),
('G7',N'Ghế G7','PC2','LV2',N'Chưa đặt'),
('G8',N'Ghế G8','PC2','LV2',N'Chưa đặt'),
('G9',N'Ghế G9','PC2','LV2',N'Chưa đặt'),
('G10',N'Ghế G10','PC2','LV2',N'Chưa đặt'),
('G11',N'Ghế G11','PC2','LV2',N'Chưa đặt'),
('H1',N'Ghế H1','PC2','LV3',N'Chưa đặt'),

('H2',N'Ghế H2','PC2','LV3',N'Chưa đặt'),
('H3',N'Ghế H3','PC2','LV3',N'Chưa đặt'),
('H4',N'Ghế H4','PC2','LV3',N'Chưa đặt'),
('H5',N'Ghế H5','PC2','LV3',N'Chưa đặt'),
('H6',N'Ghế H6','PC2','LV3',N'Chưa đặt'),
('H7',N'Ghế H7','PC2','LV3',N'Chưa đặt'),
('H8',N'Ghế H8','PC2','LV3',N'Chưa đặt'),
('H9',N'Ghế H9','PC2','LV3',N'Chưa đặt'),
('H10',N'Ghế H10','PC2','LV3',N'Chưa đặt'),
('H11',N'Ghế H11','PC2','LV3',N'Chưa đặt')

GO
--PC3
INSERT INTO CHITIETCHONGOI(MAGHE,TENGHE,MAPC,MALV,TRANGTHAI) VALUES 
('A1',N'Ghế A1','PC3','LV1',N'Chưa đặt'),
('A2',N'Ghế A2','PC3','LV1',N'Chưa đặt'),
('A3',N'Ghế A3','PC3','LV1',N'Chưa đặt'),
('A4',N'Ghế A4','PC3','LV1',N'Chưa đặt'),
('A5',N'Ghế A5','PC3','LV1',N'Chưa đặt'),
('A6',N'Ghế A6','PC3','LV1',N'Chưa đặt'),
('A7',N'Ghế A7','PC3','LV1',N'Chưa đặt'),
('A8',N'Ghế A8','PC3','LV1',N'Chưa đặt'),
('A9',N'Ghế A9','PC3','LV1',N'Chưa đặt'),
('A10',N'Ghế A10','PC3','LV1',N'Chưa đặt'),
('A11',N'Ghế A11','PC3','LV1',N'Chưa đặt'),

('B1',N'Ghế B1','PC3','LV1',N'Chưa đặt'),
('B2',N'Ghế B2','PC3','LV1',N'Chưa đặt'),
('B3',N'Ghế B3','PC3','LV1',N'Chưa đặt'),
('B4',N'Ghế B4','PC3','LV1',N'Chưa đặt'),
('B5',N'Ghế B5','PC3','LV1',N'Chưa đặt'),
('B6',N'Ghế B6','PC3','LV1',N'Chưa đặt'),
('B7',N'Ghế B7','PC3','LV1',N'Chưa đặt'),
('B8',N'Ghế B8','PC3','LV1',N'Chưa đặt'),
('B9',N'Ghế B9','PC3','LV1',N'Chưa đặt'),
('B10',N'Ghế B10','PC3','LV1',N'Chưa đặt'),
('B11',N'Ghế B11','PC3','LV1',N'Chưa đặt'),

('C1',N'Ghế C1','PC3','LV1',N'Chưa đặt'),
('C2',N'Ghế C2','PC3','LV1',N'Chưa đặt'),
('C3',N'Ghế C3','PC3','LV1',N'Chưa đặt'),
('C4',N'Ghế C4','PC3','LV1',N'Chưa đặt'),
('C5',N'Ghế C5','PC3','LV1',N'Chưa đặt'),
('C6',N'Ghế C6','PC3','LV1',N'Chưa đặt'),
('C7',N'Ghế C7','PC3','LV1',N'Chưa đặt'),
('C8',N'Ghế C8','PC3','LV1',N'Chưa đặt'),
('C9',N'Ghế C9','PC3','LV1',N'Chưa đặt'),
('C10',N'Ghế C10','PC3','LV1',N'Chưa đặt'),
('C11',N'Ghế C11','PC3','LV1',N'Chưa đặt'),

('D1',N'Ghế D1','PC3','LV1',N'Chưa đặt'),
('D2',N'Ghế D2','PC3','LV1',N'Chưa đặt'),
('D3',N'Ghế D3','PC3','LV1',N'Chưa đặt'),
('D4',N'Ghế D4','PC3','LV1',N'Chưa đặt'),
('D5',N'Ghế D5','PC3','LV1',N'Chưa đặt'),
('D6',N'Ghế D6','PC3','LV1',N'Chưa đặt'),
('D7',N'Ghế D7','PC3','LV1',N'Chưa đặt'),
('D8',N'Ghế D8','PC3','LV1',N'Chưa đặt'),
('D9',N'Ghế D9','PC3','LV1',N'Chưa đặt'),
('D10',N'Ghế D10','PC3','LV1',N'Chưa đặt'),
('D11',N'Ghế D11','PC3','LV1',N'Chưa đặt'),

('E1',N'Ghế E1','PC3','LV2',N'Chưa đặt'),
('E2',N'Ghế E2','PC3','LV2',N'Chưa đặt'),
('E3',N'Ghế E3','PC3','LV2',N'Chưa đặt'),
('E4',N'Ghế E4','PC3','LV2',N'Chưa đặt'),
('E5',N'Ghế E5','PC3','LV2',N'Chưa đặt'),
('E6',N'Ghế E6','PC3','LV2',N'Chưa đặt'),
('E7',N'Ghế E7','PC3','LV2',N'Chưa đặt'),
('E8',N'Ghế E8','PC3','LV2',N'Chưa đặt'),
('E9',N'Ghế E9','PC3','LV2',N'Chưa đặt'),
('E10',N'Ghế E10','PC3','LV2',N'Chưa đặt'),
('E11',N'Ghế E11','PC3','LV2',N'Chưa đặt'),

('F1',N'Ghế F1','PC3','LV2',N'Chưa đặt'),
('F2',N'Ghế F2','PC3','LV2',N'Chưa đặt'),
('F3',N'Ghế F3','PC3','LV2',N'Chưa đặt'),
('F4',N'Ghế F4','PC3','LV2',N'Chưa đặt'),
('F5',N'Ghế F5','PC3','LV2',N'Chưa đặt'),
('F6',N'Ghế F6','PC3','LV2',N'Chưa đặt'),
('F7',N'Ghế F7','PC3','LV2',N'Chưa đặt'),
('F8',N'Ghế F8','PC3','LV2',N'Chưa đặt'),
('F9',N'Ghế F9','PC3','LV2',N'Chưa đặt'),
('F10',N'Ghế F10','PC3','LV2',N'Chưa đặt'),
('F11',N'Ghế F11','PC3','LV2',N'Chưa đặt'),

('G1',N'Ghế G1','PC3','LV2',N'Chưa đặt'),
('G2',N'Ghế G2','PC3','LV2',N'Chưa đặt'),
('G3',N'Ghế G3','PC3','LV2',N'Chưa đặt'),
('G4',N'Ghế G4','PC3','LV2',N'Chưa đặt'),
('G5',N'Ghế G5','PC3','LV2',N'Chưa đặt'),
('G6',N'Ghế G6','PC3','LV2',N'Chưa đặt'),
('G7',N'Ghế G7','PC3','LV2',N'Chưa đặt'),
('G8',N'Ghế G8','PC3','LV2',N'Chưa đặt'),
('G9',N'Ghế G9','PC3','LV2',N'Chưa đặt'),
('G10',N'Ghế G10','PC3','LV2',N'Chưa đặt'),
('G11',N'Ghế G11','PC3','LV2',N'Chưa đặt'),

('H1',N'Ghế H1','PC3','LV3',N'Chưa đặt'),
('H2',N'Ghế H2','PC3','LV3',N'Chưa đặt'),
('H3',N'Ghế H3','PC3','LV3',N'Chưa đặt'),
('H4',N'Ghế H4','PC3','LV3',N'Chưa đặt'),
('H5',N'Ghế H5','PC3','LV3',N'Chưa đặt'),
('H6',N'Ghế H6','PC3','LV3',N'Chưa đặt'),
('H7',N'Ghế H7','PC3','LV3',N'Chưa đặt'),
('H8',N'Ghế H8','PC3','LV3',N'Chưa đặt'),
('H9',N'Ghế H9','PC3','LV3',N'Chưa đặt'),
('H10',N'Ghế H10','PC3','LV3',N'Chưa đặt'),
('H11',N'Ghế H11','PC3','LV3',N'Chưa đặt')

--PC4
GO
INSERT INTO CHITIETCHONGOI(MAGHE,TENGHE,MAPC,MALV,TRANGTHAI) VALUES 
('A1',N'Ghế A1','PC4','LV1',N'Chưa đặt'),
('A2',N'Ghế A2','PC4','LV1',N'Chưa đặt'),
('A3',N'Ghế A3','PC4','LV1',N'Chưa đặt'),
('A4',N'Ghế A4','PC4','LV1',N'Chưa đặt'),
('A5',N'Ghế A5','PC4','LV1',N'Chưa đặt'),
('A6',N'Ghế A6','PC4','LV1',N'Chưa đặt'),
('A7',N'Ghế A7','PC4','LV1',N'Chưa đặt'),
('A8',N'Ghế A8','PC4','LV1',N'Chưa đặt'),
('A9',N'Ghế A9','PC4','LV1',N'Chưa đặt'),
('A10',N'Ghế A10','PC4','LV1',N'Chưa đặt'),
('A11',N'Ghế A11','PC4','LV1',N'Chưa đặt'),

('B1',N'Ghế B1','PC4','LV1',N'Chưa đặt'),
('B2',N'Ghế B2','PC4','LV1',N'Chưa đặt'),
('B3',N'Ghế B3','PC4','LV1',N'Chưa đặt'),
('B4',N'Ghế B4','PC4','LV1',N'Chưa đặt'),
('B5',N'Ghế B5','PC4','LV1',N'Chưa đặt'),
('B6',N'Ghế B6','PC4','LV1',N'Chưa đặt'),
('B7',N'Ghế B7','PC4','LV1',N'Chưa đặt'),
('B8',N'Ghế B8','PC4','LV1',N'Chưa đặt'),
('B9',N'Ghế B9','PC4','LV1',N'Chưa đặt'),
('B10',N'Ghế B10','PC4','LV1',N'Chưa đặt'),
('B11',N'Ghế B11','PC4','LV1',N'Chưa đặt'),

('C1',N'Ghế C1','PC4','LV1',N'Chưa đặt'),
('C2',N'Ghế C2','PC4','LV1',N'Chưa đặt'),
('C3',N'Ghế C3','PC4','LV1',N'Chưa đặt'),
('C4',N'Ghế C4','PC4','LV1',N'Chưa đặt'),
('C5',N'Ghế C5','PC4','LV1',N'Chưa đặt'),
('C6',N'Ghế C6','PC4','LV1',N'Chưa đặt'),
('C7',N'Ghế C7','PC4','LV1',N'Chưa đặt'),
('C8',N'Ghế C8','PC4','LV1',N'Chưa đặt'),
('C9',N'Ghế C9','PC4','LV1',N'Chưa đặt'),
('C10',N'Ghế C10','PC4','LV1',N'Chưa đặt'),
('C11',N'Ghế C11','PC4','LV1',N'Chưa đặt'),

('D1',N'Ghế D1','PC4','LV1',N'Chưa đặt'),
('D2',N'Ghế D2','PC4','LV1',N'Chưa đặt'),
('D3',N'Ghế D3','PC4','LV1',N'Chưa đặt'),
('D4',N'Ghế D4','PC4','LV1',N'Chưa đặt'),
('D5',N'Ghế D5','PC4','LV1',N'Chưa đặt'),
('D6',N'Ghế D6','PC4','LV1',N'Chưa đặt'),
('D7',N'Ghế D7','PC4','LV1',N'Chưa đặt'),
('D8',N'Ghế D8','PC4','LV1',N'Chưa đặt'),
('D9',N'Ghế D9','PC4','LV1',N'Chưa đặt'),
('D10',N'Ghế D10','PC4','LV1',N'Chưa đặt'),
('D11',N'Ghế D11','PC4','LV1',N'Chưa đặt'),

('E1',N'Ghế E1','PC4','LV2',N'Chưa đặt'),
('E2',N'Ghế E2','PC4','LV2',N'Chưa đặt'),
('E3',N'Ghế E3','PC4','LV2',N'Chưa đặt'),
('E4',N'Ghế E4','PC4','LV2',N'Chưa đặt'),
('E5',N'Ghế E5','PC4','LV2',N'Chưa đặt'),
('E6',N'Ghế E6','PC4','LV2',N'Chưa đặt'),
('E7',N'Ghế E7','PC4','LV2',N'Chưa đặt'),
('E8',N'Ghế E8','PC4','LV2',N'Chưa đặt'),
('E9',N'Ghế E9','PC4','LV2',N'Chưa đặt'),
('E10',N'Ghế E10','PC4','LV2',N'Chưa đặt'),
('E11',N'Ghế E11','PC4','LV2',N'Chưa đặt'),

('F1',N'Ghế F1','PC4','LV2',N'Chưa đặt'),
('F2',N'Ghế F2','PC4','LV2',N'Chưa đặt'),
('F3',N'Ghế F3','PC4','LV2',N'Chưa đặt'),
('F4',N'Ghế F4','PC4','LV2',N'Chưa đặt'),
('F5',N'Ghế F5','PC4','LV2',N'Chưa đặt'),
('F6',N'Ghế F6','PC4','LV2',N'Chưa đặt'),
('F7',N'Ghế F7','PC4','LV2',N'Chưa đặt'),
('F8',N'Ghế F8','PC4','LV2',N'Chưa đặt'),
('F9',N'Ghế F9','PC4','LV2',N'Chưa đặt'),
('F10',N'Ghế F10','PC4','LV2',N'Chưa đặt'),
('F11',N'Ghế F11','PC4','LV2',N'Chưa đặt'),

('G1',N'Ghế G1','PC4','LV2',N'Chưa đặt'),
('G2',N'Ghế G2','PC4','LV2',N'Chưa đặt'),
('G3',N'Ghế G3','PC4','LV2',N'Chưa đặt'),
('G4',N'Ghế G4','PC4','LV2',N'Chưa đặt'),
('G5',N'Ghế G5','PC4','LV2',N'Chưa đặt'),
('G6',N'Ghế G6','PC4','LV2',N'Chưa đặt'),
('G7',N'Ghế G7','PC4','LV2',N'Chưa đặt'),
('G8',N'Ghế G8','PC4','LV2',N'Chưa đặt'),
('G9',N'Ghế G9','PC4','LV2',N'Chưa đặt'),
('G10',N'Ghế G10','PC4','LV2',N'Chưa đặt'),
('G11',N'Ghế G11','PC4','LV2',N'Chưa đặt'),
('H1',N'Ghế H1','PC4','LV3',N'Chưa đặt'),

('H2',N'Ghế H2','PC4','LV3',N'Chưa đặt'),
('H3',N'Ghế H3','PC4','LV3',N'Chưa đặt'),
('H4',N'Ghế H4','PC4','LV3',N'Chưa đặt'),
('H5',N'Ghế H5','PC4','LV3',N'Chưa đặt'),
('H6',N'Ghế H6','PC4','LV3',N'Chưa đặt'),
('H7',N'Ghế H7','PC4','LV3',N'Chưa đặt'),
('H8',N'Ghế H8','PC4','LV3',N'Chưa đặt'),
('H9',N'Ghế H9','PC4','LV3',N'Chưa đặt'),
('H10',N'Ghế H10','PC4','LV3',N'Chưa đặt'),
('H11',N'Ghế H11','PC4','LV3',N'Chưa đặt')

--PC5
GO
INSERT INTO CHITIETCHONGOI(MAGHE,TENGHE,MAPC,MALV,TRANGTHAI) VALUES 
('A1',N'Ghế A1','PC5','LV1',N'Chưa đặt'),
('A2',N'Ghế A2','PC5','LV1',N'Chưa đặt'),
('A3',N'Ghế A3','PC5','LV1',N'Chưa đặt'),
('A4',N'Ghế A4','PC5','LV1',N'Chưa đặt'),
('A5',N'Ghế A5','PC5','LV1',N'Chưa đặt'),
('A6',N'Ghế A6','PC5','LV1',N'Chưa đặt'),
('A7',N'Ghế A7','PC5','LV1',N'Chưa đặt'),
('A8',N'Ghế A8','PC5','LV1',N'Chưa đặt'),
('A9',N'Ghế A9','PC5','LV1',N'Chưa đặt'),
('A10',N'Ghế A10','PC5','LV1',N'Chưa đặt'),
('A11',N'Ghế A11','PC5','LV1',N'Chưa đặt'),

('B1',N'Ghế B1','PC5','LV1',N'Chưa đặt'),
('B2',N'Ghế B2','PC5','LV1',N'Chưa đặt'),
('B3',N'Ghế B3','PC5','LV1',N'Chưa đặt'),
('B4',N'Ghế B4','PC5','LV1',N'Chưa đặt'),
('B5',N'Ghế B5','PC5','LV1',N'Chưa đặt'),
('B6',N'Ghế B6','PC5','LV1',N'Chưa đặt'),
('B7',N'Ghế B7','PC5','LV1',N'Chưa đặt'),
('B8',N'Ghế B8','PC5','LV1',N'Chưa đặt'),
('B9',N'Ghế B9','PC5','LV1',N'Chưa đặt'),
('B10',N'Ghế B10','PC5','LV1',N'Chưa đặt'),
('B11',N'Ghế B11','PC5','LV1',N'Chưa đặt'),

('C1',N'Ghế C1','PC5','LV1',N'Chưa đặt'),
('C2',N'Ghế C2','PC5','LV1',N'Chưa đặt'),
('C3',N'Ghế C3','PC5','LV1',N'Chưa đặt'),
('C4',N'Ghế C4','PC5','LV1',N'Chưa đặt'),
('C5',N'Ghế C5','PC5','LV1',N'Chưa đặt'),
('C6',N'Ghế C6','PC5','LV1',N'Chưa đặt'),
('C7',N'Ghế C7','PC5','LV1',N'Chưa đặt'),
('C8',N'Ghế C8','PC5','LV1',N'Chưa đặt'),
('C9',N'Ghế C9','PC5','LV1',N'Chưa đặt'),
('C10',N'Ghế C10','PC5','LV1',N'Chưa đặt'),
('C11',N'Ghế C11','PC5','LV1',N'Chưa đặt'),

('D1',N'Ghế D1','PC5','LV1',N'Chưa đặt'),
('D2',N'Ghế D2','PC5','LV1',N'Chưa đặt'),
('D3',N'Ghế D3','PC5','LV1',N'Chưa đặt'),
('D4',N'Ghế D4','PC5','LV1',N'Chưa đặt'),
('D5',N'Ghế D5','PC5','LV1',N'Chưa đặt'),
('D6',N'Ghế D6','PC5','LV1',N'Chưa đặt'),
('D7',N'Ghế D7','PC5','LV1',N'Chưa đặt'),
('D8',N'Ghế D8','PC5','LV1',N'Chưa đặt'),
('D9',N'Ghế D9','PC5','LV1',N'Chưa đặt'),
('D10',N'Ghế D10','PC5','LV1',N'Chưa đặt'),
('D11',N'Ghế D11','PC5','LV1',N'Chưa đặt'),

('E1',N'Ghế E1','PC5','LV2',N'Chưa đặt'),
('E2',N'Ghế E2','PC5','LV2',N'Chưa đặt'),
('E3',N'Ghế E3','PC5','LV2',N'Chưa đặt'),
('E4',N'Ghế E4','PC5','LV2',N'Chưa đặt'),
('E5',N'Ghế E5','PC5','LV2',N'Chưa đặt'),
('E6',N'Ghế E6','PC5','LV2',N'Chưa đặt'),
('E7',N'Ghế E7','PC5','LV2',N'Chưa đặt'),
('E8',N'Ghế E8','PC5','LV2',N'Chưa đặt'),
('E9',N'Ghế E9','PC5','LV2',N'Chưa đặt'),
('E10',N'Ghế E10','PC5','LV2',N'Chưa đặt'),
('E11',N'Ghế E11','PC5','LV2',N'Chưa đặt'),

('F1',N'Ghế F1','PC5','LV2',N'Chưa đặt'),
('F2',N'Ghế F2','PC5','LV2',N'Chưa đặt'),
('F3',N'Ghế F3','PC5','LV2',N'Chưa đặt'),
('F4',N'Ghế F4','PC5','LV2',N'Chưa đặt'),
('F5',N'Ghế F5','PC5','LV2',N'Chưa đặt'),
('F6',N'Ghế F6','PC5','LV2',N'Chưa đặt'),
('F7',N'Ghế F7','PC5','LV2',N'Chưa đặt'),
('F8',N'Ghế F8','PC5','LV2',N'Chưa đặt'),
('F9',N'Ghế F9','PC5','LV2',N'Chưa đặt'),
('F10',N'Ghế F10','PC5','LV2',N'Chưa đặt'),
('F11',N'Ghế F11','PC5','LV2',N'Chưa đặt'),

('G1',N'Ghế G1','PC5','LV2',N'Chưa đặt'),
('G2',N'Ghế G2','PC5','LV2',N'Chưa đặt'),
('G3',N'Ghế G3','PC5','LV2',N'Chưa đặt'),
('G4',N'Ghế G4','PC5','LV2',N'Chưa đặt'),
('G5',N'Ghế G5','PC5','LV2',N'Chưa đặt'),
('G6',N'Ghế G6','PC5','LV2',N'Chưa đặt'),
('G7',N'Ghế G7','PC5','LV2',N'Chưa đặt'),
('G8',N'Ghế G8','PC5','LV2',N'Chưa đặt'),
('G9',N'Ghế G9','PC5','LV2',N'Chưa đặt'),
('G10',N'Ghế G10','PC5','LV2',N'Chưa đặt'),
('G11',N'Ghế G11','PC5','LV2',N'Chưa đặt'),
('H1',N'Ghế H1','PC5','LV3',N'Chưa đặt'),

('H2',N'Ghế H2','PC5','LV3',N'Chưa đặt'),
('H3',N'Ghế H3','PC5','LV3',N'Chưa đặt'),
('H4',N'Ghế H4','PC5','LV3',N'Chưa đặt'),
('H5',N'Ghế H5','PC5','LV3',N'Chưa đặt'),
('H6',N'Ghế H6','PC5','LV3',N'Chưa đặt'),
('H7',N'Ghế H7','PC5','LV3',N'Chưa đặt'),
('H8',N'Ghế H8','PC5','LV3',N'Chưa đặt'),
('H9',N'Ghế H9','PC5','LV3',N'Chưa đặt'),
('H10',N'Ghế H10','PC5','LV3',N'Chưa đặt'),
('H11',N'Ghế H11','PC5','LV3',N'Chưa đặt')

GO
SET DATEFORMAT DMY
INSERT INTO HOADON VALUES('HD1','15/1/2020 14:00:00','KH1',0),--1444277
 ('HD2', '16/1/2020 10:04:00','KH2', 0),--3660700.0
 ('HD3', '16/1/2020 21:18', 'KH4',0 )--654725.0
-- select * from hoadon
-- select * from cthd
GO
INSERT INTO CTHD VALUES('HD1','A1','PC1',0)
INSERT INTO CTHD VALUES('HD1','A2','PC1',0)
INSERT INTO CTHD VALUES('HD2','A3','PC1',0)
INSERT INTO CTHD VALUES('HD2','A4','PC1',40000)
INSERT INTO CTHD VALUES('HD2','A5','PC1',30000)
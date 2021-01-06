﻿create database DOAN
GO
use DOAN

GO
CREATE TABLE KHACHHANGTHANTHIET
(
    STT INT IDENTITY,
	MAKH VARCHAR(10) NOT NULL PRIMARY KEY ,
	HOTEN NVARCHAR(40) NOT NULL ,
	DIACHI NVARCHAR(100) NOT NULL ,
	NGAYSINH DATE NOT NULL,
	GIOITINH NVARCHAR(4) check (GIOITINH IN ('Nam',N'Nữ')) NOT NULL,
	SDT VARCHAR(20) NOT NULL,
	LOAIKH NVARCHAR(50) NOT NULL DEFAULT(N'Đồng'),
	NGAYDK DATE NOT NULL,
	TONGCHITIEU MONEY DEFAULT(0) NOT NULL,
	EMAIL VARCHAR(100) DEFAULT('abc@gmail.com') NOT NULL
)


go
CREATE TABLE DANGNHAP_KHACHHANG
(
MAKH VARCHAR(10),
TAIKHOAN VARCHAR(50),
MATKHAU VARCHAR(50),
CONSTRAINT PK_DANGNHAP_KHACHHANG PRIMARY KEY(MAKH,MATKHAU),
CONSTRAINT FK_DANGNHAP_KHACHHANG_MAKH FOREIGN KEY(MAKH) REFERENCES KHACHHANGTHANTHIET(MAKH) ON DELETE CASCADE
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
	THOILUONG NVARCHAR(100),
	POSTER NVARCHAR(100),
	NGONNGU NVARCHAR(100),
	NGAYBATDAU DATE,
	NGAYKETTHUC DATE,
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
CREATE TABLE CACHIEU -- các suất chiếu , 12-2h, 2h-4 , ....
(
    STT INT IDENTITY,
	MACC VARCHAR(10) PRIMARY KEY, -- mã ca chiếu
	TENCC NVARCHAR(100), -- tên ca chiếu : ca 1, ca 2,...
	GIOBATDAU TIME,
	GIOKETTHUC TIME
)

--SELECT CAST(GETDATE() AS DATE)

GO
CREATE TABLE LICHCHIEU
(
    STT INT IDENTITY,
	MALC VARCHAR(10) PRIMARY KEY, -- mã lịch chiếu
	MAPHIM VARCHAR(10), -- phim được chiếu
	MACC VARCHAR(10), -- CA CHIẾU
	MAPC VARCHAR(10), -- Phòng chiếu
	NGAYCHIEU DATE,
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
LOAICHONGOI NVARCHAR(100), -- LOAI CHO NGOI
GIA MONEY
)

-- table chỗ ngồi : có trạng thái ( đặt, chưa đặt)
go
CREATE TABLE GHE -- CHỖ NGỒI
(
    STT INT IDENTITY,
	MAGHE VARCHAR(10),
	TENGHE NVARCHAR(40),
	MAPC VARCHAR(10), -- mã phòng chiếu, ví dụ ghế này ở phòng chiếu 1 thì MAPC = 1
	MACC VARCHAR(10),
	MALV VARCHAR(10), -- mã loại vé : ví dụ ghế này thuộc hàng ghế VIP thì lấy giá tiền ở loại vé VIP thay vì phải nhập giá ghế
	TRANGTHAI NVARCHAR(10) CHECK (TRANGTHAI IN(N'Đặt',N'Chưa đặt')),
	NGAYCHIEU DATETIME,
	CONSTRAINT PK_GHE PRIMARY KEY(MAGHE,NGAYCHIEU),
	CONSTRAINT FK_GHE_MAPC FOREIGN KEY(MAPC) REFERENCES PHONGCHIEU(MAPC) ON DELETE CASCADE,
	CONSTRAINT FK_GHE_LOAICHONGOI FOREIGN KEY(MALV) REFERENCES LOAIVE(MALV) ON DELETE CASCADE
)
-- drop table GHE

GO
CREATE TABLE VE
(
STT INT IDENTITY,
MAVE VARCHAR(10) PRIMARY KEY,
MALC VARCHAR(10),
NGAY_GIO_MUA DATETIME,
TONGCONG MONEY,
MAKH VARCHAR(10),
CONSTRAINT FK_VE_MALC FOREIGN KEY(MALC) REFERENCES LICHCHIEU(MALC) ON DELETE CASCADE,
CONSTRAINT FK_VE_MAKH FOREIGN KEY(MAKH) REFERENCES KHACHHANGTHANTHIET(MAKH) ON DELETE CASCADE
)


GO
CREATE TABLE CT_VE
(
MAVE VARCHAR(10),
MAGHE VARCHAR(10),
NGAYCHIEU DATETIME,
THANHTIEN MONEY,
CONSTRAINT PK_CT_VE PRIMARY KEY(MAVE,MAGHE,NGAYCHIEU),
CONSTRAINT FK_CT_VE_MAVE FOREIGN KEY(MAVE) REFERENCES VE(MAVE) ON DELETE CASCADE,
CONSTRAINT FK_CT_VE_MAGHE_NGAYCHIEU FOREIGN KEY(MAGHE,NGAYCHIEU) REFERENCES GHE(MAGHE,NGAYCHIEU)
)
-- DROP TABLE CT_VE

GO
SET DATEFORMAT DMY

GO
CREATE TRIGGER TRIGGER_UPDATE_THANHTIEN_CTHD ON CT_VE
FOR INSERT AS
BEGIN
UPDATE CT_VE
SET CT_VE.THANHTIEN=(SELECT LV.GIA
					FROM LOAIVE LV JOIN GHE G ON G.MALV=LV.MALV
					JOIN CT_VE ON CT_VE.MAGHE = G.MAGHE AND CT_VE.NGAYCHIEU=G.NGAYCHIEU
					JOIN inserted I ON I.MAGHE=G.MAGHE
					WHERE CT_VE.MAVE=I.MAVE AND I.MAGHE=CT_VE.MAGHE 
					AND CT_VE.NGAYCHIEU=I.NGAYCHIEU)
WHERE EXISTS (SELECT *
               FROM INSERTED 
		       WHERE INSERTED.MAVE=CT_VE.MAVE AND INSERTED.MAGHE=CT_VE.MAGHE
			   AND CT_VE.NGAYCHIEU=INSERTED.NGAYCHIEU)-- CHỈ SELECT NHỮNG SP ĐƯỢC XUẤT
END
-- DROP TRIGGER TRIGGER_UPDATE_THANHTIEN_CTHD

GO
--SELECT *
--FROM LOAIVE LV JOIN GHE G ON G.MALV=LV.MALV
--JOIN CT_VE ON CT_VE.MAGHE = G.MAGHE AND CT_VE.NGAYCHIEU=G.NGAYCHIEU
--WHERE CT_VE.MAVE='HD1' AND CT_VE.NGAYCHIEU='5/1/2021' AND CT_VE.MAGHE='A1PC1CC1'
GO

GO
CREATE TRIGGER TRIGGER_UPDATE_TONGCONG_HOADON_AFTER_CTHD ON CT_VE
-- TĂNG TIỀN TỔNG CỘNG MỖI KHI NHẬP 1 CT_VE
AFTER INSERT AS
BEGIN
UPDATE VE
SET VE.TONGCONG=VE.TONGCONG+(SELECT CT_VE.THANHTIEN
            FROM CT_VE, inserted I
			WHERE CT_VE.MAVE=VE.MAVE
			AND I.MAVE=CT_VE.MAVE
			AND CT_VE.MAGHE=I.MAGHE
			AND CT_VE.NGAYCHIEU=I.NGAYCHIEU)
-- AND CT_VE.MAGHE=I.MAGHE AND CT_VE.MAPC=I.MAPC : tránh lỗi trả về nhiều kết quả khi MAVE='HD1'
WHERE EXISTS (SELECT *
              FROM CT_VE, inserted I
			  WHERE CT_VE.MAVE=VE.MAVE
			  AND I.MAVE=CT_VE.MAVE
			  AND CT_VE.MAGHE=I.MAGHE
			  AND CT_VE.NGAYCHIEU=I.NGAYCHIEU)-- CHỈ SELECT NHỮNG SP ĐƯỢC XUẤT
END

GO
CREATE TRIGGER TRIGGER_UPDATE_TONGCHITIEU_KHACHANG ON CT_VE
-- TĂNG TIỀN TỔNG CỘNG MỖI KHI NHẬP 1 CT_VE
AFTER INSERT AS
BEGIN
UPDATE KHACHHANGTHANTHIET
SET TONGCHITIEU = TONGCHITIEU + (SELECT CT_VE.THANHTIEN
								 FROM CT_VE, inserted I, VE
								 WHERE CT_VE.MAVE=VE.MAVE
								 AND I.MAVE=CT_VE.MAVE
								 AND CT_VE.MAGHE=I.MAGHE
								 AND VE.MAKH=KHACHHANGTHANTHIET.MAKH 
								 AND CT_VE.NGAYCHIEU=I.NGAYCHIEU)
WHERE EXISTS (SELECT *
              FROM CT_VE, inserted I, VE
			  WHERE CT_VE.MAVE=VE.MAVE
			  AND I.MAVE=CT_VE.MAVE
			  AND CT_VE.MAGHE=I.MAGHE
			  AND VE.MAKH=KHACHHANGTHANTHIET.MAKH 
			  AND CT_VE.NGAYCHIEU=I.NGAYCHIEU)
			  -- CHỈ SELECT NHỮNG SP ĐƯỢC XUẤT
END
go
--select * from VE
--select * from CT_VE
--select * from KHACHHANGTHANTHIET
--SELECT *
--FROM CT_VE,VE
--WHERE CT_VE.MAVE=VE.MAVE
--AND VE.MAKH='kh2'
--AND CT_VE.NGAYCHIEU='6/1/2021'
--and CT_VE.MAGHE='a1pc1cc1'
go

GO
CREATE TRIGGER TRIGGER_UPDATE_TRANGTHAI_GHE ON CT_VE
-- 
AFTER INSERT AS
BEGIN
 UPDATE GHE
 SET GHE.TRANGTHAI = N'Đặt'
 WHERE GHE.MAGHE = (SELECT I.MAGHE
               FROM INSERTED I 
			   JOIN VE ON VE.MAVE = I.MAVE
			   JOIN LICHCHIEU LC ON LC.MALC = VE.MALC
			   JOIN GHE ON I.MAGHE=GHE.MAGHE
			   WHERE  LC.MALC = VE.MALC AND LC.NGAYCHIEU=GHE.NGAYCHIEU)-- CHỈ SELECT NHỮNG SP ĐƯỢC XUẤT
   AND GHE.NGAYCHIEU = (SELECT GHE.NGAYCHIEU
               FROM INSERTED I 
			   JOIN VE ON VE.MAVE = I.MAVE
			   JOIN LICHCHIEU LC ON LC.MALC = VE.MALC
			   JOIN GHE ON I.MAGHE=GHE.MAGHE
			   WHERE  LC.MALC = VE.MALC AND LC.NGAYCHIEU=GHE.NGAYCHIEU)
END


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
-- SELECT * FROM KHACHHANGTHANTHIET
GO
---PROC THEMKHACHHANG
create PROC Them_khachhang( @makh varchar(10),@hoten NVARCHAR(40),@diachi NVARCHAR(100),@ngaysinh DATE,@gioitinh nvarchar(4), @sdt varchar(20) ,@loaikh NVARCHAR(50),@ngaydk date)
as
begin
 insert into KHACHHANGTHANTHIET(MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES (@makh,@hoten,@diachi,@sdt,@ngaysinh,@gioitinh,@loaikh,@ngaydk)
end

GO
CREATE PROC SuaKhachHang(@makh varchar(10),@hoten NVARCHAR(40),@diachi NVARCHAR(100),@ngaysinh DATE,@gioitinh nvarchar(4), @sdt varchar(20) ,@loaikh NVARCHAR(50),@ngaydk date)
as begin
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
----PROC TIMTHEOmakh
CREATE PROC TimKH_theo_MAKH(@makh varchar(10))
as begin
select * from KHACHHANGTHANTHIET where MAKH like '%'+ @makh +'%'
end
-- exec TimKH_theo_MAKH 'kh1'

GO
CREATE PROC TimTheoMaP(@map varchar(10))
as
begin
select * from PHIM where MAPHIM like '%'+ @map +'%'
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

go
create proc LoadDSPhim
as 
begin 
select *
from PHIM 
ORDER BY STT ASC
end

go
create proc LoadDSPhongChieu
as 
begin 
select * from PHONGCHIEU ORDER BY STT ASC
end

go
CREATE PROC LoadDSLichChieu
as
BEGIN
SELECT LC.STT,TENPHIM,TENPC,TENCC,LC.MAPHIM,LC.MACC,LC.MAPC
FROM LICHCHIEU LC
INNER JOIN PHIM ON LC.MAPHIM=PHIM.MAPHIM
INNER JOIN PHONGCHIEU PC ON LC.MAPC=PC.MAPC
INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
ORDER BY NGAYBATDAU ASC
END

GO
CREATE PROC LoadDSNgayChieu
AS
BEGIN
 SELECT NGAYCHIEU
 FROM LICHCHIEU 
 GROUP BY NGAYCHIEU
 ORDER BY NGAYCHIEU ASC
END

go
CREATE PROC LoadDSCaChieu
as
BEGIN
select * from CACHIEU ORDER BY STT ASC
END

go
CREATE PROC HienLichChieuPhim(@ngaychieu date,@macc varchar(10))
  as
  BEGIN
SELECT pc.TENPC,LC.NGAYCHIEU,PHIM.NGAYBATDAU,PHIM.NGAYKETTHUC,TENPHIM
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
where lc.NGAYCHIEU=@ngaychieu  and CC.MACC=@macc
order by pc.MAPC asc
end

go
 CREATE PROC HienLichChieuPhim_NgayChieu_MaCC_MaPC(@ngaychieu date,@macc varchar(10),@mapc varchar(10))
  as
  BEGIN
SELECT pc.TENPC,LC.NGAYCHIEU,PHIM.NGAYBATDAU,PHIM.NGAYKETTHUC,TENPHIM
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
where lc.NGAYCHIEU=@ngaychieu  and CC.MACC=@macc and pc.MAPC=@mapc
end

go
CREATE PROC DatVe_Phim_NgayChieu(@maphim varchar(10),@ngaychieu datetime)
as
BEGIN
SELECT pc.MAPC,PC.TENPC,LC.NGAYCHIEU,CC.MACC,CC.GIOBATDAU,CC.GIOKETTHUC
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
where LC.MAPHIM=@maphim AND LC.NGAYCHIEU=@ngaychieu
END

go
CREATE PROC DatVe_Load_ChonChoNgoi(@maphim varchar(10),@ngaychieu datetime,@macc varchar(10))
as
BEGIN
SELECT pc.TENPC,CC.GIOBATDAU,CC.GIOKETTHUC,TENPHIM,PC.MAPC
FROM LICHCHIEU LC INNER JOIN CACHIEU CC ON LC.MACC=CC.MACC
JOIN PHIM ON PHIM.MAPHIM=LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC=LC.MAPC
where LC.MAPHIM=@maphim AND LC.NGAYCHIEU=@ngaychieu AND LC.MACC=@macc
END
-- drop proc DatVe_Load_ChonChoNgoi
--  EXEC DatVe_Load_ChonChoNgoi 'PHIM1','05/01/2021','CC1'
-- select * from lichchieu
go
CREATE PROC Load_DSGhe(@ngaychieu date,@macc varchar(10),@maphim varchar(10))
as BEGIN
SELECT GHE.MAGHE,GHE.TENGHE,GHE.TRANGTHAI,LV.GIA
FROM GHE
join LICHCHIEU LC ON LC.NGAYCHIEU=GHE.NGAYCHIEU AND LC.MACC=GHE.MACC AND LC.MAPC=GHE.MAPC
join LOAIVE LV ON LV.MALV=GHE.MALV
WHERE ghe.NGAYCHIEU = @ngaychieu
and LC.MACC=@macc
and LC.MAPHIM=@maphim
order by GHE.STT asc
END 
-- exec Load_DSGhe  '05/01/2021','CC1','PHIM1'

go
CREATE PROC GetMALC(@ngaychieu date,@macc varchar(10),@maphim varchar(10))
as BEGIN
select MALC
from LICHCHIEU
where MACC=@macc and MAPHIM=@maphim and NGAYCHIEU=@ngaychieu
END 

GO
CREATE PROC LoadDSVe
AS BEGIN
SELECT *
FROM VE
ORDER BY STT ASC
END

GO
create PROC ThemVe(@MAVE varchar(10),@MALC NVARCHAR(10),@NGAY_GIO_MUA DATETIME,@TONGCONG MONEY,@MAKH VARCHAR(10))
as
begin
insert into VE(MAVE,MALC,NGAY_GIO_MUA,MAKH,TONGCONG)
VALUES (@MAVE,@MALC,@NGAY_GIO_MUA,@MAKH,@TONGCONG)
end

GO
create PROC ThemCTVe(@MAVE varchar(10),@MAGHE NVARCHAR(10),@NGAYCHIEU DATE,@THANHTIEN MONEY)
as
begin
insert into CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN)
VALUES (@MAVE,@MAGHE,@NGAYCHIEU,@THANHTIEN)
end

GO
create PROC HuyVe(@MAVE varchar(10))
as
begin
DELETE  FROM [VE]
WHERE MAVE=@MAVE;
end

GO
create PROC LoadDataGrid_LichSuDatVe(@MAKH varchar(10))
as
begin
SELECT VE.NGAY_GIO_MUA as "Ngày giờ mua",VE.TONGCONG as "Tổng cộng",VE.MAVE
FROM KHACHHANGTHANTHIET KH JOIN VE ON VE.MAKH = KH.MAKH
WHERE KH.MAKH=@MAKH
GROUP BY VE.NGAY_GIO_MUA,VE.TONGCONG,VE.MAVE
ORDER BY VE.NGAY_GIO_MUA ASC
END

GO
create PROC LichSuDatVe_LayThongTinChiTiet(@MAKH varchar(10), @MAVE varchar(10))
as begin
select PHIM.TENPHIM,LC.NGAYCHIEU,PC.TENPC,CC.GIOBATDAU,CC.GIOKETTHUC
FROM VE JOIN LICHCHIEU LC ON LC.MALC=VE.MALC
JOIN PHIM ON PHIM.MAPHIM = LC.MAPHIM
JOIN PHONGCHIEU PC ON PC.MAPC = LC.MAPC
JOIN CACHIEU CC ON CC.MACC=LC.MACC
WHERE VE.MAVE=@MAVE AND VE.MAKH=@MAKH
END 

GO
create PROC LichSuDatVe_LayDSGhe(@MAKH varchar(10), @MAVE varchar(10))
as begin
SELECT GHE.MAGHE
FROM VE JOIN CT_VE CTV ON VE.MAVE=CTV.MAVE
JOIN GHE ON GHE.MAGHE=CTV.MAGHE AND CTV.NGAYCHIEU=GHE.NGAYCHIEU
WHERE VE.MAKH=@MAKH AND VE.MAVE=@MAVE
END

GO
INSERT INTO KHACHHANGTHANTHIET (MAKH,HOTEN,DIACHI,SDT,NGAYSINH,GIOITINH,LOAIKH,NGAYDK) VALUES 
('KH1',N'Nguyễn Văn An',N'731 Trần Hưng Đạo, Q5, TpHCM','08823451','22/10/1960','Nam',N'Đồng','22/07/2018'),
('KH2',N'Trần Ngọc Hân',N'23/5 Nguyễn Trãi, Q5, TpHCM','0908256478','3/4/1974',N'Nữ',N'Đồng','30/07/2018'),
('KH3',N'Trần Ngọc Linh',N'45 Nguyen Tất Thành, Q1, TpHCM','0938776266','12/6/1980',N'Nữ',N'Đồng','05/08/2018'),
('KH4',N'Trần Minh Long',N'50/34 Lê Đại Hành, Q10, TpHCM','0917325476','9/3/1965','Nam',N'Đồng','02/10/2017')

GO
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH1','thanhphuong','thanhphuong')
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH2','thienhuong','thienhuong')
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH3','trungquan','trungquan')
INSERT INTO DANGNHAP_KHACHHANG VALUES ('KH4','tranthanh','tranthanh')


GO
INSERT INTO PHONGCHIEU(MAPC,TENPC,SOCHO,MAYCHIEU,LOA,DIENTICH,TINHTRANG,TRANGTHIETBIKHAC) VALUES 
('PC1',N'Phòng chiếu 1',200,N'Viewsonic PX727 4K HDR (US)',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-299',200,N'Tốt',N'Có'),
('PC2',N'Phòng chiếu 2',150,N'Viewsonic PX747 4K (US)',N'Bộ dàn âm thanh xem phim 5.1 Yamaha YHT-196',150,N'Tốt',N'Không')


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
INSERT INTO PHIM(MAPHIM,TENPHIM,DAODIEN,DIENVIEN,NOIDUNG,NAMSX,NUOCSX,THOILUONG,POSTER,NGONNGU,NGAYBATDAU,NGAYKETTHUC) VALUES 
('PHIM1',N'Quái Vật Venom',N'Ruben Fleischer',N'Tom Hardy, Michelle William, Riz Ahmed',N'Quái Vật Venom là một kẻ thù nguy hiểm và nặng ký của Người nhện trong loạt series của Marvel. Chàng phóng viên Eddie Brock (do Tom Hardy thủ vai) bí mật theo dõi âm mưu xấu xa của một tổ chức và đã không may mắn khi nhiễm phải loại cộng sinh trùng ngoài hành tinh (Symbiote) và từ đó đã không còn làm chủ bản thân về thể chất lẫn tinh thần. Điều này đã dần biến anh thành quái vật đen tối và nguy hiểm nhất chống lại người Nhện - Venom','2018',N'Mỹ',N'115 phút',
'Venom.png',N'Tiếng Việt','01/01/2021','15/02/2021'),
('PHIM2',N'Sword Art Online: Đao Kiếm Thần Vực',N'Tomohiko Ito',N'Haruka Tomatsu, Bryce Papenbrook, Yoshitsugu Matsuoka, Kanae Ito, Ayana Taketatsu',N'Con đường sống duy nhất là đánh bại mọi kẻ thù. Cái chết trong game đồng nghĩa với cái chết ngoài đời thực. Bằng Nerve Gear, mười ngàn con người lao đầu vào một trò chơi bí ẩn "Sword Art Online", để rồi bị giam cầm trong đó, buộc phải dấn thân vào một đấu trường sinh tử. Anh main của chúng ta, Kirito, một trong số các game thủ, đã nhận ra được "sự thật" khủng khiếp này. Anh đơn thương độc mã, chiến đấu trong một lâu đài bay khổng lồ-mang tên "Aincrad" Để có thể hoàn thành trò chơi và trở về với thực tại, anh phải vượt qua đủ 100 thử thách. Liệu anh có thể làm được hay anh sẽ về với cát bụi?','2013',N'Nhật Bản',N'24 phút/tập',
'SwordArtOnline.jpg',N'Tiếng Việt','01/01/2021','15/02/2021'),
('PHIM3',N'Weathering With You: Đứa Con Của Thời Tiết',N'Makoto Shinkai',N'Kotaro Daigo, Sei Hiraizumi, Tsubasa Honda, Yuki Kaji, Ryunosuke Kamiki, Nana Mori',N'Đứa Con Của Thời Tiết xoay quanh hai nhân vật: Hodaka và Hina. Hodaka là cậu thiếu niên sống trên một hòn đảo nhỏ, đã rời khỏi quê hương để đến Tokyo sầm uất. Tại đây, cậu quen biết với Hina - một cô gái kì lạ có năng lực thanh lọc bầu trời mỗi khi "cầu nguyện". Cô có khả năng chặn đứng cơn mưa và xua tan mây đen theo ý muốn.','2019',N'Nhật Bản',N'114 phút',
'DuaConCuaThoiTiet.jpg',N'Tiếng Việt','01/01/2021','15/02/2021'),
('PHIM4',N'Shokugeki no Souma ( Season 1): Vua Đầu Bếp Soma (Phần 1)',N'Yoshitomo Yonetani',N'Minami Takahashi, Ai Kayano, Risa Taneda, Saori Oonishi, Takahiro Sakurai, Natsuki Hanae',N'Yukihira Souma là đứa con trai duy nhất của một quán ăn bình dân, cậu có một khao khát cháy bỏng là vượt qua cha mình người đã đánh bại cậu liên tục 489 trận. Đến một ngày cậu nghe lời cha mình để vào trường đào tạo tài năng ẩm thực . Câu chuyện đời cậu sắp bước sang một ngã rẻ khác và nhìu thú vị hơn.','2015',N'Nhật Bản',N'24 phút/ tập',
'Shokugeki-no-Souma-SS2-Poster.jpg',N'Tiếng Việt','01/01/2021','15/02/2021')

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
INSERT INTO CACHIEU(MACC,TENCC,GIOBATDAU,GIOKETTHUC) VALUES 
('CC1',N'Ca 1','8:00:00','10:00:00'),
('CC2',N'Ca 2','10:00:00','12:00:00'),
('CC3',N'Ca 3','12:00:00','14:00:00'),
('CC4',N'Ca 4','14:00:00','16:00:00'),
('CC5',N'Ca 5','16:00:00','18:00:00'),
('CC6',N'Ca 6','18:00:00','20:00:00'),
('CC7',N'Ca 7','20:00:00','22:00:00')

GO
SET DATEFORMAT DMY
	
INSERT INTO LICHCHIEU(MALC,NGAYCHIEU,MAPHIM,MACC,MAPC) VALUES 
('LC1','05/01/2021','PHIM1','CC1','PC1'),
('LC2','05/01/2021','PHIM1','CC3','PC1'),
('LC3','05/01/2021','PHIM1','CC5','PC1'),
('LC4','05/01/2021','PHIM1','CC7','PC1'),
('LC5','05/01/2021','PHIM2','CC2','PC1'),
('LC6','05/01/2021','PHIM2','CC4','PC1'),
('LC7','05/01/2021','PHIM2','CC6','PC1'),

('LC8','05/01/2021','PHIM3','CC1','PC2'),
('LC9','05/01/2021','PHIM3','CC3','PC2'),
('LC10','05/01/2021','PHIM3','CC5','PC2'),
('LC11','05/01/2021','PHIM3','CC7','PC2'),
('LC12','05/01/2021','PHIM4','CC2','PC2'),
('LC13','05/01/2021','PHIM4','CC4','PC2'),
('LC14','05/01/2021','PHIM4','CC6','PC2'),

('LC15','06/01/2021','PHIM1','CC1','PC1'),
('LC16','06/01/2021','PHIM1','CC3','PC1'),
('LC17','06/01/2021','PHIM1','CC5','PC1'),
('LC18','06/01/2021','PHIM1','CC7','PC1'),
('LC19','06/01/2021','PHIM2','CC2','PC1'),
('LC20','06/01/2021','PHIM2','CC4','PC1'),
('LC21','06/01/2021','PHIM2','CC6','PC1'),

('LC22','06/01/2021','PHIM3','CC1','PC2'),
('LC23','06/01/2021','PHIM3','CC3','PC2'),
('LC24','06/01/2021','PHIM3','CC5','PC2'),
('LC25','06/01/2021','PHIM3','CC7','PC2'),
('LC26','06/01/2021','PHIM4','CC2','PC2'),
('LC27','06/01/2021','PHIM4','CC4','PC2'),
('LC28','06/01/2021','PHIM4','CC6','PC2')

GO
INSERT INTO LOAIVE(MALV,TENLV,LOAICHONGOI,GIA) VALUES 
('LV1',N'Vé thường',N'Ghế thường',40000),
('LV2',N'Vé VIP',N'Ghế VIP',50000),
('LV3',N'Vé đôi',N'Ghế đôi',110000)
-- select * from loaive

GO
-- PC1 , CC1
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC1',N'Ghế A1','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A2PC1CC1',N'Ghế A2','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A3PC1CC1',N'Ghế A3','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A4PC1CC1',N'Ghế A4','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A5PC1CC1',N'Ghế A5','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A6PC1CC1',N'Ghế A6','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A7PC1CC1',N'Ghế A7','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A8PC1CC1',N'Ghế A8','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A9PC1CC1',N'Ghế A9','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A10PC1CC1',N'Ghế A10','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A11PC1CC1',N'Ghế A11','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),

('B1PC1CC1',N'Ghế B1','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B2PC1CC1',N'Ghế B2','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B3PC1CC1',N'Ghế B3','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B4PC1CC1',N'Ghế B4','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B5PC1CC1',N'Ghế B5','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B6PC1CC1',N'Ghế B6','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B7PC1CC1',N'Ghế B7','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B8PC1CC1',N'Ghế B8','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B9PC1CC1',N'Ghế B9','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B10PC1CC1',N'Ghế B10','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B11PC1CC1',N'Ghế B11','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),

('C1PC1CC1',N'Ghế C1','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C2PC1CC1',N'Ghế C2','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C3PC1CC1',N'Ghế C3','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C4PC1CC1',N'Ghế C4','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C5PC1CC1',N'Ghế C5','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C6PC1CC1',N'Ghế C6','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C7PC1CC1',N'Ghế C7','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C8PC1CC1',N'Ghế C8','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C9PC1CC1',N'Ghế C9','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C10PC1CC1',N'Ghế C10','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C11PC1CC1',N'Ghế C11','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),

('D1PC1CC1',N'Ghế D1','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D2PC1CC1',N'Ghế D2','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D3PC1CC1',N'Ghế D3','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D4PC1CC1',N'Ghế D4','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D5PC1CC1',N'Ghế D5','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D6PC1CC1',N'Ghế D6','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D7PC1CC1',N'Ghế D7','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D8PC1CC1',N'Ghế D8','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D9PC1CC1',N'Ghế D9','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D10PC1CC1',N'Ghế D10','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D11PC1CC1',N'Ghế D11','PC1','CC1','LV1',N'Chưa đặt','05/01/2021'),

('E1PC1CC1',N'Ghế E1','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E2PC1CC1',N'Ghế E2','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E3PC1CC1',N'Ghế E3','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E4PC1CC1',N'Ghế E4','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E5PC1CC1',N'Ghế E5','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E6PC1CC1',N'Ghế E6','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E7PC1CC1',N'Ghế E7','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E8PC1CC1',N'Ghế E8','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E9PC1CC1',N'Ghế E9','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E10PC1CC1',N'Ghế E10','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E11PC1CC1',N'Ghế E11','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),

('F1PC1CC1',N'Ghế F1','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F2PC1CC1',N'Ghế F2','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F3PC1CC1',N'Ghế F3','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F4PC1CC1',N'Ghế F4','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F5PC1CC1',N'Ghế F5','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F6PC1CC1',N'Ghế F6','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F7PC1CC1',N'Ghế F7','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F8PC1CC1',N'Ghế F8','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F9PC1CC1',N'Ghế F9','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F10PC1CC1',N'Ghế F10','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F11PC1CC1',N'Ghế F11','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),

('G1PC1CC1',N'Ghế G1','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G2PC1CC1',N'Ghế G2','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G3PC1CC1',N'Ghế G3','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G4PC1CC1',N'Ghế G4','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G5PC1CC1',N'Ghế G5','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G6PC1CC1',N'Ghế G6','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G7PC1CC1',N'Ghế G7','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G8PC1CC1',N'Ghế G8','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G9PC1CC1',N'Ghế G9','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G10PC1CC1',N'Ghế G10','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G11PC1CC1',N'Ghế G11','PC1','CC1','LV2',N'Chưa đặt','05/01/2021'),
('H1PC1CC1',N'Ghế H1','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),

('H2PC1CC1',N'Ghế H2','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H3PC1CC1',N'Ghế H3','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H4PC1CC1',N'Ghế H4','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H5PC1CC1',N'Ghế H5','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H6PC1CC1',N'Ghế H6','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H7PC1CC1',N'Ghế H7','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H8PC1CC1',N'Ghế H8','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H9PC1CC1',N'Ghế H9','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H10PC1CC1',N'Ghế H10','PC1','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H11PC1CC1',N'Ghế H11','PC1','CC1','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC1 , CC2
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC2',N'Ghế A1','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A2PC1CC2',N'Ghế A2','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A3PC1CC2',N'Ghế A3','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A4PC1CC2',N'Ghế A4','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A5PC1CC2',N'Ghế A5','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A6PC1CC2',N'Ghế A6','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A7PC1CC2',N'Ghế A7','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A8PC1CC2',N'Ghế A8','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A9PC1CC2',N'Ghế A9','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A10PC1CC2',N'Ghế A10','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A11PC1CC2',N'Ghế A11','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),

('B1PC1CC2',N'Ghế B1','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B2PC1CC2',N'Ghế B2','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B3PC1CC2',N'Ghế B3','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B4PC1CC2',N'Ghế B4','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B5PC1CC2',N'Ghế B5','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B6PC1CC2',N'Ghế B6','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B7PC1CC2',N'Ghế B7','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B8PC1CC2',N'Ghế B8','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B9PC1CC2',N'Ghế B9','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B10PC1CC2',N'Ghế B10','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B11PC1CC2',N'Ghế B11','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),

('C1PC1CC2',N'Ghế C1','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C2PC1CC2',N'Ghế C2','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C3PC1CC2',N'Ghế C3','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C4PC1CC2',N'Ghế C4','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C5PC1CC2',N'Ghế C5','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C6PC1CC2',N'Ghế C6','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C7PC1CC2',N'Ghế C7','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C8PC1CC2',N'Ghế C8','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C9PC1CC2',N'Ghế C9','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C10PC1CC2',N'Ghế C10','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C11PC1CC2',N'Ghế C11','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),

('D1PC1CC2',N'Ghế D1','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D2PC1CC2',N'Ghế D2','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D3PC1CC2',N'Ghế D3','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D4PC1CC2',N'Ghế D4','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D5PC1CC2',N'Ghế D5','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D6PC1CC2',N'Ghế D6','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D7PC1CC2',N'Ghế D7','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D8PC1CC2',N'Ghế D8','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D9PC1CC2',N'Ghế D9','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D10PC1CC2',N'Ghế D10','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D11PC1CC2',N'Ghế D11','PC1','CC2','LV1',N'Chưa đặt','05/01/2021'),

('E1PC1CC2',N'Ghế E1','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E2PC1CC2',N'Ghế E2','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E3PC1CC2',N'Ghế E3','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E4PC1CC2',N'Ghế E4','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E5PC1CC2',N'Ghế E5','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E6PC1CC2',N'Ghế E6','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E7PC1CC2',N'Ghế E7','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E8PC1CC2',N'Ghế E8','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E9PC1CC2',N'Ghế E9','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E10PC1CC2',N'Ghế E10','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E11PC1CC2',N'Ghế E11','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),

('F1PC1CC2',N'Ghế F1','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F2PC1CC2',N'Ghế F2','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F3PC1CC2',N'Ghế F3','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F4PC1CC2',N'Ghế F4','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F5PC1CC2',N'Ghế F5','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F6PC1CC2',N'Ghế F6','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F7PC1CC2',N'Ghế F7','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F8PC1CC2',N'Ghế F8','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F9PC1CC2',N'Ghế F9','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F10PC1CC2',N'Ghế F10','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F11PC1CC2',N'Ghế F11','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),

('G1PC1CC2',N'Ghế G1','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G2PC1CC2',N'Ghế G2','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G3PC1CC2',N'Ghế G3','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G4PC1CC2',N'Ghế G4','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G5PC1CC2',N'Ghế G5','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G6PC1CC2',N'Ghế G6','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G7PC1CC2',N'Ghế G7','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G8PC1CC2',N'Ghế G8','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G9PC1CC2',N'Ghế G9','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G10PC1CC2',N'Ghế G10','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G11PC1CC2',N'Ghế G11','PC1','CC2','LV2',N'Chưa đặt','05/01/2021'),
('H1PC1CC2',N'Ghế H1','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),

('H2PC1CC2',N'Ghế H2','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H3PC1CC2',N'Ghế H3','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H4PC1CC2',N'Ghế H4','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H5PC1CC2',N'Ghế H5','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H6PC1CC2',N'Ghế H6','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H7PC1CC2',N'Ghế H7','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H8PC1CC2',N'Ghế H8','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H9PC1CC2',N'Ghế H9','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H10PC1CC2',N'Ghế H10','PC1','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H11PC1CC2',N'Ghế H11','PC1','CC2','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC1 , CC3
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC3',N'Ghế A1','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A2PC1CC3',N'Ghế A2','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A3PC1CC3',N'Ghế A3','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A4PC1CC3',N'Ghế A4','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A5PC1CC3',N'Ghế A5','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A6PC1CC3',N'Ghế A6','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A7PC1CC3',N'Ghế A7','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A8PC1CC3',N'Ghế A8','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A9PC1CC3',N'Ghế A9','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A10PC1CC3',N'Ghế A10','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A11PC1CC3',N'Ghế A11','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),

('B1PC1CC3',N'Ghế B1','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B2PC1CC3',N'Ghế B2','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B3PC1CC3',N'Ghế B3','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B4PC1CC3',N'Ghế B4','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B5PC1CC3',N'Ghế B5','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B6PC1CC3',N'Ghế B6','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B7PC1CC3',N'Ghế B7','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B8PC1CC3',N'Ghế B8','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B9PC1CC3',N'Ghế B9','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B10PC1CC3',N'Ghế B10','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B11PC1CC3',N'Ghế B11','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),

('C1PC1CC3',N'Ghế C1','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C2PC1CC3',N'Ghế C2','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C3PC1CC3',N'Ghế C3','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C4PC1CC3',N'Ghế C4','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C5PC1CC3',N'Ghế C5','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C6PC1CC3',N'Ghế C6','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C7PC1CC3',N'Ghế C7','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C8PC1CC3',N'Ghế C8','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C9PC1CC3',N'Ghế C9','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C10PC1CC3',N'Ghế C10','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C11PC1CC3',N'Ghế C11','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),

('D1PC1CC3',N'Ghế D1','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D2PC1CC3',N'Ghế D2','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D3PC1CC3',N'Ghế D3','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D4PC1CC3',N'Ghế D4','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D5PC1CC3',N'Ghế D5','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D6PC1CC3',N'Ghế D6','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D7PC1CC3',N'Ghế D7','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D8PC1CC3',N'Ghế D8','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D9PC1CC3',N'Ghế D9','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D10PC1CC3',N'Ghế D10','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D11PC1CC3',N'Ghế D11','PC1','CC3','LV1',N'Chưa đặt','05/01/2021'),

('E1PC1CC3',N'Ghế E1','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E2PC1CC3',N'Ghế E2','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E3PC1CC3',N'Ghế E3','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E4PC1CC3',N'Ghế E4','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E5PC1CC3',N'Ghế E5','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E6PC1CC3',N'Ghế E6','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E7PC1CC3',N'Ghế E7','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E8PC1CC3',N'Ghế E8','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E9PC1CC3',N'Ghế E9','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E10PC1CC3',N'Ghế E10','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E11PC1CC3',N'Ghế E11','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),

('F1PC1CC3',N'Ghế F1','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F2PC1CC3',N'Ghế F2','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F3PC1CC3',N'Ghế F3','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F4PC1CC3',N'Ghế F4','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F5PC1CC3',N'Ghế F5','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F6PC1CC3',N'Ghế F6','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F7PC1CC3',N'Ghế F7','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F8PC1CC3',N'Ghế F8','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F9PC1CC3',N'Ghế F9','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F10PC1CC3',N'Ghế F10','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F11PC1CC3',N'Ghế F11','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),

('G1PC1CC3',N'Ghế G1','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G2PC1CC3',N'Ghế G2','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G3PC1CC3',N'Ghế G3','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G4PC1CC3',N'Ghế G4','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G5PC1CC3',N'Ghế G5','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G6PC1CC3',N'Ghế G6','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G7PC1CC3',N'Ghế G7','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G8PC1CC3',N'Ghế G8','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G9PC1CC3',N'Ghế G9','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G10PC1CC3',N'Ghế G10','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G11PC1CC3',N'Ghế G11','PC1','CC3','LV2',N'Chưa đặt','05/01/2021'),
('H1PC1CC3',N'Ghế H1','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),

('H2PC1CC3',N'Ghế H2','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H3PC1CC3',N'Ghế H3','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H4PC1CC3',N'Ghế H4','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H5PC1CC3',N'Ghế H5','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H6PC1CC3',N'Ghế H6','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H7PC1CC3',N'Ghế H7','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H8PC1CC3',N'Ghế H8','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H9PC1CC3',N'Ghế H9','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H10PC1CC3',N'Ghế H10','PC1','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H11PC1CC3',N'Ghế H11','PC1','CC3','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC1 , CC4
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC4',N'Ghế A1','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A2PC1CC4',N'Ghế A2','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A3PC1CC4',N'Ghế A3','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A4PC1CC4',N'Ghế A4','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A5PC1CC4',N'Ghế A5','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A6PC1CC4',N'Ghế A6','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A7PC1CC4',N'Ghế A7','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A8PC1CC4',N'Ghế A8','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A9PC1CC4',N'Ghế A9','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A10PC1CC4',N'Ghế A10','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A11PC1CC4',N'Ghế A11','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),

('B1PC1CC4',N'Ghế B1','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B2PC1CC4',N'Ghế B2','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B3PC1CC4',N'Ghế B3','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B4PC1CC4',N'Ghế B4','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B5PC1CC4',N'Ghế B5','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B6PC1CC4',N'Ghế B6','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B7PC1CC4',N'Ghế B7','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B8PC1CC4',N'Ghế B8','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B9PC1CC4',N'Ghế B9','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B10PC1CC4',N'Ghế B10','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B11PC1CC4',N'Ghế B11','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),

('C1PC1CC4',N'Ghế C1','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C2PC1CC4',N'Ghế C2','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C3PC1CC4',N'Ghế C3','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C4PC1CC4',N'Ghế C4','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C5PC1CC4',N'Ghế C5','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C6PC1CC4',N'Ghế C6','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C7PC1CC4',N'Ghế C7','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C8PC1CC4',N'Ghế C8','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C9PC1CC4',N'Ghế C9','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C10PC1CC4',N'Ghế C10','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C11PC1CC4',N'Ghế C11','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),

('D1PC1CC4',N'Ghế D1','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D2PC1CC4',N'Ghế D2','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D3PC1CC4',N'Ghế D3','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D4PC1CC4',N'Ghế D4','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D5PC1CC4',N'Ghế D5','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D6PC1CC4',N'Ghế D6','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D7PC1CC4',N'Ghế D7','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D8PC1CC4',N'Ghế D8','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D9PC1CC4',N'Ghế D9','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D10PC1CC4',N'Ghế D10','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D11PC1CC4',N'Ghế D11','PC1','CC4','LV1',N'Chưa đặt','05/01/2021'),

('E1PC1CC4',N'Ghế E1','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E2PC1CC4',N'Ghế E2','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E3PC1CC4',N'Ghế E3','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E4PC1CC4',N'Ghế E4','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E5PC1CC4',N'Ghế E5','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E6PC1CC4',N'Ghế E6','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E7PC1CC4',N'Ghế E7','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E8PC1CC4',N'Ghế E8','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E9PC1CC4',N'Ghế E9','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E10PC1CC4',N'Ghế E10','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E11PC1CC4',N'Ghế E11','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),

('F1PC1CC4',N'Ghế F1','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F2PC1CC4',N'Ghế F2','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F3PC1CC4',N'Ghế F3','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F4PC1CC4',N'Ghế F4','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F5PC1CC4',N'Ghế F5','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F6PC1CC4',N'Ghế F6','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F7PC1CC4',N'Ghế F7','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F8PC1CC4',N'Ghế F8','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F9PC1CC4',N'Ghế F9','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F10PC1CC4',N'Ghế F10','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F11PC1CC4',N'Ghế F11','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),

('G1PC1CC4',N'Ghế G1','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G2PC1CC4',N'Ghế G2','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G3PC1CC4',N'Ghế G3','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G4PC1CC4',N'Ghế G4','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G5PC1CC4',N'Ghế G5','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G6PC1CC4',N'Ghế G6','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G7PC1CC4',N'Ghế G7','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G8PC1CC4',N'Ghế G8','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G9PC1CC4',N'Ghế G9','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G10PC1CC4',N'Ghế G10','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G11PC1CC4',N'Ghế G11','PC1','CC4','LV2',N'Chưa đặt','05/01/2021'),

('H1PC1CC4',N'Ghế H1','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H2PC1CC4',N'Ghế H2','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H3PC1CC4',N'Ghế H3','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H4PC1CC4',N'Ghế H4','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H5PC1CC4',N'Ghế H5','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H6PC1CC4',N'Ghế H6','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H7PC1CC4',N'Ghế H7','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H8PC1CC4',N'Ghế H8','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H9PC1CC4',N'Ghế H9','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H10PC1CC4',N'Ghế H10','PC1','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H11PC1CC4',N'Ghế H11','PC1','CC4','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC1 , CC5
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC5',N'Ghế A1','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A2PC1CC5',N'Ghế A2','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A3PC1CC5',N'Ghế A3','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A4PC1CC5',N'Ghế A4','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A5PC1CC5',N'Ghế A5','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A6PC1CC5',N'Ghế A6','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A7PC1CC5',N'Ghế A7','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A8PC1CC5',N'Ghế A8','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A9PC1CC5',N'Ghế A9','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A10PC1CC5',N'Ghế A10','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A11PC1CC5',N'Ghế A11','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),

('B1PC1CC5',N'Ghế B1','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B2PC1CC5',N'Ghế B2','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B3PC1CC5',N'Ghế B3','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B4PC1CC5',N'Ghế B4','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B5PC1CC5',N'Ghế B5','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B6PC1CC5',N'Ghế B6','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B7PC1CC5',N'Ghế B7','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B8PC1CC5',N'Ghế B8','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B9PC1CC5',N'Ghế B9','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B10PC1CC5',N'Ghế B10','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B11PC1CC5',N'Ghế B11','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),

('C1PC1CC5',N'Ghế C1','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C2PC1CC5',N'Ghế C2','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C3PC1CC5',N'Ghế C3','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C4PC1CC5',N'Ghế C4','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C5PC1CC5',N'Ghế C5','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C6PC1CC5',N'Ghế C6','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C7PC1CC5',N'Ghế C7','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C8PC1CC5',N'Ghế C8','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C9PC1CC5',N'Ghế C9','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C10PC1CC5',N'Ghế C10','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C11PC1CC5',N'Ghế C11','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),

('D1PC1CC5',N'Ghế D1','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D2PC1CC5',N'Ghế D2','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D3PC1CC5',N'Ghế D3','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D4PC1CC5',N'Ghế D4','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D5PC1CC5',N'Ghế D5','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D6PC1CC5',N'Ghế D6','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D7PC1CC5',N'Ghế D7','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D8PC1CC5',N'Ghế D8','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D9PC1CC5',N'Ghế D9','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D10PC1CC5',N'Ghế D10','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D11PC1CC5',N'Ghế D11','PC1','CC5','LV1',N'Chưa đặt','05/01/2021'),

('E1PC1CC5',N'Ghế E1','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E2PC1CC5',N'Ghế E2','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E3PC1CC5',N'Ghế E3','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E4PC1CC5',N'Ghế E4','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E5PC1CC5',N'Ghế E5','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E6PC1CC5',N'Ghế E6','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E7PC1CC5',N'Ghế E7','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E8PC1CC5',N'Ghế E8','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E9PC1CC5',N'Ghế E9','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E10PC1CC5',N'Ghế E10','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E11PC1CC5',N'Ghế E11','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),

('F1PC1CC5',N'Ghế F1','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F2PC1CC5',N'Ghế F2','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F3PC1CC5',N'Ghế F3','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F4PC1CC5',N'Ghế F4','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F5PC1CC5',N'Ghế F5','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F6PC1CC5',N'Ghế F6','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F7PC1CC5',N'Ghế F7','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F8PC1CC5',N'Ghế F8','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F9PC1CC5',N'Ghế F9','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F10PC1CC5',N'Ghế F10','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F11PC1CC5',N'Ghế F11','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),

('G1PC1CC5',N'Ghế G1','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G2PC1CC5',N'Ghế G2','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G3PC1CC5',N'Ghế G3','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G4PC1CC5',N'Ghế G4','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G5PC1CC5',N'Ghế G5','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G6PC1CC5',N'Ghế G6','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G7PC1CC5',N'Ghế G7','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G8PC1CC5',N'Ghế G8','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G9PC1CC5',N'Ghế G9','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G10PC1CC5',N'Ghế G10','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G11PC1CC5',N'Ghế G11','PC1','CC5','LV2',N'Chưa đặt','05/01/2021'),

('H1PC1CC5',N'Ghế H1','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H2PC1CC5',N'Ghế H2','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H3PC1CC5',N'Ghế H3','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H4PC1CC5',N'Ghế H4','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H5PC1CC5',N'Ghế H5','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H6PC1CC5',N'Ghế H6','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H7PC1CC5',N'Ghế H7','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H8PC1CC5',N'Ghế H8','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H9PC1CC5',N'Ghế H9','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H10PC1CC5',N'Ghế H10','PC1','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H11PC1CC5',N'Ghế H11','PC1','CC5','LV3',N'Chưa đặt','05/01/2021')


GO
-- PC2 , CC1
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC1',N'Ghế A1','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A2PC2CC1',N'Ghế A2','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A3PC2CC1',N'Ghế A3','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A4PC2CC1',N'Ghế A4','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A5PC2CC1',N'Ghế A5','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A6PC2CC1',N'Ghế A6','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A7PC2CC1',N'Ghế A7','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A8PC2CC1',N'Ghế A8','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A9PC2CC1',N'Ghế A9','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A10PC2CC1',N'Ghế A10','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('A11PC2CC1',N'Ghế A11','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),

('B1PC2CC1',N'Ghế B1','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B2PC2CC1',N'Ghế B2','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B3PC2CC1',N'Ghế B3','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B4PC2CC1',N'Ghế B4','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B5PC2CC1',N'Ghế B5','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B6PC2CC1',N'Ghế B6','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B7PC2CC1',N'Ghế B7','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B8PC2CC1',N'Ghế B8','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B9PC2CC1',N'Ghế B9','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B10PC2CC1',N'Ghế B10','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('B11PC2CC1',N'Ghế B11','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),

('C1PC2CC1',N'Ghế C1','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C2PC2CC1',N'Ghế C2','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C3PC2CC1',N'Ghế C3','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C4PC2CC1',N'Ghế C4','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C5PC2CC1',N'Ghế C5','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C6PC2CC1',N'Ghế C6','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C7PC2CC1',N'Ghế C7','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C8PC2CC1',N'Ghế C8','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C9PC2CC1',N'Ghế C9','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C10PC2CC1',N'Ghế C10','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('C11PC2CC1',N'Ghế C11','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),

('D1PC2CC1',N'Ghế D1','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D2PC2CC1',N'Ghế D2','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D3PC2CC1',N'Ghế D3','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D4PC2CC1',N'Ghế D4','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D5PC2CC1',N'Ghế D5','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D6PC2CC1',N'Ghế D6','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D7PC2CC1',N'Ghế D7','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D8PC2CC1',N'Ghế D8','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D9PC2CC1',N'Ghế D9','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D10PC2CC1',N'Ghế D10','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),
('D11PC2CC1',N'Ghế D11','PC2','CC1','LV1',N'Chưa đặt','05/01/2021'),

('E1PC2CC1',N'Ghế E1','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E2PC2CC1',N'Ghế E2','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E3PC2CC1',N'Ghế E3','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E4PC2CC1',N'Ghế E4','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E5PC2CC1',N'Ghế E5','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E6PC2CC1',N'Ghế E6','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E7PC2CC1',N'Ghế E7','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E8PC2CC1',N'Ghế E8','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E9PC2CC1',N'Ghế E9','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E10PC2CC1',N'Ghế E10','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('E11PC2CC1',N'Ghế E11','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),

('F1PC2CC1',N'Ghế F1','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F2PC2CC1',N'Ghế F2','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F3PC2CC1',N'Ghế F3','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F4PC2CC1',N'Ghế F4','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F5PC2CC1',N'Ghế F5','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F6PC2CC1',N'Ghế F6','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F7PC2CC1',N'Ghế F7','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F8PC2CC1',N'Ghế F8','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F9PC2CC1',N'Ghế F9','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F10PC2CC1',N'Ghế F10','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('F11PC2CC1',N'Ghế F11','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),

('G1PC2CC1',N'Ghế G1','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G2PC2CC1',N'Ghế G2','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G3PC2CC1',N'Ghế G3','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G4PC2CC1',N'Ghế G4','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G5PC2CC1',N'Ghế G5','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G6PC2CC1',N'Ghế G6','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G7PC2CC1',N'Ghế G7','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G8PC2CC1',N'Ghế G8','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G9PC2CC1',N'Ghế G9','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G10PC2CC1',N'Ghế G10','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('G11PC2CC1',N'Ghế G11','PC2','CC1','LV2',N'Chưa đặt','05/01/2021'),
('H1PC2CC1',N'Ghế H1','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),

('H2PC2CC1',N'Ghế H2','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H3PC2CC1',N'Ghế H3','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H4PC2CC1',N'Ghế H4','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H5PC2CC1',N'Ghế H5','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H6PC2CC1',N'Ghế H6','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H7PC2CC1',N'Ghế H7','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H8PC2CC1',N'Ghế H8','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H9PC2CC1',N'Ghế H9','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H10PC2CC1',N'Ghế H10','PC2','CC1','LV3',N'Chưa đặt','05/01/2021'),
('H11PC2CC1',N'Ghế H11','PC2','CC1','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC2 , CC2
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC2',N'Ghế A1','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A2PC2CC2',N'Ghế A2','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A3PC2CC2',N'Ghế A3','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A4PC2CC2',N'Ghế A4','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A5PC2CC2',N'Ghế A5','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A6PC2CC2',N'Ghế A6','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A7PC2CC2',N'Ghế A7','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A8PC2CC2',N'Ghế A8','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A9PC2CC2',N'Ghế A9','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A10PC2CC2',N'Ghế A10','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('A11PC2CC2',N'Ghế A11','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),

('B1PC2CC2',N'Ghế B1','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B2PC2CC2',N'Ghế B2','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B3PC2CC2',N'Ghế B3','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B4PC2CC2',N'Ghế B4','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B5PC2CC2',N'Ghế B5','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B6PC2CC2',N'Ghế B6','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B7PC2CC2',N'Ghế B7','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B8PC2CC2',N'Ghế B8','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B9PC2CC2',N'Ghế B9','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B10PC2CC2',N'Ghế B10','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('B11PC2CC2',N'Ghế B11','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),

('C1PC2CC2',N'Ghế C1','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C2PC2CC2',N'Ghế C2','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C3PC2CC2',N'Ghế C3','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C4PC2CC2',N'Ghế C4','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C5PC2CC2',N'Ghế C5','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C6PC2CC2',N'Ghế C6','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C7PC2CC2',N'Ghế C7','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C8PC2CC2',N'Ghế C8','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C9PC2CC2',N'Ghế C9','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C10PC2CC2',N'Ghế C10','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('C11PC2CC2',N'Ghế C11','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),

('D1PC2CC2',N'Ghế D1','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D2PC2CC2',N'Ghế D2','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D3PC2CC2',N'Ghế D3','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D4PC2CC2',N'Ghế D4','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D5PC2CC2',N'Ghế D5','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D6PC2CC2',N'Ghế D6','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D7PC2CC2',N'Ghế D7','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D8PC2CC2',N'Ghế D8','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D9PC2CC2',N'Ghế D9','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D10PC2CC2',N'Ghế D10','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),
('D11PC2CC2',N'Ghế D11','PC2','CC2','LV1',N'Chưa đặt','05/01/2021'),

('E1PC2CC2',N'Ghế E1','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E2PC2CC2',N'Ghế E2','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E3PC2CC2',N'Ghế E3','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E4PC2CC2',N'Ghế E4','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E5PC2CC2',N'Ghế E5','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E6PC2CC2',N'Ghế E6','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E7PC2CC2',N'Ghế E7','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E8PC2CC2',N'Ghế E8','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E9PC2CC2',N'Ghế E9','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E10PC2CC2',N'Ghế E10','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('E11PC2CC2',N'Ghế E11','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),

('F1PC2CC2',N'Ghế F1','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F2PC2CC2',N'Ghế F2','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F3PC2CC2',N'Ghế F3','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F4PC2CC2',N'Ghế F4','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F5PC2CC2',N'Ghế F5','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F6PC2CC2',N'Ghế F6','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F7PC2CC2',N'Ghế F7','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F8PC2CC2',N'Ghế F8','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F9PC2CC2',N'Ghế F9','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F10PC2CC2',N'Ghế F10','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('F11PC2CC2',N'Ghế F11','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),

('G1PC2CC2',N'Ghế G1','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G2PC2CC2',N'Ghế G2','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G3PC2CC2',N'Ghế G3','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G4PC2CC2',N'Ghế G4','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G5PC2CC2',N'Ghế G5','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G6PC2CC2',N'Ghế G6','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G7PC2CC2',N'Ghế G7','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G8PC2CC2',N'Ghế G8','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G9PC2CC2',N'Ghế G9','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G10PC2CC2',N'Ghế G10','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('G11PC2CC2',N'Ghế G11','PC2','CC2','LV2',N'Chưa đặt','05/01/2021'),
('H1PC2CC2',N'Ghế H1','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),

('H2PC2CC2',N'Ghế H2','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H3PC2CC2',N'Ghế H3','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H4PC2CC2',N'Ghế H4','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H5PC2CC2',N'Ghế H5','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H6PC2CC2',N'Ghế H6','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H7PC2CC2',N'Ghế H7','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H8PC2CC2',N'Ghế H8','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H9PC2CC2',N'Ghế H9','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H10PC2CC2',N'Ghế H10','PC2','CC2','LV3',N'Chưa đặt','05/01/2021'),
('H11PC2CC2',N'Ghế H11','PC2','CC2','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC2 , CC3
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC3',N'Ghế A1','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A2PC2CC3',N'Ghế A2','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A3PC2CC3',N'Ghế A3','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A4PC2CC3',N'Ghế A4','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A5PC2CC3',N'Ghế A5','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A6PC2CC3',N'Ghế A6','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A7PC2CC3',N'Ghế A7','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A8PC2CC3',N'Ghế A8','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A9PC2CC3',N'Ghế A9','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A10PC2CC3',N'Ghế A10','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('A11PC2CC3',N'Ghế A11','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),

('B1PC2CC3',N'Ghế B1','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B2PC2CC3',N'Ghế B2','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B3PC2CC3',N'Ghế B3','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B4PC2CC3',N'Ghế B4','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B5PC2CC3',N'Ghế B5','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B6PC2CC3',N'Ghế B6','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B7PC2CC3',N'Ghế B7','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B8PC2CC3',N'Ghế B8','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B9PC2CC3',N'Ghế B9','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B10PC2CC3',N'Ghế B10','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('B11PC2CC3',N'Ghế B11','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),

('C1PC2CC3',N'Ghế C1','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C2PC2CC3',N'Ghế C2','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C3PC2CC3',N'Ghế C3','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C4PC2CC3',N'Ghế C4','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C5PC2CC3',N'Ghế C5','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C6PC2CC3',N'Ghế C6','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C7PC2CC3',N'Ghế C7','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C8PC2CC3',N'Ghế C8','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C9PC2CC3',N'Ghế C9','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C10PC2CC3',N'Ghế C10','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('C11PC2CC3',N'Ghế C11','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),

('D1PC2CC3',N'Ghế D1','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D2PC2CC3',N'Ghế D2','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D3PC2CC3',N'Ghế D3','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D4PC2CC3',N'Ghế D4','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D5PC2CC3',N'Ghế D5','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D6PC2CC3',N'Ghế D6','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D7PC2CC3',N'Ghế D7','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D8PC2CC3',N'Ghế D8','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D9PC2CC3',N'Ghế D9','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D10PC2CC3',N'Ghế D10','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),
('D11PC2CC3',N'Ghế D11','PC2','CC3','LV1',N'Chưa đặt','05/01/2021'),

('E1PC2CC3',N'Ghế E1','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E2PC2CC3',N'Ghế E2','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E3PC2CC3',N'Ghế E3','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E4PC2CC3',N'Ghế E4','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E5PC2CC3',N'Ghế E5','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E6PC2CC3',N'Ghế E6','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E7PC2CC3',N'Ghế E7','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E8PC2CC3',N'Ghế E8','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E9PC2CC3',N'Ghế E9','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E10PC2CC3',N'Ghế E10','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('E11PC2CC3',N'Ghế E11','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),

('F1PC2CC3',N'Ghế F1','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F2PC2CC3',N'Ghế F2','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F3PC2CC3',N'Ghế F3','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F4PC2CC3',N'Ghế F4','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F5PC2CC3',N'Ghế F5','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F6PC2CC3',N'Ghế F6','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F7PC2CC3',N'Ghế F7','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F8PC2CC3',N'Ghế F8','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F9PC2CC3',N'Ghế F9','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F10PC2CC3',N'Ghế F10','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('F11PC2CC3',N'Ghế F11','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),

('G1PC2CC3',N'Ghế G1','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G2PC2CC3',N'Ghế G2','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G3PC2CC3',N'Ghế G3','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G4PC2CC3',N'Ghế G4','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G5PC2CC3',N'Ghế G5','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G6PC2CC3',N'Ghế G6','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G7PC2CC3',N'Ghế G7','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G8PC2CC3',N'Ghế G8','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G9PC2CC3',N'Ghế G9','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G10PC2CC3',N'Ghế G10','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('G11PC2CC3',N'Ghế G11','PC2','CC3','LV2',N'Chưa đặt','05/01/2021'),
('H1PC2CC3',N'Ghế H1','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),

('H2PC2CC3',N'Ghế H2','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H3PC2CC3',N'Ghế H3','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H4PC2CC3',N'Ghế H4','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H5PC2CC3',N'Ghế H5','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H6PC2CC3',N'Ghế H6','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H7PC2CC3',N'Ghế H7','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H8PC2CC3',N'Ghế H8','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H9PC2CC3',N'Ghế H9','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H10PC2CC3',N'Ghế H10','PC2','CC3','LV3',N'Chưa đặt','05/01/2021'),
('H11PC2CC3',N'Ghế H11','PC2','CC3','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC2 , CC4
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC4',N'Ghế A1','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A2PC2CC4',N'Ghế A2','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A3PC2CC4',N'Ghế A3','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A4PC2CC4',N'Ghế A4','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A5PC2CC4',N'Ghế A5','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A6PC2CC4',N'Ghế A6','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A7PC2CC4',N'Ghế A7','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A8PC2CC4',N'Ghế A8','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A9PC2CC4',N'Ghế A9','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A10PC2CC4',N'Ghế A10','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('A11PC2CC4',N'Ghế A11','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),

('B1PC2CC4',N'Ghế B1','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B2PC2CC4',N'Ghế B2','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B3PC2CC4',N'Ghế B3','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B4PC2CC4',N'Ghế B4','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B5PC2CC4',N'Ghế B5','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B6PC2CC4',N'Ghế B6','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B7PC2CC4',N'Ghế B7','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B8PC2CC4',N'Ghế B8','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B9PC2CC4',N'Ghế B9','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B10PC2CC4',N'Ghế B10','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('B11PC2CC4',N'Ghế B11','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),

('C1PC2CC4',N'Ghế C1','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C2PC2CC4',N'Ghế C2','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C3PC2CC4',N'Ghế C3','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C4PC2CC4',N'Ghế C4','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C5PC2CC4',N'Ghế C5','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C6PC2CC4',N'Ghế C6','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C7PC2CC4',N'Ghế C7','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C8PC2CC4',N'Ghế C8','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C9PC2CC4',N'Ghế C9','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C10PC2CC4',N'Ghế C10','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('C11PC2CC4',N'Ghế C11','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),

('D1PC2CC4',N'Ghế D1','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D2PC2CC4',N'Ghế D2','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D3PC2CC4',N'Ghế D3','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D4PC2CC4',N'Ghế D4','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D5PC2CC4',N'Ghế D5','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D6PC2CC4',N'Ghế D6','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D7PC2CC4',N'Ghế D7','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D8PC2CC4',N'Ghế D8','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D9PC2CC4',N'Ghế D9','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D10PC2CC4',N'Ghế D10','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),
('D11PC2CC4',N'Ghế D11','PC2','CC4','LV1',N'Chưa đặt','05/01/2021'),

('E1PC2CC4',N'Ghế E1','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E2PC2CC4',N'Ghế E2','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E3PC2CC4',N'Ghế E3','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E4PC2CC4',N'Ghế E4','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E5PC2CC4',N'Ghế E5','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E6PC2CC4',N'Ghế E6','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E7PC2CC4',N'Ghế E7','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E8PC2CC4',N'Ghế E8','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E9PC2CC4',N'Ghế E9','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E10PC2CC4',N'Ghế E10','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('E11PC2CC4',N'Ghế E11','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),

('F1PC2CC4',N'Ghế F1','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F2PC2CC4',N'Ghế F2','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F3PC2CC4',N'Ghế F3','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F4PC2CC4',N'Ghế F4','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F5PC2CC4',N'Ghế F5','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F6PC2CC4',N'Ghế F6','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F7PC2CC4',N'Ghế F7','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F8PC2CC4',N'Ghế F8','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F9PC2CC4',N'Ghế F9','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F10PC2CC4',N'Ghế F10','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('F11PC2CC4',N'Ghế F11','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),

('G1PC2CC4',N'Ghế G1','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G2PC2CC4',N'Ghế G2','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G3PC2CC4',N'Ghế G3','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G4PC2CC4',N'Ghế G4','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G5PC2CC4',N'Ghế G5','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G6PC2CC4',N'Ghế G6','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G7PC2CC4',N'Ghế G7','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G8PC2CC4',N'Ghế G8','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G9PC2CC4',N'Ghế G9','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G10PC2CC4',N'Ghế G10','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),
('G11PC2CC4',N'Ghế G11','PC2','CC4','LV2',N'Chưa đặt','05/01/2021'),

('H1PC2CC4',N'Ghế H1','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H2PC2CC4',N'Ghế H2','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H3PC2CC4',N'Ghế H3','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H4PC2CC4',N'Ghế H4','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H5PC2CC4',N'Ghế H5','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H6PC2CC4',N'Ghế H6','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H7PC2CC4',N'Ghế H7','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H8PC2CC4',N'Ghế H8','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H9PC2CC4',N'Ghế H9','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H10PC2CC4',N'Ghế H10','PC2','CC4','LV3',N'Chưa đặt','05/01/2021'),
('H11PC2CC4',N'Ghế H11','PC2','CC4','LV3',N'Chưa đặt','05/01/2021')

GO
-- PC2 , CC5
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC5',N'Ghế A1','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A2PC2CC5',N'Ghế A2','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A3PC2CC5',N'Ghế A3','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A4PC2CC5',N'Ghế A4','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A5PC2CC5',N'Ghế A5','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A6PC2CC5',N'Ghế A6','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A7PC2CC5',N'Ghế A7','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A8PC2CC5',N'Ghế A8','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A9PC2CC5',N'Ghế A9','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A10PC2CC5',N'Ghế A10','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('A11PC2CC5',N'Ghế A11','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),

('B1PC2CC5',N'Ghế B1','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B2PC2CC5',N'Ghế B2','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B3PC2CC5',N'Ghế B3','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B4PC2CC5',N'Ghế B4','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B5PC2CC5',N'Ghế B5','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B6PC2CC5',N'Ghế B6','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B7PC2CC5',N'Ghế B7','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B8PC2CC5',N'Ghế B8','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B9PC2CC5',N'Ghế B9','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B10PC2CC5',N'Ghế B10','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('B11PC2CC5',N'Ghế B11','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),

('C1PC2CC5',N'Ghế C1','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C2PC2CC5',N'Ghế C2','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C3PC2CC5',N'Ghế C3','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C4PC2CC5',N'Ghế C4','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C5PC2CC5',N'Ghế C5','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C6PC2CC5',N'Ghế C6','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C7PC2CC5',N'Ghế C7','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C8PC2CC5',N'Ghế C8','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C9PC2CC5',N'Ghế C9','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C10PC2CC5',N'Ghế C10','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('C11PC2CC5',N'Ghế C11','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),

('D1PC2CC5',N'Ghế D1','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D2PC2CC5',N'Ghế D2','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D3PC2CC5',N'Ghế D3','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D4PC2CC5',N'Ghế D4','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D5PC2CC5',N'Ghế D5','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D6PC2CC5',N'Ghế D6','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D7PC2CC5',N'Ghế D7','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D8PC2CC5',N'Ghế D8','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D9PC2CC5',N'Ghế D9','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D10PC2CC5',N'Ghế D10','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),
('D11PC2CC5',N'Ghế D11','PC2','CC5','LV1',N'Chưa đặt','05/01/2021'),

('E1PC2CC5',N'Ghế E1','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E2PC2CC5',N'Ghế E2','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E3PC2CC5',N'Ghế E3','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E4PC2CC5',N'Ghế E4','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E5PC2CC5',N'Ghế E5','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E6PC2CC5',N'Ghế E6','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E7PC2CC5',N'Ghế E7','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E8PC2CC5',N'Ghế E8','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E9PC2CC5',N'Ghế E9','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E10PC2CC5',N'Ghế E10','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('E11PC2CC5',N'Ghế E11','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),

('F1PC2CC5',N'Ghế F1','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F2PC2CC5',N'Ghế F2','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F3PC2CC5',N'Ghế F3','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F4PC2CC5',N'Ghế F4','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F5PC2CC5',N'Ghế F5','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F6PC2CC5',N'Ghế F6','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F7PC2CC5',N'Ghế F7','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F8PC2CC5',N'Ghế F8','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F9PC2CC5',N'Ghế F9','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F10PC2CC5',N'Ghế F10','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('F11PC2CC5',N'Ghế F11','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),

('G1PC2CC5',N'Ghế G1','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G2PC2CC5',N'Ghế G2','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G3PC2CC5',N'Ghế G3','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G4PC2CC5',N'Ghế G4','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G5PC2CC5',N'Ghế G5','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G6PC2CC5',N'Ghế G6','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G7PC2CC5',N'Ghế G7','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G8PC2CC5',N'Ghế G8','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G9PC2CC5',N'Ghế G9','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G10PC2CC5',N'Ghế G10','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),
('G11PC2CC5',N'Ghế G11','PC2','CC5','LV2',N'Chưa đặt','05/01/2021'),

('H1PC2CC5',N'Ghế H1','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H2PC2CC5',N'Ghế H2','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H3PC2CC5',N'Ghế H3','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H4PC2CC5',N'Ghế H4','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H5PC2CC5',N'Ghế H5','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H6PC2CC5',N'Ghế H6','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H7PC2CC5',N'Ghế H7','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H8PC2CC5',N'Ghế H8','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H9PC2CC5',N'Ghế H9','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H10PC2CC5',N'Ghế H10','PC2','CC5','LV3',N'Chưa đặt','05/01/2021'),
('H11PC2CC5',N'Ghế H11','PC2','CC5','LV3',N'Chưa đặt','05/01/2021')


GO
-- PC1 , CC1
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC1',N'Ghế A1','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A2PC1CC1',N'Ghế A2','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A3PC1CC1',N'Ghế A3','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A4PC1CC1',N'Ghế A4','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A5PC1CC1',N'Ghế A5','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A6PC1CC1',N'Ghế A6','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A7PC1CC1',N'Ghế A7','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A8PC1CC1',N'Ghế A8','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A9PC1CC1',N'Ghế A9','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A10PC1CC1',N'Ghế A10','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A11PC1CC1',N'Ghế A11','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),

('B1PC1CC1',N'Ghế B1','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B2PC1CC1',N'Ghế B2','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B3PC1CC1',N'Ghế B3','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B4PC1CC1',N'Ghế B4','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B5PC1CC1',N'Ghế B5','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B6PC1CC1',N'Ghế B6','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B7PC1CC1',N'Ghế B7','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B8PC1CC1',N'Ghế B8','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B9PC1CC1',N'Ghế B9','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B10PC1CC1',N'Ghế B10','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B11PC1CC1',N'Ghế B11','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),

('C1PC1CC1',N'Ghế C1','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C2PC1CC1',N'Ghế C2','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C3PC1CC1',N'Ghế C3','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C4PC1CC1',N'Ghế C4','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C5PC1CC1',N'Ghế C5','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C6PC1CC1',N'Ghế C6','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C7PC1CC1',N'Ghế C7','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C8PC1CC1',N'Ghế C8','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C9PC1CC1',N'Ghế C9','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C10PC1CC1',N'Ghế C10','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C11PC1CC1',N'Ghế C11','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),

('D1PC1CC1',N'Ghế D1','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D2PC1CC1',N'Ghế D2','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D3PC1CC1',N'Ghế D3','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D4PC1CC1',N'Ghế D4','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D5PC1CC1',N'Ghế D5','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D6PC1CC1',N'Ghế D6','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D7PC1CC1',N'Ghế D7','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D8PC1CC1',N'Ghế D8','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D9PC1CC1',N'Ghế D9','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D10PC1CC1',N'Ghế D10','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D11PC1CC1',N'Ghế D11','PC1','CC1','LV1',N'Chưa đặt','06/01/2021'),

('E1PC1CC1',N'Ghế E1','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E2PC1CC1',N'Ghế E2','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E3PC1CC1',N'Ghế E3','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E4PC1CC1',N'Ghế E4','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E5PC1CC1',N'Ghế E5','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E6PC1CC1',N'Ghế E6','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E7PC1CC1',N'Ghế E7','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E8PC1CC1',N'Ghế E8','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E9PC1CC1',N'Ghế E9','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E10PC1CC1',N'Ghế E10','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E11PC1CC1',N'Ghế E11','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),

('F1PC1CC1',N'Ghế F1','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F2PC1CC1',N'Ghế F2','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F3PC1CC1',N'Ghế F3','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F4PC1CC1',N'Ghế F4','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F5PC1CC1',N'Ghế F5','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F6PC1CC1',N'Ghế F6','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F7PC1CC1',N'Ghế F7','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F8PC1CC1',N'Ghế F8','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F9PC1CC1',N'Ghế F9','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F10PC1CC1',N'Ghế F10','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F11PC1CC1',N'Ghế F11','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),

('G1PC1CC1',N'Ghế G1','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G2PC1CC1',N'Ghế G2','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G3PC1CC1',N'Ghế G3','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G4PC1CC1',N'Ghế G4','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G5PC1CC1',N'Ghế G5','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G6PC1CC1',N'Ghế G6','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G7PC1CC1',N'Ghế G7','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G8PC1CC1',N'Ghế G8','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G9PC1CC1',N'Ghế G9','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G10PC1CC1',N'Ghế G10','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G11PC1CC1',N'Ghế G11','PC1','CC1','LV2',N'Chưa đặt','06/01/2021'),
('H1PC1CC1',N'Ghế H1','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),

('H2PC1CC1',N'Ghế H2','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H3PC1CC1',N'Ghế H3','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H4PC1CC1',N'Ghế H4','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H5PC1CC1',N'Ghế H5','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H6PC1CC1',N'Ghế H6','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H7PC1CC1',N'Ghế H7','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H8PC1CC1',N'Ghế H8','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H9PC1CC1',N'Ghế H9','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H10PC1CC1',N'Ghế H10','PC1','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H11PC1CC1',N'Ghế H11','PC1','CC1','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC1 , CC2
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC2',N'Ghế A1','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A2PC1CC2',N'Ghế A2','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A3PC1CC2',N'Ghế A3','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A4PC1CC2',N'Ghế A4','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A5PC1CC2',N'Ghế A5','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A6PC1CC2',N'Ghế A6','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A7PC1CC2',N'Ghế A7','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A8PC1CC2',N'Ghế A8','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A9PC1CC2',N'Ghế A9','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A10PC1CC2',N'Ghế A10','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A11PC1CC2',N'Ghế A11','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),

('B1PC1CC2',N'Ghế B1','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B2PC1CC2',N'Ghế B2','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B3PC1CC2',N'Ghế B3','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B4PC1CC2',N'Ghế B4','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B5PC1CC2',N'Ghế B5','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B6PC1CC2',N'Ghế B6','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B7PC1CC2',N'Ghế B7','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B8PC1CC2',N'Ghế B8','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B9PC1CC2',N'Ghế B9','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B10PC1CC2',N'Ghế B10','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B11PC1CC2',N'Ghế B11','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),

('C1PC1CC2',N'Ghế C1','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C2PC1CC2',N'Ghế C2','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C3PC1CC2',N'Ghế C3','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C4PC1CC2',N'Ghế C4','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C5PC1CC2',N'Ghế C5','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C6PC1CC2',N'Ghế C6','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C7PC1CC2',N'Ghế C7','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C8PC1CC2',N'Ghế C8','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C9PC1CC2',N'Ghế C9','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C10PC1CC2',N'Ghế C10','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C11PC1CC2',N'Ghế C11','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),

('D1PC1CC2',N'Ghế D1','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D2PC1CC2',N'Ghế D2','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D3PC1CC2',N'Ghế D3','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D4PC1CC2',N'Ghế D4','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D5PC1CC2',N'Ghế D5','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D6PC1CC2',N'Ghế D6','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D7PC1CC2',N'Ghế D7','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D8PC1CC2',N'Ghế D8','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D9PC1CC2',N'Ghế D9','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D10PC1CC2',N'Ghế D10','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D11PC1CC2',N'Ghế D11','PC1','CC2','LV1',N'Chưa đặt','06/01/2021'),

('E1PC1CC2',N'Ghế E1','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E2PC1CC2',N'Ghế E2','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E3PC1CC2',N'Ghế E3','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E4PC1CC2',N'Ghế E4','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E5PC1CC2',N'Ghế E5','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E6PC1CC2',N'Ghế E6','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E7PC1CC2',N'Ghế E7','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E8PC1CC2',N'Ghế E8','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E9PC1CC2',N'Ghế E9','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E10PC1CC2',N'Ghế E10','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E11PC1CC2',N'Ghế E11','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),

('F1PC1CC2',N'Ghế F1','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F2PC1CC2',N'Ghế F2','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F3PC1CC2',N'Ghế F3','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F4PC1CC2',N'Ghế F4','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F5PC1CC2',N'Ghế F5','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F6PC1CC2',N'Ghế F6','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F7PC1CC2',N'Ghế F7','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F8PC1CC2',N'Ghế F8','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F9PC1CC2',N'Ghế F9','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F10PC1CC2',N'Ghế F10','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F11PC1CC2',N'Ghế F11','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),

('G1PC1CC2',N'Ghế G1','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G2PC1CC2',N'Ghế G2','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G3PC1CC2',N'Ghế G3','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G4PC1CC2',N'Ghế G4','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G5PC1CC2',N'Ghế G5','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G6PC1CC2',N'Ghế G6','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G7PC1CC2',N'Ghế G7','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G8PC1CC2',N'Ghế G8','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G9PC1CC2',N'Ghế G9','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G10PC1CC2',N'Ghế G10','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G11PC1CC2',N'Ghế G11','PC1','CC2','LV2',N'Chưa đặt','06/01/2021'),
('H1PC1CC2',N'Ghế H1','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),

('H2PC1CC2',N'Ghế H2','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H3PC1CC2',N'Ghế H3','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H4PC1CC2',N'Ghế H4','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H5PC1CC2',N'Ghế H5','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H6PC1CC2',N'Ghế H6','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H7PC1CC2',N'Ghế H7','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H8PC1CC2',N'Ghế H8','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H9PC1CC2',N'Ghế H9','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H10PC1CC2',N'Ghế H10','PC1','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H11PC1CC2',N'Ghế H11','PC1','CC2','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC1 , CC3
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC3',N'Ghế A1','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A2PC1CC3',N'Ghế A2','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A3PC1CC3',N'Ghế A3','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A4PC1CC3',N'Ghế A4','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A5PC1CC3',N'Ghế A5','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A6PC1CC3',N'Ghế A6','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A7PC1CC3',N'Ghế A7','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A8PC1CC3',N'Ghế A8','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A9PC1CC3',N'Ghế A9','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A10PC1CC3',N'Ghế A10','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A11PC1CC3',N'Ghế A11','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),

('B1PC1CC3',N'Ghế B1','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B2PC1CC3',N'Ghế B2','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B3PC1CC3',N'Ghế B3','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B4PC1CC3',N'Ghế B4','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B5PC1CC3',N'Ghế B5','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B6PC1CC3',N'Ghế B6','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B7PC1CC3',N'Ghế B7','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B8PC1CC3',N'Ghế B8','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B9PC1CC3',N'Ghế B9','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B10PC1CC3',N'Ghế B10','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B11PC1CC3',N'Ghế B11','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),

('C1PC1CC3',N'Ghế C1','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C2PC1CC3',N'Ghế C2','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C3PC1CC3',N'Ghế C3','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C4PC1CC3',N'Ghế C4','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C5PC1CC3',N'Ghế C5','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C6PC1CC3',N'Ghế C6','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C7PC1CC3',N'Ghế C7','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C8PC1CC3',N'Ghế C8','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C9PC1CC3',N'Ghế C9','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C10PC1CC3',N'Ghế C10','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C11PC1CC3',N'Ghế C11','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),

('D1PC1CC3',N'Ghế D1','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D2PC1CC3',N'Ghế D2','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D3PC1CC3',N'Ghế D3','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D4PC1CC3',N'Ghế D4','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D5PC1CC3',N'Ghế D5','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D6PC1CC3',N'Ghế D6','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D7PC1CC3',N'Ghế D7','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D8PC1CC3',N'Ghế D8','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D9PC1CC3',N'Ghế D9','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D10PC1CC3',N'Ghế D10','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D11PC1CC3',N'Ghế D11','PC1','CC3','LV1',N'Chưa đặt','06/01/2021'),

('E1PC1CC3',N'Ghế E1','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E2PC1CC3',N'Ghế E2','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E3PC1CC3',N'Ghế E3','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E4PC1CC3',N'Ghế E4','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E5PC1CC3',N'Ghế E5','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E6PC1CC3',N'Ghế E6','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E7PC1CC3',N'Ghế E7','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E8PC1CC3',N'Ghế E8','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E9PC1CC3',N'Ghế E9','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E10PC1CC3',N'Ghế E10','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E11PC1CC3',N'Ghế E11','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),

('F1PC1CC3',N'Ghế F1','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F2PC1CC3',N'Ghế F2','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F3PC1CC3',N'Ghế F3','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F4PC1CC3',N'Ghế F4','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F5PC1CC3',N'Ghế F5','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F6PC1CC3',N'Ghế F6','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F7PC1CC3',N'Ghế F7','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F8PC1CC3',N'Ghế F8','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F9PC1CC3',N'Ghế F9','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F10PC1CC3',N'Ghế F10','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F11PC1CC3',N'Ghế F11','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),

('G1PC1CC3',N'Ghế G1','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G2PC1CC3',N'Ghế G2','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G3PC1CC3',N'Ghế G3','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G4PC1CC3',N'Ghế G4','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G5PC1CC3',N'Ghế G5','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G6PC1CC3',N'Ghế G6','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G7PC1CC3',N'Ghế G7','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G8PC1CC3',N'Ghế G8','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G9PC1CC3',N'Ghế G9','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G10PC1CC3',N'Ghế G10','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G11PC1CC3',N'Ghế G11','PC1','CC3','LV2',N'Chưa đặt','06/01/2021'),
('H1PC1CC3',N'Ghế H1','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),

('H2PC1CC3',N'Ghế H2','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H3PC1CC3',N'Ghế H3','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H4PC1CC3',N'Ghế H4','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H5PC1CC3',N'Ghế H5','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H6PC1CC3',N'Ghế H6','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H7PC1CC3',N'Ghế H7','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H8PC1CC3',N'Ghế H8','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H9PC1CC3',N'Ghế H9','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H10PC1CC3',N'Ghế H10','PC1','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H11PC1CC3',N'Ghế H11','PC1','CC3','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC1 , CC4
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC4',N'Ghế A1','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A2PC1CC4',N'Ghế A2','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A3PC1CC4',N'Ghế A3','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A4PC1CC4',N'Ghế A4','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A5PC1CC4',N'Ghế A5','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A6PC1CC4',N'Ghế A6','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A7PC1CC4',N'Ghế A7','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A8PC1CC4',N'Ghế A8','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A9PC1CC4',N'Ghế A9','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A10PC1CC4',N'Ghế A10','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A11PC1CC4',N'Ghế A11','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),

('B1PC1CC4',N'Ghế B1','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B2PC1CC4',N'Ghế B2','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B3PC1CC4',N'Ghế B3','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B4PC1CC4',N'Ghế B4','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B5PC1CC4',N'Ghế B5','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B6PC1CC4',N'Ghế B6','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B7PC1CC4',N'Ghế B7','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B8PC1CC4',N'Ghế B8','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B9PC1CC4',N'Ghế B9','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B10PC1CC4',N'Ghế B10','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B11PC1CC4',N'Ghế B11','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),

('C1PC1CC4',N'Ghế C1','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C2PC1CC4',N'Ghế C2','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C3PC1CC4',N'Ghế C3','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C4PC1CC4',N'Ghế C4','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C5PC1CC4',N'Ghế C5','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C6PC1CC4',N'Ghế C6','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C7PC1CC4',N'Ghế C7','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C8PC1CC4',N'Ghế C8','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C9PC1CC4',N'Ghế C9','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C10PC1CC4',N'Ghế C10','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C11PC1CC4',N'Ghế C11','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),

('D1PC1CC4',N'Ghế D1','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D2PC1CC4',N'Ghế D2','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D3PC1CC4',N'Ghế D3','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D4PC1CC4',N'Ghế D4','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D5PC1CC4',N'Ghế D5','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D6PC1CC4',N'Ghế D6','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D7PC1CC4',N'Ghế D7','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D8PC1CC4',N'Ghế D8','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D9PC1CC4',N'Ghế D9','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D10PC1CC4',N'Ghế D10','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D11PC1CC4',N'Ghế D11','PC1','CC4','LV1',N'Chưa đặt','06/01/2021'),

('E1PC1CC4',N'Ghế E1','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E2PC1CC4',N'Ghế E2','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E3PC1CC4',N'Ghế E3','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E4PC1CC4',N'Ghế E4','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E5PC1CC4',N'Ghế E5','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E6PC1CC4',N'Ghế E6','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E7PC1CC4',N'Ghế E7','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E8PC1CC4',N'Ghế E8','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E9PC1CC4',N'Ghế E9','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E10PC1CC4',N'Ghế E10','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E11PC1CC4',N'Ghế E11','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),

('F1PC1CC4',N'Ghế F1','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F2PC1CC4',N'Ghế F2','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F3PC1CC4',N'Ghế F3','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F4PC1CC4',N'Ghế F4','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F5PC1CC4',N'Ghế F5','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F6PC1CC4',N'Ghế F6','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F7PC1CC4',N'Ghế F7','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F8PC1CC4',N'Ghế F8','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F9PC1CC4',N'Ghế F9','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F10PC1CC4',N'Ghế F10','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F11PC1CC4',N'Ghế F11','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),

('G1PC1CC4',N'Ghế G1','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G2PC1CC4',N'Ghế G2','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G3PC1CC4',N'Ghế G3','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G4PC1CC4',N'Ghế G4','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G5PC1CC4',N'Ghế G5','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G6PC1CC4',N'Ghế G6','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G7PC1CC4',N'Ghế G7','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G8PC1CC4',N'Ghế G8','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G9PC1CC4',N'Ghế G9','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G10PC1CC4',N'Ghế G10','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G11PC1CC4',N'Ghế G11','PC1','CC4','LV2',N'Chưa đặt','06/01/2021'),

('H1PC1CC4',N'Ghế H1','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H2PC1CC4',N'Ghế H2','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H3PC1CC4',N'Ghế H3','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H4PC1CC4',N'Ghế H4','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H5PC1CC4',N'Ghế H5','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H6PC1CC4',N'Ghế H6','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H7PC1CC4',N'Ghế H7','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H8PC1CC4',N'Ghế H8','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H9PC1CC4',N'Ghế H9','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H10PC1CC4',N'Ghế H10','PC1','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H11PC1CC4',N'Ghế H11','PC1','CC4','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC1 , CC5
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC1CC5',N'Ghế A1','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A2PC1CC5',N'Ghế A2','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A3PC1CC5',N'Ghế A3','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A4PC1CC5',N'Ghế A4','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A5PC1CC5',N'Ghế A5','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A6PC1CC5',N'Ghế A6','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A7PC1CC5',N'Ghế A7','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A8PC1CC5',N'Ghế A8','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A9PC1CC5',N'Ghế A9','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A10PC1CC5',N'Ghế A10','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A11PC1CC5',N'Ghế A11','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),

('B1PC1CC5',N'Ghế B1','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B2PC1CC5',N'Ghế B2','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B3PC1CC5',N'Ghế B3','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B4PC1CC5',N'Ghế B4','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B5PC1CC5',N'Ghế B5','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B6PC1CC5',N'Ghế B6','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B7PC1CC5',N'Ghế B7','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B8PC1CC5',N'Ghế B8','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B9PC1CC5',N'Ghế B9','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B10PC1CC5',N'Ghế B10','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B11PC1CC5',N'Ghế B11','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),

('C1PC1CC5',N'Ghế C1','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C2PC1CC5',N'Ghế C2','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C3PC1CC5',N'Ghế C3','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C4PC1CC5',N'Ghế C4','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C5PC1CC5',N'Ghế C5','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C6PC1CC5',N'Ghế C6','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C7PC1CC5',N'Ghế C7','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C8PC1CC5',N'Ghế C8','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C9PC1CC5',N'Ghế C9','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C10PC1CC5',N'Ghế C10','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C11PC1CC5',N'Ghế C11','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),

('D1PC1CC5',N'Ghế D1','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D2PC1CC5',N'Ghế D2','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D3PC1CC5',N'Ghế D3','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D4PC1CC5',N'Ghế D4','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D5PC1CC5',N'Ghế D5','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D6PC1CC5',N'Ghế D6','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D7PC1CC5',N'Ghế D7','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D8PC1CC5',N'Ghế D8','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D9PC1CC5',N'Ghế D9','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D10PC1CC5',N'Ghế D10','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D11PC1CC5',N'Ghế D11','PC1','CC5','LV1',N'Chưa đặt','06/01/2021'),

('E1PC1CC5',N'Ghế E1','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E2PC1CC5',N'Ghế E2','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E3PC1CC5',N'Ghế E3','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E4PC1CC5',N'Ghế E4','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E5PC1CC5',N'Ghế E5','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E6PC1CC5',N'Ghế E6','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E7PC1CC5',N'Ghế E7','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E8PC1CC5',N'Ghế E8','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E9PC1CC5',N'Ghế E9','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E10PC1CC5',N'Ghế E10','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E11PC1CC5',N'Ghế E11','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),

('F1PC1CC5',N'Ghế F1','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F2PC1CC5',N'Ghế F2','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F3PC1CC5',N'Ghế F3','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F4PC1CC5',N'Ghế F4','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F5PC1CC5',N'Ghế F5','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F6PC1CC5',N'Ghế F6','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F7PC1CC5',N'Ghế F7','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F8PC1CC5',N'Ghế F8','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F9PC1CC5',N'Ghế F9','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F10PC1CC5',N'Ghế F10','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F11PC1CC5',N'Ghế F11','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),

('G1PC1CC5',N'Ghế G1','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G2PC1CC5',N'Ghế G2','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G3PC1CC5',N'Ghế G3','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G4PC1CC5',N'Ghế G4','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G5PC1CC5',N'Ghế G5','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G6PC1CC5',N'Ghế G6','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G7PC1CC5',N'Ghế G7','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G8PC1CC5',N'Ghế G8','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G9PC1CC5',N'Ghế G9','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G10PC1CC5',N'Ghế G10','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G11PC1CC5',N'Ghế G11','PC1','CC5','LV2',N'Chưa đặt','06/01/2021'),

('H1PC1CC5',N'Ghế H1','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H2PC1CC5',N'Ghế H2','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H3PC1CC5',N'Ghế H3','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H4PC1CC5',N'Ghế H4','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H5PC1CC5',N'Ghế H5','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H6PC1CC5',N'Ghế H6','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H7PC1CC5',N'Ghế H7','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H8PC1CC5',N'Ghế H8','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H9PC1CC5',N'Ghế H9','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H10PC1CC5',N'Ghế H10','PC1','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H11PC1CC5',N'Ghế H11','PC1','CC5','LV3',N'Chưa đặt','06/01/2021')


GO
-- PC2 , CC1
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC1',N'Ghế A1','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A2PC2CC1',N'Ghế A2','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A3PC2CC1',N'Ghế A3','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A4PC2CC1',N'Ghế A4','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A5PC2CC1',N'Ghế A5','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A6PC2CC1',N'Ghế A6','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A7PC2CC1',N'Ghế A7','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A8PC2CC1',N'Ghế A8','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A9PC2CC1',N'Ghế A9','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A10PC2CC1',N'Ghế A10','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('A11PC2CC1',N'Ghế A11','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),

('B1PC2CC1',N'Ghế B1','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B2PC2CC1',N'Ghế B2','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B3PC2CC1',N'Ghế B3','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B4PC2CC1',N'Ghế B4','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B5PC2CC1',N'Ghế B5','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B6PC2CC1',N'Ghế B6','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B7PC2CC1',N'Ghế B7','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B8PC2CC1',N'Ghế B8','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B9PC2CC1',N'Ghế B9','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B10PC2CC1',N'Ghế B10','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('B11PC2CC1',N'Ghế B11','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),

('C1PC2CC1',N'Ghế C1','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C2PC2CC1',N'Ghế C2','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C3PC2CC1',N'Ghế C3','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C4PC2CC1',N'Ghế C4','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C5PC2CC1',N'Ghế C5','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C6PC2CC1',N'Ghế C6','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C7PC2CC1',N'Ghế C7','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C8PC2CC1',N'Ghế C8','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C9PC2CC1',N'Ghế C9','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C10PC2CC1',N'Ghế C10','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('C11PC2CC1',N'Ghế C11','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),

('D1PC2CC1',N'Ghế D1','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D2PC2CC1',N'Ghế D2','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D3PC2CC1',N'Ghế D3','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D4PC2CC1',N'Ghế D4','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D5PC2CC1',N'Ghế D5','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D6PC2CC1',N'Ghế D6','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D7PC2CC1',N'Ghế D7','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D8PC2CC1',N'Ghế D8','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D9PC2CC1',N'Ghế D9','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D10PC2CC1',N'Ghế D10','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),
('D11PC2CC1',N'Ghế D11','PC2','CC1','LV1',N'Chưa đặt','06/01/2021'),

('E1PC2CC1',N'Ghế E1','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E2PC2CC1',N'Ghế E2','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E3PC2CC1',N'Ghế E3','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E4PC2CC1',N'Ghế E4','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E5PC2CC1',N'Ghế E5','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E6PC2CC1',N'Ghế E6','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E7PC2CC1',N'Ghế E7','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E8PC2CC1',N'Ghế E8','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E9PC2CC1',N'Ghế E9','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E10PC2CC1',N'Ghế E10','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('E11PC2CC1',N'Ghế E11','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),

('F1PC2CC1',N'Ghế F1','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F2PC2CC1',N'Ghế F2','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F3PC2CC1',N'Ghế F3','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F4PC2CC1',N'Ghế F4','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F5PC2CC1',N'Ghế F5','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F6PC2CC1',N'Ghế F6','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F7PC2CC1',N'Ghế F7','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F8PC2CC1',N'Ghế F8','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F9PC2CC1',N'Ghế F9','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F10PC2CC1',N'Ghế F10','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('F11PC2CC1',N'Ghế F11','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),

('G1PC2CC1',N'Ghế G1','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G2PC2CC1',N'Ghế G2','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G3PC2CC1',N'Ghế G3','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G4PC2CC1',N'Ghế G4','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G5PC2CC1',N'Ghế G5','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G6PC2CC1',N'Ghế G6','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G7PC2CC1',N'Ghế G7','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G8PC2CC1',N'Ghế G8','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G9PC2CC1',N'Ghế G9','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G10PC2CC1',N'Ghế G10','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('G11PC2CC1',N'Ghế G11','PC2','CC1','LV2',N'Chưa đặt','06/01/2021'),
('H1PC2CC1',N'Ghế H1','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),

('H2PC2CC1',N'Ghế H2','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H3PC2CC1',N'Ghế H3','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H4PC2CC1',N'Ghế H4','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H5PC2CC1',N'Ghế H5','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H6PC2CC1',N'Ghế H6','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H7PC2CC1',N'Ghế H7','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H8PC2CC1',N'Ghế H8','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H9PC2CC1',N'Ghế H9','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H10PC2CC1',N'Ghế H10','PC2','CC1','LV3',N'Chưa đặt','06/01/2021'),
('H11PC2CC1',N'Ghế H11','PC2','CC1','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC2 , CC2
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC2',N'Ghế A1','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A2PC2CC2',N'Ghế A2','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A3PC2CC2',N'Ghế A3','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A4PC2CC2',N'Ghế A4','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A5PC2CC2',N'Ghế A5','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A6PC2CC2',N'Ghế A6','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A7PC2CC2',N'Ghế A7','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A8PC2CC2',N'Ghế A8','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A9PC2CC2',N'Ghế A9','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A10PC2CC2',N'Ghế A10','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('A11PC2CC2',N'Ghế A11','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),

('B1PC2CC2',N'Ghế B1','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B2PC2CC2',N'Ghế B2','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B3PC2CC2',N'Ghế B3','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B4PC2CC2',N'Ghế B4','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B5PC2CC2',N'Ghế B5','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B6PC2CC2',N'Ghế B6','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B7PC2CC2',N'Ghế B7','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B8PC2CC2',N'Ghế B8','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B9PC2CC2',N'Ghế B9','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B10PC2CC2',N'Ghế B10','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('B11PC2CC2',N'Ghế B11','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),

('C1PC2CC2',N'Ghế C1','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C2PC2CC2',N'Ghế C2','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C3PC2CC2',N'Ghế C3','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C4PC2CC2',N'Ghế C4','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C5PC2CC2',N'Ghế C5','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C6PC2CC2',N'Ghế C6','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C7PC2CC2',N'Ghế C7','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C8PC2CC2',N'Ghế C8','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C9PC2CC2',N'Ghế C9','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C10PC2CC2',N'Ghế C10','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('C11PC2CC2',N'Ghế C11','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),

('D1PC2CC2',N'Ghế D1','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D2PC2CC2',N'Ghế D2','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D3PC2CC2',N'Ghế D3','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D4PC2CC2',N'Ghế D4','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D5PC2CC2',N'Ghế D5','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D6PC2CC2',N'Ghế D6','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D7PC2CC2',N'Ghế D7','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D8PC2CC2',N'Ghế D8','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D9PC2CC2',N'Ghế D9','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D10PC2CC2',N'Ghế D10','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),
('D11PC2CC2',N'Ghế D11','PC2','CC2','LV1',N'Chưa đặt','06/01/2021'),

('E1PC2CC2',N'Ghế E1','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E2PC2CC2',N'Ghế E2','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E3PC2CC2',N'Ghế E3','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E4PC2CC2',N'Ghế E4','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E5PC2CC2',N'Ghế E5','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E6PC2CC2',N'Ghế E6','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E7PC2CC2',N'Ghế E7','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E8PC2CC2',N'Ghế E8','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E9PC2CC2',N'Ghế E9','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E10PC2CC2',N'Ghế E10','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('E11PC2CC2',N'Ghế E11','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),

('F1PC2CC2',N'Ghế F1','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F2PC2CC2',N'Ghế F2','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F3PC2CC2',N'Ghế F3','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F4PC2CC2',N'Ghế F4','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F5PC2CC2',N'Ghế F5','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F6PC2CC2',N'Ghế F6','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F7PC2CC2',N'Ghế F7','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F8PC2CC2',N'Ghế F8','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F9PC2CC2',N'Ghế F9','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F10PC2CC2',N'Ghế F10','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('F11PC2CC2',N'Ghế F11','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),

('G1PC2CC2',N'Ghế G1','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G2PC2CC2',N'Ghế G2','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G3PC2CC2',N'Ghế G3','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G4PC2CC2',N'Ghế G4','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G5PC2CC2',N'Ghế G5','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G6PC2CC2',N'Ghế G6','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G7PC2CC2',N'Ghế G7','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G8PC2CC2',N'Ghế G8','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G9PC2CC2',N'Ghế G9','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G10PC2CC2',N'Ghế G10','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('G11PC2CC2',N'Ghế G11','PC2','CC2','LV2',N'Chưa đặt','06/01/2021'),
('H1PC2CC2',N'Ghế H1','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),

('H2PC2CC2',N'Ghế H2','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H3PC2CC2',N'Ghế H3','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H4PC2CC2',N'Ghế H4','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H5PC2CC2',N'Ghế H5','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H6PC2CC2',N'Ghế H6','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H7PC2CC2',N'Ghế H7','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H8PC2CC2',N'Ghế H8','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H9PC2CC2',N'Ghế H9','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H10PC2CC2',N'Ghế H10','PC2','CC2','LV3',N'Chưa đặt','06/01/2021'),
('H11PC2CC2',N'Ghế H11','PC2','CC2','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC2 , CC3
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC3',N'Ghế A1','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A2PC2CC3',N'Ghế A2','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A3PC2CC3',N'Ghế A3','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A4PC2CC3',N'Ghế A4','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A5PC2CC3',N'Ghế A5','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A6PC2CC3',N'Ghế A6','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A7PC2CC3',N'Ghế A7','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A8PC2CC3',N'Ghế A8','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A9PC2CC3',N'Ghế A9','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A10PC2CC3',N'Ghế A10','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('A11PC2CC3',N'Ghế A11','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),

('B1PC2CC3',N'Ghế B1','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B2PC2CC3',N'Ghế B2','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B3PC2CC3',N'Ghế B3','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B4PC2CC3',N'Ghế B4','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B5PC2CC3',N'Ghế B5','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B6PC2CC3',N'Ghế B6','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B7PC2CC3',N'Ghế B7','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B8PC2CC3',N'Ghế B8','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B9PC2CC3',N'Ghế B9','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B10PC2CC3',N'Ghế B10','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('B11PC2CC3',N'Ghế B11','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),

('C1PC2CC3',N'Ghế C1','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C2PC2CC3',N'Ghế C2','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C3PC2CC3',N'Ghế C3','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C4PC2CC3',N'Ghế C4','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C5PC2CC3',N'Ghế C5','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C6PC2CC3',N'Ghế C6','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C7PC2CC3',N'Ghế C7','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C8PC2CC3',N'Ghế C8','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C9PC2CC3',N'Ghế C9','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C10PC2CC3',N'Ghế C10','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('C11PC2CC3',N'Ghế C11','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),

('D1PC2CC3',N'Ghế D1','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D2PC2CC3',N'Ghế D2','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D3PC2CC3',N'Ghế D3','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D4PC2CC3',N'Ghế D4','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D5PC2CC3',N'Ghế D5','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D6PC2CC3',N'Ghế D6','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D7PC2CC3',N'Ghế D7','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D8PC2CC3',N'Ghế D8','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D9PC2CC3',N'Ghế D9','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D10PC2CC3',N'Ghế D10','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),
('D11PC2CC3',N'Ghế D11','PC2','CC3','LV1',N'Chưa đặt','06/01/2021'),

('E1PC2CC3',N'Ghế E1','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E2PC2CC3',N'Ghế E2','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E3PC2CC3',N'Ghế E3','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E4PC2CC3',N'Ghế E4','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E5PC2CC3',N'Ghế E5','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E6PC2CC3',N'Ghế E6','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E7PC2CC3',N'Ghế E7','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E8PC2CC3',N'Ghế E8','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E9PC2CC3',N'Ghế E9','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E10PC2CC3',N'Ghế E10','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('E11PC2CC3',N'Ghế E11','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),

('F1PC2CC3',N'Ghế F1','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F2PC2CC3',N'Ghế F2','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F3PC2CC3',N'Ghế F3','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F4PC2CC3',N'Ghế F4','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F5PC2CC3',N'Ghế F5','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F6PC2CC3',N'Ghế F6','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F7PC2CC3',N'Ghế F7','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F8PC2CC3',N'Ghế F8','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F9PC2CC3',N'Ghế F9','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F10PC2CC3',N'Ghế F10','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('F11PC2CC3',N'Ghế F11','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),

('G1PC2CC3',N'Ghế G1','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G2PC2CC3',N'Ghế G2','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G3PC2CC3',N'Ghế G3','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G4PC2CC3',N'Ghế G4','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G5PC2CC3',N'Ghế G5','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G6PC2CC3',N'Ghế G6','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G7PC2CC3',N'Ghế G7','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G8PC2CC3',N'Ghế G8','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G9PC2CC3',N'Ghế G9','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G10PC2CC3',N'Ghế G10','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('G11PC2CC3',N'Ghế G11','PC2','CC3','LV2',N'Chưa đặt','06/01/2021'),
('H1PC2CC3',N'Ghế H1','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),

('H2PC2CC3',N'Ghế H2','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H3PC2CC3',N'Ghế H3','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H4PC2CC3',N'Ghế H4','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H5PC2CC3',N'Ghế H5','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H6PC2CC3',N'Ghế H6','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H7PC2CC3',N'Ghế H7','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H8PC2CC3',N'Ghế H8','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H9PC2CC3',N'Ghế H9','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H10PC2CC3',N'Ghế H10','PC2','CC3','LV3',N'Chưa đặt','06/01/2021'),
('H11PC2CC3',N'Ghế H11','PC2','CC3','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC2 , CC4
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC4',N'Ghế A1','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A2PC2CC4',N'Ghế A2','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A3PC2CC4',N'Ghế A3','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A4PC2CC4',N'Ghế A4','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A5PC2CC4',N'Ghế A5','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A6PC2CC4',N'Ghế A6','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A7PC2CC4',N'Ghế A7','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A8PC2CC4',N'Ghế A8','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A9PC2CC4',N'Ghế A9','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A10PC2CC4',N'Ghế A10','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('A11PC2CC4',N'Ghế A11','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),

('B1PC2CC4',N'Ghế B1','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B2PC2CC4',N'Ghế B2','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B3PC2CC4',N'Ghế B3','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B4PC2CC4',N'Ghế B4','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B5PC2CC4',N'Ghế B5','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B6PC2CC4',N'Ghế B6','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B7PC2CC4',N'Ghế B7','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B8PC2CC4',N'Ghế B8','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B9PC2CC4',N'Ghế B9','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B10PC2CC4',N'Ghế B10','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('B11PC2CC4',N'Ghế B11','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),

('C1PC2CC4',N'Ghế C1','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C2PC2CC4',N'Ghế C2','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C3PC2CC4',N'Ghế C3','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C4PC2CC4',N'Ghế C4','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C5PC2CC4',N'Ghế C5','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C6PC2CC4',N'Ghế C6','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C7PC2CC4',N'Ghế C7','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C8PC2CC4',N'Ghế C8','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C9PC2CC4',N'Ghế C9','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C10PC2CC4',N'Ghế C10','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('C11PC2CC4',N'Ghế C11','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),

('D1PC2CC4',N'Ghế D1','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D2PC2CC4',N'Ghế D2','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D3PC2CC4',N'Ghế D3','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D4PC2CC4',N'Ghế D4','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D5PC2CC4',N'Ghế D5','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D6PC2CC4',N'Ghế D6','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D7PC2CC4',N'Ghế D7','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D8PC2CC4',N'Ghế D8','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D9PC2CC4',N'Ghế D9','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D10PC2CC4',N'Ghế D10','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),
('D11PC2CC4',N'Ghế D11','PC2','CC4','LV1',N'Chưa đặt','06/01/2021'),

('E1PC2CC4',N'Ghế E1','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E2PC2CC4',N'Ghế E2','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E3PC2CC4',N'Ghế E3','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E4PC2CC4',N'Ghế E4','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E5PC2CC4',N'Ghế E5','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E6PC2CC4',N'Ghế E6','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E7PC2CC4',N'Ghế E7','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E8PC2CC4',N'Ghế E8','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E9PC2CC4',N'Ghế E9','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E10PC2CC4',N'Ghế E10','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('E11PC2CC4',N'Ghế E11','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),

('F1PC2CC4',N'Ghế F1','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F2PC2CC4',N'Ghế F2','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F3PC2CC4',N'Ghế F3','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F4PC2CC4',N'Ghế F4','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F5PC2CC4',N'Ghế F5','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F6PC2CC4',N'Ghế F6','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F7PC2CC4',N'Ghế F7','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F8PC2CC4',N'Ghế F8','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F9PC2CC4',N'Ghế F9','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F10PC2CC4',N'Ghế F10','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('F11PC2CC4',N'Ghế F11','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),

('G1PC2CC4',N'Ghế G1','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G2PC2CC4',N'Ghế G2','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G3PC2CC4',N'Ghế G3','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G4PC2CC4',N'Ghế G4','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G5PC2CC4',N'Ghế G5','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G6PC2CC4',N'Ghế G6','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G7PC2CC4',N'Ghế G7','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G8PC2CC4',N'Ghế G8','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G9PC2CC4',N'Ghế G9','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G10PC2CC4',N'Ghế G10','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),
('G11PC2CC4',N'Ghế G11','PC2','CC4','LV2',N'Chưa đặt','06/01/2021'),

('H1PC2CC4',N'Ghế H1','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H2PC2CC4',N'Ghế H2','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H3PC2CC4',N'Ghế H3','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H4PC2CC4',N'Ghế H4','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H5PC2CC4',N'Ghế H5','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H6PC2CC4',N'Ghế H6','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H7PC2CC4',N'Ghế H7','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H8PC2CC4',N'Ghế H8','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H9PC2CC4',N'Ghế H9','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H10PC2CC4',N'Ghế H10','PC2','CC4','LV3',N'Chưa đặt','06/01/2021'),
('H11PC2CC4',N'Ghế H11','PC2','CC4','LV3',N'Chưa đặt','06/01/2021')

GO
-- PC2 , CC5
INSERT INTO GHE(MAGHE,TENGHE,MAPC,MACC,MALV,TRANGTHAI,NGAYCHIEU) VALUES 
('A1PC2CC5',N'Ghế A1','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A2PC2CC5',N'Ghế A2','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A3PC2CC5',N'Ghế A3','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A4PC2CC5',N'Ghế A4','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A5PC2CC5',N'Ghế A5','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A6PC2CC5',N'Ghế A6','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A7PC2CC5',N'Ghế A7','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A8PC2CC5',N'Ghế A8','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A9PC2CC5',N'Ghế A9','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A10PC2CC5',N'Ghế A10','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('A11PC2CC5',N'Ghế A11','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),

('B1PC2CC5',N'Ghế B1','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B2PC2CC5',N'Ghế B2','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B3PC2CC5',N'Ghế B3','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B4PC2CC5',N'Ghế B4','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B5PC2CC5',N'Ghế B5','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B6PC2CC5',N'Ghế B6','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B7PC2CC5',N'Ghế B7','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B8PC2CC5',N'Ghế B8','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B9PC2CC5',N'Ghế B9','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B10PC2CC5',N'Ghế B10','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('B11PC2CC5',N'Ghế B11','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),

('C1PC2CC5',N'Ghế C1','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C2PC2CC5',N'Ghế C2','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C3PC2CC5',N'Ghế C3','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C4PC2CC5',N'Ghế C4','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C5PC2CC5',N'Ghế C5','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C6PC2CC5',N'Ghế C6','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C7PC2CC5',N'Ghế C7','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C8PC2CC5',N'Ghế C8','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C9PC2CC5',N'Ghế C9','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C10PC2CC5',N'Ghế C10','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('C11PC2CC5',N'Ghế C11','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),

('D1PC2CC5',N'Ghế D1','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D2PC2CC5',N'Ghế D2','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D3PC2CC5',N'Ghế D3','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D4PC2CC5',N'Ghế D4','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D5PC2CC5',N'Ghế D5','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D6PC2CC5',N'Ghế D6','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D7PC2CC5',N'Ghế D7','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D8PC2CC5',N'Ghế D8','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D9PC2CC5',N'Ghế D9','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D10PC2CC5',N'Ghế D10','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),
('D11PC2CC5',N'Ghế D11','PC2','CC5','LV1',N'Chưa đặt','06/01/2021'),

('E1PC2CC5',N'Ghế E1','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E2PC2CC5',N'Ghế E2','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E3PC2CC5',N'Ghế E3','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E4PC2CC5',N'Ghế E4','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E5PC2CC5',N'Ghế E5','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E6PC2CC5',N'Ghế E6','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E7PC2CC5',N'Ghế E7','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E8PC2CC5',N'Ghế E8','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E9PC2CC5',N'Ghế E9','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E10PC2CC5',N'Ghế E10','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('E11PC2CC5',N'Ghế E11','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),

('F1PC2CC5',N'Ghế F1','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F2PC2CC5',N'Ghế F2','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F3PC2CC5',N'Ghế F3','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F4PC2CC5',N'Ghế F4','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F5PC2CC5',N'Ghế F5','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F6PC2CC5',N'Ghế F6','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F7PC2CC5',N'Ghế F7','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F8PC2CC5',N'Ghế F8','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F9PC2CC5',N'Ghế F9','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F10PC2CC5',N'Ghế F10','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('F11PC2CC5',N'Ghế F11','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),

('G1PC2CC5',N'Ghế G1','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G2PC2CC5',N'Ghế G2','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G3PC2CC5',N'Ghế G3','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G4PC2CC5',N'Ghế G4','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G5PC2CC5',N'Ghế G5','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G6PC2CC5',N'Ghế G6','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G7PC2CC5',N'Ghế G7','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G8PC2CC5',N'Ghế G8','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G9PC2CC5',N'Ghế G9','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G10PC2CC5',N'Ghế G10','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),
('G11PC2CC5',N'Ghế G11','PC2','CC5','LV2',N'Chưa đặt','06/01/2021'),

('H1PC2CC5',N'Ghế H1','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H2PC2CC5',N'Ghế H2','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H3PC2CC5',N'Ghế H3','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H4PC2CC5',N'Ghế H4','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H5PC2CC5',N'Ghế H5','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H6PC2CC5',N'Ghế H6','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H7PC2CC5',N'Ghế H7','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H8PC2CC5',N'Ghế H8','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H9PC2CC5',N'Ghế H9','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H10PC2CC5',N'Ghế H10','PC2','CC5','LV3',N'Chưa đặt','06/01/2021'),
('H11PC2CC5',N'Ghế H11','PC2','CC5','LV3',N'Chưa đặt','06/01/2021')



GO
INSERT INTO VE(MAVE,MALC,NGAY_GIO_MUA,MAKH,TONGCONG) VALUES
('HD1','LC1','05/01/2021 7:00:00','KH1',0),--1444277
('HD2','LC1', '05/01/2021 7:04:00','KH2', 0),
('HD3','LC6', '05/01/2021 8:10:00','KH3', 0),
('HD4','LC15', '05/01/2021 17:04:00','KH2', 0),
('HD5','LC16', '05/01/2021 15:04:00','KH2', 0)
--select * from lichchieu
--where NGAYCHIEU='05/01/2021'
--select * from ve
--select * from CT_VE

GO
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD1','A1PC1CC1','05/01/2021',0)
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD1','A2PC1CC1','05/01/2021',0)
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD2','A1PC1CC2','05/01/2021',0)
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD3','A1PC2CC3','05/01/2021',0)
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD3','A2PC2CC3','05/01/2021',0)
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD4','A1PC1CC1','06/01/2021',0)
INSERT INTO CT_VE(MAVE,MAGHE,NGAYCHIEU,THANHTIEN) VALUES('HD5','A1PC1CC1','06/01/2021',0)
go
select * from GHE
select * from KHACHHANGTHANTHIET


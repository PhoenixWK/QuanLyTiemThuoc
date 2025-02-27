/*3 CÂU LỆNH DƯỚI ĐÂY, CHẠY LẦN LƯỢT TỪNG CÂU LỆNH MỘT*/

/*drop database if exists quanlynhathuoc*/
/*create database quanlynhathuoc*/
/*use quanlynhathuoc*/

/*SAU ĐÓ CÓ THỂ CHẠY TOÀN BỘ CÁC CÂU LỆNH DƯỚI ĐÂY*/
create table loaisanpham (
	maloai varchar(50) primary key,
    tenloai nvarchar(50),
    trangthai boolean default true
);

create table nhasanxuat (
	mansx varchar(50) primary key,
    tennsx nvarchar(100),
    trangthai boolean default true
);

create table sanpham (
	masp varchar(50) primary key,
    tensp nvarchar(200),
    loaisp varchar(50),
    nhasanxuat varchar(50),
    quycach nvarchar(20),
    xuatxu nvarchar(40),
    canketoa boolean,
    trangthai boolean default true,
    constraint foreign key (loaisp) references loaisanpham(maloai),
    constraint foreign key (nhasanxuat) references nhasanxuat(mansx)
);

create table dieutri (
	mathuoc varchar(50) not null,
    benhdieutri nvarchar(100) not null,
    constraint foreign key (mathuoc) references sanpham(masp),
    constraint primary key (mathuoc, benhdieutri)
);

create table thanhphan (
	mathuoc varchar(50) not null,
    thanhphan nvarchar(100) not null,
    constraint foreign key (mathuoc) references sanpham(masp),
    constraint primary key (mathuoc, thanhphan)
);

create table duocsi (
	mads varchar(50) primary key,
    hoten nvarchar(50),
    sodt char(10),
    email varchar(100),
    trangthai boolean default true
);

create table taikhoan (
	matk varchar(50) primary key,
    username varchar(50),
    password varchar(200),
    quyen int,
    constraint foreign key (matk) references duocsi(mads)
);

create table nhacungcap(
	mancc varchar(50) primary key,
    tenncc nvarchar(200),
    diachi nvarchar(200),
    sodt varchar(15),
    email varchar(100),
    trangthai boolean default true
);

create table phieunhap (
	mapn varchar(50) primary key,
    ngaylap date,
    nguoilap varchar(50),
    nhacungcap varchar(50),
    tongtien decimal(10,0),
    constraint foreign key (nguoilap) references duocsi(mads),
    constraint foreign key (nhacungcap) references nhacungcap(mancc)
);

create table khachhang (
	makh int primary key AUTO_INCREMENT,
    hoten nvarchar(50),
    ngaysinh date,
    gioitinh nvarchar(3),
    sodt char(10),
    diem int default 0
);

create table hoadon (
	maHD varchar(50) primary key,
    ngaylap date,
    nguoilap varchar(50),
    khachhang int,
    toathuoc varchar(512), /*chua duong dan cua hinh anh toa thuoc*/
    diemtichluy int,
    tongtien decimal(10,0),
    constraint foreign key (nguoilap) references duocsi(mads),
    constraint foreign key (khachhang) references khachhang(makh)
);

insert into loaisanpham values
('LSP0001', 'Thuốc', 1),
('LSP0002', 'Thực phẩm chức năng', 1);

insert into nhasanxuat values
('NSX0001', 'Sanofi', 1),
('NSX0002', 'Tâm Bình', 1),
('NSX0003', 'Công ty cổ phần công nghệ cao Traphaco', 1);

insert into sanpham values
('SP0001', 'Thuốc Boganic Traphaco bổ gan, hỗ trợ điều trị suy giảm chức năng gan (5 vỉ x 20 viên)', 'LSP0002', 'NSX0003', 'Hộp 5 Vỉ x 20 Viên', 'Việt Nam', 0, 1),
('SP0002', 'Viên nén Methyldopa 250mg Traphaco điều trị tăng huyết áp (10 vỉ x 10 viên)', 'LSP0001', 'NSX0003', 'Hộp 10 Vỉ x 10 Viên', 'Việt Nam', 1, 1),
('SP0003', 'Viên nhuận tràng Ovalax 5mg Traphaco điều trị táo bón, làm sạch ruột (1 vỉ x 10 viên)', 'LSP0001', 'NSX0003', 'Hộp 1 vỉ x 10 viên', 'Việt Nam', 0, 1),
('SP0004', 'Viên ngậm Cagu Traphaco điều trị viêm họng, ho do lạnh, viêm thanh quản (2 vỉ x 10 viên)', 'LSP0002', 'NSX0003', 'Hộp 2 vỉ x 10 viên', 'Việt Nam', 0, 1),
('SP0005', 'Thuốc Solupred 5mg Sanofi dùng chống viêm (30 viên)', 'LSP0001', 'NSX0001', 'Hộp 30 viên', 'Pháp', 1, 1),
('SP0006', 'Thuốc Fumafer B9 Corbière Sanofi điều trị thiếu máu do thiếu sắt (8 vỉ x 15 viên)', 'LSP0001', 'NSX0001', 'Hộp 8 vỉ x 15 viên', 'Pháp', 0, 1),
('SP0007', 'Hỗn dịch uống Phosphalugel Sanofi giảm độ axit của dạ dày (26 gói x 20g)', 'LSP0001', 'NSX0001', 'Hộp 26 Gói x 20g', 'Pháp', 0, 1),
('SP0008', 'Thuốc Telfast HD 180mg Sanofi điều trị viêm mũi dị ứng, mày đay (1 vỉ x 10 viên)', 'LSP0001', 'NSX0001', 'Hộp 1 Vỉ x 10 Viên', 'Pháp', 0, 1),
('SP0009', 'Viên khớp Tâm Bình hỗ trợ giảm các triệu chứng của thoái hóa khớp, viêm khớp (60 viên)', 'LSP0002', 'NSX0002', 'Hộp 60 viên', 'Việt Nam', 0, 1),
('SP0010', 'Viên uống Bổ gan Tâm Bình tăng cường chức năng gan, thanh nhiệt, giải độc (60 viên)', 'LSP0002', 'NSX0002', 'Hộp 60 viên', 'Việt Nam', 0, 1),
('SP0011', 'Viên uống Đại Tràng Tâm Bình hỗ trợ giảm các triệu chứng của viêm đại tràng cấp và mãn tính (5 vỉ x 12 viên)', 'LSP0002', 'NSX0002', 'Hộp 5 vỉ x 12 viên', 'Việt Nam', 0, 1),
('SP0012', 'Thuốc Dưỡng Tâm An Thần Danapha điều trị mất ngủ do lo âu, làm việc quá sức (100 viên)', 'LSP0002', 'NSX0002', 'Hộp 100 viên', 'Việt Nam', 1, 1);

insert into thanhphan values
('SP0001', 'Bìm Bìm'),
('SP0001', 'Rau đắng đất'),
('SP0001', 'Atiso'),
('SP0002', 'Methyldopa'),
('SP0003', 'Bisacodyl'),
('SP0004', 'Xạ can'),
('SP0004', 'Bột quế'),
('SP0004', 'Bột gừng'),
('SP0004', 'Cam thảo'),
('SP0005', 'Prednisolone'),
('SP0006', 'Acid folic'),
('SP0006', 'Sắt'),
('SP0007', 'Aluminium phosphate'),
('SP0008', 'Fexofenadine'),
('SP0009', 'Tá dược vừa đủ'),
('SP0009', 'Bột mã tiền chế'),
('SP0009', 'Độc hoạt'),
('SP0009', 'Cẩu tích'),
('SP0009', 'Tục đoạn'),
('SP0009', 'Đỗ trọng'),
('SP0009', 'Hy thiêm'),
('SP0009', 'Ba kích'),
('SP0009', 'Ngưu tất (Rễ)'),
('SP0009', 'Đương quy'),
('SP0009', 'Bột thương truật'),
('SP0010', 'Novasol Curcumin'),
('SP0010', 'Cao khô actiso'),
('SP0010', 'Mật nhân'),
('SP0010', 'Sài hồ'),
('SP0010', 'Bạch thược'),
('SP0010', 'Khúng khéng'),
('SP0010', 'Cao kế sữa'),
('SP0010', 'Cao hỗn hợp dược liệu'),
('SP0011', 'Bạch linh'),
('SP0011', 'Đảng Sâm'),
('SP0011', 'Trần bì'),
('SP0011', 'Mộc hương bắc'),
('SP0011', 'Hoài Sơn'),
('SP0011', 'Nhục đậu khấu'),
('SP0011', 'Mạch Nha'),
('SP0011', 'Sơn Tra'),
('SP0011', 'Sa nhân'),
('SP0011', 'Hoàng liên'),
('SP0011', 'Tá dược vừa đủ'),
('SP0011', 'Bạch truật'),
('SP0011', 'Cam thảo'),
('SP0012', 'Long nhãn'),
('SP0012', 'Lá vông'),
('SP0012', 'Lá dâu'),
('SP0012', 'Hắc táo nhân'),
('SP0012', 'Bá tử nhân'),
('SP0012', 'Liên tâm'),
('SP0012', 'Liên Nhục'),
('SP0012', 'Hoài Sơn');

insert into dieutri values
('SP0001', 'Bổ gan'),
('SP0001', 'Suy giảm chức năng gan'),
('SP0001', 'Giảm triệu chứng của viêm gan'),
('SP0001', 'Xơ vữa động mạch'),
('SP0001', 'Mỡ trong máu cao'),
('SP0002', 'Tăng huyết áp'),
('SP0002', 'Cao huyết áp'),
('SP0003', 'Táo bón'),
('SP0003', 'Thải sạch ruột trước khi phẫu thuật'),
('SP0004', 'Viêm họng'),
('SP0004', 'Viêm thanh quản'),
('SP0004', 'Khản tiếng'),
('SP0004', 'Rát họng'),
('SP0005', 'Hội chứng thận hư'),
('SP0005', 'Viêm mạch'),
('SP0005', 'Thiếu máu huyết tán'),
('SP0005', 'Lupus ban đỏ'),
('SP0005', 'Bệnh dị ứng'),
('SP0005', 'Hen phế quản'),
('SP0005', 'Viêm loét đại tràng'),
('SP0005', 'U lympho'),
('SP0005', 'Sarcoid'),
('SP0005', 'Ung thư vú'),
('SP0005', 'Ung thư tuyến tiền liệt'),
('SP0005', 'Viêm khớp dạng thấp'),
('SP0005', 'Giảm bạch cầu hạt'),
('SP0006', 'Thiếu máu'),
('SP0006', 'Thiếu sắt'),
('SP0007', 'Trào ngược dạ dày'),
('SP0008', 'Viêm mũi dị ứng'),
('SP0008', 'Mề đay'),
('SP0009', 'Thoái hóa khớp'),
('SP0009', 'Viêm khớp'),
('SP0010', 'Bổ gan'),
('SP0011', 'Tiêu chảy'),
('SP0011', 'Viêm đại tràng co thắt'),
('SP0011', 'Rối loạn tiêu hóa'),
('SP0011', 'Đi ngoài phân sống'),
('SP0011', 'Viêm đại tràng'),
('SP0011', 'Đầy hơi'),
('SP0011', 'Đau bụng'),
('SP0012', 'Suy nhược cơ thể'),
('SP0012', 'Suy giảm trí nhớ'),
('SP0012', 'Mệt mỏi'),
('SP0012', 'Mất ngủ'),
('SP0012', 'Chán ăn'),
('SP0012', 'Tim đập nhanh');

insert into duocsi values
('AD', 'Admin', NULL, NULL, 1),
('DS0001', 'Lý Văn Công', '0903001001', 'cong@gmail.com', 1),
('DS0002', 'Quách Hồng Linh', '0903001001', 'linh@gmail.com', 1),
('DS0003', 'Đỗ Thị Như Quỳnh', '0903001001', 'quynh@gmail.com', 1),
('DS0004', 'Trần Tuấn Sang', '0903001001', 'sang@gmail.com', 1),
('DS0005', 'Nguyễn Thị Bích Trâm', '0903001001', 'tram@gmail.com', 0),
('DS0006', 'Trần Minh Trường', '0903001001', 'truong@gmail.com', 1);

insert into taikhoan values
('AD', 'Admin', '123456', 255),
('DS0001', 'DS0001', '123456', 224),
('DS0002', 'DS0002', '123456', 224),
('DS0003', 'DS0003', '123456', 224),
('DS0004', 'ttsang793', '123456', 224),
('DS0006', 'DS0006', '123456', 224);

insert into nhacungcap values
('NCC0001', 'Công ty Cổ phần Dược phẩm và Sinh học Y tế (MEBIPHAR JSC)', '18, đường số 13, KCN Tân Bình, quận Tân Phú, TP.HCM', '02838156187', 'contact@mebiphar.vn', 1),
('NCC0002', 'Công ty TNHH Sanofi Aventis Việt Nam', '123 Nguyễn Khoái, phường 1,  quận 4, TP.HCM', '02816669999', 'contact@sanofi.vn', 1),
('NCC0003', 'Công ty cổ phần Hóa - Dược phẩm Mekophar', '297/5, đường Lý Thường Kiệt, phường 15, quận 11, TP.HCM', '02838650258', 'info@mekophar.com', 1);

insert into khachhang (hoten, ngaysinh, gioitinh, sodt, diem) values
('Lê Ngọc Bích Thảo', '2003-09-18', 'Nữ', '0903123456', 320),
('Nguyễn Trọng Nhân', '2002-01-18', 'Nam', '0903123123', 80),
('Nguyễn Hoàng Kiều Ngân', '2003-03-25', 'Nữ', '0903456456', 104);

insert into phieunhap values
('PN0001', '2024-01-11', 'DS0005', 'NCC0003', 4125000),
('PN0002', '2024-01-18', 'DS0001', 'NCC0001', 15500000),
('PN0003', '2024-01-18', 'DS0002', 'NCC0002', 16500000),
('PN0004', '2024-01-18', 'DS0003', 'NCC0003', 9250000),
('PN0005', '2024-02-18', 'DS0004', 'NCC0001', 600000),
('PN0006', '2024-03-18', 'DS0004', 'NCC0002', 600000),
('PN0007', '2024-04-18', 'DS0006', 'NCC0003', 600000);

insert into hoadon values
('HD0001', '2024-01-01', 'DS0001', 1, NULL, 160, 160000),
('HD0002', '2024-01-01', 'DS0002', NULL, NULL, 0, 80000),
('HD0003', '2024-01-01', 'DS0003', NULL, NULL, 0, 80000),
('HD0004', '2024-01-01', 'DS0004', NULL, NULL, 0, 80000),
('HD0005', '2024-01-01', 'DS0005', NULL, NULL, 0, 80000),
('HD0006', '2024-01-01', 'DS0001', NULL, NULL, 0, 160000),
('HD0007', '2024-01-01', 'DS0002', NULL, NULL, 0, 80000),
('HD0008', '2024-01-01', 'DS0003', NULL, NULL, 0, 100000),
('HD0009', '2024-01-01', 'DS0004', NULL, NULL, 0, 160000),
('HD0010', '2024-01-01', 'DS0005', NULL, NULL, 0, 80000),
('HD0011', '2024-02-01', 'DS0001', NULL, NULL, 0, 170000),
('HD0012', '2024-02-01', 'DS0002', NULL, NULL, 0, 640000),
('HD0013', '2024-02-01', 'DS0003', NULL, NULL, 0, 80000),
('HD0014', '2024-02-01', 'DS0004', NULL, NULL, 0, 80000),
('HD0015', '2024-02-01', 'DS0006', NULL, NULL, 0, 80000),
('HD0016', '2024-02-01', 'DS0001', NULL, NULL, 0, 80000),
('HD0017', '2024-02-01', 'DS0002', NULL, NULL, 0, 180000),
('HD0018', '2024-02-01', 'DS0003', NULL, NULL, 0, 80000),
('HD0019', '2024-02-01', 'DS0004', NULL, NULL, 0, 80000),
('HD0020', '2024-02-01', 'DS0006', NULL, NULL, 0, 80000),
('HD0021', '2024-03-01', 'DS0001', NULL, NULL, 0, 160000),
('HD0022', '2024-03-01', 'DS0002', NULL, NULL, 0, 40000),
('HD0023', '2024-03-01', 'DS0003', NULL, NULL, 0, 80000),
('HD0024', '2024-03-01', 'DS0004', NULL, NULL, 0, 80000),
('HD0025', '2024-03-01', 'DS0006', NULL, NULL, 0, 80000),
('HD0026', '2024-03-01', 'DS0001', NULL, NULL, 0, 80000),
('HD0027', '2024-03-01', 'DS0002', 2, NULL, 80, 80000),
('HD0028', '2024-03-01', 'DS0003', NULL, NULL, 0, 240000),
('HD0029', '2024-03-01', 'DS0004', NULL, NULL, 0, 80000),
('HD0030', '2024-03-01', 'DS0006', NULL, NULL, 0, 160000),
('HD0031', '2024-04-01', 'DS0001', NULL, NULL, 0, 80000),
('HD0032', '2024-04-01', 'DS0002', NULL, NULL, 0, 80000),
('HD0033', '2024-04-01', 'DS0003', NULL, NULL, 0, 80000),
('HD0034', '2024-04-01', 'DS0004', NULL, NULL, 0, 80000),
('HD0035', '2024-04-01', 'DS0006', NULL, NULL, 0, 80000),
('HD0036', '2024-04-01', 'DS0001', NULL, NULL, 0, 100000),
('HD0037', '2024-04-01', 'DS0002', 1, NULL, 160, 160000),
('HD0038', '2024-04-01', 'DS0003', NULL, NULL, 0, 20000),
('HD0039', '2024-04-01', 'DS0004', 2, NULL, 80, 72000),
('HD0040', '2024-04-01', 'DS0006', 3, NULL, 104, 104000);

create table chitietsanpham (
    mact int AUTO_INCREMENT primary key,
    masp varchar(50),
    losx varchar(50),
    ngaysx date,
    hansd date,
    phantram decimal(10,0),
    soLuong int,
    constraint foreign key (masp) references sanpham (masp)
);

create table chitietphieunhap (
	mapn varchar(50) not null,
    mact int not null,
    gianhap decimal(10,0),
    soluong int,
    constraint foreign key (mapn) references phieunhap (mapn),
    constraint foreign key (mact) references chitietsanpham (mact),
    constraint primary key (mapn, mact)
);

create table chitiethoadon (
	mahd varchar(50) not null,
    mact int,
    giaban decimal(10,0),
    soLuong int,
    constraint foreign key (mahd) references hoadon (mahd),
    constraint foreign key (mact) references chitietsanpham (mact),
    constraint primary key (mahd, mact)
);

insert into chitietsanpham values
(-1, NULL, NULL, NULL, NULL, NULL, NULL), /*dung cho tich luy diem*/
(1, 'SP0001', 'SX12345TN', '2023-12-24', '2026-06-24', 80000, 13),
(2, 'SP0003', 'SX13381TN', '2023-12-24', '2026-06-24', 8000, 50),
(3, 'SP0004', 'SX14003TN', '2023-12-19', '2026-06-19', 20000, 42),
(4, 'SP0002', 'SX12843TN', '2023-12-24', '2026-06-24', 200000, 50),
(5, 'SP0007', 'PDVN12033', '2023-12-24', '2026-06-24', 104000, 48),
(6, 'SP0009', 'TBSX01393', '2023-12-19', '2026-06-19', 120000, 50),
(7, 'SP0005', 'PDVN12034', '2023-12-24', '2026-06-24', 200000, 50),
(8, 'SP0006', 'PDVN12035', '2023-12-24', '2026-06-24', 160000, 45),
(9, 'SP0008', 'PDVN12040', '2023-12-19', '2026-06-19', 70000, 47),
(10, 'SP0010', 'TBSX01394', '2023-12-24', '2026-06-24', 180000, 49),
(11, 'SP0011', 'TBSX01395', '2023-12-24', '2026-06-24', 90000, 50),
(12, 'SP0012', 'TBSX01396', '2023-12-19', '2026-06-19', 70000, 0),
(13, 'SP0001', 'SX15000TN', '2024-03-11', '2026-10-11', 80000, 20);

insert into chitietphieunhap values
('PN0001', 1, 60000, 50),
('PN0001', 2, 5500, 50),
('PN0001', 3, 17000, 50),
('PN0002', 4, 150000, 50),
('PN0002', 5, 80000, 50),
('PN0002', 6, 80000, 50),
('PN0003', 7, 180000, 50),
('PN0003', 8, 100000, 50),
('PN0003', 9, 50000, 50),
('PN0004', 10, 125000, 50),
('PN0004', 11, 50000, 50),
('PN0004', 12, 50000, 10),
('PN0005', 1, 60000, 10),
('PN0006', 13, 60000, 10),
('PN0007', 13, 60000, 10);

insert into chitiethoadon values
('HD0001', 1, 80000, 2),
('HD0002', 1, 80000, 1),
('HD0002', 3, 20000, 1),
('HD0003', 1, 80000, 1),
('HD0004', 1, 80000, 1),
('HD0005', 1, 80000, 1),
('HD0006', 1, 80000, 2),
('HD0007', 1, 80000, 1),
('HD0008', 3, 20000, 1),
('HD0008', 5, 104000, 1),
('HD0009', 9, 70000, 2),
('HD0009', 3, 20000, 1),
('HD0010', 1, 80000, 1),
('HD0011', 1, 80000, 1),
('HD0011', 9, 70000, 1),
('HD0011', 3, 20000, 1),
('HD0012', 8, 160000, 4),
('HD0013', 1, 80000, 1),
('HD0014', 1, 80000, 1),
('HD0015', 1, 80000, 1),
('HD0016', 1, 80000, 1),
('HD0017', 10, 180000, 1),
('HD0018', 1, 80000, 1),
('HD0019', 1, 80000, 1),
('HD0020', 1, 80000, 1),
('HD0021', 8, 160000, 1),
('HD0022', 3, 20000, 2),
('HD0023', 1, 80000, 1),
('HD0024', 1, 80000, 1),
('HD0025', 1, 80000, 1),
('HD0026', 1, 80000, 1),
('HD0027', 1, 80000, 1),
('HD0028', 1, 80000, 3),
('HD0029', 1, 80000, 1),
('HD0030', 1, 80000, 2),
('HD0031', 1, 80000, 1),
('HD0032', 1, 80000, 2),
('HD0033', 1, 80000, 1),
('HD0034', 1, 80000, 1),
('HD0035', 1, 80000, 1),
('HD0036', 1, 80000, 1),
('HD0037', 1, 80000, 2),
('HD0038', 3, 20000, 2),
('HD0039', 1, 80000, 1),
('HD0039', -1, -8000, 1),
('HD0040', 5, 104000, 1);

create table tieuhuy (
	mact int primary key,
    ngaytieuhuy date not null,
    nguoilap varchar(50) not null,
    lydo nvarchar(512),
    thiethai decimal(10,0),
    constraint foreign key (mact) references chitietsanpham (mact)
);

insert into tieuhuy values
(12, '2024-04-28', 'DS0004', 'Sản phẩm không đảm bảo chất lượng', 500000);

/*Store procedure*/
DELIMITER $$

drop procedure if exists `insertTH`;

create procedure `insertTH`(
    IN in_maSP varchar(50),
    IN in_loSX varchar(50),
    IN in_ngayTieuHuy date,
    IN in_nguoiTieuHuy varchar(50),
    IN in_lyDo varchar(512),
    IN in_thietHai decimal(10,2)
)

begin
	declare `in_maCT` int(11);
    select maCT into `in_maCT` from ChiTietSanPham where maSP = `in_maSP` and loSX = `in_loSX`;
    update ChiTietSanPham set soLuong = 0 where maCT = `in_maCT`;
    insert into TieuHuy values (`in_maCT`, `in_ngayTieuHuy`, `in_nguoiTieuHuy`, `in_lyDo`, `in_thietHai`);
end $$

DELIMITER ;

DELIMITER $$

drop procedure if exists `insertPN`;

create procedure `insertPN`(
	IN in_maPN varchar(50),
    IN in_maSP varchar(50),
    IN in_loSX varchar(50),
    IN in_ngaySX date,
    IN in_hanSD date,
    IN in_giaNhap decimal(10,2),
    IN in_giaBan decimal(10,2),
    IN in_soLuong int
)

begin
	declare `flag` int(11);
	select count(*) into flag from chitietsanpham where maSP = `in_maSP` and loSX = `in_loSX`;
    if (flag > 0) then
		begin
			declare `number` int(11);
			select maCT, soLuong into `flag`, `number` from chitietsanpham where maSP = `in_maSP` and loSX = `in_loSX`;
			update chitietsanpham set soLuong = `number` + `in_soLuong` where maCT = `flag`;
		end;
	else
		begin
			insert into chitietsanpham(maSP, loSX, ngaySX, hanSD, giaBan, soLuong) values (`in_maSP`, `in_loSX`, `in_ngaySX`, `in_hanSD`, `in_giaBan`, `in_soLuong`);        
			select maCT into `flag` from chitietsanpham where maSP = `in_maSP` and loSX = `in_loSX`;
		end;
	end if;
    
    insert into chitietphieunhap values (`in_maPN`, `flag`, `in_giaNhap`, `in_soLuong`);
end $$

DELIMITER ;

DELIMITER $$

drop procedure if exists `updateDiem`;

create procedure `updateDiem` (
    IN in_maKH int,
    IN in_hoTen varchar(50),
    IN in_ngaySinh date,
    IN in_gioiTinh varchar(3),
    IN in_soDT char(10),
    IN in_diem int
)
begin
	declare `flag` int(11);
	select count(*) into flag from khachhang where maKH = `maKH`;
    if (flag > 0) then
    begin
        declare `old_diem` int(11);
        select diem into `old_diem` from khachhang where maKH = `maKH`;
        update khachhang set diem = `old_diem` + `diem` where maKH = `maKH`;
    end
    else
    begin
        insert into khachhang (hoten, ngaysinh, gioitinh, sodt, diem) values
        (`in_hoTen`, `in_ngaySinh`, `in_gioiTinh`, `in_soDT`, `in_diem`)
    end
end

DELIMITER ;

DELIMITER $$

drop procedure if exists `insertCTHD`;

create procedure `insertCTHD`(
	IN in_maHD varchar(50),
    IN in_maCT int,
    IN in_giaBan decimal(10,2),
    IN in_soLuong int
)
begin
	declare `old_soLuong` int(11);
	insert into chitiethoadon values (`in_maHD`, `in_maCT`, `in_giaBan`, `in_soLuong`);    
    select soLuong into `old_soLuong` from chitietsanpham where maCT = `in_maCT`;
    update chitietsanpham set soLuong = `old_soLuong` - `in_soLuong` where maCT = `in_maCT`;
end

DELIMITER ;
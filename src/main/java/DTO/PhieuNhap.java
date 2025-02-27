package DTO;
import java.time.LocalDate;

public class PhieuNhap {
	private String ma;
	private LocalDate ngayLap;
	private String nguoiLap;
	private String nhaCungCap;
	private long tongTien;
	
	public PhieuNhap() {}
	
	public PhieuNhap(String ma, LocalDate ngayLap, String nguoiLap, String nhaCungCap, long tongTien) {
		this.ma = ma;
		this.ngayLap = ngayLap;
		this.nguoiLap = nguoiLap;
		this.nhaCungCap = nhaCungCap;
		this.tongTien = tongTien;
	}

	public String getMa() {
		return ma;
	}
	
	public void setMa(String ma) {
		this.ma = ma;
	}

	public LocalDate getNgayLap() {
		return ngayLap;
	}

	public String getNguoiLap() {
		return nguoiLap;
	}

	public String getNhaCungCap() {
		return nhaCungCap;
	}

	public long getTongTien() {
		return tongTien;
	}
}
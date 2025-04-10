package GUI;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Image;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.border.EmptyBorder;

import BUS.NhaCungCapBUS;
import DTO.NhaCungCap;

public class SuaNhaCungCap extends JDialog {
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTextField tf_ten;
	private JTextField tf_diaChi;
	private JTextField tf_sdt;
	private JTextField tf_email;
	private String maNccUp;
	private NhaCungCapBUS nccBUS = new NhaCungCapBUS();
	
	public void handleUp(String trangthai) {
		if (tf_diaChi.getText().isEmpty() || tf_sdt.getText().isEmpty() || tf_email.getText().isEmpty()) {
			ThongBao.baoLoi("Vui lòng nhập đầy đủ thông tin");
		} else if (!tf_sdt.getText().matches("^(0[1,3-9]\\d{8}|02\\d{9}|\\+\\d{5,})$")) {
			ThongBao.baoLoi("Vui lòng nhập đúng cú pháp số điện thoại");
		} else if (!tf_email.getText().matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$")) {
			ThongBao.baoLoi("Vui lòng nhập đúng cú pháp email");
		}else if (checktrungsdt(tf_sdt.getText(),tf_ten.getText())) {
	        ThongBao.baoLoi("Số điện thoại đã tồn tại!");
	    }else if (checktrungemail(tf_email.getText(),tf_ten.getText())) {
	        ThongBao.baoLoi("Email đã tồn tại!");
	    } else {
			String tenNcc = tf_ten.getText();
			String diachi = tf_diaChi.getText();
			String sdt = tf_sdt.getText();
			String email = tf_email.getText();
			boolean tt = trangthai.equals("Còn hợp tác");
			NhaCungCap ncc = new NhaCungCap(maNccUp, tenNcc, diachi, sdt, email, tt);
			if (nccBUS.editNhaCungCap(ncc)) {
				JOptionPane.showMessageDialog(null, "Cập nhật thành công");
				refersh();
				this.dispose();
			}
		}
	}
	public boolean checktrungsdt(String sdt, String ten) {
	    for (NhaCungCap ncc : nccBUS.getAllNCC()) {
	        if (ncc.getSoDT().equals(sdt.trim()) && !ncc.getTen().equals(ten.trim())) {
	            return true;
	        }
	    }
	    return false;
	}
	public boolean checktrungemail(String email, String ten) {
	    for (NhaCungCap ncc : nccBUS.getAllNCC()) {
	        if (ncc.getEmail().equals(email.trim()) && !ncc.getTen().equals(ten.trim())) {
	            return true;
	        }
	    }
	    return false;
	}
	public void setData(NhaCungCap ncc,boolean check) {
		maNccUp = ncc.getMa();
		tf_ten.setText(ncc.getTen());
		tf_diaChi.setText(ncc.getDiaChi());
		tf_sdt.setText(ncc.getSoDT());
		tf_email.setText(ncc.getEmail());
	}
	
	public void refersh() {
		tf_diaChi.setText("");
		tf_sdt.setText("");
		tf_email.setText("");
	}

	public SuaNhaCungCap(String title,String ten,String trangthai) {
		setIconImage(new ImageIcon("img/icon.png").getImage());
		setTitle(title);
		setResizable(false);
		setModalityType(DEFAULT_MODALITY_TYPE);
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 442, 463);
		setLocationRelativeTo(null);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[] {90, 0};
		gbl_contentPane.rowHeights = new int[] {0, 65, 40, 40, 40, 40};
		gbl_contentPane.columnWeights = new double[]{0.0, 1.0};
		gbl_contentPane.rowWeights = new double[]{0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
		contentPane.setLayout(gbl_contentPane);
		
		JLabel lblTitle = new JLabel(title.toUpperCase());
		lblTitle.setHorizontalAlignment(SwingConstants.CENTER);
		lblTitle.setFont(new Font("Segoe UI", Font.PLAIN, 25));
		GridBagConstraints gbc_lblTitle = new GridBagConstraints();
		gbc_lblTitle.gridwidth = 2;
		gbc_lblTitle.fill = GridBagConstraints.BOTH;
		gbc_lblTitle.insets = new Insets(0, 0, 30, 0);
		gbc_lblTitle.gridx = 0;
		gbc_lblTitle.gridy = 0;
		contentPane.add(lblTitle, gbc_lblTitle);
		
		JLabel lblNewLabel = new JLabel("Tên NCC:");
		lblNewLabel.setFont(new Font("Segoe UI", Font.PLAIN, 18));
		GridBagConstraints gbc_lblNewLabel = new GridBagConstraints();
		gbc_lblNewLabel.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel.fill = GridBagConstraints.VERTICAL;
		gbc_lblNewLabel.insets = new Insets(0, 0, 30, 5);
		gbc_lblNewLabel.gridx = 0;
		gbc_lblNewLabel.gridy = 1;
		contentPane.add(lblNewLabel, gbc_lblNewLabel);
		
		
		tf_ten = new JTextField();
		tf_ten.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		tf_ten.setColumns(10);
		tf_ten.setEditable(false);
		tf_ten.setText(ten);
		
		GridBagConstraints gbc_tf_ten = new GridBagConstraints();
		gbc_tf_ten.fill = GridBagConstraints.BOTH;
		gbc_tf_ten.insets = new Insets(0, 0, 30, 0);
		gbc_tf_ten.gridx = 1;
		gbc_tf_ten.gridy = 1;
		contentPane.add(tf_ten, gbc_tf_ten);
		
		
		JLabel lblaCh = new JLabel("Địa chỉ:");
		lblaCh.setFont(new Font("Segoe UI", Font.PLAIN, 18));
		GridBagConstraints gbc_lblaCh = new GridBagConstraints();
		gbc_lblaCh.anchor = GridBagConstraints.EAST;
		gbc_lblaCh.fill = GridBagConstraints.VERTICAL;
		gbc_lblaCh.insets = new Insets(0, 0, 30, 5);
		gbc_lblaCh.gridx = 0;
		gbc_lblaCh.gridy = 2;
		contentPane.add(lblaCh, gbc_lblaCh);
		
		tf_diaChi = new JTextField();
		tf_diaChi.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		tf_diaChi.setColumns(10);
		GridBagConstraints gbc_tf_diaChi = new GridBagConstraints();
		gbc_tf_diaChi.fill = GridBagConstraints.BOTH;
		gbc_tf_diaChi.insets = new Insets(0, 0, 30, 0);
		gbc_tf_diaChi.gridx = 1;
		gbc_tf_diaChi.gridy = 2;
		contentPane.add(tf_diaChi, gbc_tf_diaChi);
		
		JLabel lblSt = new JLabel("SĐT:");
		lblSt.setFont(new Font("Segoe UI", Font.PLAIN, 18));
		GridBagConstraints gbc_lblSt = new GridBagConstraints();
		gbc_lblSt.anchor = GridBagConstraints.EAST;
		gbc_lblSt.fill = GridBagConstraints.VERTICAL;
		gbc_lblSt.insets = new Insets(0, 0, 30, 5);
		gbc_lblSt.gridx = 0;
		gbc_lblSt.gridy = 3;
		contentPane.add(lblSt, gbc_lblSt);
		
		tf_sdt = new JTextField();
		tf_sdt.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		tf_sdt.setColumns(10);
		GridBagConstraints gbc_tf_sdt = new GridBagConstraints();
		gbc_tf_sdt.fill = GridBagConstraints.BOTH;
		gbc_tf_sdt.insets = new Insets(0, 0, 30, 0);
		gbc_tf_sdt.gridx = 1;
		gbc_tf_sdt.gridy = 3;
		contentPane.add(tf_sdt, gbc_tf_sdt);
		
		JLabel lblEmail = new JLabel("Email:");
		lblEmail.setFont(new Font("Segoe UI", Font.PLAIN, 18));
		GridBagConstraints gbc_lblEmail = new GridBagConstraints();
		gbc_lblEmail.anchor = GridBagConstraints.EAST;
		gbc_lblEmail.fill = GridBagConstraints.VERTICAL;
		gbc_lblEmail.insets = new Insets(0, 0, 30, 5);
		gbc_lblEmail.gridx = 0;
		gbc_lblEmail.gridy = 4;
		contentPane.add(lblEmail, gbc_lblEmail);
		
		tf_email = new JTextField();
		tf_email.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		tf_email.setColumns(10);
		GridBagConstraints gbc_tf_email = new GridBagConstraints();
		gbc_tf_email.fill = GridBagConstraints.BOTH;
		gbc_tf_email.insets = new Insets(0, 0, 30, 0);
		gbc_tf_email.gridx = 1;
		gbc_tf_email.gridy = 4;
		contentPane.add(tf_email, gbc_tf_email);
		
		JPanel buttonPanel = new JPanel();
		buttonPanel.setOpaque(false);
		GridBagConstraints gbc_buttonPanel = new GridBagConstraints();
		gbc_buttonPanel.insets = new Insets(0, 0, 5, 0);
		gbc_buttonPanel.fill = GridBagConstraints.BOTH;
		gbc_buttonPanel.gridx = 1;
		gbc_buttonPanel.gridy = 5;
		contentPane.add(buttonPanel, gbc_buttonPanel);
		buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 40, 0));
		
		JButton btnSave = new JButton("Lưu");
		buttonPanel.add(btnSave);
		btnSave.setPreferredSize(new Dimension(100, 40));
		btnSave.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				handleUp(trangthai);
			}
		});
		btnSave.setFont(new Font("Segoe UI", Font.PLAIN, 18));
		btnSave.setForeground(new Color(255, 255, 255));
		btnSave.setBackground(new Color(11, 101, 140));
		btnSave.setBorderPainted(false);
		btnSave.setFocusPainted(false);
		btnSave.setIcon(new ImageIcon(new ImageIcon("img/Icon/Save.png").getImage().getScaledInstance(24, 24, Image.SCALE_SMOOTH)));
		
		JButton btnRefersh = new JButton("Hủy");
		btnRefersh.setPreferredSize(new Dimension(100, 40));
		buttonPanel.add(btnRefersh);
		btnRefersh.setFont(new Font("Segoe UI", Font.PLAIN, 18));
		btnRefersh.setForeground(new Color(255, 255, 255));
		btnRefersh.setBackground(new Color(11, 101, 140));
		btnRefersh.setBorderPainted(false);
		btnRefersh.setFocusPainted(false);
		btnRefersh.setIcon(new ImageIcon(new ImageIcon("img/Icon/Cancel.png").getImage().getScaledInstance(24, 24, Image.SCALE_SMOOTH)));
		btnRefersh.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dispose();
			}
		});
		
		repainting();
	}
	
	void repainting() {
		Theme.setTheme(this);
		getRootPane().putClientProperty("JRootPane.titleBarBackground", Theme.DARK);
		getRootPane().putClientProperty("JRootPane.titleBarForeground", Color.WHITE);
		contentPane.setBackground(Theme.LIGHT);
	}
	
}

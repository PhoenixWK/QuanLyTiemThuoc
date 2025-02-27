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

import javax.swing.DefaultComboBoxModel;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import BUS.NhaSanXuatBUS;
import DTO.NhaSanXuat;

public class SuaNhaSanXuat extends JDialog {
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTextField tf_ten;
	private String maNsxUp;
	private boolean tt_up;
	private NhaSanXuatBUS nsxBUS = new NhaSanXuatBUS();
	private static boolean close;
	
	public void handlUpdate() {
		if (tf_ten.getText().isEmpty() ){
			JOptionPane.showMessageDialog(null, "Vui lòng nhập đầy đủ thông tin");
			close = false;
		}else {
			if (!tf_ten.getText().equals(tf_ten.getText().trim())) {
	            ThongBao.baoLoi("Tên nhà sản xuất không được bắt đầu hoặc kết thúc bằng khoảng trắng");
	            return;
	        }

	        if (tf_ten.getText().contains("  ")) {
	            ThongBao.baoLoi("Tên nhà sản xuất không được chứa hơn một khoảng trắng giữa các từ");
	            return;
	        }
	        for (NhaSanXuat nsx : nsxBUS.getAllNsx()) {
	            if (tf_ten.getText().equalsIgnoreCase(nsx.getTen()) && !nsx.getMa().equals(maNsxUp)) {
	                ThongBao.baoLoi("Tên nhà sản xuất đã tồn tại");
	                return;
	            }
	        }
			if (nsxBUS.updateNhaSanXuat(new NhaSanXuat(maNsxUp, tf_ten.getText(), tt_up))) {
				ThongBao.thongBao("Sửa nhà sản xuất thành công");
				close = true;
			}
		}
	}
	
	public void setData(NhaSanXuat nsx) {
		maNsxUp = nsx.getMa();
		tf_ten.setText(nsx.getTen());
		tt_up = nsx.getTrangThai();
	}
	
	public void refersh() {
		tf_ten.setText("");
	}
	
	public SuaNhaSanXuat(String title) {
		setIconImage(new ImageIcon("img/icon.png").getImage());
		setTitle(title);
		setResizable(false);
		setModalityType(DEFAULT_MODALITY_TYPE);
		setBounds(100, 100, 443, 270);
		setLocationRelativeTo(null);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));

		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[] {90, 0};
		gbl_contentPane.rowHeights = new int[] {65, 40, 40, 40};
		gbl_contentPane.columnWeights = new double[]{0.0, 0.0};
		gbl_contentPane.rowWeights = new double[]{0.0, 0.0, 0.0, 0.0};
		contentPane.setLayout(gbl_contentPane);
		
		JLabel lblTitle = new JLabel(title.toUpperCase());
		lblTitle.setFont(new Font("Segoe UI", Font.PLAIN, 25));
		GridBagConstraints gbc_lblTitle = new GridBagConstraints();
		gbc_lblTitle.fill = GridBagConstraints.VERTICAL;
		gbc_lblTitle.insets = new Insets(0, 0, 30, 0);
		gbc_lblTitle.gridwidth = 2;
		gbc_lblTitle.gridx = 0;
		gbc_lblTitle.gridy = 0;
		contentPane.add(lblTitle, gbc_lblTitle);
		
		JLabel lblNewLabel = new JLabel("Tên NSX:");
		lblNewLabel.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		GridBagConstraints gbc_lblNewLabel = new GridBagConstraints();
		gbc_lblNewLabel.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel.fill = GridBagConstraints.VERTICAL;
		gbc_lblNewLabel.insets = new Insets(0, 0, 30, 15);
		gbc_lblNewLabel.gridx = 0;
		gbc_lblNewLabel.gridy = 1;
		contentPane.add(lblNewLabel, gbc_lblNewLabel);
		
		tf_ten = new JTextField();
		tf_ten.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		tf_ten.setColumns(10);
		GridBagConstraints gbc_tf_ten = new GridBagConstraints();
		gbc_tf_ten.fill = GridBagConstraints.BOTH;
		gbc_tf_ten.insets = new Insets(0, 0, 30, 0);
		gbc_tf_ten.gridx = 1;
		gbc_tf_ten.gridy = 1;
		contentPane.add(tf_ten, gbc_tf_ten);
		String[] arrTT = {"Còn nhập hàng", "Ngừng nhập hàng"};
		DefaultComboBoxModel<String> defauTT = new DefaultComboBoxModel<>(arrTT);
		
		JPanel buttonPanel = new JPanel();
		buttonPanel.setOpaque(false);
		GridBagConstraints gbc_buttonPanel = new GridBagConstraints();
		gbc_buttonPanel.insets = new Insets(0, 0, 5, 0);
		gbc_buttonPanel.fill = GridBagConstraints.BOTH;
		gbc_buttonPanel.gridx = 1;
		gbc_buttonPanel.gridy = 2;
		contentPane.add(buttonPanel, gbc_buttonPanel);
		buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 40, 0));
		
		JButton btnSave = new JButton("LƯU");
		btnSave.setPreferredSize(new Dimension(100,40));
		buttonPanel.add(btnSave);
		btnSave.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		
		JButton btnRefersh = new JButton("HỦY");
		btnRefersh.setPreferredSize(new Dimension(100,40));
		buttonPanel.add(btnRefersh);
		btnRefersh.setForeground(new Color(255, 255, 255));
		btnRefersh.setBackground(new Color(11, 101, 140));
		btnRefersh.setBorderPainted(false);
		btnRefersh.setFocusPainted(false);
		btnRefersh.setIcon(new ImageIcon(new ImageIcon("img/Icon/Cancel.png").getImage().getScaledInstance(24, 24, Image.SCALE_SMOOTH)));
		btnRefersh.setFont(new Font("Segoe UI", Font.PLAIN, 16));
		btnRefersh.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dispose();
			}
		});
		btnSave.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				handlUpdate();
				if (close == true) {
					NhaSanXuatGUI.loadDataNSX();
					dispose();
				}
			}
		});
		btnSave.setForeground(new Color(255, 255, 255));
		btnSave.setBackground(new Color(11, 101, 140));
		btnSave.setBorderPainted(false);
		btnSave.setFocusPainted(false);
		btnSave.setIcon(new ImageIcon(new ImageIcon("img/Icon/Save.png").getImage().getScaledInstance(24, 24, Image.SCALE_SMOOTH)));
		repainting();
	}
	
	void repainting() {
		Theme.setTheme(this);
		getRootPane().putClientProperty("JRootPane.titleBarBackground", Theme.DARK);
		getRootPane().putClientProperty("JRootPane.titleBarForeground", Color.WHITE);
		contentPane.setBackground(Theme.LIGHT);		
	}
}

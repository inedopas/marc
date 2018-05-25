<?php

class ModelModuleCreatetable extends Model {

    public function ISEXISTS($table_name, $column_name) {
        $query = $this->db->query("select * from  information_schema.columns where TABLE_SCHEMA = '".DB_DATABASE."' and table_name = '" . DB_PREFIX . $table_name . "' and column_name = '" . $column_name . "'");
        return $query->num_rows;
    }
    
    public function ADDALTER($table_name, $column_name, $Value) {
        if (!$this->ISEXISTS($table_name, $column_name)) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . $table_name . "` ADD `" . $column_name . "` " . $Value);
        }
    }

    public function DROPALTER($table_name, $column_name) {
       if ($this->ISEXISTS($table_name, $column_name)) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . $table_name . "` DROP COLUMN `".$column_name."`");
        }
    }

    public function CHANGEALTER($table_name, $column_name, $column_name_change, $Value) {
        if ($this->ISEXISTS($table_name, $column_name)) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . $table_name . "` CHANGE COLUMN `" . $column_name . "` `" . $column_name_change . "` " . $Value);
        }
    }

    public function EditTableVer1() {
		/*
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "affiliate_setting` (affiliate_id INT(11) NOT NULL AUTO_INCREMENT, order_status_id INT(11), days INT(11), total DECIMAL(15,4) NOT NULL, add_auto INT(11), qiwi INT(11), card INT(11), yandex INT(11), webmoney INT(11), cheque INT(11), paypal INT(11), bank INT(11), PRIMARY KEY (affiliate_id))");
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "affiliate_setting` WHERE affiliate_id = 1");
        if (!$query->num_rows) {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "affiliate_setting` SET affiliate_id= 1, order_status_id = '5', days = '7', total = '100.00',cheque = '1', paypal = '1', bank = '1'");
        }*/
        $this->ADDALTER('affiliate', 'qiwi', "VARCHAR(100) NOT NULL DEFAULT ''");
        $this->ADDALTER('affiliate', 'card', "VARCHAR(100) NOT NULL DEFAULT ''");
        $this->ADDALTER('affiliate', 'yandex', "VARCHAR(100) NOT NULL DEFAULT ''");
        //$this->ADDALTER('affiliate', 'webmoney', "VARCHAR(100) NOT NULL DEFAULT ''");
        $this->CHANGEALTER('affiliate', 'payment', 'payment', "VARCHAR(64) NOT NULL");
        $this->ADDALTER('affiliate', 'request_payment', "DECIMAL(10, 2) NOT NULL DEFAULT 0.00");
    }

    public function EditTableVer2() {
		/*
        $this->DROPALTER('affiliate', 'count_transitions');
        $this->DROPALTER('affiliate', 'count_orders');
        $this->DROPALTER('affiliate', 'count_shopping');
        $this->DROPALTER('affiliate', 'sum_orders');
        $this->DROPALTER('affiliate', 'sum_shopping');
		*/
    }

    public function EditTableVer3() {
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "affiliate_statistics` (id INT(11) NOT NULL AUTO_INCREMENT, affiliate_id INT(11) NOT NULL, date_added DATE NOT NULL,  count_transitions INT(11) NOT NULL DEFAULT 0, PRIMARY KEY (id))");
    }

    public function EditTableVer4() {
        $this->ADDALTER('affiliate', 'coupon', 'INT(11)');
        $this->CHANGEALTER('coupon', 'code', 'code', "VARCHAR(64) NOT NULL");
        $this->ADDALTER('coupon', 'affiliate_id', 'INT(11) NOT NULL DEFAULT 0');
    }
    public function EditTableVer5() {
        $this->ADDALTER('affiliate_statistics', 'affiliate_ip_name', 'VARCHAR(64) DEFAULT NULL');
		/*$this->ADDALTER('affiliate', 'webmoneyWMZ', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoneyWMU', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoneyWME', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoneyWMY', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoneyWMB', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoneyWMG', "VARCHAR(100) NOT NULL DEFAULT ''");
		*/
    }
	public function EditTableVer6() {
		$this->CHANGEALTER('affiliate_statistics', 'affiliate_ip_name', 'affiliate_ip_name', "VARCHAR(300) DEFAULT NULL");
		/*$this->ADDALTER('affiliate', 'AlertPay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'Moneybookers', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'LIQPAY', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'SagePay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'twoCheckout', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'GoogleWallet', "VARCHAR(100) NOT NULL DEFAULT ''");
		*/
    }
	public function EditTableVer7() {
		$payment = $this->GetPayment();
		$this->db->query("UPDATE `" . DB_PREFIX . "affiliate` SET payment = '" . $payment . "' WHERE payment = ''");
    }
	
	public function GetPayment() {
		$this->load->model('module/affiliate');
		return $this->model_module_affiliate->getPaymentAffiliate();
    }
	
	public function EditTableVer8() {
		$this->CHANGEALTER('affiliate', 'webmoney', 'webmoney_wmr', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'webmoneyWMZ', 'webmoney_wmz', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'webmoneyWMU', 'webmoney_wmu', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'webmoneyWME', 'webmoney_wme', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'webmoneyWMY', 'webmoney_wmy', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'webmoneyWMB', 'webmoney_wmb', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'webmoneyWMG', 'webmoney_wmg', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'AlertPay', 'alert_pay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'Moneybookers', 'moneybookers', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'LIQPAY', 'liqpay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'SagePay', 'sage_pay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'twoCheckout', 'two_checkout', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->CHANGEALTER('affiliate', 'GoogleWallet', 'google_wallet', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wmr', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wmz', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wmu', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wme', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wmy', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wmb', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'webmoney_wmg', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'alert_pay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'moneybookers', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'liqpay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'sage_pay', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'two_checkout', "VARCHAR(100) NOT NULL DEFAULT ''");
		$this->ADDALTER('affiliate', 'google_wallet', "VARCHAR(100) NOT NULL DEFAULT ''");
    }
	
}

?>
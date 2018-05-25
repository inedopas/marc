<?php

class ModelModuleAffiliate extends Model {

    public function createAffiliate() {
      $this->load->model('module/createtable');
      $this->model_module_createtable->EditTableVer1();
      $this->model_module_createtable->EditTableVer2();
      $this->model_module_createtable->EditTableVer3();
      $this->model_module_createtable->EditTableVer4();
      $this->model_module_createtable->EditTableVer5();
      $this->model_module_createtable->EditTableVer6();
      $this->model_module_createtable->EditTableVer7();
      $this->model_module_createtable->EditTableVer8();
    }

    public function valuePlayment($affiliate_info) {
        $this->language->load('marketing/affiliate');
        return $this->language->get('text_' . $affiliate_info['payment']);
    }

    public function deleteAffiliate($affiliate_id) {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "affiliate` WHERE affiliate_id = '" . (int) $affiliate_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "affiliate_transaction` WHERE affiliate_id = '" . (int) $affiliate_id . "'");
    }
	
	public function validate($order_id, $data, $commission, $total = 0) {
        $affiliatestatus = (int) $this->config->get('affiliate_order_status_id');
        if (
                ((int) $data['affiliate_id'] > 0)
                &
                ((int) $data['order_status_id'] == $affiliatestatus)
                &
                ($order_id != 0)
        ) {
            $query_affiliate = $this->db->query("SELECT * FROM `" . DB_PREFIX . "affiliate_transaction` WHERE order_id = '" . (int) $order_id . "'");
            $query_affiliate_bool = $query_affiliate->num_rows;
            if (!$query_affiliate_bool) {
				$this->language->load('sale/order');
                $this->load->model('marketing/affiliate');
                $this->model_marketing_affiliate->addTransaction((int) $data['affiliate_id'], $this->language->get('text_order_id') . ' #' . $order_id, (float) $commission, $order_id);
            }
        }
    }
	
    public function validateHistory($order_id, $order_info, $data) {
        $affiliatestatus = (int) $this->config->get('affiliate_order_status_id');
        if (
                ((int) $order_info['affiliate_id'] > 0)
                &
                ((int) $data['order_status_id'] == $affiliatestatus)
                &
                ($order_id != 0)
        ) {
            $query_affiliate = $this->db->query("SELECT * FROM `" . DB_PREFIX . "affiliate_transaction` WHERE order_id = '" . (int) $order_id . "'");
            $query_affiliate_bool = $query_affiliate->num_rows;
            if (!$query_affiliate_bool) {
				$this->language->load('sale/order');
                $this->load->model('marketing/affiliate');
                $this->model_marketing_affiliate->addTransaction((int) $order_info['affiliate_id'], $this->language->get('text_order_id') . ' #' . $order_id, (float) $order_info['commission'], $order_id);
            }
        }
    }

    public function addTrackingCoupon($data = array()) {
        $query = $this->db->query("SELECT DISTINCT * FROM `" . DB_PREFIX . "affiliate` WHERE coupon is NULL");
        $data['logged'] = 0;
        $data['uses_total'] = 0;
        $data['uses_customer'] = 0;
        $data['status'] = 1;
        $data['shipping'] = 0;
        $data['date_start'] = date("Y-m-d H:i:s");
        $data['date_end'] = date('Y-m-d H:i:s', PHP_INT_MAX);
        $data['uses_total'] = 0;
        $data['uses_customer'] = 0;
        $data['status'] = 1;
        $this->load->model('marketing/coupon');
        foreach ($query->rows as $row) {
            $data['name'] = $row['firstname'] . ' ' . $row['lastname'];
            $data['code'] = $row['code'];
            $this->model_marketing_coupon->addCoupon($data);
            $idcoupon = $this->db->getLastId();
            $this->db->query("UPDATE `" . DB_PREFIX . "affiliate` SET coupon = '" . (int)$idcoupon . "' WHERE affiliate_id = '" . (int) $row['affiliate_id'] . "'");
            $this->db->query("UPDATE `" . DB_PREFIX . "coupon` SET affiliate_id = '" . (int)$row['affiliate_id'] . "' WHERE coupon_id = '" . (int) $idcoupon . "'");
        }
    }
     public function dellTrackingCoupon($coupon) {
            $this->db->query("UPDATE `" . DB_PREFIX . "affiliate` set coupon = NULL WHERE coupon ='" . $coupon . "'");
     }
     public function updateMaxDate() {
            $this->db->query("UPDATE `" . DB_PREFIX . "coupon` set date_end = ".date('Y-m-d H:i:s', PHP_INT_MAX)." WHERE affiliate_id != 0");
     }
     public function isAffilateCoupon($coupon_id) {
            $query = $this->db->query("SELECT * from `" . DB_PREFIX . "coupon` WHERE (coupon_id ='" . $coupon_id . "' and affiliate_id = 0)");
            return $query->num_rows;
     }
	 
	 public function getPaymentAffiliate ($affiliate_info = array()) {
		$payment = null;
		if (array_key_exists('payment', $affiliate_info)) {
			if ((bool)$this->config->get('affiliate_' . $affiliate_info['payment'])) {
				$payment = $affiliate_info['payment'];
				return $payment;
			}
		}
		
		$affiliate_bonus = (bool)$this->config->get('affiliate_bonus');
		$affiliate_cheque = (bool)$this->config->get('affiliate_cheque');
		$affiliate_paypal = (bool)$this->config->get('affiliate_paypal');
		$affiliate_bank = (bool)$this->config->get('affiliate_bank');
		$affiliate_qiwi = (bool)$this->config->get('affiliate_qiwi');
		$affiliate_card = (bool)$this->config->get('affiliate_card');
		$affiliate_yandex = (bool)$this->config->get('affiliate_yandex');
		$affiliate_webmoney_wmr = (bool)$this->config->get('affiliate_webmoney_wmr');
		$affiliate_webmoney_wmz = (bool)$this->config->get('affiliate_webmoney_wmz');
		$affiliate_webmoney_wmu = (bool)$this->config->get('affiliate_webmoney_wmu');
		$affiliate_webmoney_wme = (bool)$this->config->get('affiliate_webmoney_wme');
		$affiliate_webmoney_wmy = (bool)$this->config->get('affiliate_webmoney_wmy');
		$affiliate_webmoney_wmb = (bool)$this->config->get('affiliate_webmoney_wmb');
		$affiliate_webmoney_wmg = (bool)$this->config->get('affiliate_webmoney_wmg');
		$affiliate_alert_pay = (bool)$this->config->get('affiliate_alert_pay');
		$affiliate_moneybookers = (bool)$this->config->get('affiliate_moneybookers');
		$affiliate_liqpay = (bool)$this->config->get('affiliate_liqpay');
		$affiliate_sage_pay = (bool)$this->config->get('affiliate_sage_pay');
		$affiliate_two_checkout = (bool)$this->config->get('affiliate_two_checkout');
		$affiliate_google_wallet = (bool)$this->config->get('affiliate_google_wallet');
		
		if($affiliate_bonus){
			$payment = 'bonus';
		} else if($affiliate_cheque){
			$payment = 'cheque';
		} else if($affiliate_paypal){
			$payment = 'paypal';
		} else if($affiliate_bank){
			$payment = 'bank';
		} else if($affiliate_qiwi){
			$payment = 'qiwi';
		} else if($affiliate_card){
			$payment = 'card';
		} else if($affiliate_yandex){
			$payment = 'yandex';
		} else if($affiliate_webmoney_wmr){
			$payment = 'webmoney_wmr';
		} else if($affiliate_webmoney_wmz){
			$payment = 'webmoney_wmz';
		} else if($affiliate_webmoney_wmu){
			$payment = 'webmoney_wmu';
		} else if($affiliate_webmoney_wme){
			$payment = 'webmoney_wme';
		} else if($affiliate_webmoney_wmy){
			$payment = 'webmoney_wmy';
		} else if($affiliate_webmoney_wmb){
			$payment = 'webmoney_wmb';
		} else if($affiliate_webmoney_wmg){
			$payment = 'webmoney_wmg';
		} else if($affiliate_alert_pay){
			$payment = 'alert_pay';
		} else if($affiliate_moneybookers){
			$payment = 'moneybookers';
		} else if($affiliate_liqpay){
			$payment = 'liqpay';
		} else if($affiliate_sage_pay){
			$payment = 'sage_pay';
		} else if($affiliate_two_checkout){
			$payment = 'two_checkout';
		} else if($affiliate_google_wallet){
			$payment = 'google_wallet';
		}
		return $payment;
	 }
	 
	 public function getPaymentAffiliateConfig ($request_post, $affiliate_info) {
		
	 }
   
	 public function getInfoModule() {
      $data = array();
      if ((boolean)$this->getExists('is_dorabotka')) {
        return '';
      }
      $informer = $this->getInfo('code&tracking=' . constant('HTTP_CATALOG'));
      $elements = explode("<newelement>", $informer);
      foreach ($elements as $element) {
        $arr = json_decode($element, true);
        $arr['isexists'] = $this->getExists('is_' . $arr['name']);
        if ((boolean)$arr['isexists']) {
          $new = $arr['version'];
          $old = $this->getVer('is_' . $arr['name']);
          if ((boolean)$this->isVer($new, $old)) {
            $arr['versioninfo'] = null;
          } else {
            $arr['versioninfo'] = sprintf($arr['versioninfo'] , $new, $old);
          }
        }
        $data[] = $arr;
      }
      return $data;
   }
   
	 public function getInfo ($product) {
      $info = '';
      try {
        $info = file_get_contents('http://partnerkaprog.ru/index.php?route=account/order/' . $product);
      } catch (Exception $e) {
        
      }
      return $info;
   }
	 public function getExists ($product) {
      $info = false;
      if (file_exists(DIR_SYSTEM.'library/affiliate/affiliate_mod/' . $product . '.php')) {
        $info = true;
      }
      return $info;
   }
	 public function getVer($product, $int = true) {
      $xml = simplexml_load_file(DIR_SYSTEM.'library/affiliate/affiliate_mod/' . $product . '.php');
      foreach ($xml->version as $info) {
        return $info[0];
      }
      return '9999999999';
   }

   public function isVer($new, $old) {
    $new_int = (double)('0.'.preg_replace('~\.~', '', $new));
    $old_int = (double)('0.'.preg_replace('~\.~', '',  $old));
     if ((double)$new_int <= (double)$old_int) {
        return true;
     }
     return false;
   }
          
}
?>
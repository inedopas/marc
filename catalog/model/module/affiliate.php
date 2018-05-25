<?php
class ModelModuleAffiliate extends Model {
    public function validate($order_id, $order_info, $order_status_id) {
        $affiliatestatus = (int) $this->config->get('affiliate_order_status_id');
        if (
                ((int) $order_info['affiliate_id'] > 0)
                &
                ($order_status_id == $affiliatestatus)
                &
                ($order_id != 0)
        ) {
            $query_affiliate = $this->db->query("SELECT * FROM `" . DB_PREFIX . "affiliate_transaction` WHERE order_id = '" . (int) $order_id . "'");
            $query_affiliate_bool = $query_affiliate->num_rows;
            if (!$query_affiliate_bool) {
                $this->language->load('account/order');
                $this->addTransaction((int) $order_info['affiliate_id'], $this->language->get('text_order_id') . ' #' . $order_id, (float) $order_info['commission'], $order_id);
            }
        }
    }
    public function addRequestPayment($request_payment) {

        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "affiliate` WHERE affiliate_id = '" . (int) $this->affiliate->getId() . "'");
        if ($query->num_rows) {
            $this->language->load('mail/affiliate');

            $subject = sprintf($this->language->get('text_subject_request_payment'), $this->db->escape($query->row['firstname']) . ' ' .
                    $this->db->escape($query->row['lastname']));

            $message = sprintf($this->language->get('text_request_payment'), $this->config->get('config_name'), $this->db->escape($query->row['firstname']) . ' ' .
                    $this->db->escape($query->row['lastname']), $this->currency->format($request_payment, $this->session->data['currency'])
            );
            $ver = str_replace(".", "", VERSION);
            if ((int)$ver < 2031) {
              $mail = new Mail($this->config->get('config_mail'));
            } else {
              $mail = new Mail();
              $mail->protocol = $this->config->get('config_mail_protocol');
              $mail->parameter = $this->config->get('config_mail_parameter');
              $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
              $mail->smtp_username = $this->config->get('config_mail_smtp_username');
              $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
              $mail->smtp_port = $this->config->get('config_mail_smtp_port');
              $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
            }
            $mail->setTo($this->config->get('config_email'));
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
            $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
            $mail->send();

            $subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));

            $message = sprintf($this->language->get('text_payment'), $this->db->escape($query->row['firstname']) . ' ' .
                    $this->db->escape($query->row['lastname']), $this->currency->format($request_payment, $this->session->data['currency']), $this->config->get('affiliate_days')
            );
            $mail->setTo($query->row['email']);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
            $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
            $mail->send();
        }
    }

    public function ConvertLocalCurrency($currency) {
        return $this->currency->convert($currency, $this->session->data['currency'], $this->config->get('config_currency'));
    }

    public function ConvertSessionCurrency($currency) {
        return $this->currency->convert($currency, $this->config->get('config_currency'), $this->session->data['currency']);
    }

    public function editOrderPayment($data) {
        $this->load->model('affiliate/transaction');
        $balance = $this->model_affiliate_transaction->getBalance();
        $this->load->model('affiliate/affiliate');
        $affiliate_info = $this->model_affiliate_affiliate->getAffiliate((int) $this->affiliate->getId());
        $request_payment_history = $affiliate_info['request_payment'];
        $min_balanse = $this->config->get('affiliate_total');

        $request_payment = $this->ConvertLocalCurrency((double) $this->db->escape($data['request_payment']));


        if ($request_payment >= $balance) {
            $request_payment = $balance;
            $this->addRequestPayment($request_payment);
        } elseif ($request_payment < $min_balanse) {
            if ($request_payment_history > 0) {
                $request_payment = $request_payment_history;
            } else {
                $request_payment = 0.00;
            }
        } else {
            $request_payment = $this->db->escape($request_payment);
            $this->addRequestPayment($request_payment);
        }
        $this->db->query("UPDATE `" . DB_PREFIX . "affiliate` SET request_payment = '" . $request_payment . "' WHERE affiliate_id = '" . (int) $this->affiliate->getId() . "'");
    }

    public function addTransaction($affiliate_id, $description = '', $amount = '', $order_id = 0) {
      $this->load->model('affiliate/affiliate');
        $affiliate_info = $this->model_affiliate_affiliate->getAffiliate($affiliate_id);
        if ($affiliate_info & (float) $amount != 0) {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "affiliate_transaction` SET affiliate_id = '" . (int) $affiliate_id . "', order_id = '" . (float) $order_id . "', description = '" . $this->db->escape($description) . "', amount = '" . (float) $amount . "', date_added = NOW()");
            if ((int) $this->db->escape($amount) < 0) {
                $query_request_payment = $this->db->query("SELECT request_payment AS total FROM `" . DB_PREFIX . "affiliate` WHERE affiliate_id = '" . (int) $affiliate_id . "'");
                $request_payment_value = $query_request_payment->row['total'] + $amount;
                if ($request_payment_value < 0) {
                    $request_payment_value = 0.00;
                }
                $this->db->query("UPDATE `" . DB_PREFIX . "affiliate` SET request_payment = '" . $request_payment_value . "' WHERE affiliate_id = '" . (int) $affiliate_id . "'");
            }
			$getlevel = $this->config->get('affiliate_level_commission');
			if(($getlevel) & ($affiliate_id!=0)) {
				$this->load->model('checkout/order');
				$order_info = $this->model_checkout_order->getOrder($order_id);
				$this->load->model('module/statisticsmyaffiliate');
				$levelcount = count($getlevel);
				$text = $this->model_module_statisticsmyaffiliate->getAffiliateParent((int)$affiliate_id, 0, $levelcount);
				$getaffiliates = $this->model_module_statisticsmyaffiliate->getAffiliateCommission($text, $getlevel, $order_info);
				foreach ($getaffiliates as $parentaffiliate) {
          if ((int)$order_id != 0 ) {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "affiliate_transaction` SET affiliate_id = '" . (int)$parentaffiliate['affiliate_id'] . "', order_id = '" . (float)$order_id . "', description = '" . $this->db->escape($description). " (" .$affiliate_info['firstname'] ." ". $affiliate_info['lastname'] . ")', amount = '" . (float)$parentaffiliate['total'] . "', date_added = NOW(), affiliate_children = '" . $affiliate_id . "'");
            //mmm_dop_fun
          }
				} 
			}
		}
	}
  public function isAffCoupon($code_coupon) { 
    $query_coupon = $this->db->query("SELECT DISTINCT affiliate_id FROM `" . DB_PREFIX . "coupon` WHERE code = '" . $code_coupon . "'"); 
    $query = $this->db->query("SELECT DISTINCT code FROM `" . DB_PREFIX . "affiliate` WHERE affiliate_id = '" . $query_coupon->row['affiliate_id'] . "'"); 
    if ($query->num_rows) { 
      foreach ($query->rows as $row) { 
        setcookie('tracking', $row['code']); 
        $this->session->data['tracking'] = $row['code']; 
        $this->request->cookie['tracking'] = $row['code']; 
      } 
    } 
    return $query->num_rows; 
  }
    public function isTrackingCoupon($Coupon) {

        $query = $this->db->query("SELECT DISTINCT code FROM `" . DB_PREFIX . "affiliate` WHERE coupon = '" . $Coupon . "' or code = '" . $Coupon . "'");
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                setcookie('tracking', $row['code']);
				$this->session->data['tracking'] = $row['code'];
				$this->request->cookie['tracking'] = $row['code'];
            }
        }
        return $query->num_rows;
    }
	
	 public function getTrackingCoupon($affiliate_id) {
        $query = $this->db->query("SELECT DISTINCT code FROM `" . DB_PREFIX . "coupon` WHERE affiliate_id = '" . $affiliate_id . "'");
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                return $row['code'];
            }
        }
        return null;
    }
	
	public function getHomeUrl() {
		return HTTP_SERVER . '?tracking=' . $this->affiliate->getCode();
	}
	
	public function getSumbol() {
		$affiliate_sumbol = $this->config->get('affiliate_sumbol');
		if ($affiliate_sumbol == 1) {
			return '&';
		} else if ($affiliate_sumbol == 2) {
			return '?';
		}
		return '&';
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
}
?>
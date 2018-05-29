<?php
class ControllerAffiliatePayment extends Controller {
	private $error = array();


        private function validate() {

          if ($this->request->post['payment'] == 'qiwi') {
            if (!preg_match("/^[0-9]{10}$/", $this->request->post['qiwi'])) {
              $this->error['qiwi'] = $this->language->get('error_qiwi');
            }
          }
          if ($this->request->post['payment'] == 'card') {
            if (
                (preg_match("/^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{1,4}-{0,1}[0-9]{0,3}$/", $this->request->post['card']))
               || (preg_match("/^[X]{4}-[X]{4}-[X]{4}-[0-9]{1,4}-{0,1}[0-9]{0,3}$/", $this->request->post['card']))
               ) 
             {
              $affiliate_info = $this->model_affiliate_affiliate->getAffiliate($this->affiliate->getId());
              if((empty($affiliate_info['card']))
                &&(preg_match("/^[X]{4}-[X]{4}-[X]{4}-[0-9]{1,4}-{0,1}[0-9]{0,3}$/", $this->request->post['card']))
                )
              {
                $this->error['card'] = $this->language->get('error_card');  
              }               
              if (strlen($this->request->post['card']) == 16) {
                
              } else if (strlen($this->request->post['card']) == 19) {
                
              } else if (strlen($this->request->post['card']) == 23) {
                
              } else {
                $this->error['card'] = $this->language->get('error_card');
              }
            } else {
              $this->error['card'] = $this->language->get('error_card');
            }
          }
          if ($this->request->post['payment'] == 'yandex') {
            if (!preg_match("/^[0-9]{14,15}$/", $this->request->post['yandex'])) {
              $this->error['yandex'] = $this->language->get('error_yandex');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wmr') {
            if (!preg_match("/^R[0-9]{12}$/", $this->request->post['webmoney_wmr'])) {
              $this->error['webmoney_wmr'] = $this->language->get('error_webmoney_wmr');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wmz') {
            if (!preg_match("/^Z[0-9]{12}$/", $this->request->post['webmoney_wmz'])) {
              $this->error['webmoney_wmz'] = $this->language->get('error_webmoney_wmz');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wmu') {
            if (!preg_match("/^U[0-9]{12}$/", $this->request->post['webmoney_wmu'])) {
              $this->error['webmoney_wmu'] = $this->language->get('error_webmoney_wmu');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wme') {
            if (!preg_match("/^E[0-9]{12}$/", $this->request->post['webmoney_wme'])) {
              $this->error['webmoney_wme'] = $this->language->get('error_webmoney_wme');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wmy') {
            if (!preg_match("/^Y[0-9]{12}$/", $this->request->post['webmoney_wmy'])) {
              $this->error['webmoney_wmy'] = $this->language->get('error_webmoney_wmy');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wmb') {
            if (!preg_match("/^B[0-9]{12}$/", $this->request->post['webmoney_wmb'])) {
              $this->error['webmoney_wmb'] = $this->language->get('error_webmoney_wmb');
            }
          }
          if ($this->request->post['payment'] == 'webmoney_wmg') {
            if (!preg_match("/^G[0-9]{12}$/", $this->request->post['webmoney_wmg'])) {
              $this->error['webmoney_wmg'] = $this->language->get('error_webmoney_wmg');
            }
          }
          if (!$this->error) {
            return true;
          } else {
            return false;
          }
        }
      
	public function index() {
		if (!$this->affiliate->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('affiliate/payment', '', true);

			$this->response->redirect($this->url->link('affiliate/login', '', true));
		}

		$this->load->language('affiliate/payment');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('affiliate/affiliate');

		
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
      
			$this->model_affiliate_affiliate->editPayment($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			// Add to activity log
			if ($this->config->get('config_customer_activity')) {
				$this->load->model('affiliate/activity');

				$activity_data = array(
					'affiliate_id' => $this->affiliate->getId(),
					'name'         => $this->affiliate->getFirstName() . ' ' . $this->affiliate->getLastName()
				);

				$this->model_affiliate_activity->addActivity('payment', $activity_data);
			}

			$this->response->redirect($this->url->link('affiliate/account', '', true));
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('affiliate/account', '', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('affiliate/payment', '', true)
		);

		$data['heading_title'] = $this->language->get('heading_title');

$data['text_bonus'] = $this->language->get('text_bonus');
$data['text_qiwi'] = $this->language->get('text_qiwi');
$data['text_card'] = $this->language->get('text_card');
$data['text_yandex'] = $this->language->get('text_yandex');
$data['text_webmoney_wmr'] = $this->language->get('text_webmoney_wmr');
$data['text_webmoney_wmz'] = $this->language->get('text_webmoney_wmz');
$data['text_webmoney_wmu'] = $this->language->get('text_webmoney_wmu');
$data['text_webmoney_wme'] = $this->language->get('text_webmoney_wme');
$data['text_webmoney_wmy'] = $this->language->get('text_webmoney_wmy');
$data['text_webmoney_wmb'] = $this->language->get('text_webmoney_wmb');
$data['text_webmoney_wmg'] = $this->language->get('text_webmoney_wmg');
$data['text_alert_pay'] = $this->language->get('text_alert_pay');
$data['text_moneybookers'] = $this->language->get('text_moneybookers');
$data['text_liqpay'] = $this->language->get('text_liqpay');
$data['text_sage_pay'] = $this->language->get('text_sage_pay');
$data['text_two_checkout'] = $this->language->get('text_two_checkout');
$data['text_google_wallet'] = $this->language->get('text_google_wallet');

$data['entry_payment'] = $this->language->get('entry_payment');
$data['entry_qiwi'] = $this->language->get('entry_qiwi');
$data['entry_card'] = $this->language->get('entry_card');
$data['entry_yandex'] = $this->language->get('entry_yandex');
$data['entry_webmoney_wmr'] = $this->language->get('entry_webmoney_wmr');
$data['entry_webmoney_wmz'] = $this->language->get('entry_webmoney_wmz');
$data['entry_webmoney_wmu'] = $this->language->get('entry_webmoney_wmu');
$data['entry_webmoney_wme'] = $this->language->get('entry_webmoney_wme');
$data['entry_webmoney_wmy'] = $this->language->get('entry_webmoney_wmy');
$data['entry_webmoney_wmb'] = $this->language->get('entry_webmoney_wmb');
$data['entry_webmoney_wmg'] = $this->language->get('entry_webmoney_wmg');
$data['entry_alert_pay'] = $this->language->get('entry_alert_pay');
$data['entry_moneybookers'] = $this->language->get('entry_moneybookers');
$data['entry_liqpay'] = $this->language->get('entry_liqpay');
$data['entry_sage_pay'] = $this->language->get('entry_sage_pay');
$data['entry_two_checkout'] = $this->language->get('entry_two_checkout');
$data['entry_google_wallet'] = $this->language->get('entry_google_wallet');

$data['title_qiwi'] = $this->language->get('title_qiwi');
$data['title_card'] = $this->language->get('title_card');
$data['title_yandex'] = $this->language->get('title_yandex');
$data['title_webmoney_wmr'] = $this->language->get('title_webmoney_wmr');
$data['title_webmoney_wmz'] = $this->language->get('title_webmoney_wmz');
$data['title_webmoney_wmu'] = $this->language->get('title_webmoney_wmu');
$data['title_webmoney_wme'] = $this->language->get('title_webmoney_wme');
$data['title_webmoney_wmy'] = $this->language->get('title_webmoney_wmy');
$data['title_webmoney_wmb'] = $this->language->get('title_webmoney_wmb');
$data['title_webmoney_wmg'] = $this->language->get('title_webmoney_wmg');
$data['title_alert_pay'] = $this->language->get('title_alert_pay');
$data['title_moneybookers'] = $this->language->get('title_moneybookers');
$data['title_liqpay'] = $this->language->get('title_liqpay');
$data['title_sage_pay'] = $this->language->get('title_sage_pay');
$data['title_two_checkout'] = $this->language->get('title_two_checkout');
$data['title_google_wallet'] = $this->language->get('title_google_wallet');
                
$data['affiliate_bonus'] = (bool)$this->config->get('affiliate_bonus');
$data['affiliate_cheque'] = (bool)$this->config->get('affiliate_cheque');
$data['affiliate_paypal'] = (bool)$this->config->get('affiliate_paypal');
$data['affiliate_bank'] = (bool)$this->config->get('affiliate_bank');
$data['affiliate_qiwi'] = (bool)$this->config->get('affiliate_qiwi');
$data['affiliate_card'] = (bool)$this->config->get('affiliate_card');
$data['affiliate_yandex'] = (bool)$this->config->get('affiliate_yandex');
$data['affiliate_webmoney_wmr'] = (bool)$this->config->get('affiliate_webmoney_wmr');    
$data['affiliate_webmoney_wmz'] = (bool)$this->config->get('affiliate_webmoney_wmz');
$data['affiliate_webmoney_wmu'] = (bool)$this->config->get('affiliate_webmoney_wmu');
$data['affiliate_webmoney_wme'] = (bool)$this->config->get('affiliate_webmoney_wme');
$data['affiliate_webmoney_wmy'] = (bool)$this->config->get('affiliate_webmoney_wmy');
$data['affiliate_webmoney_wmb'] = (bool)$this->config->get('affiliate_webmoney_wmb');
$data['affiliate_webmoney_wmg'] = (bool)$this->config->get('affiliate_webmoney_wmg');
$data['affiliate_alert_pay'] = (bool)$this->config->get('affiliate_alert_pay');
$data['affiliate_moneybookers'] = (bool)$this->config->get('affiliate_moneybookers');
$data['affiliate_liqpay'] = (bool)$this->config->get('affiliate_liqpay');
$data['affiliate_sage_pay'] = (bool)$this->config->get('affiliate_sage_pay');
$data['affiliate_two_checkout'] = (bool)$this->config->get('affiliate_two_checkout');
$data['affiliate_google_wallet'] = (bool)$this->config->get('affiliate_google_wallet');
        
if (isset($this->error['qiwi'])) {
  $data['error_qiwi'] = $this->error['qiwi'];
} else {
  $data['error_qiwi'] = '';
}

if (isset($this->error['card'])) {
  $data['error_card'] = $this->error['card'];
} else {
  $data['error_card'] = '';
}

if (isset($this->error['yandex'])) {
  $data['error_yandex'] = $this->error['yandex'];
} else {
  $data['error_yandex'] = '';
}

if (isset($this->error['webmoney_wmr'])) {
  $data['error_webmoney_wmr'] = $this->error['webmoney_wmr'];
} else {
  $data['error_webmoney_wmr'] = '';
}
if (isset($this->error['webmoney_wmz'])) {
  $data['error_webmoney_wmz'] = $this->error['webmoney_wmz'];
} else {
  $data['error_webmoney_wmz'] = '';
}
if (isset($this->error['webmoney_wmu'])) {
  $data['error_webmoney_wmu'] = $this->error['webmoney_wmu'];
} else {
  $data['error_webmoney_wmu'] = '';
}
if (isset($this->error['webmoney_wme'])) {
  $data['error_webmoney_wme'] = $this->error['webmoney_wme'];
} else {
  $data['error_webmoney_wme'] = '';
}
if (isset($this->error['webmoney_wmy'])) {
  $data['error_webmoney_wmy'] = $this->error['webmoney_wmy'];
} else {
  $data['error_webmoney_wmy'] = '';
}
if (isset($this->error['webmoney_wmb'])) {
  $data['error_webmoney_wmb'] = $this->error['webmoney_wmb'];
} else {
  $data['error_webmoney_wmb'] = '';
}
if (isset($this->error['webmoney_wmg'])) {
  $data['error_webmoney_wmg'] = $this->error['webmoney_wmg'];
} else {
  $data['error_webmoney_wmg'] = '';
}
      

		$data['text_your_payment'] = $this->language->get('text_your_payment');
		$data['text_cheque'] = $this->language->get('text_cheque');
		$data['text_paypal'] = $this->language->get('text_paypal');
		$data['text_bank'] = $this->language->get('text_bank');

		$data['entry_tax'] = $this->language->get('entry_tax');
		$data['entry_payment'] = $this->language->get('entry_payment');
		$data['entry_cheque'] = $this->language->get('entry_cheque');
		$data['entry_paypal'] = $this->language->get('entry_paypal');
		$data['entry_bank_name'] = $this->language->get('entry_bank_name');
		$data['entry_bank_branch_number'] = $this->language->get('entry_bank_branch_number');
		$data['entry_bank_swift_code'] = $this->language->get('entry_bank_swift_code');
		$data['entry_bank_account_name'] = $this->language->get('entry_bank_account_name');
		$data['entry_bank_account_number'] = $this->language->get('entry_bank_account_number');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_back'] = $this->language->get('button_back');

		$data['action'] = $this->url->link('affiliate/payment', '', true);

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
			$affiliate_info = $this->model_affiliate_affiliate->getAffiliate($this->affiliate->getId());
		}

		if (isset($this->request->post['tax'])) {
			$data['tax'] = $this->request->post['tax'];
		} elseif (!empty($affiliate_info)) {
			$data['tax'] = $affiliate_info['tax'];
		} else {
			$data['tax'] = '';
		}

		if (isset($this->request->post['payment'])) {
			$data['payment'] = $this->request->post['payment'];
		} elseif (!empty($affiliate_info)) {
			
$this->load->model('module/affiliate');
$data['payment'] = $this->model_module_affiliate->getPaymentAffiliate($affiliate_info);
      
		} else {
			
$this->load->model('module/affiliate');
$data['payment'] = $this->model_module_affiliate->getPaymentAffiliate();
      
		}


if (isset($this->request->post['qiwi'])) {
  $data['qiwi'] = $this->request->post['qiwi'];
} elseif (!empty($affiliate_info)) {
  $data['qiwi'] = $affiliate_info['qiwi'];
} else {
  $data['qiwi'] = '';
}

if (isset($this->request->post['card'])) {
  $data['card'] = $this->request->post['card'];
} elseif (!empty($affiliate_info)) {
  $affiliate_info_card = $affiliate_info['card'];
  if (strlen($affiliate_info_card) != 0) {
    $data['card'] = 'XXXX-XXXX-XXXX-' . substr($affiliate_info_card, 15, strlen($affiliate_info_card));
  } else {
    $data['card'] = '';
  }
} else {
  $data['card'] = '';
}

if (isset($this->request->post['yandex'])) {
  $data['yandex'] = $this->request->post['yandex'];
} elseif (!empty($affiliate_info)) {
  $data['yandex'] = $affiliate_info['yandex'];
} else {
  $data['yandex'] = '';
}

if (isset($this->request->post['webmoney_wmr'])) {
  $data['webmoney_wmr'] = $this->request->post['webmoney_wmr'];
} elseif (!empty($affiliate_info)) {
  $data['webmoney_wmr'] = $affiliate_info['webmoney_wmr'];
} else {
  $data['webmoney_wmr'] = '';
}

if (isset($this->request->post['webmoney_wmz'])) {
  $data['webmoney_wmz'] = $this->request->post['webmoney_wmz'];
} elseif (!empty($affiliate_info)) { 
  $data['webmoney_wmz'] = $affiliate_info['webmoney_wmz'];
} else {
  $data['webmoney_wmz'] = '';
}

if (isset($this->request->post['webmoney_wmu'])) {
  $data['webmoney_wmu'] = $this->request->post['webmoney_wmu'];
} elseif (!empty($affiliate_info)) { 
  $data['webmoney_wmu'] = $affiliate_info['webmoney_wmu'];
} else {
  $data['webmoney_wmu'] = '';
}

if (isset($this->request->post['webmoney_wme'])) {
  $data['webmoney_wme'] = $this->request->post['webmoney_wme'];
} elseif (!empty($affiliate_info)) { 
  $data['webmoney_wme'] = $affiliate_info['webmoney_wme'];
} else {
  $data['webmoney_wme'] = '';
}

if (isset($this->request->post['webmoney_wmy'])) {
  $data['webmoney_wmy'] = $this->request->post['webmoney_wmy'];
} elseif (!empty($affiliate_info)) { 
  $data['webmoney_wmy'] = $affiliate_info['webmoney_wmy'];
} else {
  $data['webmoney_wmy'] = '';
}

if (isset($this->request->post['webmoney_wmb'])) {
  $data['webmoney_wmb'] = $this->request->post['webmoney_wmb'];
} elseif (!empty($affiliate_info)) { 
  $data['webmoney_wmb'] = $affiliate_info['webmoney_wmb'];
} else {
  $data['webmoney_wmb'] = '';
}

if (isset($this->request->post['webmoney_wmg'])) {
  $data['webmoney_wmg'] = $this->request->post['webmoney_wmg'];
} elseif (!empty($affiliate_info)) { 
  $data['webmoney_wmg'] = $affiliate_info['webmoney_wmg'];
} else {
  $data['webmoney_wmg'] = '';
}

if (isset($this->request->post['alert_pay'])) {
  $data['alert_pay'] = $this->request->post['alert_pay'];
} elseif (!empty($affiliate_info)) { 
  $data['alert_pay'] = $affiliate_info['alert_pay'];
} else {
  $data['alert_pay'] = '';
}

if (isset($this->request->post['moneybookers'])) {
  $data['moneybookers'] = $this->request->post['moneybookers'];
} elseif (!empty($affiliate_info)) { 
  $data['moneybookers'] = $affiliate_info['moneybookers'];
} else {
  $data['moneybookers'] = '';
}

if (isset($this->request->post['liqpay'])) {
  $data['liqpay'] = $this->request->post['liqpay'];
} elseif (!empty($affiliate_info)) { 
  $data['liqpay'] = $affiliate_info['liqpay'];
} else {
  $data['liqpay'] = '';
}

if (isset($this->request->post['sage_pay'])) {
  $data['sage_pay'] = $this->request->post['sage_pay'];
} elseif (!empty($affiliate_info)) { 
  $data['sage_pay'] = $affiliate_info['sage_pay'];
} else {
  $data['sage_pay'] = '';
}

if (isset($this->request->post['two_checkout'])) {
  $data['two_checkout'] = $this->request->post['two_checkout'];
} elseif (!empty($affiliate_info)) { 
  $data['two_checkout'] = $affiliate_info['two_checkout'];
} else {
  $data['two_checkout'] = '';
}

if (isset($this->request->post['google_wallet'])) {
  $data['google_wallet'] = $this->request->post['google_wallet'];
} elseif (!empty($affiliate_info)) { 
  $data['google_wallet'] = $affiliate_info['google_wallet'];
} else {
  $data['google_wallet'] = '';
}
      
		if (isset($this->request->post['cheque'])) {
			$data['cheque'] = $this->request->post['cheque'];
		} elseif (!empty($affiliate_info)) {
			$data['cheque'] = $affiliate_info['cheque'];
		} else {
			$data['cheque'] = '';
		}

		if (isset($this->request->post['paypal'])) {
			$data['paypal'] = $this->request->post['paypal'];
		} elseif (!empty($affiliate_info)) {
			$data['paypal'] = $affiliate_info['paypal'];
		} else {
			$data['paypal'] = '';
		}

		if (isset($this->request->post['bank_name'])) {
			$data['bank_name'] = $this->request->post['bank_name'];
		} elseif (!empty($affiliate_info)) {
			$data['bank_name'] = $affiliate_info['bank_name'];
		} else {
			$data['bank_name'] = '';
		}

		if (isset($this->request->post['bank_branch_number'])) {
			$data['bank_branch_number'] = $this->request->post['bank_branch_number'];
		} elseif (!empty($affiliate_info)) {
			$data['bank_branch_number'] = $affiliate_info['bank_branch_number'];
		} else {
			$data['bank_branch_number'] = '';
		}

		if (isset($this->request->post['bank_swift_code'])) {
			$data['bank_swift_code'] = $this->request->post['bank_swift_code'];
		} elseif (!empty($affiliate_info)) {
			$data['bank_swift_code'] = $affiliate_info['bank_swift_code'];
		} else {
			$data['bank_swift_code'] = '';
		}

		if (isset($this->request->post['bank_account_name'])) {
			$data['bank_account_name'] = $this->request->post['bank_account_name'];
		} elseif (!empty($affiliate_info)) {
			$data['bank_account_name'] = $affiliate_info['bank_account_name'];
		} else {
			$data['bank_account_name'] = '';
		}

		if (isset($this->request->post['bank_account_number'])) {
			$data['bank_account_number'] = $this->request->post['bank_account_number'];
		} elseif (!empty($affiliate_info)) {
			$data['bank_account_number'] = $affiliate_info['bank_account_number'];
		} else {
			$data['bank_account_number'] = '';
		}

		$data['back'] = $this->url->link('affiliate/account', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('affiliate/payment', $data));
	}
}
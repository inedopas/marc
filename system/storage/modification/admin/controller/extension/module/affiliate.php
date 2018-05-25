<?php
class ControllerExtensionModuleAffiliate extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/affiliate');


$this->load->model('localisation/order_status');
$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
$this->load->model('module/affiliate');
$data['elements'] = $this->model_module_affiliate->getInfoModule();
if ($this->request->server['REQUEST_METHOD'] != 'POST') {
  $this->model_module_affiliate->createAffiliate();
}
$data['entry_add'] = $this->language->get('entry_add');
$data['entry_category_visible'] = $this->language->get('entry_category_visible');
$data['entry_total'] = $this->language->get('entry_total');
$data['entry_days'] = $this->language->get('entry_days');
$data['entry_order_status'] = $this->language->get('entry_order_status');
$data['entry_payment'] = $this->language->get('entry_payment');
$data['is_affiliate_dopfun'] = $this->model_module_affiliate->getExists('is_affiliate_dopfun');
$data['mod_affiliate_dopfun'] = $this->language->get('mod_affiliate_dopfun');
$data['is_affiliate_trackingproduct'] = $this->model_module_affiliate->getExists('is_affiliate_trackingproduct');
$data['mod_affiliate_trackingproduct'] = $this->language->get('mod_affiliate_trackingproduct');

$data['text_bonus'] = $this->language->get('text_bonus');
$data['text_cheque'] = $this->language->get('text_cheque');
$data['text_paypal'] = $this->language->get('text_paypal');
$data['text_bank'] = $this->language->get('text_bank');
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
  
$data['affiliate_bonus'] = (bool)$this->config->get('affiliate_bonus');
$data['affiliate_category_visible'] = (bool)$this->config->get('affiliate_category_visible');

if((int)$this->config->get('affiliate_order_status_id')!=0){
  $data['affiliate_order_status_id'] = (int)$this->config->get('affiliate_order_status_id');
  $data['affiliate_cheque'] = (bool)$this->config->get('affiliate_cheque');
  $data['affiliate_paypal'] = (bool)$this->config->get('affiliate_paypal');
  $data['affiliate_bank'] = (bool)$this->config->get('affiliate_bank');
  $data['affiliate_days'] = (int)$this->config->get('affiliate_days');
  $data['affiliate_total'] = (float)$this->config->get('affiliate_total');
}
else{
  $data['affiliate_order_status_id'] = (int)$this->config->get('config_complete_status_id');
  $data['affiliate_cheque'] = true;
  $data['affiliate_paypal'] = true;
  $data['affiliate_bank'] = true;
  $data['affiliate_days'] = 7;
  $data['affiliate_total'] = 100;
}
$data['entry_affiliate_sumbol'] = $this->language->get('entry_affiliate_sumbol');
$data['affiliate_sumbol'] = $this->config->get('affiliate_sumbol');
if (!$this->config->get('affiliate_sumbol')) {
  $data['affiliate_sumbol'] = '1';
}
$data['affiliate_add'] = (bool)$this->config->get('affiliate_add');
$data['affiliate_number_tracking'] = (bool)$this->config->get('affiliate_number_tracking');
$data['entry_number_tracking'] = $this->language->get('entry_number_tracking');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('affiliate', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/affiliate', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('extension/module/affiliate', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['affiliate_status'])) {
			$data['affiliate_status'] = $this->request->post['affiliate_status'];
		} else {
			$data['affiliate_status'] = $this->config->get('affiliate_status');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/affiliate', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/affiliate')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
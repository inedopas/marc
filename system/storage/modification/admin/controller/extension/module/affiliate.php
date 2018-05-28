<?php
class ControllerExtensionModuleAffiliate extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('extension/module/affiliate');

		$this->document->setTitle($this->language->get('heading_title'));

      $this->load->model('module/affiliatemmm');
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
          $this->model_module_affiliatemmm->createAffiliate();
        }
      if(isset($this->request->post['affiliate_level_commission'])){
        $count = 1;
        foreach ($this->request->post['affiliate_level_commission'] as $key => $value) {
          $value['level_id'] = $count;
          $this->request->post['affiliate_level_commission'][$key]['level_id'] = '' . $count;
          $count++;
        }
      }
      

        $data['levels'] = array();
        if (isset($this->request->post['affiliate_level_commission'])) {
          $data['levels'] = $this->request->post['affiliate_level_commission'];
        } elseif ($this->config->get('affiliate_level_commission')) {
          $data['levels'] = $this->config->get('affiliate_level_commission');
        }
        $data['entry_affiliate_level'] = $this->language->get('entry_affiliate_level');
        $this->load->model('module/affiliatemmm');
        $data['entry_affiliate_commission'] = sprintf($this->language->get('entry_affiliate_commission'), $this->model_module_affiliatemmm->getAffiliateAllCommission(), '%');
        $data['entry_affiliate_count'] = $this->language->get('entry_affiliate_count');
        $data['button_add_level'] = $this->language->get('button_add_level');
        $data['entry_customer_lifetime'] = $this->language->get('entry_customer_lifetime');
        $data['entry_product_commission'] = $this->language->get('entry_product_commission');
        $data['affiliate_customer_lifetime'] = $this->config->get('affiliate_customer_lifetime');
        $data['affiliate_product_commission'] = $this->config->get('affiliate_product_commission');
      

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
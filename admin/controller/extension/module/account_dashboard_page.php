<?php
class ControllerExtensionModuleAccountdashboardpage extends Controller {
	private $error = array();

	public function install(){
		 
	}

	public function index() {
		$this->load->language('extension/module/account_dashboard_page');
		$this->document->setTitle( strip_tags($this->language->get('heading_title')));

		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('account_dashboard_page', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			/*$this->response->redirect($this->url->link('extension/module/account_dashboard_page', 'token=' . $this->session->data['token'], 'SSL'));*/
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] =  strip_tags($this->language->get('heading_title'));
		$data['text_success_install'] = $this->language->get('text_success_install');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['text_new_tab'] = $this->language->get('text_new_tab');
		$data['text_id_text'] = $this->language->get('text_id_text');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/module/account_dashboard_page', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('extension/module/account_dashboard_page', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['account_dashboard_page_status'])) {
			$data['account_dashboard_page_status'] = $this->request->post['account_dashboard_page_status'];
		} else {
			$data['account_dashboard_page_status'] = $this->config->get('account_dashboard_page_status');
		}



		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/account_dashboard_page.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/account_dashboard_page')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}
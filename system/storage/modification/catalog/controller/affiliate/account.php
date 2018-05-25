<?php
class ControllerAffiliateAccount extends Controller {
	public function index() {
		if (!$this->affiliate->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('affiliate/account', '', true);

			$this->response->redirect($this->url->link('affiliate/login', '', true));
		}

		$this->load->language('affiliate/account');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('affiliate/account', '', true)
		);

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_my_account'] = $this->language->get('text_my_account');
		$data['text_my_tracking'] = $this->language->get('text_my_tracking');
		$data['text_my_transactions'] = $this->language->get('text_my_transactions');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_payment'] = $this->language->get('text_payment');
		$data['text_tracking'] = $this->language->get('text_tracking');
		$data['text_transaction'] = $this->language->get('text_transaction');

        $data['text_my_orderpayment'] = $this->language->get('text_my_orderpayment');
		$data['text_my_statistics'] = $this->language->get('text_my_statistics');
		$data['text_orderpayment'] = $this->language->get('text_orderpayment');
		$data['text_statistics'] = $this->language->get('text_statistics');     
		$data['orderpayment'] = $this->url->link('affiliate/orderpayment', '', 'SSL');
		$data['statistics'] = $this->url->link('affiliate/statistics', '', 'SSL');
        $this->load->model('affiliate/affiliate');
        $affiliateinfo = $this->model_affiliate_affiliate->getAffiliate($this->affiliate->getId());
        $this->load->model('affiliate/transaction');
        $balance = $this->model_affiliate_transaction->getBalance();
        $data['balance'] = sprintf($this->language->get('text_balance'), $this->currency->format($balance, $this->session->data['currency']));
        $data['percentage'] = sprintf($this->language->get('text_percentage'), $affiliateinfo['commission'], '%');
        $data['name_affiliate'] = sprintf($this->language->get('text_name_affiliate'), $affiliateinfo['firstname'] , $affiliateinfo['lastname']);
      

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['edit'] = $this->url->link('affiliate/edit', '', true);
		$data['password'] = $this->url->link('affiliate/password', '', true);
		$data['payment'] = $this->url->link('affiliate/payment', '', true);
		$data['tracking'] = $this->url->link('affiliate/tracking', '', true);
		$data['transaction'] = $this->url->link('affiliate/transaction', '', true);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('affiliate/account', $data));
	}
}
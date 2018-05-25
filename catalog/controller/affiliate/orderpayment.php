<?php
class ControllerAffiliateOrderpayment extends Controller {
    private $error = array();

    public function index() {
        
        if (!$this->affiliate->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('affiliate/orderpayment', '', 'SSL');

            $this->response->redirect($this->url->link('affiliate/login', '', 'SSL'));
        }

        $this->language->load('affiliate/orderpayment');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('module/affiliate');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            
            $this->model_module_affiliate->editOrderPayment($this->request->post);
            $my_request_payment = (double)$this->model_module_affiliate->ConvertLocalCurrency((double)$this->request->post['request_payment']);
        
            $this->session->data['success'] = sprintf($this->language->get('text_success'), $this->currency->format($my_request_payment, $this->session->data['currency']));

            $this->response->redirect($this->url->link('affiliate/account', '', 'SSL'));
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_account'),
            'href' => $this->url->link('affiliate/account', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_payment'),
            'href' => $this->url->link('affiliate/orderpayment', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_request_payment_history'] = $this->language->get('text_request_payment_history');

        $data['entry_request_payment'] = $this->language->get('entry_request_payment');
        $data['entry_payment'] = $this->language->get('entry_payment');
        
        $this->load->model('module/affiliate');
        $data['title_request_payment'] = sprintf($this->language->get('title_request_payment'),$this->currency->format($this->config->get('affiliate_total'), $this->session->data['currency']));

        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_back'] = $this->language->get('button_back');

        $data['action'] = $this->url->link('affiliate/orderpayment', '', 'SSL');
        $data['text_request_balanse'] = $this->language->get('text_request_balanse');
        $this->load->model('affiliate/transaction');
        $data['balance'] = $this->currency->format($this->model_affiliate_transaction->getBalance(), $this->session->data['currency']);
		$data['max_balance_double'] = (double)$this->model_affiliate_transaction->getBalance();
		$data['min_balance_double'] = (double)$this->config->get('affiliate_total');
        $data['min_balance'] = $this->currency->format($this->config->get('affiliate_total'), $this->session->data['currency']);
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $this->load->model('affiliate/affiliate');
            $affiliate_info = $this->model_affiliate_affiliate->getAffiliate($this->affiliate->getId());
        }
        if (isset($this->request->post['request_payment_history'])) {
            $data['request_payment_history'] = $this->request->post['request_payment_history'];
        } elseif (!empty($affiliate_info)) {
            $data['request_payment_history'] = $this->currency->format($affiliate_info['request_payment'], $this->session->data['currency']);
        } else {
            
        $this->load->model('affiliate/affiliate');
        $affiliate_info_error = $this->model_affiliate_affiliate->getAffiliate($this->affiliate->getId());
            $data['request_payment_history'] = $this->currency->format($affiliate_info_error['request_payment'], $this->session->data['currency']);
        }

        if (isset($this->request->post['request_payment'])) {
            $data['request_payment'] = $this->request->post['request_payment'];
        } elseif (!empty($affiliate_info)) {
            $data['request_payment'] = $affiliate_info['request_payment'];
        } else {
            $data['request_payment'] = '0.00';
        }
        if (isset($this->error['balance_max'])) {
            $data['error_max'] = $this->error['balance_max'];
        } else {
            $data['error_max'] = '';
        }
        if (isset($this->error['balance_nil'])) {
            $data['error_nil'] = $this->error['balance_nil'];
        } else {
            $data['error_nil'] = '';
        }

        if (isset($this->error['balance_min'])) {
            $data['error_min'] = sprintf($this->error['balance_min'],$this->currency->format($this->config->get('affiliate_total'), $this->session->data['currency']));
        } else {
            $data['error_min'] = '';
        }
        
        $data['back'] = $this->url->link('affiliate/account', '', 'SSL');


		$data['continue'] = $this->url->link('affiliate/account', '', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('affiliate/orderpayment', $data));
    }
    private function validate() {
        
        $this->load->model('affiliate/transaction');
        $balance = (double)$this->model_affiliate_transaction->getBalance();
        $min_balance = (double)$this->config->get('affiliate_total');
        $request_payment = (double)$this->model_module_affiliate->ConvertLocalCurrency((double)$this->request->post['request_payment']);
        
         
         
        if ($balance < $min_balance) {
            $this->error['balance_nil'] = $this->language->get('error_nil');
        } else {
            
            if ($request_payment < $min_balance) {
                $this->error['balance_min'] = $this->language->get('error_min');
            }
            if (($request_payment > $min_balance) && ($request_payment > $balance )) {
                $this->error['balance_max'] = $this->language->get('error_max');
            }
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
?>
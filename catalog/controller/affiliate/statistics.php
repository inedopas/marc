<?php

class ControllerAffiliateStatistics extends Controller {

    public function index() {
        if (!$this->affiliate->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('affiliate/statistics', '', 'SSL');
            $this->response->redirect($this->url->link('affiliate/login', '', 'SSL'));
        }

        $this->language->load('affiliate/statistics');

        $this->document->setTitle($this->language->get('heading_title'));

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
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
            'text' => $this->language->get('text_statistics'),
            'href' => $this->url->link('affiliate/statistics', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        if (isset($this->request->get['filter_date_start'])) {
            $filter_date_start = $this->request->get['filter_date_start'];
        } else {
            $filter_date_start = '';
        }

        if (isset($this->request->get['filter_date_end'])) {
            $filter_date_end = $this->request->get['filter_date_end'];
        } else {
            $filter_date_end = '';
        }

        $url = '';

        if (isset($this->request->get['filter_date_start'])) {
            $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
        }

        if (isset($this->request->get['filter_date_end'])) {
            $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
        }

        $filter_data = array(
            'filter_date_start' => $filter_date_start,
            'filter_date_end' => $filter_date_end
        );

        $data['entry_date_start'] = $this->language->get('entry_date_start');
        $data['entry_date_end'] = $this->language->get('entry_date_end');

        $data['button_filter'] = $this->language->get('button_filter');
        $data['button_clear'] = $this->language->get('button_clear');
        $url = '';

        if (isset($this->request->get['filter_date_start'])) {
            $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
        }

        if (isset($this->request->get['filter_date_end'])) {
            $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
        }


        $data['filter_date_start'] = $filter_date_start;
        $data['filter_date_end'] = $filter_date_end;

        $data['heading_title'] = $this->language->get('heading_title');

        $data['entry_statistics'] = $this->language->get('entry_statistics');
        $data['column_count_transitions'] = $this->language->get('column_count_transitions');
        $data['column_count_orders'] = $this->language->get('column_count_orders');
        $data['column_count_shopping'] = $this->language->get('column_count_shopping');
        $data['column_sum_orders'] = $this->language->get('column_sum_orders');
        $data['column_sum_shopping'] = $this->language->get('column_sum_shopping');
        $data['column_sum_credited'] = $this->language->get('column_sum_credited');
        $data['column_sum_paid'] = $this->language->get('column_sum_paid');
        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_back'] = $this->language->get('button_back');

        $data['action'] = $this->url->link('affiliate/statistics', '', 'SSL');
        $affiliates[] = array();
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $this->load->model('module/statistics');
            $transitions = $this->model_module_statistics->GetStatistics($this->affiliate->getId(), $filter_data);
            $Orders = $this->model_module_statistics->GetStatisticsOrders($this->affiliate->getId(), $filter_data);
            $Shopping = $this->model_module_statistics->GetStatisticsShopping($this->affiliate->getId(), $filter_data);
            $Sum = $this->model_module_statistics->GetStatisticsSum($this->affiliate->getId(), $filter_data);
        }
        
        $affiliates = $transitions + $Orders + $Shopping + $Sum;

        foreach ($affiliates as $key => $value) {
            if (empty($affiliates[$key])) {
                $affiliates[$key] = 0.00;
            }
        }
        
        $affiliates['count_transitions'] = (int) $affiliates['count_transitions'];
        $affiliates['count_orders'] = (int) $affiliates['count_orders'];
        $affiliates['count_shopping'] = (int) $affiliates['count_shopping'];
        $affiliates['commission'] = $this->currency->format($affiliates['commission'], $this->session->data['currency']);
        $affiliates['paid'] = $this->currency->format((-1) * $affiliates['paid'], $this->session->data['currency']);
        $affiliates['sum_orders'] = $this->currency->format($affiliates['sum_orders'], $this->session->data['currency']);
        $affiliates['sum_shopping'] = $this->currency->format($affiliates['sum_shopping'], $this->session->data['currency']);

        $data['affiliates'] = $affiliates;
        $data['back'] = $this->url->link('affiliate/account', '', 'SSL');


		$data['continue'] = $this->url->link('affiliate/account', '', 'SSL');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('affiliate/statistics', $data));
    }

}

?>
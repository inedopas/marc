<?php
class ControllerReportAffiliateStatisticsall extends Controller {
	public function index() {
		$this->load->language('report/affiliate_statistics_all');

		$this->document->setTitle($this->language->get('heading_title'));

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('report/affiliate_statistics_all', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'text' => $this->language->get('heading_title')
		);

		$this->load->model('report/affiliate_statistics');

		$data['activities'] = array();

		$filter_data = array(
			'filter_date_start'	=> $filter_date_start,
			'filter_date_end'	=> $filter_date_end,
			'start'             => 0,
			'limit'             => 20
		);

		$resultCount = $this->model_report_affiliate_statistics->getAffiliatesCount($filter_data);
        $resultOrders = $this->model_report_affiliate_statistics->getAffiliatesOrders($filter_data);
        $resultShopping = $this->model_report_affiliate_statistics->getAffiliatesShopping($filter_data);
        $resultSum = $this->model_report_affiliate_statistics->getAffiliatesSum($filter_data);
        
        $result = array();
        $result=$resultCount+$resultOrders+$resultShopping+$resultSum;
        
        $data['affiliates'][] = array(
            'count_transitions' => (int)$result['transitions'],
            'count_orders' => (int)$result['orders'],
            'count_shopping' => (int)$result['shopping'],
            'sum_orders' => $this->currency->format($result['total'], $this->config->get('config_currency')),
            'sum_shopping' => $this->currency->format($result['totals'], $this->config->get('config_currency')),
            'sum_credited' => $this->currency->format($result['commission'], $this->config->get('config_currency')),
            'sum_paid' => $this->currency->format((-1) * $result['paid'], $this->config->get('config_currency')),
        );

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['column_count_transitions'] = $this->language->get('column_count_transitions');
        $data['column_count_orders'] = $this->language->get('column_count_orders');
        $data['column_count_shopping'] = $this->language->get('column_count_shopping');
        $data['column_sum_orders'] = $this->language->get('column_sum_orders');
        $data['column_sum_shopping'] = $this->language->get('column_sum_shopping');
        $data['column_sum_credited'] = $this->language->get('column_sum_credited');
        $data['column_sum_paid'] = $this->language->get('column_sum_paid');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		
		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');

		$data['button_filter'] = $this->language->get('button_filter');

		$data['token'] = $this->session->data['token'];

		$url = '';

		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}

		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		
		$data['filter_date_start'] = $filter_date_start;
		$data['filter_date_end'] = $filter_date_end;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('report/affiliate_statistics_all.tpl', $data));
	}
}
<?php
class ControllerReportAffiliateStatistics extends Controller {
	public function index() {
		$this->load->language('report/affiliate_statistics');

		$this->document->setTitle($this->language->get('heading_title'));

		if (isset($this->request->get['filter_affiliate'])) {
			$filter_affiliate = $this->request->get['filter_affiliate'];
		} else {
			$filter_affiliate = null;
		}

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

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_affiliate'])) {
			$url .= '&filter_affiliate=' . urlencode($this->request->get['filter_affiliate']);
		}

		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}

		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('report/affiliate_statistics', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'text' => $this->language->get('heading_title')
		);

		$this->load->model('report/affiliate_statistics');

		$data['affiliates'] = array();

		$filter_data = array(
			'filter_affiliate'   => $filter_affiliate,
			'filter_date_start'	=> $filter_date_start,
			'filter_date_end'	=> $filter_date_end,
			'start'             => ($page - 1) * 20,
			'limit'             => 20
		);

        $activity_total = $this->model_report_affiliate_statistics->getTotalCommission($filter_data);

        $results = $this->model_report_affiliate_statistics->getAffiliatesName($filter_data);

        foreach ($results as $result) {
            $resultCount = $this->model_report_affiliate_statistics->getAffiliatesCount($filter_data, $result['affiliate_id']);
            $resultOrders = $this->model_report_affiliate_statistics->getAffiliatesOrders($filter_data, $result['affiliate_id']);
            $resultShopping = $this->model_report_affiliate_statistics->getAffiliatesShopping($filter_data, $result['affiliate_id']);
            $resultSum = $this->model_report_affiliate_statistics->getAffiliatesSum($filter_data, $result['affiliate_id']);

            $result = $result + $resultCount + $resultOrders + $resultShopping + $resultSum;
            
            $data['affiliates'][] = array(
                'affiliate' => $result['affiliate'],
                'email' => $result['email'],
                'count_transitions' => (int)$result['transitions'],
                'count_orders' => (int)$result['orders'],
                'count_shopping' => (int)$result['shopping'],
                'sum_orders' => $this->currency->format($result['total'], $this->config->get('config_currency')),
                'sum_shopping' => $this->currency->format($result['totals'], $this->config->get('config_currency')),
                'sum_credited' => $this->currency->format($result['commission'], $this->config->get('config_currency')),
                'sum_paid' => $this->currency->format((-1) * $result['paid'], $this->config->get('config_currency')),
            );
        }

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

        $data['column_affiliate'] = $this->language->get('column_affiliate');
        $data['column_email'] = $this->language->get('column_email');
        $data['column_count_transitions'] = $this->language->get('column_count_transitions');
        $data['column_count_orders'] = $this->language->get('column_count_orders');
        $data['column_count_shopping'] = $this->language->get('column_count_shopping');
        $data['column_sum_orders'] = $this->language->get('column_sum_orders');
        $data['column_sum_shopping'] = $this->language->get('column_sum_shopping');
        $data['column_sum_credited'] = $this->language->get('column_sum_credited');
        $data['column_sum_paid'] = $this->language->get('column_sum_paid');
		
		$data['entry_affiliate'] = $this->language->get('entry_affiliate');
		$data['entry_date_start'] = $this->language->get('entry_date_start');
		$data['entry_date_end'] = $this->language->get('entry_date_end');

		$data['button_filter'] = $this->language->get('button_filter');

		$data['token'] = $this->session->data['token'];

		$url = '';

		if (isset($this->request->get['filter_affiliate'])) {
			$url .= '&filter_affiliate=' . urlencode($this->request->get['filter_affiliate']);
		}

		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}

		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}

		$pagination = new Pagination();
		$pagination->total = $activity_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('report/affiliate_statistics', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($activity_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($activity_total - $this->config->get('config_limit_admin'))) ? $activity_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $activity_total, ceil($activity_total / $this->config->get('config_limit_admin')));

		$data['filter_affiliate'] = $filter_affiliate;
		$data['filter_date_start'] = $filter_date_start;
		$data['filter_date_end'] = $filter_date_end;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('report/affiliate_statistics.tpl', $data));
	}
}
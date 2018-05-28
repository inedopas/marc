<?php
class ControllerAffiliateStatisticsmyaffiliate extends Controller {

    public function index() {
        if (!$this->affiliate->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('affiliate/statisticsmyaffiliate', '', 'SSL');
            $this->response->redirect($this->url->link('affiliate/login', '', 'SSL'));
        }
		
        $this->language->load('affiliate/statisticsmyaffiliate');

        $this->document->setTitle($this->language->get('heading_title'));

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $this->response->redirect($this->url->link('affiliate/account', '', 'SSL'));
        }
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('affiliate/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('affiliate/tracking', '', 'SSL')
		);
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
            'href' => $this->url->link('affiliate/statisticsmyaffiliate', '', 'SSL'),
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
        $data['column_name'] = $this->language->get('column_name');
        $data['column_level'] = $this->language->get('column_level');
        $data['column_count_shopping'] = $this->language->get('column_count_shopping');
        $data['column_sum_orders'] = $this->language->get('column_sum_orders');
        $data['column_sum_shopping'] = $this->language->get('column_sum_shopping');
        $data['column_sum_credited'] = $this->language->get('column_sum_credited');
        $data['column_sum_paid'] = $this->language->get('column_sum_paid');
        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_back'] = $this->language->get('button_back');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['action'] = $this->url->link('affiliate/statisticsmyaffiliate', '', 'SSL');
		
		$this->load->model('module/statisticsmyaffiliate');
		$getlevel = $this->config->get('affiliate_level_commission');
    $levelcount = count($getlevel);
		$implode = array();
		$implode[] = "parent = '" . $this->affiliate->getId() . "'";
    // if (!(isset($this->session->data['children_level']))) { 
      $training = $this->model_module_statisticsmyaffiliate->getAffiliatesChildren($implode, $levelcount);
      if(strlen($training)) {
        $results = $this->model_module_statisticsmyaffiliate->getChildrenLevel($training, $levelcount);
        foreach ($results as $result) {
          $affiliate_name  = $this->model_module_statisticsmyaffiliate->getAffiliatesName($result['affiliate_id']);
          $resultOrders = $this->model_module_statisticsmyaffiliate->GetStatisticsOrders($result['affiliate_id'], $filter_data);
          $resultShopping =  $this->model_module_statisticsmyaffiliate->GetStatisticsShopping($result['affiliate_id'], $filter_data);
          $resultSum = $this->model_module_statisticsmyaffiliate->GetStatisticsSum($this->affiliate->getId(), $result['affiliate_id'], $filter_data);
          $data['affiliates'][] = array(
            'level' =>  $result['level'],
            'affiliate' =>  $affiliate_name,
            'count_orders' => (int)$resultOrders['count_orders'],
            'count_shopping' => (int)$resultShopping['count_shopping'],
            'sum_orders' => $this->currency->format($resultOrders['sum_orders'], $this->session->data['currency']),
            'sum_shopping' => $this->currency->format($resultShopping['sum_shopping'], $this->session->data['currency']),
            'commission' => $this->currency->format($resultSum['commission'], $this->session->data['currency'])
          );
        }
    //    $this->session->data['children_level'] = $affiliates;
      }
    //} else {
    ////  $affiliates = $this->session->data['children_level'];
    // }
		
    $data['back'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['continue'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('affiliate/statisticsmyaffiliate', $data));
    }

}
?>
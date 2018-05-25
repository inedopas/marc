<?php
class ControllerModuleOcextSmartSearch extends Controller {
	private $error = array();
        private $this_version = '2.9.0.0';
        private $this_extension = 'ocext_smart_search';
        private $this_ocext_host = 'oc2101.ocext';

        public function index() {   
		$this->load->language('module/ocext_smart_search');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
                        if(isset($this->request->get['set_index'])){
                            
                            $this->load->model('module/ocext_smart_search');
                            $index = $this->model_module_ocext_smart_search->setIndexSmartSearch();
                            if($index){
                                $this->session->data['success'] = $this->language->get('text_success_index');
                            }else{
                                $this->session->data['error'] = $this->language->get('text_error_index');
                            }
                            $this->response->redirect($this->url->link('module/ocext_smart_search', 'token=' . $this->session->data['token'], 'SSL'));
                        }
			$this->model_setting_setting->editSetting('ocext_smart_search', $this->request->post);
                        $this->model_setting_setting->editSetting('ocext_ajax', $this->request->post);
                        
			$this->session->data['success'] = $this->language->get('text_success');
                        $this->response->redirect($this->url->link('module/ocext_smart_search', 'token=' . $this->session->data['token'], 'SSL'));
		}
                
                //$this->load->model('module/ocext_smart_search');
                //$index = $this->model_module_ocext_smart_search->setIndexSmartSearch();
                //$this->model_module_ocext_smart_search->getIndexDataDebug(35);
                
                $data['open_tab'] = 'tab-setting';
                if (isset($this->request->get['page'])) {
                        $data['open_tab'] = 'tab-statistic';
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
                if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
                if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
                }elseif(isset ($this->session->data['error'])){
                        $data['error_warning'] = $this->session->data['error'];
                        unset($this->session->data['error']);
                } else {
			$data['error_warning'] = '';
		}
                
                $data['text_title_index_setting'] = $this->language->get('text_title_index_setting');
                $data['text_smart_search_attribute'] = $this->language->get('text_smart_search_attribute');
                $data['text_smart_search_option'] = $this->language->get('text_smart_search_option');
                $data['text_smart_search_category'] = $this->language->get('text_smart_search_category');
                $data['text_smart_search_manufacturer'] = $this->language->get('text_smart_search_manufacturer');
                $data['text_smart_search_review'] = $this->language->get('text_smart_search_review');
                $data['text_smart_search_min_symbols'] = $this->language->get('text_smart_search_min_symbols');
                $data['text_index_stat_total_index_keywords'] = $this->language->get('text_index_stat_total_index_keywords');
                $data['text_index_start'] = $this->language->get('text_index_start');
                $data['text_smart_search_status_general'] = $this->language->get('text_smart_search_status_general');
                $data['text_smart_search_status'] = $this->language->get('text_smart_search_status');
                $data['text_smart_search_finished'] = $this->language->get('text_smart_search_finished');
                $data['text_smart_search_strict_master_function'] = $this->language->get('text_smart_search_strict_master_function');
                $data['text_smart_search_wite'] = $this->language->get('text_smart_search_wite');
                $data['text_smart_search_limit'] = $this->language->get('text_smart_search_limit');
                $data['text_smart_search_strict_master_function_500'] = $this->language->get('text_smart_search_strict_master_function_500');
                $data['text_smart_search_strict_master_function_1000'] = $this->language->get('text_smart_search_strict_master_function_1000');
                $data['text_smart_search_strict_master_function_1500'] = $this->language->get('text_smart_search_strict_master_function_1500');
                $data['text_smart_search_strict_master_function_2000'] = $this->language->get('text_smart_search_strict_master_function_2000');
                $data['text_ocext_smart_search_count_relevant_result'] = $this->language->get('text_ocext_smart_search_count_relevant_result');
                $data['text_ocext_smart_search_index_level_0'] = $this->language->get('text_ocext_smart_search_index_level_0');
                $data['text_ocext_smart_search_index_level_1'] = $this->language->get('text_ocext_smart_search_index_level_1');
                $data['text_ocext_smart_search_index_level'] = $this->language->get('text_ocext_smart_search_index_level');
                
                
                $data['column_id'] = $this->language->get('column_id');
                $data['column_keyword'] = $this->language->get('column_keyword');
                $data['column_used'] = $this->language->get('column_used');
                $data['column_index_elements'] = $this->language->get('column_index_elements');
                $data['column_date_added'] = $this->language->get('column_date_added');
                $data['text_no_results'] = $this->language->get('text_no_results');
                
                
                $data['text_ocext_smart_search_disable_prod'] = $this->language->get('text_ocext_smart_search_disable_prod');
                
                $data['ocext_smart_search_disable_prod'] = 0;
                if($this->config->get('ocext_smart_search_disable_prod')){
                    $data['ocext_smart_search_disable_prod'] = $this->config->get('ocext_smart_search_disable_prod');
                }
                $data['text_ocext_smart_search_null_price'] = $this->language->get('text_ocext_smart_search_null_price');
                
                $data['ocext_smart_search_null_price'] = 0;
                if($this->config->get('ocext_smart_search_null_price')){
                    $data['ocext_smart_search_null_price'] = $this->config->get('ocext_smart_search_null_price');
                }
                
                $data['ocext_smart_search_relevant_result'] = 50;
                if($this->config->get('ocext_smart_search_relevant_result')){
                    $data['ocext_smart_search_relevant_result'] = $this->config->get('ocext_smart_search_relevant_result');
                }
                
                $data['ocext_smart_search_index_level'] = 0;
                if($this->config->get('ocext_smart_search_index_level')){
                    $data['ocext_smart_search_index_level'] = $this->config->get('ocext_smart_search_index_level');
                }
                
                
                
                $data['ocext_ajax_status'] = 0;
                if($this->config->get('ocext_ajax_status')){
                    $data['ocext_ajax_status'] = $this->config->get('ocext_ajax_status');
                }
                
                $data['text_ocext_ajax_status'] = $this->language->get('text_ocext_ajax_status');
                
                $data['ocext_ajax_status'] = 0;
                if($this->config->get('ocext_ajax_status')){
                    $data['ocext_ajax_status'] = $this->config->get('ocext_ajax_status');
                }
                
                $data['text_ocext_ajax_products'] = $this->language->get('text_ocext_ajax_products');
                
                $data['ocext_ajax_products'] = 5;
                if($this->config->get('ocext_ajax_products')){
                    $data['ocext_ajax_products'] = $this->config->get('ocext_ajax_products');
                }
                
                $data['text_ocext_ajax_products_price'] = $this->language->get('text_ocext_ajax_products_price');
                if($this->config->get('ocext_ajax_products_price')){
                    $data['ocext_ajax_products_price'] = 1;
                }else{
                    $data['ocext_ajax_products_price'] = 0;
                }
                
                
                $data['text_ocext_ajax_products_image'] = $this->language->get('text_ocext_ajax_products_image');
                
                 if($this->config->get('ocext_ajax_products_image')){
                    $data['ocext_ajax_products_image'] = 1;
                }else{
                    $data['ocext_ajax_products_image'] = 0;
                }
                
                $data['text_ocext_ajax_products_category'] = $this->language->get('text_ocext_ajax_products_category');
                
                 if($this->config->get('ocext_ajax_products_category')){
                    $data['ocext_ajax_products_category'] = 1;
                }else{
                    $data['ocext_ajax_products_category'] = 0;
                }
                
                $data['text_ocext_ajax_category'] = $this->language->get('text_ocext_ajax_category');
                
                $data['ocext_ajax_category'] = 5;
                if($this->config->get('ocext_ajax_category')){
                    $data['ocext_ajax_category'] = $this->config->get('ocext_ajax_category');
                }
                
                
                
                
                $data['text_ocext_ajax_text_calculate_products_manufacturer'] = $this->language->get('text_ocext_ajax_text_calculate_products_manufacturer');
                
                $data['ocext_ajax_cal_prod_manuf'] = 0;
                if($this->config->get('ocext_ajax_cal_prod_manuf')){
                    $data['ocext_ajax_cal_prod_manuf'] = $this->config->get('ocext_ajax_cal_prod_manuf');
                }
                
                $data['text_ocext_ajax_text_calculate_products_categories'] = $this->language->get('text_ocext_ajax_text_calculate_products_categories');
                
                $data['ocext_ajax_cal_prod_cat'] = 0;
                if($this->config->get('ocext_ajax_cal_prod_cat')){
                    $data['ocext_ajax_cal_prod_cat'] = $this->config->get('ocext_ajax_cal_prod_cat');
                }
                
                
                $data['text_ocext_ajax_manufacturer'] = $this->language->get('text_ocext_ajax_manufacturer');
                
                $data['ocext_ajax_manufacturer'] = 5;
                if($this->config->get('ocext_ajax_manufacturer')){
                    $data['ocext_ajax_manufacturer'] = $this->config->get('ocext_ajax_manufacturer');
                }
                
                $data['text_ocext_ajax_search_input'] = $this->language->get('text_ocext_ajax_search_input');
                
                $data['ocext_ajax_search_input'] = 'search';
                if($this->config->get('ocext_ajax_search_input')){
                    $data['ocext_ajax_search_input'] = $this->config->get('ocext_ajax_search_input');
                }
                
                $data['text_ocext_ajax_text_no_results'] = $this->language->get('text_ocext_ajax_text_no_results');
                $data['text_ocext_ajax_text_more_results'] = $this->language->get('text_ocext_ajax_text_more_results');
                
                $data['ocext_ajax_text_no_results_value'] = $this->language->get('text_ocext_ajax_text_no_results_value');
                if($this->config->get('ocext_ajax_text_no_results_value')){
                    $data['ocext_ajax_text_no_results_value'] = $this->config->get('ocext_ajax_text_no_results_value');
                }
                
                $data['ocext_ajax_text_more_results_value'] = $this->language->get('text_ocext_ajax_text_more_results_value');
                if($this->config->get('ocext_ajax_text_more_results_value')){
                    $data['ocext_ajax_text_more_results_value'] = $this->config->get('ocext_ajax_text_more_results_value');
                }
                
                $data['heading_title'] = $this->language->get('heading_title');
                $data['tab_setting'] = $this->language->get('tab_setting');
                $data['tab_statistic'] = $this->language->get('tab_statistic');
                $data['button_set_index'] = $this->language->get('button_set_index');
                $data['button_save'] = $this->language->get('button_save');
                
                $data['ocext_smart_search_status'] = 0;
                if($this->config->get('ocext_smart_search_status')) {
			$data['ocext_smart_search_status'] = $this->config->get('ocext_smart_search_status');
		}
                
                $indexStat = $this->indexStat();
                $data['total_index_keywords'] = $indexStat['total_index_keywords'];
                
                $data['ocext_smart_search_attribute'] = '';
                if($this->config->get('ocext_smart_search_attribute')){
                    $data['ocext_smart_search_attribute'] = $this->config->get('ocext_smart_search_attribute');
                }
                
                
                if($this->config->get('ocext_smart_search_strict_master_function')){
                    $data['ocext_smart_search_strict_master_function'][$this->config->get('ocext_smart_search_strict_master_function')] = $this->config->get('ocext_smart_search_strict_master_function');
                }else{
                    $data['ocext_smart_search_strict_master_function'][500] = 500;
                }
                
                
                $data['ocext_smart_search_option'] = '';
                if($this->config->get('ocext_smart_search_option')){
                    $data['ocext_smart_search_option'] = $this->config->get('ocext_smart_search_option');
                }
                $data['ocext_smart_search_category'] = '';
                if($this->config->get('ocext_smart_search_category')){
                    $data['ocext_smart_search_category'] = $this->config->get('ocext_smart_search_category');
                }
                $data['ocext_smart_search_manufacturer'] = '';
                if($this->config->get('ocext_smart_search_manufacturer')){
                    $data['ocext_smart_search_manufacturer'] = $this->config->get('ocext_smart_search_manufacturer');
                }
                $data['ocext_smart_search_review'] = '';
                if($this->config->get('ocext_smart_search_review')){
                    $data['ocext_smart_search_review'] = $this->config->get('ocext_smart_search_review');
                }
                
                $data['ocext_smart_search_min_symbols'] = 3;
                if($this->config->get('ocext_smart_search_min_symbols') && $this->config->get('ocext_smart_search_min_symbols')>=3){
                    $data['ocext_smart_search_min_symbols'] = $this->config->get('ocext_smart_search_min_symbols');
                }
                
                //Делаем url
                $url = '';
                
                $filer = array(
			'filter_id'      => NULL,
			'filter_keyword'	   => NULL,
			'filter_used'  => NULL,
			'filter_index_elements'         => NULL,
			'filter_date_added'    => NULL,
			'sort'                 => 'used',
			'order'                => 'DESC',
			'start'                => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'                => $this->config->get('config_limit_admin')
		);
                $smart_search_statistic_total = $this->model_module_ocext_smart_search->getSmartSearchStatisticTotal($filer);
		$smart_search_statistic = $this->model_module_ocext_smart_search->getSmartSearchStatistic($filer);
                $data['smart_search_statistic'] = array();
		foreach ($smart_search_statistic as $statistic) {
                    $statistic['index_elements'] = json_decode($statistic['index_elements'],TRUE);
                    $data['smart_search_statistic'][] = array(
                            'id'      => $statistic['id'],
                            'keyword'      => $statistic['keyword'],
                            'index_elements'        => count($statistic['index_elements']),
                            'used'         => $statistic['used'],
                            'date_added'    => date($this->language->get('date_format_short'), strtotime($statistic['date_added']))
                    );
		}
                $pagination = new Pagination();
                $pagination->total = $smart_search_statistic_total;
                $pagination->page = $page;
                $pagination->limit = $this->config->get('config_limit_admin');
                $pagination->text = $this->language->get('text_pagination');
                $pagination->url = $this->url->link('module/ocext_smart_search', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
                $data['pagination'] = $pagination->render();
                //создаем строковые данные
                
                $data['token'] = $this->session->data['token'];
  		$data['breadcrumbs'] = array();
   		$data['breadcrumbs'][] = array(
                    'text'      => $this->language->get('text_home'),
                    'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
                    'separator' => false
   		);
   		$data['breadcrumbs'][] = array(
                    'text'      => $this->language->get('text_module'),
                    'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
                    'separator' => ' :: '
   		);
   		$data['breadcrumbs'][] = array(
                    'text'      => $this->language->get('heading_title'),
                    'href'      => $this->url->link('module/ocext_smart_search', 'token=' . $this->session->data['token'], 'SSL'),
                    'separator' => ' :: '
   		);
                
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
                $data['action'] = $this->url->link('module/ocext_smart_search', 'token=' . $this->session->data['token'], 'SSL');
                $data['action_index'] = $this->url->link('module/ocext_smart_search', 'set_index&token=' . $this->session->data['token'], 'SSL');
                $data['action_statistic'] = $this->url->link('module/ocext_smart_search', 'statistic&token=' . $this->session->data['token'], 'SSL');
                
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
                
		$this->template = 'module/iml.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
                $data['back'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['button_back'] = $this->language->get( 'button_back' );
                $data['header'] = $this->load->controller('common/header');
                $data['column_left'] = $this->load->controller('common/column_left');
                $data['footer'] = $this->load->controller('common/footer');
                $this->response->setOutput($this->load->view('module/ocext_smart_search.tpl', $data));
	}
	
	private function validate() {
            
		if (!$this->user->hasPermission('modify', 'module/ocext_smart_search')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
        
        private function indexStat(){
            //статистика
            $this->load->model('module/ocext_smart_search');
            $index_stat = $this->model_module_ocext_smart_search->getIndexStat();
            return $index_stat;
        }
        
        public function setIndexSmartSearch() {
            $data['start'] = $this->request->get['start'];
            $data['limit'] = $this->request->get['limit'];
            $this->load->model('module/ocext_smart_search');
            $total = $this->model_module_ocext_smart_search->getTotalProducts();
            $this->model_module_ocext_smart_search->setIndexSmartSearch($data);
            $data['total'] = $total;
            $data['error'] = '';
            $this->load->language('module/ocext_smart_search');
            $data['message'] = $this->language->get('text_success_index');
            $data = json_encode($data);
            echo $data;
        }
        public function getNotifications() {
		sleep(1);
		$this->load->language('module/ocext_smart_search');
		$response = $this->getNotificationsCurl();
		$json = array();
		if ($response===false) {
			$json['message'] = '';
			$json['error'] = $this->language->get( 'error_notifications' );
		} else {
			$json['message'] = $response;
			$json['error'] = '';
		}
		$this->response->setOutput(json_encode($json));
	}
        
        protected function curl_get_contents($url) {
            if(function_exists('curl_version')){
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
                $output = curl_exec($ch);
                curl_close($ch);
                return $output;
            }else{
                $output['ru'] = 'Проверка версии недоступна. Включите php расширение - CURL на Вашем хостинге';
                $output['en'] = 'You can not check the version. Enable php extension - CURL on your hosting';
                $language_code = $this->config->get( 'config_admin_language' );
                if(isset($output[$language_code])){
                    return $output[$language_code];
                }else{
                    return $output['en'];
                }
            }
	}


	public function getNotificationsCurl() {
		$language_code = $this->config->get( 'config_admin_language' );
		$result = $this->curl_get_contents("http://www.".$this->this_ocext_host.".com/index.php?route=information/check_update_version&license=".HTTP_SERVER."&version_opencart=".VERSION."&version_ocext=".$this->this_version."&extension=".$this->this_extension."&language_code=$language_code");
		if (stripos($result,'<html') !== false) {
			return '';
		}
		return $result;
	}
        
}
?>
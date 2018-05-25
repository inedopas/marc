<?php
class ControllerCatalogColorkits extends Controller {
	private $error = array();  
 
	public function index() {
		$this->load->language('catalog/color_kits');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/colorkit');
		
		$this->getList();
	}
	
	public function insert() {
		$this->load->language('catalog/color_kits');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/colorkit');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_colorkit->addColorKit($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->response->redirect($this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function update() {	
		$this->load->language('catalog/color_kits');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/colorkit');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_colorkit->editColorKit($this->request->get['color_kit_id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->response->redirect($this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}
	
	public function delete() {
		$this->load->language('catalog/color_kits');

		$this->document->setTitle($this->language->get('heading_title'));
 		
		$this->load->model('catalog/colorkit');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $color_kit_id) {
				$this->model_catalog_colorkit->deleteColorKit($color_kit_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->response->redirect($this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}
	
	protected function getList() {

		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'ck.name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
			
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true)
   		);


		$data['kits_auto'] = $this->url->link('catalog/color_kits/auto', 'token=' . $this->session->data['token'] . $url, true);
		$data['insert'] = $this->url->link('catalog/color_kits/insert', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/color_kits/delete', 'token=' . $this->session->data['token'] . $url, true);
		$data['color_list'] = $this->url->link('extension/module/colors', 'token=' . $this->session->data['token'] , true);
		 
		$data['filters'] = array();
		
		$datas = array(
			'filter_name' => $filter_name,
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);
		
		$filter_total = $this->model_catalog_colorkit->getTotalColorKits();

		$resultCkits = $this->model_catalog_colorkit->getColorKitsGroups($datas);
		
		foreach ($resultCkits as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/color_kits/update', 'token=' . $this->session->data['token'] . '&color_kit_id=' . $result['color_kit_id'] . $url, true)
			);

			$data['color_kits'][] = array(
				'color_kit_id'	  => $result['color_kit_id'],
				'name'            => $result['name'],
				'status'          => $result['status'],
				'tpl'          	  => $this->language->get('tpl_'.$result['tpl']),
				'action'          => $action
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_no_results'] = $this->language->get('text_no_results');

		$data['text_search'] = $this->language->get('text_search');
		$data['text_delete'] = $this->language->get('text_delete');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_kits'] = $this->language->get('column_kits');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');
		$data['column_tpl'] = $this->language->get('column_tpl');

		$data['button_insert'] = $this->language->get('button_insert');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_color_list'] = $this->language->get('button_color_list');

		$data['button_auto'] = $this->language->get('button_auto');
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$data['sort_name'] = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . '&sort=ck.name' . $url, true);
		$data['sort_tpl'] = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . '&sort=ck.tpl' . $url, true);
		$data['sort_status'] = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . '&sort=ck.status' . $url, true);
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $filter_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['filter_name'] = $filter_name;
		$data['token'] = $this->session->data['token'];

		$data['results'] = sprintf($this->language->get('text_pagination'), ($filter_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($filter_total - $this->config->get('config_limit_admin'))) ? $filter_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $filter_total, ceil($filter_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_kits.tpl', $data));
	}

	protected function getForm() {	
		$this->load->model('tool/image');
		$data['heading_title'] = $this->language->get('heading_title');

		$data['save_photos'] = $this->language->get('save_photos');
		$data['entry_group'] = $this->language->get('entry_group');		
		$data['column_kits'] = $this->language->get('column_kits');
		$data['column_status'] = $this->language->get('column_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_remove'] = $this->language->get('button_remove');

		$langs = array('entry_name_product','name_product','name_color','status_on','status_off','template','template_colors','template_photos','column_photo','choose','clear');
		foreach($langs as $lang){
			$data[$lang] = $this->language->get($lang);
		}
		
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
						
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true),
      		'separator' => ' :: '
   		);

	
		if (!isset($this->request->get['color_kit_id'])) {
			$data['action'] = $this->url->link('catalog/color_kits/insert', 'token=' . $this->session->data['token'] . $url, true);
		} else { 
			$data['action'] = $this->url->link('catalog/color_kits/update', 'token=' . $this->session->data['token'] . '&color_kit_id=' . $this->request->get['color_kit_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true);
			$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 50, 50);
		$data['token'] = $this->session->data['token'];
						
		$data['get_colors'] = $this->model_catalog_colorkit->getColors();				
		if (isset($this->request->post['color_kits'])) {
			$data['color_kits'] = $this->request->post['color_kits'];
		} elseif (isset($this->request->get['color_kit_id'])) {
			$results = $this->model_catalog_colorkit->getColorKit($this->request->get['color_kit_id']);
			$data['color_kit'] = $this->model_catalog_colorkit->getColorKitDescription($this->request->get['color_kit_id']);
			$this->load->model('catalog/product');
		
			
			$data['color_kits'] = array();
			foreach($results as $result){
				$product_info = $this->model_catalog_product->getProduct($result['product_id']);
				if ($product_info) {
					$data['color_kits'][] = array(
						'product_id' => $product_info['product_id'],
						'product_name' => $product_info['name'],
						'name' => $result['name'],
						'image' => $result['image'],
						'option_id' => $result['option_id'],
						'color' => $result['color']
					);
				}
			}
			
		} else {
			$data['color_kits'] = array();
			$data['color_kit']['name'] = '';
			$data['color_kit']['name'] = 'color';
			$data['color_kit']['status'] = '1';
		}

		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_kits_form.tpl', $data));
	}
	
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/color_kits')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 255)) {
				$this->error['warning'] = $this->language->get('error_name');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/color_kits')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}	
	
	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model']) || isset($this->request->get['filter_sku'])) {
			$this->load->model('catalog/colorkit');
			
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			
			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}
				
			if (isset($this->request->get['filter_sku'])) {
				$filter_sku = $this->request->get['filter_sku'];
			} else {
				$filter_sku = '';
			}
			
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];	
			} else {
				$limit = 20;	
			}			
						
			$data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'filter_sku' => $filter_sku,
				'start'        => 0,
				'limit'        => $limit
			);
				
			$results = $this->model_catalog_colorkit->getProducts($data);
			
			foreach ($results as $result) {								
				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),	
					'model'      => $result['model'],
					'sku'        => $result['sku']
				);	
			}

		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function auto(){
		$this->load->language('catalog/color_kits');
		
		$data['heading_title'] = $this->language->get('head_auto');
		$url = '';
		$this->document->setTitle($this->language->get('head_auto'));
		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('head_auto'),
			'href'      => $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true),
   		);
		

		$this->document->setTitle($this->language->get('head_auto'));
		
		$this->load->model('catalog/colorkit');
		
		$color_list = $this->model_catalog_colorkit->getColors();
		
		$products = $this->model_catalog_colorkit->getProductWidthColors($color_list);
		
		$data['kits_auto'] = $this->url->link('catalog/color_kits/auto', 'token=' . $this->session->data['token'] . $url, true);
		$data['insert'] = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'] . $url, true);
		$data['color_list'] = $this->url->link('extension/module/colors', 'token=' . $this->session->data['token'] , true);
		$data['action'] = $this->url->link('catalog/color_kits/auto', 'token=' . $this->session->data['token'] . $url, true);
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST'){
			$status = (isset($this->request->post['status'])) ? $this->request->post['status'] : '0';
			$save = $this->model_catalog_colorkit->autoFillKits($this->request->post,$status);
			$data['success'] = $this->language->get('successful');
		}

		$data['text_tpl'] = $this->language->get('text_tpl');
		$data['save_photos'] = $this->language->get('save_photos');
		$data['template_colors'] = $this->language->get('template_colors');
		$data['button_color_list'] = $this->language->get('button_color_list');
		$data['text_found'] = $this->language->get('text_found');
		$data['button_add_auto'] = $this->language->get('button_add_auto');
		$data['button_auto'] = $this->language->get('button_auto');
		$data['button_sets'] = $this->language->get('button_sets');
		$data['column_status'] = $this->language->get('column_status');

		$data['products'] = $products;


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/color_kits_auto.tpl', $data));
		
	}
	
}	
	
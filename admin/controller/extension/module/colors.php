<?php
class ControllerExtensionModuleColors extends Controller {
	private $error = array();  
 
	public function index() {
		$this->load->language('extension/module/colors');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/color');
		$this->load->model('setting/setting');
		
		$this->document->addScript('/admin/view/javascript/jquery/jquery-minicolors-master/jquery.minicolors.js');
		$this->document->addStyle('/admin/view/javascript/jquery/jquery-minicolors-master/jquery.minicolors.css');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_color->editColorOptions($this->request->post);
			$this->model_setting_setting->editSetting('color_kit', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/module/colors', 'token=' . $this->session->data['token'], true));
		}

		$this->getForm();
	}

	

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');
		$data['entry_name'] = $this->language->get('entry_name');
		
		$data['text_descr_col'] = $this->language->get('text_descr_col');
		$data['text_val_col'] = $this->language->get('text_val_col');
		
		$data['text_entry_name'] = $this->language->get('text_entry_name');
		$data['text_entry_color'] = $this->language->get('text_entry_color');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_remove'] = $this->language->get('button_remove');

		$langs = array('text_settings','text_val_col','text_descr_col','text_status_visibility','text_limit_colors','text_title','text_enable_popup','text_limit_colors_popup','text_size','text_width','text_color_templates',
			'text_ico_size','text_preview_size','text_category_ico_size','text_height','button_edit_kits');
		foreach($langs as $lang){
			$data[$lang] = $this->language->get($lang);
		}
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),
      		'separator' => false
   		);

		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], true),
      		'separator' => ' :: '
   		);
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/colors', 'token=' . $this->session->data['token'], true),
      		'separator' => ' :: '
   		);
		
		$data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		$data['action'] = $this->url->link('extension/module/colors', 'token=' . $this->session->data['token'], true);
		$data['color_kits'] = $this->url->link('catalog/color_kits', 'token=' . $this->session->data['token'], true);
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true);
				
		$data['color_options'] = array();			
		if (isset($this->request->post['color_options'])) {
			$data['color_options'] = $this->request->post['color_options'];
		} else {
			$data['color_options'] = $this->model_catalog_color->getColorOptionDescriptions();
		}	
		
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
		
		$colors_cfg = $this->config->get('color_kit');
		$colors_array = array ('name', 'limit','width','height','ico_width','ico_height','preview_width','preview_height','category_ico_width','category_ico_height','visible','title','enable_popup');
		
		foreach ($colors_array as $datas) {
			if (isset($this->request->post['color_kit'][$datas])) {
				$data[$datas] = $this->request->post['color_kit'][$datas];
			} else {			
				$data[$datas] = $colors_cfg[$datas];
			}
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/colors.tpl', $data));
	}
	
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'extension/module/colors')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		$arr = $this->request->post['option_value'];
		
		foreach($arr as $key => $opt){
			foreach($arr[$key]['r_opt_description'] as $value){			
				if ((utf8_strlen($value['name']) < 1) || (utf8_strlen($value['name']) > 64)) {
					$this->error['warning'] = $this->language->get('error_name');
				}		
			}
			
			if (utf8_strlen($opt['color']) < 4) {
				$this->error['warning'] = $this->language->get('error_color');
			}				
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	public function install() {
		$this->load->model('catalog/color');
		$this->model_catalog_color->createDatabaseTables();
	}

	public function uninstall() {

		$this->load->model('catalog/color');
		$this->model_catalog_color->dropDatabaseTables();
	}
}
?>
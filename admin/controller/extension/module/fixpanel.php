<?php
class ControllerExtensionModuleFixpanel extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('extension/module/fixpanel');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('extension/module');
		$data['text_image_manager'] = 'Image manager';
		$data['no_image'] = '/image/no_image.jpg';
		$this->load->model('setting/setting');
		
		$data['token'] = $this->session->data['token'];
		$fixpanel_module_cfg = $this->config->get('fixpanel');
		$fixpanel_module_links = $this->config->get('fixpanel_custom');	

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('fixpanel', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		}
		
		$this->document->addScript('/admin/view/javascript/jquery/jquery-minicolors-master/jquery.minicolors.js');
		
		$this->document->addStyle('/admin/view/stylesheet/fixpanel.css');
		$this->document->addStyle('/admin/view/javascript/jquery/jquery-minicolors-master/jquery.minicolors.css');
		
		$langs = array('entry_link','entry_name','entry_image','entry_sort_order','heading_title','text_default_links','text_custom_links','text_main_setting','text_enabled','text_browse','text_clear','text_design','text_add_phone','text_map','text_address');
		
		foreach ($langs as $lang) {
			$data[$lang] = $this->language->get($lang);
		}

		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');
		
		$data['entry_layout'] = $this->language->get('entry_layout');
		$data['entry_position'] = $this->language->get('entry_position');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['text_phone'] = $this->language->get('text_phone');
		$data['text_theme'] = $this->language->get('text_theme');
		$data['text_light'] = $this->language->get('text_light');
		$data['text_dark'] = $this->language->get('text_dark');
		$data['text_minimal'] = $this->language->get('text_minimal');
		$data['text_lk'] = $this->language->get('text_lk');
		$data['text_cart'] = $this->language->get('text_cart');
		$data['text_feedback'] = $this->language->get('text_feedback');
		
		$data['text_soc_links'] = $this->language->get('text_soc_links');
		$data['text_soc_link_vk'] = $this->language->get('text_soc_link_vk');
		$data['text_soc_link_fb'] = $this->language->get('text_soc_link_fb');
		$data['text_soc_link_tw'] = $this->language->get('text_soc_link_tw');
		$data['text_soc_link_gp'] = $this->language->get('text_soc_link_gp');
		$data['text_soc_link_inst'] = $this->language->get('text_soc_link_inst');
		
		$data['text_position'] = $this->language->get('text_position');
		$data['text_position_top'] = $this->language->get('text_position_top');
		$data['text_position_bottom'] = $this->language->get('text_position_bottom');
		 
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['image'])) {
			$data['error_image'] = $this->error['image'];
		} else {
			$data['error_image'] = array();
		}
				
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/module/fixpanel', 'token=' . $this->session->data['token'], true),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('extension/module/fixpanel', 'token=' . $this->session->data['token'], true);
		
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], true);

		$data['token'] = $this->session->data['token'];
			
		$this->load->model('localisation/language');
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		$fixpanel_cfg_data = array ('phone', 'oc_link', 'theme', 'link_lk', 'link_inst', 'link_cart', 'link_feedback', 'position', 'link_vk', 'link_fb', 'link_gp', 'link_tw','color_links','color_links_h','color_phone','color_back','color_border','add_phone','map','address');
			
		foreach ($fixpanel_cfg_data as $datas) {
			if (isset($this->request->post['fixpanel'][$datas])) {
				$data[$datas] = $this->request->post['fixpanel'][$datas];
			} else {			
				$data[$datas] = $fixpanel_module_cfg[$datas];
			}
		}
		
		$data['datal'] = array();
		if(isset($fixpanel_module_links)){
			foreach ($fixpanel_module_links as $datal) {			
				$data['datal'][] = $datal; 			
			}
		}
		
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('extension/module/fixpanel', $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/fixpanel')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
<?php  
class ControllerExtensionModuleFixpanel extends Controller {
	public function index($setting) {
		$this->language->load('extension/module/fixpanel');

		$fixpanel_module_cfg = $this->config->get('fixpanel');
		$fixpanel_module_links = $this->config->get('fixpanel_custom');	

		$langs = array('text_account','text_cart','text_feedback','text_viewed','button_cart','text_map','text_address','text_all_contancts','text_add_phone');
		foreach($langs as $lang){
			$data[$lang] = $this->language->get($lang);
		}
					
		$data['fix_theme'] = $fixpanel_module_cfg['theme'];
		$data['lang_id'] = (int)$this->config->get('config_language_id');
					
		$data['fix_phone'] = $fixpanel_module_cfg['phone'];
		$data['fix_position'] = $fixpanel_module_cfg['position'];
		$data['fix_link_fb'] = $fixpanel_module_cfg['link_fb'];
		$data['fix_link_vk'] = $fixpanel_module_cfg['link_vk'];
		$data['fix_link_tw'] = $fixpanel_module_cfg['link_tw'];
		$data['fix_link_inst'] = $fixpanel_module_cfg['link_inst'];
		$data['fix_link_gp'] = $fixpanel_module_cfg['link_gp'];					
		
		$ar_config = array('color_links','color_links_h','color_phone','color_back','color_border','link_lk','oc_link','link_cart','link_feedback','map','address','add_phone');
		if(isset($fixpanel_module_cfg)){
			foreach($ar_config as $conf){
				$data[$conf] = $fixpanel_module_cfg[$conf];
			}
		}
						
		$data['custom_links'] = array();
		if(isset($fixpanel_module_links)){
			foreach ($fixpanel_module_links as $custom_links) { 		
				$data['custom_links'][] = $custom_links; 			
			}		
		}
		$data['account'] = $this->url->link('account/account', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);
		$data['contact'] = $this->url->link('information/contact', '', true);
		
		$this->document->addStyle('catalog/view/theme/default/stylesheet/fixpanel.css');
		$this->document->addStyle('catalog/view/javascript/owl-carousel/owl.carousel.css');
		$this->document->addStyle('catalog/view/javascript/owl-carousel/owl.theme.css');
		$this->document->addScript('catalog/view/javascript/owl-carousel/owl.carousel.js');	
		//colorbox
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
		
		if(isset($this->session->data['wishlist'])) {
			$data['total_wl'] = count($this->session->data['wishlist']);
		} else {
			$data['total_wl'] = 0;
		}

		return $this->load->view('extension/module/fixpanel', $data);
	}
	
	public function countWishlist(){
		$json = array();
		$json['total'] = isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0;
				
		$this->response->setOutput(json_encode($json));
	}
	
	public function getWishlist(){
		if (!isset($this->session->data['wishlist'])) {
			$this->session->data['wishlist'] = array();
		}
		
		if (isset($this->request->get['remove'])) {
			$key = array_search($this->request->get['remove'], $this->session->data['wishlist']);
			if ($key !== false) {
				unset($this->session->data['wishlist'][$key]);
			}	
		}
		
		$data['products'] = array();
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image');
		foreach ($this->session->data['wishlist'] as $key => $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) { 
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], 35, 35);
				} else {
					$image = false;
				}

																			
				$data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'thumb'      => $image,
					'name'       => $product_info['name'],
					'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
					'remove'     => $this->url->link('extension/module/fixpanel/getWishlist', 'remove=' . $product_info['product_id'])
				);
			} else {
				unset($this->session->data['wishlist'][$key]);
			}
		}	
		
	
		$this->response->setOutput($this->load->view('extension/module/fix_wishlist', $data));
		
	}
}
?>
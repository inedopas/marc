<?php
class ControllerProductColorkits extends Controller {  
	
	public function index() { 
	
	
	$this->load->model('catalog/product');
	$this->load->model('catalog/colorkit');
	$this->load->model('tool/image');
	
	$data['colors_cfg'] = $this->config->get('color_kit');
	
	
	$colors = $this->model_catalog_colorkit->getColors($this->request->get['c_product_id']);

	$data['colors'] = array();
					
	foreach ($colors as $color) {
					
		$cp_product_info = $this->model_catalog_product->getProduct($color['product_id']);
						
		if ($cp_product_info['image']) {
			$cp_image = $this->model_tool_image->resize($cp_product_info['image'], $data['colors_cfg']['width'], $data['colors_cfg']['height']);
		} else {
			$cp_image = false;
		}
						
		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$cp_price = $this->currency->format($this->tax->calculate($cp_product_info['price'], $cp_product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
		} else {
			$cp_price = false;
		}
								
		if ((float)$cp_product_info['special']) {
			$cp_special = $this->currency->format($this->tax->calculate($cp_product_info['special'], $cp_product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
		} else {
			$cp_special = false;
		}

		if ($cp_product_info['quantity'] === '0') {
			$quantity = 'disabled';
		} else {
			$quantity = null;
		}

		$data['colors'][] = array(
			'product_id' => $color['product_id'],
			'thumb'   	 => $cp_image,
			'name_color' => $color['color_name'],
			'quantity'	 => (isset($quantity)) ? $quantity : null,
			'color' 	 => $color['color'],
			'price'   	 => $cp_price,
			'special' 	 => $cp_special,
			'href'    	 => $this->url->link('product/product', 'product_id=' . $color['product_id'])
		);			
	}
	
	
	if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . 'product/colorkits')) {
		$this->response->setOutput($this->load->view($this->config->get('config_template') . 'product/colorkits', $data));
	} else {
		$this->response->setOutput($this->load->view('product/colorkits', $data));
	}
					
	}
	
}
				
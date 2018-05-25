<?php
class ControllerExtensionModuleViewed extends Controller {
	public function index($setting) {
		$this->load->language('extension/module/viewed');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');
		
		/*Комплекты начало*/
		$this->document->addStyle('catalog/view/theme/default/stylesheet/color_options.css');
        /*Комплекты конец*/

		$data['products'] = array();

        $products = array();

        if (isset($this->request->cookie['viewed'])) {
            $products = explode(',', $this->request->cookie['viewed']);
        }
		
		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}
		
		if ( $products ) {
			
			/*Комлекты начало*/
			$this->load->model('catalog/colorkit');
			$data['colors_cfg'] = $this->config->get('color_kit');
            /*Комлекты конец*/
			
			foreach ($products as $product_id) {
			    
				if ( !isset($this->request->get['product_id']) || $product_id != $this->request->get['product_id'] ) {
					$product_info = $this->model_catalog_product->getProduct($product_id);
				} else {
					$product_info = false;
				}
				
				/*Комлекты начало*/
			$getColors = $this->model_catalog_colorkit->getColors($product_info['product_id']);
            $data_colors = array();
            foreach ($getColors as $color) {
                if($color['product_id'] == $product_info['product_id']) continue;
                    $cp_product_info = $this->model_catalog_product->getProduct($color['product_id']);
                    if($color['tpl'] == 'photos') {
                        $ico_photo = $this->model_tool_image->resize($cp_product_info['image'], $data['colors_cfg']['category_ico_width'], $data['colors_cfg']['category_ico_height']);
                    } else {
                        $ico_photo = false;
                    }
                    if ($cp_product_info['image']) {
                    $cp_image = $this->model_tool_image->resize($cp_product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                        } else {
                    $cp_image = false;
                    }
                
                    $cp_name = $cp_product_info['name'];
						
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
	 
                    $data_colors[] = array(
                        'product_id' => $color['product_id'],
                        'product_name' => $cp_name,
                        'product_price' => $cp_price,
                        'thumb'     => $cp_image,
                        'color_name' => $color['color_name'],
                        'tpl'        => $color['tpl'],
                        'ico_color'  => $this->model_tool_image->resize($color['image'], 50, 50),
                        'ico_photo'  => $ico_photo,
                        'color_photo'  => $cp_photo,
                        'color'      => $color['color'],
                        'href'      => $this->url->link('product/product', 'product_id=' . $color['product_id'])
                    );
                }
			    /*Комлекты конец*/
				
				if ($product_info) {
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$price = false;
					}

					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}

					$data['products'][] = array(
						'product_id'  => $product_info['product_id'],
						'thumb'       => $image,
						/*Комлекты начало*/
					    'colors'      => $data_colors,
					    /*Комлекты конец*/
						'name'        => $product_info['name'],
						'description' => utf8_substr(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $product_info['product_id'])
					);
				}
				
				if ( count($data['products']) >= $setting['limit'] ) break;
				
			}
		}

		if ($data['products']) {
			return $this->load->view('extension/module/viewed', $data);
		}
	}

}
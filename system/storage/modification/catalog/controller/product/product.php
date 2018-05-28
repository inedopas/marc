<?php
class ControllerProductProduct extends Controller {
	private $error = array();


				protected function getReviewsFirstPage($product_id) {
					$this->load->language('product/product');

          $this->load->model('module/statistics');
        $this->model_module_statistics->validateTransitions();
      
					$this->load->model('catalog/review');
					$data['text_no_reviews'] = $this->language->get('text_no_reviews');

			$data['entry_admin_author'] = $this->config->get('config_name');
		
					
					$page = 1;
					$data['reviews'] = array();
					$review_total = $this->model_catalog_review->getTotalReviewsByProductId($product_id);
					$results = $this->model_catalog_review->getReviewsByProductId($product_id, 0, $review_total);
					foreach ($results as $result) {
						$data['reviews'][] = array(

			'admin_author'       => $result['admin_author'],
			'answer'       => $result['answer'],			
		
							'author'     => $result['author'],
							'text'       => nl2br($result['text']),
							'rating'     => (int)$result['rating'],
							'date_added_fixed' => date('Y-m-d', strtotime($result['date_added'])),
							'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
						);
					}
					$pagination = new Pagination();
					$pagination->total = $review_total;
					$pagination->page = $page;
					$pagination->limit = 5;
					$pagination->url = $this->url->link('product/product/review', 'product_id=' . $product_id . '&page={page}');
					$data['pagination'] = $pagination->render();
					$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));
					
					return $data;
				}
				
	public function index() {
		$this->load->language('product/product');

          $this->load->model('module/statistics');
        $this->model_module_statistics->validateTransitions();
      


				//breadcrumbs data
				if ($this->request->server['HTTPS']) {
			    $server = $this->config->get('config_ssl');
		        } else {
		  	    $server = $this->config->get('config_url');
		        }
		        $data['base'] = $server;
				$data['store_name'] = $this->config->get('config_name');
                
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$this->load->model('catalog/category');

		if (isset($this->request->get['path'])) {
			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

			$category_id = (int)array_pop($parts);

			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path)
					);
				}
			}

			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);

			if ($category_info) {
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

				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}

				$data['breadcrumbs'][] = array(
					'text' => $category_info['name'],
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
				);
			}
		}

		$this->load->model('catalog/manufacturer');

		if (isset($this->request->get['manufacturer_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_brand'),
				'href' => $this->url->link('product/manufacturer')
			);

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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {
				$data['breadcrumbs'][] = array(
					'text' => $manufacturer_info['name'],
					'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
				);
			}
		}

		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_search'),
				'href' => $this->url->link('product/search', $url)
			);
		}



		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

	

		if ($product_info) {
$data['video_status'] = $this->config->get('video_status');

		$viewed_products = array();
        if (isset($this->request->cookie['viewed'])) {
            $viewed_products = explode(',', $this->request->cookie['viewed']);
        }
		$viewed_products = array_diff( $viewed_products, array($product_id) );
		array_unshift( $viewed_products, $product_id );
		$viewed_products = array_chunk( $viewed_products, 99 ) ;
		$viewed_products = array_shift( $viewed_products );
		setcookie( 'viewed', implode( ',', $viewed_products), time() + 60 * 60 * 24 * 30, '/', $this->request->server['HTTP_HOST'] );
			
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $product_info['name'],
				'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
			);

			if ($product_info['meta_title']) {
				$this->document->setTitle($product_info['meta_title']);
			} else {
				$this->document->setTitle($product_info['name']);
			}

			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/locale/'.$this->session->data['language'].'.js');
			$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

			if ($product_info['meta_h1']) {
				$data['heading_title'] = $product_info['meta_h1'];
			} else {
				$data['heading_title'] = $product_info['name'];
			}

			$data['text_select'] = $this->language->get('text_select');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['entry_weight'] = $this->language->get('entry_weight');
			$data['weight_class_id'] = $this->language->get('weight_class_id');
			$data['text_weight_1'] = $this->language->get('text_weight_1');
			$data['text_weight_2'] = $this->language->get('text_weight_2');
			$data['text_reward'] = $this->language->get('text_reward');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_stock'] = $this->language->get('text_stock');
			$data['text_qustock'] = $this->language->get('text_qustock');
			$data['text_discount'] = $this->language->get('text_discount');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_option'] = $this->language->get('text_option');
			$data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$data['text_write'] = $this->language->get('text_write');
			$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', true), $this->url->link('account/register', '', true));
			$data['text_note'] = $this->language->get('text_note');
			$data['text_tags'] = $this->language->get('text_tags');
			$data['text_related'] = $this->language->get('text_related');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_qty'] = $this->language->get('entry_qty');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_review'] = $this->language->get('entry_review');
			$data['entry_rating'] = $this->language->get('entry_rating');
			$data['entry_good'] = $this->language->get('entry_good');
			$data['entry_bad'] = $this->language->get('entry_bad');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_upload'] = $this->language->get('button_upload');
			$data['button_continue'] = $this->language->get('button_continue');

			$this->load->model('catalog/review');

			$data['tab_description'] = $this->language->get('tab_description');
			$data['tab_attribute'] = $this->language->get('tab_attribute');
			$data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

			$data['product_id'] = (int)$this->request->get['product_id'];
			$data['manufacturer'] = $product_info['manufacturer'];
			$data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$data['model'] = $product_info['model'];
			$data['weight'] = $product_info['weight'];
			$data['weight_class_id'] = $product_info['weight_class_id'];
			$data['reward'] = $product_info['reward'];
			$data['points'] = $product_info['points'];
			$data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');

                if (isset($this->session->data['partner_price']) && $this->session->data['partner_price'] === true) {
    				$custom_discounts = $this->config->get('total_customer_group_discount_customer_group_id');
    				foreach ($custom_discounts as $group_id => $discount){
    					if ($group_id == 16){
    						$customerDiscount = $discount;
    						break;
    					}
    				}
    				$data['custom_partner_price'] = "У вас есть скидка <b style=\"color:red\">$customerDiscount%</b> от указанной цены";
    			}
			

			// +++ TESLA-CHITA
			$product_id = (int)$this->request->get['product_id'];
			// Характеристики
			$product_option_values = array();
			$sql = "SELECT `pfv`.`product_feature_id`, `pov`.`product_option_id`, `pfv`.`product_option_value_id` FROM `" . DB_PREFIX . "product_feature_value` `pfv` LEFT JOIN `" . DB_PREFIX . "product_option_value` `pov` ON (`pfv`.`product_option_value_id` = `pov`.`product_option_value_id`) LEFT JOIN `" . DB_PREFIX . "option` `o` ON (`pov`.`option_id` = `o`.`option_id`) WHERE `pfv`.`product_id` = " . $this->request->get['product_id'] . " ORDER BY `o`.`sort_order`";
			$query = $this->db->query($sql);
			$features = $query->rows;
			foreach ($features as $feature_value) {
				if (empty($product_option_values[$feature_value['product_option_value_id']])) {
					$product_option_values[$feature_value['product_option_value_id']] = array();
				}
       			foreach ($features as $feature_value1) {
       				if ($feature_value1['product_feature_id'] == $feature_value['product_feature_id'] && $feature_value1['product_option_value_id'] <> $feature_value['product_option_value_id']) {

       					$product_option_values[$feature_value['product_option_value_id']][] = $feature_value1['product_option_value_id'];
       				}
				}

	        }
        	unset($query);

			$customer_group_id = $this->customer->isLogged()? $this->customer->getGroupId() : $this->config->get('config_customer_group_id');
			$product_features_price = array();
			$query = $this->db->query("SELECT `product_feature_id`, `price`, `unit_id` FROM `" . DB_PREFIX . "product_price` WHERE `product_id` = " . (int)$this->request->get['product_id'] . " AND `customer_group_id` = " . $customer_group_id);
			$data['currency_data'] = array(
				'symbol'  => $this->currency->getSymbolRight($this->session->data['currency']),
				'decimal' => $this->currency->getDecimalPlace($this->session->data['currency']),
				'value'	  => $this->currency->getValue($this->session->data['currency'])
			);
			$product_features_price = array();
			$product_features_options = array();
			$product_features_options_values = array();
			foreach ($query->rows as $query_price) {
				$product_features_price[$query_price['product_feature_id']] = array(
					'value' => $query_price['price'] * $data['currency_data']['value'],
					'tax'	=> $this->tax->calculate($query_price['price'], $product_info['tax_class_id'], $this->config->get('config_tax')) * $data['currency_data']['value'],
					'unit'	=> $query_price['unit_id']
				);
				foreach ($features as $feature) {
					if ($feature['product_feature_id'] == $query_price['product_feature_id']) {
						if (!isset($product_features_options[$feature['product_feature_id']])) {
							$product_features_options[$feature['product_feature_id']] = array();
						}
						$product_features_options[$feature['product_feature_id']][$feature['product_option_id']] = $feature['product_option_value_id'];
						$product_features_options_values[$feature['product_option_value_id']] = $feature['product_feature_id'];
					}
				}
			}
			$data['product_features_price'] = $product_features_price;
			$data['product_features_options'] = $product_features_options;
			$data['product_features_options_values'] = $product_features_options_values;

			// Остатки в базовой единице
			$product_quantity = array();
			$product_units = array();
			$quantity_total = 0;
			if ($this->config->get('config_stock_display') && !empty($product_features_options)) {

				$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_quantity` WHERE `product_id` = " . (int)$this->request->get['product_id']);
				foreach ($query->rows as $query_quantity) {

					if (!isset($product_quantity[$query_quantity['product_feature_id']])) {
						$product_quantity[$query_quantity['product_feature_id']] = array();
					}
					$quantity = &$product_quantity[$query_quantity['product_feature_id']];

					if (!isset($quantity[$query_quantity['warehouse_id']])) {
						$quantity[$query_quantity['warehouse_id']] = $query_quantity['quantity'];
						$quantity_total += $query_quantity['quantity'];
					}

					$query = $this->db->query("SELECT `u`.`name`, `u`.`full_name`, `pu`.`ratio`, `pu`.`product_feature_id`, `u`.`unit_id` FROM `" . DB_PREFIX . "product_unit` `pu` LEFT JOIN `" . DB_PREFIX . "unit_to_1c` `u` ON (`pu`.`unit_id` = `u`.`unit_id`) WHERE `pu`.`product_id` = " . $product_id);
					if ($query->num_rows) {
						foreach ($query->rows as $row) {
							if (isset($product_units[$row['unit_id']]))
								continue;
							$product_units[$row['unit_id']] = array(
								'full_name'				=> $row['full_name'],
								'name'					=> $row['name'],
								'ratio'					=> $row['ratio'],
								'product_feature_id'	=> $row['product_feature_id']
						  );
						}
					}
				}
			}
			$product_quantity[0] = $quantity_total;
			$data['product_quantity'] = $product_quantity;
			$data['product_units'] = $product_units;

			// Список складов
			$sql = "SELECT * FROM `" . DB_PREFIX . "warehouse`";
			$query = $this->db->query($sql);
			$data['warehouses'] = array();
			foreach ($query->rows as $query_warehouse) {
				$data['warehouses'][$query_warehouse['warehouse_id']] = $query_warehouse['name'];
			}
			// --- TESLA-CHITA

			if ($product_info['quantity'] <= 0) {
				$data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$data['stock'] = $product_info['quantity'];
			} else {
				$data['stock'] = $this->language->get('text_instock');
			}

			$this->load->model('tool/image');

			if ($product_info['image']) {
				$data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
			} else {
				$data['popup'] = '';
			}

			if ($product_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

			$data['images'] = array();

			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

			foreach ($results as $result) {
				$data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height')),
'video' => $result['video'],
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_additional_width'), $this->config->get($this->config->get('config_theme') . '_image_additional_height'))
				);
			}

			if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
				// if (!(float)$product_info['price']) {
				// 	$tmp_query = $this->db->query("SELECT min(price) as price FROM " . DB_PREFIX . "product_option_value WHERE price > 0 AND product_id = '" . (int)$product_info['product_id'] . "'");
				// 	if ($tmp_query->num_rows) {
				// 		$product_info['price'] = $tmp_query->row['price'];
				// 	}
				// }
				// if (!(float)$product_info['price']) {
				// 	$tmp_query = $this->db->query("SELECT min(price) as price FROM " . DB_PREFIX . "product_option_value WHERE price > 0 AND product_id = '" . (int)$product_info['product_id'] . "'");
				// 	if ($tmp_query->num_rows) {
				// 		$data['price'] = $this->currency->format($this->tax->calculate($tmp_query->row['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				// 		$data['price_float'] = $tmp_query->row['price'];
				// 	}
				// } else {
                	$data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                	$data['price_float'] = $product_info['price'];
                // }
            } else {
                $data['price'] = false;
                $data['price_float'] = false;
            }

            if ((float)$product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                $data['special_float'] = $product_info['special'];
            } else {
                $data['special'] = false;
                $data['special_float'] = false;
            }

			if ($this->config->get('config_tax')) {
				$data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price'], $this->session->data['currency']);
			} else {
				$data['tax'] = false;
			}

			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

			$data['discounts'] = array();

			foreach ($discounts as $discount) {
				$data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'])
				);
			}

			$data['options'] = array();

            foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
                        } else {
                            $price = false;
                        }

                        if ((float)$option_value['special'] && (($option_value['date_start'] == '0000-00-00' || strtotime($option_value['date_start']) < time()) && ($option_value['date_end'] == '0000-00-00' || strtotime($option_value['date_end']) > time()))) {
							$special = $this->currency->format($this->tax->calculate($option_value['special'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false), $this->session->data['currency']);
						} else {
							$special = false;
						}

						// +++ TESLA-CHITA
						$class = "";
						foreach ($product_option_values[$option_value['product_option_value_id']] as $value) {
							if (empty($class)) {
								$class = $value;
							} else {
								$class .= " " . $value;
							}
						}
						// --- TESLA-CHITA


                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
							// +++ TESLA-CHITA
							'price_prefix'            => $option_value['price_prefix'],
							'class'                   => $class,
							// --- TESLA-CHITA
                            'option_value_id'         => $option_value['option_value_id'],
                            'name'                    => $option_value['name'],
                            'quantity'                => $option_value['quantity'],
                            'image'                   => $option_value['image'] ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
                            'price'                   => $price,
                            'special'				  => $special,
                            'price_prefix'            => $option_value['price_prefix'],
                            'weight'                  => $option_value['weight']
                        );
                    }
                }

                $data['options'][] = array(
                    'product_option_id'    => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id'            => $option['option_id'],
                    'name'                 => $option['name'],
                    'type'                 => $option['type'],
                    'value'                => $option['value'],
                    'required'             => $option['required']
                );
            }

			if ($product_info['minimum']) {
				$data['minimum'] = $product_info['minimum'];
			} else {
				$data['minimum'] = 1;
			}

			$data['review_status'] = $this->config->get('config_review_status');

			if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
			} else {
				$data['review_guest'] = false;
			}

			if ($this->customer->isLogged()) {
				$data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
			} else {
				$data['customer_name'] = '';
			}

			$data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
			$data['rating'] = (int)$product_info['rating'];

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$data['captcha'] = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha'));
			} else {
				$data['captcha'] = '';
			}

			$data['share'] = $this->url->link('product/product', 'product_id=' . (int)$this->request->get['product_id']);

			$data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);


					$data['colors_cfg'] = $this->config->get('color_kit');
				
					$this->document->addStyle('catalog/view/theme/default/stylesheet/color_options.css');
					$this->document->addStyle('catalog/view/javascript/fancybox/jquery.fancybox.css?v=2.1.5');
					
					$this->document->addScript('catalog/view/javascript/fancybox/jquery.fancybox.js');
					$this->document->addScript('catalog/view/javascript/fancybox/jquery.fancybox.pack.js?v=2.1.5');
					
					$this->load->model('catalog/colorkit');

					$data['colors_title'] = $data['colors_cfg']['title'][$this->config->get('config_language_id')];

					$colors = $this->model_catalog_colorkit->getColors($this->request->get['product_id']);
					$data['colors'] = array();
					if(isset($data['colors_cfg']['visible']) && $data['colors_cfg']['visible'] != 0){
						$colors = array_slice($colors,0,$data['colors_cfg']['visible']);
					}
					foreach ($colors as $color) {
						
						$cp_product_info = $this->model_catalog_product->getProduct($color['product_id']);

						//$ico_photo - ico main image product
						if($color['tpl'] == 'photos') {
							$ico_photo = $this->model_tool_image->resize($cp_product_info['image'], $data['colors_cfg']['ico_width'], $data['colors_cfg']['ico_height']);
							$preview_photo = $this->model_tool_image->resize($cp_product_info['image'], $data['colors_cfg']['preview_width'], $data['colors_cfg']['preview_height']);
						} else {
							$ico_photo = false;
							$preview_photo = false;
						}

						if ($cp_product_info['image']) {
							$cp_image = $this->model_tool_image->resize($cp_product_info['image'], $this->config->get('theme_default_image_additional_width'), $this->config->get('theme_default_image_additional_height'));
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

						if ($cp_product_info['quantity'] === '0') {
							$quantity = 'disabled';
						} else {
							$quantity = null;
						}

						$data['colors'][] = array(
							'product_id' => $color['product_id'],
							'name'       => $cp_name,
							'thumb'   	 => $cp_image,
							'color_name' => $color['color_name'],
							'tpl'        => $color['tpl'],
							'quantity'	 => (isset($quantity)) ? $quantity : null,
							'ico_color'  =>  $this->model_tool_image->resize($color['image'], $data['colors_cfg']['ico_width'], $data['colors_cfg']['ico_height']),
							'ico_photo'  => $ico_photo,
							'preview_photo'  => $preview_photo,
							'color'      => $color['color'],
							'price'   	 => $cp_price,
							'special' 	 => $cp_special,
							'href'    	 => $this->url->link('product/product', 'product_id=' . $color['product_id'])
						);

					}
				
			$data['products'] = array();

			$results = $this->model_catalog_product->getRelatedByCategory($this->request->get['product_id']);
//$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}

			$data['tags'] = array();

			if ($product_info['tag']) {
				$tags = explode(',', $product_info['tag']);

				foreach ($tags as $tag) {
					$data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}

			$data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

//BOF Product Series 
			//get link of linked products + colors
			$pds_allow_buying_series = $this->getData('pds_allow_buying_series', 0);
			
			$this->load->model('catalog/product_master');
			$results = $this->model_catalog_product_master->getLinkedProducts($this->request->get['product_id'], '2', $pds_allow_buying_series); //'2' is Image
			
			$data['pds'] = array();
			
			$pds_detail_thumbnail_width = $this->getData('pds_detail_thumbnail_width', 50);
			$pds_detail_thumbnail_height = $this->getData('pds_detail_thumbnail_height', 50);
			$pds_preview_width = $this->getData('pds_preview_width', 200);
			$pds_preview_height = $this->getData('pds_preview_height', 200);
			$data['pds_enable_preview'] = $this->getData('pds_enable_preview', 1);
			
			foreach ($results as $result)
			{
				$product_pds_image = ($result['special_attribute_value'] != '' && strtolower($result['special_attribute_value']) != 'no_image.png')
					? $this->model_tool_image->resize($result['special_attribute_value'], $pds_detail_thumbnail_width, $pds_detail_thumbnail_height)
					: $this->model_tool_image->resize($result['image'], $pds_detail_thumbnail_width, $pds_detail_thumbnail_height);
				
				$product_main_image = ($result['image'] != '' && strtolower($result['image']) != 'no_image.png')
					? $this->model_tool_image->resize($result['image'], $pds_preview_width, $pds_preview_height) //user default main image
					: $this->model_tool_image->resize($result['special_attribute_value'], $pds_preview_width, $pds_preview_height); // use series image
			
				$data['pds'][] = array(
					'product_id' => $result['product_id'],
					'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
					'product_name' => $result['name'],
					'product_pds_image' => $product_pds_image,
					'product_main_image' => $product_main_image
				);
			}
			
			$this->load->model('catalog/product_master');
			$this->load->language('product/pds');
			
			if(!isset($data['display_add_to_cart']))
			{
				$is_master = $this->model_catalog_product_master->isMaster($this->request->get['product_id'], '2'); //2 is Image
				$pds_allow_buying_series = $this->getData('pds_allow_buying_series', 0);
				$data['display_add_to_cart'] = !$is_master || $pds_allow_buying_series;
				$data['no_add_to_cart_message'] = $this->language->get('text_select_series_item');
			}
			
			$data['text_in_the_same_series'] = $this->language->get('text_in_the_same_series');
			//EOF Product Series 
			$this->model_catalog_product->updateViewed($this->request->get['product_id']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');


				//reviews add without ajax
				$data['reviews_first'] = $this->getReviewsFirstPage((int)$this->request->get['product_id']);
				//product data
                $data['rich_snippets'] = array();
				$data['rich_snippets']['name'] = $data['heading_title'];
				$data['rich_snippets']['image'] = $data['popup'];
				$data['rich_snippets']['description'] = preg_replace('/[\n\r]/', '', strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')));
				$data['rich_snippets']['model'] = $data['model'];
				$data['rich_snippets']['brand'] = $data['manufacturer'];
				$data['rich_snippets']['ratingValue'] = number_format((float)$product_info['rating_fixed'], 1, '.', '');
				$data['rich_snippets']['ratingCount'] = $product_info['reviews'];
				$data['rich_snippets']['reviewCount'] = $product_info['reviews'];
				$data['rich_snippets']['priceCurrency'] = $this->session->data['currency'];
				$rich_snippets_price = trim(trim(($data['special'] != false) ? $data['special'] : $data['price'], $this->currency->getSymbolLeft($this->session->data['currency'])), $this->currency->getSymbolRight($this->session->data['currency']));
				$decimal_point_rs_price = $this->language->get('decimal_point') ? $this->language->get('decimal_point') : '.';
                $thousand_point_rs_price = $this->language->get('thousand_point')? $this->language->get('thousand_point') : ' ';
                $rich_snippets_price = str_replace($thousand_point_rs_price, '', $rich_snippets_price);
                if ( $decimal_point_rs_price != '.' ) {
                  $rich_snippets_price = str_replace($decimal_point_rs_price, '.', $rich_snippets_price);
                }
                $rich_snippets_price = number_format($rich_snippets_price, 2, '.', '');
				$data['rich_snippets']['price'] = $rich_snippets_price;
				$data['rich_snippets']['availability'] = (($product_info['quantity'] <= 0) ? $product_info['stock_status'] : 'InStock');
				$data['rich_snippets']['seller_name'] = $this->config->get('config_name');
                
			$this->response->setOutput($this->load->view('product/product', $data));
		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}

			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}

			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}

			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
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

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function review() {
		$this->load->language('product/product');

          $this->load->model('module/statistics');
        $this->model_module_statistics->validateTransitions();
      

		$this->load->model('catalog/review');

		$data['text_no_reviews'] = $this->language->get('text_no_reviews');

			$data['entry_admin_author'] = $this->config->get('config_name');
		

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['reviews'] = array();

		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['reviews'][] = array(

			'admin_author'       => $result['admin_author'],
			'answer'       => $result['answer'],			
		
				'author'     => $result['author'],
				'text'       => nl2br($result['text']),
				'rating'     => (int)$result['rating'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

		$this->response->setOutput($this->load->view('product/review', $data));
	}

	public function write() {
		$this->load->language('product/product');

          $this->load->model('module/statistics');
        $this->model_module_statistics->validateTransitions();
      

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			// Captcha
			if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('review', (array)$this->config->get('config_captcha_page'))) {
				$captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

				if ($captcha) {
					$json['error'] = $captcha;
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/review');

				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getRecurringDescription() {
		$this->load->language('product/product');

          $this->load->model('module/statistics');
        $this->model_module_statistics->validateTransitions();
      
		$this->load->model('catalog/product');

		if (isset($this->request->post['product_id'])) {
			$product_id = $this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		if (isset($this->request->post['recurring_id'])) {
			$recurring_id = $this->request->post['recurring_id'];
		} else {
			$recurring_id = 0;
		}

		if (isset($this->request->post['quantity'])) {
			$quantity = $this->request->post['quantity'];
		} else {
			$quantity = 1;
		}

		$product_info = $this->model_catalog_product->getProduct($product_id);
		$recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

		$json = array();

		if ($product_info && $recurring_info) {
			if (!$json) {
				$frequencies = array(
					'day'        => $this->language->get('text_day'),
					'week'       => $this->language->get('text_week'),
					'semi_month' => $this->language->get('text_semi_month'),
					'month'      => $this->language->get('text_month'),
					'year'       => $this->language->get('text_year'),
				);

				if ($recurring_info['trial_status'] == 1) {
					$price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
					$trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
				} else {
					$trial_text = '';
				}

				$price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);

				if ($recurring_info['duration']) {
					$text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				} else {
					$text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
				}

				$json['success'] = $text;
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}

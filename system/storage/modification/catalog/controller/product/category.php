<?php
class ControllerProductCategory extends Controller {
	public function index() {
		$this->load->language('product/category');

          $this->load->model('module/statistics');
        $this->model_module_statistics->validateTransitions();
      

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		/*Комплекты начало*/
		$this->document->addStyle('catalog/view/theme/default/stylesheet/color_options.css');
        /*Комплекты конец*/

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}


		// OCFilter start
    if (isset($this->request->get['filter_ocfilter'])) {
      $filter_ocfilter = $this->request->get['filter_ocfilter'];
    } else {
      $filter_ocfilter = '';
    }
		// OCFilter end
      

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

		if (isset($this->request->get['path'])) {
//BOF Product Series	
			$pds_show_thumbnails = $this->getData('pds_show_thumbnails', 1);
			
			if($pds_show_thumbnails)
			{
				if(isset($data['products']))
				{
					$pds_list_thumbnail_width = $this->getData('pds_list_thumbnail_width', 20);
					$pds_list_thumbnail_height = $this->getData('pds_list_thumbnail_height', 20);
					$pds_thumbnail_hover_effect = $this->getData('pds_thumbnail_hover_effect', 'rollover');
					
					if($pds_thumbnail_hover_effect == 'rollover')
					{
						$pds_list_hover_width = $this->config->get($this->config->get('config_theme') . '_image_product_width');
						$pds_list_hover_height = $this->config->get($this->config->get('config_theme') . '_image_product_height');
						$pds_list_thumbnail_class = 'pds-thumb-rollover';
					}
					else if($pds_thumbnail_hover_effect == 'preview')
					{
						$pds_list_hover_width = $this->getData('pds_list_preview_width', 200);
						$pds_list_hover_height = $this->getData('pds_list_preview_height', 200);
						$pds_list_thumbnail_class = 'preview';
					}
					else //none
					{
						$pds_list_thumbnail_class = '';
					}
					
					$this->load->model('catalog/product_master');
					$linkedProducts = $this->model_catalog_product_master->getAllLinkedProducts('2'); //2 is Image
					
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
						
						foreach ($linkedProducts as $result) {
							if($result['master_product_id'] == $product['product_id'])
							{
								$product_pds_image = $result['special_attribute_value'] != '' 
								? $this->model_tool_image->resize($result['special_attribute_value'], $pds_list_thumbnail_width, $pds_list_thumbnail_height)
								: $this->model_tool_image->resize($result['image'], $pds_list_thumbnail_width, $pds_list_thumbnail_height);
								
								if($pds_thumbnail_hover_effect == 'rollover' || $pds_thumbnail_hover_effect == 'preview')
								{
									$product_pds_image_hover = $this->model_tool_image->resize($result['image'], $pds_list_hover_width, $pds_list_hover_height);
								}
								else //none
								{
									$product_pds_image_hover = '';
								}
							
								$product['pds'][] = array(
									'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
									'product_name' => $result['product_name'],
									'product_pds_image' => $product_pds_image,
									'product_master_image' => $product['thumb'],
									'product_pds_image_hover' => $product_pds_image_hover,
									'pds_list_thumbnail_class' => $pds_list_thumbnail_class
								);
							}
						}
					}
				}
			}
			else
			{
				if(isset($data['products']))
				{
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
					}
				}
			}
			//EOF Product Series
			$url = '';

				if( ! empty( $this->request->get['mfp'] ) ) {
					$url .= '&mfp=' . $this->request->get['mfp'];
				}
			

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);

				if( isset( $this->request->get['mfp_path'] ) ) {
					$parts = explode('_', (string)$this->request->get['mfp_path']);
				}
			

			$category_id = (int)array_pop($parts);


			foreach ($parts as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);

				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => $this->url->link('product/category', 'path=' . $path . $url)
					);
				}
			}
		} else {
			$category_id = 0;
		}

		$category_info = $this->model_catalog_category->getCategory($category_id);

		if ($category_info) {

			if ($category_info['meta_title']) {
				$this->document->setTitle($category_info['meta_title']);
			} else {
				$this->document->setTitle($category_info['name']);
			}

            $data['product_in_row_class'] = (int) $category_info['product_in_row'] > 0
                ? (12 / (int) $category_info['product_in_row'])
                : false;

			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			if ($category_info['meta_h1']) {
				$data['heading_title'] = $category_info['meta_h1'];
			} else {
				$data['heading_title'] = $category_info['name'];
			}

			$data['text_refine'] = $this->language->get('text_refine');
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'])
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');
			$data['compare'] = $this->url->link('product/compare');

//BOF Product Series	
			$pds_show_thumbnails = $this->getData('pds_show_thumbnails', 1);
			
			if($pds_show_thumbnails)
			{
				if(isset($data['products']))
				{
					$pds_list_thumbnail_width = $this->getData('pds_list_thumbnail_width', 20);
					$pds_list_thumbnail_height = $this->getData('pds_list_thumbnail_height', 20);
					$pds_thumbnail_hover_effect = $this->getData('pds_thumbnail_hover_effect', 'rollover');
					
					if($pds_thumbnail_hover_effect == 'rollover')
					{
						$pds_list_hover_width = $this->config->get($this->config->get('config_theme') . '_image_product_width');
						$pds_list_hover_height = $this->config->get($this->config->get('config_theme') . '_image_product_height');
						$pds_list_thumbnail_class = 'pds-thumb-rollover';
					}
					else if($pds_thumbnail_hover_effect == 'preview')
					{
						$pds_list_hover_width = $this->getData('pds_list_preview_width', 200);
						$pds_list_hover_height = $this->getData('pds_list_preview_height', 200);
						$pds_list_thumbnail_class = 'preview';
					}
					else //none
					{
						$pds_list_thumbnail_class = '';
					}
					
					$this->load->model('catalog/product_master');
					$linkedProducts = $this->model_catalog_product_master->getAllLinkedProducts('2'); //2 is Image
					
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
						
						foreach ($linkedProducts as $result) {
							if($result['master_product_id'] == $product['product_id'])
							{
								$product_pds_image = $result['special_attribute_value'] != '' 
								? $this->model_tool_image->resize($result['special_attribute_value'], $pds_list_thumbnail_width, $pds_list_thumbnail_height)
								: $this->model_tool_image->resize($result['image'], $pds_list_thumbnail_width, $pds_list_thumbnail_height);
								
								if($pds_thumbnail_hover_effect == 'rollover' || $pds_thumbnail_hover_effect == 'preview')
								{
									$product_pds_image_hover = $this->model_tool_image->resize($result['image'], $pds_list_hover_width, $pds_list_hover_height);
								}
								else //none
								{
									$product_pds_image_hover = '';
								}
							
								$product['pds'][] = array(
									'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
									'product_name' => $result['product_name'],
									'product_pds_image' => $product_pds_image,
									'product_master_image' => $product['thumb'],
									'product_pds_image_hover' => $product_pds_image_hover,
									'pds_list_thumbnail_class' => $pds_list_thumbnail_class
								);
							}
						}
					}
				}
			}
			else
			{
				if(isset($data['products']))
				{
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
					}
				}
			}
			//EOF Product Series
			$url = '';

				if( ! empty( $this->request->get['mfp'] ) ) {
					$url .= '&mfp=' . $this->request->get['mfp'];
				}
			

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}


				$fmSettings = $this->config->get('mega_filter_settings');
				
				if( isset( $this->request->get['mfp_path'] ) && false !== ( $mfpPos = strpos( $url, '&mfp=' ) ) ) {
					$mfSt = mb_strpos( $url, '&', $mfpPos+1, 'utf-8');
					$mfp = $mfSt === false ? $url : mb_substr( $url, $mfpPos, $mfSt-1, 'utf-8' );
					$url = $mfSt === false ? '' : mb_substr($url, $mfSt, mb_strlen( $url, 'utf-8' ), 'utf-8');				
					$mfp = preg_replace( '#path(\[[^\]]+\],?|,[^/]+/?)#', '', urldecode( $mfp ) );
					$mfp = preg_replace( '#&mfp=&|&mfp=#', '', $mfp );
					
					if( $mfp ) {
						$url .= '&mfp=' . urlencode( $mfp );
					}
				}
				
				if( ! empty( $fmSettings['not_remember_filter_for_subcategories'] ) && false !== ( $mfpPos = strpos( $url, '&mfp=' ) ) ) {
					$mfUrlBeforeChange = $url;
					$mfSt = mb_strpos( $url, '&', $mfpPos+1, 'utf-8');
					$url = $mfSt === false ? '' : mb_substr($url, $mfSt, mb_strlen( $url, 'utf-8' ), 'utf-8');
				} else if( empty( $fmSettings['not_remember_filter_for_subcategories'] ) && false !== ( $mfpPos = strpos( $url, '&mfp=' ) ) ) {
					$mfUrlBeforeChange = $url;
					$url = preg_replace( '/,?path\[[0-9_]+\]/', '', $url );
				}
			
			$data['categories'] = array();

			$results = $this->model_catalog_category->getCategories($category_id);

			foreach ($results as $result) {
				$filter_data = array(
					'filter_category_id'  => $result['category_id'],
					'filter_sub_category' => true
				);

				$data['categories'][] = array(
					'name' => $result['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
					'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url)
				);
			}


				if( isset( $mfUrlBeforeChange ) ) {
					$url = $mfUrlBeforeChange;
					unset( $mfUrlBeforeChange );
				}
			
			$data['products'] = array();

			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);


				$fmSettings = $this->config->get('mega_filter_settings');
		
				if( ! empty( $fmSettings['show_products_from_subcategories'] ) ) {
					if( ! empty( $fmSettings['level_products_from_subcategories'] ) ) {
						$fmLevel = (int) $fmSettings['level_products_from_subcategories'];
						$fmPath = explode( '_', empty( $this->request->get['path'] ) ? '' : $this->request->get['path'] );

						if( $fmPath && count( $fmPath ) >= $fmLevel ) {
							$filter_data['filter_sub_category'] = '1';
						}
					} else {
						$filter_data['filter_sub_category'] = '1';
					}
				}
				
				if( ! empty( $this->request->get['manufacturer_id'] ) ) {
					$filter_data['filter_manufacturer_id'] = (int) $this->request->get['manufacturer_id'];
				}
			

				$filter_data['mfp_overwrite_path'] = true;
			

  		// OCFilter start
  		$filter_data['filter_ocfilter'] = $filter_ocfilter;
  		// OCFilter end
      
			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			/*Комлекты начало*/
			$this->load->model('catalog/colorkit');
			$data['colors_cfg'] = $this->config->get('color_kit');
            /*Комлекты конец*/

			foreach ($results as $result) {

			/*Комлекты начало*/
			$getColors = $this->model_catalog_colorkit->getColors($result['product_id']);
            $data_colors = array();
            foreach ($getColors as $color) {
                if($color['product_id'] == $result['product_id']) continue;
                    $cp_product_info = $this->model_catalog_product->getProduct($color['product_id']);
                    if($color['tpl'] == 'photos') {
                        $ico_photo = $this->model_tool_image->resize($cp_product_info['image'], $data['colors_cfg']['category_ico_width'], $data['colors_cfg']['category_ico_height']);
                    } else {
                        $ico_photo = false;
                    }

                    if ($cp_product_info['image']) {
                        if ((int) $category_info['product_image_width'] > 0 && (int) $category_info['product_image_height'] > 0) {
                            $cp_image = $this->model_tool_image->resize($cp_product_info['image'], (int) $category_info['product_image_width'], (int) $category_info['product_image_height']);
                        } else {
                            $cp_image = $this->model_tool_image->resize($cp_product_info['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
                        }
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



                $imgFile = $result['image'] ? $result['image'] : 'placeholder.png';

                $image = $this->model_tool_image->resize($imgFile, $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));

                if ((int) $category_info['product_image_width'] > 0 && (int) $category_info['product_image_height'] > 0) {
                    $imageWithCustomSize = $this->model_tool_image->resize($imgFile, (int) $category_info['product_image_width'], (int) $category_info['product_image_height']);
                }

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					 	$tmp_query = $this->db->query("SELECT min(special) as newprice FROM " . DB_PREFIX . "product_option_value WHERE special > 0 AND product_id = '" . (int)$result['product_id'] . "'");
					 	if ($tmp_query->num_rows) {
					 		$result['newprice'] = $tmp_query->row['newprice'];
					 	}
					$newprice = $this->currency->format($this->tax->calculate($result['newprice'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
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

				$options= array();
                foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
                    $product_option_value_data = array();
                    foreach ($option['product_option_value'] as $option_value) {
                        if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                            if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                                $oprice = $this->currency->format($this->tax->calculate($option_value['price'], $result['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
                            } else {
                                $oprice = false;
                            }

                            $product_option_value_data[] = array(
                                'product_option_value_id' => $option_value['product_option_value_id'],
                                'option_value_id'         => $option_value['option_value_id'],
                                'name'                    => $option_value['name'],
                                'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
                                'price'                   => $oprice,
								'special'				  => $option_value['special'],
                                'price_prefix'            => $option_value['price_prefix']
                            );
                        }
                    }
                    $options[] = array(
                        'product_option_id'    => $option['product_option_id'],
                        'product_option_value' => $product_option_value_data,
                        'option_id'            => $option['option_id'],
                        'name'                 => $option['name'],
                        'type'                 => $option['type'],
                        'value'                => $option['value'],
                        'required'             => $option['required']
                    );
                }

				$data['products'][] = array(
					'options'     => $options,
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'custom_thumb'       => isset($imageWithCustomSize) ? $imageWithCustomSize : '',
					/*Комлекты начало*/
					'colors'      => $data_colors,
					/*Комлекты конец*/
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'newprice'    => $newprice,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => ($result['minimum'] > 0) ? $result['minimum'] : 1,
					'rating'      => $rating,
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
				);
			}

//BOF Product Series	
			$pds_show_thumbnails = $this->getData('pds_show_thumbnails', 1);
			
			if($pds_show_thumbnails)
			{
				if(isset($data['products']))
				{
					$pds_list_thumbnail_width = $this->getData('pds_list_thumbnail_width', 20);
					$pds_list_thumbnail_height = $this->getData('pds_list_thumbnail_height', 20);
					$pds_thumbnail_hover_effect = $this->getData('pds_thumbnail_hover_effect', 'rollover');
					
					if($pds_thumbnail_hover_effect == 'rollover')
					{
						$pds_list_hover_width = $this->config->get($this->config->get('config_theme') . '_image_product_width');
						$pds_list_hover_height = $this->config->get($this->config->get('config_theme') . '_image_product_height');
						$pds_list_thumbnail_class = 'pds-thumb-rollover';
					}
					else if($pds_thumbnail_hover_effect == 'preview')
					{
						$pds_list_hover_width = $this->getData('pds_list_preview_width', 200);
						$pds_list_hover_height = $this->getData('pds_list_preview_height', 200);
						$pds_list_thumbnail_class = 'preview';
					}
					else //none
					{
						$pds_list_thumbnail_class = '';
					}
					
					$this->load->model('catalog/product_master');
					$linkedProducts = $this->model_catalog_product_master->getAllLinkedProducts('2'); //2 is Image
					
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
						
						foreach ($linkedProducts as $result) {
							if($result['master_product_id'] == $product['product_id'])
							{
								$product_pds_image = $result['special_attribute_value'] != '' 
								? $this->model_tool_image->resize($result['special_attribute_value'], $pds_list_thumbnail_width, $pds_list_thumbnail_height)
								: $this->model_tool_image->resize($result['image'], $pds_list_thumbnail_width, $pds_list_thumbnail_height);
								
								if($pds_thumbnail_hover_effect == 'rollover' || $pds_thumbnail_hover_effect == 'preview')
								{
									$product_pds_image_hover = $this->model_tool_image->resize($result['image'], $pds_list_hover_width, $pds_list_hover_height);
								}
								else //none
								{
									$product_pds_image_hover = '';
								}
							
								$product['pds'][] = array(
									'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
									'product_name' => $result['product_name'],
									'product_pds_image' => $product_pds_image,
									'product_master_image' => $product['thumb'],
									'product_pds_image_hover' => $product_pds_image_hover,
									'pds_list_thumbnail_class' => $pds_list_thumbnail_class
								);
							}
						}
					}
				}
			}
			else
			{
				if(isset($data['products']))
				{
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
					}
				}
			}
			//EOF Product Series
			$url = '';

				if( ! empty( $this->request->get['mfp'] ) ) {
					$url .= '&mfp=' . $this->request->get['mfp'];
				}
			


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
			);

//BOF Product Series	
			$pds_show_thumbnails = $this->getData('pds_show_thumbnails', 1);
			
			if($pds_show_thumbnails)
			{
				if(isset($data['products']))
				{
					$pds_list_thumbnail_width = $this->getData('pds_list_thumbnail_width', 20);
					$pds_list_thumbnail_height = $this->getData('pds_list_thumbnail_height', 20);
					$pds_thumbnail_hover_effect = $this->getData('pds_thumbnail_hover_effect', 'rollover');
					
					if($pds_thumbnail_hover_effect == 'rollover')
					{
						$pds_list_hover_width = $this->config->get($this->config->get('config_theme') . '_image_product_width');
						$pds_list_hover_height = $this->config->get($this->config->get('config_theme') . '_image_product_height');
						$pds_list_thumbnail_class = 'pds-thumb-rollover';
					}
					else if($pds_thumbnail_hover_effect == 'preview')
					{
						$pds_list_hover_width = $this->getData('pds_list_preview_width', 200);
						$pds_list_hover_height = $this->getData('pds_list_preview_height', 200);
						$pds_list_thumbnail_class = 'preview';
					}
					else //none
					{
						$pds_list_thumbnail_class = '';
					}
					
					$this->load->model('catalog/product_master');
					$linkedProducts = $this->model_catalog_product_master->getAllLinkedProducts('2'); //2 is Image
					
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
						
						foreach ($linkedProducts as $result) {
							if($result['master_product_id'] == $product['product_id'])
							{
								$product_pds_image = $result['special_attribute_value'] != '' 
								? $this->model_tool_image->resize($result['special_attribute_value'], $pds_list_thumbnail_width, $pds_list_thumbnail_height)
								: $this->model_tool_image->resize($result['image'], $pds_list_thumbnail_width, $pds_list_thumbnail_height);
								
								if($pds_thumbnail_hover_effect == 'rollover' || $pds_thumbnail_hover_effect == 'preview')
								{
									$product_pds_image_hover = $this->model_tool_image->resize($result['image'], $pds_list_hover_width, $pds_list_hover_height);
								}
								else //none
								{
									$product_pds_image_hover = '';
								}
							
								$product['pds'][] = array(
									'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
									'product_name' => $result['product_name'],
									'product_pds_image' => $product_pds_image,
									'product_master_image' => $product['thumb'],
									'product_pds_image_hover' => $product_pds_image_hover,
									'pds_list_thumbnail_class' => $pds_list_thumbnail_class
								);
							}
						}
					}
				}
			}
			else
			{
				if(isset($data['products']))
				{
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
					}
				}
			}
			//EOF Product Series
			$url = '';

				if( ! empty( $this->request->get['mfp'] ) ) {
					$url .= '&mfp=' . $this->request->get['mfp'];
				}
			


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 40, 60, 80, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value)
				);
			}

//BOF Product Series	
			$pds_show_thumbnails = $this->getData('pds_show_thumbnails', 1);
			
			if($pds_show_thumbnails)
			{
				if(isset($data['products']))
				{
					$pds_list_thumbnail_width = $this->getData('pds_list_thumbnail_width', 20);
					$pds_list_thumbnail_height = $this->getData('pds_list_thumbnail_height', 20);
					$pds_thumbnail_hover_effect = $this->getData('pds_thumbnail_hover_effect', 'rollover');
					
					if($pds_thumbnail_hover_effect == 'rollover')
					{
						$pds_list_hover_width = $this->config->get($this->config->get('config_theme') . '_image_product_width');
						$pds_list_hover_height = $this->config->get($this->config->get('config_theme') . '_image_product_height');
						$pds_list_thumbnail_class = 'pds-thumb-rollover';
					}
					else if($pds_thumbnail_hover_effect == 'preview')
					{
						$pds_list_hover_width = $this->getData('pds_list_preview_width', 200);
						$pds_list_hover_height = $this->getData('pds_list_preview_height', 200);
						$pds_list_thumbnail_class = 'preview';
					}
					else //none
					{
						$pds_list_thumbnail_class = '';
					}
					
					$this->load->model('catalog/product_master');
					$linkedProducts = $this->model_catalog_product_master->getAllLinkedProducts('2'); //2 is Image
					
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
						
						foreach ($linkedProducts as $result) {
							if($result['master_product_id'] == $product['product_id'])
							{
								$product_pds_image = $result['special_attribute_value'] != '' 
								? $this->model_tool_image->resize($result['special_attribute_value'], $pds_list_thumbnail_width, $pds_list_thumbnail_height)
								: $this->model_tool_image->resize($result['image'], $pds_list_thumbnail_width, $pds_list_thumbnail_height);
								
								if($pds_thumbnail_hover_effect == 'rollover' || $pds_thumbnail_hover_effect == 'preview')
								{
									$product_pds_image_hover = $this->model_tool_image->resize($result['image'], $pds_list_hover_width, $pds_list_hover_height);
								}
								else //none
								{
									$product_pds_image_hover = '';
								}
							
								$product['pds'][] = array(
									'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
									'product_name' => $result['product_name'],
									'product_pds_image' => $product_pds_image,
									'product_master_image' => $product['thumb'],
									'product_pds_image_hover' => $product_pds_image_hover,
									'pds_list_thumbnail_class' => $pds_list_thumbnail_class
								);
							}
						}
					}
				}
			}
			else
			{
				if(isset($data['products']))
				{
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
					}
				}
			}
			//EOF Product Series
			$url = '';

				if( ! empty( $this->request->get['mfp'] ) ) {
					$url .= '&mfp=' . $this->request->get['mfp'];
				}
			


      // OCFilter start
			if (isset($this->request->get['filter_ocfilter'])) {
				$url .= '&filter_ocfilter=' . $this->request->get['filter_ocfilter'];
			}
      // OCFilter end
      
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}');

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    
				if( ! empty( $this->request->get['mfp_seo_alias'] ) ) {
					$this->document->addLink( rtrim( $this->url->link('product/category', 'path=' . $category_info['category_id'], true), '/' ) . '/' . $this->request->get['mfp_seo_alias'], 'canonical');
				} else {
					$this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'canonical');
				}
			
			} elseif ($page == 2) {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'], true), 'prev');
			} else {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page - 1), true), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    $this->document->addLink($this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page + 1), true), 'next');
			}

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

      // OCFilter Start
      $ocfilter_page_info = $this->load->controller('extension/module/ocfilter/getPageInfo');

      if ($ocfilter_page_info) {
        $this->document->setTitle($ocfilter_page_info['meta_title']);

        if ($ocfilter_page_info['meta_description']) {
			    $this->document->setDescription($ocfilter_page_info['meta_description']);
        }

        if ($ocfilter_page_info['meta_keyword']) {
			    $this->document->setKeywords($ocfilter_page_info['meta_keyword']);
        }

			  $data['heading_title'] = $ocfilter_page_info['title'];

        if ($ocfilter_page_info['description'] && !isset($this->request->get['page']) && !isset($this->request->get['sort']) && !isset($this->request->get['order']) && !isset($this->request->get['search']) && !isset($this->request->get['limit'])) {
        	$data['description'] = html_entity_decode($ocfilter_page_info['description'], ENT_QUOTES, 'UTF-8');
        }
      } else {
        $meta_title = $this->document->getTitle();
        $meta_description = $this->document->getDescription();
        $meta_keyword = $this->document->getKeywords();

        $filter_title = $this->load->controller('extension/module/ocfilter/getSelectedsFilterTitle');

        if ($filter_title) {
          if (false !== strpos($meta_title, '{filter}')) {
            $meta_title = trim(str_replace('{filter}', $filter_title, $meta_title));
          } else {
            $meta_title .= ' ' . $filter_title;
          }

          $this->document->setTitle($meta_title);

          if ($meta_description) {
            if (false !== strpos($meta_description, '{filter}')) {
              $meta_description = trim(str_replace('{filter}', $filter_title, $meta_description));
            } else {
              $meta_description .= ' ' . $filter_title;
            }

  			    $this->document->setDescription($meta_description);
          }

          if ($meta_keyword) {
            if (false !== strpos($meta_keyword, '{filter}')) {
              $meta_keyword = trim(str_replace('{filter}', $filter_title, $meta_keyword));
            } else {
              $meta_keyword .= ' ' . $filter_title;
            }

           	$this->document->setKeywords($meta_keyword);
          }

          $heading_title = $data['heading_title'];

          if (false !== strpos($heading_title, '{filter}')) {
            $heading_title = trim(str_replace('{filter}', $filter_title, $heading_title));
          } else {
            $heading_title .= ' ' . $filter_title;
          }

          $data['heading_title'] = $heading_title;

          $data['description'] = '';
        } else {
          $this->document->setTitle(trim(str_replace('{filter}', '', $meta_title)));
          $this->document->setDescription(trim(str_replace('{filter}', '', $meta_description)));
          $this->document->setKeywords(trim(str_replace('{filter}', '', $meta_keyword)));

          $data['heading_title'] = trim(str_replace('{filter}', '', $data['heading_title']));
        }
      }
      // OCFilter End
      

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');


				$this->load->model( 'module/mega_filter' );
				
				$data = $this->model_module_mega_filter->prepareData( $data );
			
			$this->response->setOutput($this->load->view('product/category', $data));
		} else {
//BOF Product Series	
			$pds_show_thumbnails = $this->getData('pds_show_thumbnails', 1);
			
			if($pds_show_thumbnails)
			{
				if(isset($data['products']))
				{
					$pds_list_thumbnail_width = $this->getData('pds_list_thumbnail_width', 20);
					$pds_list_thumbnail_height = $this->getData('pds_list_thumbnail_height', 20);
					$pds_thumbnail_hover_effect = $this->getData('pds_thumbnail_hover_effect', 'rollover');
					
					if($pds_thumbnail_hover_effect == 'rollover')
					{
						$pds_list_hover_width = $this->config->get($this->config->get('config_theme') . '_image_product_width');
						$pds_list_hover_height = $this->config->get($this->config->get('config_theme') . '_image_product_height');
						$pds_list_thumbnail_class = 'pds-thumb-rollover';
					}
					else if($pds_thumbnail_hover_effect == 'preview')
					{
						$pds_list_hover_width = $this->getData('pds_list_preview_width', 200);
						$pds_list_hover_height = $this->getData('pds_list_preview_height', 200);
						$pds_list_thumbnail_class = 'preview';
					}
					else //none
					{
						$pds_list_thumbnail_class = '';
					}
					
					$this->load->model('catalog/product_master');
					$linkedProducts = $this->model_catalog_product_master->getAllLinkedProducts('2'); //2 is Image
					
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
						
						foreach ($linkedProducts as $result) {
							if($result['master_product_id'] == $product['product_id'])
							{
								$product_pds_image = $result['special_attribute_value'] != '' 
								? $this->model_tool_image->resize($result['special_attribute_value'], $pds_list_thumbnail_width, $pds_list_thumbnail_height)
								: $this->model_tool_image->resize($result['image'], $pds_list_thumbnail_width, $pds_list_thumbnail_height);
								
								if($pds_thumbnail_hover_effect == 'rollover' || $pds_thumbnail_hover_effect == 'preview')
								{
									$product_pds_image_hover = $this->model_tool_image->resize($result['image'], $pds_list_hover_width, $pds_list_hover_height);
								}
								else //none
								{
									$product_pds_image_hover = '';
								}
							
								$product['pds'][] = array(
									'product_link' => $this->url->link('product/product', $url . '&product_id=' . $result['product_id']),
									'product_name' => $result['product_name'],
									'product_pds_image' => $product_pds_image,
									'product_master_image' => $product['thumb'],
									'product_pds_image_hover' => $product_pds_image_hover,
									'pds_list_thumbnail_class' => $pds_list_thumbnail_class
								);
							}
						}
					}
				}
			}
			else
			{
				if(isset($data['products']))
				{
					foreach ($data['products'] as &$product) //& is for reference
					{
						$product['pds'] = array();
					}
				}
			}
			//EOF Product Series
			$url = '';

				if( ! empty( $this->request->get['mfp'] ) ) {
					$url .= '&mfp=' . $this->request->get['mfp'];
				}
			

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
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
				'href' => $this->url->link('product/category', $url)
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


				$this->load->model( 'module/mega_filter' );
				
				$data = $this->model_module_mega_filter->prepareData( $data );
			
			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}
}

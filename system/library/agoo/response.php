<?php
class agooResponse extends Controller
{
	protected $response_old;
	protected $sc_data;
	protected $agooheaders = array();
	protected $header_flag_octet_stream = false;
	protected $header_flag_json = false;
	protected $sc_cache_name = '';

	public function __call($name, array $params) {

		//$enter_mem = memory_get_peak_usage();
        $cache_output = $this->registry->get('jetcache_output');

		if ($this->registry->get('returnResponseSetOutput') && strtolower($name) == 'setoutput') {
			$this->registry->set('returnResponseSetOutput', $params[0]);
			return;
		}
		if ($this->config->get('ascp_settings') != '') {
			$this->sc_data['settings_general'] = $this->config->get('ascp_settings');
		} else {
			$this->sc_data['settings_general'] = Array();
		}

		if (strtolower($name) == 'addheader') {
			$this->agooheaders[] = $params[0];
			if (is_string($params[0]) && strpos(strtolower($params[0]), '/octet-stream') !== false) {
            	$this->header_flag_octet_stream = true;
			}

			if (is_string($params[0]) && strpos(strtolower($params[0]), '/json') !== false) {
            	$this->header_flag_json = true;
			}

		}

		$modules = false;

        if (!$cache_output) {

			if (isset($params[0]) && is_string($params[0])) {
				if (!$this->registry->get('admin_work')) {
					if (strtolower($name) == 'setoutput') {
						$params[0] = $this->set_sitemap($params[0]);
					}

					$params[0] = $this->set_og_page($params[0]);
					$params[0] = $this->set_hreflang($params[0]);

						$this->cont('record/pagination');
						$params[0] = $this->controller_record_pagination->setPagination($params[0]);
						unset($this->controller_record_pagintation);
				}
				if ($this->registry->get('admin_work') && isset($this->sc_data['settings_general']['menu_admin_status']) && $this->sc_data['settings_general']['menu_admin_status']) {
					if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
					} else {
						if (strtolower($name) == 'setoutput' && $this->cont('catalog/seocms')) {
							$admin_html = $this->controller_catalog_seocms->index();
							$find       = array(
								'</body>'
							);
							$replace    = array(
								$admin_html . '</body>'
							);

							if (!$this->header_flag_octet_stream) {
								if (!isset($params[0][11000000])) {
									$params[0]  = str_replace($find, $replace, $params[0]);
								}
							}
						}
					}
				}
			}

        }

        if (!$this->registry->get('admin_work') && isset($params[0])) {
        	$params[0] = $this->jetcache_info($params[0], $name);
        }


		$this->registry->set('response_work', true);
		$this->response_old = $this->registry->get('response_old');
		$modules = call_user_func_array(array(
			$this->response_old,
			$name
		), $params);

		// low memory consumption
		// print_my(memory_get_peak_usage() - $enter_mem);

        if (!$cache_output && !$this->registry->get('admin_work')) {
            $this->jetcache_to_cache($name);
        }

        unset($this->response_old);
        unset($params);
        unset($cache_output);

        $this->registry->set('response_work', false);

		return $modules;
	}


	private function jetcache_info($params, $name) {

        if (isset($this->sc_data['settings_general']['jetcache_widget_status']) && $this->sc_data['settings_general']['jetcache_widget_status']) {
	        $jetcache_settings = $this->registry->get('config')->get('asc_jetcache_settings');
	       	if (($this->registry->get('sc_isLogged') && isset($jetcache_settings['jetcache_info_status']) && $jetcache_settings['jetcache_info_status']) || (isset($jetcache_settings['jetcache_info_demo_status']) && $jetcache_settings['jetcache_info_demo_status']) ) {

				if (is_array($this->registry->get('jetcache_output_visual'))) {

			        	$time_visual = $this->registry->get('jetcache_output_visual');

			           	agoo_cont('jetcache/jetcache', $this->registry);
						$visual_html = $this->controller_jetcache_jetcache->visual($time_visual);
						$visual_find = array('</body>');
						$visual_replace = array($visual_html. '</body>');

						if (strtolower($name) == 'setoutput') {
							$params = str_replace($visual_find, $visual_replace, $params);
						}
				} else {
		                $time_visual['start'] = $this->registry->get('sc_time_start');
		                $time_visual['end'] = microtime(true);
		                $time_visual['load'] = round($time_visual['end'] - $time_visual['start'], 3);

		                $time_visual['queries'] = $this->db->get_sc_jetcache_query_count();

			           	agoo_cont('jetcache/jetcache', $this->registry);
						$visual_html = $this->controller_jetcache_jetcache->visual($time_visual);
						$visual_find = array('</body>');
						$visual_replace = array($visual_html. '</body>');

						if (strtolower($name) == 'setoutput') {
							$params = str_replace($visual_find, $visual_replace, $params);
						}
				}
			}
        }
        return $params;

	}



	private function jetcache_to_cache($name) {

			if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
				$this->sc_data['settings_general']['jetcache_widget_status'] = false;
			}

			if ((isset($this->sc_data['settings_general']['jetcache_widget_status']) && $this->sc_data['settings_general']['jetcache_widget_status']) || ($this->registry->get('blog_output') && isset($this->sc_data['settings_general']['cache_pages']) && $this->sc_data['settings_general']['cache_pages'])) {

	  			if ((isset($this->sc_data['settings_general']['jetcache_widget_status']) && $this->sc_data['settings_general']['jetcache_widget_status'] && strtolower($name) == 'setoutput') || strtolower($name) == 'output') {
                  if (!$this->header_flag_json && !$this->registry->get('admin_work')) {

						if ($this->registry->get('url_old')) {
							$url = $this->registry->get('response_old');
							$class = get_class($url);
						} else {
							$url = $this->url;
							$class = get_class($url);
						}

						$reflection = new ReflectionClass($class);
						$priv_attr  = $reflection->getProperties(ReflectionProperty::IS_PRIVATE);

                        $property = 'output';
		                if ($reflection->hasProperty($property)) {
							$reflectionProperty = $reflection->getProperty($property);
							$reflectionProperty->setAccessible(true);
							$data_private = $reflectionProperty->getValue($url);
	                        $cache_output = $data_private;
		                    unset($data_private);
		                    unset($reflectionProperty);
						}

						$property = 'headers';
		                if ($reflection->hasProperty($property)) {
							$reflectionProperty = $reflection->getProperty($property);
							$reflectionProperty->setAccessible(true);
							$data_private = $reflectionProperty->getValue($url);
	                        $cache_headers = $data_private;
		                    unset($data_private);
		                    unset($reflectionProperty);
						}

	                    unset($url);
	                    unset($reflection);
	                    unset($priv_attr);
	                    unset($class);

					//for cache
					if (!$this->config->get('blog_work')) {
						$this->config->set('blog_work', true);
						$off_blog_work = true;
					} else {
						$off_blog_work = false;
					}

                    if (is_string($cache_output) && $cache_output != '') {
						$this->sc_set_cache_name();

                        $sc_time_end = microtime(true);
						$cache['time'] = $sc_time_end - $this->registry->get('sc_time_start');

				        if (is_callable(array('DB', 'get_sc_jetcache_query_count'))) {
				        	$cache['queries'] = $this->db->get_sc_jetcache_query_count();
				        } else {
				        	$cache['queries'] = '';
				        }
                        $cache['headers'] = $cache_headers;
						$cache['output'] = $cache_output;


                        $this->cache->set($this->sc_cache_name, $cache);
					}

					if ($off_blog_work) {
						$this->config->set('blog_work', false);
					}
					$this->registry->set('jetcache_response_set_cache', true);

				}
              }
			}

	}


	private function set_sitemap($params) {
		if ($this->config->get('google_sitemap_blog_status')) {
			if ($this->config->get('ascp_settings_sitemap') != '') {
				$data['ascp_settings_sitemap'] = $this->config->get('ascp_settings_sitemap');
			} else {
				$data['ascp_settings_sitemap'] = Array();
			}
			if (isset($data['ascp_settings_sitemap']['google_sitemap_blog_inter_status']) && $data['ascp_settings_sitemap']['google_sitemap_blog_inter_status']) {
				if (isset($this->request->get['route'])) {
					$data['route'] = $this->request->get['route'];
				} else {
					$data['route'] = false;
				}
				if (isset($data['ascp_settings_sitemap']['google_sitemap_blog_inter_route']) && $data['ascp_settings_sitemap']['google_sitemap_blog_inter_route'] != '' && $data['ascp_settings_sitemap']['google_sitemap_blog_inter_route'] == $data['route'] && $data['route'] != 'record/google_sitemap_blog') {
					if (isset($data['ascp_settings_sitemap']['google_sitemap_blog_inter_tag']) && $data['ascp_settings_sitemap']['google_sitemap_blog_inter_tag'] != '') {
						$google_sitemap_blog_inter_tag = html_entity_decode($data['ascp_settings_sitemap']['google_sitemap_blog_inter_tag'], ENT_QUOTES, 'UTF-8');
						if (strpos($params, $google_sitemap_blog_inter_tag) === false) {
						} else {
							if ($this->cont('record/google_sitemap_blog')) {
								$sitemap_html = $this->controller_record_google_sitemap_blog->getascp();
								$find         = array(
									$google_sitemap_blog_inter_tag
								);
								$replace      = array(
									$sitemap_html . $google_sitemap_blog_inter_tag
								);
								$params       = str_replace($find, $replace, $params);
							}
						}
					}
				}
			}
		}
		return $params;
	}

	private function set_hreflang($params) {
		if (isset($params) && !$this->registry->get('admin_work')) {
			if (is_string($params) && strpos($params, '<link rel="alternate"') === false && method_exists($this->document, 'getHreflang')) {
				$sc_hreflang = $this->document->getHreflang();
				if ($sc_hreflang && !empty($sc_hreflang)) {
					foreach ($sc_hreflang as $sc_hreflang_code => $sc_hreflang_array) {
						$params = str_replace("</head>", '
<link rel="alternate" hreflang="' . $sc_hreflang_array['hreflang'] . '" href="' . $sc_hreflang_array['href'] . '" />
</head>', $params);
					}
				}
			}
		}
		return $params;
	}

	private function set_og_page($params) {
		if (isset($params) && !$this->registry->get('admin_work')) {
			if (isset($this->request->get['route']) && ($this->request->get['route'] == 'record/record' || $this->request->get['route'] == 'record/blog')) {

				if (is_string($params) && strpos($params, '<meta name="robots"') === false && method_exists($this->document, 'getSCRobots')) {
					$sc_robots = $this->document->getSCRobots();
					if ($sc_robots && $sc_robots != '')
						$params = str_replace("</head>", '
<meta name="robots" content="' . $sc_robots . '" />
</head>', $params);
				}
				if (isset($this->sc_data['settings_general']['og']) && $this->sc_data['settings_general']['og']) {
					if (is_string($params) && strpos($params, "og:image") === false && method_exists($this->document, 'getOgImage')) {
						$og_image = $this->document->getOgImage();
						if ($og_image && $og_image != '')
							$params = str_replace("</head>", '
<meta property="og:image" content="' . $og_image . '" />
</head>', $params);
					}
					if (is_string($params) && strpos($params, "og:title") === false && method_exists($this->document, 'getOgTitle')) {
						$og_title = $this->document->getOgTitle();
						if ($og_title && $og_title != '')
							$params = str_replace("</head>", '
<meta property="og:title" content="' . $og_title . '" />
</head>', $params);
					}
					if (is_string($params) && strpos($params, "og:description") === false && method_exists($this->document, 'getOgDescription')) {
						$og_description = $this->document->getOgDescription();
						if ($og_description && $og_description != '')
							$params = str_replace("</head>", '
<meta property="og:description" content="' . $og_description . '" />
</head>', $params);
					}
					if (is_string($params) && strpos($params, "og:url") === false && method_exists($this->document, 'getOgUrl')) {
						$og_url = $this->document->getOgUrl();
						if ($og_url && $og_url != '')
							$params = str_replace("</head>", '
<meta property="og:url" content="' . $og_url . '" />
</head>', $params);
					}
					if (is_string($params) && strpos($params, "og:type") === false && method_exists($this->document, 'getOgType')) {
						$og_type = $this->document->getOgType();
						if ($og_type && $og_type != '')
							$params = str_replace("</head>", '
<meta property="og:type" content="' . $og_type . '" />
</head>', $params);
					}
				}
			}
		}
		return $params;
	}


	public function getSCOutput() {
		return $this->output;
	}

	public function getSCHeaders() {
		return $this->agooheaders;
	}

	private function cont($cont) {
		$file  = DIR_APPLICATION . 'controller/' . $cont . '.php';
		$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
		if (file_exists($file)) {
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
			return true;
		} else {
			return false;
		}
	}

	private function sc_set_cache_name($type = 'pages', $cont_route = '') {
        $jetcache_settings = $this->registry->get('config')->get('asc_jetcache_settings');
		if (isset($this->session->data)) {
			$session = $this->session->data;
		} else {
			$session = array();
		}
		if (isset($session['token'])) {
			unset($session['token']);
		}
		if (isset($session['captcha'])) {
			unset($session['captcha']);
		}

        if (SC_VERSION > 15) {
        	$data_cache['cart'] = $this->cart->getProducts();
        }
		$data_cache['session'] = $session;
		$data_cache['url'] = $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
		$data_cache['post'] = $this->request->post;
		$data_cache['get'] = $this->request->get;
        unset($data_cache['get']['_route_']);
		$hash = md5(json_encode($data_cache));

		$route_name = $this->config->get('config_language_id').'_'.$this->config->get('config_store_id');
		if (isset($this->request->get['route'])) {
			$route_name .= '_'.str_replace('/', '_', $this->request->get['route']);
		}

		unset($data_cache);

		if (isset($jetcache_settings[$type.'_db_status']) && $jetcache_settings[$type.'_db_status']) {
        	$this->sc_cache_name  = 'blog.db.'.$type.'.'.$hash.'.'. $cont_route. $route_name;
		} else {
        	$this->sc_cache_name = 'blog.jetcache_'.$type.'_'.$route_name.$cont_route.'.' . $hash;
		}

		return $this->sc_cache_name;
	}


}

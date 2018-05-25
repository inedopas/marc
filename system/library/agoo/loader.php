<?php
class agooLoader extends Controller
{
	protected $Loader;
	protected $sc_force_cache = false;
	protected $sc_force_cache_no_access = false;
	protected $sc_cache_name = '';
	protected $seocms_settings;
	protected $jetcache_settings;


	public function __call($name, array $params) {
		$this->registry->set('loader_work', true);

        $this->seocms_settings = $this->registry->get('config')->get('ascp_settings');

		if (
			isset($this->seocms_settings['latest_widget_status']) && $this->seocms_settings['latest_widget_status'] &&
			$this->registry->get('seocms_url_alter') &&
			!class_exists('ControllerCommonSeoBlog') &&
			(class_exists('ControllerCommonSeoUrl') ||
			 class_exists('ControllerCommonSeoPro') ||
			 class_exists('ControllerStartupSeoUrl') ||
			 class_exists('ControllerStartupSeoPro'))
			 && !$this->registry->get('admin_work')
             && !$this->config->get('sc_ar_'.strtolower('ControllerCommonSeoBlog'))
			 ) {
			agoo_cont('record/addrewrite', $this->registry);
			$this->controller_record_addrewrite->add_construct($this->registry);
		}

		if (isset($this->seocms_settings['jetcache_widget_status']) && $this->seocms_settings['jetcache_widget_status']) {
			$this->jetcache_settings = $this->registry->get('config')->get('asc_jetcache_settings');
		}

        if ((!$this->sc_force_cache_no_access && !$this->sc_force_cache) && !$this->registry->get('admin_work')) {
			$this->sc_force_cache_output();
		}

        unset($this->seocms_settings);

		$flag    = false;
		$modules = NULL;

		if ($name == 'library') {

  			$name_agoo = str_replace('agoo/', '', $params[0]);

            $file = DIR_SYSTEM . 'library/agoo/' . $name_agoo . '.php';

            if (function_exists('modification')) {
        		$file = modification($file);
        	}

			if (file_exists($file)) {

				if (SC_VERSION < 20) {
                	include_once($file);
				} else {
					require_once($file);
				}

				if (SC_VERSION > 21) {
					$route = preg_replace('/[^a-zA-Z0-9_\/]/', '', (string)$name_agoo);
					$class = str_replace('/', '', $params[0]);
					$this->registry->set(basename($route), new $class($this->registry));
				}

				$flag = true;

			} else {

				if (!is_callable(array('Loader', 'library'))) {
					$file = DIR_SYSTEM . 'library/' . $params[0] . '.php';
		            if (function_exists('modification')) {
		        		$file = modification($file);
		        	}

					if (file_exists($file)) {

						if (SC_VERSION < 20) {
		                	include_once($file);
						} else {
							require_once($file);
						}

						if (SC_VERSION > 21) {
							$route = preg_replace('/[^a-zA-Z0-9_\/]/', '', (string)$params[0]);
							$class = str_replace('/', '\\', $route);
							$this->registry->set(basename($route), new $class($this->registry));
						}

  						$flag = true;
					}
				}
			}
		}
		if ($name == 'helper') {
			$file = DIR_SYSTEM . 'helper/agoo/' . $params[0] . '.php';
            if (function_exists('modification')) {
        		$file = modification($file);
        	}
			if (file_exists($file)) {
				$params[0] = 'agoo/' . $params[0];
				$flag      = true;
			}
		}
		if ($name == 'model') {
			$file = DIR_APPLICATION . 'model/agoo/' . $params[0] . '.php';
            if (function_exists('modification')) {
        		$file = modification($file);
        	}

			if (file_exists($file) || isset($params[1])) {
				$flag = true;
				if (isset($params[1])) {
					if (isset($params[2])) {
						$this->agoomodel($params[0], $params[1], $params[2]);
					} else {
						$this->agoomodel($params[0], $params[1]);
					}
				} else {
					$this->agoomodel($params[0]);
				}
			}
		}
		if (SC_VERSION > 15) {
			if ($name == 'controller' && !$this->registry->get('admin_work')) {


				if ($this->jetcache_cont_access($params)) {
	                // From cache Controller
                    $cache_from = $this->jetcache_cont_from_cache($params[0]);

                    if ($cache_from) {
                    	return $cache_from;
                    }

				}

				$asc_replacecontroller = $this->registry->get('asc_replacecontroller');
				if (!empty($asc_replacecontroller)) {
					foreach ($asc_replacecontroller as $replace_controller_key => $replace_controller) {
						list($key_replace_controller, $value_replace_controller) = each($replace_controller);
						if ($params[0] == $key_replace_controller) {
							if (!isset($params[1])) {
								$modules = $this->load->controller($value_replace_controller);
							} else {
								$modules = $this->load->controller($value_replace_controller, $params[1]);
							}
							$this->registry->set('loader_work', false);
							return $modules;
						}
					}
				}
				if ($this->registry->get('returnResponseSetOutput')) {
					if ($params[0] == 'common/column_left' || $params[0] == 'common/column_right' || $params[0] == 'common/content_top' || $params[0] == 'common/content_bottom' || $params[0] == 'common/footer' || $params[0] == 'common/header') {
						return '';
					}
				}
			}
			if ($name == 'view' && !$this->registry->get('admin_work')) {
				if (SC_VERSION > 21) {
					if (strpos($params[0], 'agootemplates/') !== false) {
					    $params[0] = str_replace('default/template', '', $params[0]);
						$params[0] = str_replace($this->registry->get('theme_directory') . '/template', '', $params[0]);
					}
				}
				$asc_replacedata = $this->registry->get('asc_replacedata');
				if (!empty($asc_replacedata)) {
					foreach ($asc_replacedata as $replace_data_key => $replace_data) {
						list($key_replace_data, $value_replace_data) = each($replace_data);

						if ($key_replace_data != '') {
							if (SC_VERSION > 21) {
								$pos = stripos($key_replace_data, $params[0]);
							} else {
	                          	$pos = stripos($params[0], $key_replace_data);
							}
						} else {
							$pos = true;
						}
						if ($key_replace_data == '' || $pos !== false) {
							$params[1] = $this->replacedatamethod($params[1], $key_replace_data, $value_replace_data);
							if ($key_replace_data != '') {
								unset($asc_replacedata[$replace_data_key]);
								$this->registry->set('asc_replacedata', $asc_replacedata);
							}
						}
					}
				}
			}
		}
		if (!$flag) {

			$this_loader = $this->registry->get('load');
			if (!$this->registry->get('loader_work')) {
				$this->Loader = $this->registry->get('load_old');
			} else {
				$this->Loader = new Loader($this->registry);
			}
			if ($name == 'library' && !is_callable(array('Loader', 'library'))) {
				$flag = true;
			}

			if (!$flag) {

				$modules = call_user_func_array(array(
					$this->Loader,
					$name
				), $params);

				if ($name == 'controller' && !$this->registry->get('admin_work')) {
	    			if ($this->jetcache_cont_access($params)) {
						// To cache Controller
       					$this->jetcache_cont_to_cache($modules, $params[0]);
					}
			   	}
			}

			$this->registry->set('load', $this_loader);
			unset($this->Loader);

		}
		$this->registry->set('loader_work', false);
		return $modules;
	}

    private function jetcache_cont_from_cache($cont_route) {
        if (is_string($cont_route)) {
        	//$this->sc_set_cache_name('cont_'.str_replace('/', '_', $cont_route));
        	$this->sc_set_cache_name('cont', str_replace('/', '_', $cont_route));

            if (!$this->config->get('blog_work')) {
				$this->config->set('blog_work', true);
				$off_blog_work = true;
			} else {
				$off_blog_work = false;
			}

	        $cache_content = $this->cache->get($this->sc_cache_name);

			if ($off_blog_work) {
				$this->config->set('blog_work', false);
			}

			if (isset($cache_content['output']) && $cache_content['output'] != '') {

				return $cache_content['output'];
			}

			return false;
        }
    }

    private function jetcache_cont_to_cache($cache_output, $cont_route ) {

    	if (is_string($cache_output) && is_string($cont_route)) {

	    	$this->sc_set_cache_name('cont', str_replace('/', '_', $cont_route));

			if (!$this->config->get('blog_work')) {
				$this->config->set('blog_work', true);
				$off_blog_work = true;
			} else {
				$off_blog_work = false;
			}
			$cache['output'] = $cache_output;

	        $this->cache->set($this->sc_cache_name, $cache);

			if ($off_blog_work) {
				$this->config->set('blog_work', false);
			}
		}
    }


    private function jetcache_cont_access($params) {
		if (isset($this->seocms_settings['jetcache_widget_status']) && $this->seocms_settings['jetcache_widget_status']) {
			if (isset($this->jetcache_settings['store']) && in_array($this->config->get('config_store_id'), $this->jetcache_settings['store'])) {
		       	if (isset($this->jetcache_settings['cont_status']) && $this->jetcache_settings['cont_status']) {
			       if (isset($this->jetcache_settings['add_cont']) && !empty($this->jetcache_settings['add_cont'])) {
				       foreach($this->jetcache_settings['add_cont'] as $add_cont) {
	         				if ($params[0] == $add_cont['cont'] && $add_cont['status']) {
	         					return true;
	         				}
				       }
			       }
				}
			}
		}

		return false;
    }

	public function setreplacecontroller($data) {
		$asc_replacecontroller   = $this->registry->get('asc_replacecontroller');
		$asc_replacecontroller[] = $data;
		$this->registry->set('asc_replacecontroller', $asc_replacecontroller);
	}

	public function getreplacecontroller() {
		return $this->registry->get('asc_replacecontroller');
	}

	public function setreplacedata($data) {
		$asc_replacedata   = $this->registry->get('asc_replacedata');
		$asc_replacedata[] = $data;
		$this->registry->set('asc_replacedata', $asc_replacedata);
	}

	public function getreplacedata() {
		return $this->registry->get('asc_replacedata');
	}

	public function replacedatamethod($data, $value, $newvalue)	{
		list($key_replace_data, $value_replace_data) = each($newvalue);
		if (isset($data[$key_replace_data]) || $key_replace_data == '') {
			if (is_object($value_replace_data)) {
				// reset($value_replace_data);
				$value_replace_data = (array) $value_replace_data;
				list($object_str, $method_str) = each($value_replace_data);
				$this_obgect = new $object_str($this->registry);
				if ($key_replace_data == '') {
					$this_obgect->$method_str();
				} else {
					$data[$key_replace_data] = $this_obgect->$method_str($data[$key_replace_data]);
				}
			} else {
				$data[$key_replace_data] = $value_replace_data;
			}
		}
		return $data;
	}

	public function agoomodel($model, $data = array(), $dir_application = DIR_APPLICATION) {
		$model = str_replace('../', '', (string) $model);
		$file  = $dir_application . 'model/agoo/' . $model . '.php';
  		if (function_exists('modification')) {
        	$file = modification($file);
        }
		$class = 'agooModel' . preg_replace('/[^a-zA-Z0-9]/', '', $model);
		if (!file_exists($file)) {
			$file  = $dir_application . 'model/' . $model . '.php';
			if (function_exists('modification')) {
        		$file = modification($file);
        	}
			$class = 'Model' . preg_replace('/[^a-zA-Z0-9]/', '', $model);
		}
		if (file_exists($file)) {
			include_once($file);
			$this->registry->set('model_' . str_replace('/', '_', $model), new $class($this->registry));
		} else {

		}
	}

	public function sc_force_cache_output_access() {

        $access_status = false;

        // ≈сли loader первее загрузилс€ чем seo_url роута может еще не быть (даже к примеру на категории товаров)  и тогда не найдет по имени файла кеша
		if (!isset($this->request->get['route'])) {
			if (!isset($this->request->get['_route_'])) {
            	$this->request->get['route'] = 'common/home';
			}
		}
		if (isset($this->request->get['record_id']) && isset($this->request->get['blog_id'])) {
			unset($this->request->get['blog_id']);
		}

		if (isset($this->request->get['route']) && $this->request->get['route'] != 'error/not_found') {

	      	if (isset($this->jetcache_settings['store']) && in_array($this->config->get('config_store_id'), $this->jetcache_settings['store'])) {
	       		$access_status = true;
	      	} else {
				return $access_status = false;
			}

			if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
				return $access_status = false;
			}

			if ((isset($this->seocms_settings['jetcache_widget_status']) && $this->seocms_settings['jetcache_widget_status'] && isset($this->jetcache_settings['pages_status']) && $this->jetcache_settings['pages_status']) ||
				(isset($this->seocms_settings['cache_pages']) && $this->seocms_settings['cache_pages'] && !$this->registry->get('admin_work'))) {
				$access_status = true;
			} else {
				return $access_status = false;
			}

			if (isset($this->jetcache_settings['ex_route']) && !empty($this->jetcache_settings['ex_route'])) {
				$routes = explode('/', $this->request->get['route']);
                $routes_count = count($routes);

			    foreach($this->jetcache_settings['ex_route'] as $ex_route) {
		    		if ($ex_route['status']) {
			    		$ex_routes = explode('/', $ex_route['route']);
                        $ex_routes_count = count($ex_routes);
						if ($ex_routes_count <= $routes_count) {

                            $new_array = array();
                            $prom_array = array();
						    $key_search = array_search('%', $ex_routes);
						    if ($routes_count - $ex_routes_count > 0) {
                            	$prom_array = array_fill($key_search, $routes_count - $ex_routes_count , '%');
                            }

                            array_splice($ex_routes, $key_search, 0, $prom_array);

	                        $key = 0;
							foreach ($routes as $routes_val) {
                            	if ($ex_routes[$key] == '%') {
                            		$ex_routes[$key] = $routes_val;
                            	}
								$key++;
			    			}

                            if ($routes == $ex_routes)  {
                            	 return $access_status = false;
                            }
						}
		    		}
			    }
			}
            $request_uri_trim = ltrim($this->request->server['REQUEST_URI'], '/');

			if (isset($this->jetcache_settings['ex_page']) && !empty($this->jetcache_settings['ex_page'])) {
			    foreach($this->jetcache_settings['ex_page'] as $ex_page) {
		    		if ($ex_page['status'] && ($request_uri_trim == $ex_page['url'] || (!$ex_page['accord'] && strpos($request_uri_trim, $ex_page['url']) !== false ))) {
		    			return $access_status = false;
		    		}
			    }
			}

        }
		return $access_status;
	}

	public function sc_force_cache_output() {

    	if ($this->sc_force_cache_output_access()) {

			$this->sc_force_cache = true;

			$this->sc_set_cache_name();

			if (!$this->config->get("blog_work")) {
				$this->config->set("blog_work", true);
				$off_blog_work = true;
			} else {
				$off_blog_work = false;
			}

			$cache_content = $this->cache->get($this->sc_cache_name);


			if ($off_blog_work) {
				$this->config->set("blog_work", false);
			}

			if (isset($cache_content['output']) && $cache_content['output'] != '' && !$this->registry->get('jetcache_response_set_cache')) {

				$jetcache_content = $cache_content['output'];
			    $jetcache_headers = $cache_content['headers'];
			    $jetcache_time = $cache_content['time'];
			    $jetcache_queries = $cache_content['queries'];

				$this->config->set('ascp_comp_url', true);

				if (SC_VERSION > 15) {
					//$this->load->controller('common/seoblog');
				} else {
					$this->getChild('common/seoblog');
				}

				if (!empty($jetcache_headers)) {
					foreach ($jetcache_headers as $jc_header) {
			    		$this->response->addHeader($jc_header);
					}
			    }

			 	if (isset($this->request->get['record_id']) || isset($this->request->get['blog_id'])) {
					if (isset($this->request->get['record_id'])) {
						$this->countRecordUpdate();
					}
					if ($this->checkAccess()) {
						$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 200 OK');
					} else {
						$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');
					}
				}

			    if (($this->registry->get('sc_isLogged') && isset($this->jetcache_settings['jetcache_info_status']) && $this->jetcache_settings['jetcache_info_status']) || (isset($this->jetcache_settings['jetcache_info_demo_status']) && $this->jetcache_settings['jetcache_info_demo_status']) ) {
				    $time_visual['start'] = $this->registry->get('sc_time_start');
				    $time_visual['end'] = microtime(true);
				    $time_visual['load'] = $jetcache_time;
				    $time_visual['queries'] = $jetcache_queries;

					$this->registry->set('jetcache_output_visual', $time_visual);
				}

			    $this->registry->set('jetcache_output', true);

				$this->response->setOutput($jetcache_content);

				if (SC_VERSION > 21) {
					$this->response->setCompression($this->config->get('config_compression'));
				}

				$this->response->output();
				exit();

			}

		} else {

			if (isset($this->request->get['route']) && $this->request->get['route']!='error/not_found') {
				$this->sc_force_cache_no_access	= true;
			}
		}

	}


	private function countRecordUpdate() {
		$msql = "UPDATE `" . DB_PREFIX . "record` SET `viewed`=`viewed` + 1 WHERE `record_id`='" . (int) ($this->db->escape($this->request->get['record_id'])) . "'";
		$this->db->query($msql);
	}


	private function checkAccess() {
		if (!$this->config->get('ascp_customer_groups')) {
			agoo_cont('record/customer', $this->registry);
			$data = $this->controller_record_customer->customer_groups($this->seocms_settings);
			$this->config->set('ascp_customer_groups', $data['customer_groups']);
		} else {
			$data['customer_groups'] = $this->config->get('ascp_customer_groups');
		}
		if (isset($this->request->get['record_id'])) {

			$this->load->model('record/record');
			$record_info = $this->model_record_record->getRecord($this->request->get['record_id']);
			if ($record_info) {
				$check = true;
			} else {
				$check = false;
			}
		}
		if (isset($this->request->get['blog_id'])) {
			$this->load->model('record/blog');
			$blog_info = $this->model_record_blog->getBlog($this->request->get['blog_id']);
			if ($blog_info) {
				$check = true;
			} else {
				$check = false;
			}
		}
		return $check;
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

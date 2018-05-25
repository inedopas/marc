<?php
class agooModelCatalogProduct extends Controller
{
	protected  $agooobject;
    protected  $jetcache_settings;

   	public function __call($name, array $params) {

		$object = 'ModelCatalogProduct';

		if (!class_exists('ModelCatalogProduct')) {
			$file  = DIR_APPLICATION . 'model/catalog/product.php';
		    if (function_exists('modification')) {
		 		$file = modification($file);
		 	}
			if (file_exists($file)) {
				include_once($file);
			}
		}

        $general_settings = $this->registry->get('config')->get('ascp_settings');
        $this->jetcache_settings = $this->registry->get('config')->get('asc_jetcache_settings');

		$sc_access = $this->sc_get_jetcache_access($name, $general_settings);

		if ($sc_access) {

				if (!$this->config->get('blog_work')) {
					$this->config->set('blog_work', true);
					$off_blog_work = true;
				} else {
					$off_blog_work = false;
				}

                $cachedata['params'] = $params;
				$cachedata['name'] = $name;
				$hash = md5(json_encode($cachedata));
                $cache_filename = $this->sc_set_cache_name($hash);
				$cache_content = $this->cache->get($cache_filename);

				if ($off_blog_work) {
					$this->config->set('blog_work', false);
				}

				if (isset($cache_content[$hash])) {
                	return $cache_content[$hash];
				}
		}

		$this->agooobject =  new $object($this->registry);
		$data = call_user_func_array(array($this->agooobject , $name), $params);

		if ($sc_access) {
			if (!$this->config->get('blog_work')) {
				$this->config->set('blog_work', true);
				$off_blog_work = true;
			} else {
				$off_blog_work = false;
			}

	        $cachedata['params'] = $params;
			$cachedata['name'] = $name;
			$hash = md5(json_encode($cachedata));
	        $cache_filename = $this->sc_set_cache_name($hash);

			$cache_content[$hash] = $data;
			$this->cache->set($cache_filename, $cache_content);

			if ($off_blog_work) {
				$this->config->set('blog_work', false);
			}
		}

		return $data;
   	}

	private function sc_get_jetcache_access($name, $general_settings) {

      	$access_status = false;

      	if (isset($this->jetcache_settings['store']) && in_array($this->config->get('config_store_id'), $this->jetcache_settings['store'])) {
       		$access_status = true;
      	} else {
			return $access_status = false;
		}


		if (strtolower($name) == 'gettotalproducts' &&
		(isset($this->jetcache_settings['jetcache_gettotalproducts_status']) && $this->jetcache_settings['jetcache_gettotalproducts_status'])
		) {
			$access_status = true;
		} else {
			return $access_status = false;
		}

		if (!$this->registry->get('admin_work') && $access_status &&
		(isset($general_settings['jetcache_widget_status']) && $general_settings['jetcache_widget_status']) &&
		(isset($this->jetcache_settings['jetcache_model_status']) && $this->jetcache_settings['jetcache_model_status'])
		) {
			$access_status = true;
		} else {
			return $access_status = false;
		}

        return $access_status;
	}


	private function sc_set_cache_name($hash) {
		$route_name = $this->config->get('config_language_id').'_'.$this->config->get('config_store_id');

       if (isset($this->jetcache_settings['model_db_status']) && $this->jetcache_settings['model_db_status']) {
			$sc_cache_name  = 'blog.db.model.gettotalproducts.'.$route_name;
       } else {
	       $sc_cache_name  = 'blog.jetcache_gettotalproducts.'.$route_name;
       }

		return $sc_cache_name;
	}

}

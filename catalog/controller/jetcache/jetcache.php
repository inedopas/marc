<?php
if (!class_exists('ControllerJetcacheJetcache')) {
class ControllerJetcacheJetcache extends Controller {
	protected $data;
	protected $settings;
	protected $template;

	public function index() {
	}


	public function visual($arg) {

        $this->language->load('jetcache/jetcache');

		$sc_ver = VERSION; if (!defined('SC_VERSION')) define('SC_VERSION', (int) substr(str_replace('.', '', $sc_ver), 0, 2));

		if ($this->config->get('ascp_settings') != '') {
			$this->data['settings_general'] = $this->config->get('ascp_settings');
		} else {
			$this->data['settings_general'] = Array();
		}
        if (SC_VERSION > 21) {
        	$link_protocol = true;
        } else {
        	$link_protocol = 'SSL';
        }
        $this->data['jetcache_url_cache_remove'] = $this->url->link('module/blog/cacheremove', '', $link_protocol);
        $html = '';
        $this->data['load'] = $arg['load'];
        $this->data['start'] = $arg['start'];
        $this->data['end'] = $arg['end'];
        $this->data['queries'] = $arg['queries'];
        $this->data['cache'] = round($arg['end'] - $arg['start'], 3);
        $this->data['rate'] = round($this->data['load'] / $this->data['cache'], 0);
        $this->data['icon'] = getSCWebDir(DIR_IMAGE , $this->data['settings_general']).'jetcache/jetcache-icon.png';

        if (is_callable(array('DB', 'get_sc_jetcache_query_count'))) {
        	$this->data['queries_cache'] = $this->db->get_sc_jetcache_query_count();
        } else {
        	$this->data['queries_cache'] = '';
        }

		if (SC_VERSION > 21 && !$this->config->get('config_template')) {
			$this->config->set('config_template', $this->config->get($this->config->get('config_theme').'_directory'));
		}

        $template = '/template/agootemplates/jetcache/visual.tpl';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . $template) && is_file(DIR_TEMPLATE . $this->config->get('config_template') . $template)) {
			$this->template = $this->config->get('config_template') . $template;
		} else {
			if (file_exists(DIR_TEMPLATE . 'default' . $template) && is_file(DIR_TEMPLATE . 'default' . $template)) {
				$this->template = 'default' . $template;
			} else {
				$this->template = '';
			}
		}
        $this->data['language'] = $this->language;
		if ($this->template != '') {
			if (SC_VERSION < 20) {
				$html = $this->render();
			} else {
				if (!is_array($this->data))	$this->data = array();

				$html = $this->load->view($this->template, $this->data);
			}
		}

		return $html;
	}

}
}

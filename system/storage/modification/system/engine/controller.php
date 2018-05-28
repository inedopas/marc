<?php
abstract class Controller {
	protected $registry;


		// [BEGIN]


			//BOF WeDoWeb Util			
			//usage: $this->setDataLang('field_name');
			protected function setDataLang(&$data, $field_name)
			{
				$data[$field_name] = $this->language->get($field_name);
			}
			
			//usage $this->setData('width', 100);
			protected function setData(&$data, $field_name, $default_value)
			{
				$data[$field_name] = $this->getData($field_name, $default_value);
			}
			
			//usage $width = $this->getData('width', 100);
			protected function getData($field_name, $default_value)
			{
				if (isset($this->request->post[$field_name]))
				{
					return $this->request->post[$field_name];
				}
				elseif ($this->config->has($field_name))
				{ 
					return $this->config->get($field_name);
				}
				
				return $default_value;
			}			
	
			//usage: $link_to_image = $this->getDataImage('image_field_name', 64, 64);
			//MUST load model tool/image before calling this
			protected function getDataImage($field_name, $width, $height)
			{
				if (isset($this->request->post[$field_name]) && file_exists(DIR_IMAGE . $this->request->post[$field_name]))
				{
					return $this->model_tool_image->resize($this->request->post[$field_name], $width, $height);
				}
				elseif ($this->config->has($field_name))
				{ 
					return $this->model_tool_image->resize($this->config->get($field_name), $width, $height);
				}
				else
				{
					return $this->model_tool_image->resize('no_image.jpg', $width, $height);
				}
			}
			//EOF WeDoWeb Util
			
		protected function oc_smsc_init() {

				// Load language
				$this->load->language('module/oc_smsc');

				// Load OC SMSC library
				require_once(DIR_SYSTEM . 'library/oc_smsc/gateway.php');

				// Add to global registry
				$this->registry->set('oc_smsc_gateway', new OCSMSCGateway($this->registry));

				return true;
		}
		// [END]
		
	public function __construct($registry) {
		$this->registry = $registry;

				if( ! empty( $this->request->get['mfp'] ) && ! $this->config->get('mfp_path_was_verificed') && isset( $this->request->get['route'] ) ) {
					preg_match( '/path\[([^]]*)\]/', $this->request->get['mfp'], $mf_matches );
								
					if( class_exists( 'VQMod' ) ) {
						require_once VQMod::modCheck( modification( DIR_SYSTEM . '../catalog/model/module/mega_filter.php' ) );
					} else {
						require_once modification( DIR_SYSTEM . '../catalog/model/module/mega_filter.php' );
					}
				
					if( empty( $mf_matches[1] ) ) {
						preg_match( '#path,([^/]+)#', $this->request->get['mfp'], $mf_matches );
				
						if( ! empty( $mf_matches[1] ) ) {				
							if( class_exists( 'MegaFilterCore' ) ) {
								$mf_matches[1] = MegaFilterCore::__parsePath( $this, $mf_matches[1] );
							}
						}
					} else if( class_exists( 'MegaFilterCore' ) ) {
						$mf_matches[1] = MegaFilterCore::__parsePath( $this, $mf_matches[1] );
					}

					if( ! empty( $mf_matches[1] ) ) {
						if( empty( $this->request->get['mfilterAjax'] ) && ! empty( $this->request->get['path'] ) && $this->request->get['path'] != $mf_matches[1] ) {
							$this->request->get['mfp_org_path'] = $this->request->get['path'];
				
							if( 0 === ( $mf_strpos = strpos( $this->request->get['mfp_org_path'], $mf_matches[1] . '_' ) ) ) {
								$this->request->get['mfp_org_path'] = substr( $this->request->get['mfp_org_path'], $mf_strpos+strlen($mf_matches[1])+1 );
							}
						} else {
							$this->request->get['mfp_org_path'] = '';
						}
				
						//$this->request->get['path'] = $mf_matches[1];
						$this->request->get['mfp_path'] = $mf_matches[1];

						if( isset( $this->request->get['category_id'] ) || ( isset( $this->request->get['route'] ) && in_array( $this->request->get['route'], array( 'product/search', 'product/special', 'product/manufacturer/info' ) ) ) ) {
							$mf_matches = explode( '_', $mf_matches[1] );
							$this->request->get['category_id'] = end( $mf_matches );
						}
					}
				
					unset( $mf_matches );
				
					if( method_exists( $this->config, 'set' ) ) {
						$this->config->set('mfp_path_was_verificed', true);
					}
				}
			
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}
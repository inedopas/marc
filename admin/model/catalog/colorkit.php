<?php
class ModelCatalogColorkit extends Model {
		
		
	public function addColorKit($data) {
	
	$this->db->query("INSERT INTO `" . DB_PREFIX . "color_kits` SET name = '" . $this->db->escape($data['name']) . "', tpl = '" . $this->db->escape($data['tpl']) . "', status = '" . (int)$data['status'] . "'");
	
	$color_kit_id = $this->db->getLastId();
	
	if (isset($data['color_kit'])) {
			foreach ($data['color_kit'] as $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "color_kit_group SET option_id = '" . (int)$value['option_id'] . "', color_kit_id = '" . (int)$color_kit_id . "', product_id = '" . (int)$value['product_id'] . "', image = '" . $this->db->escape($value['image']) . "' ");						
			}
		}		
	}
	
	public function editColorKit($color_kit_id, $data) {

		$this->db->query("UPDATE `" . DB_PREFIX . "color_kits` SET name = '" . $this->db->escape($data['name']) . "', tpl = '" . $this->db->escape($data['tpl']) . "', status = '" . (int)$data['status'] . "' WHERE color_kit_id = '" . (int)$color_kit_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "color_kit_group WHERE color_kit_id = '" . (int)$color_kit_id . "'");
		
		if (isset($data['color_kit'])) {
			foreach ($data['color_kit'] as $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "color_kit_group SET option_id = '" . (int)$value['option_id'] . "', color_kit_id = '" . (int)$color_kit_id . "', product_id = '" . (int)$value['product_id'] . "', image = '" . $this->db->escape($value['image']). "' ");						
			}
		}			
	}
	
	public function deleteColorKit($color_kit_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "color_kits` WHERE color_kit_id = '" . (int)$color_kit_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "color_kit_group` WHERE color_kit_id = '" . (int)$color_kit_id . "'");	
	}
	
	public function getColorKitDescription($color_kit_id){
			
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "color_kits` WHERE color_kit_id = '" . (int)$color_kit_id . "'");
		
		return $query->row;
	
	}
	
	public function getColorKit($color_kit_id){
			
		$query = $this->db->query("SELECT ck.*, ckg.*, cod.name as color FROM `" . DB_PREFIX . "color_kits` ck LEFT JOIN " . DB_PREFIX . "color_kit_group ckg ON (ck.color_kit_id = ckg.color_kit_id) LEFT JOIN " . DB_PREFIX . "color_options_description cod ON (ckg.option_id = cod.option_id AND cod.language_id = '" .(int)$this->config->get('config_language_id'). "') WHERE ck.color_kit_id = '" . (int)$color_kit_id . "'");
		
		//echo '<pre>';
		//print_r($query->rows); die;
		return $query->rows;
	
	}

	public function getColors(){
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "color_options_description` WHERE language_id = '" .(int)$this->config->get('config_language_id'). "'");
		
		return $query->rows;
	}
	
	public function getColorKitsGroups($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "color_kits`";

		if (!empty($data['filter_name'])) {
			$sql .= " WHERE name LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		$sort_data = array(
			'name',
			'status',
			'tpl'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}					

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
		
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}	
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	
	public function getTotalColorKits() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "color_kits`"); 
		
		return $query->row['total'];
	}	
	public function getProducts($data = array()) {
					
			$sql = "SELECT p.*, pd.* FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";	
								
			$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 
			
			if (!empty($data['filter_name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
			}

			if (!empty($data['filter_model'])) {
				$sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";
			}
				
			if (!empty($data['filter_sku'])) {
				$sql .= " AND LCASE(p.sku) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_sku'])) . "%'";
			}
			
			$sql .= " AND p.status = '1'";
								
			$sql .= " GROUP BY p.product_id";
						
			$sort_data = array(
				'pd.name',
				'p.model',
				'p.sku',
				'p.price',
				'p.status',
				'p.sort_order'
			);	
			
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY pd.name DESC";	
			}
			
		
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}				

				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
			
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}	
			
			$query = $this->db->query($sql);
		
			return $query->rows;
		}
		
		public function getProductWidthColors($data) {
		$products = array();
		foreach($data as $color) {
			$sql = "SELECT p.product_id, pd.name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";	
								
			$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 
			
			if (!empty($color['name'])) {
				$sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($color['name'])) . "%'";
			}
			
			$query = $this->db->query($sql);
			
			$results = $query->rows;
			if(!empty($results)){
				foreach($results as $res){
					$checkIsset = $this->db->query("SELECT * FROM " . DB_PREFIX . "color_kit_group WHERE product_id = '" . (int)$res['product_id'] . "' LIMIT 1");
					if($checkIsset->num_rows) continue;

					$products[] = array(
						'name' => str_replace(utf8_strtolower($color['name']),'',utf8_strtolower($res['name'])),
						'product_id' => $res['product_id'],
						'product_name' => $res['name'],
						'color' => $color['name'],
						'option_id' => $color['option_id']
					);
				}		
			}			
		
		}
		
		
		$kits = array();
		foreach($products as $product){
				$kits[trim($product['name'])][$product['color']] = array(
					'product_id' => $product['product_id'],
					'product_name' => $product['product_name'],	
					'option_id' => $product['option_id'],
					'color' => $product['color'],
					'tpl' => 'color',
					'status' => '1'
				);
		}
		$product_data = array();
		foreach($kits as $key => $kit){

			if(count($kit) != '1'){
				$product_data[$key] = $kit;
			}
		}	

		return $product_data;
	}

	public function autoFillKits($data,$status) {

		if(isset($data['colorkit'])){
			foreach($data['colorkit'] as $name_group => $kit){

				$this->db->query("INSERT INTO `" . DB_PREFIX . "color_kits` SET name = '" . $this->db->escape($name_group) . "', tpl = '".$this->db->escape($data['template'])."', status = '" . (int)$status . "'");
				$color_kit_id = $this->db->getLastId();
				foreach($kit['rows'] as $row){
					$this->db->query("INSERT INTO " . DB_PREFIX . "color_kit_group SET option_id = '" . (int)$row['option_id'] . "', color_kit_id = '" . (int)$color_kit_id . "', product_id = '" . (int)$row['product_id'] . "', image = '' ");
				}
			}
		}

	}
	
}
	
<?php
class ModelCatalogColorkit extends Model {

	public function getColors($product_id) {

		$query = $this->db->query("SELECT ck.tpl, ckg.color_kit_id as color_kit_id FROM `" . DB_PREFIX . "color_kit_group` ckg LEFT JOIN " . DB_PREFIX . "color_kits ck ON (ck.color_kit_id = ckg.color_kit_id) WHERE ckg.product_id = '" . (int)$product_id . "' AND ck.status <> 0");
		
		if($query->num_rows > 0){
			$color_kit_id = $query->row['color_kit_id'];
			$color_kit_tpl = $query->row['tpl'];
		}
		$arr_emty = array();
		
		if(isset($color_kit_id)){
			$result = $this->db->query("SELECT * FROM `" . DB_PREFIX . "color_kit_group` ckg LEFT JOIN " . DB_PREFIX . "color_options co ON (co.option_id = ckg.option_id) LEFT JOIN " . DB_PREFIX . "color_options_description cod ON (ckg.option_id = cod.option_id AND cod.language_id = '" .(int)$this->config->get('config_language_id'). "') WHERE ckg.color_kit_id = '" . (int)$color_kit_id . "' ORDER BY co.sort");
			$res = array();
			foreach($result->rows as $row){
				$res[] = array(
					'product_id' => $row['product_id'],
					'tpl' => $color_kit_tpl,
					'image' => $row['image'],
					'color' => $row['color'],
					'color_name' => $row['name']
				);
			}

		}
		
		if(isset($res)){
			return $res;
		} else {
			return $arr_emty;
		}		
	}
	
}

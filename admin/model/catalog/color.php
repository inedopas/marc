<?php
class ModelCatalogColor extends Model {
	
	public function editColorOptions($data) {
	
		$this->db->query("DELETE FROM " . DB_PREFIX . "color_options_description");
		$this->db->query("DELETE FROM " . DB_PREFIX . "color_options");
		
		if (isset($data['option_value'])) {
			foreach ($data['option_value'] as $r_option) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "color_options SET option_id = '" . (int)$r_option['option_id'] . "', color = '" . $this->db->escape($r_option['color']) . "', sort = '" . (int)$r_option['sort'] . "'");
				
				$option_id = $this->db->getLastId();
				
				foreach ($r_option['r_opt_description'] as $language_id => $r_opt_description) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "color_options_description SET option_id = '" . (int)$option_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($r_opt_description['name']) . "'");
				}
			}
		}
			
	}	
	
	public function getColorOptionDescriptions() {	
		
		$related_option_data = array();
		
		$related_options_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "color_options");
				
		foreach ($related_options_query->rows as $related_option) {
			$related_options_description_data = array();
			
			$r_opt_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "color_options_description WHERE option_id = '" . (int)$related_option['option_id'] . "'");			
			
			foreach ($r_opt_description_query->rows as $r_opt_description) {
				$related_options_description_data[$r_opt_description['language_id']] = array('name' => $r_opt_description['name']);
			}
			
			$related_option_data[] = array(
				'option_id'          => $related_option['option_id'],
				'r_opt_description' => $related_options_description_data,
				'color'          => $related_option['color'],
				'sort'         => $related_option['sort']
			);
		}
		
		return $related_option_data;
	}
	
	public function createDatabaseTables() {
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."color_kits` ( ";
  		$sql .= "`color_kit_id` int(11) NOT NULL AUTO_INCREMENT, ";
  		$sql .= "`status` tinyint(1) NOT NULL, ";
  		$sql .= "`name` varchar(255) NOT NULL, ";
		$sql .= "`tpl` varchar(10) NOT NULL, ";
  		$sql .= "PRIMARY KEY (`color_kit_id`) ";
		$sql .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci; ";
		$this->db->query($sql);
		
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."color_kit_group` ( ";
  		$sql .= "`color_kit_id` int(11) NOT NULL, ";
  		$sql .= "`product_id` int(11) NOT NULL, ";
  		$sql .= "`option_id` int(11) NOT NULL, ";
		$sql .= "`image` varchar(100) NOT NULL ";
		$sql .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci; ";
		$this->db->query($sql);
		
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."color_options` ( ";
  		$sql .= "`option_id` int(11) NOT NULL AUTO_INCREMENT, ";
  		$sql .= "`sort` int(11) NOT NULL, ";
  		$sql .= "`color` varchar(7) NOT NULL, ";
		$sql .= "PRIMARY KEY (`option_id`) ";
		$sql .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci; ";
		$this->db->query($sql);
		
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."color_options_description` ( ";
  		$sql .= "`option_id` int(11) NOT NULL, ";
  		$sql .= "`language_id` tinyint(1) NOT NULL, ";
  		$sql .= "`name` varchar(64) NOT NULL ";
		$sql .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci; ";
		$this->db->query($sql);
	}
	
	
	public function dropDatabaseTables() {
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."color_kits`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."color_kit_group`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."color_options`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."color_options_description`;";
		$this->db->query($sql);

	}
		
}	
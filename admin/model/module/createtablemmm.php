<?php
class ModelModuleCreatetablemmm extends Model {

    public function ISEXISTS($table_name, $column_name) {
        $query = $this->db->query("select * from  information_schema.columns where TABLE_SCHEMA = '".DB_DATABASE."' and table_name = '" . DB_PREFIX . $table_name . "' and column_name = '" . $column_name . "'");
        return $query->num_rows;
    }
    
    public function ADDALTER($table_name, $column_name, $Value) {
        if (!$this->ISEXISTS($table_name, $column_name)) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . $table_name . "` ADD `" . $column_name . "` " . $Value);
        }
    }

    public function DROPALTER($table_name, $column_name) {
       if ($this->ISEXISTS($table_name, $column_name)) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . $table_name . "` DROP COLUMN `".$column_name."`");
        }
    }

    public function CHANGEALTER($table_name, $column_name, $column_name_change, $Value) {
        if ($this->ISEXISTS($table_name, $column_name)) {
            $this->db->query("ALTER TABLE `" . DB_PREFIX . $table_name . "` CHANGE COLUMN `" . $column_name . "` `" . $column_name_change . "` " . $Value);
        }
    }

    public function EditTableVer1() {
        $this->ADDALTER('affiliate', 'parent', "INT(11) NOT NULL DEFAULT 0");
        $this->ADDALTER('customer', 'parent', "INT(11) NOT NULL DEFAULT 0");
		$this->ADDALTER('affiliate_transaction', 'affiliate_children', "INT(11) NOT NULL DEFAULT 0");
    }
	
	public function EditTableVer2() {
        $this->ADDALTER('product', 'affiliate_commission', "DECIMAL(4, 2) NOT NULL DEFAULT 0.00");
    }
}
?>
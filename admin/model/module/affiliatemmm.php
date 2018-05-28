<?php
class ModelModuleAffiliatemmm extends Model {

    public function createAffiliate() {
        $this->load->model('module/createtablemmm');
        $this->model_module_createtablemmm->EditTableVer1();
		$this->model_module_createtablemmm->EditTableVer2();
    }
	
	public function getAffiliateParent($affiliate_id, $count, $limit) {
        $result = '';
        $query = $this->db->query("SELECT parent FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . $affiliate_id . "'");
		if ($query->num_rows) {
			$affiliate_id = $query->row['parent'];
			$count = $count + 1;
			if($affiliate_id!=0) {
				$result = $affiliate_id;
				if($count <= $limit) {
					$result = $result.','.$this->getAffiliateParent($affiliate_id, $count, $limit);
				}
			}
		}
	    return $result;
    }
	
	public function getOrderTotals($order_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' and code = 'sub_total'");
		if($query->num_rows)
		  return $query->row['value'];
		return 0;
	}
	
	public function getOrderCommission($order_id) {		
		$query_special = $this->db->query("SELECT sum(CASE WHEN (SELECT sum(ps.price) FROM `" . DB_PREFIX . "product_special` ps WHERE ps.product_id = p.product_id and date_start <= now() and date_end > now()) IS NOT NULL THEN (SELECT sum(ps.price) FROM `" . DB_PREFIX . "product_special` ps WHERE ps.product_id = p.product_id and date_start <= now() and date_end > now()) ELSE p.price END * orp.quantity * p.affiliate_commission) AS value FROM `" . DB_PREFIX . "product` p LEFT JOIN `" . DB_PREFIX . "order_product` orp ON (orp.product_id = p.product_id) WHERE order_id = '" . (int)$order_id . "'");
		$query_discount = $this->db->query("SELECT sum(CASE WHEN (SELECT sum(ps.price) FROM `" . DB_PREFIX . "product_discount` ps WHERE ps.product_id = p.product_id and date_start <= now() and date_end > now()) IS NOT NULL THEN (SELECT sum(ps.price) FROM `" . DB_PREFIX . "product_discount` ps WHERE ps.product_id = p.product_id and date_start <= now() and date_end > now()) ELSE p.price END * orp.quantity * p.affiliate_commission) AS value FROM `" . DB_PREFIX . "product` p LEFT JOIN `" . DB_PREFIX . "order_product` orp ON (orp.product_id = p.product_id) WHERE order_id = '" . (int)$order_id . "'");
		if ($query_special->num_rows & $query_discount->num_rows) {
			$query_special = (double)$query_special->row['value'];
			$query_discount = (double)$query_discount->row['value'];
			if ($query_special > $query_discount) {
				return $query_discount;
			} else {
				return $query_special;
			}
		}
		return 0;
	}
	public function getOrder($order_id) {
		$query = $this->db->query("SELECT commission FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");
		if($query->num_rows)
		  return $query->row['commission'];
		return 0;
	}
    public function getAffiliateCommission($text, $levels, $order_info) {
        $text = trim($text,',');
		$getaffiliate= explode(',', $text);
		$count = 1;
		$return = array();
		$level_max = count($levels);
		$oldcommission = -1;
		foreach ($getaffiliate as $affiliate_id) {
			if(((int)$affiliate_id != 0) & ($count <= $level_max)) {
				if($oldcommission == -1) {
					$oldcommission = (double) $this->getOrder($order_info['order_id']);
				}
				$commission = $oldcommission * $levels[$count]['level_commission'] / 100;    
				$return[] = array(
					'affiliate_id' => $affiliate_id,
					'affiliate_name' => $this->getAffiliatesName((int)$affiliate_id),
					'level' => $count,
					'total' => $commission,
					'commission' => $this->currency->format($commission, $order_info['currency_code'], $order_info['currency_value']),
					'link' => $this->url->link('marketing/affiliate/update', 'token=' . $this->session->data['token'] . '&affiliate_id=' . $affiliate_id, 'SSL')
				);
				$count = $count + 1;
				if ($count <= $level_max) {
					$oldcommission = $commission;
				}
			}
		}
		return $return;
    }
	
	public function getAffiliateAllCommission() {
        $getlevel = $this->config->get('affiliate_level_commission');
		$oldcommision = (double) $this->config->get('config_affiliate_commission');
		$return  = $oldcommision ;
		if(is_array($getlevel)) {
			foreach ($getlevel as $level) {
				$return = $return + $oldcommision * (double) $level['level_commission'] / 100;
				$oldcommision = $oldcommision * (double) $level['level_commission'] / 100;
			}
		}
		return $return;
    }
	
	public function getAffiliatesName($affiliate_id) {
        $sql = "SELECT CONCAT(firstname, ' ', lastname) AS name FROM `" . DB_PREFIX . "affiliate` WHERE affiliate_id = '" . (int) $affiliate_id . "'";
        $query = $this->db->query($sql);
		if ($query->num_rows) {
			return $query->row['name'];
		}
		return '';
    }
}
?>
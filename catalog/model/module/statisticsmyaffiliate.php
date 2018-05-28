<?php
class ModelModuleStatisticsmyaffiliate extends Model {//('tracking', $tracking);

    public function ISEXISTS($table_name) {
        $query = $this->db->query("select * from  information_schema.columns where TABLE_SCHEMA = '" . DB_DATABASE . "' and table_name = '" . DB_PREFIX . $table_name . "'");
        return $query->num_rows;
    }
	
	public function getAffiliatesChildren($implode, $level) {
	    $text = '';
        $sql = "SELECT affiliate_id FROM `" . DB_PREFIX . "affiliate` ";
        if ($implode) {
            $sql .= " WHERE " . implode(" OR ", $implode);
        }
        $query = $this->db->query($sql);
		$result = $query->rows;
		$implode = array();
		foreach ($query->rows as $res) {
			$implode[] = "parent = '" . (int)$res['affiliate_id'] . "'";
			$text = $text.','.$res['affiliate_id'];
		}
		$getlevel = explode(',,', $text);
		if(count($getlevel)<$level) {
			if ($implode) {
				$text = $text.','.$this->getAffiliatesChildren($implode, $level);
			}
		}
        return $text;
    }
	//explode(',,', $text);
	public function getChildrenLevel($text, $level) {
		$text = trim($text,',');
		$count = 0;
		$getlevel = explode(',,', $text);
		$return = array();
		foreach ($getlevel as $l) {
			$getaffiliate = explode(',', $l);
			$count++;
			if($count<=$level){
				foreach ($getaffiliate as $a) {
					$return[] = array(
						'level' => $count,
						'affiliate_id' => $a
					);
				}
			}
		}
		
        return $return;
    }
	
    public function GetStatisticsOrders($affiliate_id, $data) {
        $sql = "SELECT count(total) as count_orders, SUM(total) as sum_orders FROM `" . DB_PREFIX . "order` ";
        $rezult_data = $this->end($affiliate_id, $data, $sql, 0);
        return $rezult_data;
    }

    public function GetStatisticsShopping($affiliate_id, $data) {
        $sql = "SELECT count(total) as count_shopping, SUM(total) as sum_shopping FROM `" . DB_PREFIX . "order` ";
        $rezult_data = $this->end($affiliate_id, $data, $sql, (int) $this->config->get('config_complete_status_id'));
        return $rezult_data;
    }

    public function GetStatisticsSum($affiliate_id, $affiliate_children, $data) {

        $sql = "SELECT SUM(case when amount > 0 then amount else 0 end) AS commission FROM " . DB_PREFIX . "affiliate_transaction ";
        $rezult_data = $this->end($affiliate_id, $data, $sql, -1, $affiliate_children);
        return $rezult_data;
    }

    private function end($affiliate_id, $data, $sql, $order_status_id = -1, $affiliate_children = 0) {
		
		$implode[] = "affiliate_id = '" . (int) $affiliate_id . "'";
		if($affiliate_children!=0){
			$implode[] = "affiliate_children = '" . (int) $affiliate_children . "'";
		}

        if ($order_status_id != -1) {
            if ($order_status_id == 0) {
                $implode[] = "order_status_id != '" . $order_status_id . "'";
            } else {
                $implode[] = "order_status_id = '" . $order_status_id . "'";
            }
        }

        if (!empty($data['filter_date_start'])) {
            $implode[] = "DATE(date_added) >= DATE('" . date("Y.m.d", strtotime($this->db->escape($data['filter_date_start']))) . "')";
        }

        if (!empty($data['filter_date_end'])) {
            $implode[] = "DATE(date_added) <= DATE('" . date("Y.m.d", strtotime($this->db->escape($data['filter_date_end']))) . "')";
        }

        if ($implode) {
            $sql .= " WHERE " . implode(" AND ", $implode);
        }

        $query = $this->db->query($sql);
        return $query->row;
    }
	
	public function isAffiliate(){
		if($this->config->get('affiliate_customer_lifetime')){
			if(isset($this->session->data['customer_id'])){
				$customer_id = $this->session->data['customer_id'];
				$query = $this->db->query("SELECT parent FROM " . DB_PREFIX . "customer WHERE customer_id = '" . $customer_id . "'");
				$parent_customer = $query->row['parent'];
				if($parent_customer != 0){
					$query = $this->db->query("SELECT code FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . $parent_customer . "'");
					if ($query->num_rows) {
						setcookie('tracking', $query->row['code']);
						$this->session->data['tracking'] = $query->row['code'];
						$this->request->cookie['tracking'] = $query->row['code'];
					}
				} elseif(isset($this->request->cookie['tracking'])) {
					$query = $this->db->query("SELECT affiliate_id FROM " . DB_PREFIX . "affiliate WHERE code = '" . $this->request->cookie['tracking'] . "'");
					if ($query->num_rows) {
						$query = $this->db->query("UPDATE " . DB_PREFIX . "customer SET parent =". $query->row['affiliate_id'] ." WHERE customer_id = '" . (int)$customer_id . "'");
					}
				}
			}
		}
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
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' and sort_order = 1");

		return $query->row['value'];
	}
	
    public function getAffiliateCommission($text, $levels, $order_info) {
        $text = trim($text,',');
		$getaffiliate= explode(',', $text);
		$count = 1;
		$return = array();
		$level_max = count($levels);
		$ordertotal = ((float)$this->getOrderTotals($order_info['order_id']) / 10000);
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
					'commission' => $this->currency->format($commission, $order_info['currency_code'], $order_info['currency_value'])
				);
				$count = $count + 1;
				if ($count <= $level_max) {
					$oldcommission = $commission;
				}
			}
		}
		return $return;
    }
	
	public function getOrder($order_id) {
		$query = $this->db->query("SELECT commission FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");
		if($query->num_rows)
		  return $query->row['commission'];
		return 0;
	}
	
	public function getAffiliatesName($affiliate_id) {
        $sql = "SELECT CONCAT(firstname, ' ', lastname) AS name FROM `" . DB_PREFIX . "affiliate` WHERE affiliate_id = '" . (int) $affiliate_id . "'";
        $query = $this->db->query($sql);
		if ($query->num_rows) {
			return $query->row['name'];
		}
		return '';
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
	
	public function getRegUrl() {
		return $this->url->link('affiliate/register'. $this->getSumbol(). 'tracking='.$this->affiliate->getCode());
	}
	
	public function getSumbol() {
		$affiliate_sumbol = $this->config->get('config_affiliate_sumbol');
		if (!$this->config->get('config_affiliate_sumbol')) {
			return '&';
		} else if ($affiliate_sumbol == 2) {
			return '?';
		}
		return '&';
	}
}
?>
<?php
class ModelExtensionTotalTotalCustomerGroupDiscount extends Model {
	// public function getTotal(&$total_data, &$total, &$taxes) {
	public function getTotal($total) {
		if($user_id = $this->customer->isLogged()){
			$this->load->model('account/customer');
			$customer = $this->model_account_customer->getCustomer($user_id);
			$customerDiscount = 0;
			$sumForDiscount = 0;
			$subtraction = 0;

			if (isset($this->session->data['partner_price']) && $this->session->data['partner_price'] === true) {
				$customer_group_id = 16;
			} else {
				$customer_group_id = $customer['customer_group_id'];
			}
			$discounts = $this->config->get('total_customer_group_discount_customer_group_id');
			foreach ($discounts as $group_id => $discount){
				if($group_id == $customer_group_id){
					$customerDiscount = $discount;
					break;
				}
			}

			if($customerDiscount != 0){
				$this->load->model('catalog/product');
				if($this->config->get('total_customer_group_discount_tax')){
					if($this->config->get('total_customer_group_discount_special')){
						foreach ($this->cart->getProducts() as $product) {
							if($this->model_catalog_product->getProductSpecial($product['product_id'], $customer['customer_group_id'])){
								continue;
							}
							$sumForDiscount += $product['quantity']*$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
						}
					}else{
						foreach ($this->cart->getProducts() as $product) {
							$sumForDiscount += $product['quantity']*$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
						}
					}
				}else{
					if($this->config->get('total_customer_group_discount_special')){
						foreach ($this->cart->getProducts() as $product) {
							if($this->model_catalog_product->getProductSpecial($product['product_id'], $customer['customer_group_id'])){
								continue;
							}
							$sumForDiscount += $product['quantity']*$product['price'];
						}
					}else{
						foreach ($this->cart->getProducts() as $product) {
							$sumForDiscount += $product['quantity']*$product['price'];
						}
					}
				}

				$subtraction = $sumForDiscount*($customerDiscount/100);
				$total['total'] -= $subtraction;
			}

			if ($this->config->get('total_customer_group_discount_show') == 1 || ($customerDiscount != 0 && $this->config->get('total_customer_group_discount_show') == 2)){
				$this->load->language('extension/total/total_customer_group_discount');
				$total['totals'][] = array(
					'code'       => 'total_customer_group_discount',
					'title'      => sprintf($this->language->get('text_total_discount'), $customerDiscount),
					'value'      => -$subtraction,
					'sort_order' => $this->config->get('total_customer_group_discount_sort_order')
				);
			}

		} elseif (isset($this->session->data['partner_price']) && $this->session->data['partner_price'] === true) {
			$customerDiscount = 0;
			$sumForDiscount = 0;
			$subtraction = 0;
			$customer_group_id = 16;

			$discounts = $this->config->get('total_customer_group_discount_customer_group_id');
			foreach ($discounts as $group_id => $discount){
				if($group_id == $customer_group_id){
					$customerDiscount = $discount;
					break;
				}
			}

			if ($customerDiscount != 0){
				$this->load->model('catalog/product');
				if($this->config->get('total_customer_group_discount_tax')){
					if($this->config->get('total_customer_group_discount_special')){
						foreach ($this->cart->getProducts() as $product) {
							if($this->model_catalog_product->getProductSpecial($product['product_id'], $customer['customer_group_id'])){
								continue;
							}
							$sumForDiscount += $product['quantity']*$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
						}
					}else{
						foreach ($this->cart->getProducts() as $product) {
							$sumForDiscount += $product['quantity']*$this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'));
						}
					}
				}else{
					if($this->config->get('total_customer_group_discount_special')){
						foreach ($this->cart->getProducts() as $product) {
							if($this->model_catalog_product->getProductSpecial($product['product_id'], $customer['customer_group_id'])){
								continue;
							}
							$sumForDiscount += $product['quantity']*$product['price'];
						}
					}else{
						foreach ($this->cart->getProducts() as $product) {
							$sumForDiscount += $product['quantity']*$product['price'];
						}
					}
				}

				$subtraction = $sumForDiscount*($customerDiscount/100);
				$total['total'] -= $subtraction;
			}

			if ($this->config->get('total_customer_group_discount_show') == 1 || ($customerDiscount != 0 && $this->config->get('total_customer_group_discount_show') == 2)){
				$this->load->language('extension/total/total_customer_group_discount');
				$total['totals'][] = array(
					'code'       => 'total_customer_group_discount',
					'title'      => sprintf($this->language->get('text_total_discount'), $customerDiscount),
					'value'      => -$subtraction,
					'sort_order' => $this->config->get('total_customer_group_discount_sort_order')
				);
			}

		}
	}
}
?>

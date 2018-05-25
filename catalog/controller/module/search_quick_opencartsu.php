<?php
class ControllerModuleSearchQuickOpencartsu extends Controller
{
  public function index() {
    $this->load->language('module/search_quick_opencartsu');
    if ($this->config->get('searchquickopencartsu_status')==1 && isset($this->request->get['search_query']) && strlen($this->request->get['search_query']) >= 1) {
      $limit=$this->config->get('searchquickopencartsu_maxquery'); if($limit<1) {$limit=10;}

	  $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_description` WHERE `name` LIKE '%" . $this->db->escape($this->request->get['search_query']) . "%' ORDER BY name ASC LIMIT $limit");

      if(!$query->rows) {
      				$data[] = array(
					'img' => '',
					'price' => '',
					'quantity' => '',
					'name' => $this->language->get('text_notfound'),
					'href' => 'index.php?route=product/search&search=' . $this->request->get['search_query']
				);
      }
      else {
      $cutname=$this->config->get('searchquickopencartsu_maxnamelen'); if($cutname<1) {$cutname=50;}
      $all=array();
	  foreach ($query->rows as $row) {
              if(in_array($row['product_id'],$all)) { continue; } // исключение дублирования

              $sel = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product` WHERE `product_id`='".$row['product_id']."'");

              if($sel->rows[0]['status']==0) { continue; } // если товар отключен, то не показываем его в поиске

			  if($this->config->get('searchquickopencartsu_img')==1) {  // вывод картинки
                $imgwidth=$this->config->get('searchquickopencartsu_imgwidth'); if($imgwidth<5) {$imgwidth=5;}
                $imgheight=$this->config->get('searchquickopencartsu_imgheight'); if($imgheight<5) {$imgheight=5;}
                $original_image=$sel->rows[0]['image'];
			      if (is_file(DIR_IMAGE . $original_image)) { $this->load->model('tool/image'); $image1 = $this->model_tool_image->resize($original_image, $imgwidth, $imgheight); }
                  else { $image1 = $this->model_tool_image->resize('no_image.png', $imgwidth, $imgheight); }
                  $image="<img src='".$image1."'>";
              } else { $image=""; }

			  if($this->config->get('searchquickopencartsu_price')==1) {  // вывод цены
                $original_price=$sel->rows[0]['price'];
                $text_preprice=$this->language->get('text_preprice');
                $query_special_price = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_special` WHERE `product_id`='".$row['product_id']."' ORDER BY `priority` ASC, `product_special_id` DESC");
                 if(isset($query_special_price->rows[0])) {
                    $special_price=$query_special_price->rows[0]['price'];
                    $price2=" ".$this->currency->format($special_price, $this->config->get('config_currency'));
                    $style_price1=" style='text-decoration:line-through'";
                  } else {$style_price1=""; $price2="";}

			      if ($original_price>0) {
			      $this->load->model('catalog/product');
                  $price1=$this->currency->format($original_price, $this->config->get('config_currency'));
                  $price="<div style='float:right;margin-left:5px'><small>$text_preprice <span$style_price1>$price1</span>$price2</small></div>";
                  } else { $price=""; }
              } else { $price=""; }

			  if($this->config->get('searchquickopencartsu_quantity')==1) {  // вывод кол-ва
                $original_quantity=$sel->rows[0]['quantity'];
                $text_sctock=$this->language->get('text_stock');
			      if ($original_quantity>0) { $quantity=" <small>($text_sctock$original_quantity)</small>"; } else { $quantity=$this->language->get('text_outstock'); }
                } else { $quantity=""; }

                $name = html_entity_decode($row['name']);
                if(strlen($name)>$cutname) { $name=substr($name,0,$cutname)."...";}

				$data[] = array(
					'img' => $image,
					'price' => $price,
					'quantity' => $quantity,
					'name' => $name,
					'href' => 'index.php?route=product/product&product_id=' . $row['product_id']
				);

                $all[]=$row['product_id'];
	  }

                   // добавляем внизу показать все результаты
      				$data[] = array(
					'img' => '',
					'price' => '',
					'quantity' => '',
					'name' => $this->language->get('view_all_result'),
					'href' => 'index.php?route=product/search&search=' . $this->request->get['search_query']
				);



      }
	  $this->response->addHeader('Content-Type: application/json');
	  $this->response->setOutput(json_encode($data));
    }
  }
}
?>
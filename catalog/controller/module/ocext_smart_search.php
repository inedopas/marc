<?php
class ControllerModuleOcextSmartSearch extends Controller {
    
    public function index(){
    
        if(!$this->config->get('ocext_ajax_status')){
            return;
        }
        
        $this->load->model('tool/ocext_smart_search');
        
        $keyword = $this->request->get['query'];
        
        $search_data = $this->model_tool_ocext_smart_search->getProducts($keyword,true);
        
        $this->getResult($search_data);
        
    }
    
    public function getResult($search_data) { 

            $this->load->model('tool/ocext_smart_search');
            $this->load->model('tool/image');
            
            $search_data['products']['limit'] = 0;
            if($this->config->get('ocext_ajax_products')){
                $limit = (int)$this->config->get('ocext_ajax_products');
                $search_data['products']['limit'] = $limit;
            }
            
            $search_data['manufacturers']['limit'] = 0;
            if($this->config->get('ocext_ajax_manufacturer')){
                $limit = (int)$this->config->get('ocext_ajax_manufacturer');
                $search_data['manufacturers']['limit'] = $limit;
            }
            
            $search_data['categories']['limit'] = 0;
            if($this->config->get('ocext_ajax_category')){
                $limit = (int)$this->config->get('ocext_ajax_category');
                $search_data['categories']['limit'] = $limit;
            }
            
            $this->load->language('module/ocext_smart_search');
            
            $more_results = $this->language->get('text_ocext_ajax_text_no_results');
            if($this->config->get('ocext_ajax_text_more_results_value')){
                $more_results = $this->config->get('ocext_ajax_text_more_results_value');
            }
            
            $no_results = $this->language->get('text_ocext_ajax_text_no_results_value');
            if($this->config->get('ocext_ajax_text_no_results_value')){
                $no_results = $this->config->get('ocext_ajax_text_no_results_value');
            }
            
            $ocext_ajax_products_image = $this->config->get('ocext_ajax_products_image');
            $ocext_ajax_products_price = $this->config->get('ocext_ajax_products_price');
            
            $results['products'] = array();
            $results['categories'] = array();
            $results['manufacturers'] = array();
            
            $total_categories = 0;
            
            if($search_data['categories']['limit'] && $search_data['categories']['sql']){
                
                
                
                $data = array(
                    'start'  => 0,
                    'limit'  => $search_data['categories']['limit'],
                    'sql'   =>  $search_data['categories']['sql']   
                );
                
                $categories = $this->model_tool_ocext_smart_search->getCategoriesToDb($data);
                
                $total_categories = $this->model_tool_ocext_smart_search->getCategoriesToDb($data,true);
                
                $results['categories_title'] = '<div class="title-box">'.$this->language->get('text_ocext_ajax_text_categories').'</div>';
                
                $i = 0;
                foreach ($categories as $row) {
                    $results['categories'][$i]["class"] = "";
                    $results['categories'][$i]["name"] = $row["name"];
                    
                    
                    if($this->config->get('ocext_ajax_cal_prod_cat')){
                        $results['categories'][$i]["products"] = $this->model_tool_ocext_smart_search->getProductsCategoriesByToDb($row['category_id']);
                    }else{
                        $results['categories'][$i]["products"] = '';
                    }
                    $results['categories'][$i]["href"] = $this->url->link('product/category', 'path=' . $row['category_id']);
                    $i++;
                }
            }
            
            $total_manufacturers = 0;
            if($search_data['manufacturers']['limit'] && $search_data['manufacturers']['sql']){
                $data = array(
                    'start'  => 0,
                    'limit'  => $search_data['manufacturers']['limit'],
                    'sql'   =>  $search_data['manufacturers']['sql']   
                );
                
                $manufacturers = $this->model_tool_ocext_smart_search->getManufacturersToDb($data);
                
                $total_manufacturers = $this->model_tool_ocext_smart_search->getManufacturersToDb($data,true);
                
                $results['manufacturers_title'] = '<div class="title-box">'.$this->language->get('text_ocext_ajax_text_manufacturers').'</div>';
                
                $i = 0;
                foreach ($manufacturers as $row) {
                    $results['manufacturers'][$i]["class"] = "";
                    $results['manufacturers'][$i]["name"] = $row["name"];
                    if($this->config->get('ocext_ajax_cal_prod_manuf')){
                        $results['manufacturers'][$i]["products"] = $this->model_tool_ocext_smart_search->getProductsManufacturersByToDb($row['manufacturer_id']);
                    }else{
                        $results['manufacturers'][$i]["products"] = '';
                    }
                    $results['manufacturers'][$i]["href"] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $row['manufacturer_id']);
                    $i++;
                }
            }
            
            $total_products = 0;
            if($search_data['products']['limit'] && $search_data['products']['sql']){
                $data = array(
                    'start'  => 0,
                    'limit'  => $search_data['products']['limit'],
                    'sql'   =>  $search_data['products']['sql'],
                    'sql_sorted'   =>  $search_data['products']['sql_sorted'],
                );
                
                $products = $this->model_tool_ocext_smart_search->getProductsToDb($data);
                
                $total_products = $this->model_tool_ocext_smart_search->getProductsToDb($data,true);
                
                $results['products_title'] = '<div class="title-box">'.$this->language->get('text_ocext_ajax_text_products').'</div>';
                
                $i = 0;
                foreach ($products as $product) {

                        $results['products'][$i]["class"] = "";
                        $results['products'][$i]["name"] = $product["name"];
                        
                        if($this->config->get('ocext_ajax_products_category')){
                            $results['products'][$i]["category_path"] = $this->model_tool_ocext_smart_search->getCategories($product['product_id']);
                        }else{
                            $results['products'][$i]["category_path"] = '';
                        }

                        $results['products'][$i]["img"] = "";
                        if ($product['image'] && $ocext_ajax_products_image==1) {
                                $results['products'][$i]["img"] = $this->model_tool_image->resize($product['image'],50,50);
                        }

                        if ($ocext_ajax_products_price) {
                                $results['products'][$i]["price"] = $this->currency->format( $this->tax->calculate( $product['price'], $product['tax_class_id'], $this->config->get('config_tax') ) );
                                if ($product['special']) {
                                        $results['products'][$i]["price"] = '<strike>' . $results['products'][$i]["price"] . '</strike> ' . $this->currency->format( $this->tax->calculate( $product['special'], $product['tax_class_id'], $this->config->get('config_tax') ) );
                                }
                        }
                        
                        //$results['products'][$i]["sql"] = $search_data['products']['sql_sorted'];
                        
                        $results['products'][$i]["href"] = $this->url->link('product/product', 'product_id=' . $product['product_id']);
                        $i++;
                }
            }
            $results['no_results']['no_results_status'] = 0;
            $results['total_products'] = $total_products;
            $results['total_manufacturers'] = $total_manufacturers;
            $results['total_categories'] = $total_categories;
            
            if (!$results['products'] && !$results['categories'] && !$results['manufacturers']) {
                    $results['no_results']['no_results_status'] = 1;
                    $results['products'][] = array(
                            "class" => ' class="amore" ',
                            "img"  => "",
                            "name" => '<p class="pmore">' . $no_results . '</p>',
                            "href" => $this->url->link('product/search', '&search=' . $search_data['keyword'])
                    );
            } else {
                    if ($total_products >= $search_data['products']['limit']) {
                            $results['products'][] = array(
                                    "class" => " class='amore' ",
                                    "img"  => "",
                                    "name" => '<p class="pmore">'.htmlentities($more_results, ENT_QUOTES, 'UTF-8').'</p>',
                                    "href" => $this->url->link('product/search', '&search=' . $search_data['keyword'])
                            );
                    }
            }
            echo json_encode($results);
    }
}
?>
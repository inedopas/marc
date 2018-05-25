<?php
class ModelModuleOcextSmartSearch extends Model {
	
    protected $registry;
    protected $languages;
    protected $language_active;
    protected $rang;
    protected $words;

    public function __construct($registry) {
        $this->registry = $registry;
        $this->install();
        $this->setLanguages();
        $this->rang = array();
        $this->words = array();
    }
    
    private function setLanguages(){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE status = '1'");
        if($query->rows){
            foreach($query->rows as $language){
                if($language['code']=='ru'){
                    $this->languages[ $language['language_id'] ] = $language['code'];
                }else{
                    $this->languages[ $language['language_id'] ] = 'en';
                }
            }
        }
        $this->language_active = $this->config->get('config_language_id');
    }


    public function getTotalProducts() {
            
            $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE status = '1'");
            $sql_language = array();
            if($query->rows){
                foreach($query->rows as $language){
                    $sql_language[] = " pd.language_id = '" . (int)$language['language_id'] . "' ";
                }
            }
            
            $where_null_price_status = array();
            if($this->config->get('ocext_smart_search_null_price')){
                $where_null_price_status[] = ' p.price > 0 ';
            }
            if($this->config->get('ocext_smart_search_disable_prod')){
                $where_null_price_status[] = " p.status = '1' ";
            }

            if($where_null_price_status){
                $where_null_price_status = ' AND ('.implode(' AND ', $where_null_price_status).') ';
            }else{
                $where_null_price_status = '';
            }
        
            $sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";
            
            if($sql_language){
                $sql .= " WHERE (".implode(' OR ', $sql_language).") ".$where_null_price_status;
            }else{
                $sql .= " WHERE ".$where_null_price_status;
            }
            $query = $this->db->query($sql);
            return $query->row['total'];
    }
    
    public function getIndexDataDebug($product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocext_smart_search_index WHERE product_id = '" . (int)$product_id . "' ");
        //var_dump($query->row['rang']);
        
        foreach ($query->rows as $key => $value) {
            //$test = json_decode($value['rang'],TRUE);
            //var_dump($test);
        }
    }
    
    public function setIndexSmartSearch($data=array()){
        error_reporting(0);
        //Получаем все языки
        $languages = array();
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE status = '1'");
        $index = FALSE;
        foreach ($query->rows as $language) {
                $language_id = $language['language_id'];
                $this->language_active = $language_id;
                
                $where_null_price_status = array();
                if($this->config->get('ocext_smart_search_null_price')){
                    $where_null_price_status[] = ' p.price > 0 ';
                }
                if($this->config->get('ocext_smart_search_disable_prod')){
                    $where_null_price_status[] = " p.status = '1' ";
                }
                
                if($where_null_price_status){
                    $where_null_price_status = ' AND ('.implode(' AND ', $where_null_price_status).') ';
                }else{
                    $where_null_price_status = '';
                }
                
                $sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . $language_id . "' ".$where_null_price_status;
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
                if($query->rows){
                    foreach($query->rows as $product){
                        $rang = array();
                        $index = array(); 
                        $product_id = $product['product_id'];
                        $insert = "";
                        ///атрибуты
                        $index = $this->getProductAttributes($product_id,$language_id);
                        $attribute = $index['index'];
                        $rang['attribute'] = $index['rang'];
                        $insert .= " attribute = '".$this->db->escape($attribute)."', ";
                        //продукт
                        $index = $this->getProduct($product_id,$language_id);
                        $product_index = $index['index'];
                        $rang['product'] = $index['rang'];
                        $insert .= " product = '".$this->db->escape($product_index)."', ";
                        //опции
                        $index = $this->getProductOptions($product_id,$language_id);
                        $options = $index['index'];
                        $rang['options'] = $index['rang'];
                        $insert .= " options = '".$this->db->escape($options)."', ";
                        //категории
                        $index = $this->getProductCategories($product_id,$language_id);
                        $category = $index['index'];
                        $rang['category'] = $index['rang'];
                        $insert .= " category = '".$this->db->escape($category)."', ";
                        //категории для категорий
                        $index = $this->getCategoriesId($product_id,$language_id);
                        $categories_id = $index['rang'];
                        $insert .= " categories_id = '".$this->db->escape(json_encode($categories_id))."', ";
                        //производители
                        $manufacturer_id = $product['manufacturer_id'];
                        $index = $this->getProductManufacturer($manufacturer_id);
                        $manufacturer = $index['index'];
                        $rang['manufacturer'] = $index['rang'];
                        $insert .= " manufacturer = '".$this->db->escape($manufacturer)."', ";
                        $insert .= " manufacturer_id = '".$manufacturer_id."', ";
                        //отзывы
                        $index = $this->getProductReview($product_id);
                        $review = $index['index'];
                        $rang['review'] = $index['rang'];
                        $insert .= " review = '".$this->db->escape($review)."', ";
                        $rang = json_encode($rang);                        
                        $insert .= " rang = '".$this->db->escape($rang)."', product_id = " . (int)$product_id . ", language_id = '" . (int)$language_id . "' ";
                        
                        $update = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocext_smart_search_index WHERE product_id = '" . (int)$product_id . "' AND language_id = '" . (int)$language_id . "' ");
                        if($update->row){
                            $insert = "UPDATE " . DB_PREFIX . "ocext_smart_search_index SET ".$insert." WHERE  product_id = '" . (int)$product_id . "' AND language_id = '" . (int)$language_id . "'  ";
                        }else{
                            $insert = "INSERT INTO  " . DB_PREFIX . "ocext_smart_search_index SET ".$insert;
                        }
                        $this->db->query($insert);
                    }
                }
            
        }
        return $index;
        //получаем товары с данными, и обновляем массив индекса
    }
    
    public function getIndexStat(){
        
        $query = $this->db->query("SELECT rang FROM " . DB_PREFIX . "ocext_smart_search_index ");
        
        $index_stat['total_index_keywords'] = 0;
        if($query->rows){
            foreach ($query->rows as $row) {
                $rang = json_decode($row['rang'],TRUE);
                if($rang && is_array($rang)){
                    
                    foreach ($rang as $value) {
                        if($value && is_array($value)){
                            foreach ($value as $count) {
                                $index_stat['total_index_keywords'] += $count;
                            }
                        }
                    }
                }
            }
        }
        return $index_stat;
    }

    public function getProductManufacturer($manufacturer_id) {
            $result['index'] = '';
            $result['rang'] = array();
            
            $index_level = $this->config->get('ocext_smart_search_index_level');
            
            if(!$this->config->get('ocext_smart_search_manufacturer')){
                return $result;
            }
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "manufacturer WHERE manufacturer_id = '" . (int)$manufacturer_id . "' ");
            if($query->row){
                $result['index'] = $this->getIndexString(array($query->row['name']),2);
                $result['rang'] = $this->getRangArray($result['index'],TRUE,$index_level);
            }
            return $result;
    }
    
    public function getProductReview($product_id) {
            $result['index'] = '';
            $result['rang'] = array();
            
            $index_level = $this->config->get('ocext_smart_search_index_level');
            
            if(!$this->config->get('ocext_smart_search_review')){
                return $result;
            }
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "' ");
            $reviews_data = array();
            if($query->rows){
                foreach($query->rows as $reviews){
                    $reviews_data[] = $reviews['text'];
                }
                if($reviews_data){
                    $result['index'] = $this->getIndexString($reviews_data);
                    $result['rang'] = $this->getRangArray($result['index'],TRUE,$index_level);
                }
            }
            return $result;
    }
    
    public function getProductCategories($product_id,$language_id) {
            $product_category_data = array();
            $result['index'] = '';
            $result['rang'] = array();
            
            if(!$this->config->get('ocext_smart_search_category')){
                return $result;
            }
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category pc LEFT JOIN " . DB_PREFIX . "category_description cd ON (pc.category_id = cd.category_id) WHERE pc.product_id = '" . (int)$product_id . "' AND cd.language_id = '" . (int)$language_id . "'");

            foreach ($query->rows as $category) {
                    if($category){
                        
                        $product_category_data[] = $category['name'];
                        
                        $product_category_data[] = $this->noCleanWordEndingsRu($category['description'], TRUE, FALSE);
                        
                        if(isset($category['meta_title'])){
                            $product_category_data[] = $this->noCleanWordEndingsRu($category['meta_title'],  TRUE, FALSE);
                        }
                        
                        if(isset($category['meta_description'])){
                            $product_category_data[] = $this->noCleanWordEndingsRu($category['meta_description'],  TRUE, FALSE);
                        }
                        
                        if(isset($category['meta_keyword'])){
                            $product_category_data[] = $this->noCleanWordEndingsRu($category['meta_keyword'],  TRUE, FALSE);
                        }
                        
                    }
            } 
            
            $index_level = $this->config->get('ocext_smart_search_index_level');
            
            if($product_category_data){
                $result['index'] = $this->getIndexString($product_category_data);
                $result['rang'] = $this->getRangArray($result['index'],TRUE,$index_level);
            }
            
            return $result;
    }
    
    public function getCategoriesId($product_id,$language_id) {
            $product_category_data = array();
            $result['index'] = '';
            $result['rang'] = array();
            
            if(!$this->config->get('ocext_smart_search_category')){
                return $result;
            }
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category pc LEFT JOIN " . DB_PREFIX . "category_description cd ON (pc.category_id = cd.category_id) WHERE pc.product_id = '" . (int)$product_id . "' AND cd.language_id = '" . (int)$language_id . "'");

            foreach ($query->rows as $category) {
                    $product_category_data = array();
                    if($category){
                        
                        $product_category_data[] = $category['name'];
                        
                        $product_category_data[] = $this->noCleanWordEndingsRu($category['description'], TRUE, FALSE);
                        
                        if(isset($category['meta_title'])){
                            $product_category_data[] = $this->noCleanWordEndingsRu($category['meta_title'],  TRUE, FALSE);
                        }
                        
                        if(isset($category['meta_description'])){
                            $product_category_data[] = $this->noCleanWordEndingsRu($category['meta_description'],  TRUE, FALSE);
                        }
                        
                        if(isset($category['meta_keyword'])){
                            $product_category_data[] = $this->noCleanWordEndingsRu($category['meta_keyword'],  TRUE, FALSE);
                        }
                        
                        $index_level = $this->config->get('ocext_smart_search_index_level');
                        
                        if($product_category_data){
                            $result['index'] = $this->getIndexString($product_category_data);
                            $result['rang'][$category['category_id']]['category_id'] = $category['category_id'];
                            $result['rang'][$category['category_id']]['rang'] = $this->getRangArray($result['index'],TRUE,$index_level);
                        }
                        
                    }
            }
            
            return $result;
    }
    
    public function getProductOptions($product_id,$language_id) {
        $product_option_data = array();
        
        
        $result['index'] = '';
        $result['rang'] = array();
        if(!$this->config->get('ocext_smart_search_option')){
            return $result;
        }
        
        $product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option` po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$language_id . "'");
        
        foreach ($product_option_query->rows as $product_option) {
            
            if($product_option){
                $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int)$product_option['product_option_id'] . "'");
                $product_option_data_value = array();
                foreach ($product_option_value_query->rows as $product_option_value) {
                    $product_option_data_value_query = $this->getProductOptionValue($product_id, $product_option_value['product_option_value_id'], $language_id);
                    if($product_option_data_value_query){
                        $product_option_data_value[] = $product_option_data_value_query['name'];
                    }
                }
                $product_option_data[] = array($product_option['name'],$product_option['value'],$product_option_data_value);
            }
        }
        
        $index_level = $this->config->get('ocext_smart_search_index_level');
        
        if($product_option_data){
            $result['index'] = $this->getIndexString($product_option_data);
            $result['rang'] = $this->getRangArray($result['index'],TRUE,$index_level);
        }
        return $result;
    }
    
    public function getProduct($product_id,$language_id) {
            $query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "') AS keyword FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$language_id . "'");
            $result['index'] = '';
            $result['rang'] = array();
            if($query->row){
                
                $array[] = $query->row['description'];
                $array[] = $query->row['name'];
                $array[] = $query->row['tag'];
                
                $this->noCleanWordEndingsRu($query->row['description'], TRUE, FALSE);
                $this->noCleanWordEndingsRu($query->row['name'], TRUE, FALSE);                
                $this->noCleanWordEndingsRu($query->row['tag'], TRUE, FALSE,FALSE,',');

                $array[] = $query->row['description'];
                $array[] = $query->row['name'];
                $array[] = $query->row['tag'];
                
                if(isset($query->row['meta_title'])){
                    $array[] = $query->row['meta_title'];
                    $this->noCleanWordEndingsRu($query->row['meta_title'], TRUE, FALSE);
                    $array[] = $query->row['meta_title'];
                }
                if(isset($query->row['meta_description'])){
                    $array[] = $query->row['meta_description'];
                    $this->noCleanWordEndingsRu($query->row['meta_description'], TRUE, FALSE);
                    $array[] = $query->row['meta_description'];
                }
                if(isset($query->row['meta_keyword'])){
                    $array[] = $query->row['meta_keyword'];
                    $this->noCleanWordEndingsRu($query->row['meta_keyword'], TRUE, FALSE);
                    $array[] = $query->row['meta_keyword'];
                }
                if(isset($query->row['model'])){
                    $array[] = $query->row['model'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['model'], TRUE, TRUE,TRUE);
                }
                if(isset($query->row['sku'])){
                    $array[] = $query->row['sku'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['sku'], TRUE, TRUE,TRUE);
                }
                if(isset($query->row['upc'])){
                    $array[] = $query->row['upc'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['upc'], TRUE, TRUE,TRUE);
                }
                if(isset($query->row['ean'])){
                    $array[] = $query->row['ean'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['ean'], TRUE, TRUE,TRUE);
                }
                if(isset($query->row['jan'])){
                    $array[] = $query->row['jan'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['jan'], TRUE, TRUE,TRUE);
                }
                if(isset($query->row['isbn'])){
                    $array[] = $query->row['isbn'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['isbn'], TRUE, TRUE,TRUE);
                }
                if(isset($query->row['mpn'])){
                    $array[] = $query->row['mpn'];
                     $array[] = $this->noCleanWordEndingsRu($query->row['mpn'], TRUE, TRUE,TRUE);
                }
                
                $index_level = $this->config->get('ocext_smart_search_index_level');
                
                $result['index'] = $this->getIndexString($array);
                
                $result['rang'] = $this->getRangArray($result['index'],FALSE,$index_level);
            }
            return $result;
    }
    
    public function getProductOptionValue($product_id, $product_option_value_id,$language_id) {
            $query = $this->db->query("SELECT pov.option_value_id, ovd.name, pov.quantity, pov.subtract, pov.price, pov.price_prefix, pov.points, pov.points_prefix, pov.weight, pov.weight_prefix FROM " . DB_PREFIX . "product_option_value pov LEFT JOIN " . DB_PREFIX . "option_value ov ON (pov.option_value_id = ov.option_value_id) LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE pov.product_id = '" . (int)$product_id . "' AND pov.product_option_value_id = '" . (int)$product_option_value_id . "' AND ovd.language_id = '" . (int)$language_id . "'");

            return $query->row;
    }
    
    public function getProductAttributes($product_id,$language_id) {
            
        $result['index'] = '';
        $result['rang'] = array();
        if(!$this->config->get('ocext_smart_search_attribute')){
            return $result;
        }
            
            
            $product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND language_id = ".(int)$language_id."  GROUP BY attribute_id");
            $product_attribute_description_data = array();
            
            foreach ($product_attribute_query->rows as $product_attribute) {
                if($product_attribute){
                    $product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (pa.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int)$product_id . "' AND pa.language_id = '" . (int)$language_id . "' AND ad.language_id = '" . (int)$language_id . "' AND pa.attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");
                    
                    $product_attribute_group_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "attribute a LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON (a.attribute_group_id = agd.attribute_group_id) WHERE a.attribute_id = '" . (int)$product_attribute['attribute_id'] . "' AND agd.language_id = '" . (int)$language_id . "' ");
                    
                    foreach ($product_attribute_description_query->rows as $product_attribute_description) {
                        
                        foreach ($product_attribute_group_description_query->rows  as $product_attribute_group_description) {
                            $product_attribute_description_data[$product_attribute_group_description['name']][$product_attribute_description['name']] = $product_attribute_description['text'];
                        }
                    }
                }
            }
            
            $index_level = $this->config->get('ocext_smart_search_index_level');
            
            if($product_attribute_description_data){
                $result['index'] = $this->getIndexString($product_attribute_description_data);
                $result['rang'] = $this->getRangArray($result['index'],TRUE,$index_level);
            }
            return $result;
    }
    
    private function getIndexString($array,$min_symblos=3){
        $index = '^^^^^^';
        if($this->config->get('ocext_smart_search_min_symbols')){
            $min_symblos = $this->config->get('ocext_smart_search_min_symbols');
        }
        foreach ($array as $word => $value) {
            
            if(is_string($word) && mb_strlen($word,'UTF-8')>=$min_symblos){
                
                $this->cleanPretext($word, TRUE);
                
                $this->cleanWordEndings($word, FALSE, TRUE);
                
                if($word){
                    $index .= $word.'^^^^^^';
                }
            }
            
            if(is_string($value) && $value && mb_strlen($value,'UTF-8')>=$min_symblos){
                
                $this->cleanPretext($value, TRUE);
                
                $this->cleanWordEndings($value, FALSE, TRUE);
                
                if($value){
                    $index .= '^^^^^^'.$value.'^^^^^^';
                }
            }elseif(is_array($value)){
                
                $index .= $this->getIndexString($value);
                
            }
        }
        $index = str_replace('^^^^^^^^^^^^', '^^^^^^', $index);
        
        return $index;
    }
    
    private function creatRangArray($array,$level=TRUE){
        if($array){
            
            foreach ($array as $value) {
                
                $value = mb_strtolower(trim($value),'UTF-8');
                
                if($value){
                    
                    $keywords = explode(' ', $value);
                    
                    $first = '';
                    
                    $two_1 = '';
                    
                    $two_2 = '';
                    
                    $three_1 = '';
                    
                    $three_2 = '';
                    
                    $three_3 = '';
                    
                    foreach ($keywords as $keyword) {
                        
                        $keyword = trim($keyword);
                        
                        if($keyword){
                            
                            $first = $keyword;
                            
                            $this->words[$first] = $first;

                            if(!isset($this->rang[$first])){

                                $this->rang[$first] = 1;

                            }else{

                                $this->rang[$first] += 1;

                            }
                            
                            if(!$two_1 && !$two_2){
                                
                                $two_1 = $keyword;
                                
                            }elseif($two_1 && !$two_2){
                                
                                $two_1 = $two_1.' '.$keyword;
                                
                                $this->words[$two_1] = $two_1;

                                if(!isset($this->rang[$two_1])){

                                    $this->rang[$two_1] = 1;

                                }else{

                                    $this->rang[$two_1] += 1;

                                }
                                
                                //echo $two_1.'<br>';
                                
                                $two_1 = '';
                                
                                $two_2 = $keyword;
                                
                            }elseif(!$two_1 && $two_2){
                                
                                $two_1 = $keyword;
                                
                                $two_2 = $two_2.' '.$keyword;
                                
                                $this->words[$two_2] = $two_2;

                                if(!isset($this->rang[$two_2])){

                                    $this->rang[$two_2] = 1;

                                }else{

                                    $this->rang[$two_2] += 1;

                                }
                                
                                //echo $two_2.'<br>';
                                
                                $two_2 = '';
                                
                            }
                            
                            if($level){
                                
                                if(!$three_1 && !$three_2 && !$three_3){
                                
                                    $three_1 = $keyword;

                                }elseif($three_1 && !$three_2 && !$three_3){

                                    $three_1 = $three_1.' '.$keyword;

                                    $three_2 = $keyword;

                                }elseif($three_1 && $three_2 && !$three_3){

                                    $three_1 = $three_1.' '.$keyword;

                                    $this->words[$three_1] = $three_1;

                                    if(!isset($this->rang[$three_1])){

                                        $this->rang[$three_1] = 1;

                                    }else{

                                        $this->rang[$three_1] += 1;

                                    }
                                    
                                    //echo $three_1.'<br>';
                                    
                                    $three_1 = '';

                                    $three_2 = $three_2.' '.$keyword;

                                    $three_3 = $keyword;

                                }elseif(!$three_1 && $three_2 && $three_3){

                                    $three_1 = $three_1.' '.$keyword;

                                    $three_2 = $three_2.' '.$keyword;

                                    $this->words[$three_2] = $three_2;

                                    if(!isset($this->rang[$three_2])){

                                        $this->rang[$three_2] = 1;

                                    }else{

                                        $this->rang[$three_2] += 1;

                                    }
                                    
                                    //echo $three_2.'<br>';

                                    $three_2 = '';

                                    $three_3 = $three_3.' '.$keyword;

                                }elseif($three_1 && !$three_2 && $three_3){

                                    $three_1 = $three_1.' '.$keyword;

                                    $three_2 = $keyword;

                                    $three_3 = $three_3.' '.$keyword;

                                    $this->words[$three_3] = $three_3;

                                    if(!isset($this->rang[$three_3])){

                                        $this->rang[$three_3] = 1;

                                    }else{

                                        $this->rang[$three_3] += 1;

                                    }
                                    
                                    //echo $three_3.'<br><br><br>';

                                    $three_3 = '';

                                }
                                
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }
    
    private function creatRangArrayLast($array,$max_count_words,&$rang){
        $words = array();
        $word = '';
        if($array){
            foreach ($array as $value) {
                $value = trim($value);
                $value = mb_strtolower($value,'UTF-8');
                if($value){
                    if(count($words)<$max_count_words && count($array)!=$max_count_words){ //3
                        $words[] = $value; 
                    }elseif(count($words)==$max_count_words){
                        $word = trim(implode(' ', $words));
                        $words = array();
                        if(isset($rang[$word]) && $word){
                            $rang[$word]++;
                        }elseif($word){
                            $rang[$word] = 1;
                        }
                    }elseif(count($array)==$max_count_words){
                        $words[] = $value;
                        $word = trim(implode(' ', $words));
                        $words = array();
                        if(isset($rang[$word]) && $word){
                            $rang[$word]++;
                        }elseif($word){
                            $rang[$word] = 1;
                        }
                    }
                }
            }
            array_shift($array);
            if(isset($array) && $array){
                $this->creatRangArray($array, $max_count_words, $rang);
            }
        }
    }


    private function getRangArray(&$string,$cleanIndexSymblols=TRUE,$level=TRUE){
        $array_check = explode('^^^^^^', $string);
        $this->rang = array();
        $array = array();
        
        if($array_check){
            foreach($array_check as $el){
                $el = trim($el);
                if($el){
                    $array[] = $el;
                }
            }
        }

        $this->creatRangArray($array,$level);
        
        if($cleanIndexSymblols){
            $string = str_replace('^^^^^^', ' ', $string);
            $string = trim($string);
        }
        
        return $this->rang;
    }


    public function getCleanIndexString(&$words){
        
        $this->cleanPretext($words,TRUE);
        $this->cleanWordEndings($words,FALSE,TRUE);
        
    }
    
    public function cleanPretext(&$words,$cleanHTML=FALSE,$ignorDotAndComa=FALSE) {
        if($this->languages[$this->language_active]=='ru'){
            $this->cleanPretextRu($words,$cleanHTML,$ignorDotAndComa);
        }elseif ($this->languages[$this->language_active]=='en') {
            $this->cleanPretextEn($words,$cleanHTML,$ignorDotAndComa);
        }else{
            $this->cleanPretextEn($words,$cleanHTML,$ignorDotAndComa);
        }
    }
    
    public function cleanWordEndings(&$words,$returnArray=FALSE,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        if($this->languages[$this->language_active]=='ru'){
            $this->cleanWordEndingsRu($words,$returnArray,$cleanHTML,$ignorDotAndComa);
        }elseif ($this->languages[$this->language_active]=='en') {
            $this->cleanWordEndingsEn($words,$returnArray,$cleanHTML,$ignorDotAndComa);
        }else{
            $this->cleanWordEndingsEn($words,$returnArray,$cleanHTML,$ignorDotAndComa);
        }
    }
    
    public function cleanPretextEn(&$words,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),'',$words);
            $words = preg_replace ('/\\s+/', ' ',  $words) ; 
        }
        
        $words = mb_strtolower($words, 'UTF-8');
        $words = trim($words);
        
        if(!$words){
            return;
        }

        $word_array = explode(' ', $words);
        if(!$word_array || !is_array($word_array)){
            return;
        }

        $result = '';
        $pretexts = array('a','an','the', 'aboard','about','above','absent','across','afore','after','against','along','amid','amidst','among','amongst','around','as','aside','aslant','astride','at','athwart','atop','bar','before','behind','below','beneath','beside','besides','between','betwixt','beyond','but','by','circa','despite','down','except','for','from','given','in','inside','into','like','mid (от "amid")','minus','near','neath','next','notwithstanding','of','off','on','opposite','out','outside','over','pace','per','plus','post','pro','qua','round','save','since','than','through','till','times','to','toward','towards','under','underneath','unlike','until','up','versus (сокр. «vs.»)','via','vice','with','without','barring','concerning','considering','depending','during','granted','excepting','excluding','failing','following','including','past','pending','regarding','alongside','within','outside','upon','onto','throughout','wherewith');

        foreach ($word_array as $key=>$word) {
            
            if($word){

                foreach($pretexts as $pretext){
                    $word = mb_strtolower($word, 'UTF-8');
                    if($word == $pretext){
                        unset($word_array[$key]);
                    }
                }

            }
        }
        
        if($word_array && is_array($word_array)){
            foreach ($word_array as $word) {
                $result .= ' '.$word;
            }
        }
        $words = trim($result);
        return $words;
    }
    public function cleanPretextRu(&$words,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),' ',$words);
            $words = preg_replace ('/\\s+/', ' ',  $words) ; 
        }
        
        $words = mb_strtolower($words, 'UTF-8');
        $words = trim($words);
        $words = str_replace(array("ё", 'Ё'),array("е", 'Е'),$words);
        
        if(!$words){
            return;
        }

        $word_array = explode(' ', $words);
        if(!$word_array || !is_array($word_array)){
            return;
        }

        $result = '';
        $pretexts = array('the','a','on','у',',','.','-', 'о', 'в', 'с', 'к', 'за', 'до', 'на','обо','об','при', 'по', 'из', 'от', 'над', 'под', 'про', 'без', 'для', 'ради', 'через','все','всё');

        foreach ($word_array as $key=>$word) {
            
            if($word){

                foreach($pretexts as $pretext){
                    $word = mb_strtolower($word, 'UTF-8');
                    if($word == $pretext){
                        unset($word_array[$key]);
                    }
                }

            }
        }
        
        if($word_array && is_array($word_array)){
            foreach ($word_array as $word) {
                $result .= ' '.$word;
            }
        }
        $words = trim($result);
        return $words;
    }
    
    public function getSmartSearchStatistic($data=array()){
        
            $sql = "SELECT * FROM `" . DB_PREFIX . "ocext_smart_search_statistic`";

            if (!empty($data['filter_id'])) {
                    $sql .= " AND id = '" . (int)$data['filter_id'] . "'";
            }

            if (!empty($data['filter_keyword'])) {
                    $sql .= " AND keyword = '" . $this->db->escape($data['filter_keyword']) . "'";
            }
            
            if (!empty($data['filter_index_elements'])) {
                    $sql .= " AND index_elements = '" . $this->db->escape($data['filter_index_elements']) . "'";
            }
            
            if (!empty($data['filter_used'])) {
                    $sql .= " AND used = '" . $this->db->escape($data['filter_used']) . "'";
            }

            if (!empty($data['filter_date_added'])) {
                    $sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
            }
        
            $sort_data = array(
			'id',
			'index_elements',
			'keyword',
			'date_added',
			'used'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY used";
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
    
    public function getSmartSearchStatisticTotal($data = array()) {
            $sql = "SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "ocext_smart_search_statistic`";

            if (!empty($data['filter_id'])) {
                    $sql .= " AND id = '" . (int)$data['filter_id'] . "'";
            }

            if (!empty($data['filter_keyword'])) {
                    $sql .= " AND keyword = '" . $this->db->escape($data['filter_keyword']) . "'";
            }
            
            if (!empty($data['filter_index_elements'])) {
                    $sql .= " AND index_elements = '" . $this->db->escape($data['filter_index_elements']) . "'";
            }
            
            if (!empty($data['filter_used'])) {
                    $sql .= " AND used = '" . $this->db->escape($data['filter_used']) . "'";
            }

            if (!empty($data['filter_date_added'])) {
                    $sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
            }

            $query = $this->db->query($sql);

            return $query->row['total'];
    }
    
    public function cleanWordEndingsEn(&$words,$returnArray=FALSE,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),' ',$words);
            $words = preg_replace ('/\\s+/', ' ',  $words); 
        }
        
        $words = mb_strtolower($words, 'UTF-8');
        $words = trim($words);
        
        if(!$words){
            return;
        }
        
        $word_array = explode(' ', $words);
        if(!$word_array || !is_array($word_array)){
            return;
        }
        
        $result = '';
        
        foreach ($word_array as $key_tmp_word=>$word) {
            $word = str_replace(array(",", ".", ";", ":"),'',$word);
            $word = trim($word);
            
            if($word){
                
                $count_symbols = mb_strlen($word,'UTF-8');
                
                if($count_symbols>3){
                    $clean = FALSE;
                    $finwords = array(":",";",",",".", "®","§","©","™","`s","'s", 's', 'ies','es', 'ed','ing','e', 'ful','less','able, ible','ic','ical','ous','ate','ish','ive','y');
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==5){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                                
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==4){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==3){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==2){

                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==1){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                }
            }
        }
        
        if($word_array && is_array($word_array) && !$returnArray){
            foreach ($word_array as $word) {
                $result .= ' '.$word;
            }
            $words = trim($result);
        }else{
            $words = $word_array;
        }
        return $words;
    }
    public function cleanWordEndingsRu(&$words,$returnArray=FALSE,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),' ',$words);
            $words = preg_replace ('/\\s+/', ' ',  $words); 
        }
        
        $words = mb_strtolower($words, 'UTF-8');
        $words = trim($words);
        
        if(!$words){
            return;
        }
        
        $word_array = explode(' ', $words);
        if(!$word_array || !is_array($word_array)){
            return;
        }
        
        $result = '';
        
        foreach ($word_array as $key_tmp_word=>$word) {
            $word = str_replace(array(",", ".", ";", ":"),'',$word);
            $word = trim($word);
            if($word){
                
                $count_symbols = mb_strlen($word,'UTF-8');

                if($count_symbols>3){
                    $clean = FALSE;
                    $finwords = array('а', 'я', 'о','и', 'е', 'ы', 'ю','ия', 'ных' ,'ный', 'ней', 'ная', 'ное', 'ным', 'ном', 'ные', 'у','ые','ую','ою','ое','ая','ой', 'ою','еи','ие','ею', 'ей', 'ею', 'ете','ые','ый','ий', 'ами', 'ям', 'ями', 'ов', 'ев', 'ах', 'ях', 'й', 'ся', 'ь', 'ешь','ишь','ишься','очка','очки','ешься','ющься','ющь','ещь','ут','ют','ся','ться','вши','чи','вшу','вша');
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==5){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                                
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==4){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==3){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==2){

                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==1){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword && !$clean){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                $clean = TRUE;
                            }
                        }
                    }
                }
            }
        }
        
        if($word_array && is_array($word_array) && !$returnArray){
            foreach ($word_array as $word) {
                $result .= ' '.$word;
            }
            $words = trim($result);
        }else{
            $words = $word_array;
        }
        return $words;
    }
    
    public function noCleanWordEndingsRu(&$words,$cleanHTML=FALSE,$ignorDotAndComa=FALSE,$returnString=FALSE,$d=' '){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),' ',$words);
            $words = preg_replace ('/\\s+/', ' ',  $words); 
        }
        
        $words = mb_strtolower($words, 'UTF-8');
        $words = trim($words);
        
        if($returnString){
            return $words;
        }
        
        if(!$words){
            return;
        }
        
        $word_array = explode($d, $words);
        if(!$word_array || !is_array($word_array)){
            return;
        }
        
        if($word_array && is_array($word_array)){
            $words = $word_array;
        }
        return $words;
    }
    
    public function install() {
        $tables[] = 'ocext_smart_search_statistic';
        $tables[] = 'ocext_smart_search_index';
        foreach ($tables as $table) {
            $check = $query = $this->db->query('SHOW TABLES from '.DB_DATABASE.' like "'.DB_PREFIX.$table.'" ');
            if(!$check->num_rows){
                $this->creatTables($table);
            }
        }
        
        $new_tape_data_column_name = array('product','review','rang');
        //миграция типов данных
        foreach ($new_tape_data_column_name as $column_name) {
            $sql = "SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '".DB_PREFIX."ocext_smart_search_index' AND COLUMN_NAME = '".$column_name."'";
            $query = $this->db->query($sql);
            if(isset($query->row['DATA_TYPE']) && $query->row['DATA_TYPE']=='text'){
                $sql = "ALTER TABLE  `".DB_PREFIX."ocext_smart_search_index` CHANGE  `".$column_name."`  `".$column_name."` MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL";
                $query = $this->db->query($sql);
            }
        }
        
                $result = FALSE;
        if(is_string($table)){
            $check = $query = $this->db->query('SHOW TABLES from '.DB_DATABASE.' like "'.DB_PREFIX.$table.'" ');
            if($check->num_rows){
                $result = TRUE;
            }
        }elseif (is_array($table)) {
            $result = TRUE;
            foreach ($table as $t) {
                $check = $query = $this->db->query('SHOW TABLES from '.DB_DATABASE.' like "'.DB_PREFIX.$t.'" ');
                if(!$check->num_rows){
                    $result = FALSE;
                }
            }
        }
        
        $new_column = array('manufacturer_id', 'categories_id');
        $new_column = array_flip($new_column);
                
        $sql = 'SHOW COLUMNS FROM `'.DB_PREFIX.'ocext_smart_search_index` ';
        $columns = $this->db->query($sql);
        if($columns->rows && is_array($columns->rows)){
            foreach ($columns->rows as $column_data) {
                if(isset($column_data['Field']) && isset($new_column[$column_data['Field']])){
                    unset($new_column[$column_data['Field']]);
                }
            }
            if($new_column){
                foreach ($new_column as $column=>$tmp) {
                    $sql = 'ALTER TABLE  `'.DB_PREFIX.'ocext_smart_search_index` ADD `'.$column.'` text NOT NULL AFTER `language_id`';
                    $this->db->query($sql);
                }
            }
        }
        
        return $result;
    }
    
    private function creatTables($table) {
        if($table=='ocext_smart_search_index'){
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "ocext_smart_search_index (
                  `index_id` int(16) NOT NULL AUTO_INCREMENT,
                  `product_id` int(16) NOT NULL,
                  `product` mediumtext NOT NULL,
                  `category` text NOT NULL,
                  `manufacturer` text NOT NULL,
                  `options` text NOT NULL,
                  `attribute` text NOT NULL,
                  `review` mediumtext NOT NULL,
                  `rang` mediumtext NOT NULL,
                  `language_id` int(3) NOT NULL,
                  PRIMARY KEY (`index_id`)
                ) ENGINE=MyISAM  DEFAULT CHARSET=utf8;"
            );
        }
        if($table=='ocext_smart_search_statistic'){
            $this->db->query(
                "CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "ocext_smart_search_statistic (
                  `id` int(16) NOT NULL AUTO_INCREMENT,
                  `keyword` text NOT NULL,
                  `used` bigint(20) NOT NULL,
                  `index_elements` text NOT NULL,
                  `date_added` datetime NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=MyISAM  DEFAULT CHARSET=utf8;"
            );
        }
    }
        
}
?>
<?php
class ModelToolOcextSmartSearch extends Model {
    
    public function getProducts(&$words,$ajax=FALSE){
        
        
        
        $keyword = trim($words);
        
        $sku_sql = '';
        if($keyword){
        $sku_sql = ' OR ( ';
        $sku_sql .= " LCASE(p.model) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= " OR LCASE(p.sku) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= " OR LCASE(p.upc) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= " OR LCASE(p.ean) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= " OR LCASE(p.jan) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= " OR LCASE(p.isbn) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= " OR LCASE(p.mpn) = '" . $this->db->escape(utf8_strtolower($keyword)) . "'";
            $sku_sql .= ' ) ';
        }
        
        
        if($this->config->get('config_language')=='ru'){
            $words_eng = $words;
            
            $words_abracadabra = $words;
            $this->cleanAbracadabra($words_abracadabra);
            
            
            $this->cleanPretextRu($words);
            $this->cleanWordEndingsRu($words,TRUE,TRUE);
            $this->cleanPretextRu($words_abracadabra);
            $this->cleanWordEndingsRu($words_abracadabra,TRUE,TRUE);
            
            $this->cleanPretextEn($words_eng);
            $this->cleanWordEndingsEn($words_eng,TRUE,TRUE);
            
            if($words_abracadabra!=$words){
                $words = $this->getMergeArrays($words, $words_abracadabra);
            }
            
            if($words_eng && $words){
                $words = $this->getMergeArrays($words, $words_eng);
            }
        }elseif($this->config->get('config_language')=='en'){
            $this->cleanPretextEn($words);
            $this->cleanWordEndingsEn($words,TRUE,TRUE);
        }else{
            $this->cleanPretextEn($words);
            $this->cleanWordEndingsEn($words,TRUE,TRUE);
        }
        
        $search_relevant_result = 50;
        if($this->config->get('ocext_smart_search_relevant_result')){
            $search_relevant_result = (int)$this->config->get('ocext_smart_search_relevant_result');
        }
        
        $resutlt['sql'] = " ".$sku_sql;
        $resutlt['sort'] = array();
        if($words){
            array_splice($words, 20);
            if($keyword){
                $words[] = $keyword;
            }
            $sql_result = array();
            $sql_result2 = array();
            $matches = array();
            $against = array();
            $sql = array();
            $sql2 = array();
            foreach ($words as $word) {
                
                $against[] = ' (*'.$word.'*) ';
                
                $sql[] = " `product` LIKE '%" . $this->db->escape($word) . "%' ";
                
                $sql2['product'] = " `product` LIKE '%" . $this->db->escape($word) . "%' ";
                
                $matches['product'] = 'product';
                
                if($this->config->get('ocext_smart_search_attribute')){
                    
                    $sql[] = " `attribute` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $sql2['attribute'] = " `attribute` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $matches['attribute'] = 'attribute';
                    
                }
                if($this->config->get('ocext_smart_search_option')){
                    
                    $sql[] = " `options` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $sql2['options'] = " `options` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $matches['options'] = 'options';
                    
                }
                if($this->config->get('ocext_smart_search_category')){
                    
                    $sql[] = " `category` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $sql2['category'] = " `category` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $matches['category'] = 'category';
                    
                }
                if($this->config->get('ocext_smart_search_manufacturer')){
                    
                    $sql[] = " `manufacturer` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $sql2['manufacturer'] = " `manufacturer` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $matches['manufacturer'] = 'manufacturer';
                    
                }
                if($this->config->get('ocext_smart_search_review')){
                    
                    $sql[] = " `review` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $sql2['review'] = " `review` LIKE '%" . $this->db->escape($word) . "%' ";
                    
                    $matches['review'] = 'review';
                    
                }
                if($sql){
                    $sql_result[] = implode(' OR ', $sql);
                }
                
                if($sql2){
                    $sql_result2[] = implode(' OR ', $sql2);
                }
            }
            
            $sql_new = 'SELECT *, MATCH ( '.  implode(',', $matches).' ) ';
            
            $sql_new .= "AGAINST ('".  implode(' ', $against)."' IN BOOLEAN MODE) as OCEXT_RELEVANT ";
            
            $sql_new .= 'FROM '. DB_PREFIX . "ocext_smart_search_index WHERE ";
            
            $sql_new .= 'MATCH ( '.  implode(',', $matches).' ) ';
            
            $sql_new .= "AGAINST ('".  implode(' ', $against)."' IN BOOLEAN MODE) ";
            
            $sql_new .= "ORDER BY OCEXT_RELEVANT LIMIT 0, ".$search_relevant_result;
            
            //$query = $this->db->query($sql_new);
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocext_smart_search_index WHERE ".implode(' OR ', $sql_result2)." "); 
            
            $sql = array();
            
            if($query->rows){
                $products = array();
                foreach ($query->rows as $key => $product) {
                    $products[$key] = $product;
                    $products[$key]['rang'] = $this->getTotalProductRang($product['rang'], $words);
                    if($this->config->get('ocext_smart_search_strict_master_function') && !$products[$key]['rang']){
                        unset($products[$key]);
                    }
                }
                
                if(isset($products) && $products){
                    usort($products, array('ModelToolOcextSmartSearch','cmp_obj'));
                    $sql = array();
                    
                    
                    
                    if(count($words)>=9){
                        $max_weight = 1000;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function');
                        }
                    }
                    elseif(count($words)>=7){
                        $max_weight = 1000;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function');
                        }
                    }
                    else{
                        $max_weight = 500;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function') / 2;
                        }
                    }
                    
                    
                    
                    foreach ($products as $product) {
                        if($product['rang']>=$max_weight){
                            $sql[$product['product_id']] = " p.product_id = ".$product['product_id'];
                            $resutlt['sort'][$product['product_id']] = $product['rang'];
                        }
                    }
                    
                    if($sql){
                        $resutlt['sql'] = " AND (".implode(' OR ', $sql)." ) ".$sku_sql;
                    }
                    
                }
            }
            
            $sql_sorted = array();
            if($resutlt['sql'] && $resutlt['sort']){
                arsort($resutlt['sort']);
                foreach ($resutlt['sort'] as $product_id_sort => $tmp_rang) {
                    $sql_sorted[] = $product_id_sort;
                }
            }
            
            if(isset($this->request->get['us'])){
                $this->updateStatistic($keyword, $resutlt['sort']);
                return;
            }
            
            if($ajax){

                if($sql && $this->config->get('ocext_ajax_products')){
                    $ajax_result['products']['sql'] = " AND (".implode(' OR ', $sql)." ) ".$sku_sql;
                    if($sql_sorted){
                        $ajax_result['products']['sql_sorted'] = " ORDER BY Field(p.product_id, ".implode(',',$sql_sorted).") ";
                    }else{
                        $ajax_result['products']['sql_sorted'] = "  ";
                    }
                }else{
                    $ajax_result['products']['sql'] = '';
                    $ajax_result['products']['sql_sorted'] = "  ";
                }
                
                $ajax_result['manufacturers']['sql'] = '';
                if($this->config->get('ocext_ajax_manufacturer')){
                    $ajax_result['manufacturers']['sql'] = $this->getManufacturers($keyword);
                }
                
                $ajax_result['categories']['sql'] = '';
                if($this->config->get('ocext_ajax_category')){
                    $ajax_result['categories']['sql'] = $this->getCategoriesSql($keyword);
                }

                $ajax_result['keyword'] = $keyword;

                $ajax_result['words'] = $words;

                return $ajax_result;
                
            }
        }
        $this->updateStatistic($keyword, $resutlt['sort']);
        return $resutlt;
    }
    
    public function getCategoriesSql($words){
        
        $keyword = trim($words);
        
        $sku_sql = '';
        
        
        if($this->config->get('config_language')=='ru'){
            $words_eng = $words;
            
            $words_abracadabra = $words;
            $this->cleanAbracadabra($words_abracadabra);
            
            
            $this->cleanPretextRu($words);
            $this->cleanWordEndingsRu($words,TRUE,TRUE);
            $this->cleanPretextRu($words_abracadabra);
            $this->cleanWordEndingsRu($words_abracadabra,TRUE,TRUE);
            
            $this->cleanPretextEn($words_eng);
            $this->cleanWordEndingsEn($words_eng,TRUE,TRUE);
            
            if($words_abracadabra!=$words){
                $words = $this->getMergeArrays($words, $words_abracadabra);
            }
            
            if($words_eng && $words){
                $words = $this->getMergeArrays($words, $words_eng);
            }
        }elseif($this->config->get('config_language')=='en'){
            $this->cleanPretextEn($words);
            $this->cleanWordEndingsEn($words,TRUE,TRUE);
        }else{
            $this->cleanPretextEn($words);
            $this->cleanWordEndingsEn($words,TRUE,TRUE);
        }
        
        $resutlt['sql'] = "";
        $resutlt['sort'] = array();
        if($words){
            array_splice($words, 20);
            if($keyword){
                $words[] = $keyword;
            }
            $sql_result = array();
            foreach ($words as $word) {
                if($this->config->get('ocext_smart_search_category')){
                    $sql[] = " `category` LIKE '%" . $this->db->escape($word) . "%' ";
                }
                if($sql){
                    $sql_result[] = implode(' OR ', $sql);
                }
            }
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocext_smart_search_index WHERE ".implode(' OR ', $sql_result)." ");
            $sql = array();
            if($query->rows){
                $products = array();
                foreach ($query->rows as $key => $product) {
                    $products[$key] = $product;
                    $products[$key]['rang'] = $this->getTotalProductRang($product['rang'], $words);
                    $products[$key]['category_id'] = json_decode($product['categories_id'],TRUE);
                    
                    if($this->config->get('ocext_smart_search_strict_master_function') && !$products[$key]['rang']){
                        unset($products[$key]);
                    }
                }
                
                if(isset($products) && $products){
                    usort($products, array('ModelToolOcextSmartSearch','cmp_obj'));
                    $sql = array();
                    
                    if(count($words)>=9){
                        $max_weight = 1000;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function');
                        }
                    }
                    elseif(count($words)>=7){
                        $max_weight = 1000;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function');
                        }
                    }
                    else{
                        $max_weight = 500;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function') / 2;
                        }
                    }
                    
                    foreach ($products as $product) {
                        if($product['rang']>=$max_weight){
                            foreach ($product['category_id'] as $category_id => $tmp) {
                                
                                
                                $sql_part = array();
                                
                                foreach ($words as $word_category_part) {
                                    $sql_part[] = "( cd.name LIKE '%".$this->db->escape($word_category_part)."%' OR cd.description LIKE '%".$this->db->escape($word_category_part)."%') ";
                                }
                                
                                if($sql_part){
                                    $sql_part = " AND (".implode(' OR ', $sql_part).") ";
                                }else{
                                    $sql_part = '';
                                }
                                
                                $sql[] = " c.category_id = ".(int)$category_id.$sql_part; 
                                
                                
                                
                                $resutlt['sort'][$category_id] = $product['rang'];
                            }
                        }
                    }
                }
            }
            if($sql && $this->config->get('ocext_ajax_category')){
                $resutlt['sql'] = " AND (".implode(' OR ', $sql)." ) ";
            }
        }
        return $resutlt['sql'];
    }
    
    public function getCategoriesToDb($data,$total_categories=FALSE) {
            
		$sql = "SELECT c.category_id AS category_id, cd.name AS name FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' ";

		if($data['sql']){
                    $sql .= $data['sql'];
                }else{
                    $sql .= " AND cp.category_id = 0 ";
                }
                
                
                if ( (isset($data['start']) || isset($data['limit'])) && !$total_categories ) {
                    
                        if ($data['start'] < 0) {
                                $data['start'] = 0;
                        }

                        if ($data['limit'] < 1) {
                                $data['limit'] = 20;
                        }

                        $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
                }
                
		$query = $this->db->query($sql);
                
                if($total_categories){
                    return count($query->rows);
                }else{
                    return $query->rows;
                }
    }
    
    public function getManufacturers($words){
        
        $keyword = trim($words);
        
        $sku_sql = '';
        
        
        if($this->config->get('config_language')=='ru'){
            $words_eng = $words;
            
            $words_abracadabra = $words;
            $this->cleanAbracadabra($words_abracadabra);
            
            
            $this->cleanPretextRu($words);
            $this->cleanWordEndingsRu($words,TRUE,TRUE);
            $this->cleanPretextRu($words_abracadabra);
            $this->cleanWordEndingsRu($words_abracadabra,TRUE,TRUE);
            
            $this->cleanPretextEn($words_eng);
            $this->cleanWordEndingsEn($words_eng,TRUE,TRUE);
            
            if($words_abracadabra!=$words){
                $words = $this->getMergeArrays($words, $words_abracadabra);
            }
            
            if($words_eng && $words){
                $words = $this->getMergeArrays($words, $words_eng);
            }
        }elseif($this->config->get('config_language')=='en'){
            $this->cleanPretextEn($words);
            $this->cleanWordEndingsEn($words,TRUE,TRUE);
        }else{
            $this->cleanPretextEn($words);
            $this->cleanWordEndingsEn($words,TRUE,TRUE);
        }
        
        $resutlt['sql'] = "";
        $resutlt['sort'] = array();
        if($words){
            array_splice($words, 20);
            if($keyword){
                $words[] = $keyword;
            }
            $sql_result = array();
            foreach ($words as $word) {
                if($this->config->get('ocext_smart_search_manufacturer')){
                    $sql[] = " `manufacturer` LIKE '%" . $this->db->escape($word) . "%' ";
                }
                if($sql){
                    $sql_result[] = implode(' OR ', $sql);
                }
            }
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocext_smart_search_index WHERE ".implode(' OR ', $sql_result)." ");
            $sql = array();
            $product_added = array();
            if($query->rows){
                $products = array();
                foreach ($query->rows as $key => $product) {
                    $products[$key] = $product;
                    $products[$key]['rang'] = $this->getTotalProductRang($product['rang'], $words);
                    $products[$key]['manufacturer_id'] = (int)$product['manufacturer_id'];
                    if($this->config->get('ocext_smart_search_strict_master_function') && !$products[$key]['rang']){
                        unset($products[$key]);
                    }
                }
                if(isset($products) && $products){
                    usort($products, array('ModelToolOcextSmartSearch','cmp_obj'));
                    $sql = array();
                    
                    
                    
                    if(count($words)>=9){
                        $max_weight = 1000;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function');
                        }
                    }
                    elseif(count($words)>=7){
                        $max_weight = 1000;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function');
                        }
                    }
                    else{
                        $max_weight = 500;
                        if($this->config->get('ocext_smart_search_strict_master_function')){
                            $max_weight = $this->config->get('ocext_smart_search_strict_master_function') / 2;
                        }
                    }
                    
                    
                    
                    foreach ($products as $product) {
                        if($product['rang']>=$max_weight){
                            
                            if(!isset($product_added[$product['manufacturer_id']])){
                                $sql[] = " m.manufacturer_id = ".(int)$product['manufacturer_id'];
                                $product_added[$product['manufacturer_id']] = TRUE;
                            }
                            
                            $resutlt['sort'][$product['manufacturer_id']] = $product['rang'];
                        }
                    }
                }
            }
            if($sql && $this->config->get('ocext_ajax_manufacturer')){
                $resutlt['sql'] = " AND (".implode(' OR ', $sql)." ) ".$sku_sql;
            }
        }
        return $resutlt['sql'];
    }
    
    
    function cmp_obj($a, $b){
        if ($a["rang"] == $b["rang"]) {
        return 0;
        }
        return ($a["rang"] < $b["rang"]) ? 1 : -1;
    }
    
    private function getTotalProductRang($rang,$words_array){
        $rang = json_decode($rang, TRUE);
        $total_product_rang = 0;
        for($i_words=0;$i_words<count($words_array);$i_words++){
            $weight[] = 100;
        }
        if(count($words_array)>=20){
            $weight[0] = 1000;
            $weight[1] = 1000;
            $weight[2] = 1000;
            $weight[3] = 1000;
            $weight[4] = 1000;
            $weight[5] = 500;
            $weight[6] = 500;
            $weight[7] = 1000;
            $weight[8] = 1000;
            $weight[9] = 1000;
            $weight[10] = 1000;
            $weight[11] = 500;
            $weight[12] = 500;
            $weight[13] = 1000;
            $weight[14] = 1000;
            $weight[15] = 1000;
            $weight[16] = 500;
            $weight[17] = 250;
            $weight[18] = 250;
            $weight[19] = 250;
        }elseif(count($words_array)>=12){
            $weight[0] = 1000;
            $weight[1] = 1000;
            $weight[2] = 1000;
            $weight[3] = 500;
            $weight[4] = 1000;
            $weight[5] = 1000;
            $weight[6] = 1000;
            $weight[7] = 500;
            $weight[8] = 500;
            $weight[9] = 1000;
            $weight[10] = 1000;
            $weight[11] = 500;
            $weight[12] = 500;
        }elseif(count($words_array)>=6){
            $weight[0] = 1000;
            $weight[1] = 1000;
            $weight[2] = 1000;
            $weight[3] = 500;
            $weight[4] = 1000;
            $weight[5] = 1000;
            $weight[6] = 500;
            $weight[7] = 1000;
        }elseif(count($words_array)>=3){
            $weight[0] = 1000;
            $weight[1] = 1000;
            $weight[2] = 500;
        }elseif(count($words_array)==2){
            $weight[0] = 1000;
            $weight[1] = 1000;
        }
        
        
        foreach ($words_array as $position=>$keyword) {
            $keyword = mb_strtolower($keyword,'UTF-8');
            
            if(isset($rang['product'][$keyword])){
                if(isset($weight[$position])){
                    $total_product_rang += $weight[$position];
                }
                $total_product_rang += $rang['product'][$keyword];
            }elseif ($this->getStristrIntoIndex($rang['product'], $keyword)) {
                if(isset($weight[$position])){
                    $total_product_rang += $weight[$position];
                }
                $total_product_rang += $rang['product'][ $this->getStristrIntoIndex($rang['product'], $keyword) ];
            }
            
            
            if($this->config->get('ocext_smart_search_attribute')){
                if(isset($rang['attribute'][$keyword])){
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['attribute'][$keyword];
                }elseif ($this->getStristrIntoIndex($rang['attribute'], $keyword)) {
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['attribute'][ $this->getStristrIntoIndex($rang['attribute'], $keyword) ];

                }
            }
            
            
            if($this->config->get('ocext_smart_search_option')){
                if(isset($rang['options'][$keyword])){
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['options'][$keyword];
                }elseif ($this->getStristrIntoIndex($rang['options'], $keyword)) {
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['options'][ $this->getStristrIntoIndex($rang['options'], $keyword) ];

                }
            }
            
            
            if($this->config->get('ocext_smart_search_category')){
                if(isset($rang['category'][$keyword])){
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['category'][$keyword];
                }elseif ($this->getStristrIntoIndex($rang['category'], $keyword)) {
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['category'][ $this->getStristrIntoIndex($rang['category'], $keyword) ];

                }
            }
            
            
            if($this->config->get('ocext_smart_search_manufacturer')){
                if(isset($rang['manufacturer'][$keyword])){
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['manufacturer'][$keyword];
                }elseif ($this->getStristrIntoIndex($rang['manufacturer'], $keyword)) {
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['manufacturer'][ $this->getStristrIntoIndex($rang['manufacturer'], $keyword) ];

                }
            }
            
            
            if($this->config->get('ocext_smart_search_review')){
                if(isset($rang['review'][$keyword])){
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['review'][$keyword];
                }elseif ($this->getStristrIntoIndex($rang['review'], $keyword)) {
                    if(isset($weight[$position])){
                        $total_product_rang += $weight[$position];
                    }
                    $total_product_rang += $rang['review'][ $this->getStristrIntoIndex($rang['review'], $keyword) ];

                }
            }
        }
        return $total_product_rang;
    }
    
    public function cleanAbracadabra(&$words) {
        $new_words = '';
        if($words){
            $find = array("q","w","e","r","t","y","u","i","o","p","[","]","a","s","d","f","g","h","j","k","l",";","'","z","x","c","v","b","n","m",",",".","`");
            $replace = array("й","ц","у","к","е","н","г","ш","щ","з","х","ъ","ф","ы","в","а","п","р","о","л","д","ж","э","я","ч","с","м","и","т","ь","б","ю","ё");
            foreach (str_split( $words ) as $word) {
                $new_words .= str_replace($find, $replace, $word);
            }
        }
        $words = $new_words;
        return $words;
    }
    
    public function getStristrIntoIndex($rangs,$keyword) {
        if($rangs){
            foreach ($rangs as $rang=>$tmp) {
                if(stristr($rang, $keyword)){
                    return $rang;
                }
            }
        }
        return FALSE;
    }

    public function cleanPretextRu(&$words,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),'',$words);
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
    
    private function getArrayWhisVariationKeywordsRu($words){
        $word_array = explode(' ', $words);
        $result = array();
        $two_word = '';
        $two_word_revers = '';
        if(!$word_array || !is_array($word_array)){
            return $result;
        }
        if($words){
            $result[] = trim($words);
        }
        $word_array_revers = array_reverse($word_array);
        $count = count($word_array);
        for($i = 1;$i<=$count;$i++){
            $text = '';
            $text_revers = '';
            foreach ($word_array as $key => $word) {
                $this->cleanWordEndingsRuOnlyClean($word,FALSE, FALSE, TRUE);
                $word = trim($word);
                //зопоминаем второе слово
                if($key==1){
                    $two_word = $word;
                }
                
                if($word){
                    $text .= $word.' ';
                }
            }
            
            foreach ($word_array_revers as $word_revers) {
                $this->cleanWordEndingsRuOnlyClean($word_revers,FALSE, FALSE, TRUE);
                $word_revers = trim($word_revers);
                //зопоминаем второе слово
                if($key==1){
                    $two_word_revers = $word_revers;
                }
                
                if($word_revers){
                    $text_revers .= $word_revers.' ';
                }
            }
            $text = trim($text);
            $text_revers = trim($text_revers);
            
            if($text){
                $result[] = $text;
            }
            if($text_revers){
                $result[] = $text_revers;
            }
            unset($word_array[$key]);
            unset($word_array_revers[$key]);
        }
        if($two_word){
            $result[] = $two_word;
        }
        if($two_word_revers){
            $result[] = $two_word_revers;
        }
        return $result;
    }
    
    private function getArrayWhisVariationKeywordsEn($words){
        $word_array = explode(' ', $words);
        $result = array();
        $two_word = '';
        $two_word_revers = '';
        if(!$word_array || !is_array($word_array)){
            return $result;
        }
        if($words){
            $result[] = trim($words);
        }
        $word_array_revers = array_reverse($word_array);
        $count = count($word_array);
        for($i = 1;$i<=$count;$i++){
            $text = '';
            $text_revers = '';
            foreach ($word_array as $key => $word) {
                $this->cleanWordEndingsEnOnlyClean($word,FALSE, FALSE, TRUE);
                $word = trim($word);
                //зопоминаем второе слово
                if($key==1){
                    $two_word = $word;
                }
                
                if($word){
                    $text .= $word.' ';
                }
            }
            
            foreach ($word_array_revers as $word_revers) {
                $this->cleanWordEndingsEnOnlyClean($word_revers,FALSE, FALSE, TRUE);
                $word_revers = trim($word_revers);
                //зопоминаем второе слово
                if($key==1){
                    $two_word_revers = $word_revers;
                }
                
                if($word_revers){
                    $text_revers .= $word_revers.' ';
                }
            }
            $text = trim($text);
            $text_revers = trim($text_revers);
            
            if($text){
                $result[] = $text;
            }
            if($text_revers){
                $result[] = $text_revers;
            }
            unset($word_array[$key]);
            unset($word_array_revers[$key]);
        }
        if($two_word){
            $result[] = $two_word;
        }
        if($two_word_revers){
            $result[] = $two_word_revers;
        }
        return $result;
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
        
        $word_array = $this->getArrayWhisVariationKeywordsRu($words);
        if(!$word_array || !is_array($word_array)){
            return;
        }
        $result = '';
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
        
        $word_array = $this->getArrayWhisVariationKeywordsEn($words);
        
        if(!$word_array || !is_array($word_array)){
            return;
        }
        $result = '';
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
    
    public function cleanWordEndingsRuOnlyClean(&$words,$returnArray=FALSE,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
        if($cleanHTML){
            $words = trim(strip_tags(html_entity_decode($words,ENT_QUOTES)));
            $words = str_replace(array("\r\n", "\r", "\n"),' ',$words);
            $words = preg_replace ('/\\s+/', ' ',  $words); 
        }
        
        $words = mb_strtolower($words, 'UTF-8');
        $words = trim($words);
        
        //return;
        
        
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
        /*
        if($word_array && is_array($word_array) && !$ignorDotAndComa){
            
            foreach ($word_array as $key => $value) {
                $this->checkNumber($value);
                if(!$value){
                    unset($word_array[$key]);
                }else{
                    $word_array[$key] = $value;
                }
            }
        }
         * 
         */
        
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
    
    public function cleanWordEndingsEnOnlyClean(&$words,$returnArray=FALSE,$cleanHTML=FALSE,$ignorDotAndComa=FALSE){
        
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
    
    private function updateStatistic($keyword,$index_elements){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "ocext_smart_search_statistic` WHERE keyword = '" . $this->db->escape($keyword) . "'");
        if($query->row){
            $latest_index_elements = json_decode($query->row['index_elements'], TRUE);
            $index_elements += $latest_index_elements;
            $index_elements = json_encode($index_elements);
            $used = ++$query->row['used'];
            $this->db->query("UPDATE " . DB_PREFIX . "ocext_smart_search_statistic SET used = '".$used."', index_elements = '".$index_elements."' WHERE  keyword = '" . $this->db->escape($keyword) . "'  ");
        }else{
            $index_elements = json_encode($index_elements);
            $this->db->query("INSERT INTO " . DB_PREFIX . "ocext_smart_search_statistic SET used = '1' , index_elements = '".$index_elements."', keyword = '" . $this->db->escape($keyword) . "', date_added = NOW()");
        }
        
    }
    
    private function getMergeArrays($array1,$array2) {
        $result = array();
        $dublicate = array();
        if($array1){
            foreach ($array1 as $value1) {
                if(!isset($dublicate[$value1])){
                    $result[] = $value1;
                }
                $dublicate[$value1] = $value1;
            }
        }
        if($array2){
            foreach ($array2 as $value2) {
                    if(!isset($dublicate[$value2])){
                        $result[] = $value2;
                    }
                $dublicate[$value2] = $value2;
            }
        }
        return $result;
    }
    
    public function getManufacturersToDb($data = array(),$total_manufacturers=FALSE) {
        
            $sql = "SELECT * FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ";

            if($data['sql']){
                $sql .= $data['sql'];
            }else{
                $sql .= " AND m.manufacturer_id = 0 ";
            }
            
            if ( (isset($data['start']) || isset($data['limit'])) && !$total_manufacturers ) {
                    if ($data['start'] < 0) {
                            $data['start'] = 0;
                    }

                    if ($data['limit'] < 1) {
                            $data['limit'] = 20;
                    }

                    $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }
            $query = $this->db->query($sql);
            
            if($total_manufacturers){
                return count($query->rows);
            }

            return $query->rows;
        
    }
    
    public function getProductsToDb($data = array(),$total_products=FALSE,$manufacturer_id=FALSE) {
        
		$sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";

		$sql .= " FROM " . DB_PREFIX . "product p";

		$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

                $product_data = array();
                
                if($data['sql']){
                    $sql .= $data['sql'];
                }else{
                    $sql .= " AND p.product_id = 0 ";
                }
                
                if($manufacturer_id){
                    $sql .= " AND p.manufacturer_id = ".(int)$manufacturer_id;
                }
                
		$sql .= " GROUP BY p.product_id";
                
                if(isset($data['sql_sorted'])){
                    $sql .= $data['sql_sorted'];
                }
                
		if ((isset($data['start']) || isset($data['limit'])) && !$total_products) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
                
		$query = $this->db->query($sql);
                
                if($total_products || $manufacturer_id){
                    return count($query->rows);
                }

                $this->load->model('catalog/product');
                
		foreach ($query->rows as $result) {
			$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
		}

		return $product_data;
	}
        
        public function getCategories($product_id) {
                $this->load->model('catalog/product');
                $categories = $this->model_catalog_product->getCategories($product_id);
                $category_id = 0;
                if($categories){
                    $category_id = $categories[0]['category_id'];
                }
            
		$sql = "SELECT cp.category_id AS category_id, GROUP_CONCAT(cd1.name ORDER BY cp.level SEPARATOR '&nbsp;&nbsp;&gt;&nbsp;&nbsp;') AS name, c1.parent_id, c1.sort_order FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c1 ON (cp.category_id = c1.category_id) LEFT JOIN " . DB_PREFIX . "category c2 ON (cp.path_id = c2.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (cp.category_id = cd2.category_id) WHERE cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if ($category_id) {
			$sql .= " AND cd2.category_id = '" . $category_id . "' ";
                }else{
                    return '';
                }

		$sql .= " GROUP BY cp.category_id";

		$query = $this->db->query($sql);
                
                if($query->row['name']){
                    return $query->row['name'];
                }else{
                    return '';
                }
	}
        
        public function getProductsManufacturersByToDb($manufacturer_id) {
        
		$sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";

		$sql .= " FROM " . DB_PREFIX . "product p";

		$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

                $sql .= " AND p.manufacturer_id = ".(int)$manufacturer_id;
                
		$sql .= " GROUP BY p.product_id";
                
		$query = $this->db->query($sql);
                
                return count($query->rows);
	}
        
        public function getProductsCategoriesByToDb($category_id) {
        
		$sql = "SELECT * FROM " . DB_PREFIX . "product_to_category WHERE ";

                $sql .= " category_id = ".(int)$category_id;
                
		$query = $this->db->query($sql);
                
                return count($query->rows);
	}
        
    
}
?>
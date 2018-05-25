<?php
class ModelToolSmartSearch extends Model {
    
        public function updateSearchData(&$words){
            $this->cleanPretext($words);
            $this->cleanWordEndings($words);
        } 

        public function cleanPretext(&$words){
        
            if(!$words){
                return;
            }

            $word_array = explode(' ', $words);
            if(!$word_array || !is_array($word_array)){
                return;
            }

            $result = '';
            $pretexts = array('у',',','.','-', 'о', 'в', 'с', 'к', 'за', 'до', 'на','обо','об','при', 'по', 'из', 'от', 'над', 'под', 'про', 'без', 'для', 'ради', 'через','все','всё');

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
    
    public function cleanWordEndings(&$words,$only_last_word=FALSE){
        
        if(!$words){
            return;
        }
        
        if(!$only_last_word){
            $word_array = explode(' ', $words);
        }elseif($only_last_word){
            $word_array[0] = $words;
        }
        if(!$word_array || !is_array($word_array)){
            return;
        }
        
        $result = '';
        
        foreach ($word_array as $key_tmp_word=>$word) {
            if($word){
                
                $count_symbols = mb_strlen($word,'UTF-8');

                if($count_symbols>3){
                    
                    $finwords = array('а', 'я', 'о','и', 'е', 'ы', 'ка', 'ки', 'ке', 'ку', 'ал', 'ил',  'ю', 'ел', 'ный', 'ней', 'ная', 'ное', 'ные', 'ол', 'у','ом','ем','ые','ую','ою','ое','ая','ой', 'ою', 'ей', 'ею', 'ете','ые','ый', 'ами', 'ям', 'ями', 'ов', 'ев', 'ах', 'ях', 'ит', 'ут', 'им', 'й', 'ся', 'ь', 'ет', 'ик','ть','ешь','ишь','ишься','ешься','ющься','ющь','ещь','ут','ют','ся','ться','вши','чи','вшу','вша');
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==5){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                                
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==4){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==3){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==2){

                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                            }
                        }
                    }
                    foreach($finwords as $num=>$finword){
                        if(mb_strlen($finword,'UTF-8')==1){
                            $fin_check = mb_strcut($word, (strlen($word) - strlen($finword)), strlen($word), 'UTF-8');
                            if($fin_check == $finword){
                                $word_array[$key_tmp_word] = mb_strcut($word, 0, (strlen($word) - strlen($finword)), 'UTF-8');
                            }
                        }
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
}
?>
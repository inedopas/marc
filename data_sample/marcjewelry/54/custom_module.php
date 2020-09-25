<?php 

$language_id = 2;
foreach($data['languages'] as $language) {
	if($language['language_id'] != 1) {
		$language_id = $language['language_id'];
	}
}

$output = array();
$output["custom_module_module"] = array (
  1 => 
  array (
    'type' => '2',
    'block_heading' => 
    array (
      1 => '',
      $language_id => '',
    ),
    'block_content' => 
    array (
      1 => '&lt;p&gt;&lt;br&gt;&lt;/p&gt;',
      $language_id => '&lt;p&gt;&lt;br&gt;&lt;/p&gt;',
    ),
    'html' => 
    array (
      1 => '&lt;div style=&quot;height: 10px&quot; class=&quot;hidden-xs&quot;&gt;&lt;/div&gt;',
      $language_id => '&lt;div style=&quot;height: 10px&quot; class=&quot;hidden-xs&quot;&gt;&lt;/div&gt;',
    ),
    'layout_id' => '1',
    'position' => 'content_bottom',
    'status' => '1',
    'sort_order' => '20',
  ),
  2 => 
  array (
    'type' => '2',
    'block_heading' => 
    array (
      1 => '',
      $language_id => '',
    ),
    'block_content' => 
    array (
      1 => '&lt;p&gt;&lt;br&gt;&lt;/p&gt;',
      $language_id => '&lt;p&gt;&lt;br&gt;&lt;/p&gt;',
    ),
    'html' => 
    array (
      1 => '&lt;div class=&quot;row banners banners-with-padding-0-2 responsive-margin-top-0&quot; style=&quot;position: relative;margin-top: -179px;z-index: 22&quot;&gt;
     &lt;div class=&quot;col-sm-6&quot;&gt;
          &lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;image/catalog/lingerie/banner-01.png&quot; alt=&quot;Banner&quot;&gt;&lt;/a&gt;
          &lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;image/catalog/lingerie/banner-03.png&quot; style=&quot;margin-top: 30px;margin-right: 0px&quot; alt=&quot;Banner&quot;&gt;&lt;/a&gt;
     &lt;/div&gt;
     &lt;div class=&quot;col-sm-6&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;image/catalog/lingerie/banner-02.png&quot; alt=&quot;Banner&quot;&gt;&lt;/a&gt;&lt;/div&gt;
&lt;/div&gt;',
      $language_id => '&lt;div class=&quot;row banners banners-with-padding-0-2 responsive-margin-top-0&quot; style=&quot;position: relative;margin-top: -179px;z-index: 22&quot;&gt;
     &lt;div class=&quot;col-sm-6&quot;&gt;
          &lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;image/catalog/lingerie/banner-01.png&quot; alt=&quot;Banner&quot;&gt;&lt;/a&gt;
          &lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;image/catalog/lingerie/banner-03.png&quot; style=&quot;margin-top: 30px;margin-right: 0px&quot; alt=&quot;Banner&quot;&gt;&lt;/a&gt;
     &lt;/div&gt;
     &lt;div class=&quot;col-sm-6&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;image/catalog/lingerie/banner-02.png&quot; alt=&quot;Banner&quot;&gt;&lt;/a&gt;&lt;/div&gt;
&lt;/div&gt;',
    ),
    'layout_id' => '1',
    'position' => 'preface_fullwidth',
    'status' => '1',
    'sort_order' => '0',
  ),
  3 => 
  array (
    'type' => '2',
    'block_heading' => 
    array (
      1 => '',
      $language_id => '',
    ),
    'block_content' => 
    array (
      1 => '&lt;p&gt;&lt;br&gt;&lt;/p&gt;',
      $language_id => '&lt;p&gt;&lt;br&gt;&lt;/p&gt;',
    ),
    'html' => 
    array (
      1 => '&lt;div class=&quot;lingerie-free-shipping&quot;&gt;
     &lt;img src=&quot;image/catalog/lingerie/icon-free-shipping.png&quot; alt=&quot;Free shipping&quot;&gt;
     Free shipping for all orders over $400
&lt;/div&gt;',
      $language_id => '&lt;div class=&quot;lingerie-free-shipping&quot;&gt;
     &lt;img src=&quot;image/catalog/lingerie/icon-free-shipping.png&quot; alt=&quot;Free shipping&quot;&gt;
     Free shipping for all orders over $400
&lt;/div&gt;',
    ),
    'layout_id' => '99999',
    'position' => 'top_block',
    'status' => '1',
    'sort_order' => '',
  ),
); 

$output2 = array();
$output2["custom_module_module"] = $this->config->get('custom_module_module');

if(!is_array($output["custom_module_module"])) $output["custom_module_module"] = array();
if(!is_array($output2["custom_module_module"])) $output2["custom_module_module"] = array();
$output3 = array();
$output3["custom_module_module"] = array_merge($output["custom_module_module"], $output2["custom_module_module"]);

$this->model_setting_setting->editSetting( "custom_module", $output3 );	

?>
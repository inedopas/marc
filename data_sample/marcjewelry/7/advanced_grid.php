<?php

$language_id = 2;
foreach($data['languages'] as $language) {
	if($language['language_id'] != 1) {
		$language_id = $language['language_id'];
	}
}

$output = array();
$output["advanced_grid_module"] = array (
  1 =>
  array (
    'custom_class' => '',
    'margin_top' => '0',
    'margin_right' => '0',
    'margin_bottom' => '0',
    'margin_left' => '0',
    'padding_top' => '0',
    'padding_right' => '0',
    'padding_bottom' => '0',
    'padding_left' => '0',
    'force_full_width' => '0',
    'background_color' => '',
    'background_image_type' => '0',
    'background_image' => '',
    'background_image_position' => 'top left',
    'background_image_repeat' => 'no-repeat',
    'background_image_attachment' => 'scroll',
    'layout_id' => '99999',
    'position' => 'footer',
    'status' => '1',
    'sort_order' => '',
    'disable_on_mobile' => '0',
    'column' =>
    array (
      1 =>
      array (
        'status' => '1',
        'width' => '3',
        'disable_on_mobile' => '0',
        'width_xs' => '1',
        'width_sm' => '1',
        'width_md' => '1',
        'width_lg' => '1',
        'sort' => '1',
        'module' =>
        array (
          1 =>
          array (
            'status' => '1',
            'sort' => '',
            'type' => 'html',
            'html' =>
            array (
              1 => '&lt;div class=&quot;footer-about-us&quot;&gt;
     &lt;img src=&quot;image/catalog/gardentools/logo-footer.png&quot; alt=&quot;Marcjewelry&quot;&gt;
     &lt;h6 style=&quot;color: #fff&quot;&gt;PO Box 16122 Collins Street &lt;br&gt;Victoria 8007 Australia&lt;/h6&gt;
     &lt;ul class=&quot;social-icons&quot;&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-twitter&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-facebook&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-youtube-play&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-github&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-behance&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
     &lt;/ul&gt;
&lt;/div&gt;',
              $language_id => '&lt;div class=&quot;footer-about-us&quot;&gt;
     &lt;img src=&quot;image/catalog/gardentools/logo-footer.png&quot; alt=&quot;Marcjewelry&quot;&gt;
     &lt;h6 style=&quot;color: #fff&quot;&gt;PO Box 16122 Collins Street &lt;br&gt;Victoria 8007 Australia&lt;/h6&gt;
     &lt;ul class=&quot;social-icons&quot;&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-twitter&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-facebook&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-youtube-play&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-github&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;#&quot;&gt;&lt;i class=&quot;fa fa-behance&quot;&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;
     &lt;/ul&gt;
&lt;/div&gt;',
            ),
            'module' =>
            array (
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'links' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'limit' => '5',
            ),
            'products' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'get_products_from' => 'latest',
              'product' => '',
              'products' => '',
              'category' => '',
              'categories' => '',
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'newsletter' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'input_placeholder' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'subscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'unsubscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'latest_blogs' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'load_module' =>
            array (
              'module' => 'account',
            ),
          ),
        ),
      ),
      2 =>
      array (
        'status' => '1',
        'width' => '3',
        'disable_on_mobile' => '0',
        'width_xs' => '1',
        'width_sm' => '1',
        'width_md' => '1',
        'width_lg' => '1',
        'sort' => '2',
        'module' =>
        array (
          1 =>
          array (
            'status' => '1',
            'sort' => '',
            'type' => 'links',
            'html' =>
            array (
              1 => '',
              $language_id => '',
            ),
            'module' =>
            array (
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'links' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => 'Custom block',
                $language_id => 'Custom block',
              ),
              'limit' => '5',
              'array' =>
              array (
                1 =>
                array (
                  'name' =>
                  array (
                    1 => 'About us',
                    $language_id => 'About us',
                  ),
                  'url' => 'index.php?route=information/information&amp;information_id=4',
                  'sort' => '1',
                ),
                2 =>
                array (
                  'name' =>
                  array (
                    1 => 'Delivery information',
                    $language_id => 'Delivery information',
                  ),
                  'url' => 'index.php?route=information/information&amp;information_id=6',
                  'sort' => '2',
                ),
                3 =>
                array (
                  'name' =>
                  array (
                    1 => 'Privacy Policy',
                    $language_id => 'Privacy Policy',
                  ),
                  'url' => 'index.php?route=information/information&amp;information_id=3',
                  'sort' => '3',
                ),
                4 =>
                array (
                  'name' =>
                  array (
                    1 => 'Terms &amp; Conditions',
                    $language_id => 'Terms &amp; Conditions',
                  ),
                  'url' => 'index.php?route=information/information&amp;information_id=5',
                  'sort' => '4',
                ),
                5 =>
                array (
                  'name' =>
                  array (
                    1 => 'Contact us',
                    $language_id => 'Contact us',
                  ),
                  'url' => 'index.php?route=information/contact',
                  'sort' => '5',
                ),
              ),
            ),
            'products' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'get_products_from' => 'latest',
              'product' => '',
              'products' => '',
              'category' => '',
              'categories' => '',
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'newsletter' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'input_placeholder' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'subscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'unsubscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'latest_blogs' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'load_module' =>
            array (
              'module' => 'account',
            ),
          ),
        ),
      ),
      3 =>
      array (
        'status' => '1',
        'width' => '3',
        'disable_on_mobile' => '0',
        'width_xs' => '1',
        'width_sm' => '1',
        'width_md' => '1',
        'width_lg' => '1',
        'sort' => '3',
        'module' =>
        array (
          1 =>
          array (
            'status' => '1',
            'sort' => '',
            'type' => 'links',
            'html' =>
            array (
              1 => '',
              $language_id => '',
            ),
            'module' =>
            array (
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'links' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => 'Put here',
                $language_id => 'Put here',
              ),
              'limit' => '7',
              'array' =>
              array (
                6 =>
                array (
                  'name' =>
                  array (
                    1 => 'My account',
                    $language_id => 'My account',
                  ),
                  'url' => 'index.php?route=account/account',
                  'sort' => '1',
                ),
                7 =>
                array (
                  'name' =>
                  array (
                    1 => 'Order History',
                    $language_id => 'Order History',
                  ),
                  'url' => 'index.php?route=account/order',
                  'sort' => '2',
                ),
                8 =>
                array (
                  'name' =>
                  array (
                    1 => 'Wish List',
                    $language_id => 'Wish List',
                  ),
                  'url' => 'index.php?route=account/wishlist',
                  'sort' => '3',
                ),
                9 =>
                array (
                  'name' =>
                  array (
                    1 => 'Newsletter',
                    $language_id => 'Newsletter',
                  ),
                  'url' => 'index.php?route=account/newsletter',
                  'sort' => '4',
                ),
                10 =>
                array (
                  'name' =>
                  array (
                    1 => 'Returns',
                    $language_id => 'Returns',
                  ),
                  'url' => 'index.php?route=account/return/add',
                  'sort' => '5',
                ),
              ),
            ),
            'products' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'get_products_from' => 'latest',
              'product' => '',
              'products' => '',
              'category' => '',
              'categories' => '',
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'newsletter' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'input_placeholder' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'subscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'unsubscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'latest_blogs' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'load_module' =>
            array (
              'module' => 'account',
            ),
          ),
        ),
      ),
      4 =>
      array (
        'status' => '1',
        'width' => '3',
        'disable_on_mobile' => '0',
        'width_xs' => '1',
        'width_sm' => '1',
        'width_md' => '1',
        'width_lg' => '1',
        'sort' => '4',
        'module' =>
        array (
          1 =>
          array (
            'status' => '1',
            'sort' => '',
            'type' => 'box',
            'html' =>
            array (
              1 => '',
              $language_id => '',
            ),
            'module' =>
            array (
              'title' =>
              array (
                1 => 'Contact',
                $language_id => 'Contact',
              ),
              'text' =>
              array (
                1 => '&lt;div style=&quot;line-height:30px&quot;&gt;Phone: +48 400-400-400&lt;br&gt;
Fax: +29 213-213-11&lt;br&gt;
Skype: zverus777&lt;br&gt;
E-mail: ihor@nedopas.com&lt;/div&gt;',
                $language_id => '&lt;div style=&quot;line-height:30px&quot;&gt;Phone: +48 400-400-400&lt;br&gt;
Fax: +29 213-213-11&lt;br&gt;
Skype: zverus777&lt;br&gt;
E-mail: ihor@nedopas.com&lt;/div&gt;',
              ),
            ),
            'links' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'limit' => '5',
            ),
            'products' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => 'What you want',
                $language_id => 'What you want',
              ),
              'get_products_from' => 'latest',
              'product' => '',
              'products' => '',
              'category' => '',
              'categories' => '',
              'width' => '83',
              'height' => '83',
              'limit' => '2',
            ),
            'newsletter' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'input_placeholder' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'subscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'unsubscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'latest_blogs' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'load_module' =>
            array (
              'module' => 'account',
            ),
          ),
        ),
      ),
      5 =>
      array (
        'status' => '1',
        'width' => '12',
        'disable_on_mobile' => '0',
        'width_xs' => '1',
        'width_sm' => '1',
        'width_md' => '1',
        'width_lg' => '1',
        'sort' => '6',
        'module' =>
        array (
          1 =>
          array (
            'status' => '1',
            'sort' => '',
            'type' => 'html',
            'html' =>
            array (
              1 => 'Copyright © 2015, Your Store, All Rights Reserved.',
              $language_id => 'Copyright © 2015, Your Store, All Rights Reserved.',
            ),
            'module' =>
            array (
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'links' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'limit' => '5',
            ),
            'products' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'get_products_from' => 'latest',
              'product' => '',
              'products' => '',
              'category' => '',
              'categories' => '',
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'newsletter' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'input_placeholder' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'subscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'unsubscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'latest_blogs' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'load_module' =>
            array (
              'module' => 'account',
            ),
          ),
        ),
      ),
    ),
  ),
  2 =>
  array (
    'custom_class' => '',
    'margin_top' => '63',
    'margin_right' => '0',
    'margin_bottom' => '0',
    'margin_left' => '0',
    'padding_top' => '0',
    'padding_right' => '0',
    'padding_bottom' => '0',
    'padding_left' => '0',
    'force_full_width' => '1',
    'background_color' => '',
    'background_image_type' => '1',
    'background_image' => 'catalog/gardentools/bg-newsletter.png',
    'background_image_position' => 'top center',
    'background_image_repeat' => 'repeat-x',
    'background_image_attachment' => 'scroll',
    'layout_id' => '1',
    'position' => 'content_bottom',
    'status' => '1',
    'sort_order' => '1',
    'disable_on_mobile' => '1',
    'column' =>
    array (
      6 =>
      array (
        'status' => '1',
        'width' => '12',
        'disable_on_mobile' => '0',
        'width_xs' => 'hidden',
        'width_sm' => 'hidden',
        'width_md' => 'hidden',
        'width_lg' => '12',
        'sort' => '',
        'module' =>
        array (
          1 =>
          array (
            'status' => '1',
            'sort' => '',
            'type' => 'newsletter',
            'html' =>
            array (
              1 => '',
              $language_id => '',
            ),
            'module' =>
            array (
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'links' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'limit' => '5',
            ),
            'products' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'get_products_from' => 'latest',
              'product' => '',
              'products' => '',
              'category' => '',
              'categories' => '',
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'newsletter' =>
            array (
              'module_layout' => 'gardentools_newsletter.tpl',
              'title' =>
              array (
                1 => 'Newsletter',
                $language_id => 'Newsletter',
              ),
              'text' =>
              array (
                1 => 'Sign in to our newsletter&lt;br&gt;and receive a ten dollars coupon',
                $language_id => 'Sign in to our newsletter&lt;br&gt;and receive a ten dollars coupon',
              ),
              'input_placeholder' =>
              array (
                1 => 'E-mail',
                $language_id => 'E-mail',
              ),
              'subscribe_text' =>
              array (
                1 => 'Send',
                $language_id => 'Send',
              ),
              'unsubscribe_text' =>
              array (
                1 => '',
                $language_id => '',
              ),
            ),
            'latest_blogs' =>
            array (
              'module_layout' => 'default.tpl',
              'title' =>
              array (
                1 => '',
                $language_id => '',
              ),
              'width' => '80',
              'height' => '80',
              'limit' => '3',
            ),
            'load_module' =>
            array (
              'module' => 'account',
            ),
          ),
        ),
      ),
    ),
  ),
);

$output2 = array();
$output2["advanced_grid_module"] = $this->config->get('advanced_grid_module');

if(!is_array($output["advanced_grid_module"])) $output["advanced_grid_module"] = array();
if(!is_array($output2["advanced_grid_module"])) $output2["advanced_grid_module"] = array();
$output3 = array();
$output3["advanced_grid_module"] = array_merge($output["advanced_grid_module"], $output2["advanced_grid_module"]);

$this->model_setting_setting->editSetting( "advanced_grid", $output3 );

?>

<?php
if($registry->has('theme_options') == false) {
	header("location: themeinstall/index.php");
	exit;
}

$theme_options = $registry->get('theme_options');
$config = $registry->get('config');
$page_direction = $theme_options->get( 'page_direction' );
$background_status = false;
$product_page = true;
$url = $registry->get('url');
$modules_old_opencart = new Modules($registry); ?>
<!DOCTYPE html>
<html class="quickview <?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no-'; } ?>responsive<?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? ' rtl' : '' ) ?>" <?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? 'dir="rtl"' : '' ) ?>>
<head>
     <!-- Google Fonts -->
     <link href="//fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css">
     <?php
     if( $theme_options->get( 'font_status' ) == '1' ) {
     	$lista_fontow = array();
     	if( $theme_options->get( 'body_font' ) != '' && $theme_options->get( 'body_font' ) != 'standard' && $theme_options->get( 'body_font' ) != 'Arial' && $theme_options->get( 'body_font' ) != 'Georgia' && $theme_options->get( 'body_font' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'body_font' );
     		$lista_fontow[$font] = $font;
     	}

     	if( $theme_options->get( 'categories_bar' ) != '' && $theme_options->get( 'categories_bar' ) != 'standard' && $theme_options->get( 'categories_bar' ) != 'Arial' && $theme_options->get( 'categories_bar' ) != 'Georgia' && $theme_options->get( 'categories_bar' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'categories_bar' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'categories_submenu_heading' ) != '' && $theme_options->get( 'categories_submenu_heading' ) != 'standard' && $theme_options->get( 'categories_submenu_heading' ) != 'Arial' && $theme_options->get( 'categories_submenu_heading' ) != 'Georgia' && $theme_options->get( 'categories_submenu_heading' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'categories_submenu_heading' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'categories_box_heading' ) != '' && $theme_options->get( 'categories_box_heading' ) != 'standard' && $theme_options->get( 'categories_box_heading' ) != 'Arial' && $theme_options->get( 'categories_box_heading' ) != 'Georgia' && $theme_options->get( 'categories_box_heading' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'categories_box_heading' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'categories_box_links' ) != '' && $theme_options->get( 'categories_box_links' ) != 'standard' && $theme_options->get( 'categories_box_links' ) != 'Arial' && $theme_options->get( 'categories_box_links' ) != 'Georgia' && $theme_options->get( 'categories_box_links' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'categories_box_links' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'headlines' ) != '' && $theme_options->get( 'headlines' ) != 'standard' && $theme_options->get( 'headlines' ) != 'Arial' && $theme_options->get( 'headlines' ) != 'Georgia' && $theme_options->get( 'headlines' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'headlines' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'footer_headlines' ) != '' && $theme_options->get( 'footer_headlines' ) != 'standard'  && $theme_options->get( 'footer_headlines' ) != 'Arial' && $theme_options->get( 'footer_headlines' ) != 'Georgia' && $theme_options->get( 'footer_headlines' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'footer_headlines' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'page_name' ) != '' && $theme_options->get( 'page_name' ) != 'standard' && $theme_options->get( 'page_name' ) != 'Arial' && $theme_options->get( 'page_name' ) != 'Georgia' && $theme_options->get( 'page_name' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'page_name' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'button_font' ) != '' && $theme_options->get( 'button_font' ) != 'standard' && $theme_options->get( 'button_font' ) != 'Arial' && $theme_options->get( 'button_font' ) != 'Georgia' && $theme_options->get( 'button_font' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'button_font' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'custom_price' ) != '' && $theme_options->get( 'custom_price' ) != 'standard' && $theme_options->get( 'custom_price' ) != 'Arial' && $theme_options->get( 'custom_price' ) != 'Georgia' && $theme_options->get( 'custom_price' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'custom_price' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	if( $theme_options->get( 'sale_new_font' ) != '' && $theme_options->get( 'sale_new_font' ) != 'standard' && $theme_options->get( 'sale_new_font' ) != 'Arial' && $theme_options->get( 'sale_new_font' ) != 'Georgia' && $theme_options->get( 'sale_new_font' ) != 'Times New Roman' ) {
     		$font = $theme_options->get( 'sale_new_font' );
     		if(!isset($lista_fontow[$font])) {
     			$lista_fontow[$font] = $font;
     		}
     	}

     	foreach($lista_fontow as $font) {
     		echo '<link href="//fonts.googleapis.com/css?family=' . $font . ':800,700,600,500,400,300,200,100" rel="stylesheet" type="text/css">';
     		echo "\n";
     	}
     }
     ?>

     <?php $lista_plikow = array(
     		'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/bootstrap.css',
     		'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/animate.css',
     		'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/stylesheet.css',
     		'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/responsive.css',
     		'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/owl.carousel.css',
     		'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/font-awesome.min.css',
     		'catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css'
     );

     //RTL
     if($page_direction[$config->get( 'config_language_id' )] == 'RTL'){
         $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/rtl.css';
         $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/bootstrap_rtl.css';
     }

     echo $theme_options->compressorCodeCss( $config->get($config->get('config_theme') . '_directory'), $lista_plikow, 0, HTTP_SERVER );

     // Custom colors, fonts and backgrounds
     include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/custom_colors.php'); ?>

     <?php $lista_plikow = array();

     $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery-2.1.1.min.js';
     $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery-migrate-1.2.1.min.js';
     $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery.easing.1.3.js';
     $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/bootstrap.min.js';
     $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery.elevateZoom-3.0.3.min.js';
     $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/common.js';
     $lista_plikow[] = 'catalog/view/javascript/jquery/datetimepicker/moment.js';
     $lista_plikow[] = 'catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js';

     echo $theme_options->compressorCodeJs( $config->get($config->get('config_theme') . '_directory'), $lista_plikow, 0, HTTP_SERVER ); ?>

     <script type="text/javascript" src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/owl.carousel.min.js"></script>
	 <script type="text/javascript">
		 var responsive_design = '<?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no'; } else { echo 'yes'; } ?>';
	 </script>
	<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<script src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
					           $(document).ready(function() {
					             $(".thumbnails-carousel").owlCarousel({
					                 autoPlay: 6000, //Set AutoPlay to 3 seconds
					                 navigation: true,
					                 navigationText: ['', ''],
					                 itemsCustom : [
					                   [0, 2],
					                   [450, 2],
					                   [550, 2],
					                   [768, 3],
					                   [1200, 4]
					                 ],
					                 <?php if($page_direction[$config->get( 'config_language_id' )] == 'RTL'): ?>
					                 direction: 'rtl'
					                 <?php endif; ?>
					             });
					           });
					      </script>
</head>
<body class="<?php if($theme_options->get( 'page_width' ) == 2 && $theme_options->get( 'max_width' ) > 900) { echo 'body-full-width'; } ?> <?php if($theme_options->get( 'product_list_type' ) > 0) { echo 'product-list-type-' . $theme_options->get( 'product_list_type' ); } ?> <?php if($theme_options->get( 'product_grid_type' ) > 0) { echo 'product-grid-type-' . $theme_options->get( 'product_grid_type' ); } ?> <?php if($theme_options->get( 'dropdown_menu_type' ) > 0) { echo 'dropdown-menu-type-' . $theme_options->get( 'dropdown_menu_type' ); } ?> <?php if($theme_options->get( 'products_buttons_action' ) > 0) { echo 'products-buttons-action-type-' . $theme_options->get( 'products_buttons_action' ); } ?> <?php if($theme_options->get( 'buttons_prev_next_in_slider' ) > 0) { echo 'buttons-prev-next-type-' . $theme_options->get( 'buttons_prev_next_in_slider' ); } ?> <?php if($theme_options->get( 'inputs_type' ) > 0) { echo 'inputs-type-' . $theme_options->get( 'inputs_type' ); } ?> <?php if($theme_options->get( 'cart_block_type' ) > 0) { echo 'cart-block-type-' . $theme_options->get( 'cart_block_type' ); } ?> <?php if($theme_options->get( 'my_account_type' ) > 0) { echo 'my-account-type-' . $theme_options->get( 'my_account_type' ); } ?> <?php if($theme_options->get( 'top_bar_type' ) > 0) { echo 'top-bar-type-' . $theme_options->get( 'top_bar_type' ); } ?> <?php if($theme_options->get( 'show_vertical_menu' ) > 0) { echo 'show-vertical-megamenu'; } ?> <?php if($theme_options->get( 'product_page_type' ) > 0) { echo 'product-page-type-' . $theme_options->get( 'product_page_type' ); } ?> <?php if($theme_options->get( 'megamenu_type' ) > 0) { echo 'megamenu-type-' . $theme_options->get( 'megamenu_type' ); } ?> <?php if($theme_options->get( 'search_type_in_header' ) > 0) { echo 'search-type-' . $theme_options->get( 'search_type_in_header' ); } ?> <?php if($theme_options->get( 'megamenu_label_type' ) > 0) { echo 'megamenu-label-type-' . $theme_options->get( 'megamenu_label_type' ); } ?> <?php if($theme_options->get( 'box_type' ) == 7) { echo 'box-type-4'; } else { echo 'no-box-type-7'; } ?> <?php if($theme_options->get( 'box_type' ) > 0) { echo 'box-type-' . $theme_options->get( 'box_type' ); } ?> <?php if($theme_options->get( 'header_margin_top' ) > 0) { echo 'header-margin-top-' . $theme_options->get( 'header_margin_top' ); } ?> <?php if($theme_options->get( 'sale_new_type' ) > 0) { echo 'sale-new-type-' . $theme_options->get( 'sale_new_type' ); } ?> <?php if($theme_options->get( 'button_type' ) > 0) { echo 'button-body-type-' . $theme_options->get( 'button_type' ); } ?> <?php if($theme_options->get( 'countdown_special' ) > 0) { echo 'countdown-special-type-' . $theme_options->get( 'countdown_special' ); } ?> <?php if($theme_options->get( 'footer_type' ) > 0) { echo 'footer-type-' . $theme_options->get( 'footer_type' ); } ?> <?php if($theme_options->get( 'breadcrumb_style' ) > 0) { echo 'breadcrumb-style-' . $theme_options->get( 'breadcrumb_style' ); } ?> <?php if($theme_options->get( 'border_width' ) == '1') { echo 'border-width-1'; } else { echo 'border-width-0'; } ?> <?php if(($theme_options->get( 'body_background_color' ) == '#ffffff' || ($theme_options->get( 'main_content_background_color' ) == $theme_options->get( 'body_background_color' ) && $theme_options->get( 'body_background_color' ) != '') || $theme_options->get( 'main_content_background_color' ) == 'none') && $theme_options->get( 'colors_status' ) == '1') { echo 'body-white'; } else { echo 'body-other'; } ?> <?php if($theme_options->get( 'main_content_background_color' ) == 'none' && $theme_options->get( 'colors_status' ) == '1') { echo 'body-white-type-2'; } ?> body-header-type-<?php echo $theme_options->get( 'header_type' ); ?>">

<div id="main">
  <div class="product-info">
      <div itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
			      <h2 class="product-heading"><a href="#" class="review-link"><?php echo $heading_title; ?></a></h2>
  	<div class="row">
  		<div class="col-sm-12">
  			<div class="row" id="quickview_product">
			    <script>
			    	$(document).ready(function(){
			    	    $('#ex1, .review-link').live('click', function () {
			    	         top.location.href = "<?php echo $url->link('product/product&product_id=' . $product_id); ?>";
			    	         return false;
			    	     });

     			    	$('#image').elevateZoom({
     			    		zoomType: "inner",
     			    		cursor: "pointer",
     			    		zoomWindowFadeIn: 500,
     			    		zoomWindowFadeOut: 750
     			    	});

     			    	$('.thumbnails a, .thumbnails-carousel a').click(function() {
     			    		var smallImage = $(this).attr('data-image');
     			    		var largeImage = $(this).attr('data-zoom-image');
     			    		var ez =   $('#image').data('elevateZoom');
     			    		ez.swaptheimage(smallImage, largeImage);
     			    		return false;
     			    	});
			    	});
			    </script>
			    <?php $image_grid = 6; $product_center_grid = 6;
			    if ($theme_options->get( 'product_image_size' ) == 1) {
			    	$image_grid = 4; $product_center_grid = 8;
			    }

			    if ($theme_options->get( 'product_image_size' ) == 3) {
			    	$image_grid = 8; $product_center_grid = 4;
			    }
			    ?>
			    <div class="col-sm-<?php echo $image_grid; ?> popup-gallery">
			    <?php
			      $product_image_top = $modules_old_opencart->getModules('product_image_top');
			      if( count($product_image_top) ) {
			      	foreach ($product_image_top as $module) {
			      		echo $module;
			      	}
			      } ?>
			      <div class="row">
			      	  <?php if ($images && $theme_options->get( 'position_image_additional' ) == 2) { ?>
			      	  <div class="col-sm-2">
						<div class="thumbnails thumbnails-left clearfix">
							<ul>
							  <?php if($thumb) { ?>
						      <li><p><a href="<?php echo $popup; ?>" class="popup-image" data-image="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>"><img src="<?php echo $theme_options->productImageThumb($product_id, $config->get($config->get('config_theme') . '_image_additional_width'), $config->get($config->get('config_theme') . '_image_additional_height')); ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></p></li>
							  <?php } ?>
						      <?php foreach ($images as $image) { ?>
						      <li><p><a href="<?php echo $image['popup']; ?>" class="popup-image" data-image="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></p></li>
						      <?php } ?>
						  </ul>
						</div>
			      	  </div>
			      	  <?php } ?>

				      <div class="col-sm-<?php if($theme_options->get( 'position_image_additional' ) == 2) { echo 10; } else { echo 12; } ?>">
				      	<?php if ($thumb) { ?>
					      <div class="product-image inner-cloud-zoom">
					      	 <?php if($special && $theme_options->get( 'display_text_sale' ) != '0') { ?>
					      	 	<?php $text_sale = 'Sale';
					      	 	if($theme_options->get( 'sale_text', $config->get( 'config_language_id' ) ) != '') {
					      	 		$text_sale = $theme_options->get( 'sale_text', $config->get( 'config_language_id' ) );
					      	 	} ?>
					      	 	<?php if($theme_options->get( 'type_sale' ) == '1') { ?>
					      	 	<?php $product_detail = $theme_options->getDataProduct( $product_id );
					      	 	$roznica_ceny = $product_detail['price']-$product_detail['special'];
					      	 	$procent = ($roznica_ceny*100)/$product_detail['price']; ?>
					      	 	<div class="sale">-<?php echo round($procent); ?>%</div>
					      	 	<?php } else { ?>
					      	 	<div class="sale"><?php echo $text_sale; ?></div>
					      	 	<?php } ?>
					      	 <?php } ?>

					     	 <a href="#" title="<?php echo $heading_title; ?>" id="ex1"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" itemprop="image" data-zoom-image="<?php echo $popup; ?>" /></a>
					      </div>
					  	 <?php } else { ?>
					  	 <div class="product-image">
					  	 	 <a href="#" id="ex1"><img src="image/no_image.jpg" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" itemprop="image" /></a>
					  	 </div>
					  	 <?php } ?>
				      </div>

				      <?php if ($images && $theme_options->get( 'position_image_additional' ) != 2) { ?>
				      <div class="col-sm-12">
				           <div class="overflow-thumbnails-carousel">
     					      <div class="thumbnails-carousel owl-carousel">
     					      	<?php if($thumb) { ?>
     					      	     <div class="item"><a href="<?php echo $popup; ?>" class="popup-image" data-image="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>"><img src="<?php echo $theme_options->productImageThumb($product_id, $config->get($config->get('config_theme') . '_image_additional_width'), $config->get($config->get('config_theme') . '_image_additional_height')); ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
     					      	<?php } ?>
     						     <?php foreach ($images as $image) { ?>
     						         <div class="item"><a href="<?php echo $image['popup']; ?>" class="popup-image" data-image="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></div>
     						     <?php } ?>
     					      </div>
					      </div>

				      </div>
				      <?php } ?>
			      </div>
			      <?php
			      $product_image_bottom = $modules_old_opencart->getModules('product_image_bottom');
			      if( count($product_image_bottom) ) {
			      	foreach ($product_image_bottom as $module) {
			      		echo $module;
			      	}
			      } ?>
			    </div>

			    <div class="col-sm-<?php echo $product_center_grid; ?> product-center clearfix">
			     <?php if ($price) { ?>
			      <div class="price">
			      	<span class="textprice">Цена</span>
			        <?php if($theme_options->get( 'display_specials_countdown' ) == '1' && $special) { $countdown = rand(0, 5000)*rand(0, 5000);
			                  $product_detail = $theme_options->getDataProduct( $product_id );
			                  $date_end = $product_detail['date_end'];
			                  if($date_end != '0000-00-00' && $date_end) { ?>
			             		<script>
			             		$(function () {
			             			var austDay = new Date();
			             			austDay = new Date(<?php echo date("Y", strtotime($date_end)); ?>, <?php echo date("m", strtotime($date_end)); ?> - 1, <?php echo date("d", strtotime($date_end)); ?>);
			             			$('#countdown<?php echo $countdown; ?>').countdown({until: austDay});
			             		});
			             		</script>
			             		<h3><?php if($theme_options->get( 'limited_time_offer_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'limited_time_offer_text', $config->get( 'config_language_id' ) ); } else { echo 'Limited time offer'; } ?></h3>
			             		<div id="countdown<?php echo $countdown; ?>" class="clearfix"></div>
			        	     <?php } ?>
			        <?php } ?>
			        <?php if (!$special) { ?>
                    <span class="price-new" data-price="<?php echo $price_float; ?>"><span itemprop="price" id="price-old" class="price_true"><?php echo $price . " ₽"; ?></span></span> <span id="price-special" class="price_old price-old" data-price=""></span>
                    <?php } else { ?>
                    <span class="price-new" data-price="<?php echo $price_special; ?>"><span itemprop="price" id="price-special" class="price_true"><?php echo $special . " ₽"; ?></span></span> <span id="price-old" class="price_old price-old" data-price="<?php echo $price_float; ?>"><?php echo $price . " ₽"; ?></span>
                    <?php } ?>
			        <br />
			        <?php if ($tax) { ?>
			        <span class="price-tax"><?php echo $text_tax . " ₽"; ?> <span id="price-tax"><?php echo $tax . " ₽"; ?></span></span><br />
			        <?php } ?>
			        <?php if ($points) { ?>
			        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
			        <?php } ?>
			        <?php if ($discounts) { ?>
			        <br />
			        <div class="discount">
			          <?php foreach ($discounts as $discount) { ?>
			          <?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price'] . " ₽"; ?><br />
			          <?php } ?>
			        </div>
			        <?php } ?>
			      </div>
			      <?php } ?>

			   	<div id="product">

			      <?php $product_options_center = $modules_old_opencart->getModules('product_options_center'); ?>
			      <?php if ($options || count($product_options_center)) { ?>
			      <div class="options2">
			        <?php foreach ($product_options_center as $module) { echo $module; } ?>

			        <?php if ($options) { ?>
                    <div class="options">
                         <h2><?php echo $text_option; ?></h2>
                         <?php foreach ($options as $option) { ?>
                         <?php if ($option['type'] == 'select') { ?>
                         <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                           <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name'] . $option_value['name']; ?></label>
                           <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                             <option value=""><?php echo $text_select; ?></option>
                             <?php foreach ($option['product_option_value'] as $option_value) { ?>
                             <!--BOF Related Options-->
			<option value="<?php echo $option_value['product_option_value_id']; ?>" <?php echo 'master-option-value="' . $option_value['master_option_value'] . '"' . ' option-value="' . $option_value['option_value_id'] . '"'; ?> <?php echo ($related_options['show_disabled'] == 0 and isset($option_value['quantity']) and $option_value['quantity'] <= 0) ? 'disabled' : ''; ?>><?php echo $option_value['name']; ?>
			<!--EOF Related Options-->
                             <?php if ($option_value['price']) { ?>
                             (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price'] . " ₽"; ?>)
                             <?php } ?>
                             </option>
                             <?php } ?>
                           </select>
                         </div>
                         <?php } ?>
                          <?php if ($option['type'] == 'radio') { ?>
                          <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                            <label class="control-label opt-name"><?php echo $option['name']; ?></label>
                            <div id="input-option<?php echo $option['product_option_id']; ?>" class="overflow-thumbnails-carousel global clearfix">
                            	<div class="thumbnails-carousel owl-carousel">
                              <?php foreach ($option['product_option_value'] as $option_value) { ?>
                              <div class="radio <?php if($theme_options->get( 'product_page_radio_style' ) == 1) { echo 'radio-type-button2'; } ?>">
                                <!--BOF Related Options--><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><!--EOF Related Options-->
                                  <!--BOF Related Options-->
					<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" <?php echo 'master-option-value="' . $option_value['master_option_value'] . '"' . ' option-value="' . $option_value['option_value_id'] . '"'; ?> <?php echo ($related_options['show_disabled'] == 0 and isset($option_value['quantity']) and $option_value['quantity'] <= 0) ? 'disabled' : ''; ?> />
					<!--EOF Related Options-->
                                  <span <?php if ($option_value['image']) { echo 'style="padding: 5px 2px 0px"'; } ?>>
                                 <?php if (!$option_value['image']) { ?><?php } ?>
                                 <span id="opt-name" class="opt"><?php echo $option_value['name']; ?></span>
                                 <div class="hidden">
                                 <?php if ($option_value['special']) { ?><span id='opt-special' class="opt"><?php echo $special . " ₽"; ?></span><?php } else { ?><span id="opt-price" class="opt" style="background-color:#eeeeee;padding:2px 0px 3px 0px;color:#4e636d;border-radius: 9px;"><?php echo $option_value['price'] . " ₽"; ?></span><?php } ?>
                                 <?php if ($option_value['weight'] > 0) { ?><span id="opt-weight" class="opt"><?php echo $option_value['weight']; ?> гр.</span><?php } ?><span id="opt-quantity" class="opt" style="background-color:#eeeeee;padding:2px 0px 3px 0px;color:#4e636d;border-radius: 9px;"><?php echo $option_value['quantity']; ?> шт.</span>
                                  <?php if ($option_value['image']) { ?>
                                  <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"  style="border-radius: 100px;-webkit-border-radius: 100px;-moz-border-radius: 100px" class="img-thumbnail" />
                                  <?php } ?>
                                  <span class="hidden"><?php if ($option_value['special']) { ?>(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['special']; ?>)<?php } elseif ($option_value['price']) { ?><!--BOF Related Options-->(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<!--EOF Related Options--><?php } ?></span>
                                  <?php if($theme_options->get( 'product_page_radio_style' ) != 1) { ?>
                                  <?php } ?></span>
                                  </div>
                                </label>
                              </div>
                              <?php } ?>

                              <?php if($theme_options->get( 'product_page_radio_style' ) == 1) { ?>
                              <script type="text/javascript">
                                   $(document).ready(function(){
                                        $('#input-option<?php echo $option['product_option_id']; ?>').on('click', 'span', function () {
                                             $('#input-option<?php echo $option['product_option_id']; ?> span').removeClass("active");
                                             $(this).addClass("active");
											 $('.checked-options table .opt-value td[option="11"]').empty();
                                             var tableId = '.checked-options table td[option="<?php echo $option['option_id']; ?>"]';
                                             var optName = $(this).find('#opt-name').text();
                                             var optWeight = $(this).find('#opt-weight').text();
                                             var optQuantity = $(this).find('#opt-quantity').text();
                                             $(tableId + '.opt-name').text(optName);
                                             $(tableId + '.opt-weight').text(optWeight);
                                             $(tableId + '.opt-quantity').text(optQuantity);
                                        });
                                   });
                              </script>
                              <?php } ?>
                            </div>
                            </div>
                          </div>
                          <?php } ?>
                         <?php if ($option['type'] == 'checkbox') { ?>
                         <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                           <label class="control-label"><?php echo $option['name']; ?></label>
                           <div id="input-option<?php echo $option['product_option_id']; ?>">
                             <?php foreach ($option['product_option_value'] as $option_value) { ?>
                             <div class="checkbox <?php if($theme_options->get( 'product_page_checkbox_style' ) == 1) { echo 'radio-type-button2'; } ?>">
                               <!--BOF Related Options--><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><!--EOF Related Options-->
                                 <!--BOF Related Options-->
						<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" <?php echo 'master-option-value="' . $option_value['master_option_value'] . '"' . ' option-value="' . $option_value['option_value_id'] . '"'; ?> <?php echo ($related_options['show_disabled'] == 0 and isset($option_value['quantity']) and $option_value['quantity'] <= 0) ? 'disabled' : ''; ?> />
					<!--EOF Related Options-->
                                 <span><?php echo $option_value['name']; ?>
                                <span class="hidden">
                                <?php if ($option_value['price']) { ?>
                                 <!--BOF Related Options-->(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<!--EOF Related Options-->
                                 <?php } ?>
                                </span>
                                 <?php if($theme_options->get( 'product_page_checkbox_style' ) != 1) { ?><?php } ?></span>
                               </label>
                             </div>
                             <?php } ?>

                             <?php if($theme_options->get( 'product_page_checkbox_style' ) == 1) { ?>
                             <script type="text/javascript">
                                  $(document).ready(function(){
                                       $('#input-option<?php echo $option['product_option_id']; ?>').on('click', 'span', function () {
                                            if($(this).hasClass("active") == true) {
                                                 $(this).removeClass("active");
                                            } else {
                                                 $(this).addClass("active");
                                            }
                                       });
                                  });
                             </script>
                             <?php } ?>
                           </div>
                         </div>
                         <?php } ?>
                         <?php if ($option['type'] == 'image') { ?>
                         <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                           <label class="control-label"><?php echo $option['name']; ?></label>
                           <div id="input-option<?php echo $option['product_option_id']; ?>">
                             <?php foreach ($option['product_option_value'] as $option_value) { ?>
                             <div class="radio <?php if($theme_options->get( 'product_page_radio_style' ) == 1) { echo 'radio-type-button'; } ?>">
                               <!--BOF Related Options--><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><!--EOF Related Options-->
                                 <!--BOF Related Options-->
					<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" <?php echo 'master-option-value="' . $option_value['master_option_value'] . '"' . ' option-value="' . $option_value['option_value_id'] . '"'; ?> <?php echo ($related_options['show_disabled'] == 0 and isset($option_value['quantity']) and $option_value['quantity'] <= 0) ? 'disabled' : ''; ?> />
					<!--EOF Related Options-->
                                 <span <?php if($theme_options->get( 'product_page_radio_style' ) == 1) { ?>data-toggle="tooltip" data-placement="top" title="<?php echo $option_value['name']; ?> <?php if ($option_value['price']) { ?><!--BOF Related Options-->(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<!--EOF Related Options--><?php } ?>"<?php } ?>><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" <?php if($theme_options->get( 'product_page_radio_style' ) == 1) { ?>width="<?php if($theme_options->get( 'product_page_radio_image_width' ) > 0) { echo $theme_options->get( 'product_page_radio_image_width' ); } else { echo 25; } ?>px" height="<?php if($theme_options->get( 'product_page_radio_image_height' ) > 0) { echo $theme_options->get( 'product_page_radio_image_height' ); } else { echo 25; } ?>px"<?php } ?> /> <?php if($theme_options->get( 'product_page_radio_style' ) != 1) { ?><?php echo $option_value['name']; ?>
                                 <?php if ($option_value['price']) { ?>
                                 <!--BOF Related Options-->(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)<!--EOF Related Options-->
                                 <?php } ?><?php } ?></span>
                               </label>
                             </div>
                             <?php } ?>
                             <?php if($theme_options->get( 'product_page_radio_style' ) == 1) { ?>
                             <script type="text/javascript">
                                  $(document).ready(function(){
                                       $('#input-option<?php echo $option['product_option_id']; ?>').on('click', 'span', function () {
                                            $('#input-option<?php echo $option['product_option_id']; ?> span').removeClass("active");
                                            $(this).addClass("active");
                                       });
                                  });
                             </script>
                             <?php } ?>
                           </div>
                         </div>
                         <?php } ?>
                         <?php if ($option['type'] == 'text') { ?>
                         <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                           <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                           <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                         </div>
                         <?php } ?>
                         <?php if ($option['type'] == 'textarea') { ?>
                         <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                           <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                           <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                         </div>
                         <?php } ?>
                         <?php if ($option['type'] == 'file') { ?>
                         <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                           <label class="control-label"><?php echo $option['name']; ?></label>
                           <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" class="btn btn-default btn-block" style="margin-top: 7px"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                           <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                         </div>
                         <?php } ?>
                            <?php if ($option['type'] == 'date') { ?>
                            <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                              <div class="input-group date">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                </span></div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'datetime') { ?>
                            <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                              <div class="input-group datetime">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'time') { ?>
                            <!--BOF Related Options-->
			<div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?> option" <?php echo 'master-option="' . $option['master_option'] . '"' . ' option="' . $option['option_id'] . '"'; ?> id="option-<?php echo $option['product_option_id']; ?>" >
						<!--EOF Related Options-->
                              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                              <div class="input-group time">
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                <span class="input-group-btn">
                                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                </span></div>
                            </div>
                            <?php } ?>
                         <?php } ?>
                    </div>
                    <?php } ?>
			      </div>

			      <?php } ?>

			      <?php if ($recurrings) { ?>
			      <div class="options">
			          <h2><?php echo $text_payment_recurring ?></h2>
			          <div class="form-group required">
			            <select name="recurring_id" class="form-control">
			              <option value=""><?php echo $text_select; ?></option>
			              <?php foreach ($recurrings as $recurring) { ?>
			              <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
			              <?php } ?>
			            </select>
			            <div class="help-block" id="recurring-description"></div>
			          </div>
			      </div>
			      <?php } ?>
				  <?php if ($option['option_id'] == '11') { $tab='tab'; ?>
			      <div class="form-group checked-options" style="background-color: #f9f9f9;margin-top: 5px;">
			            <div class="heading">Выбрано</div>
			            <table cellpadding="10">
                            <tr class="opt-heading">
                                <td width="15%">Размер</td>
                                <td width="15%">Вес</td>
                                <td width="15%">В наличии</td>
                                <td width="15%">Цена</td>
                            </tr>
                            <tr class="opt-value">
                                <td option="11" class="opt-name"></td>
                                <td option="11" class="opt-weight"></td>
                                <td id="<?php echo $tab;?>" option="11" class="opt-quantity"></td>
                                <td class="opt-price"></td>
                            </tr>
                        </table>
                </div>
				<?php } else if ($option['option_id'] == '14') { $tab='tab'; ?>
<div class="form-group checked-options" style="background-color: #f9f9f9;margin-top: 5px;">
			            <div class="heading">Выбрано</div>
			            <table cellpadding="10">
                            <tr class="opt-heading">
                                <td width="25%">Вставка</td>
                                <td width="15%">Вес</td>
                                <td width="20%">В наличии</td>
                                <td width="20%">Цена</td>
                            </tr>
                            <tr class="opt-value">
                                <td option="14" class="opt-name"></td>
                                <td option="14" class="opt-weight"></td>
                                <td id="<?php echo $tab;?>" option="14" class="opt-quantity"></td>
                                <td class="opt-price"></td>
                            </tr>
                        </table>
                </div>
<?php } ?>

<div id="win" style="display:none;">
					 <div class="overlay"></div>
							<div class="visible">
								<h2 style="text-align:center">Уважаемый покупатель!</h2>
									<div class="content">
									<p></p>Извините у нас в наличии только <span id="qv"></span> шт. Можете связаться с менеджером для заказа большего количество.</p>
									</div>
							<button type="submit"class="button" onClick="getElementById('win').style.display='none';">закрыть</button>
						</div>
				</div>

			      <div class="cart">
                        <div class="add-to-cart clearfix">
			          <?php
			          $product_enquiry = $modules_old_opencart->getModules('product_enquiry');
			          if( count($product_enquiry) ) {
			          	foreach ($product_enquiry as $module) {
			          		echo $module;
			          	}
			          } else { ?>
			          <div style="padding:10px 0;width: 100%;float:right;" class="col-sm-6">
     			          <!-- <p><?php echo $entry_qty; ?></p> -->
						  <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
     			          <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" rel="<?php echo $product_id; ?>" data-loading-text="<?php echo $text_loading; ?>" class="button" />
						  <div class="quantity">
     			          <span id="q_up"><i class="fa fa-angle-up"></i></span>
     				      <input type="text" name="quantity" id="quantity_wanted" size="2" value="<?php echo $minimum; ?>" />
     				      <span id="q_down"><i class="fa fa-angle-down"></i></span>
     			          </div>


     			          <?php
     			          $product_question = $modules_old_opencart->getModules('product_question');
     			          if( count($product_question) ) {
     			          	foreach ($product_question as $module) {
     			          		echo $module;
     			          	}
     			          } ?>
			          <?php } ?>
			        </div>
			         </div>
			        <div class="links clearfix">
			        	<a onclick="parent.wishlist.add('<?php echo $product_id; ?>');"><?php if($theme_options->get( 'add_to_wishlist_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'add_to_wishlist_text', $config->get( 'config_language_id' ) ); } else { echo 'Add to wishlist'; } ?></a>
			        	<a onclick="parent.compare.add('<?php echo $product_id; ?>');"><?php if($theme_options->get( 'add_to_compare_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'add_to_compare_text', $config->get( 'config_language_id' ) ); } else { echo 'Add to compare'; } ?></a>
			        </div>

			        <?php if ($minimum > 1) { ?>
			        <div class="minimum"><?php echo $text_minimum; ?></div>
			        <?php } ?>
			      </div>
			      <div class="checked-options"></div>
			     </div><!-- End #product -->
			     <div class="clearfix"></div>
			     <div itemscope itemtype="http://schema.org/Offer">
			      <?php
			      $product_options_top = $modules_old_opencart->getModules('product_options_top');
			      if( count($product_options_top) ) {
			      	foreach ($product_options_top as $module) {
			      		echo $module;
			      	}
			      } ?>

			      <?php if ($review_status) { ?>
			      <div class="review">
			      	<?php if($rating > 0) { ?>
			      	<span itemprop="review" class="hidden" itemscope itemtype="http://schema.org/Review-aggregate">
			      		<span itemprop="itemreviewed"><?php echo $heading_title; ?></span>
			      		<span itemprop="rating"><?php echo $rating; ?></span>
			      		<span itemprop="votes"><?php preg_match_all('/\(([0-9]+)\)/', $tab_review, $wyniki);
			      		if(isset($wyniki[1][0])) { echo $wyniki[1][0]; } else { echo 0; } ?></span>
			      	</span>
			      	<?php } ?>
			        <div class="rating"><i class="fa fa-star<?php if($rating >= 1) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 2) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 3) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 4) { echo ' active'; } ?>"></i><i class="fa fa-star<?php if($rating >= 5) { echo ' active'; } ?>"></i>&nbsp;&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click'); $('html, body').animate({scrollTop:$('#tab-review').offset().top}, '500', 'swing');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click'); $('html, body').animate({scrollTop:$('#tab-review').offset().top}, '500', 'swing');"><?php echo $text_write; ?></a></div>
			        <?php if($theme_options->get( 'product_social_share' ) != '0') { ?>
			        <div class="share">
			        	<!-- AddThis Button BEGIN -->
			        	<div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
			        	<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
			        	<!-- AddThis Button END -->
			        </div>
			        <?php } ?>
			      </div>
			      <?php } ?>

			      <div class="description">
			        <?php if ($manufacturer) { ?>
			        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
			        <?php } ?>
			        <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
			        <?php if ($reward) { ?>
			        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
			        <?php } ?>
			        <span><?php echo $text_stock; ?></span> <?php echo $stock; ?><?php echo $text_qustock; ?><br />
			        <?php foreach ($attribute_groups as $attribute_group) { ?>
			        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
			        	<span><?php echo $attribute['name']; ?>:</span> <?php echo $attribute['text']; ?><br />
			        <?php } ?>
			        <?php } ?>
			      </div>

			     </div>



			      <?php
			      $product_options_bottom = $modules_old_opencart->getModules('product_options_bottom');
			      if( count($product_options_bottom) ) {
			      	foreach ($product_options_bottom as $module) {
			      		echo $module;
			      	}
			      } ?>
		    	</div>
  </div>
</div>

<?php if($theme_options->get( 'custom_block', 'product_page', $config->get( 'config_language_id' ), 'status' ) == 1) { ?>
    	<div class="col-md-3 col-sm-12">
    	     <?php if($theme_options->get( 'custom_block', 'product_page', $config->get( 'config_language_id' ), 'status' ) == 1) { ?>
    		<div class="product-block">
    			<?php if($theme_options->get( 'custom_block', 'product_page', $config->get( 'config_language_id' ), 'heading' ) != '') { ?>
    			<h4 class="title-block"><?php echo $theme_options->get( 'custom_block', 'product_page', $config->get( 'config_language_id' ), 'heading' ); ?></h4>
    			<div class="strip-line"></div>
    			<?php } ?>
    			<div class="block-content">
    				<?php echo html_entity_decode($theme_options->get( 'custom_block', 'product_page', $config->get( 'config_language_id' ), 'text' )); ?>
    			</div>
    		</div>
    		<?php } ?>

    		<?php foreach ($product_custom_block as $module) { echo $module; } ?>
    	</div>
    	<?php } ?>
    </div>
  </div>
  <?php
  $product_over_tabs = $modules_old_opencart->getModules('product_over_tabs');
  if( count($product_over_tabs) ) {
  	foreach ($product_over_tabs as $module) {
  		echo $module;
  	}
  } ?>

  <?php
  	  $language_id = $config->get( 'config_language_id' );
	  $tabs = array();

	  $tabs[] = array(
	  	'heading' => $tab_description,
	  	'content' => 'description',
	  	'sort' => 1
	  );

	  if ($attribute_groups) {
		  $tabs[] = array(
		  	'heading' => $tab_attribute,
		  	'content' => 'attribute',
		  	'sort' => 3
		  );
	  }

	  if ($review_status) {
	  	  $tabs[] = array(
	  	  	'heading' => $tab_review,
	  	  	'content' => 'review',
	  	  	'sort' => 5
	  	  );
	  }

	  if(is_array($config->get('product_tabs'))) {
		  foreach($config->get('product_tabs') as $tab) {
		  	if($tab['status'] == 1 || $tab['product_id'] == $product_id) {
		  		foreach($tab['tabs'] as $zakladka) {
		  			if($zakladka['status'] == 1) {
		  				$heading = false; $content = false;
		  				if(isset($zakladka[$language_id])) {
		  					$heading = $zakladka[$language_id]['name'];
		  					$content = html_entity_decode($zakladka[$language_id]['html']);
		  				}
		  				$tabs[] = array(
		  					'heading' => $heading,
		  					'content' => $content,
		  					'sort' => $zakladka['sort_order']
		  				);
		  			}
		  		}
		  	}
		  }
	  }

	  usort($tabs, "cmp_by_optionNumber");
  ?>
  <div id="tabs" class="htabs">
  	<?php $i = 0; foreach($tabs as $tab) { $i++;
  		$id = 'tab_'.$i;
  		if($tab['content'] == 'review') { $id = 'tab-review'; }
  		if($tab['content'] == 'attribute') { $id = 'tab-attribute'; }
  		if($tab['content'] == 'description') { $id = 'tab-description'; }
  		echo '<a href="#'.$id.'">'.$tab['heading'].'</a>';
  	} ?>
  </div>
  <?php $i = 0; foreach($tabs as $tab) { $i++;
  	$id = 'tab_'.$i;
  	if($tab['content'] != 'review' && $tab['content'] != 'attribute' && $tab['content'] != 'description') {
  		echo '<div id="'.$id.'" class="tab-content">'.$tab['content'].'</div>';
  	}
  } ?>
    <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
	<form class="form-horizontal" id="form-review">

				<div id="review">
				  <?php if ($reviews_first['reviews']) {
				     if ( count($reviews_first['reviews']) > 5 ) {
					   $reviews_first_page = array_slice($reviews_first['reviews'], 0, 5);
					 } else { $reviews_first_page = $reviews_first['reviews']; }
				  ?>
					<?php foreach ($reviews_first_page as $review) { ?>
					<table class="table table-striped table-bordered">
					  <tr>
						<td style="width: 50%;"><strong><?php echo $review['author']; ?></strong></td>
						<td class="text-right"><?php echo $review['date_added']; ?></td>
					  </tr>
					  <tr>
						<td colspan="2"><p><?php echo $review['text']; ?></p>
						  <?php for ($i = 1; $i <= 5; $i++) { ?>
						  <?php if ($review['rating'] < $i) { ?>
						  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
						  <?php } else { ?>
						  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
						  <?php } ?>
						  <?php } ?></td>
					  </tr>
					</table>
					<?php } ?>
					<div class="text-right"><?php echo $reviews_first['pagination']; ?></div>
					<?php } else { ?>
					<p><?php echo $reviews_first['text_no_reviews']; ?></p>
					<?php } ?>
				</div>

	  <h2><?php echo $text_write; ?></h2>
	  <?php if ($review_guest) { ?>
	  <div class="form-group required">
	    <div class="col-sm-12">
	      <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
	      <input type="text" name="name" value="" id="input-name" class="form-control" />
	    </div>
	  </div>
	  <div class="form-group required">
	    <div class="col-sm-12">
	         <label class="control-label"><?php echo $entry_rating; ?></label>

	       <div class="rating set-rating">
	          <i class="fa fa-star" data-value="1"></i>
	          <i class="fa fa-star" data-value="2"></i>
	          <i class="fa fa-star" data-value="3"></i>
	          <i class="fa fa-star" data-value="4"></i>
	          <i class="fa fa-star" data-value="5"></i>
	      </div>
	      <script type="text/javascript">
	          $(document).ready(function() {
	            $('.set-rating i').hover(function(){
	                var rate = $(this).data('value');
	                var i = 0;
	                $('.set-rating i').each(function(){
	                    i++;
	                    if(i <= rate){
	                        $(this).addClass('active');
	                    }else{
	                        $(this).removeClass('active');
	                    }
	                })
	            })

	            $('.set-rating i').mouseleave(function(){
	                var rate = $('input[name="rating"]:checked').val();
	                rate = parseInt(rate);
	                i = 0;
	                  $('.set-rating i').each(function(){
	                    i++;
	                    if(i <= rate){
	                        $(this).addClass('active');
	                    }else{
	                        $(this).removeClass('active');
	                    }
	                  })
	            })

	            $('.set-rating i').click(function(){
	                $('input[name="rating"]:nth('+ ($(this).data('value')-1) +')').prop('checked', true);
	            });
	          });
	      </script>
	      <div class="hidden">
	         &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
	         <input type="radio" name="rating" value="1" />
	         &nbsp;
	         <input type="radio" name="rating" value="2" />
	         &nbsp;
	         <input type="radio" name="rating" value="3" />
	         &nbsp;
	         <input type="radio" name="rating" value="4" />
	         &nbsp;
	         <input type="radio" name="rating" value="5" />
	         &nbsp;<?php echo $entry_good; ?>
	      </div>
	   </div>
	  </div>
	  <div class="form-group required">
	    <div class="col-sm-12">
	      <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
	      <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
	      <div class="help-block"><?php echo $text_note; ?></div>
	    </div>
	  </div>
	  <?php echo $captcha; ?>
	  <div class="buttons clearfix" style="margin-bottom: 0px">
	    <div class="pull-right">
	      <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
	    </div>
	  </div>
	  <?php } else { ?>
	  <?php echo $text_login; ?>
	  <?php } ?>
	</form>
  </div>
  <?php } ?>

  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute" cellspacing="0">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
   <div id="tab-description" class="tab-content" itemprop="description"><?php echo $description; ?></div>

  <?php if ($tags) { ?>
  <div class="tags_product"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>

</div>

<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
	var $input = $(this).parent().find('#quantity_wanted');
	var count = parseInt($input.val());
 var sht = document.getElementById('tab');
 var tor =(sht.innerHTML);
	kil= parseInt(tor.replace(/\D+/g,""));
	if (count>kil){
	document.getElementById('qv').innerHTML=kil;
	document.getElementById("win").style.display = null;
 return;
 }
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				parent.$.notify({
					message: json['success'],
					target: '_blank'
				},{
					// settings
					element: 'body',
					position: null,
					type: "info",
					allow_dismiss: true,
					newest_on_top: false,
					placement: {
						from: "top",
						align: "right"
					},
					offset: 20,
					spacing: 10,
					z_index: 2031,
					delay: 5000,
					timer: 1000,
					url_target: '_blank',
					mouse_over: null,
					animate: {
						enter: 'animated fadeInDown',
						exit: 'animated fadeOutUp'
					},
					onShow: null,
					onShown: null,
					onClose: null,
					onClosed: null,
					icon_type: 'class',
					template: '<div data-notify="container" class="col-xs-11 col-sm-3 alert alert-success" role="alert">' +
						'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
						'<span data-notify="message"><i class="fa fa-check-circle"></i>&nbsp; {2}</span>' +
						'<div class="progress" data-notify="progressbar">' +
							'<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
						'</div>' +
						'<a href="{3}" target="{4}" data-notify="url"></a>' +
					'</div>'
				});

				$('#cart_block #cart_content').load('index.php?route=common/cart/info #cart_content_ajax');
				$('#cart_block #total_price_ajax').load('index.php?route=common/cart/info #total_price');
				$('#cart_block .cart-count').load('index.php?route=common/cart/info #total_count_ajax');
			}
		},
     	error: function(xhr, ajaxOptions, thrownError) {
     	    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
     	}
	});
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
	e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});


				/*$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');*/


$('#button-review').on('click', function() {
    $.ajax({
        url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
        type: 'post',
        dataType: 'json',
        data: $("#form-review").serialize(),
        beforeSend: function() {
            $('#button-review').button('loading');
        },
        complete: function() {
            $('#button-review').button('reset');
        },
        success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
                $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
            }

            if (json['success']) {
                $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

                $('input[name=\'name\']').val('');
                $('textarea[name=\'text\']').val('');
                $('input[name=\'rating\']:checked').prop('checked', false);
            }
        }
    });
});
</script>



<script type="text/javascript">
var ajax_price = function() {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=product/liveprice/index',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
			success: function(json) {
			if (json.success) {
				if (json.new_price.special) {
					change_price('#price-special', json.new_price.special);
					$('#price-special').show();
					if ($('td').is('.special')) {

					} else {
					    $('.checked-options .opt-price').addClass('opt-oldprice');
					    $('.checked-options .opt-heading').append('<td class="special">Акция</td>');
					    $('.checked-options .opt-value').append('<td class="opt-special"></td>');
					    $('.checked-options .opt-price').text(json.new_price.special + ' р.');
					}
				} else {
					$('#price-special').hide();
					$('#price-special').html('');
					$('.checked-options .opt-price').removeClass('opt-oldprice');
					$('.checked-options .opt-heading .special').remove();
					$('.checked-options .opt-value .opt-special').remove();
				}
				change_price('#price-tax', json.new_price.tax);
				change_price('#price-old', json.new_price.price);
				if (json.new_price.special == 0) {
					$('.checked-options .opt-price').text(json.new_price.price + ' р.');
				} else {
					$('.checked-options .opt-special').text(json.new_price.price + ' р.');
				}
			}
		}
	});
}

var change_price = function(id, new_price) {
	$(id).html(new_price + ' р.');
}

$('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\'], .product-info input[type=\'checkbox\'], .product-info select, .product-info textarea, .product-info input[name=\'quantity\']').on('change', function() {
	ajax_price();
});
</script>

<script type="text/javascript">
$.fn.tabs = function() {
	var selector = this;

	this.each(function() {
		var obj = $(this);

		$(obj.attr('href')).hide();

		$(obj).click(function() {
			$(selector).removeClass('selected');

			$(selector).each(function(i, element) {
				$($(element).attr('href')).hide();
			});

			$(this).addClass('selected');

			$($(this).attr('href')).show();

			return false;
		});
	});

	$(this).show();

	$(this).first().click();
};
</script>

<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script>


<?php if($theme_options->get( 'product_image_zoom' ) != 2) {
echo '<script type="text/javascript" src="catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/js/jquery.elevateZoom-3.0.3.min.js"></script>';
} ?>


<!--BOF Related Options-->
            <!--BOF Related Options-->
            <script type="text/javascript"><!--
                $(document).ready(function(){
                    /*
                    $('.product-thumb input[name=quantity]').bind('change keyup mouseup', function(){
                        $(this).addClass('changed');
                        t = true;
                        $(this).parents('.product-thumb').find('.options input[type=radio]').each(function(){
                            if ($(this).prop('checked')) {
                                t = false;
                                $(this).parents('.product-thumb').find('input[type=radio]:checked').trigger('change');
                            }
                        })
                        if (t) {
                            var $pr = $(this).parents('.product-thumb').find('.price-new').data('price');
                            var $pr_old = $(this).parents('.product-thumb').find('.price-old').data('price');

                            $(this).parents('.product-thumb').find('.price-new').html( price_format(Number($pr) * $(this).val()) );
                            $(this).parents('.product-thumb').find('.price-old').html( price_format(Number($pr_old) * $(this).val()) );



                        }

                    });
                    */

                        var main_timeout_id = 0;
                        var special_timeout_id = 0;
                        var animate_delay = 20;

                        var regex_price = /[0-9]+[\.]{0,1}[0-9]*/;
                        var regex_replace_price = /([0-9]+[\.]{0,1}[0-9]*)/;

//                    $('.option[master-option!=0]').hide();

                    // SELECT OPTION
                    /*
                    $('.option select').bind('change', function(){
                        var option_value = $(this).children('option:selected').attr('option-value');
                        var $related_options = $(this).parents('.options').find('.option[master-option=' + $(this).parent('.option').attr('option') + ']');
                        if ($(this).val() != '') {
                            updateOptionList($related_options, option_value);
                        } else {
                            $related_options.slideUp();
                        }
                        clearOption($related_options);
                    });
                    */

                    // RADIO OPTION
                    /*
                    $('.option input[type=radio]').bind('click', function(){
                        $(this).parents('.product-thumb').find('input[name=quantity]').removeClass('changed');
                    })
                    */
                    $('.option input[type=radio]').bind('change', function(){

                        $(this).each(function(){
                            if ($(this).prop('checked') == false) {
                                $(this).parents('.form-group').next().find('.radio-type-button2 span').removeClass('active');
                            }
                        })

                        var option_value = $(this).attr('option-value');
                        var $related_options = $(this).parents('.options').find('.option[master-option = ' + $(this).parents('.option').attr('option') + ']');

                        // changing price
                        var num = <?php echo $related_options['price_residue'] ?>;
                        var $price = $(this).parents('.product-info').find('.price-new').data('price');

                        var $price_old = $(this).parents('.product-info').find('.price-old').data('price');
                        var $price_special = $(this).parents('.product-info').find('.price-new').data('price');
                        var $qty = $(this).parents('.product-info').find('input[name=quantity]').val();




                        if ($price_special) {
                            var $special = true;

                          var initial_price = $price_special * $qty;
                          var initial_price_old = $price_old * $qty;
//                          initial_price = initial_price[0]*1;
//                          initial_price_old = initial_price_old[0]*1;
                          var initial_price_old_update = initial_price_old;
                        } else {
                            var $special = false;
                            var initial_price = $price * $qty;
//                          initial_price = initial_price[0]*1;
                        }

                        var initial_price_update = initial_price;

                        var regex_add_price = /([\+\-\=])[^0-9]*([0-9]+[\.]{0,1}[0-9]*)/;
                        additional_price = regex_add_price.exec($(this).parents('.option').find('label[for=' + $(this).attr('id') + '] span.hidden').text().replace('<?php echo $decimal_point; ?>', '.').replace(new RegExp('<?php echo $thousand_point; ?>', 'g'), ''));

                        if (additional_price != null && additional_price != '' && additional_price != undefined) {
                            if (additional_price[1] == '=') {
                                var initial_price = 0;
                                var initial_price_old = 0;
                                var initial_price_old_update = 0;
                                var initial_price_update = 0;
                            }
                        }

                        if ($('input[name=\'' + $(this).attr('name') + '\']:checked').size() != '') {
                            updateOptionList($related_options, option_value);
                        } else {
//                            $related_options.slideUp();
                        }
                        clearOption($related_options, $price, $price_old, $special, $(this), initial_price_update, initial_price, initial_price_old, $qty);

                    });

                    // CHECKBOX OPTION
                    /*
                    $('.option input[type=checkbox]').bind('change', function(){
                        var option_value = [];
                        $('.option input[name=\'' + $(this).attr('name') + '\']:checked').each(function(){
                            option_value.push($(this).attr('option-value'));
                        });
                        var $related_options = $('.option[master-option = ' + $(this).parents('.option').attr('option') + ']');
                        if ($('input[name=\'' + $(this).attr('name') + '\']:checked').size() != '') {
                            updateOptionList($related_options, option_value);
                        } else {
                            $related_options.slideUp();
                        }
                        clearOption($related_options);
                    });

                    // TEXT INPUT AND TEXTAREA OPTION
                    $('.option input[type=text], .option textarea').bind('change', function(){
                        var $related_options = $('.option[master-option = ' + $(this).parent('.option').attr('option') + ']');
                        if ($(this).val() != '') {
                            $related_options.slideDown();
                        } else {
                            $related_options.slideUp();
                        }
                        clearOption($related_options);
                    });
                    */

                    $( document ).on( "click", '[class^="opt-reset"]', function() {
                        var id = $(this).attr('class').replace("opt-reset-", "");
                        $('#option-'+ id).find('input[type=\'radio\']').prop('checked', false).trigger('change');
                        $('#option-'+ id).find('.img-option-a').html('Выбрать');
                        $('#option-'+ id).find('.img-option-span').html('');
                        $('.opt-reset-'+ id).remove();
                        changeimg();
                    });
                });
                function updateOptionList($related_options, option_value) {
                    // select options
                    $related_options.find('option[master-option-value!=0]').each(function(){
                        if ($(this).parent('span').size() == 0) {
                            $(this).wrap("<span>");
                        }
                    });

                    $related_options.find('.img_block[master-option-value!=0]').hide();
                    $related_options.find('input[type=hidden][master-option-value!=0]').prev().prop('disabled', true);
                    if ($related_options.find('[class^="opt-reset"]').length) {
                        $related_options.find('[class^="opt-reset"]').trigger('click');
                    }

                    $related_options.find('input[master-option-value!=0]').hide();
                    $related_options.find('input[master-option-value!=0]').parent('label').parent('div').hide();
                    $related_options.find('input[master-option-value!=0]').next('label').next('br').hide();
                    $related_options.find('textarea[master-option-value!=0]').hide();
                    // image options
                    $related_options.find('input[master-option-value!=0]').each(function(){
                        if ($(this).closest('table').hasClass('option-image')) {
                            $(this).closest('tr').hide();
                        }
                    });


                    if (typeof(option_value) == "string") {
                        option_value = [option_value];
                    }
                    for (var i in option_value) {
                        $related_options.find('option[master-option-value=' + option_value[i] + '], option[value=\'\']').each(function(){
                            if ($(this).parent('span').size() != 0) {
                                $(this).unwrap();
                            }
                        });

                        $related_options.find('.img_block[master-option-value=' + option_value[i] + ']').show();
                        $related_options.find('input[type=hidden][master-option-value=' + option_value[i] + ']').prev().prop('disabled', false);

                        $related_options.find('input[master-option-value=' + option_value[i] + ']').show();
                        $related_options.find('input[master-option-value=' + option_value[i] + ']').parent('label').parent('div').show();
                        $related_options.find('input[master-option-value=' + option_value[i] + ']').next('label').next('br').show();
                        $related_options.find('textarea[master-option-value=' + option_value[i] + ']').show();
                        // image options
                        $related_options.find('input[master-option-value=' + option_value[i] + ']').each(function(){
                            if ($(this).closest('table').hasClass('option-image')) {
                                $(this).closest('tr').show();
                            }
                        });
                    }

                    $related_options.each(function(){
                        var visible_options = 0;
                        for (var i in option_value) {
                            visible_options += $(this).find('[master-option-value=' + option_value[i] + ']').size()*1;
                            visible_options += $(this).find('[master-option-value=0]').size()*1;
                        }
                        if ($(this).find('.img_block, option, input, textarea').size() != 0 && visible_options == 0) {
                            $(this).slideUp();
                        } else {
                            $(this).slideDown();
                        }
                    });
                }
                function clearOption($option_container, $price, $price_old, $special, element,initial_price_update, initial_price, initial_price_old, $qty) {
                    $option_container.find('select').val('');
//                    if (!$option_container.parents('.product-thumb').find('input[name=quantity]').is('.changed')) {

                    $option_container.find('.radio-type-button2 span').removeClass('active');
                    $option_container.find('input[type=radio], input[type=checkbox]').removeAttr('checked');

//                    }
                    //$option_container.find('input[type=text], textarea').attr('value', '');
                    recalcPrice($price, $price_old, $special, element, initial_price_update, initial_price, initial_price_old, $qty);
                }
            //--></script>
            <?php
            if (isset($related_options['price_adjustment_on']) && $related_options['price_adjustment_on']) {
            ?>
            <script type="text/javascript"><!--


                function formatMoney(n, c, d, t) {
                    var c = isNaN(c = Math.abs(c)) ? 2 : c,
                    d = d == undefined ? "." : d,
                    t = t == undefined ? "," : t,
                    s = n < 0 ? "-" : "",
                    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "",
                    j = (j = i.length) > 3 ? j % 3 : 0;
                   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
                };

                function diffPrice(element) {

                    var regex_add_price = /([\+\-\=])[^0-9]*([0-9]+[\.]{0,1}[0-9]*)/;
                  var diff = 0;
                  element.parents('.option').find('input[type=radio]:checked, input[type=checkbox]:checked').each(function(){
                    additional_price = regex_add_price.exec(element.parents('.option').find('label[for=' + element.attr('id') + '] span.hidden').text().replace('<?php echo $decimal_point; ?>', '.').replace(new RegExp('<?php echo $thousand_point; ?>', 'g'), ''));

                    if (additional_price != null && additional_price != '' && additional_price != undefined) {
                      if (additional_price[1] == '+') {
                        diff += additional_price[2]*1;
                      } else if (additional_price[1] == '-') {
                        diff -= additional_price[2]*1;
                      } else if (additional_price[1] == '=') {
                        diff = additional_price[2]*1;
                      }
                    }
                  });
                  /*
                  element.parents('.options').find('select>option:selected').each(function(){
                    additional_price = regex_add_price.exec(element.text().replace('<?php echo $decimal_point; ?>', '.').replace(new RegExp('<?php echo $thousand_point; ?>', 'g'), ''));
                    if (additional_price != null && additional_price != '' && additional_price != undefined) {
                      if (additional_price[1] == '+') {
                        diff += additional_price[2]*1;
                      } else if (additional_price[1] == '-') {
                        diff -= additional_price[2]*1;
                      }
                    }
                  });
                  */
                  qty = element.parents('.product-info').find('input[name=quantity]').val();

                  return diff * qty;
                }
                function price_format(/*price_view, */price) {

                        var regex_replace_price = /([0-9]+[\.]{0,1}[0-9]*)/;
                        var num = <?php echo $related_options['price_residue'] ?>;
                  price = formatMoney(price, num, '<?php echo $decimal_point; ?>', '<?php echo $thousand_point; ?>');
                  return price + ' р.';
                  /*
                  return price_view.replace('<?php echo $decimal_point; ?>', '.').replace(new RegExp('<?php echo $thousand_point; ?>', 'g'), '').replace(regex_replace_price, price);
                  */
                }
                /*
                <?php if ($related_options['animate_price']) { ?>
                function animateMainPrice_callback(wrapper, price_start, price_final, animate_step, special) {

                  price_start += animate_step;

                  if ((animate_step > 0) && (price_start > price_final)){
                    price_start = price_final;
                  } else if ((animate_step < 0) && (price_start < price_final)) {
                    price_start = price_final;
                  } else if (animate_step == 0) {
                    price_start = price_final;
                  }

                  wrapper.html( price_format(wrapper.html(), price_start) );

                  if (price_start != price_final) {
                    if (special === true) {
                      special_timeout_id = setTimeout(function(){animateMainPrice_callback(wrapper, price_start, price_final, animate_step, special)}, animate_delay);
                    } else {
                      main_timeout_id = setTimeout(function(){animateMainPrice_callback(wrapper, price_start, price_final, animate_step, special)}, animate_delay);
                    }
                  }
                }
                function animateMainPrice(wrapper, start, final, special) {
                  animate_step = (final - start) / 10;
                  if (special === true) {
                    clearTimeout(special_timeout_id);
                    special_timeout_id = setTimeout(function(){animateMainPrice_callback(wrapper, start, final, animate_step, special)}, animate_delay);
                  } else {
                    clearTimeout(main_timeout_id);
                    main_timeout_id = setTimeout(function(){animateMainPrice_callback(wrapper, start, final, animate_step, special)}, animate_delay);
                  }
                }
                <?php } else { ?>

                function showPrice(wrapper, price) {
                  wrapper.html( price_format(wrapper, price) );
                }
                <?php } ?>
                */

                function recalcPrice($price, $price_old, $special, element, initial_price_update, initial_price, initial_price_old) {
                  var diff = diffPrice(element);
                  if (initial_price_update != initial_price + diff) {
                      /*
                    <?php if ($related_options['animate_price']) { ?>
                      animateMainPrice($price, initial_price_update, initial_price + diff, false);
                    <?php } else { ?>
                      showPrice($price, initial_price + diff);
                    <?php } ?>
                    */

                    if ($special) {
                        element.parents('.product-info').find('.price-new').html( price_format(Number(initial_price) + Number(diff)) );
                        element.parents('.product-info').find('.price-old').html( price_format(Number(initial_price_old) + Number(diff)) );
                    } else {
                        element.parents('.product-info').find('.price-new').html( price_format(Number(initial_price) + Number(diff)) );
                    }

//                    showPrice($price, initial_price + diff, element);
                    initial_price_update = initial_price + diff;
                    if ($special) {
                        /*
                      <?php if ($related_options['animate_price']) { ?>
                        animateMainPrice($price_old, initial_price_old_update, initial_price_old + diff, tru Save file  e);
                      <?php } else { ?>
                        showPrice($price_old, initial_price_old + diff);
                      <?php } ?>
                      */
//                        showPrice($price_old, initial_price_old + diff, element, true);
                        initial_price_old_update = initial_price_old + diff;
                    }
                  }
                }
            //--></script>
            <?php } else { ?>
            <script type="text/javascript"><!--
                function recalcPrice() {
//                    return true;
                }
            //--></script>
            <?php } ?>
            <!--EOF Related Options-->

</body>
</html>

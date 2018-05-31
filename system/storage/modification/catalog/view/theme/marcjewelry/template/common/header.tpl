<?php
if($registry->has('theme_options') == false) {
	header("location: themeinstall/index.php");
	exit;
}

$theme_options = $registry->get('theme_options');
$config = $registry->get('config');
$page_direction = $theme_options->get( 'page_direction' );

require_once( DIR_TEMPLATE.$config->get($config->get('config_theme') . '_directory')."/lib/module.php" );
$modules_old_opencart = new Modules($registry);
?>
<!DOCTYPE html>
<!--[if IE 7]> <html lang="<?php echo $lang; ?>" class="ie7 <?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no-'; } ?>responsive<?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? ' rtl' : '' ) ?>" <?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? 'dir="rtl"' : '' ) ?>> <![endif]-->
<!--[if IE 8]> <html lang="<?php echo $lang; ?>" class="ie8 <?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no-'; } ?>responsive<?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? ' rtl' : '' ) ?>" <?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? 'dir="rtl"' : '' ) ?>> <![endif]-->
<!--[if IE 9]> <html lang="<?php echo $lang; ?>" class="ie9 <?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no-'; } ?>responsive<?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? ' rtl' : '' ) ?>" <?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? 'dir="rtl"' : '' ) ?>> <![endif]-->
<!--[if !IE]><!--> <html lang="<?php echo $lang; ?>" class="<?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no-'; } ?>responsive<?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? ' rtl' : '' ) ?>" <?php echo ($page_direction[$config->get( 'config_language_id' )] == 'RTL' ? 'dir="rtl"' : '' ) ?>> <!--<![endif]-->
<head>
	<title><?php echo $title; ?></title>

<?php if ($noindex) { ?>
<!-- OCFilter Start -->
<meta name="robots" content="noindex,nofollow" />
<!-- OCFilter End -->
<?php } ?>
      
	<base href="<?php echo $base; ?>" />

	<!-- Meta -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<?php if($theme_options->get( 'responsive_design' ) != '0') { ?>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<?php } ?>
	<?php if ($description) { ?>
	<meta name="description" content="<?php echo $description; ?>" />
	<?php } ?>
	<?php if ($keywords) { ?>
	<meta name="keywords" content="<?php echo $keywords; ?>" />
	<?php } ?>

	<?php foreach ($links as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>

	<!-- Google Fonts -->
	<link href="//fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet" type="text/css">

	<!-- New Mobile Header -->
	<?php $v = rand(rand(rand(155, 455), rand(766, 988)), rand(rand(10, 25), rand(25, 50))); ?>
	<link href="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory');?>/css/new_mobile_header.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/new_filter_mobile.js"></script>

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
			echo '<link href="//fonts.googleapis.com/css?family=' . urlencode($font) . ':800,700,600,500,400,300,200,100" rel="stylesheet" type="text/css">';
			echo "\n";
		}
	}
	?>

	<?php $lista_plikow = array(
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/bootstrap.css?v=' . $v,
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/animate.css?v=' . $v,
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/stylesheet.css?v=' . $v,
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/responsive.css?v=' . $v,
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/menu.css?v=' . $v,
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/owl.carousel.css?v=' . $v,
			'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/font-awesome.min.css?v=' . $v
	);

	//RTL
	if($page_direction[$config->get( 'config_language_id' )] == 'RTL'){
	    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/rtl.css';
	    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/bootstrap_rtl.css';
	}

	// Full screen background slider
	if($config->get( 'full_screen_background_slider_module' ) != '') $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/jquery.vegas.css';

	// Category wall
	if($config->get( 'category_wall_module' ) != '') $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/category_wall.css';

	// Filter product
	if($config->get( 'filter_product_module' ) != '') $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/filter_product.css';

	// Wide width
	if($theme_options->get( 'page_width' ) == 1) $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/wide-grid.css';

	// Normal width
	if($theme_options->get( 'page_width' ) == 3) $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/standard-grid.css';

	// Spacing 20px
	if($theme_options->get( 'spacing_between_columns' ) == 2) $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/spacing_20.css';

	echo $theme_options->compressorCodeCss( $config->get($config->get('config_theme') . '_directory'), $lista_plikow, $theme_options->get( 'compressor_code_status' ), HTTP_SERVER );

	// Custom colors, fonts and backgrounds
	include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/css/custom_colors.php'); ?>

	<?php if($theme_options->get( 'custom_code_css_status' ) == 1) { ?>
	<link rel="stylesheet" href="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/skins/store_<?php echo $theme_options->get( 'store' ); ?>/<?php echo $theme_options->get( 'skin' ); ?>/css/custom_code.css">
	<?php } ?>


              <script src="https://api2.fondy.eu/static_common/v1/checkout/ipsp.js"></script>
			
<link href="catalog/view/theme/default/stylesheet/geoip.css" rel="stylesheet">
	<?php foreach ($styles as $style) { ?>
		<?php if(strpos($style['href'], "mf/jquery-ui.min.css") == true) { ?>
			<link rel="<?php echo $style['rel']; ?>" type="text/css" href="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/css/jquery-ui.min.css" media="<?php echo $style['media']; ?>" />
		<?php } elseif(strpos($style['href'], "mf/style.css") == true) { ?>
			<link rel="<?php echo $style['rel']; ?>" type="text/css" href="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/css/mega_filter.css" media="<?php echo $style['media']; ?>" />
		<?php } elseif(strpos($style['href'], "blog-news") == true) { ?>
			<link rel="<?php echo $style['rel']; ?>" type="text/css" href="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/css/blog.css" media="<?php echo $style['media']; ?>" />
		<?php } elseif($style['href'] != 'catalog/view/javascript/jquery/owl-carousel/owl.carousel.css') { ?>
			<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
		<?php } ?>
	<?php } ?>

	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/magnific/magnific-popup.css" media="screen" />

	<?php if($theme_options->get( 'page_width' ) == 2 && $theme_options->get( 'max_width' ) > 900) { ?>
	<style type="text/css">
		.standard-body .full-width .container {
			max-width: <?php echo $theme_options->get( 'max_width' ); ?>px;
			<?php if($theme_options->get( 'responsive_design' ) == '0') { ?>
			width: <?php echo $theme_options->get( 'max_width' ); ?>px;
			<?php } ?>
		}

		.main-fixed,
		.fixed-body-2-2,
		.standard-body .fixed2 .background {
			max-width: <?php echo $theme_options->get( 'max_width' ); ?>px;
			<?php if($theme_options->get( 'responsive_design' ) == '0') { ?>
			width: <?php echo $theme_options->get( 'max_width' ); ?>px;
			<?php } ?>
		}

		.standard-body .fixed .background {
		     max-width: <?php echo $theme_options->get( 'max_width' )-90; ?>px;
		     <?php if($theme_options->get( 'responsive_design' ) == '0') { ?>
		     width: <?php echo $theme_options->get( 'max_width' )-90; ?>px;
		     <?php } ?>
		}
	</style>
	<?php } ?>

    <?php $lista_plikow = array();

    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery-2.1.1.min.js?v=' . $v;
    if(file_exists('catalog/view/javascript/mf/jquery-ui.min.js')) $lista_plikow[] = 'catalog/view/javascript/mf/jquery-ui.min.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery-migrate-1.2.1.min.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery.easing.1.3.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/bootstrap.min.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/twitter-bootstrap-hover-dropdown.js?v=' . $v;
    if($theme_options->get( 'lazy_loading_images' ) != '0') $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/echo.min.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/common.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/tweetfeed.min.js?v=' . $v;
    $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/bootstrap-notify.min.js?v=' . $v;

    // Specials countdown
    if($theme_options->get( 'display_specials_countdown' ) == '1') {
         $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery.plugin.min.js?v=' . $v;
         $countdown = $theme_options->get( 'jquery_countdown_translate' );
         $language_id = $config->get( 'config_language_id' );
         if(isset($countdown[$language_id])) {
         	$lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/countdown/' . $countdown[$language_id];
         } else {
         	$lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/countdown/jquery.countdown.min.js?v=' . $v;
         }
    }

    // Banner module
    if($config->get( 'banner_module' ) != '') $lista_plikow[] = 'catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/js/jquery.cycle2.min.js?v=' . $v;

    echo $theme_options->compressorCodeJs( $config->get($config->get('config_theme') . '_directory'), $lista_plikow, $theme_options->get( 'compressor_code_status' ), HTTPS_SERVER ); ?>

    <?php // Full screen background slider
    if($config->get( 'full_screen_background_slider_module' ) != '') { ?>
        <script type="text/javascript" src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/jquery.vegas.min.js"></script>
    <?php } ?>

    <script type="text/javascript" src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/owl.carousel.min.js"></script>

    <?php if(!isset($_GEt['route'])) $_GET['route'] = false; ?>
    <?php if($theme_options->get( 'quick_search_autosuggest' ) != '0' && $_GET['route'] != 'affiliate/tracking') { ?>
    	<script type="text/javascript" src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/jquery-ui-1.10.4.custom.min.js"></script>
    <?php } ?>

    <script type="text/javascript" src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js"></script>

	<script type="text/javascript">
		var responsive_design = '<?php if($theme_options->get( 'responsive_design' ) == '0') { echo 'no'; } else { echo 'yes'; } ?>';
	</script>

	<?php foreach ($scripts as $script) { ?>
		<?php if($script != 'catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js') { ?>
			<script type="text/javascript" src="<?php echo $script; ?>"></script>
		<?php } ?>
		<?php if(strpos($script, "mega_filter.js") == true) { ?>
			<script type="text/javascript">
				function display_MFP(view) {
				     <?php if($theme_options->get( 'quick_view' ) == 1) { ?>
				     $('.quickview a').magnificPopup({
				          preloader: true,
				          tLoading: '',
				          type: 'iframe',
				          mainClass: 'quickview',
				          removalDelay: 200,
				          gallery: {
				           enabled: true
				          }
				     });
				     <?php } ?>

					if (localStorage.getItem('display') == 'list') {
						display('list');
					} else {
						display('grid');
					}
				}
			</script>
		<?php } ?>
	<?php } ?>

	<?php if($theme_options->get( 'custom_code_javascript_status' ) == 1) { ?>
		<script type="text/javascript" src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/skins/store_<?php echo $theme_options->get( 'store' ); ?>/<?php echo $theme_options->get( 'skin' ); ?>/js/custom_code.js"></script>
	<?php } ?>

	<?php foreach ($analytics as $analytic) { ?>
	<?php echo $analytic; ?>
	<?php } ?>
	<!--[if lt IE 9]>
		<script src="https://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<script src="catalog/view/theme/<?php echo $config->get($config->get('config_theme') . '_directory'); ?>/js/respond.min.js"></script>
	<![endif]-->
	<?php
	if(!empty($_SERVER["HTTP_USER_AGENT"])) {
	     $agent = $_SERVER["HTTP_USER_AGENT"];
	     if (preg_match('/mac/i', $agent)) {
	          if (preg_match('/firefox/i', $agent)) {
	               $class .= ' firefox-mac';
	          }
	     }
	}
	?>
		<link rel="apple-touch-icon" sizes="57x57" href="/apple-icon-57x57.png">
		<link rel="apple-touch-icon" sizes="60x60" href="/apple-icon-60x60.png">
		<link rel="apple-touch-icon" sizes="72x72" href="/apple-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="76x76" href="/apple-icon-76x76.png">
		<link rel="apple-touch-icon" sizes="114x114" href="/apple-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="120x120" href="/apple-icon-120x120.png">
		<link rel="apple-touch-icon" sizes="144x144" href="/apple-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="152x152" href="/apple-icon-152x152.png">
		<link rel="apple-touch-icon" sizes="180x180" href="/apple-icon-180x180.png">
		<link rel="icon" type="image/png" sizes="192x192"  href="/android-icon-192x192.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="96x96" href="/favicon-96x96.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
		<link rel="manifest" href="/manifest.json">
		<meta name="msapplication-TileColor" content="#ffffff">
		<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
		<meta name="theme-color" content="#ffffff">
		<meta name="wot-verification" content="e5811416aceeebabd0da"/>


				<?php if ($class == 'common-home') { ?>
				<script type="application/ld+json">
                {
                 "@context": "http://schema.org",
                 "@type": "WebSite",
                 "url": "<?php echo $base; ?>",
				 "name" : "<?php echo $store_name; ?>",
                 "potentialAction": {
                   "@type": "SearchAction",
                   "target": "<?php echo $base; ?>index.php?route=product/search&search={q}",
                   "query-input": "required name=q"
                 }
                }
                </script>
				<script type="application/ld+json">
                { "@context" : "http://schema.org",
                  "@type" : "Organization",
                  <?php if ($logo) { ?>
                  "logo" : "<?php echo $logo; ?>",
                  <?php } ?>
				  <?php if (!empty($support)) { ?>
                  "contactPoint" : [
                  { "@type" : "ContactPoint",
                    "telephone" : "<?php echo $support; ?>",
                    "contactType" : "customer service"
                  } ],
				  <?php } ?>
				  <?php if (!empty($social)) { ?>
				  "sameAs" : [<?php echo $social; ?>],
				  <?php } ?>
				  "url" : "<?php echo $base; ?>"
				}
				</script>
				<?php } ?>
                

				<script type="text/javascript">
$(document).ready(function() {
    colorListRollover();
	$('.color_items').hide();
	$('#color_options .color_option .preview-block').hide();
	$('.color_list').hover(function(){
		//on hover
		$(this).find('.color_items').fadeIn();
		$(this).find('.color_heading i').removeClass('fa-chevron-circle-down');
		$(this).find('.color_heading i').addClass('fa-chevron-circle-up');
	}, function() {
		//on unhover
		$(this).find('.color_items').fadeOut();
		$(this).find('.color_heading i').removeClass('fa-chevron-circle-up');
		$(this).find('.color_heading i').addClass('fa-chevron-circle-down');
	});
	$('#color_options div.color_option a').hover(function(){
			$this = $(this);
			$this.find('.preview-block').fadeIn();
		}, function(){
			//on unhover
			$this = $(this);
			$this.find('.preview-block').fadeOut();
		});
});

function colorListRollover() {
		$('.color_list .color-item a').hover(function(){
			//on hover
			$this = $(this);
			var hoverImage = $this.attr('rel');
			$this.parents('.product').find('.image a img').attr('src', hoverImage);
		}, function(){
			//on unhover
			$this = $(this);
			var defaultImage = $this.attr('default-image');
			$this.parents('.product').find('.image a img').attr('src', defaultImage);
		});
		
}
</script>

<script src="catalog/view/javascript/jquery/jquery.geoip-module.js" type="text/javascript"></script>
<!--BOF Product Series-->
			<style>	
				.pds a, .pds a:hover, .pds a:visited
				{
					text-decoration: none;
				}
			
				.pds a.preview
				{
					display: inline-block;
				}
				
				.pds a.preview.pds-current, .pds a.pds-current
				{
					border-bottom: 3px solid orange;
				}
				
				#preview{
					position: absolute;
					border: 1px solid #DBDEE1;
					background: #F8F8F8;
					padding: 5px;
					display: none;
					color: #333;
					z-index: 1000000;
				}
			</style>
			<script type="text/javascript" src="catalog/view/javascript/imagepreview/imagepreview.js"></script>
			<script type="text/javascript">
				$(document).ready(function(){
					pdsListRollover();
				});
				
				function pdsListRollover()
				{
					$('.pds a.pds-thumb-rollover').hover(function(){
						//on hover
						$this = $(this);
						var hoverImage = $this.attr('rel');
						$this.parents('.product-thumb').find('.image a img').attr('src', hoverImage);
					}, function(){
						//on unhover
						$this = $(this);
						var masterImage = $this.attr('master-image');
						$this.parents('.product-thumb').find('.image a img').attr('src', masterImage);
					});
				}
			</script>
			<!--EOF Product Series-->
</head>
<body class="<?php echo $class; ?> <?php if($theme_options->get( 'page_width' ) == 2 && $theme_options->get( 'max_width' ) > 1400) { echo 'body-full-width'; } ?> <?php if($theme_options->get( 'product_list_type' ) > 0) { echo 'product-list-type-' . $theme_options->get( 'product_list_type' ); } ?> <?php if($theme_options->get( 'product_grid_type' ) > 0) { echo 'product-grid-type-' . $theme_options->get( 'product_grid_type' ); } ?> <?php if($theme_options->get( 'dropdown_menu_type' ) > 0) { echo 'dropdown-menu-type-' . $theme_options->get( 'dropdown_menu_type' ); } ?> <?php if($theme_options->get( 'products_buttons_action' ) > 0) { echo 'products-buttons-action-type-' . $theme_options->get( 'products_buttons_action' ); } ?> <?php if($theme_options->get( 'buttons_prev_next_in_slider' ) > 0) { echo 'buttons-prev-next-type-' . $theme_options->get( 'buttons_prev_next_in_slider' ); } ?> <?php if($theme_options->get( 'inputs_type' ) > 0) { echo 'inputs-type-' . $theme_options->get( 'inputs_type' ); } ?> <?php if($theme_options->get( 'cart_block_type' ) > 0) { echo 'cart-block-type-' . $theme_options->get( 'cart_block_type' ); } ?> <?php if($theme_options->get( 'my_account_type' ) > 0) { echo 'my-account-type-' . $theme_options->get( 'my_account_type' ); } ?> <?php if($theme_options->get( 'top_bar_type' ) > 0) { echo 'top-bar-type-' . $theme_options->get( 'top_bar_type' ); } ?> <?php if($theme_options->get( 'show_vertical_menu_category_page' ) > 0) { echo 'show-vertical-megamenu-category-page'; } ?> <?php if($theme_options->get( 'show_vertical_menu_product_page' ) > 0) { echo 'show-vertical-megamenu-product-page'; } ?> <?php if($theme_options->get( 'show_vertical_menu' ) > 0) { echo 'show-vertical-megamenu'; } ?> <?php if($theme_options->get( 'product_page_type' ) > 0) { echo 'product-page-type-' . $theme_options->get( 'product_page_type' ); } ?> <?php if($theme_options->get( 'megamenu_type' ) > 0) { echo 'megamenu-type-' . $theme_options->get( 'megamenu_type' ); } ?> <?php if($theme_options->get( 'search_type_in_header' ) > 0) { echo 'search-type-' . $theme_options->get( 'search_type_in_header' ); } ?> <?php if($theme_options->get( 'megamenu_label_type' ) > 0) { echo 'megamenu-label-type-' . $theme_options->get( 'megamenu_label_type' ); } ?> <?php if($theme_options->get( 'box_type' ) == 7) { echo 'box-type-4'; } else { echo 'no-box-type-7'; } ?> <?php if($theme_options->get( 'box_type' ) > 0) { echo 'box-type-' . $theme_options->get( 'box_type' ); } ?> <?php if($theme_options->get( 'header_margin_top' ) > 0) { echo 'header-margin-top-' . $theme_options->get( 'header_margin_top' ); } ?> <?php if($theme_options->get( 'sale_new_type' ) > 0) { echo 'sale-new-type-' . $theme_options->get( 'sale_new_type' ); } ?> <?php if($theme_options->get( 'button_type' ) > 0) { echo 'button-body-type-' . $theme_options->get( 'button_type' ); } ?> <?php if($theme_options->get( 'countdown_special' ) > 0) { echo 'countdown-special-type-' . $theme_options->get( 'countdown_special' ); } ?> <?php if($theme_options->get( 'footer_type' ) > 0) { echo 'footer-type-' . $theme_options->get( 'footer_type' ); } ?> <?php if($theme_options->get( 'breadcrumb_style' ) > 0) { echo 'breadcrumb-style-' . $theme_options->get( 'breadcrumb_style' ); } ?> <?php if($theme_options->get( 'border_width' ) == '1') { echo 'border-width-1'; } else { echo 'border-width-0'; } ?> <?php if(($theme_options->get( 'body_background_color' ) == '#ffffff' || ($theme_options->get( 'main_content_background_color' ) == $theme_options->get( 'body_background_color' ) && $theme_options->get( 'body_background_color' ) != '') || $theme_options->get( 'main_content_background_color' ) == 'none') && $theme_options->get( 'colors_status' ) == '1') { echo 'body-white'; } else { echo 'body-other'; } ?> <?php if($theme_options->get( 'main_content_background_color' ) == 'none' && $theme_options->get( 'colors_status' ) == '1') { echo 'body-white-type-2'; } ?> <?php if($theme_options->get( 'main_content_background_color' ) == 'none' && $theme_options->get( 'box_with_products_background_color' ) == '#ffffff' && $theme_options->get( 'colors_status' ) == '1') { echo 'body-white-type-3'; } ?> <?php if($theme_options->get( 'hover_effect' ) == '1') { echo 'banners-effect-' . $theme_options->get( 'hover_effect_type' ); } ?> body-header-type-<?php echo $theme_options->get( 'header_type' ); ?>">
<div style="display:none"><?php echo $geoip;?></div>
<?php if($theme_options->get( 'widget_facebook_status' ) == 1) { ?>
<div class="facebook_<?php if($theme_options->get( 'widget_facebook_position' ) == 1) { echo 'left'; } else { echo 'right'; } ?> hidden-xs hidden-sm">
	<div class="facebook-icon"></div>
	<div class="facebook-content">
		<script>(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));</script>

		<div class="fb-like-box fb_iframe_widget" profile_id="<?php echo $theme_options->get( 'widget_facebook_id' ); ?>" data-colorscheme="light" data-height="370" data-connections="16" fb-xfbml-state="rendered"></div>
	</div>

	<script type="text/javascript">
	$(function() {
		$(".facebook_right").hover(function() {
			$(".facebook_right").stop(true, false).animate({right: "0"}, 800, 'easeOutQuint');
		}, function() {
			$(".facebook_right").stop(true, false).animate({right: "-308"}, 800, 'easeInQuint');
		}, 1000);

		$(".facebook_left").hover(function() {
			$(".facebook_left").stop(true, false).animate({left: "0"}, 800, 'easeOutQuint');
		}, function() {
			$(".facebook_left").stop(true, false).animate({left: "-308"}, 800, 'easeInQuint');
		}, 1000);
	});
	</script>
</div>
<?php } ?>

<?php if($theme_options->get( 'widget_twitter_status' ) == 1) { ?>
<div class="twitter_<?php if($theme_options->get( 'widget_twitter_position' ) == 1) { echo 'left'; } else { echo 'right'; } ?> hidden-xs hidden-sm">
	<div class="twitter-icon"></div>
	<div class="twitter-content">
		<a class="twitter-timeline"  href="https://twitter.com/@<?php echo $theme_options->get( 'widget_twitter_user_name' ); ?>" data-chrome="noborders" data-tweet-limit="<?php echo $theme_options->get( 'widget_twitter_limit' ); ?>"  data-widget-id="<?php echo $theme_options->get( 'widget_twitter_id' ); ?>" data-theme="light" data-related="twitterapi,twitter" data-aria-polite="assertive">Tweets by @<?php echo $theme_options->get( 'widget_twitter_user_name' ); ?></a>
	</div>

	<script type="text/javascript">
	!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
	$(function() {
		$(".twitter_right").hover(function() {
			$(".twitter_right").stop(true, false).animate({right: "0"}, 800, 'easeOutQuint');
		}, function() {
			$(".twitter_right").stop(true, false).animate({right: "-308"}, 800, 'easeInQuint');
		}, 1000);

		$(".twitter_left").hover(function() {
			$(".twitter_left").stop(true, false).animate({left: "0"}, 800, 'easeOutQuint');
		}, function() {
			$(".twitter_left").stop(true, false).animate({left: "-308"}, 800, 'easeInQuint');
		}, 1000);
	});
	</script>
</div>
<?php } ?>

<?php if($theme_options->get( 'widget_custom_status' ) == 1) { ?>
<div class="custom_<?php if($theme_options->get( 'widget_custom_position' ) == 1) { echo 'left'; } else { echo 'right'; } ?> hidden-xs hidden-sm">
	<div class="custom-icon"></div>
	<div class="custom-content">
		<?php $lang_id = $config->get( 'config_language_id' ); ?>
		<?php $custom_content = $theme_options->get( 'widget_custom_content' ); ?>
		<?php if(isset($custom_content[$lang_id])) echo html_entity_decode($custom_content[$lang_id]); ?>
	</div>

	<script type="text/javascript">
	$(function() {
		$(".custom_right").hover(function() {
			$(".custom_right").stop(true, false).animate({right: "0"}, 800, 'easeOutQuint');
		}, function() {
			$(".custom_right").stop(true, false).animate({right: "-308"}, 800, 'easeInQuint');
		}, 1000);

		$(".custom_left").hover(function() {
			$(".custom_left").stop(true, false).animate({left: "0"}, 800, 'easeOutQuint');
		}, function() {
			$(".custom_left").stop(true, false).animate({left: "-308"}, 800, 'easeInQuint');
		}, 1000);
	});
	</script>

</div>
<?php } ?>

<?php if($theme_options->get( 'quick_view' ) == 1) { ?>
<script type="text/javascript">
$(window).load(function(){
     $('.quickview a').magnificPopup({
          preloader: true,
          tLoading: '',
          type: 'iframe',
          mainClass: 'quickview',
          removalDelay: 200,
          gallery: {
           enabled: true
          }
     });
});
</script>
<?php } ?>

<?php
$popup = $modules_old_opencart->getModules('popup');
if( count($popup) ) {
	foreach ($popup as $module) {
		echo $module;
	}
} ?>

<?php
$header_notice = $modules_old_opencart->getModules('header_notice');
if( count($header_notice) ) {
	foreach ($header_notice as $module) {
		echo $module;
	}
} ?>

<?php
$cookie = $modules_old_opencart->getModules('cookie');
if( count($cookie) ) {
	foreach ($cookie as $module) {
		echo $module;
	}
} ?>

<div class="<?php if($theme_options->get( 'main_layout' ) == 1 || $theme_options->get( 'main_layout' ) == 5) { echo 'standard-body'; } else { echo 'fixed-body'; } if($theme_options->get( 'main_layout' ) == 7) { echo ' fixed-body-shoes'; } if($theme_options->get( 'main_layout' ) == 4 || $theme_options->get( 'main_layout' ) == 6) { echo ' fixed-body-2'; } if($theme_options->get( 'main_layout' ) == 5) { echo ' fixed-body-2-2'; } if($theme_options->get( 'main_layout' ) == 3) { echo ' with-shadow'; } ?>">
	<div id="main" class="<?php if($theme_options->get( 'main_layout' ) == 4) { echo 'main-fixed2 main-fixed'; } else if($theme_options->get( 'main_layout' ) == 6) { echo 'main-fixed2 main-fixed3 main-fixed'; } else if($theme_options->get( 'main_layout' ) != 1 && $theme_options->get( 'main_layout' ) != 5) { echo 'main-fixed'; } ?>">
		<?php
		if($theme_options->get( 'header_type' ) == 2) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_02.tpl');
		} elseif($theme_options->get( 'header_type' ) == 3) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_03.tpl');
		} elseif($theme_options->get( 'header_type' ) == 4) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_04.tpl');
		} elseif($theme_options->get( 'header_type' ) == 5) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_05.tpl');
		} elseif($theme_options->get( 'header_type' ) == 6) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_06.tpl');
		} elseif($theme_options->get( 'header_type' ) == 7) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_07.tpl');
		} elseif($theme_options->get( 'header_type' ) == 8) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_08.tpl');
		} elseif($theme_options->get( 'header_type' ) == 9) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_09.tpl');
		} elseif($theme_options->get( 'header_type' ) == 10) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_10.tpl');
		} elseif($theme_options->get( 'header_type' ) == 11) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_11.tpl');
		} elseif($theme_options->get( 'header_type' ) == 12) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_12.tpl');
		} elseif($theme_options->get( 'header_type' ) == 13) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_13.tpl');
		} elseif($theme_options->get( 'header_type' ) == 14) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_14.tpl');
		} elseif($theme_options->get( 'header_type' ) == 15) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_15.tpl');
		} elseif($theme_options->get( 'header_type' ) == 16) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_16.tpl');
		} elseif($theme_options->get( 'header_type' ) == 17) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_17.tpl');
		} elseif($theme_options->get( 'header_type' ) == 18) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_18.tpl');
		} elseif($theme_options->get( 'header_type' ) == 19) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_19.tpl');
		} elseif($theme_options->get( 'header_type' ) == 20) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_20.tpl');
		} elseif($theme_options->get( 'header_type' ) == 21) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_21.tpl');
		} elseif($theme_options->get( 'header_type' ) == 22) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_22.tpl');
		} elseif($theme_options->get( 'header_type' ) == 23) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_23.tpl');
		} elseif($theme_options->get( 'header_type' ) == 24) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_24.tpl');
		} elseif($theme_options->get( 'header_type' ) == 25) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_25.tpl');
		} elseif($theme_options->get( 'header_type' ) == 26) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_26.tpl');
		} elseif($theme_options->get( 'header_type' ) == 27) {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_27.tpl');
		} else {
			include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/common/header/header_01.tpl');
		}
		?>

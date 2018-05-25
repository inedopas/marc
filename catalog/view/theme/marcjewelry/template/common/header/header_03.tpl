<?php /*if($theme_options->get( 'fixed_header' ) == 1) { ?>
<!-- HEADER
	================================================== -->
<div class="fixed-header-1 sticky-header header-type-3" style="display: none;">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">
					<div class="container">
						<div class="row">
						     <?php if ($logo) {
						     $nthumb = str_replace(' ', "%20", ($logo));
						     $nthumb = str_replace(HTTP_SERVER, "", $nthumb);
						     $image_size = getimagesize($nthumb); ?>
						     <!-- Header Left -->
						     <div class="col-sm-4" id="header-left" style="min-width: <?php echo $image_size[0]+55; ?>px">
						          <!-- Logo -->
						          <div class="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
						     </div>
						     <?php } ?>

							<!-- Header Left -->
							<div class="col-sm-6" id="header-center">
	                                    <?php
	                                    $menu = $modules_old_opencart->getModules('menu');
	                                    if( count($menu) ) { ?>
	                                         <div class="megamenu-background">
	                                              <div class="">
	                                                   <div class="overflow-megamenu container">
	                                    				<?php
	                                    				if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
	                                    				$i = 0;

	                                    				foreach ($menu as $module) {
	                                    				     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
	                                    				     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
	                                    					     echo $module;
	                                    					if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
	                                    					if(count($menu) > 1 && $i == 1) echo '</div>';
	                                    					$i++;
	                                    				} ?>
	                                    			</div>
	                                    		</div>
	                                    	</div>
	                                    <?php } elseif($categories) { ?>
	                                    <div class="megamenu-background">
	                                         <div class="">
	                                              <div class="overflow-megamenu container">
	                                    			<div class="container-megamenu horizontal">
	                                    				<div class="megaMenuToggle">
	                                    					<div class="megamenuToogle-wrapper">
	                                    						<div class="megamenuToogle-pattern">
	                                    							<div class="container">
	                                    								<div><span></span><span></span><span></span></div>
	                                    								Navigation
	                                    							</div>
	                                    						</div>
	                                    					</div>
	                                    				</div>

	                                    				<div class="megamenu-wrapper">
	                                    					<div class="megamenu-pattern">
	                                    						<div class="container">
	                                    							<ul class="megamenu shift-up">
	                                    								<?php foreach ($categories as $category) { ?>
	                                    								<?php if ($category['children']) { ?>
	                                    								<li class="with-sub-menu hover"><p class="close-menu"></p><p class="open-menu"></p>
	                                    									<a href="<?php echo $category['href'];?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
	                                    								<?php } else { ?>
	                                    								<li>
	                                    									<a href="<?php echo $category['href']; ?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
	                                    								<?php } ?>
	                                    									<?php if ($category['children']) { ?>
	                                    									<?php
	                                    										$width = '100%';
	                                    										$row_fluid = 3;
	                                    										if($category['column'] == 1) { $width = '220px'; $row_fluid = 12; }
	                                    										if($category['column'] == 2) { $width = '500px'; $row_fluid = 6; }
	                                    										if($category['column'] == 3) { $width = '700px'; $row_fluid = 4; }
	                                    									?>
	                                    									<div class="sub-menu" style="width: <?php echo $width; ?>">
	                                    										<div class="content">
	                                    											<p class="arrow"></p>
	                                    											<div class="row hover-menu">
	                                    												<?php for ($i = 0; $i < count($category['children']);) { ?>
	                                    												<div class="col-sm-<?php echo $row_fluid; ?> mobile-enabled">
	                                    													<div class="menu">
	                                    														<ul>
	                                    														  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
	                                    														  <?php for (; $i < $j; $i++) { ?>
	                                    														  <?php if (isset($category['children'][$i])) { ?>
	                                    														  <li><a href="<?php echo $category['children'][$i]['href']; ?>" class="main-menu"><?php echo $category['children'][$i]['name']; ?></a></li>
	                                    														  <?php } ?>
	                                    														  <?php } ?>
	                                    														</ul>
	                                    													</div>
	                                    												</div>
	                                    												<?php } ?>
	                                    											</div>
	                                    										</div>
	                                    									</div>
	                                    									<?php } ?>
	                                    								</li>
	                                    								<?php } ?>
	                                    							</ul>
	                                    						</div>
	                                    					</div>
	                                    				</div>
	                                    			</div>
	                                    		</div>
	                                    	</div>
	                                    </div>
	                                    <?php
	                                    }
	                                    ?>
							</div>

							<!-- Header Right -->
							<div class="col-sm-2" id="header-right">
							     <?php
							     $top_block = $modules_old_opencart->getModules('top_block');
							     if( count($top_block) ) {
							     	foreach ($top_block as $module) {
							     		echo $module;
							     	}
							     } ?>

							     <!-- Search --><!-- <div class="search_form"> <a href="smart_search" style="color:#19a1df; color:hover:#fff;"> <i class="fa fa-search"></a></i></div> -->

								<?php echo $cart; ?>
							</div>
						</div>
					</div>

					<?php
					$menu2 = $modules_old_opencart->getModules('menu2');
					if( count($menu2) ) {
					     echo '<div class="overflow-menu2">';
						foreach ($menu2 as $module) {
							echo $module;
						}
						echo '</div>';
					} ?>
				</div>
			</div>
		</div>
	</div>
</div>
<?php }*/ ?>

<!-- HEADER
	================================================== -->
<!-- <div class="terget_old">
	<a href="https://old.marcasite.ru" style="color: white;" >ПЕРЕЙТИ НА СТАРЫЙ САЙТ</a>
</div> -->
<header class="header-type-3">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">
				     <div class="top-bar">
				          <div class="container">
				               <!-- Links -->
				               <ul class="menu col-sm-7">
				               	<li><a href="http://marcasite.su">КАБИНЕТ ПАРТНЕРА</a></li>
				               	<!-- <li><a href="tel:<?php echo $telephone; ?>"><span class="phone_info"><?php echo $telephone; ?></span></a></li> -->
				               </ul>
				               <?php echo $currency.$language; ?>
				               <div class="col-sm-3"><?php echo $search; ?></div>
				          </div>
				     </div>

					<div class="container">
						<div class="row">
						     <?php if ($logo) {
						     $nthumb = str_replace(' ', "%20", ($logo));
						     $nthumb = str_replace(HTTP_SERVER, "", $nthumb);
						     $image_size = getimagesize($nthumb); ?>
						     <!-- Header Left -->
						     <div class="col-sm-3" id="header-left" style="min-width: <?php echo $image_size[0]+5; ?>px">
						          <!-- Logo -->
						          <div class="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
						     </div>
						     <?php } ?>

							<!-- Header Left -->
							<div class="col-sm-7" id="header-center">
                                        <?php
                                        $menu = $modules_old_opencart->getModules('menu');
                                        if( count($menu) ) { ?>
                                             <div class="megamenu-background">
                                                  <div class="">
                                                       <div class="overflow-megamenu container">
                                        				<?php
                                        				if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
                                        				$i = 0;

                                        				foreach ($menu as $module) {
                                        				     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
                                        				     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
                                        					     echo $module;
                                        					if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
                                        					if(count($menu) > 1 && $i == 1) echo '</div>';
                                        					$i++;
                                        				} ?>
                                        			</div>
                                        		</div>
                                        	</div>
                                        <?php } elseif($categories) { ?>
                                        <div class="megamenu-background">
                                             <div class="">
                                                  <div class="overflow-megamenu container">
                                        			<div class="container-megamenu horizontal">
                                        				<div class="megaMenuToggle">
                                        					<div class="megamenuToogle-wrapper">
                                        						<div class="megamenuToogle-pattern">
                                        							<div class="container">
                                        								<div><span></span><span></span><span></span></div>
                                        								Navigation
                                        							</div>
                                        						</div>
                                        					</div>
                                        				</div>

                                        				<div class="megamenu-wrapper">
                                        					<div class="megamenu-pattern">
                                        						<div class="container">
                                        							<ul class="megamenu shift-up">
                                        								<?php foreach ($categories as $category) { ?>
                                        								<?php if ($category['children']) { ?>
                                        								<li class="with-sub-menu hover"><p class="close-menu"></p><p class="open-menu"></p>
                                        									<a href="<?php echo $category['href'];?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
                                        								<?php } else { ?>
                                        								<li>
                                        									<a href="<?php echo $category['href']; ?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
                                        								<?php } ?>
                                        									<?php if ($category['children']) { ?>
                                        									<?php
                                        										$width = '100%';
                                        										$row_fluid = 3;
                                        										if($category['column'] == 1) { $width = '220px'; $row_fluid = 12; }
                                        										if($category['column'] == 2) { $width = '500px'; $row_fluid = 6; }
                                        										if($category['column'] == 3) { $width = '700px'; $row_fluid = 4; }
                                        									?>
                                        									<div class="sub-menu" style="width: <?php echo $width; ?>">
                                        										<div class="content">
                                        											<p class="arrow"></p>
                                        											<div class="row hover-menu">
                                        												<?php for ($i = 0; $i < count($category['children']);) { ?>
                                        												<div class="col-sm-<?php echo $row_fluid; ?> mobile-enabled">
                                        													<div class="menu">
                                        														<ul>
                                        														  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                                        														  <?php for (; $i < $j; $i++) { ?>
                                        														  <?php if (isset($category['children'][$i])) { ?>
                                        														  <li><a href="<?php echo $category['children'][$i]['href']; ?>" class="main-menu"><?php echo $category['children'][$i]['name']; ?></a></li>
                                        														  <?php } ?>
                                        														  <?php } ?>
                                        														</ul>
                                        													</div>
                                        												</div>
                                        												<?php } ?>
                                        											</div>
                                        										</div>
                                        									</div>
                                        									<?php } ?>
                                        								</li>
                                        								<?php } ?>
                                        							</ul>
                                        						</div>
                                        					</div>
                                        				</div>
                                        			</div>
                                        		</div>
                                        	</div>
                                        </div>
                                        <?php
                                        }
                                        ?>
							</div>

							<!-- Header Right -->
							<div class="col-sm-2" id="header-right">
							     <?php
							     $top_block = $modules_old_opencart->getModules('top_block');
							     if( count($top_block) ) {
							     	foreach ($top_block as $module) {
							     		echo $module;
							     	}
							     } ?>


							     <!-- Search1 -->
								<?php echo $search; ?>
<script>
function trackChange(value)
{
	$('#search2 input[name=\'search2\']').parent().find('button').on('click', function() {
		var url = $('base').attr('href') + 'index.php?route=product/search';

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;

		console.log(value);
	});

	$('#search input[name=\'search\']').on('keydown', function(e) {
		if (e.keyCode == 13) {
			$('#search input[name=\'search\']').parent().find('button').trigger('click');
		}
	});

$('#search2 input[name=\'search2\']').keypress(function (e) {
  if (e.which == 13) {
		var url = $('base').attr('href') + 'index.php?route=product/search';

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;
  }
});

}
</script>
<style>
#top #header-right {
    position: relative;
}
#search2 {
    position: absolute;
    width: 200px;
    left: -143px;
    top: 32px;
    display: inline-block;
    display: none;
}
#search2 .searchs_input {
    border-radius: 0;
    margin: 0;
    padding-right: 30px;
}
#search2 .input-group-btn {
    position: absolute;
    right: 30px;
    top: 6px;
}
#search2 button {
    border: none;
    background: none;
    padding-top:4px;
}
.target_old {
	width:100%;
	height: 30px;
	background-color: red;
	font-size: 14px;
	text-align: center;
	padding-top: 4px;}
@media (max-width: 991px){
	#search2 {
	    left: 10px;
	}
}
@media (max-width: 553px){
	#search2 {
	    left: 10px;
	    width: calc(100% - 20px);
	    z-index: 100;
	    top: -10px;
	}
}

</style>
								<?php echo $cart; ?>
							</div>
						</div>
					</div>

					<?php
					$menu2 = $modules_old_opencart->getModules('menu2');
					if( count($menu2) ) {
					     echo '<div class="overflow-menu2">';
						foreach ($menu2 as $module) {
							echo $module;
						}
						echo '</div>';
					} ?>
				</div>
			</div>
		</div>
	</div>
	<!--Mobile Header-->
		<div class="mobile-header-new clearfix">
			<div class="mobile-logo-new">
				<?php if ($logo) { ?>
					<a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
				<?php } else { ?>
					<a href="<?php echo $home; ?>">Logo></a>
				<?php } ?>
			</div>
			<div class="mobile-menu-new">
				<span>Меню</span>
				<span class="fa fa-bars"></span>
			</div>
			<div class="mobile-menu-new-item">
				<?php $menu = $modules_old_opencart->getModules('menu'); ?>
				<?php if($menu) { ?>
					<?php foreach ($menu as $module) { ?>
						<?php echo $module; ?>
					<?php } ?>
				<?php } ?>
			</div>
		</div>
		<div class="mobile-header-sub-new">
			<ul>
				<li><a href="#">Акция</a></li>
				<li><a href="#">Новая колекция</a></li>
				<li><a href="#">Новости</a></li>
			</ul>
		</div>
	<!--end Mobile header-->

	<?php $slideshow = $modules_old_opencart->getModules('slideshow'); ?>
	<?php  if(count($slideshow)) { ?>
	<!-- Slider -->
	<div id="slider" class="<?php if($theme_options->get( 'slideshow_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'slideshow_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'slideshow_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?>">
		<div class="background-slider"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<?php foreach($slideshow as $module) { ?>
				<?php echo $module; ?>
				<?php } ?>
			</div>
		</div>
	</div>
	<?php } ?>
</header>
<?php if ($_SERVER['REQUEST_URI'] != '/') { ?>
	<a href="#" onclick="history.back(); return false;" class="back-btn"><i class="fa fa-arrow-left" aria-hidden="true"></i></a>
<?php } ?>

	<script>
		$('.megaMenuToggle').click(function(){
			if ($(this).hasClass('openedt')) {
				$(this).removeClass('openedt');
				$('.mobile-header-sub-new').css('z-index', '10000');
			} else {
				$(this).addClass('openedt');
				$('.mobile-header-sub-new').css('z-index', '0');
			}
		});
	</script>

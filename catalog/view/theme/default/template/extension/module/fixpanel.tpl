<style>
.fix_panel_minimalizm_theme{background:<?=$color_back ?>;}
.fix_panel_minimalizm_theme.position_top{border-bottom: 1px solid <?=$color_border ?>;}
.fix_panel_minimalizm_theme.position_bottom{border-top: 1px solid <?=$color_border ?>;}
.fix_panel_minimalizm_theme .fix_phone {color: <?=$color_phone ?>;}
.fix_panel_minimalizm_theme .fix_phone:after {border-right:1px solid <?=$color_border ?>;}
.fix_panel_minimalizm_theme .fix_links ul li a{color: <?=$color_links ?>;}
.fix_panel_minimalizm_theme .fix_viewed{color: <?=$color_links ?>;}
.fix_panel_minimalizm_theme .fix_links ul li:hover a,.fix_panel_dark_theme .fix_links ul li:focus a{color: <?=$color_links_h ?>}
.fix_panel_minimalizm_theme .fix_social_links:after {border-left: 1px solid <?=$color_border ?>;}
</style>

<?php if(!empty($add_phone) || !empty($map) || !empty($address)) { ?>
	<div id="fix_contact_div" style="display: none;">
		<span><?php echo $text_add_phone ?></span> <?php echo $fix_phone ?>,  <?php echo $add_phone ?><br />
		<span><?php echo $text_address ?></span> <?php echo $address ?><br />
		<iframe src="<?php echo $map ?>" width="100%" height="350" frameborder="0" style="border:0" allowfullscreen></iframe>
	</div>
<?php } ?> 

<div id="fix_up" class="fix_up_<?php echo $fix_position ?>"></div>

<div id="fix_panel" class="fix_panel_<?php echo $fix_theme ?>_theme position_<?php echo $fix_position ?> fix_hide">

<div class="inner_fix_panel">
	<div class="fix_phone"><?php echo $fix_phone ?>
	<?php if(!empty($add_phone) || !empty($map) || !empty($address)) { ?>
		<span id="fix_contacts"><?php echo $text_all_contancts ?></span>
	<?php } ?> 
	</div>
	
	<div class="fix_wishlist">
	<div id="fix_wishlist_products" class="<?php echo 'wishlist_pr_'.$fix_theme ?><?php if($fix_position=='top') { echo 'fix_view_products top'; } ?>" ></div>
	<span id="wishlist-text">Список желаний (<span id="total-wl"><?php echo $total_wl ?></span>)</span></div>
	<div class="fix_social_links">
		<ul>
			<?php if($fix_link_fb!=''){ ?>
				<li><a href="<?php echo $fix_link_fb ?>" class="link_fb" target="_blank"></a></li>
			<?php } ?>	
			<?php if($fix_link_vk!=''){ ?>	
				<li><a href="<?php echo $fix_link_vk ?>" class="link_vk" target="_blank"></a></li>
			<?php } ?>	
			<?php if($fix_link_gp!=''){ ?>	
				<li><a href="<?php echo $fix_link_gp ?>" class="link_gp" target="_blank"></a></li>
			<?php } ?>	
			<?php if($fix_link_tw!=''){ ?>	
				<li><a href="<?php echo $fix_link_tw ?>" class="link_tw" target="_blank"></a></li>
			<?php } ?>		
			<?php if($fix_link_inst!=''){ ?>	
				<li><a href="<?php echo $fix_link_inst ?>" class="link_inst" target="_blank"></a></li>
			<?php } ?>
		</ul>
	</div>
	<div class="fix_links">
		<ul>
			<?php if($oc_link==1){ ?>
				<?php if($link_lk==1){ ?>
					<li class="link_lk"><a href="<?php echo $account ?>"><div class="fp_img"><img src="/image/data/<?php echo $fix_theme ?>_fix_panel_set.png" /></div><span class="link_text"><?php echo $text_account ?></span></a></li>
				<?php } ?>	
				<?php if($link_cart==1){ ?>
					<li class="link_cart"><a href="<?php echo $shopping_cart ?>"><div class="fp_img"><img src="/image/data/<?php echo $fix_theme ?>_fix_panel_set.png" /></div><span class="link_text"><?php echo $text_cart ?></span></a></li>
				<?php } ?>	
				<?php if($link_feedback==1){ ?>
					<li class="link_feedback"><a href="<?php echo $contact ?>"><div class="fp_img"><img src="/image/data/<?php echo $fix_theme ?>_fix_panel_set.png" /></div><span class="link_text"><?php echo $text_feedback ?></span></a></li>
				<?php } ?>
			<?php } ?>
			<?php if($custom_links){ ?>
				<?php foreach($custom_links as $link) { ?>
					<li class="link_custom"><a href="<?php echo $link['link'] ?>"><div class="fp_img"><img src="/image/<?php echo $link['image'] ?>" width="24px" height="24px"/></div><span class="link_text"><?php echo $link['name'][$lang_id] ?></span></a></li>
				<?php } ?>
			<?php } ?>
		</ul>
	</div>
</div>

</div>

<script type="text/javascript">
$(document).ready(function() {

var owl = $("#owl-viewed");
owl.owlCarousel({
	 
		items : 6,
		itemsDesktop : [1199,4],
		itemsDesktopSmall : [980,3],
		itemsTablet: [768,2],
		itemsMobile : [479,1],
		
		navigation: true,
		slideSpeed: 200,
		paginationSpeed: 800,
		stopOnHover: true,
		rewindSpeed: 1000,
		lazyLoad : true,
		mouseDrag: true,
		touchDrag: true,
		pagination: false, 
	 
		// CSS Styles
		baseClass : "owl-carousel",
		theme : "owl-theme"
});
	
  var top_show = 300; // В каком положении полосы прокрутки начинать показ кнопки "Наверх"
  var delay = 500; // Задержка прокрутки

    $(window).scroll(function () { // При прокрутке попадаем в эту функцию
      /* В зависимости от положения полосы прокрукти и значения top_show, скрываем или открываем кнопку "Наверх" */
      if ($(this).scrollTop() > top_show) $('#fix_up').fadeIn();
      else $('#fix_up').fadeOut();
    });
    $('#fix_up').click(function () { // При клике по кнопке "Наверх" попадаем в эту функцию
      /* Плавная прокрутка наверх */
      $('body, html').animate({
        scrollTop: 0
      }, delay);
    });


$('#fix-show-hide').click(function(){
	$('#fix_panel').toggle('slow');
});
$('#fix-hide-show').click(function(){
	$('#fix_panel').toggle('slow');
});
$('.fix_viewed').click(function(){
	$('#fix_wishlist_products').css("display", "none");
	$('#fix_view_products').toggle('slow');
});
	
$('#wishlist-text').click(function(){
	$('#fix_wishlist_products').load('/index.php?route=extension/module/fixpanel/getWishlist');
	getcount();
	$('#fix_view_products').css("display", "none");
	$('#fix_wishlist_products').toggle('slow');
}); 

$('#fix_view_products').css("display", "none");
$('#fix_wishlist_products').css("display", "none");
		
$.ajaxPrefilter(function(options, originalOptions, jqXHR ) {
	var success = options.success;
	var url = options.url;

	if(url == 'index.php?route=account/wishlist/add') {
		    options.success = function (data) {
			    if (success != null) {
				    getcount();
			    }
		    };
	}

});

});

function getcount(){
	$.ajax({
		url: 'index.php?route=extension/module/fixpanel/countWishlist',
			type: 'post',
			dataType: 'json',
			success: function(json) {
				$('#total-wl').html(json['total']);
			}
	});
}
</script>

<?php if(!empty($add_phone) || !empty($map) || !empty($address)) { ?>
<script type="text/javascript">
$('.fix_phone').click(function(){

$.colorbox({inline:true, width:"800px",maxWidth:"95%", open:true, href:"#fix_contact_div",
	onClosed: function() {
		$('#fix_contact_div').hide();
	},
	onOpen: function() {
		$('#fix_contact_div').show();
	}
});  
}); 


</script>
<?php } ?>
<?php if($fix_position=='top') { ?>
<script type="text/javascript">
$(document).ready(function(){

var panel = $("#fix_panel");

$(window).scroll(function(){
if ( $(this).scrollTop() > 150 && panel.hasClass("fix_hide") ){
	panel.removeClass("fix_hide").addClass("fix_show");
	panel.css("display", "block");
	} else if($(this).scrollTop() <= 150 && panel.hasClass("fix_show")) {
		panel.removeClass("fix_show").addClass("fix_hide");
		panel.css("display", "none");
	}
});
});
</script>
<?php } ?>


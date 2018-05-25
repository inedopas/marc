$(document).ready(function(){
	colorListPreview();
	colorListRollover();
	colorListDropdown();
	$('.color_items').hide();
	$('#color-options .color-option .preview_block').hide();
});

function colorListPreview() {
	$('#color-options .color-option a').hover(function(){
		//on hover
		$this = $(this);
		$this.find('.preview_block').show();
	}, function(){
		//on unhover
		$this = $(this);
		$this.find('.preview_block').hide();
	});
}

function colorListDropdown() {
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
}

function colorListRollover() {
		$('.color_list .color_item a').hover(function(){
			//on hover
			$this = $(this);
			var hoverImage = $this.attr('rel');
			$this.parents('.product').find('.product-image a img').attr('src', hoverImage);
		}, function(){
			//on unhover
			$this = $(this);
			var defaultImage = $this.attr('default-image');
			$this.parents('.product').find('.product-image a img').attr('src', defaultImage);
		});
}
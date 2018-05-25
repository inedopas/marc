function open_filter(elem) {
	if ($('.mfilter-free-container').hasClass('active-filter')) {
		$('.mfilter-free-container').removeClass('active-filter');
		$("#button-filter-open").removeClass('filter_change_pos');
		$("#button-filter-open").html('<i class="fa fa-filter"></i> Фильтры');
	} else {
		$('.mfilter-free-container').addClass('active-filter');
		$("#button-filter-open").addClass('filter_change_pos');
		$("#button-filter-open").html('<i class="fa fa-times"></i>');
	}
}
document.addEventListener("DOMContentLoaded", function(){
	jQuery(function(f){
		f(window).scroll(function(){
			if (f(this).scrollTop() > 100) {
				$('#button-filter-open').addClass('filter_change_pos');
			} else {
				$('#button-filter-open').removeClass('filter_change_pos');
			}
		});
	});
});
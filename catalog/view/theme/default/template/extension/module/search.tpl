<style type="text/css">
#search-column{
}
#search-column .input-lg {
    height: 40px;
    line-height: 20px;
    padding: 0 10px;
    margin-left: 8px;
}
#search-column .btn-lg {
    font-size: 15px;
    line-height: 18px;
    padding: 10px 15px;
    text-shadow: 0 1px 0 #FFF;
        right: 32px;
    height: 40px;
    top: 3px;
}
</style>

<div class="search-column">
	<!-- <h3><?php echo $heading_title; ?></h3> -->
	<div class="search-column-form">
		<div id="search-column" class="input-group">
		  <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_search; ?>" class="form-control input-lg" />
		  <span class="input-group-btn">
		    <button type="button" class="btn btn-default btn-lg"><i class="fa fa-search"></i></button>
		  </span>
		</div>
	</div>
</div>

<script type="text/javascript">
	$('#search-column input[name=\'search\']').parent().find('button').on('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';

		var value = $('#search-column input[name=\'search\']').val();

		if (value) {
			url += '&search=' + encodeURIComponent(value);
		}

		location = url;
	});

	$('#search-column input[name=\'search\']').on('keydown', function(e) {
		if (e.keyCode == 13) {
			$('#search-column input[name=\'search\']').parent().find('button').trigger('click');
		}
	});
</script>
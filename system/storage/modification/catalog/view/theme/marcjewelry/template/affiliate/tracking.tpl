<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>


<p><?php echo $text_description; ?></p>
<?php  
  if (file_exists(DIR_TEMPLATE.'default/template/affiliate/trackingurl.tpl')) {
    require_once(DIR_TEMPLATE.'default/template/affiliate/trackingurl.tpl');
  } 
?>

<div class="buttons clearfix">
  <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
</div>

<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['link']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'product\']').val(item['label']);
		$('textarea[name=\'link\']').val(item['value']);
	}
});
//--></script>

<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>

<script type="text/javascript"><!--
function referal(url, product) {
    $('textarea[name=\'link\']').val(url);
  $('input[name=\'product\']').val(product);  
}
//--></script>
      
<?php echo $footer; ?>
<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
  <fieldset>
    <legend><?php echo $text_your_payment; ?></legend>
    <div class="form-group">
      <label class="col-sm-2 control-label" for="input-tax"><?php echo $entry_tax; ?></label>
      <div class="col-sm-10">
        <input type="text" name="tax" value="<?php echo $tax; ?>" placeholder="<?php echo $entry_tax; ?>" id="input-tax" class="form-control" />
      </div>
    </div>
    <div class="form-group">
      
<?php  
  if (file_exists(DIR_TEMPLATE.'default/template/affiliate/walletplaument.tpl')) {
    require_once(DIR_TEMPLATE.'default/template/affiliate/walletplaument.tpl');
  } 
?>
      
  <div class="buttons clearfix">
    <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
    <div class="pull-right">
      <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" />
    </div>
  </div>
</form>

<script type="text/javascript"><!--
$('input[name=\'payment\']').on('change', function() {
    $('.payment').hide();
    
    $('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script> 

<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>
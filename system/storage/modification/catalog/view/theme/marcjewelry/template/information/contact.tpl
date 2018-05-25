<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<div class="row">
	<div class="col-sm-<?php if($theme_options->get( 'custom_block', 'contact_page', $config->get( 'config_language_id' ), 'status' ) == 1) { echo 9; } else { echo 12; } ?>">
	

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
  <fieldset>
    <legend style="text-align: center;"><?php echo $text_contact; ?></legend>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-name"></label>
      <div class="col-sm-10">
        <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control"  placeholder="<?php echo $entry_name; ?>"/>
        <?php if ($error_name) { ?>
        <div class="text-danger"><?php echo $error_name; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-email"></label>
      <div class="col-sm-10">
        <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control"   placeholder="<?php echo $entry_email; ?>"/>
        <?php if ($error_email) { ?>
        <div class="text-danger"><?php echo $error_email; ?></div>
        <?php } ?>
      </div>
    </div>
    <div class="form-group required">
      <label class="col-sm-2 control-label" for="input-enquiry"></label>
      <div class="col-sm-10">
        <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"  placeholder="<?php echo $entry_enquiry; ?>"><?php echo $enquiry; ?></textarea>
        <?php if ($error_enquiry) { ?>
        <div class="text-danger"><?php echo $error_enquiry; ?></div>
        <?php } ?>
      </div>
    </div>
    <?php echo $captcha; ?>
  </fieldset>
  <div class="buttons">
    <div class="pull-right">
      <input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
    </div>
  </div>
</form>
	
  </div>
  	
  <?php if($theme_options->get( 'custom_block', 'contact_page', $config->get( 'config_language_id' ), 'status' ) == 1) { ?>
  <div class="col-sm-3">
  	<div class="product-block">
  		<?php if($theme_options->get( 'custom_block', 'contact_page', $config->get( 'config_language_id' ), 'heading' ) != '') { ?>
  		<h4 class="title-block"><?php echo $theme_options->get( 'custom_block', 'contact_page', $config->get( 'config_language_id' ), 'heading' ); ?></h4>
  		<div class="strip-line"></div>
  		<?php } ?>
  		<div class="block-content">
  			<?php echo html_entity_decode($theme_options->get( 'custom_block', 'contact_page', $config->get( 'config_language_id' ), 'text' )); ?>
  		</div>
  	</div>
  </div>
  <?php } ?>
</div>
  
<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<style>
  iframe{
    widht: 100% !important;
    height: 240px !important;
  }
</style>

				<script type="application/ld+json">
				{
				"@context": "http://schema.org",
                "@type": "BreadcrumbList",
                "itemListElement":
                [
				<?php $home = array_shift($breadcrumbs); ?>
				{
                "@type": "ListItem",
                "position": 1,
                "item":
                {
                  "@id": "<?php echo $base; ?>",
                  "name": "<?php echo $store_name; ?>"
                }
				},
				<?php for($i = 0; $i < count($breadcrumbs); ++$i) { 
				if ( strpos($breadcrumbs[$i]['href'], '?route=') == false ) {
				   $breadcrumb_url = explode("?", $breadcrumbs[$i]['href']);
				} else { $breadcrumb_url = explode("&", $breadcrumbs[$i]['href']); }
				?>
                {
                "@type": "ListItem",
                "position": <?php echo $i+2; ?>,
                "item":
                {
                  "@id": "<?php echo $breadcrumb_url[0]; ?>",
                  "name": "<?php echo $breadcrumbs[$i]['text']; ?>"
                }
                }<?php echo($i !== (count($breadcrumbs)-1) ? ',' : ''); ?>
                <?php } ?>
				]
				}
				</script>
                
<?php echo $footer; ?>
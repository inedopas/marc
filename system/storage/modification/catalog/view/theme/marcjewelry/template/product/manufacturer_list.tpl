<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/new_elements/wrapper_top.tpl'); ?>

<?php if ($categories) { ?>
<p><b><?php echo $text_index; ?></b>
  <?php foreach ($categories as $category) { ?>
  &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><b><?php echo $category['name']; ?></b></a>
  <?php } ?>
</p>
<?php foreach ($categories as $category) { ?>
<div class="manufacturer-list">
  <div class="manufacturer-heading"><?php echo $category['name']; ?><a id="<?php echo $category['name']; ?>"></a></div>
  <div class="manufacturer-content">
    <?php if ($category['manufacturer']) { ?>
    <?php for ($i = 0; $i < count($category['manufacturer']);) { ?>
    <ul>
      <?php $j = $i + ceil(count($category['manufacturer']) / 4); ?>
      <?php for (; $i < $j; $i++) { ?>
      <?php if (isset($category['manufacturer'][$i])) { ?>
      <li><a href="<?php echo $category['manufacturer'][$i]['href']; ?>"><?php echo $category['manufacturer'][$i]['name']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
    <?php } ?>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php } else { ?>
<p><?php echo $text_empty; ?></p>
<div class="buttons clearfix">
  <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
</div>
<?php } ?>

<?php include('catalog/view/theme/'.$config->get($config->get('config_theme') . '_directory').'/template/new_elements/wrapper_bottom.tpl'); ?>

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
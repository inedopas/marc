<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<div style="padding-bottom: 10px"><?php echo $description; ?></div>
<style="body {background-image: url(image/backinfo.png)}"></style>

<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>

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
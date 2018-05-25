<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php echo $description; ?><?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>

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
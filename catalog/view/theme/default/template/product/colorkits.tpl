<div style="padding:15px">
<?php $count_for_col = $colors_cfg['limit']; 
$cell = ceil( 12 / $count_for_col );
$count_colors = count($colors);
for ($i = 0; $i <= $count_colors;) {
$results = array_slice($colors,$i,$count_for_col); ?> 


<div class="row" id="popupColorKits">
	<?php foreach ($results as $color) { ?>
      <div class="col-sm-<?php echo $cell ?> col-xs-12">
	  <div class="product-thumb transition <?php echo $color['quantity']?>">
	  
        <?php if ($color['thumb']) { ?>
        <div class="image"><a href="<?php echo $color['href']; ?>"><img src="<?php echo $color['thumb']; ?>" alt="<?php echo $color['name_color']; ?>" class="img-responsive"/></a></div>
        <?php } ?>
		  <?php if(isset($color['quantity'])){ ?>
		  <div class="hideQuantity">Нет в наличии</div>
		  <?php } ?>
			<h4><a href="<?php echo $color['href']; ?>"><?php echo $color['name_color']; ?></a></h4>
		
			<?php if ($color['price']) { ?>
			<div class="price">
			  <?php if (!$color['special']) { ?>
			  <?php echo $color['price']; ?> 
			  <?php } else { ?>
			  <span class="price-old"><?php echo $color['price']; ?></span> <span class="price-new"><?php echo $color['special']; ?></span>
			  <?php } ?>
			</div>
			<?php } ?>
      </div>
	  </div>
	<?php } ?>
</div>

<?php $i += $count_for_col; } ?></div>
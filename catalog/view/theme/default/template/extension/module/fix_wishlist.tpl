<?php if(!empty($products)) { ?>

<div class="box-wishlist">
	<?php foreach($products as $product) { ?>
      <div class="item">
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
		
		<div class="remove" onclick="$('#fix_wishlist_products').load('<?php echo $product['remove']; ?>');getcount();">x</div>
      </div>
      <?php } ?>	
</div>

<?php } else { ?>
 
<span class="empty_wl">Список пустой</span>
 
<?php } ?>


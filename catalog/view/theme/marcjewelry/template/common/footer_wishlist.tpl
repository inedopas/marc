<?php if ($wishlist_products) { ?>
<table class="table table-bordered table-hover">
	<thead>
	<tr>
		<td class="text-center">Изображение</td>
		<td class="text-left">Наименование товара</td>
		<td class="text-right">Цена</td>
		<td class="text-right">Действие</td>
	</tr>
	</thead>
	<tbody>
	<?php foreach ($wishlist_products as $product) { ?>
	<tr>
		<td class="text-center"><?php if ($product['thumb']) { ?>
			<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
			<?php } ?></td>
		<td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
		<td class="text-right">
			<?php if ($product['price']) { ?>
			<div class="price">
				<?php if (!$product['special']) { ?>
				<?php echo $product['price']; ?>
				<?php } else { ?>
				<b><?php echo $product['special']; ?></b> <s><?php echo $product['price']; ?></s>
				<?php } ?>
			</div>
			<?php } ?>
		</td>
		<td class="text-right">
			<button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" title="В корзину" class="btn btn-primary">
				<i class="fa fa-shopping-cart"></i>
			</button>
			<a href="<?php echo $product['remove']; ?>" data-toggle="tooltip" title="Удалить" class="btn btn-danger">
				<i class="fa fa-times"></i>
			</a>
		</td>
	</tr>
	<?php } ?>
	</tbody>
</table>
<?php if (count($wishlist_products) > 5) { ?>
<p class="text-center">
	<a href="<?php echo $wishlist; ?>" class="btn btn-default">Посмотреть все</a>
</p>
<?php } ?>
<?php } else { ?>
<p>Нет даных</p>
<?php } ?>
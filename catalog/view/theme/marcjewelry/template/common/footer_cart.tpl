<?php if ($products_cart) { ?>
<div class="mini-cart-info">
	<table>
		<?php foreach ($products_cart as $product) { ?>
		<tr>
			<td class="image">
				<?php if ($product['thumb']) { ?>
				<a href="<?php echo $product['href']; ?>">
					<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
				</a>
				<?php } ?>
			</td>
			<td class="name">
				<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
				<div>
					<?php foreach ($product['option'] as $option) { ?>
					- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
					<?php } ?>
					<?php if ($product['recurring']): ?>
					- <small><?php echo $text_recurring ?> <?php echo $product['recurring']; ?></small><br />
					<?php endif; ?>
				</div>
			</td>
			<td class="quantity">x&nbsp;<?php echo $product['quantity']; ?></td>
			<td class="total"><?php echo $product['total']; ?></td>
		</tr>
		<?php } ?>
	</table>
</div>
<div class="mini-cart-total">
	<table>
		<?php foreach ($totals as $total) { ?>
		<tr>
			<td class="right"><b><?php echo $total['title']; ?>:</b></td>
			<td class="right"><?php echo $total['text']; ?></td>
		</tr>
		<?php } ?>
	</table>
</div>
<p class="text-center">
	<a href="<?php echo $checkout;?>" class="btn btn-default">Оформить заказ</a>
</p>
<?php } else { ?>
<div class="empty">Корзина пустая</div>
<?php } ?>
<?php if (count($products_cart) > 5) { ?>
<p class="text-center">
	<a href="<?php echo $cart; ?>" class="btn btn-default">Посмотреть все</a>
</p>
<?php } ?>
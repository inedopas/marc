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
      <div class="row">
        <?php if ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-8'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <?php if ($thumb || $images) { ?>
          <ul class="thumbnails">
            <?php if ($thumb) { ?>
            <li><a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
            <?php } ?>
            <?php if ($images) { ?>
            <?php foreach ($images as $image) { ?>
            <li class="image-additional"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
            <?php if ($attribute_groups) { ?>
            <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
            <?php } ?>
            <?php if ($review_status) { ?>
            <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
            <?php } ?>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
            <?php if ($attribute_groups) { ?>
            <div class="tab-pane" id="tab-specification">
              <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
            <?php if ($review_status) { ?>
            <div class="tab-pane" id="tab-review">
              <form class="form-horizontal" id="form-review">
                
				<div id="review">
				  <?php if ($reviews_first['reviews']) { 
				     if ( count($reviews_first['reviews']) > 5 ) {
					   $reviews_first_page = array_slice($reviews_first['reviews'], 0, 5);
					 } else { $reviews_first_page = $reviews_first['reviews']; }
				  ?>
					<?php foreach ($reviews_first_page as $review) { ?>
					<table class="table table-striped table-bordered">
					  <tr>
						<td style="width: 50%;"><strong><?php echo $review['author']; ?></strong></td>
						<td class="text-right"><?php echo $review['date_added']; ?></td>
					  </tr>
					  <tr>
						<td colspan="2"><p><?php echo $review['text']; ?></p>

			<?php if ($review['answer']) { ?>
			<hr>
			  <div class="answer_admin">
				<p><strong><?php echo $review['admin_author']; ?></strong> - <?php echo $entry_admin_author; ?></p>
				<p><?php echo $review['answer']; ?></p>
			  </div>
			<?php } ?>
			</div>
		
						  <?php for ($i = 1; $i <= 5; $i++) { ?>
						  <?php if ($review['rating'] < $i) { ?>
						  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
						  <?php } else { ?>
						  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
						  <?php } ?>
						  <?php } ?></td>
					  </tr>
					</table>
					<?php } ?>
					<div class="text-right"><?php echo $reviews_first['pagination']; ?></div>
					<?php } else { ?>
					<p><?php echo $reviews_first['text_no_reviews']; ?></p>
					<?php } ?>
				</div>
				
                <h2><?php echo $text_write; ?></h2>
                <?php if ($review_guest) { ?>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                    <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                    <div class="help-block"><?php echo $text_note; ?></div>
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label"><?php echo $entry_rating; ?></label>
                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
                    &nbsp;<?php echo $entry_good; ?></div>
                </div>
                <?php echo $captcha; ?>
                <div class="buttons clearfix">
                  <div class="pull-right">
                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                  </div>
                </div>
                <?php } else { ?>
                <?php echo $text_login; ?>
                <?php } ?>
              </form>
            </div>
            <?php } ?>
          </div>
        </div>
        <?php if ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-4'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <div class="btn-group">
            <button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button>
            <button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button>
          </div>
          <h1><?php echo $heading_title; ?></h1>
          <ul class="list-unstyled">
            <?php if ($manufacturer) { ?>
            <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
            <?php } ?>
            <li><?php echo $text_model; ?> <?php echo $model; ?></li>
            <?php if ($reward) { ?>
            <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
            <?php } ?>
            <li id="stock"><?php echo $text_stock; ?> <?php echo $stock; ?></li>
          </ul>
          <?php if ($price) { ?>
          <ul class="list-unstyled">
            <?php if (!$special) { ?>
            <li>
              <h2 id="price"><?php echo $price; ?></h2>
            </li>
            <?php } else { ?>
            <li><span style="text-decoration: line-through;"><?php echo $price; ?></span></li>
            <li>
              <h2><?php echo $special; ?></h2>
            </li>
            <?php } ?>
            <?php if ($tax) { ?>
            <li id="tax"><?php echo $text_tax; ?> <?php echo $tax; ?></li>
            <?php } ?>
            <?php if ($points) { ?>
            <li id="points"><?php echo $text_points; ?> <?php echo $points; ?></li>
            <?php } ?>
            <?php if ($discounts) { ?>
            <li>
              <hr>
            </li>
            <?php foreach ($discounts as $discount) { ?>
            <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <div id="product">
			
					
					<?php if(!empty($colors)){ ?>
					<div id="color_options">
					<div class="heading"><?php echo $colors_title?></div>
					<?php foreach($colors as $color){ ?>
						<?php if($color['product_id'] == $product_id) { ?>
							<div class="color_option active <?php echo $color['tpl']?> <?php echo $color['quantity']?>" style="<?php if($colors_cfg['name']!=1){ ?>padding:0;<?php } ?>">
								<?php if(isset($color['quantity'])){ ?>
									<div class="hideQuantity">Нет в наличии</div>
								<?php } ?>
								<?php if($color['tpl'] == 'color'){ ?>
									<div class="color_block" style="background:<?php echo $color['color'] ?>"></div>
								<?php } elseif($color['tpl'] == 'photos'){ ?>
									<div class="image_block"><img src="<?php echo $color['ico_photo'] ?>" /></div>
								<?php } else { ?>
									<div class="image_block"><img src="<?php echo $color['ico_color'] ?>" /></div>
								<?php } ?>
								<?php if($colors_cfg['name']==1){ ?>
									<div class="color_name"><?php echo $color['color_name'] ?></div> 
								<?php } ?>
								
							</div>
						<?php } else {  ?>
							<div class="color_option <?php echo $color['tpl']?> <?php echo $color['quantity']?>">
								<?php if(isset($color['quantity'])){ ?>
									<div class="hideQuantity">Нет в наличии</div>
								<?php } ?>
								<a href="<?php echo $color['href'] ?>">
								
									<?php if($color['tpl'] == 'color'){ ?>
										<div class="color_block" style="background:<?php echo $color['color'] ?>;<?php if($colors_cfg['name']!=1){ ?>padding:0;<?php } ?>"></div>
									<?php } elseif($color['tpl'] == 'photos'){ ?>
										<div class="image_block"><img src="<?php echo $color['ico_photo'] ?>" /></div>
										<div class="preview-block">
										    <img src="<?php echo $color['preview_photo']?>" />
										    <div class="name"><?php echo $color['name']?></div>
										    <div class="price"><?php echo "от " . $color['price'] . " ₽"?></div>
										</div>
									<?php } else { ?>
										<div class="image_block"><img src="<?php echo $color['ico_color'] ?>" /></div>
									<?php } ?>

									<?php if($colors_cfg['name']==1){ ?>
										<div class="color_name"><?php echo $color['color_name'] ?></div> 
									<?php } ?>
								</a>
							</div>
						<?php } ?>	
					<?php } ?>

					<?php if($colors_cfg['enable_popup'] === '0'){ ?>
					<a class="colors fancybox.ajax" href="index.php?route=product/colorkits&c_product_id=<?php echo $product_id ?>">All colors</a>
					<script type="text/javascript">
					$(document).ready(function() {
						
						$(".colors").fancybox({
							openEffect : 'elastic',
							closeEffect : 'elastic',
							fitToView   : false,
							autoSize    : true,
							closeClick  : false							
						});
					});
					</script>
					<?php } ?>
					</div>
				<?php } ?>
				
            <?php if ($options) { ?>
            <hr>
            <h3><?php echo $text_option; ?></h3>
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <option class="<?php echo $option_value['class']; ?>" value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input class="<?php echo $option_value['class']; ?>" type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>                    
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <label>
                    <input class="<?php echo $option_value['class']; ?>" type="checkbox" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php if ($option_value['image']) { ?>
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> 
                    <?php } ?>
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring; ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
            <?php } ?>
            <div class="form-group">
              <label class="control-label" for="input-quantity"><?php echo $entry_qty; ?></label>
              <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <input type="hidden" name="product_feature_id" value="0" />
              <input type="hidden" name="unit_id" value="0" />

              <br />
              <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block"><?php echo $button_cart; ?></button>
            </div>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>
          </div>
          <?php if ($review_status) { ?>
          <div class="rating">
            <p>
              <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($rating < $i) { ?>
              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } else { ?>
              <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } ?>
              <?php } ?>
              <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $text_write; ?></a></p>
            <hr>
            <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style" data-url="<?php echo $share; ?>"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
            <!-- AddThis Button END -->
          </div>
          <?php } ?>
        </div>
      </div>
      <?php if ($products) { ?>
      <h3><?php echo $text_related; ?></h3>
      <div class="row">
        <?php $i = 0; ?>
        <?php foreach ($products as $product) { ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-xs-8 col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-xs-6 col-md-4'; ?>
        <?php } else { ?>
        <?php $class = 'col-xs-6 col-sm-3'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <div class="product-thumb transition">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div class="caption">
              <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
              <p><?php echo $product['description']; ?></p>
              <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($j = 1; $j <= 5; $j++) { ?>
                <?php if ($product['rating'] < $j) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
              <?php if ($product['price']) { ?>
              <p class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                <?php } ?>
                <?php if ($product['tax']) { ?>
                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                <?php } ?>
              </p>
              <?php } ?>
            </div>
            <div class="button-group">
              <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="fa fa-shopping-cart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
            </div>
          </div>
        </div>
        <?php if (($column_left && $column_right) && (($i+1) % 2 == 0)) { ?>
        <div class="clearfix visible-md visible-sm"></div>
        <?php } elseif (($column_left || $column_right) && (($i+1) % 3 == 0)) { ?>
        <div class="clearfix visible-md"></div>
        <?php } elseif (($i+1) % 4 == 0) { ?>
        <div class="clearfix visible-md"></div>
        <?php } ?>
        <?php $i++; ?>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($tags) { ?>
      <p><?php echo $text_tags; ?>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');

				$('html, body').animate({ scrollTop: 0 }, 'slow');

				$('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		},
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
	});
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').val(json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});


				/*$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');*/
				

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
    grecaptcha.reset();
});

var text_stock = "<?php echo $text_stock; ?>";
var text_tax = "<?php echo $text_tax; ?>";
<?php
if (isset($warehouses)) {
	echo "var \$warehouses = {";
	foreach ($warehouses as $warehouse_id => $name) {
		echo "'" . $warehouse_id . "':'" . $name . "',";
	}
	echo "}\n";
}
?>
<?php if ($options) {?>
//------------------------------------------------------------------------------------------------------------------------------
// Определение переменных для характеристик
var $options_type = {<?php foreach ($options as $option) { echo $option['product_option_id'].":'".$option['type']."',"; }?>};
var options_order = [<?php foreach ($options as $option) { echo $option['product_option_id'].","; }?>];
var $options_required = {<?php foreach ($options as $option) { echo $option['product_option_id'].":true,"; }?>};
var $options = {<?php
	foreach ($product_features_options as $product_feature_id => $feature) {
		$str_value = $product_feature_id.":{";
		foreach ($feature as $product_option_id => $product_option_value_id) {
			$str_value .= $product_option_id.":".$product_option_value_id.",";
		}
		$str_value .= "},";
		echo $str_value;
	}
	echo "};\n";?>
// Тут хранится id выбранной характеристики
var product_feature_id = 0;
var unit_id = 0;
<?php

	$str_features =  "var \$features = {";
	$str_price =  "var \$price = {";
	$str_quantity = "// quantity{product_feature_id:{warehouse_id:{unit_id:quantity}}}\n";
	$quantity_total =  0;
	$str_quantity .=  "var \$quantity = {";
	foreach ($product_features_options as $product_feature_id => $feature_option) {
		// Цены
		$str_price .= "'" . $product_feature_id . "':{'value':" . $product_features_price[$product_feature_id]['value'] . ",'tax':" . $product_features_price[$product_feature_id]['tax'] . ",'unit':" . $product_features_price[$product_feature_id]['unit'] . "},";
		// Характеристики
		$str_features .= "'" . implode("_", $feature_option) . "':" . $product_feature_id . ",";
		// Остатки
		$quantity_array = isset($product_quantity[$product_feature_id]) ? $product_quantity[$product_feature_id] : array();
		$str_quantity .= "'" . $product_feature_id . "':";

		$str_quantity .= "{";
		foreach ($quantity_array as $warehouse_id => $quantity) {
			$str_quantity .= "'" . $warehouse_id . "':" . $quantity . ",";
			$quantity_total += $quantity;
		}
		$str_quantity .= "},";

	}
	echo $str_features . "};\n";
	echo $str_price . "};\n";
	echo $str_quantity . "};\n";
	echo "var quantity_total = " . $quantity_total . ";\n";
	echo "var \$product_units = {";
	foreach ($product_units as $unit_id => $unit) {
		echo $unit_id . ":{'name':'" . $unit['name'] . "','ratio':".$unit['ratio']."},";
	}
	echo "};\n";
	echo "var \$currency_data = {'symbol':'".$currency_data['symbol']."','decimal':".$currency_data['decimal']."};\n";
?>


//------------------------------------------------------------------------------------------------------------------------------
// Функция отображает остатки по складам
// Возвращает строковую переменную в которой перечислены названия всех складов с остатками и единицами измерений
function displayQuantity() {

	if ($.type($quantity[product_feature_id]) == "string") {

		// Если переменная строка, то есть нет складов, возвращается только количество
		return $quantity[product_feature_id];

	} else {

		var str = "";
		var quantity_warehouse = 0;
		var str_war = "";
		unit_id = $price[product_feature_id]['unit'];
		var $unit = $product_units[unit_id];
		var total = 0;

		// Единица цены
		if ($unit) {
			str_unit = " ("+$unit['name']+")";
		} else {
			str_unit = "";
		}

		// Перебираем все остатки по складам
		$.each($quantity[product_feature_id],function(warehouse_id, product_quantity) {

			// Нет складов, если warehouse_id = 0
			if (warehouse_id == "0") {

				// Перебираем все единицы измерений
				$.each(product_quantity,function(unit_id, quantity) {
					//str += quantity+" ("+$unit['name']+"),";
					str += "\n" + quantity;
				});
			}
			// Остатки в выбранной единице
			else if (unit_id != 0) {

				// Название склада
				str_war = " Склад: "+$warehouses[warehouse_id]+": ";

			} else {
				if (product_quantity > 0) {
					quantity_warehouse++;
					str_war += " " + $warehouses[warehouse_id] + " = " + product_quantity + str_unit;
				}
			}
		});
		if (quantity_warehouse > 0) {
			str = " " + quantity_total + str_unit + " в " + quantity_warehouse + " магазинах: (" + str_war + ")";
		} else if (quantity_total > 0) {
			if ($unit['ratio'] != 0) {
				total = quantity_total / $unit['ratio'];
			}
			str = " " + total + " по опциям: " + $quantity[product_feature_id][0] + str_unit;
		} else {
			str = " нет в наличии";
		}
		return str;
	}
} // displayQuantity()

//------------------------------------------------------------------------------------------------------------------------------
// Функция отображает на странице цену, налоги, остатки,
// а также, для передачи в корзину, устанавливает значение product_feature_id
function displaySelect() {
	if (product_feature_id){
		$('#price').text(Math.round($price[product_feature_id]['value']).toFixed($currency_data['decimal'])+$currency_data['symbol']);
		$('#tax').text(text_tax+" "+Math.round($price[product_feature_id]['tax']).toFixed($currency_data['decimal'])+$currency_data['symbol']);
		$('#stock').text(text_stock+" "+displayQuantity());
		$('input[name=\'product_feature_id\']').val(product_feature_id);
		$('input[name=\'unit_id\']').val(unit_id);
	} else {
		$('#price').text("");
		$('#tax').text("");
		$('#stock').text(text_stock+" "+quantity_total+" ("+$product_units[0]['name']+")");
		$('input[name=\'product_feature_id\']').val(0);
		$('input[name=\'unit_id\']').val(0);
	}
} // displaySelect()

//------------------------------------------------------------------------------------------------------------------------------
// Функция очищает все опции и разблокирует их, сбрасывает ид характеристики, а также обновляет надписи на страничке
function clearOptions() {

	// Перебираем все опции
	$.each($options_type,function(product_option_id, value) {

		if (value == "select") {

			// Делаем доступным опцию
			$('select[name="option['+product_option_id+']"]').attr("disabled",false);

			// Сбрасываем выбор, по-умолчанию будет выбран первый элемент
			$('select[name="option['+product_option_id+']"]').val('');

			// Делаем доступным все значения опции
			$('select[name="option['+product_option_id+']"] option').each(function(){
				$(this).removeAttr("disabled");
			});
		} else {

			// Делаем доступным опцию
			$('input[name="option['+product_option_id+']"]').attr("disabled",false);

			// Снимаем выбор со всех значений
			$('input[name="option['+product_option_id+']"]').attr('checked', false);
		}
		$options_required[product_option_id] = true;
	});

	// Проверка на обязательные опции
	checkRequired();

	// Сбрасываем выбранную характеристику
	product_feature_id = 0;

	// Обновляем надписи на страничке
	displaySelect();

} // clearOptions()

//------------------------------------------------------------------------------------------------------------------------------
// Функция проверяет и устанавливает какие опции обязательные, бывает что некоторые характеристики имеют разное количество опций
function checkRequired() {

	// Перебираем все опции
	$.each($options_required,function(product_option_id, required) {

		if ($options_type[product_option_id] == "select") {

			// Получаем элемент в котором устанавливается класс обязательной опции
			$form = $('select[name="option['+product_option_id+']"]').parents("div.form-group");

			// Если опция должна быть обязательной, а она не содержит класс "required", устанавливает этот класс или наоборот убираем его
			if (required && !$form.hasClass("required")) {
				$form.addClass("required");
			} else if (!required && $form.hasClass("required")) {
				$form.removeClass("required");
			}

		} else {

			// Получаем элемент в котором устанавливается класс обязательной опции
			$form = $('input[name="option['+product_option_id+']"]').parents("div.form-group");

			// Если опция должна быть обязательной, а она не содержит класс "required", устанавливает этот класс или наоборот убираем его
			if (required && !$form.hasClass("required")) {
				$form.addClass("required");
			} else if (!required && $form.hasClass("required")) {
				$form.removeClass("required");
			}
		}
	});
} // checkRequired()

//------------------------------------------------------------------------------------------------------------------------------
// Функция возвращает выбранные опции значений в виде объекта
// Возвращает $option_values - объект с опция и значениями
function getOptionValues() {
	var $option_values = {};

	// Перебираем опции в том порядке в каком они заданы на сайте
	$.each(options_order,function(index, product_option_id) {

		if ($options_type[product_option_id] == 'select') {
			// Если опция типа select
			$option_values[product_option_id] = $('select[name="option['+product_option_id+']"] :selected').val();

		} else {
			// Если опция типа input
			$option_values[product_option_id] = $('input[name="option['+product_option_id+']"]:checked').val();
		}
	});
	return $option_values;
} // getOptionValues()

//------------------------------------------------------------------------------------------------------------------------------
// Функция по выбранным опциям возвращает product_feature_id
// $option_values - объект с опциями и значений
// Возвращает ид характеристики, если вариант выбранныхопций не существует ни в одной характеристики, то вернет 0
function getProductFeature($option_values) {
	var new_product_feature_id = 0;
	$.each($options,function(feature_id, $product_options) {

		// Количество совпадений
		var matches = 0;

		// Перебираем все опции характеристики
		$.each($product_options,function(product_option_id, product_option_value_id) {

			// Ищем совпадение значений
			if ($option_values[product_option_id] == product_option_value_id) {
				matches ++;
			}
		});

		// Если совпали все опции
		if (matches == options_order.length) {

			// Сохраним значение характеристики где совпали все опции
			new_product_feature_id = feature_id;

			// Прервем цикл
			return false;
		}
	});

	return new_product_feature_id;
} // getProductFeature()

//------------------------------------------------------------------------------------------------------------------------------
// Функция устанавливает доступность опции типа input и ее значения
// current_product_option_value_id - текущее выбранное значение опции
// current_option_id - текущая опция в которой выбрано значение
// $option_values - объект в котором заданы все значения опций текущей характеристики
// Возвращает значение текущей опции
function setAccessInputOption(current_option_id, current_product_option_value_id, $option_values) {
	var val = 0;
	var required = false;

	// Перебираем все значения опций
	$('div#input-option'+current_option_id+' div label input').each(function(index){

		// Если в классе не содержится значение выбранной опции, то отключаем эту опцию и снимаем флажок
		if (!$(this).hasClass(current_product_option_value_id) && (current_product_option_value_id)) {
			$(this).attr("disabled",true);
			$(this).prop("checked",false);

		} else {

			required = true;

			// Включаем,если была отключена ранее
			$(this).attr("disabled",false);

			// Если есть в варианте текущее значение опции
			if ($option_values[current_option_id] == $(this).val()) {

				// И еще не выбрано значение
				if (!val) {
					val = $(this).val();
					$(this).prop("checked",true);
				} else {
					// Если значение уже было установлено, то с других опций снимаем выбор
					$(this).prop("checked",false);
				}
			} else {
				// Если вариант не содержит значение, снимаем выбор
				$(this).prop("checked",false);
				//$(this).attr("disabled",true);
			}
		}

	});
	$options_required[current_option_id] = required;
	return val;
} // setAccessSelectOption()

//------------------------------------------------------------------------------------------------------------------------------
// Функция устанавливает доступность опции типа select и ее значения
// current_product_option_value_id - текущее выбранное значение опции
// current_option_id - текущая опция в которой выбрано значение
// $option_values - объект в котором заданы все значения опций текущей характеристики
// Возвращает значение текущей опции
function setAccessSelectOption(current_option_id, current_product_option_value_id, $option_values) {
	var val = 0;
	var required = false;

	// Перебираем все значения опций
	$('select#input-option'+current_option_id+' option').each(function(index){

		// Если в классе не содержится значение выбранной опции,
		// и есть само значение и не первое, тогда отключаем эту опцию и снимаем флажок
		if (!$(this).hasClass(current_product_option_value_id) && (current_product_option_value_id) && index > 0) {
			$(this).attr("disabled",true);
			$(this).prop("selected",false);
		} else {

			required = true;

			// Значение содержится в классе, значит разблокируем если был заблокирован
			$(this).attr("disabled",false);

			// Если не было ранее выбрано значение, и не первое,
			// и в варианте для этой опции есть текущее значение
			if (!val && index > 0 && $option_values[current_option_id] == $(this).val()) {

				// Записываем выбранное значение
				val = $(this).val();

				// Выбираем его в селекте
				$(this).prop("selected",true);
			}
		}
	});
	$options_required[current_option_id] = required;
	return val;
} // setAccessSelectOption()

//------------------------------------------------------------------------------------------------------------------------------
// Функция устанавливает доступность опций и их значений
// current_product_option_value_id - текущее выбранное значение опции
// current_option_id - текущая опция в которой выбрано значение
// $option_values - объект в котором заданы все значения опций текущей характеристики
// Возвращает объект $option_values, теоретически он не меняется, оставлено временно для тестирования
function setAccessOptions(current_product_option_value_id, current_option_id, $option_values) {

	// Выберем опции по варианту
	$.each(options_order,function(index, product_option_id) {

		if (current_option_id == product_option_id) {
			$option_values[product_option_id] = current_product_option_value_id;
		} else {
			if ($options_type[product_option_id] == 'select') {

				// Установим доступность значений в опции типа select
				//$option_values[product_option_id] = setAccessSelectOption(product_option_id, current_product_option_value_id, $option_values);
				setAccessSelectOption(product_option_id, current_product_option_value_id, $option_values);
			} else {

				// Установим доступность значений в опции типа input
				//$option_values[product_option_id] = setAccessInputOption(product_option_id, current_product_option_value_id, $option_values);
				setAccessInputOption(product_option_id, current_product_option_value_id, $option_values);
			}
		}
	});

	return $option_values;
} // setAccessOptions()

//------------------------------------------------------------------------------------------------------------------------------
// Функция получает первый вариант опция по выбранному значению одной из опций
// product_option_value_id - значение выбранной опции
// Возвращает объект (index = product_option_id, value = product_option_value_id)
function getRightOption(product_option_value_id) {

	// Тут хранится вариант опций выбранной характеристики
	var $option_values = {};

	// Перебирем все опции
	$.each($options, function(sel_product_feature_id, $product_options) {

		// Прервем цикл, если ид характеристики уже определена
		if (product_feature_id) {
   			return false;
   		}

		// Перебираем все опции характеристики
		$.each($product_options, function(option_id, sel_product_option_value_id) {

			// Если значение неопределено, берем первую попавшуюся характеристику
			if (product_option_value_id == undefined) {

				// Запишем id характеристики, чтобы потом передать ее в корзину
				product_feature_id = sel_product_feature_id;

				// Получим вариант опций и значений этой характеристики
				$option_values = $product_options;

				// Прервем цикл
				return false;
			}

			// Если совпало значение опции в первой попавшейся характеристики, тогда выбираем ее, и получаем остальные значения опций
    		else if (sel_product_option_value_id == product_option_value_id) {

				// Запишем id характеристики, чтобы потом передать ее в корзину
				product_feature_id = sel_product_feature_id;

				// Получим вариант опций и значений этой характеристики
				$option_values = $product_options;

				// Прервем цикл
				return false;
    		}
   		});

	});

	return $option_values;
} // getRightOption()

//------------------------------------------------------------------------------------------------------------------------------
// Функция вызывается при изменении любой опции
// current_option_id - это номер опции в которой выбрано значение
// selected - выбранное значение опции, product_option_value_id
// type - тип опции, может иметь значение: select, input, radio, image
function selectOption(current_option_id, selected, type) {

	// Объект опций с выбранными значениями (index = опция, value = значение)
	var $option_values = {};

	// Получим существующие значения опций
	$option_values = getOptionValues();

	// Проверим вариант и получим id характеристики, если вариант неверный, тогда id = 0
	product_feature_id = getProductFeature($option_values);

	// Если опции не соответствуют ни одной характеристики, выставляем другие опции по первому совпадению в первой найденой характеристики
	if (!product_feature_id) {

		// Получим вариант опции по выбранному значению одной из опций
		// option_values это объект index = product_option_id, value = product_option_value_id
		$option_values = getRightOption(selected);

		// Устанавливает доступность значений всех опций
		setAccessOptions(selected, current_option_id, $option_values);

		// Установим единицу цены по умолчанию
		//unit_id = $price[product_feature_id]['unit'];
	}

	// Проверим опции на обязательные
	checkRequired();

	// Отображает выбранные данные
	displaySelect();
}

<?php } ?>

$(document).ready(function() {
<?php if ($options) {?>
	// Кнопки очистки опций, под каждый шаблон возможно придется править
	//$('select[name="option[9]"]').parent('div').before('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');
	$('div#input-option7').parent('div').after('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');
	//$('div#form-group').parent('div').after('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');

	$('#product').find('h3').after('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');

<?php foreach ($options as $option) { ?>
	//------------------------------------------------------------------------------------------------------------------------------
	// Функция обрабатывает значение при выборе опции
<?php
	$select_type = $option['type'] == "select" ? "select" : "input";
	$html = "	$('".$select_type."[name=\"option[".$option['product_option_id']."]\"]').change(function(){\n";
	$html .= "		var selected = ".($select_type  == "select" ? "$(':selected', this).val();" : "this.value;") . "\n";
	$html .= "		selectOption(".$option['product_option_id'].",selected,'".$select_type."');\n";
	$html .= "	});\n\n";
	echo $html;
	} ?>
	$('#product').on('click', '#clear_options', function(e){
		e.preventDefault();
		clearOptions();
	});

	selectOption();

<?php } ?>

	$('.thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});

var text_stock = "<?php echo $text_stock; ?>";
var text_tax = "<?php echo $text_tax; ?>";
<?php
if (isset($warehouses)) {
	echo "var \$warehouses = {";
	foreach ($warehouses as $warehouse_id => $name) {
		echo "'" . $warehouse_id . "':'" . $name . "',";
	}
	echo "}\n";
}
?>
<?php if ($options) {?>
//------------------------------------------------------------------------------------------------------------------------------
// Определение переменных для характеристик
var $options_type = {<?php foreach ($options as $option) { echo $option['product_option_id'].":'".$option['type']."',"; }?>};
var options_order = [<?php foreach ($options as $option) { echo $option['product_option_id'].","; }?>];
var $options_required = {<?php foreach ($options as $option) { echo $option['product_option_id'].":true,"; }?>};
var $options = {<?php
	foreach ($product_features_options as $product_feature_id => $feature) {
		$str_value = $product_feature_id.":{";
		foreach ($feature as $product_option_id => $product_option_value_id) {
			$str_value .= $product_option_id.":".$product_option_value_id.",";
		}
		$str_value .= "},";
		echo $str_value;
	}
	echo "};\n";?>
// Тут хранится id выбранной характеристики
var product_feature_id = 0;
var unit_id = 0;
<?php

	$str_features =  "var \$features = {";
	$str_price =  "var \$price = {";
	$str_quantity = "// quantity{product_feature_id:{warehouse_id:{unit_id:quantity}}}\n";
	$quantity_total =  0;
	$str_quantity .=  "var \$quantity = {";
	foreach ($product_features_options as $product_feature_id => $feature_option) {
		// Цены
		$str_price .= "'" . $product_feature_id . "':{'value':" . $product_features_price[$product_feature_id]['value'] . ",'tax':" . $product_features_price[$product_feature_id]['tax'] . ",'unit':" . $product_features_price[$product_feature_id]['unit'] . "},";
		// Характеристики
		$str_features .= "'" . implode("_", $feature_option) . "':" . $product_feature_id . ",";
		// Остатки
		$quantity_array = isset($product_quantity[$product_feature_id]) ? $product_quantity[$product_feature_id] : array();
		$str_quantity .= "'" . $product_feature_id . "':";

		$str_quantity .= "{";
		foreach ($quantity_array as $warehouse_id => $quantity) {
			$str_quantity .= "'" . $warehouse_id . "':" . $quantity . ",";
			$quantity_total += $quantity;
		}
		$str_quantity .= "},";

	}
	echo $str_features . "};\n";
	echo $str_price . "};\n";
	echo $str_quantity . "};\n";
	echo "var quantity_total = " . $quantity_total . ";\n";
	echo "var \$product_units = {";
	foreach ($product_units as $unit_id => $unit) {
		echo $unit_id . ":{'name':'" . $unit['name'] . "','ratio':".$unit['ratio']."},";
	}
	echo "};\n";
	echo "var \$currency_data = {'symbol':'".$currency_data['symbol']."','decimal':".$currency_data['decimal']."};\n";
?>


//------------------------------------------------------------------------------------------------------------------------------
// Функция отображает остатки по складам
// Возвращает строковую переменную в которой перечислены названия всех складов с остатками и единицами измерений
function displayQuantity() {

	if ($.type($quantity[product_feature_id]) == "string") {

		// Если переменная строка, то есть нет складов, возвращается только количество
		return $quantity[product_feature_id];

	} else {

		var str = "";
		var quantity_warehouse = 0;
		var str_war = "";
		unit_id = $price[product_feature_id]['unit'];
		var $unit = $product_units[unit_id];
		var total = 0;

		// Единица цены
		if ($unit) {
			str_unit = " ("+$unit['name']+")";
		} else {
			str_unit = "";
		}

		// Перебираем все остатки по складам
		$.each($quantity[product_feature_id],function(warehouse_id, product_quantity) {

			// Нет складов, если warehouse_id = 0
			if (warehouse_id == "0") {

				// Перебираем все единицы измерений
				$.each(product_quantity,function(unit_id, quantity) {
					//str += quantity+" ("+$unit['name']+"),";
					str += "\n" + quantity;
				});
			}
			// Остатки в выбранной единице
			else if (unit_id != 0) {

				// Название склада
				str_war = " Склад: "+$warehouses[warehouse_id]+": ";

			} else {
				if (product_quantity > 0) {
					quantity_warehouse++;
					str_war += " " + $warehouses[warehouse_id] + " = " + product_quantity + str_unit;
				}
			}
		});
		if (quantity_warehouse > 0) {
			str = " " + quantity_total + str_unit + " в " + quantity_warehouse + " магазинах: (" + str_war + ")";
		} else if (quantity_total > 0) {
			if ($unit['ratio'] != 0) {
				total = quantity_total / $unit['ratio'];
			}
			str = " " + total + " по опциям: " + $quantity[product_feature_id][0] + str_unit;
		} else {
			str = " нет в наличии";
		}
		return str;
	}
} // displayQuantity()

//------------------------------------------------------------------------------------------------------------------------------
// Функция отображает на странице цену, налоги, остатки,
// а также, для передачи в корзину, устанавливает значение product_feature_id
function displaySelect() {
	if (product_feature_id){
		$('#price').text(Math.round($price[product_feature_id]['value']).toFixed($currency_data['decimal'])+$currency_data['symbol']);
		$('#tax').text(text_tax+" "+Math.round($price[product_feature_id]['tax']).toFixed($currency_data['decimal'])+$currency_data['symbol']);
		$('#stock').text(text_stock+" "+displayQuantity());
		$('input[name=\'product_feature_id\']').val(product_feature_id);
		$('input[name=\'unit_id\']').val(unit_id);
	} else {
		$('#price').text("");
		$('#tax').text("");
		$('#stock').text(text_stock+" "+quantity_total+" ("+$product_units[0]['name']+")");
		$('input[name=\'product_feature_id\']').val(0);
		$('input[name=\'unit_id\']').val(0);
	}
} // displaySelect()

//------------------------------------------------------------------------------------------------------------------------------
// Функция очищает все опции и разблокирует их, сбрасывает ид характеристики, а также обновляет надписи на страничке
function clearOptions() {

	// Перебираем все опции
	$.each($options_type,function(product_option_id, value) {

		if (value == "select") {

			// Делаем доступным опцию
			$('select[name="option['+product_option_id+']"]').attr("disabled",false);

			// Сбрасываем выбор, по-умолчанию будет выбран первый элемент
			$('select[name="option['+product_option_id+']"]').val('');

			// Делаем доступным все значения опции
			$('select[name="option['+product_option_id+']"] option').each(function(){
				$(this).removeAttr("disabled");
			});
		} else {

			// Делаем доступным опцию
			$('input[name="option['+product_option_id+']"]').attr("disabled",false);

			// Снимаем выбор со всех значений
			$('input[name="option['+product_option_id+']"]').attr('checked', false);
		}
		$options_required[product_option_id] = true;
	});

	// Проверка на обязательные опции
	checkRequired();

	// Сбрасываем выбранную характеристику
	product_feature_id = 0;

	// Обновляем надписи на страничке
	displaySelect();

} // clearOptions()

//------------------------------------------------------------------------------------------------------------------------------
// Функция проверяет и устанавливает какие опции обязательные, бывает что некоторые характеристики имеют разное количество опций
function checkRequired() {

	// Перебираем все опции
	$.each($options_required,function(product_option_id, required) {

		if ($options_type[product_option_id] == "select") {

			// Получаем элемент в котором устанавливается класс обязательной опции
			$form = $('select[name="option['+product_option_id+']"]').parents("div.form-group");

			// Если опция должна быть обязательной, а она не содержит класс "required", устанавливает этот класс или наоборот убираем его
			if (required && !$form.hasClass("required")) {
				$form.addClass("required");
			} else if (!required && $form.hasClass("required")) {
				$form.removeClass("required");
			}

		} else {

			// Получаем элемент в котором устанавливается класс обязательной опции
			$form = $('input[name="option['+product_option_id+']"]').parents("div.form-group");

			// Если опция должна быть обязательной, а она не содержит класс "required", устанавливает этот класс или наоборот убираем его
			if (required && !$form.hasClass("required")) {
				$form.addClass("required");
			} else if (!required && $form.hasClass("required")) {
				$form.removeClass("required");
			}
		}
	});
} // checkRequired()

//------------------------------------------------------------------------------------------------------------------------------
// Функция возвращает выбранные опции значений в виде объекта
// Возвращает $option_values - объект с опция и значениями
function getOptionValues() {
	var $option_values = {};

	// Перебираем опции в том порядке в каком они заданы на сайте
	$.each(options_order,function(index, product_option_id) {

		if ($options_type[product_option_id] == 'select') {
			// Если опция типа select
			$option_values[product_option_id] = $('select[name="option['+product_option_id+']"] :selected').val();

		} else {
			// Если опция типа input
			$option_values[product_option_id] = $('input[name="option['+product_option_id+']"]:checked').val();
		}
	});
	return $option_values;
} // getOptionValues()

//------------------------------------------------------------------------------------------------------------------------------
// Функция по выбранным опциям возвращает product_feature_id
// $option_values - объект с опциями и значений
// Возвращает ид характеристики, если вариант выбранныхопций не существует ни в одной характеристики, то вернет 0
function getProductFeature($option_values) {
	var new_product_feature_id = 0;
	$.each($options,function(feature_id, $product_options) {

		// Количество совпадений
		var matches = 0;

		// Перебираем все опции характеристики
		$.each($product_options,function(product_option_id, product_option_value_id) {

			// Ищем совпадение значений
			if ($option_values[product_option_id] == product_option_value_id) {
				matches ++;
			}
		});

		// Если совпали все опции
		if (matches == options_order.length) {

			// Сохраним значение характеристики где совпали все опции
			new_product_feature_id = feature_id;

			// Прервем цикл
			return false;
		}
	});

	return new_product_feature_id;
} // getProductFeature()

//------------------------------------------------------------------------------------------------------------------------------
// Функция устанавливает доступность опции типа input и ее значения
// current_product_option_value_id - текущее выбранное значение опции
// current_option_id - текущая опция в которой выбрано значение
// $option_values - объект в котором заданы все значения опций текущей характеристики
// Возвращает значение текущей опции
function setAccessInputOption(current_option_id, current_product_option_value_id, $option_values) {
	var val = 0;
	var required = false;

	// Перебираем все значения опций
	$('div#input-option'+current_option_id+' div label input').each(function(index){

		// Если в классе не содержится значение выбранной опции, то отключаем эту опцию и снимаем флажок
		if (!$(this).hasClass(current_product_option_value_id) && (current_product_option_value_id)) {
			$(this).attr("disabled",true);
			$(this).prop("checked",false);

		} else {

			required = true;

			// Включаем,если была отключена ранее
			$(this).attr("disabled",false);

			// Если есть в варианте текущее значение опции
			if ($option_values[current_option_id] == $(this).val()) {

				// И еще не выбрано значение
				if (!val) {
					val = $(this).val();
					$(this).prop("checked",true);
				} else {
					// Если значение уже было установлено, то с других опций снимаем выбор
					$(this).prop("checked",false);
				}
			} else {
				// Если вариант не содержит значение, снимаем выбор
				$(this).prop("checked",false);
				//$(this).attr("disabled",true);
			}
		}

	});
	$options_required[current_option_id] = required;
	return val;
} // setAccessSelectOption()

//------------------------------------------------------------------------------------------------------------------------------
// Функция устанавливает доступность опции типа select и ее значения
// current_product_option_value_id - текущее выбранное значение опции
// current_option_id - текущая опция в которой выбрано значение
// $option_values - объект в котором заданы все значения опций текущей характеристики
// Возвращает значение текущей опции
function setAccessSelectOption(current_option_id, current_product_option_value_id, $option_values) {
	var val = 0;
	var required = false;

	// Перебираем все значения опций
	$('select#input-option'+current_option_id+' option').each(function(index){

		// Если в классе не содержится значение выбранной опции,
		// и есть само значение и не первое, тогда отключаем эту опцию и снимаем флажок
		if (!$(this).hasClass(current_product_option_value_id) && (current_product_option_value_id) && index > 0) {
			$(this).attr("disabled",true);
			$(this).prop("selected",false);
		} else {

			required = true;

			// Значение содержится в классе, значит разблокируем если был заблокирован
			$(this).attr("disabled",false);

			// Если не было ранее выбрано значение, и не первое,
			// и в варианте для этой опции есть текущее значение
			if (!val && index > 0 && $option_values[current_option_id] == $(this).val()) {

				// Записываем выбранное значение
				val = $(this).val();

				// Выбираем его в селекте
				$(this).prop("selected",true);
			}
		}
	});
	$options_required[current_option_id] = required;
	return val;
} // setAccessSelectOption()

//------------------------------------------------------------------------------------------------------------------------------
// Функция устанавливает доступность опций и их значений
// current_product_option_value_id - текущее выбранное значение опции
// current_option_id - текущая опция в которой выбрано значение
// $option_values - объект в котором заданы все значения опций текущей характеристики
// Возвращает объект $option_values, теоретически он не меняется, оставлено временно для тестирования
function setAccessOptions(current_product_option_value_id, current_option_id, $option_values) {

	// Выберем опции по варианту
	$.each(options_order,function(index, product_option_id) {

		if (current_option_id == product_option_id) {
			$option_values[product_option_id] = current_product_option_value_id;
		} else {
			if ($options_type[product_option_id] == 'select') {

				// Установим доступность значений в опции типа select
				//$option_values[product_option_id] = setAccessSelectOption(product_option_id, current_product_option_value_id, $option_values);
				setAccessSelectOption(product_option_id, current_product_option_value_id, $option_values);
			} else {

				// Установим доступность значений в опции типа input
				//$option_values[product_option_id] = setAccessInputOption(product_option_id, current_product_option_value_id, $option_values);
				setAccessInputOption(product_option_id, current_product_option_value_id, $option_values);
			}
		}
	});

	return $option_values;
} // setAccessOptions()

//------------------------------------------------------------------------------------------------------------------------------
// Функция получает первый вариант опция по выбранному значению одной из опций
// product_option_value_id - значение выбранной опции
// Возвращает объект (index = product_option_id, value = product_option_value_id)
function getRightOption(product_option_value_id) {

	// Тут хранится вариант опций выбранной характеристики
	var $option_values = {};

	// Перебирем все опции
	$.each($options, function(sel_product_feature_id, $product_options) {

		// Прервем цикл, если ид характеристики уже определена
		if (product_feature_id) {
   			return false;
   		}

		// Перебираем все опции характеристики
		$.each($product_options, function(option_id, sel_product_option_value_id) {

			// Если значение неопределено, берем первую попавшуюся характеристику
			if (product_option_value_id == undefined) {

				// Запишем id характеристики, чтобы потом передать ее в корзину
				product_feature_id = sel_product_feature_id;

				// Получим вариант опций и значений этой характеристики
				$option_values = $product_options;

				// Прервем цикл
				return false;
			}

			// Если совпало значение опции в первой попавшейся характеристики, тогда выбираем ее, и получаем остальные значения опций
    		else if (sel_product_option_value_id == product_option_value_id) {

				// Запишем id характеристики, чтобы потом передать ее в корзину
				product_feature_id = sel_product_feature_id;

				// Получим вариант опций и значений этой характеристики
				$option_values = $product_options;

				// Прервем цикл
				return false;
    		}
   		});

	});

	return $option_values;
} // getRightOption()

//------------------------------------------------------------------------------------------------------------------------------
// Функция вызывается при изменении любой опции
// current_option_id - это номер опции в которой выбрано значение
// selected - выбранное значение опции, product_option_value_id
// type - тип опции, может иметь значение: select, input, radio, image
function selectOption(current_option_id, selected, type) {

	// Объект опций с выбранными значениями (index = опция, value = значение)
	var $option_values = {};

	// Получим существующие значения опций
	$option_values = getOptionValues();

	// Проверим вариант и получим id характеристики, если вариант неверный, тогда id = 0
	product_feature_id = getProductFeature($option_values);

	// Если опции не соответствуют ни одной характеристики, выставляем другие опции по первому совпадению в первой найденой характеристики
	if (!product_feature_id) {

		// Получим вариант опции по выбранному значению одной из опций
		// option_values это объект index = product_option_id, value = product_option_value_id
		$option_values = getRightOption(selected);

		// Устанавливает доступность значений всех опций
		setAccessOptions(selected, current_option_id, $option_values);

		// Установим единицу цены по умолчанию
		//unit_id = $price[product_feature_id]['unit'];
	}

	// Проверим опции на обязательные
	checkRequired();

	// Отображает выбранные данные
	displaySelect();
}

<?php } ?>

$(document).ready(function() {
<?php if ($options) {?>
	// Кнопки очистки опций, под каждый шаблон возможно придется править
	//$('select[name="option[9]"]').parent('div').before('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');
	$('div#input-option7').parent('div').after('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');
	//$('div#form-group').parent('div').after('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');

	$('#product').find('h3').after('<div class="form-group"><a href="#" id="clear_options">Очистить опции</a></div>');

<?php foreach ($options as $option) { ?>
	//------------------------------------------------------------------------------------------------------------------------------
	// Функция обрабатывает значение при выборе опции
<?php
	$select_type = $option['type'] == "select" ? "select" : "input";
	$html = "	$('".$select_type."[name=\"option[".$option['product_option_id']."]\"]').change(function(){\n";
	$html .= "		var selected = ".($select_type  == "select" ? "$(':selected', this).val();" : "this.value;") . "\n";
	$html .= "		selectOption(".$option['product_option_id'].",selected,'".$select_type."');\n";
	$html .= "	});\n\n";
	echo $html;
	} ?>
	$('#product').on('click', '#clear_options', function(e){
		e.preventDefault();
		clearOptions();
	});

	selectOption();

<?php } ?>

	var hash = window.location.hash;
	if (hash) {
		var hashpart = hash.split('#');
		var  vals = hashpart[1].split('-');
		for (i=0; i<vals.length; i++) {
			$('div.options').find('select option[value="'+vals[i]+'"]').attr('selected', true).trigger('select');
			$('div.options').find('input[type="radio"][value="'+vals[i]+'"]').attr('checked', true).trigger('click');
		}
	}
})
//--></script>

                  <script type="application/ld+json">
               {
                 "@context": "http://schema.org/",
                 "@type": "Product",
                 "name": "<?php echo $rich_snippets['name']; ?>",
                 "image": "<?php echo $rich_snippets['image']; ?>",
				 "description": "<?php echo $rich_snippets['description']; ?>",
                 "model": "<?php echo $rich_snippets['model']; ?>",
                 <?php if (!empty($rich_snippets['brand'])) { ?>
                 "brand":{
                   "@type": "Brand",
                   "name": "<?php echo $rich_snippets['brand']; ?>"
                 },
                 <?php } ?>
                 <?php if ($rich_snippets['reviewCount'] != 0) { ?>
                 "aggregateRating":{
                   "@type": "AggregateRating",
                   "ratingValue": "<?php echo $rich_snippets['ratingValue']; ?>",
                   "reviewCount": "<?php echo $rich_snippets['reviewCount']; ?>"
                 },
                 <?php } ?>
				 <?php if ($rich_snippets['reviewCount'] > 0) {
					foreach ($reviews_first['reviews'] as $review ) { ?> 
				  "review": {
					"@type": "Review",
					"reviewRating": {
					  "@type": "Rating",
					  "ratingValue": "<?php echo $review['rating']; ?>"
					},
					"author": {
					  "@type": "Person",
					  "name": "<?php echo $review['author']; ?>"
					},
					"datePublished": "<?php echo $review['date_added_fixed']; ?>",
					"reviewBody": "<?php echo $review['text']; ?>",
					"publisher": {
					  "@type": "Organization",
					  "name": "<?php echo $rich_snippets['seller_name']; ?>"
					}
				  },
				  <?php } } ?>
                 "offers":{
                   "@type": "Offer",
                   "priceCurrency": "<?php echo $rich_snippets['priceCurrency']; ?>",
                   "price": "<?php echo $rich_snippets['price']; ?>",
				   "itemCondition": "http://schema.org/NewCondition",
                   "availability": "<?php echo $rich_snippets['availability']; ?>",
                   "seller":{
                    "@type": "Organization",
                    "name": "<?php echo $rich_snippets['seller_name']; ?>"
                   }
                  }
                }
                </script>
                

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

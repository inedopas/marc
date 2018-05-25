<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">	
		
		<a onclick="$('#form').submit();" class="btn btn-success" role="button"><?php echo $button_save; ?></a>
		<a href="<?php echo $cancel; ?>" class="btn btn-info" role="button"><?php echo $button_cancel; ?></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">

  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="panel panel-default">

    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form"  class="form-inline">
		<div class="row">
            <div class="form-group col-xs-12">
				<label><span class="required">*</span> <?php echo $entry_group; ?></label>
					<input type="text" name="name" class="form-control" value="<?php echo $color_kit['name'] ?>">			
			</div>
		</div><p></p><div class="row">
            <div class="form-group col-xs-12">
				<label><?php echo $column_status; ?></label>
				<select  name="status" class="form-control">
				<?php if($color_kit['status'] == 1){ ?>
					<option value="1" selected><?php echo $status_on ?></option>
					<option value="0"><?php echo $status_off ?></option>
				<?php } else { ?>
					<option value="1"><?php echo $status_on ?></option>
					<option value="0" selected><?php echo $status_off ?></option>
				<?php }?>  
				</select>

			</div>
	</div><p></p><div class="row">
            <div class="form-group col-xs-12">
				<label><?php echo $template ?></label>
				<select  name="tpl" class="form-control">
				<?php $tpl = (isset($color_kit['tpl'])) ? $color_kit['tpl'] : ''; ?>
					<option value="color" <?php if($tpl == 'color'){ ?>selected<?php } ?>><?php echo $template_colors ?></option>
					<option value="photos" <?php if($tpl == 'photos'){ ?>selected<?php } ?>><?php echo $save_photos ?></option>
					<option value="img" <?php if($tpl == 'img'){ ?>selected<?php } ?>><?php echo $template_photos ?></option>
				</select>

			</div>
    </div>
	<p></p>
	<div class="row">
		<div class="col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title">
				<?php echo $entry_name_product ?>
				</h3>	
				<div class="form-group">
					<input type="text" class="search" name="product" class="form-control">
				</div><div class="form-group">
				 Model
					<input type="text" class="search" name="model" class="form-control">
				</div><div class="form-group">
				 Sku
					<input type="text" class="search" name="sku" class="form-control">
				</div>
				
			  </div>
			  <div class="panel-body">
				
				<table id="product-list" class="table table-bordered table-responsive">
					<thead>
						<tr>
							<th><?php echo $name_product ?></th>
							<th><?php echo $name_color ?></th>
							<th><?php echo $column_photo ?></th>
							<th></th>
						</tr>
					</thead>
					<?php $product_row = 0; ?>
					<?php foreach ($color_kits as $color_kit) { ?>
					<tbody id="product-row<?php echo $product_row; ?>">					
						<tr>
							<td><strong><input type="hidden" name="color_kit[<?php echo $product_row; ?>][product_id]" value="<?php echo $color_kit['product_id'] ?>" /><?php echo $color_kit['product_name'] ?></strong></td>
							<td>
							<select name="color_kit[<?php echo $product_row; ?>][option_id]" class="form-control">
							<?php foreach ($get_colors as $color) { ?>
								<?php if($color['option_id'] == $color_kit['option_id']) { ?>
									<option value="<?php echo $color['option_id'] ?>" selected><?php echo $color['name'] ?></option>
								<?php } else { ?>
									<option value="<?php echo $color['option_id'] ?>"><?php echo $color['name'] ?></option>
								<?php } ?>
							<?php } ?>	
							</select>
							</td>
							<td><a href="" id="thumb-image<?php echo $product_row; ?>" data-toggle="image" class="img-thumbnail"><img src="/image/<?php echo $color_kit['image']; ?>" alt="" width="50px" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="color_kit[<?php echo $product_row; ?>][image]" value="<?php echo $color_kit['image']; ?>" id="input-image<?php echo $product_row; ?>" /></td>
							<td><a onclick="$('#product-row<?php echo $product_row; ?>').remove();" class="btn btn-danger">Очистить</a></td>
						</tr>
					</tbody>
					<?php $product_row++; ?>
					<?php } ?>
					
					<tfoot>
					</tfoot>
				</table>	
				
			  </div> 
			</div>
		</div>
	</div>
        
      </form>
    </div>
  </div>
</div>


<script type="text/javascript"><!--
var product_row = <?php echo $product_row; ?>;

$('input[name=\'product\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/color_kits/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	}, 
	'select': function(item) {
	
		html  = '<tbody id="product-row' + product_row + '">';
			html += '<tr>';	
			html += '<td><input type="hidden" name="color_kit[' + product_row + '][product_id]" value="' + item['value'] + '" /><strong>' + item['label'] + '</strong></td>';
			html += '<td><select name="color_kit[' + product_row + '][option_id]" class="form-control">';
				<?php foreach ($get_colors as $color) { ?>
					html += '<option value="<?php echo $color['option_id'] ?>"><?php echo $color['name'] ?></option>';
				<?php } ?>	
			html +='</select></td>';
			html += '<td class="text-left"><a href="" id="thumb-image' + product_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="color_kit[' + product_row + '][image]" value="" id="input-image' + product_row + '" /></td>';
			html += '<td><a onclick="$(\'#product-row' + product_row + '\').remove();" class="btn btn-danger"><?php echo $button_remove; ?></a></td>';		
			html += '</tr>';	
			html += '</tbody>';	
			$('#product-list tfoot').before(html);
			product_row++;
		
	}
});	
-->
</script>
<script type="text/javascript"><!--
var product_row = <?php echo $product_row; ?>;
$('input[name=\'model\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/color_kits/autocomplete&token=<?php echo $token; ?>&filter_model=' + encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	}, 
	'select': function(item) {

			html  = '<tbody id="product-row' + product_row + '">';
			html += '<tr>';	
			html += '<td><input type="hidden" name="color_kit[' + product_row + '][product_id]" value="' + item['value'] + '" /><strong>' + item['label'] + '</strong></td>';
			html += '<td><select name="color_kit[' + product_row + '][option_id]" class="form-control">';
				<?php foreach ($get_colors as $color) { ?>
					html += '<option value="<?php echo $color['option_id'] ?>"><?php echo $color['name'] ?></option>';
				<?php } ?>	
			html +='</select></td>';	
			html += '<td class="text-left"><a href="" id="thumb-image' + product_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="color_kit[' + product_row + '][image]" value="" id="input-image' + product_row + '" /></td>';
			html += '<td><a onclick="$(\'#product-row' + product_row + '\').remove();" class="btn btn-danger"><?php echo $button_remove; ?></a></td>';		
			html += '</tr>';	
			html += '</tbody>';	
			$('#product-list tfoot').before(html);
			product_row++; 
		
	}
});	
-->
</script>
<script type="text/javascript"><!--
var product_row = <?php echo $product_row; ?>;

$('input[name=\'sku\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/color_kits/autocomplete&token=<?php echo $token; ?>&filter_sku=' + encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	}, 
	'select': function(item) {
			html  = '<tbody id="product-row' + product_row + '">';
			html += '<tr>';	
			html += '<td><input type="hidden" name="color_kit[' + product_row + '][product_id]" value="' + item['value'] + '" /><strong>' + item['label'] + '</strong></td>';
			html += '<td><select name="color_kit[' + product_row + '][option_id]" class="form-control">';
				<?php foreach ($get_colors as $color) { ?>
					html += '<option value="<?php echo $color['option_id'] ?>"><?php echo $color['name'] ?></option>';
				<?php } ?>	
			html +='</select></td>';	
			html += '<td class="text-left"><a href="" id="thumb-image' + product_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="color_kit[' + product_row + '][image]" value="" id="input-image' + product_row + '" /></td>';
			html += '<td><a onclick="$(\'#product-row' + product_row + '\').remove();" class="btn btn-danger"><?php echo $button_remove; ?></a></td>';		
			html += '</tr>';	
			html += '</tbody>';	
			$('#product-list tfoot').before(html);
			product_row++;
	
	}
});	
//--></script> 
<?php echo $footer; ?>
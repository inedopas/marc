<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-ups" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-ups" class="form-horizontal">
			<div class="row">
				<div class="col-sm-2">
				  <ul class="nav nav-pills nav-stacked">
					<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
					<li><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li>
					<li><a href="#tab-shipping" data-toggle="tab"><?php echo $tab_shipping; ?></a></li>
				  </ul>
				</div>
				<div class="col-sm-10">
				  <div class="tab-content">
					<div class="tab-pane active" id="tab-general">
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_type_query"><?php echo $entry_type_query; ?></label>
						<div class="col-sm-10">
						  <select id="russian_post_type_query" class="form-control" name="russian_post_type_query">
							<?php if ($russian_post_type_query) { ?>
							<option value="1" selected="selected"><?php echo $text_api; ?></option>
							<option value="0"><?php echo $text_light; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_api; ?></option>
							<option value="0" selected="selected"><?php echo $text_light; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_hide"><?php echo $entry_hide; ?></label>
						<div class="col-sm-10">
						  <select id="russian_post_hide" class="form-control" name="russian_post_hide">
							<?php if ($russian_post_hide) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_sort_order"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
						  <input type="text" name="russian_post_sort_order" value="<?php echo $russian_post_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="russian_post_sort_order" class="form-control" />
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="input-show-image"><?php echo $entry_show_images; ?></label>
						<div class="col-sm-10">
						  <select id="input-show-image" class="form-control" name="russian_post_show_images">
							<?php if ($russian_post_show_images) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="input-image-width"><span data-toggle="tooltip" title="<?php echo $help_image_size; ?>"><?php echo $entry_image_size; ?></span></label>
					    <div class="col-sm-10">
						  <div class="row">
						    <div class="col-sm-6">
							  <input type="text" name="russian_post_image_width" value="<?php echo $russian_post_image_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-width" class="form-control" />
						    </div>
						    <div class="col-sm-6">
							  <input type="text" name="russian_post_image_height" value="<?php echo $russian_post_image_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
						    </div>
						  </div>
					    </div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_debug"><?php echo $entry_debug; ?></label>
						<div class="col-sm-10">
						  <select id="russian_post_debug" class="form-control" name="russian_post_debug">
							<?php if ($russian_post_debug) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					</div>
					<div class="tab-pane" id="tab-product">
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="input-weight-class"><span data-toggle="tooltip" title="<?php echo $help_weight_class; ?>"><?php echo $entry_weight_class; ?></span></label>
						<div class="col-sm-10">
						  <select name="russian_post_weight_class_id" id="input-weight-class" class="form-control">
							<?php foreach ($weight_classes as $weight_class) { ?>
							<?php if ($weight_class['weight_class_id'] == $russian_post_weight_class_id) { ?>
							<option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
							<?php } else { ?>
							<option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
							<?php } ?>
							<?php } ?>
						  </select>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_weight"><?php echo $entry_weight; ?></label>
						<div class="col-sm-10">
						  <input type="text" name="russian_post_weight" value="<?php echo $russian_post_weight; ?>" placeholder="<?php echo $entry_weight; ?>" id="russian_post_weight" class="form-control" />
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_sort_order"><?php echo $entry_weight_pack; ?></label>
						<div class="col-sm-10">
						  <input type="text" name="russian_post_weight_pack" value="<?php echo $russian_post_weight_pack; ?>" placeholder="<?php echo $entry_weight_pack; ?>" id="russian_post_weight_pack" class="form-control" />
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_declare"><?php echo $entry_declare; ?></label>
						<div class="col-sm-10">
						  <select id="russian_post_declare" class="form-control" name="russian_post_declare">
							<?php if ($russian_post_declare) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					</div>
					<div class="tab-pane" id="tab-shipping">
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_postcode_default"><span data-toggle="tooltip" title="<?php echo $help_postcode_default; ?>"><?php echo $entry_postcode_default; ?></span></label>
						
						<div class="col-sm-10">
						  <input type="text" name="russian_post_postcode_default" value="<?php echo $russian_post_postcode_default; ?>" placeholder="<?php echo $entry_postcode_default; ?>" id="russian_post_postcode_default" class="form-control" />
						</div>
					  </div>
					  <div class="form-group required">
						<label class="col-sm-2 control-label" for="russian_post_city"><?php echo $entry_city; ?></label>
						<div class="col-sm-10">
						  <input type="text" name="russian_post_city" value="<?php echo $russian_post_city; ?>" placeholder="<?php echo $entry_city; ?>" id="russian_post_city" class="form-control" />
						  <?php if ($error_city) { ?>
						  <div class="text-danger"><?php echo $error_city; ?></div>
						  <?php } ?>
						</div>
					  </div>
					  <div class="form-group required">
						<label class="col-sm-2 control-label" for="russian_post_postcode"><?php echo $entry_postcode; ?></label>
						<div class="col-sm-10">
						  <input type="text" name="russian_post_postcode" value="<?php echo $russian_post_postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="russian_post_postcode" class="form-control" />
						  <?php if ($error_postcode) { ?>
						  <div class="text-danger"><?php echo $error_postcode; ?></div>
						  <?php } ?>
						</div>
					  </div>
					  <div class="form-group">
						<label class="col-sm-2 control-label" for="russian_post_date"><?php echo $entry_time; ?></label>
						<div class="col-sm-10">
						  <select id="russian_post_date" class="form-control" name="russian_post_date">
							<?php if ($russian_post_date) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						  </select>
						</div>
					  </div>
					</div>
				  </div>
				</div>
			</div>			
			<div class="table-responsive">
			  <table id="module" class="table table-bordered table-hover">
				<thead>
				  <tr>
					<td class="text-left"><?php echo $entry_image; ?></td>
					<td class="text-left"><?php echo $entry_type; ?></td>
					<td class="text-left"><span data-toggle="tooltip" title="<?php echo $help_free; ?>"><?php echo $entry_free; ?></span></td>
					<td class="text-left"><span data-toggle="tooltip" title="<?php echo $help_limit; ?>"><?php echo $entry_limit; ?></span></td>
					<td class="text-left"><?php echo $entry_cost; ?></td>
					<td class="text-left"><?php echo $entry_date; ?></td>
					<td class="text-left"><?php echo $entry_tax_class; ?></td>
					<td class="text-left"><?php echo $entry_geo_zone; ?></td>
					<td class="text-right"><?php echo $entry_status; ?></td>
					<td class="text-right"><?php echo $entry_sort_order; ?></td>
					<td></td>
				  </tr>
				</thead>
				<?php $module_row = 0; ?>
				<?php foreach ($russian_post as $module) { ?>
				<tbody id="module-row<?php echo $module_row; ?>">
				  <tr>
					<td class="text-left"><a href="" id="thumb-image<?php echo $module_row; ?>" data-toggle="image"><img style="width: <?php echo $russian_post_image_width; ?>px; height: <?php echo $russian_post_image_height; ?>px;" src="<?php echo $images[$module_row]['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="russian_post_images[<?php echo $module_row; ?>]" value="<?php echo $images[$module_row]['image']; ?>" id="input-image<?php echo $module_row; ?>" /></td>
					<td class="text-left">
					  <select name="russian_post[<?php echo $module_row; ?>][type]" class="form-control">
						<option value="0" <?php if($module['type'] == 0){ ?>selected="selected"<?php } ?>><?php echo $text_0; ?></option>
						<option value="1" <?php if($module['type'] == 1){ ?>selected="selected"<?php } ?>><?php echo $text_1; ?></option>
						<option value="2" <?php if($module['type'] == 2){ ?>selected="selected"<?php } ?>><?php echo $text_2; ?></option>
						<option value="3" <?php if($module['type'] == 3){ ?>selected="selected"<?php } ?>><?php echo $text_3; ?></option>
						<option value="4" <?php if($module['type'] == 4){ ?>selected="selected"<?php } ?>><?php echo $text_4; ?></option>
						<option value="5" <?php if($module['type'] == 5){ ?>selected="selected"<?php } ?>><?php echo $text_5; ?></option>
						<option value="6" <?php if($module['type'] == 6){ ?>selected="selected"<?php } ?>><?php echo $text_6; ?></option>
						<option value="7" <?php if($module['type'] == 7){ ?>selected="selected"<?php } ?>><?php echo $text_7; ?></option>
						<option value="8" <?php if($module['type'] == 8){ ?>selected="selected"<?php } ?>><?php echo $text_8; ?></option>
						<option value="9" <?php if($module['type'] == 9){ ?>selected="selected"<?php } ?>><?php echo $text_9; ?></option>
						<option value="10" <?php if($module['type'] == 10){ ?>selected="selected"<?php } ?>><?php echo $text_10; ?></option>
						<option value="11" <?php if($module['type'] == 11){ ?>selected="selected"<?php } ?>><?php echo $text_11; ?></option>
						<option value="12" <?php if($module['type'] == 12){ ?>selected="selected"<?php } ?>><?php echo $text_12; ?></option>
						<option value="13" <?php if($module['type'] == 13){ ?>selected="selected"<?php } ?>><?php echo $text_13; ?></option>
						<option value="14" <?php if($module['type'] == 14){ ?>selected="selected"<?php } ?>><?php echo $text_14; ?></option>
						<option value="15" <?php if($module['type'] == 15){ ?>selected="selected"<?php } ?>><?php echo $text_15; ?></option>
						<option value="16" <?php if($module['type'] == 16){ ?>selected="selected"<?php } ?>><?php echo $text_16; ?></option>
						<option value="17" <?php if($module['type'] == 17){ ?>selected="selected"<?php } ?>><?php echo $text_17; ?></option>
						<option value="18" <?php if($module['type'] == 18){ ?>selected="selected"<?php } ?>><?php echo $text_18; ?></option>
						<option value="19" <?php if($module['type'] == 19){ ?>selected="selected"<?php } ?>><?php echo $text_19; ?></option>
						<option value="20" <?php if($module['type'] == 20){ ?>selected="selected"<?php } ?>><?php echo $text_20; ?></option>
						<option value="21" <?php if($module['type'] == 21){ ?>selected="selected"<?php } ?>><?php echo $text_21; ?></option>
						<option value="22" <?php if($module['type'] == 22){ ?>selected="selected"<?php } ?>><?php echo $text_22; ?></option>
						<option value="23" <?php if($module['type'] == 23){ ?>selected="selected"<?php } ?>><?php echo $text_23; ?></option>
						<option value="24" <?php if($module['type'] == 24){ ?>selected="selected"<?php } ?>><?php echo $text_24; ?></option>
						<option value="25" <?php if($module['type'] == 25){ ?>selected="selected"<?php } ?>><?php echo $text_25; ?></option>
						<option value="26" <?php if($module['type'] == 26){ ?>selected="selected"<?php } ?>><?php echo $text_26; ?></option>
						<option value="27" <?php if($module['type'] == 27){ ?>selected="selected"<?php } ?>><?php echo $text_27; ?></option>
						<option value="28" <?php if($module['type'] == 28){ ?>selected="selected"<?php } ?>><?php echo $text_28; ?></option>
						<option value="29" <?php if($module['type'] == 29){ ?>selected="selected"<?php } ?>><?php echo $text_29; ?></option>
						<option value="30" <?php if($module['type'] == 30){ ?>selected="selected"<?php } ?>><?php echo $text_30; ?></option>
						<option value="31" <?php if($module['type'] == 31){ ?>selected="selected"<?php } ?>><?php echo $text_31; ?></option>
						<option value="32" <?php if($module['type'] == 32){ ?>selected="selected"<?php } ?>><?php echo $text_32; ?></option>
					  </select>
					</td>
					<td class="text-right"><input type="text" name="russian_post[<?php echo $module_row; ?>][free]" value="<?php echo $module['free']; ?>" class="form-control" /></td>
					<td class="text-right"><input type="text" name="russian_post[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" class="form-control" /></td>
					<td class="text-left"><input type="text" name="russian_post[<?php echo $module_row; ?>][cost]" value="<?php echo $module['cost']; ?>" class="form-control" /></td>
					<td class="text-left"><input type="text" name="russian_post[<?php echo $module_row; ?>][date]" value="<?php echo $module['date']; ?>" class="form-control" /></td>
					<td class="text-left"><select name="russian_post[<?php echo $module_row; ?>][tax_class_id]" class="form-control">
					  <option value="0"><?php echo $text_none; ?></option>
					  <?php foreach ($tax_classes as $tax_class) { ?>
					  <?php if ($tax_class['tax_class_id'] == $module['tax_class_id']) { ?>
					  <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
					  <?php } else { ?>
					  <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
					  <?php } ?>
					  <?php } ?>
					</select></td>
					<td class="text-left"><select name="russian_post[<?php echo $module_row; ?>][geo_zone_id]" class="form-control">
					<option value="0"><?php echo $text_all_zones; ?></option>
					<?php foreach ($geo_zones as $geo_zone) { ?>
					<?php if ($geo_zone['geo_zone_id'] == $module['geo_zone_id']) { ?>
					<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
					<?php } ?>
					<?php } ?>
				  </select></td>
					<td class="text-right"><select name="russian_post[<?php echo $module_row; ?>][status]" class="form-control">
					<?php if ($module['status']) { ?>
					<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					<option value="0"><?php echo $text_disabled; ?></option>
					<?php } else { ?>
					<option value="1"><?php echo $text_enabled; ?></option>
					<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					<?php } ?>
				  </select></td>
					<td class="text-right"><input type="text" name="russian_post[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="form-control" /></td>
					<td class="text-left">
					<a data-toggle="tooltip" title="<?php echo $button_remove; ?>" onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-trash-o"></i></a>
					</td>
				  </tr>
				</tbody>
				<?php $module_row++; ?>
				<?php } ?>
				<tfoot>
				  <tr>
					<td colspan="10"></td>
					<td class="text-left">
					<a onclick="addModule();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
					</td>
				  </tr>
				</tfoot>
			  </table>
			</div>
		  <input type="hidden" name="russian_post_status" value="true" />
		</form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
function addModule() {
	html  = '<tbody id="module-row' + module_row + '">';
	html += '<tr>';
	html += '<td class="text-left"><a href="" id="thumb-image' + module_row + '" data-toggle="image"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="russian_post_images[' + module_row + ']" value="" id="input-image' + module_row + '" /></td>';
	html += '<td class="text-left"><select name="russian_post[' + module_row +'][type]" class="form-control">';
    html += '<option value="0"><?php echo $text_0;   ?></option>';
	html += '<option value="1"><?php echo $text_1;   ?></option>';
	html += '<option value="2"><?php echo $text_2;   ?></option>';
	html += '<option value="3"><?php echo $text_3;   ?></option>';
	html += '<option value="4"><?php echo $text_4;   ?></option>';
	html += '<option value="5"><?php echo $text_5;   ?></option>';
	html += '<option value="6"><?php echo $text_6;   ?></option>';
	html += '<option value="7"><?php echo $text_7;   ?></option>';
	html += '<option value="8"><?php echo $text_8;   ?></option>';
	html += '<option value="9"><?php echo $text_9; 	 ?></option>';
	html += '<option value="10"><?php echo $text_10; ?></option>';
	html += '<option value="11"><?php echo $text_11; ?></option>';
	html += '<option value="12"><?php echo $text_12; ?></option>';
	html += '<option value="13"><?php echo $text_13; ?></option>';
	html += '<option value="14"><?php echo $text_14; ?></option>';
	html += '<option value="15"><?php echo $text_15; ?></option>';
	html += '<option value="16"><?php echo $text_16; ?></option>';
	html += '<option value="17"><?php echo $text_17; ?></option>';
	html += '<option value="18"><?php echo $text_18; ?></option>';
	html += '<option value="19"><?php echo $text_19; ?></option>';
	html += '<option value="20"><?php echo $text_20; ?></option>';
	html += '<option value="21"><?php echo $text_21; ?></option>';
	html += '<option value="22"><?php echo $text_22; ?></option>';
	html += '<option value="23"><?php echo $text_23; ?></option>';
	html += '<option value="24"><?php echo $text_24; ?></option>';
	html += '<option value="25"><?php echo $text_25; ?></option>';
	html += '<option value="26"><?php echo $text_26; ?></option>';
	html += '<option value="27"><?php echo $text_27; ?></option>';
	html += '<option value="28"><?php echo $text_28; ?></option>';
	html += '<option value="29"><?php echo $text_29; ?></option>';
	html += '<option value="30"><?php echo $text_30; ?></option>';
	html += '<option value="31"><?php echo $text_31; ?></option>';
	html += '<option value="32"><?php echo $text_32; ?></option>';
	html += '</select></td>';
	html += '<td class="text-left"><input type="text" name="russian_post[' + module_row + '][free]" class="form-control" /></td>';
	html += '<td class="text-left"><input type="text" name="russian_post[' + module_row + '][limit]" class="form-control" /></td>';
	html += '<td class="text-left"><input type="text" name="russian_post[' + module_row + '][cost]" class="form-control" /></td>';
	html += '<td class="text-left"><input type="text" name="russian_post[' + module_row + '][date]" class="form-control" /></td>';
	html += '<td class="text-left"><select name="russian_post[' + module_row + '][tax_class_id]" class="form-control">';
	html += '<option value="0"><?php echo $text_none; ?></option>';
	<?php foreach ($tax_classes as $tax_class) { ?>
	html += '<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>';
    <?php } ?>
	html += '</select></td>';
	html += '<td class="text-left"><select name="russian_post[' + module_row + '][geo_zone_id]" class="form-control">';
	html += '<option value="0"><?php echo $text_all_zones; ?></option>';
    <?php foreach ($geo_zones as $geo_zone) { ?>
	html += '<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>';
    <?php } ?>
	html += '</select></td>';
	html += '<td class="text-right"><select name="russian_post[' + module_row + '][status]" class="form-control">';
	html += '<option selected="selected" value="1"><?php echo $text_enabled; ?></option>';
	html += '<option value="0"><?php echo $text_disabled; ?></option>';
	html += '</select></td>';
	html += '<td class="text-right"><input type="text" name="russian_post[' + module_row + '][sort_order]" class="form-control" /></td>';
	html += '<td class="text-left"><a data-toggle="tooltip" title="<?php echo $button_remove; ?>" onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-danger"><i class="fa fa-trash-o"></i></a></td>';
	html += '</tr>';
	html += '</tbody>';

	$('#module tfoot').before(html);

	module_row++;
}
//--></script>
<?php echo $footer; ?>
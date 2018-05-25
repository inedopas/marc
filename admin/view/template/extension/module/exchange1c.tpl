<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-exchange1c" class="btn btn-primary" id="form-save" data-toggle="tooltip" title="<?php echo $lang['button_save']; ?>"><i class="fa fa-save"></i></button>
				<button type="submit" form="form-exchange1c" class="btn btn-primary" id="form-save-refresh" data-toggle="tooltip" title="<?php echo $lang['button_apply']; ?>" onclick="$('#form-exchange1c').attr('action','<?php echo $refresh; ?>&refresh=1').submit()"><i class="fa fa-save"></i> + <i class="fa fa-refresh"></i></button>
				<a href="<?php echo $cancel; ?>" class="btn btn-default" data-toggle="tooltip" title="<?php echo $lang['button_cancel']; ?>" ><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo 'Exchcange 1c'; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
					<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo  'Exchcange 1c'; ?></a></li>
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
		<?php if ($text_info) { ?>
			<div class="alert alert-info">
				<i class="fa fa-info-circle"></i>
				<?php echo $text_info; ?>
			</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $lang['text_edit']; ?></h3>
			</div>
			<div class="panel-body">
				<form action="index.php?route=extension/module/exchange1c/downloadOrders&token=<?php echo $token; ?>" method="post" enctype="multipart/form-data" id="form-download-orders" class="form-horizontal"></form>
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-exchange1c" class="form-horizontal">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $lang['text_tab_general']; ?></a></li>
					<li><a href="#tab-product" data-toggle="tab"><?php echo $lang['text_tab_product']; ?></a></li>
					<li><a href="#tab-category" data-toggle="tab"><?php echo $lang['text_tab_category']; ?></a></li>
					<li><a href="#tab-prices" data-toggle="tab"><?php echo $lang['text_tab_prices']; ?></a></li>
					<li><a href="#tab-stock" data-toggle="tab"><?php echo $lang['text_tab_stock']; ?></a></li>
					<li><a href="#tab-seo" data-toggle="tab"><?php echo $lang['text_tab_seo']; ?></a></li>
					<li><a href="#tab-order" data-toggle="tab"><?php echo $lang['text_tab_order']; ?></a></li>
					<li><a href="#tab-manual" data-toggle="tab"><?php echo $lang['text_tab_manual']; ?></a></li>
					<li><a href="#tab-info" data-toggle="tab"><?php echo $lang['text_tab_info']; ?></a></li>
					<!-- <li><a href="#tab-help" data-toggle="tab"><?php echo $lang['text_tab_help']; ?></a></li>
					<li><a href="#tab-updates" data-toggle="tab"><?php echo $lang['text_tab_updates']; ?></a></li> -->
				</ul>
				<div class="tab-content">

					<!-- ОСНОВНЫЕ -->
					<div class="tab-pane active" id="tab-general">
						<fieldset>
							<legend><?php echo $lang['legend_stores']; ?></legend>
							<div class="alert alert-info">
								<i class="fa fa-info-circle"></i>
								<?php echo $lang['desc_stores']; ?>
							</div>
							<div class="table-responsive">
								<table id="exchange1c_store_id" class="table table-bordered table-hover">
									<thead>
										<tr>
											<td class="text-left"><?php echo $lang['entry_catalog_1c']; ?></td>
											<td class="text-left"><?php echo $lang['entry_store']; ?></td>
											<td class="text-right"><?php echo $lang['entry_action']; ?></td>
										</tr>
									</thead>
									<tbody>
										<?php $store_row = 0 ?>
										<?php foreach ($exchange1c_stores as $config_store) { ?>
											<?php if ($config_store['store_id'] == 0) {?>
												<tr id="exchange1c_store_row<?php echo $store_row ?>">
													<td class="col-sm-8 text-left"><input class="form-control" type="text" name="exchange1c_stores[<?php echo $config_store['store_id'] ?>][name]" value="<?php echo $config_store['name']; ?>" class="form-control"/></td>
													<td class="col-sm-3 text-left"><?php echo $stores[$config_store['store_id']] ?><input type="hidden" name="exchange1c_stores[<?php echo $config_store['store_id'] ?>][store_id]" value="0" /></td>
													<td class="col-sm-1 text-left">&nbsp;</td>
												</tr>
											<?php } else { ?>
												<tr id="exchange1c_store_row<?php echo $store_row ?>">
													<td class="col-sm-8 text-left"><input class="form-control" type="text" name="exchange1c_stores[<?php echo $config_store['store_id'] ?>][name]" value="<?php echo $config_store['name']; ?>" /></td>
													<td class="col-sm-3 text-left"><select class="form-control" name="exchange1c_stores[<?php echo $config_store['store_id'] ?>][store_id]">
													<?php foreach ($stores as $store_id => $name) { ?>
														<?php if ($store_id == $config_store['store_id']) { ?>
															<option value="<?php echo $store_id ?>" selected="selected"><?php echo $name ?></option>
														<?php } else { ?>
															<option value="<?php echo $store_id ?>"><?php echo $name ?></option>
														<?php } ?>
													<?php } ?>
													</select></td>
													<td class="col-sm-1 text-center">
													<button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm('<?php echo $lang['text_confirm']; ?>') ? $('#exchange1c_store_row<?php echo $config_store['store_id'] ?>').remove() : false;"><i class="fa fa-trash-o"></i></button>
													</td>
												</tr>
											<?php } // if ?>
											<?php $store_row++ ?>
										<?php } // foreach ?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td class="text-center">
												<a onclick="addStore();" data-toggle="tooltip" title="<?php echo $lang['button_add']; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></a>
											</td>
										</tr>
									</tfoot>
								</table>
							</div> <!-- table -->
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_auth']; ?></legend>
							<div class="form-group">
								<?php echo $html_username; ?>
							</div>
							<div class="form-group">
								<?php echo $html_password; ?>
							</div>
							<div class="form-group">
								<?php echo $html_module_status; ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_security']; ?></legend>
							<div class="form-group">
								<?php echo $html_allow_ip; ?>
							</div>
							<div class="form-group">
								<?php echo $html_export_module_to_all; ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_optimization']; ?></legend>
							<div class="form-group">
								<?php echo $html_parse_categories_in_memory; ?>
							</div>
							<div class="form-group">
								<?php echo $html_parse_units_in_memory; ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_other']; ?></legend>
							<div class="form-group">
								<?php echo $html_cleaning_db ?>
							</div>
							<div class="form-group">
								<?php echo $html_cleaning_links ?>
							</div>
							<div class="form-group">
								<?php echo $html_cleaning_old_images ?>
							</div>
							<div class="form-group">
								<?php echo $html_cleaning_cache ?>
							</div>
							<div class="form-group">
								<?php echo $html_remove_doubles_links; ?>
							</div>
							<div class="form-group">
								<?php echo $html_synchronize_by_code; ?>
							</div>
							<div class="form-group">
								<?php echo $html_file_exchange; ?>
							</div>
							<div class="form-group">
								<?php echo $html_log_level; ?>
							</div>
							<div class="form-group">
								<?php echo $html_log_memory_use_view; ?>
							</div>
							<div class="form-group">
								<?php echo $html_log_debug_line_view; ?>
							</div>
							<div class="form-group">
								<?php echo $html_flush_log; ?>
							</div>
						</fieldset>
					</div><!-- tab general -->

					<!-- ТОВАРЫ -->
					<div class="tab-pane" id="tab-product">

						<div class="panel-heading">
							<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $lang['title_tab_product_edit']; ?></h3>
						</div>
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab-product-general" data-toggle="tab"><?php echo $lang['text_tab_product_general']; ?></a></li>
								<li><a href="#tab-product-properties" data-toggle="tab"><?php echo $lang['text_tab_product_properties']; ?></a></li>
								<li><a href="#tab-product-requisites" data-toggle="tab"><?php echo $lang['text_tab_product_requisites']; ?></a></li>
								<li><a href="#tab-product-features" data-toggle="tab"><?php echo $lang['text_tab_product_features']; ?></a></li>
							</ul>
							<div class="tab-content">

								<!-- ОСНОВНЫЕ -->
								<div class="tab-pane active" id="tab-product-general">
									<fieldset>
										<legend><?php echo $lang['legend_synchronize']; ?></legend>
										<div class="alert alert-info">
											<i class="fa fa-info-circle"></i>
											<?php echo $lang['desc_synchronize']; ?>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_new_product']; ?></legend>
										<div class="form-group">
											<?php echo $html_create_new_product ?>
										</div>
										<div class="form-group">
											<?php echo $html_synchronize_new_product_by ?>
										</div>
										<div class="form-group">
											<?php echo $html_status_new_product ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_not_import_disable ?>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_import_product_fields']; ?></legend>
										<div class="form-group">
											<div id="import_product_name_field_select">
												<?php echo $html_import_product_name ?>
											</div>
										</div>
										<div class="form-group">
											<?php echo $html_import_product_description ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_categories ?>
										</div>
										<div class="form-group">
											<?php echo $html_import_product_manufacturer ?>
										</div>
										<div class="form-group">
											<?php echo $html_parse_only_types_item ?>
										</div>
										<div class="form-group">
											<?php echo $html_description_html ?>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_product_images']; ?></legend>
										<div class="form-group">
											<?php echo $html_product_images_import_mode ?>
										</div>
										<div class="form-group">
											<?php echo $html_watermark ?>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_product_std_from_ts']; ?></legend>
										<div class="table-responsive">
											<table id="exchange1c_product_std" class="table table-bordered table-hover">
												<thead>
													<tr>
														<td class="col-sm-2 text-left"><?php echo $lang['text_product_tag_name_ts']; ?></td>
														<td class="col-sm-7 text-left"><?php echo $lang['text_desc']; ?></td>
														<td class="col-sm-1 text-left"><?php echo $lang['text_database_field']; ?></td>
														<td class="col-sm-2 text-left"><?php echo $lang['text_database_table']; ?></td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Ид</td>
														<td><?php echo $lang['desc_product_guid']; ?></td>
														<td>1c_id</td>
														<td>product_to_1c</td>
													</tr>
													<tr>
														<td>Код</td>
														<td><?php echo $lang['desc_product_1c_code']; ?></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<td>Артикул</td>
														<td><?php echo $lang['desc_product_sku']; ?></td>
															<td>sku, model</td>
														<td>product</td>
														</tr>
													<tr>
														<td>Штрихкод</td>
														<td><?php echo $lang['desc_product_ean']; ?></td>
														<td>ean</td>
														<td>product</td>
													</tr>
													<tr>
														<td>БазоваяЕдиница</td>
														<td><?php echo $lang['desc_product_unit']; ?></td>
														<td>unit_id</td>
														<td>product_unit, product_quantity, product_price</td>
													</tr>
													<tr>
														<td>ПолноеНаименование</td>
														<td><?php echo $lang['desc_product_fullname']; ?></td>
														<td>name</td>
														<td>product</td>
													</tr>
													<tr>
														<td>Описание</td>
														<td><?php echo $lang['desc_product_description']; ?></td>
														<td>description</td>
														<td>product_description</td>
													</tr>
													<tr>
														<td>Изготовитель</td>
														<td><?php echo $lang['desc_product_manufacturer']; ?></td>
														<td>manufacturer_id</td>
														<td>product</td>
													</tr>
												</tbody>
											</table>
										</div> <!-- table -->
									</fieldset>
								</div><!-- tab-product-general -->

								<!-- СВОЙСТВА (АТРИБУТЫ) -->
								<div class="tab-pane" id="tab-product-properties">
									<fieldset>
										<div class="form-group">
											<?php echo $html_synchronize_attribute_by ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_property_type ?>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_product_properties_from_ts']; ?></legend>
										<div class="alert alert-info">
											<i class="fa fa-info-circle"></i>
											<?php echo $lang['desc_product_properties_from_ts']; ?>
										</div>
										<div class="table-responsive">
											<table id="exchange1c_property" class="table table-bordered table-hover">
												<thead>
													<tr>
														<td class="col-sm-1 text-left"><?php echo $lang['text_database_field']; ?></td>
														<td class="col-sm-2 text-left"><?php echo $lang['text_property_name_ts']; ?></td>
														<td class="col-sm-5 text-left"><?php echo $lang['text_template']; ?></td>
														<td class="col-sm-2 text-left"><?php echo $lang['text_product_field']; ?></td>
														<td class="col-sm-1 text-left"><?php echo $lang['text_import_attribute']; ?></td>
														<td class="col-sm-1 text-right"><?php echo $lang['text_action']; ?></td>
													</tr>
												</thead>
												<tbody>
													<?php $property_row = 0 ?>
													<?php foreach ($exchange1c_properties as $property_id => $property) { ?>
														<tr id="exchange1c_property_row<?php echo $property_row ?>">
															<?php foreach ($product_fields as $name => $description) { ?>
																<?php if ($name == $property['product_field_name']) { ?>
																	<td class="col-sm-1 text-left" id="property_index<?php echo $property_id; ?>"><?php echo $name; ?></td>
																<?php } ?>
															<?php } ?>
															<td class="text-left"><input class="form-control" type="text" name="exchange1c_properties[<?php echo $property_id ?>][name]" value="<?php echo $property['name']; ?>" /></td>
															<td class="text-left"><input class="form-control" type="text" name="exchange1c_properties[<?php echo $property_id ?>][template]" value="<?php echo $property['template']; ?>">
															<td class="text-left"><select class="form-control" name="exchange1c_properties[<?php echo $property_id ?>][product_field_name]" onchange="changeProductField(<?php echo $property_row ?>, this.options[this.selectedIndex].value)">
															<?php foreach ($product_fields as $name => $description) { ?>
																<?php if ($name == $property['product_field_name']) { ?>
																	<option value="<?php echo $name ?>" selected="selected"><?php echo $description ?></option>
																<?php } else { ?>
																	<option value="<?php echo $name ?>"><?php echo $description ?></option>
																<?php } ?>
															<?php } ?>
															</select></td>
															<td class="text-center">
															<input type="checkbox" name="exchange1c_properties[<?php echo $property_id ?>][import]" <?php echo isset($property['import']) ? 'checked' : '' ?>/>
															</td>
															<td class="text-center">
															<button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm('<?php echo $lang['text_confirm']; ?>') ? $('#exchange1c_property_row<?php echo $property_row ?>').remove() : false;"><i class="fa fa-minus-circle"></i></button>
															</td>
														</tr>
														<?php $property_row++ ?>
													<?php } // foreach ?>
												</tbody>
												<tfoot>
													<tr>
														<td colspan="5"></td>
														<td class="text-center">
															<a onclick="addProperty();" data-toggle="tooltip" title="<?php echo $lang['button_add']; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></a>
														</td>
													</tr>
												</tfoot>
											</table>
										</div> <!-- table -->
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_product_properties_std_from_ts']; ?></legend>
										<div class="table-responsive">
											<div class="alert alert-info">
												<i class="fa fa-info-circle"></i>
												<?php echo $lang['desc_product_properties_name']; ?>
											</div>
											<table id="exchange1c_property_standart" class="table table-bordered table-hover">
												<thead>
													<tr>
														<td class="col-sm-2 text-left"><?php echo $lang['text_property_name_ts']; ?></td>
														<td class="col-sm-7 text-left"><?php echo $lang['text_property_desc']; ?></td>
														<td class="col-sm-1 text-left"><?php echo $lang['text_database_field']; ?></td>
														<td class="col-sm-2 text-left"><?php echo $lang['text_product_field_cms']; ?></td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Производитель</td>
														<td><?php echo $lang['desc_product_prop_manufacturer']; ?></td>
														<td>manufacturer_id</td>
														<td>Производитель</td>
													</tr>
													<tr>
														<td>Вес</td>
														<td><?php echo $lang['desc_product_prop_weight']; ?></td>
														<td>weight</td>
														<td>Вес</td>
													</tr>
													<tr>
														<td>Ширина</td>
														<td><?php echo $lang['desc_product_prop_width']; ?></td>
														<td>width</td>
														<td>Ширина</td>
													</tr>
													<tr>
														<td>Высота</td>
														<td><?php echo $lang['desc_product_prop_height']; ?></td>
														<td>height</td>
														<td>Высота</td>
													</tr>
													<tr>
														<td>Длина</td>
														<td><?php echo $lang['desc_product_prop_length']; ?></td>
														<td>length</td>
														<td>Длина</td>
													</tr>
													<tr>
														<td>Модель</td>
														<td><?php echo $lang['desc_product_prop_model']; ?></td>
														<td>model</td>
														<td><?php echo $lang['text_model']; ?></td>
													</tr>
												</tbody>
											</table>
										</div> <!-- table -->
									</fieldset>
								</div><!-- tab-product-properties -->

								<!-- РЕКВИЗИТЫ -->
								<div class="tab-pane" id="tab-product-requisites">
									<fieldset>
										<legend><?php echo $lang['legend_product_requisite_std_from_ts']; ?></legend>
										<div class="table-responsive">
											<table id="exchange1c_requisite_standart" class="table table-bordered table-hover">
												<thead>
													<tr>
														<td class="col-sm-2 text-left"><?php echo $lang['text_requisite_name_ts']; ?></td>
														<td class="col-sm-7 text-left"><?php echo $lang['text_requisite_desc']; ?></td>
														<td class="col-sm-1 text-left"><?php echo $lang['text_database_field']; ?></td>
														<td class="col-sm-2 text-left"><?php echo $lang['text_product_field_cms']; ?></td>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>Вес</td>
														<td><?php echo $lang['desc_product_req_weight']; ?></td>
														<td>weight</td>
														<td>Вес</td>
													</tr>
													<tr>
														<td>ТипНоменклатуры</td>
														<td><?php echo $lang['desc_product_req_type']; ?></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<td>ВидНоменклатуры</td>
														<td><?php echo $lang['desc_product_req_view']; ?></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<td>ОписаниеВФорматеHTML</td>
														<td><?php echo $lang['desc_product_req_desc_html']; ?></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<td>Полное наименование</td>
														<td><?php echo $lang['desc_product_req_fullname']; ?></td>
														<td>name</td>
														<td>Наименование</td>
													</tr>
												</tbody>
											</table>
										</div> <!-- table -->
									</fieldset>
								</div><!-- tab-product-requisites -->

								<!-- ХАРАКТЕРИСТИКИ (ОПЦИИ) -->
								<div class="tab-pane" id="tab-product-features">
									<fieldset>
										<div class="form-group">
											<?php echo $html_product_options_mode ?>
										</div>
										<div class="form-group">
											<?php echo $html_clean_options ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_type ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_feature_name ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_subtract ?>
										</div>
									</fieldset>
									<fieldset>
										<legend><?php echo $lang['legend_product_options_images']; ?></legend>
										<div class="form-group">
											<div class="alert alert-info">
												<i class="fa fa-info-circle"></i>
												<?php echo $lang['desc_product_options_images']; ?>
											</div>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_image_load ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_image_folder ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_image_use_path_product ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_image_prefix ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_image_only_digit ?>
										</div>
										<div class="form-group">
											<?php echo $html_product_options_image_ext ?>
										</div>
									</fieldset>

								</div><!-- tab-product-features -->

							</div><!-- tab-content -->

						</div><!-- panel-body -->

					</div>
					<!-- ТОВАРЫ -->

					<!-- КАТЕГОРИИ -->
					<div class="tab-pane" id="tab-category">
						<div class="form-group">
							<?php echo $html_import_categories ?>
							<?php echo $html_import_categories_mode ?>
						</div>
						<legend><?php echo $lang['legend_synchronize']; ?></legend>
						<div class="alert alert-info">
							<i class="fa fa-info-circle"></i>
							<?php echo $lang['desc_synchronize']; ?>
						</div>
						<legend><?php echo $lang['legend_new_category']; ?></legend>
						<div class="form-group">
							<?php echo $html_create_new_category ?>
						</div>
						<div class="form-group">
							<?php echo $html_status_new_category ?>
						</div>
						<legend><?php echo $lang['legend_other']; ?></legend>
						<div class="form-group">
							<?php echo $html_fill_parent_cats ?>
						</div>

						<legend><?php echo $lang['legend_category_properties_from_ts']; ?></legend>
						<div class="table-responsive">
							<div class="alert alert-info">
								<i class="fa fa-info-circle"></i>
								<?php echo $lang['desc_category_properties']; ?>
							</div>
							<table id="exchange1c_category_property" class="table table-bordered table-hover">
								<thead>
									<tr>
										<td class="col-sm-2 text-left"><?php echo $lang['text_property_name_ts']; ?></td>
										<td class="col-sm-7 text-left"><?php echo $lang['text_property_desc']; ?></td>
										<td class="col-sm-1 text-left"><?php echo $lang['text_database_field']; ?></td>
										<td class="col-sm-2 text-left"><?php echo $lang['text_product_field_cms']; ?></td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Картинка</td>
										<td><?php echo $lang['desc_category_prop_image']; ?></td>
										<td>image</td>
										<td>Картинка</td>
									</tr>
									<tr>
										<td>Сортировка</td>
										<td><?php echo $lang['desc_category_prop_sort_order']; ?></td>
										<td>sort_order</td>
										<td>Сортировка</td>
									</tr>
								</tbody>
							</table>
						</div> <!-- table -->

						<legend><?php echo $lang['legend_category_name_split']; ?></legend>
						<div class="table-responsive">
							<div class="alert alert-info">
								<i class="fa fa-info-circle"></i>
								<?php echo $lang['desc_category_name_split']; ?>
							</div>
						</div> <!-- table -->

					</div>
					<!-- КАТЕГОРИИ -->

					<!-- ЦЕНЫ -->
					<div class="tab-pane" id="tab-prices">
						<div class="form-group">
							<?php echo $html_price_import_mode ?>
						</div>
						<div class="form-group">
							<?php echo $html_price_types_auto_load ?>
						</div>
						<div class="form-group">
							<?php echo $html_product_disable_if_price_zero ?>
						</div>
						<div class="form-group">
							<?php echo $html_clean_prices_full_import ?>
						</div>
						<div class="alert alert-info">
							<i class="fa fa-info-circle"></i>
							<?php echo $lang['desc_prices']; ?>
						</div>
						<legend><?php echo $lang['legend_prices']; ?></legend>
						<div class="table-responsive">
							<table id="exchange1c_price_type_id" class="table table-bordered table-hover">
								<thead>
									<tr>
										<td class="col-sm-3 text-left"><?php echo $lang['text_config_price_type']; ?></td>
										<td class="col-sm-3 text-left"><?php echo $lang['text_config_price_id_cml']; ?></td>
										<td class="col-sm-2 text-left"><?php echo $lang['text_customer_group']; ?></td>
										<td class="text-left" style="width: 10%;"><?php echo $lang['text_table']; ?></td>
										<td class="col-sm-1 text-right"><?php echo $lang['text_quantity']; ?></td>
										<td class="col-sm-1 text-right"><?php echo $lang['text_priority']; ?></td>
										<td><?php echo $lang['text_action']; ?></td>
									</tr>
								</thead>
								<tbody>
									<?php $price_row = 0; ?>
									<?php foreach ($exchange1c_price_type as $obj) { ?>
										<tr id="exchange1c_price_type_row<?php echo $price_row; ?>">
											<td class="text-left"><input class="form-control" type="text" name="exchange1c_price_type[<?php echo $price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
											<td class="text-left"><input class="form-control" type="text" name="exchange1c_price_type[<?php echo $price_row; ?>][guid]" value="<?php echo isset($obj['guid']) ? $obj['guid'] : ''; ?>" /></td>
											<td class="text-left"><select class="form-control" id="customer_group" name="exchange1c_price_type[<?php echo $price_row; ?>][customer_group_id]">
											<?php foreach ($customer_groups as $customer_group) { ?>
												<?php if ($customer_group['customer_group_id'] == $obj['customer_group_id']) { ?>
													<option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
												<?php } else { ?>
													<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
												<?php } ?>
											<?php } ?>
											</select></td>
											<td class="text-left"><select class="form-control" id="table_price" name="exchange1c_price_type[<?php echo $price_row; ?>][table_price]">
											<?php foreach ($table_prices as $table_price) { ?>
												<?php if ($table_price['name'] == $obj['table_price']) { ?>
													<option value="<?php echo $table_price['name']; ?>" selected="selected"><?php echo $table_price['desc']; ?></option>
												<?php } else { ?>
													<option value="<?php echo $table_price['name']; ?>"><?php echo $table_price['desc']; ?></option>
												<?php } ?>
											<?php } ?>
											<td class="text-center"><input class="form-control" type="text" name="exchange1c_price_type[<?php echo $price_row; ?>][quantity]" value="<?php echo $obj['quantity']; ?>" size="2" /></td>
											<td class="text-center"><input class="form-control" type="text" name="exchange1c_price_type[<?php echo $price_row; ?>][priority]" value="<?php echo $obj['priority']; ?>" size="2" /></td>
											<td class="text-center">
											<button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm('<?php echo $lang['text_confirm']; ?>') ? $('#exchange1c_price_type_row<?php echo $price_row; ?>').remove() : false;"><i class="fa fa-minus-circle"></i></button>
											</td>
										</tr>
										<?php $price_row++; ?>
									<?php } ?>
								</tbody>
								<tfoot>
									<?php if (count($customer_groups)) { ?>
									<tr>
										<td colspan="6"></td>
										<td class="text-center">
											<button type="button" id="btn_add_price_type" onclick="addConfigPriceType();" data-toggle="tooltip" title="<?php echo $lang['button_add']; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
										</td>
									</tr>
									<?php } ?>
								</tfoot>
							</table>
						</div> <!-- table -->
						<div class="form-group">
							<?php echo $html_ignore_price_zero ?>
						</div>
						<div class="form-group">
							<?php echo $html_currency_convert ?>
						</div>
					</div>
					<!-- ЦЕНЫ -->

					<!-- ОСТАТКИ -->
					<div class="tab-pane" id="tab-stock">
						<legend><?php echo $lang['legend_stock']; ?></legend>
						<div class="form-group">
							<?php echo $html_default_stock_status; ?>
							<?php echo $html_product_disable_if_quantity_zero ?>
							<?php echo $html_flush_quantity ?>
						</div>
					</div>
					<!-- ОСТАТКИ -->

					<!-- SEO -->
					<div class="tab-pane" id="tab-seo">
						<!-- SEO товар -->
						<fieldset>
							<legend><?php echo $lang['legend_generate_seo']; ?></legend>
							<div class="form-group">
								<?php echo $html_generate_seo ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_seo_product']; ?></legend>
							<div class="form-group">
								<?php echo $html_seo_product_mode; ?>
								<label class="col-sm-12 text-left">
									<?php echo $lang['label_available_patterns']; echo $exchange1c_seo_product_tags; ?>
									<input type="hidden" name="exchange1c_seo_product_tags" value="<?php echo $exchange1c_seo_product_tags; ?>"/>
								</label>
							</div>
							<div class="form-group">
								<?php echo $html_seo_product_seo_url; ?>
								<?php echo $html_seo_product_seo_url_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_product_meta_title; ?>
								<?php echo $html_seo_product_meta_title_template; ?>
							</div>
							<?php if(isset($html_seo_product_meta_h1)) { ?>
							<div class="form-group">
								<?php echo $html_seo_product_meta_h1 ?>
								<?php echo $html_seo_product_meta_h1_template ?>
							</div>
							<?php } ?>
							<div class="form-group">
								<?php echo $html_seo_product_meta_description; ?>
								<?php echo $html_seo_product_meta_description_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_product_meta_keyword; ?>
								<?php echo $html_seo_product_meta_keyword_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_product_tag; ?>
								<?php echo $html_seo_product_tag_template; ?>
							</div>
						</fieldset>
						<!-- SEO категория -->
						<fieldset>
							<legend><?php echo $lang['legend_seo_category']; ?></legend>
							<div class="form-group">
								<?php echo $html_seo_category_mode; ?>
								<label class="col-sm-12 text-left">
									<?php echo $lang['label_available_patterns']; echo $exchange1c_seo_category_tags; ?>
								</label>
								<input type="hidden" name="exchange1c_seo_category_tags" value="<?php echo $exchange1c_seo_category_tags; ?>"/>
							</div>
							<div class="form-group">
								<?php echo $html_seo_category_seo_url; ?>
								<?php echo $html_seo_category_seo_url_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_category_meta_title; ?>
								<?php echo $html_seo_category_meta_title_template; ?>
							</div>
							<?php if(isset($html_seo_category_meta_h1)) { ?>
							<div class="form-group">
								<?php echo $html_seo_category_meta_h1 ?>
								<?php echo $html_seo_category_meta_h1_template ?>
							</div>
							<?php } ?>
							<div class="form-group">
								<?php echo $html_seo_category_meta_description; ?>
								<?php echo $html_seo_category_meta_description_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_category_meta_keyword; ?>
								<?php echo $html_seo_category_meta_keyword_template; ?>
							</div>
						</fieldset>
						<!-- SEO Производителя -->
						<fieldset>
						<legend><?php echo $lang['legend_seo_manufacturer']; ?></legend>
							<div class="form-group">
								<?php echo $html_seo_manufacturer_mode; ?>
								<label class="col-sm-12 text-left">
									<?php echo $lang['label_available_patterns']; echo $exchange1c_seo_manufacturer_tags; ?>
								</label>
								<input type="hidden" name="exchange1c_seo_manufacturer_tags" value="<?php echo $exchange1c_seo_manufacturer_tags; ?>"/>
							</div>
							<div class="form-group">
								<?php echo $html_seo_manufacturer_seo_url; ?>
								<?php echo $html_seo_manufacturer_seo_url_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_manufacturer_meta_title; ?>
								<?php echo $html_seo_manufacturer_meta_title_template; ?>
							</div>
							<?php if(isset($html_seo_manufacturer_meta_h1)) { ?>
							<div class="form-group">
								<?php echo $html_seo_manufacturer_meta_h1 ?>
								<?php echo $html_seo_manufacturer_meta_h1_template ?>
							</div>
							<?php } ?>
							<div class="form-group">
								<?php echo $html_seo_manufacturer_meta_description; ?>
								<?php echo $html_seo_manufacturer_meta_description_template; ?>
							</div>
							<div class="form-group">
								<?php echo $html_seo_manufacturer_meta_keyword; ?>
								<?php echo $html_seo_manufacturer_meta_keyword_template; ?>
							</div>
						</fieldset>
					</div><!-- tab-seo -->

					<!-- ЗАКАЗЫ -->
					<div class="tab-pane" id="tab-order">
						<fieldset>
							<legend><?php echo $lang['legend_order_export']; ?></legend>
							<div class="form-group">
								<?php echo $html_orders_export_modify; ?>
							</div>
							<div class="form-group" id="order_date_export">
								<label class="col-sm-2 control-label"><?php echo $lang['entry_order_date_export'] ?></label>
								<div class="col-sm-2">
									<input type="datetime-local" name="exchange1c_order_date" class="form-control" value="<?php echo $order_date_export ?>"/>
								</div>
								<div class="col-sm-8">
									<div class="alert alert-info"><i class="fa fa-info-circle"></i>
										<?php echo $lang['desc_order_date_export'] ?>
									</div>
								</div>
							</div>
							<div class="form-group">
								<?php echo $html_order_status_export; ?>
							</div>
							<div class="form-group" id="order_status_export">
								<?php echo $html_order_status_exported; ?>
							</div>
							<div class="form-group">
								<?php echo $html_order_date_ship; ?>
							</div>
							<div class="form-group">
								<?php echo $html_order_reserve_product; ?>
							</div>
							<div class="form-group">
								<?php echo $html_convert_orders_cp1251; ?>
							</div>
							<div class="form-group">
								<?php echo $html_fio_corrector; ?>
							</div>
							<div class="form-group">
								<?php echo $html_order_customer_export; ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_set_order_status']; ?></legend>
							<div class="form-group" id="orders_import">
								<?php echo $html_orders_import; ?>
							</div>
							<div class="form-group" id="order_status_shipped">
								<?php echo $html_order_status_shipped; ?>
							</div>
							<div class="form-group" id="order_status_paid">
								<?php echo $html_order_status_paid; ?>
							</div>
							<div class="form-group" id="order_status_completed">
								<?php echo $html_order_status_completed; ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_order_other']; ?></legend>
							<div class="form-group">
								<?php echo $html_order_currency; ?>
							</div>
							<div class="form-group">
								<?php echo $html_order_notify; ?>
							</div>
						</fieldset>
						<fieldset>
							<legend><?php echo $lang['legend_setting_order_shipping']; ?></legend>
							<div class="alert alert-info">
								<i class="fa fa-info-circle"></i>
								<?php echo $lang['i_setting_order_shipping']; ?>
							</div>

							<div class="form-group">
								<?php echo $html_services_in_table_product; ?>
							</div>
							<!-- ТАБЛИЦА Настройка видов доставки для экспорта в заказы в ТС -->
							<div class="table-responsive">
								<table id="orders_delivery" class="table table-bordered table-hover">
									<thead>
										<tr>
											<td class="col-sm-5 text-left"><?php echo $lang['text_types_of_delivery']; ?></td>
											<td class="col-sm-6 text-left"><?php echo $lang['text_mapped_services']; ?></td>
											<td class="col-sm-1 text-center"><?php echo $lang['text_action']; ?></td>
										</tr>
									</thead>
									<tbody>
										<?php $order_delivery_row = 0 ?>
										<?php foreach ($exchange1c_order_delivery as $row_id => $data_row) { ?>
											<tr id="exchange1c_order_delivery_row<?php echo $order_delivery_row ?>">
												<td class="text-left"><select class="form-control" name="exchange1c_order_delivery[<?php echo $row_id ?>][delivery_id]">
												<?php foreach ($order_types_of_delivery as $delivery_id => $name) { ?>
													<?php if ($data_row['delivery_id'] == $delivery_id) { ?>
														<option value="<?php echo $delivery_id ?>" selected="selected"><?php echo $name ?></option>
													<?php } else { ?>
														<option value="<?php echo $delivery_id ?>"><?php echo $name ?></option>
													<?php } ?>
												<?php } ?>
												</select></td>
												<td class="text-left">
												<div><input class="form-control" type="text" name="exchange1c_order_delivery[<?php echo $row_id ?>][delivery_service_name]" value="<?php echo $data_row['delivery_service_name'] ?>"></div>
												</td>
												<td class="text-center">
												<button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm('<?php echo $lang['text_confirm']; ?>') ? $('#exchange1c_order_delivery_row<?php echo $order_delivery_row ?>').remove() : false;"><i class="fa fa-minus-circle"></i></button>
												</td>
											</tr>
											<?php $order_delivery_row++ ?>
										<?php } // foreach ?>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="2"></td>
											<td class="text-center">
												<a onclick="addOrderDelivery();" data-toggle="tooltip" title="<?php echo $lang['button_add']; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></a>
											</td>
										</tr>
									</tfoot>
								</table>
							</div> <!-- table -->
							<!-- ТАБЛИЦА Настройка видов доставки для экспорта в заказы в ТС -->
						</fieldset>

					</div><!-- tab-order -->

					<!-- РУЧНАЯ ОБРАБОТКА -->
					<div class="tab-pane" id="tab-manual">
						<div class="form-group">
							<label class="col-sm-2 control-label" for="button-upload">
								<span title="" data-original-title="<?php echo $lang['help_upload']; ?>" data-toggle="tooltip"><?php echo $lang['entry_upload']; ?></span>
							</label>
							<button id="exchange1c-button-upload" class="col-sm-2 btn btn-primary" type="button" data-loading-text="<?php echo $lang['button_upload']; ?>">
								<i class="fa fa-upload"></i>
								<?php echo $lang['button_upload']; ?>
							</button>
							<div class="col-sm-8">
								<label class="alert alert-info"><i class="fa fa-info-circle"></i> Upload max file size : <?php echo $upload_max_filesize; ?></label>
								<label class="alert alert-info"><i class="fa fa-info-circle"></i> Maximum size of POST data : <?php echo $post_max_size; ?></label>
								<label class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $lang['desc_upload_file']; ?></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="button-download-orders">
								<span title="" data-original-title="<?php echo $lang['help_download_orders']; ?>" data-toggle="tooltip"><?php echo $lang['entry_download_orders']; ?></span>
							</label>
							<button class="col-sm-2 btn btn-primary" form="form-download-orders" type="submit" data-loading-text="<?php echo $lang['button_download_orders']; ?>">
							<i class="fa fa-download"></i>
							<?php echo $lang['button_download']; ?>
							</button>
							<div class="col-sm-8">
								<div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $lang['desc_download_orders']; ?></div>
							</div>
						</div>
					</div><!-- tab-manual -->

					<!-- ИНФОРМАЦИЯ -->
					<div class="tab-pane" id="tab-info">
						<div class="form-group">
							<label class="col-sm-2 control-label"><?php echo $lang['entry_num_links_product_info'] ?></label>
							<div class="col-sm-2">
								<div class="form-control"><?php echo $links_product_info ?></div>
							</div>
							<div class="col-sm-8">
								<div class="alert alert-info"><i class="fa fa-info-circle"></i>
									<?php echo $lang['desc_num_links_product_info'] ?>
								</div>
							</div>
							<label class="col-sm-2 control-label"><?php echo $lang['entry_num_links_category_info'] ?></label>
							<div class="col-sm-2">
								<div class="form-control"><?php echo $links_category_info ?></div>
							</div>
							<div class="col-sm-8">
								<div class="alert alert-info"><i class="fa fa-info-circle"></i>
									<?php echo $lang['desc_num_links_category_info'] ?>
								</div>
							</div>
							<label class="col-sm-2 control-label"><?php echo $lang['entry_num_links_manufacturer_info'] ?></label>
							<div class="col-sm-2">
								<div class="form-control"><?php echo $links_manufacturer_info ?></div>
							</div>
							<div class="col-sm-8">
								<div class="alert alert-info"><i class="fa fa-info-circle"></i>
									<?php echo $lang['desc_num_links_manufacturer_info'] ?>
								</div>
							</div>
							<label class="col-sm-2 control-label"><?php echo $lang['entry_num_links_attribute_info'] ?></label>
							<div class="col-sm-2">
								<div class="form-control"><?php echo $links_attribute_info ?></div>
							</div>
							<div class="col-sm-8">
								<div class="alert alert-info"><i class="fa fa-info-circle"></i>
									<?php echo $lang['desc_num_links_attribute_info'] ?>
								</div>
							</div>
						</div>
					</div>

					<!-- СПРАВКА -->
					<div class="tab-pane" id="tab-help">
						<div class="form-group">
							<div class="col-sm-12">
								<div class="alert alert-info"><i class="fa fa-info-circle"></i>
									В стадии разработки
								</div>
							</div>
						</div>
					</div><!-- tab-help -->

					<!-- ОБНОВЛЕНИЯ -->
					<div class="tab-pane" id="tab-updates">
						<fieldset>
							<legend>v 1.6.3.10 от 01.06.2017</legend>
							<div class="form-group">
								<ul>
									<li>Исправлена ошибка при загрузке в товар полного наименования из реквизита</li>
									<li>Исправлена ошибка при чтении остатков без складов (формат Битрикс)</li>
									<li>Добавлена очистка картинки из кэша во время загрузки данных</li>
									<li>Добавлена загрузка определяемых пользователем свойств</li>
									<li>Объеденены опции очистки остатков в одну</li>
									<li>Добавлена вкладка "Обновления"</li>
									<li>Изменена вкладка "Заказы". Переработана система выгрузки и загрузки заказов.</li>
									<li>Исправлена ошибка с изменением статуса заказа</li>
									<li>Удалены в заказах определение статусов для выгрузки, за ненадобностью.</li>
									<li>Изменен алгоритм отключения обновления картинок</li>
									<li>Добавлена возможность редактирования периода выгрузки заказов</li>
									<li>Добавлена настройка отключающая загрузку заказов</li>
									<li>Добавлена настройка в товар, которая указывает что делать с категориями товара</li>
									<li>Добавлена возможность программной остановки загрузки каталога и предложений. При наличии файла с названием break в папке /system/storage/cache/exchange1c</li>
								</ul>
							</div>
						</fieldset>
						<fieldset>
							<legend>v 1.6.3.11 от 03.06.2017</legend>
							<div class="form-group">
								<ul>
									<li>Исправлена ошибка зацикливания при включенной очистке кэша картинок</li>
									<li>Исправлена ошибка при которой не срабатывала автозагрузка цен</li>
									<li>В заказах доработана определение адреса контрагента</li>
									<li>Изменилось название гастройки "Статус" на вкладке "Основные". Необходимо после обновления записать настройки</li>
									<li>Удалена настройка "Название системы обмена", так как она так и не была использована, модуль автоматически определяет формат и работает с ним.</li>
									<li>Исправлена ошибка в карточке товара где вместо общего остатка указывалось undefuned</li>
									<li>Изменена форма настройки товара</li>
									<li>Добавлена настройка где можно задать тип опций при загрузке характеристик</li>
									<li>Добавлена настройка где можно задать название свойства при стандартной загрузки характеристик</li>
								</ul>
							</div>
						</fieldset>
					</div><!-- tab-updates -->

	 			</div><!-- tab-content -->
			</form>
 			</div><!-- panel-body-->
		</div><!-- panel panel-default -->
	</div><!-- container-fluid  -->
</div><!-- content -->


<script type="text/javascript"><!--

$('#exchange1c-button-upload').on('click', function() {
	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" value="" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=extension/module/exchange1c/manualImport&token=<?php echo $token; ?>',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$('#exchange1c-button-upload i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
					$('#exchange1c-button-upload').prop('disabled', true);
				},
				complete: function() {
					$('#exchange1c-button-upload i').replaceWith('<i class="fa fa-upload"></i>');
					$('#exchange1c-button-upload').prop('disabled', false);
				},
				success: function(json) {
					if (json['error']) {
						alert(json['error']);
					}

					if (json['success']) {
						alert(json['success']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});


$('#exchange1c-button-cleaning_db').on('click', function() {
	$('#form-clean').remove();
	if (confirm('<?php echo $lang['text_confirm'] ?>')) {
		$.ajax({
			url: 'index.php?route=extension/module/exchange1c/manualCleaning&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			data: new FormData($('#form-clean')[0]),
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-clean').prop('disabled', true);
			},
			complete: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-trash-o"></i>');
				$('#button-clean').prop('disabled', false);
			},
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}

				if (json['success']) {
					alert(json['success']);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});


$('#exchange1c-button-cleaning_links').on('click', function() {
	$('#form-clean').remove();
	if (confirm('<?php echo $lang['text_confirm'] ?>')) {
		$.ajax({
			url: 'index.php?route=extension/module/exchange1c/manualCleaningLinks&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			data: new FormData($('#form-clean')[0]),
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-clean').prop('disabled', true);
			},
			complete: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-trash-o"></i>');
				$('#button-clean').prop('disabled', false);
			},
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}

				if (json['success']) {
					alert(json['success']);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});


$('#exchange1c-button-cleaning_old_images').on('click', function() {
	$('#form-clean').remove();
	if (confirm('<?php echo $lang['text_confirm'] ?>')) {
		$.ajax({
			url: 'index.php?route=extension/module/exchange1c/manualCleaningOldImages&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			data: new FormData($('#form-clean')[0]),
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-clean').prop('disabled', true);
			},
			complete: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-trash-o"></i>');
				$('#button-clean').prop('disabled', false);
			},
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}

				if (json['success']) {
					alert(json['success']);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});


$('#exchange1c-button-cleaning_cache').on('click', function() {
	$('#form-clean').remove();
	if (confirm('<?php echo $lang['text_confirm'] ?>')) {
		$.ajax({
			url: 'index.php?route=extension/module/exchange1c/manualCleaningCache&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			data: new FormData($('#form-clean')[0]),
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-clean').prop('disabled', true);
			},
			complete: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-trash-o"></i>');
				$('#button-clean').prop('disabled', false);
			},
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}

				if (json['success']) {
					alert(json['success']);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});


$('#exchange1c-button-generate_seo').on('click', function() {
	$('#form-clean').remove();
	if (confirm('<?php echo $lang['text_confirm'] ?>')) {
		$.ajax({
			url: 'index.php?route=extension/module/exchange1c/manualGenerateSeo&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			data: new FormData($('#form-clean')[0]),
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-clean').prop('disabled', true);
			},
			complete: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-trash-o"></i>');
				$('#button-clean').prop('disabled', false);
			},
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}

				if (json['success']) {
					alert(json['success']);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});


$('#exchange1c-button-remove_doubles_links').on('click', function() {
	$('#form-clean').remove();
	if (confirm('<?php echo $lang['text_confirm'] ?>')) {
		$.ajax({
			url: 'index.php?route=extension/module/exchange1c/manualRemoveDoublesLinks&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			data: new FormData($('#form-clean')[0]),
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
				$('#button-clean').prop('disabled', true);
			},
			complete: function() {
				$('#button-clean i').replaceWith('<i class="fa fa-trash-o"></i>');
				$('#button-clean').prop('disabled', false);
			},
			success: function(json) {
				if (json['error']) {
					alert(json['error']);
				}

				if (json['success']) {
					alert(json['success']);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});


var price_row = <?php echo $price_row; ?>;
function addConfigPriceType() {
	html = '<tr id="exchange1c_price_type_row' + price_row + '">';
	html += '<td class="text-left"><input class="form-control" type="text" name="exchange1c_price_type[' + price_row + '][keyword]" value="" /></td>';
	html += '<td class="text-left"><input class="form-control" type="text" name="exchange1c_price_type[' + price_row + '][id_cml]" value="" /></td>';
	html += '<td class="text-left"><select class="form-control" id="customer_group" name="exchange1c_price_type[' + price_row + '][customer_group_id]">';
	<?php foreach ($customer_groups as $customer_group) { ?>
	html += '<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
	<?php } ?>
	html += '</select></td>';
	html += '<td class="text-center"><input class="form-control" type="text" name="exchange1c_price_type[' + price_row + '][quantity]" value="1" size="2" /></td>';
	html += '<td class="text-center"><input class="form-control" type="text" name="exchange1c_price_type[' + price_row + '][priority]" value="<?php echo $price_row+1; ?>" size="2" /></td>';
	html += '<td class="text-center"><button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm(\'<?php echo $lang['text_confirm']; ?>\') ? $(\'#exchange1c_price_type_row' + price_row + '\').remove() : false;"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';

	$('#exchange1c_price_type_id tbody').append(html);
	price_row++;
	$('select#customer_group').change();
}


var store_row = <?php echo $store_row ?>;
function addStore() {
	html = '<tr id="exchange1c_store_row' + store_row + '">';
	html += '<td class="col-sm-8 text-left"><input class="form-control" type="text" name="exchange1c_stores[' + store_row + '][name]" value="" /></td>';
	html += '<td class="col-sm-3 text-left"><select class="form-control" name="exchange1c_stores[' + store_row + '][store_id]">';
	<?php foreach ($stores as $store_id => $name) { ?>
	html += '<option value="<?php echo $store_id ?>"><?php echo $name ?></option>';
	<?php } ?>
	html += '</select></td>';
	html += '<td class="col-sm-1 text-center"><button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm(\'<?php echo $lang['text_confirm']; ?>\') ? $(\'#exchange1c_store_row' + store_row + '\').remove() : false;"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';

	$('#exchange1c_store_id tbody').append(html);

	store_row++;
}


var property_row = <?php echo $property_row ?>;
var property = [];
function addProperty() {
	html = '<tr id="exchange1c_property_row' + property_row + '">';
	html += '<td class="col-sm-1 text-left" id="property_index' + property_row + '">' + property[property_row] + '</td>';
	html += '<td class="col-sm-2 text-left"><input class="form-control" type="text" name="exchange1c_properties[' + property_row + '][name]" value="" /></td>';
	html += '<td class="col-sm-5 text-left"><input class="form-control" type="text" name="exchange1c_properties[' + property_row + '][template]" value="" /></td>';
	html += '<td class="text-left"><select class="form-control" name="exchange1c_properties[' + property_row + '][product_field_name]" onchange="changeProductField(' + property_row + ', this.options[this.selectedIndex].value)">';
<?php foreach ($product_fields as $field_name => $description) { ?>
	html += '<option value="<?php echo $field_name ?>"><?php echo $description ?></option>';
<?php } ?>
	html += '</select></td>';
	html += '<td class="text-center"><input type="checkbox" name="exchange1c_properties[' + property_row + '][import]" checked></td>';
	html += '<td class="text-center"><button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm(\'<?php echo $lang['text_confirm']; ?>\') ? $(\'#exchange1c_property_row' + property_row + '\').remove() : false; property_row--;"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';

	$('#exchange1c_property tbody').append(html);
	property_row++;

<?php foreach ($product_fields as $field_name => $description) { ?>
	changeProductField(property_row-1, '<?php echo $field_name ?>');
<?php break; ?>
<?php } ?>
}


function changeProductField(row, value) {
	$('#property_index'+row).text(value);
}


var order_delivery_row = <?php echo $order_delivery_row ?>;
function addOrderDelivery() {
	html = '<tr id="exchange1c_order_delivery_row' + order_import_row + '">';
	html += '<td class="text-left"><select class="form-control" name="exchange1c_order_delivery[' + order_delivery_row + '][delivery_id]">';
<?php foreach ($order_types_of_delivery as $delivery_id => $name) { ?>
	html += '<option value="<?php echo $delivery_id ?>"><?php echo $name ?></option>';
<?php } ?>
	html += '<td class="text-left">';
	html += '<div><input class="form-control" type="text" name="exchange1c_order_delivery[' + order_delivery_row + '][delivery_service_name]"></div>';
	html += '</td>';
	html += '<td class="text-center"><button type="button" data-toggle="tooltip" title="<?php echo $lang['button_remove']; ?>" class="btn btn-danger" onclick="confirm(\'<?php echo $lang['text_confirm']; ?>\') ? $(\'#exchange1c_order_delivery_row' + order_delivery_row + '\').remove() : false; order_delivery_row--;"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';

	$('#orders_delivery tbody').append(html);
	order_delivery_row++;
}


function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $lang['text_image_manager']; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};


function checkOptionSynchronize_by_code() {

	var val = $('input[name="exchange1c_synchronize_by_code"]:checked').val();
	if (val == 1) {
		$('select[name="exchange1c_synchronize_new_product_by"]').attr('disabled', 'disabled');
	} else {
		$('select[name="exchange1c_synchronize_new_product_by"]').attr('disabled', null);
	}

} // checkOptionSynchronize_by_code()


function checkOptionImport_product_name() {
	var val = $('select[name="exchange1c_import_product_name"]').val();
	if (val == "manually") {
		//$('div#import_product_name_field').css("visibility", 'visible');
		$('div#import_product_name_field_select').append('<div id="import_product_name_field"><?php echo $html_import_product_name_field ?></div');
	} else {
		//$('div#import_product_name_field').css("visibility", 'hidden');
		$('div#import_product_name_field').remove();
	}

} // checkOptionImport_product_name()


$('input[name="exchange1c_synchronize_by_code"]').change(function(){
	checkOptionSynchronize_by_code();
})


$('select[name="exchange1c_import_product_name"]').change(function(){
	checkOptionImport_product_name();
});

$(document).ready(function() {
	checkOptionSynchronize_by_code();
	checkOptionImport_product_name();
});

//--></script>

<?php echo $footer; ?>

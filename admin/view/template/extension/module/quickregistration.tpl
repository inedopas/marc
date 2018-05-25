<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success"><i class="fa fa-save"></i></button>
        <a onclick="$('#form').attr('action', '<?php echo $continue; ?>');$('#form').submit();" data-toggle="tooltip" title="<?php echo $button_continue; ?>" class="btn btn-primary"><i class="fa fa-check"></i></a>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	<?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>&ensp;
        <i class="fa fa-pencil"></i> <?php echo $entry_store; ?> 
	<select onchange="store();" name="store_id">
            <option value="0"<?php echo $store_id == 0 ? ' selected="selected"' : ''; ?>><?php echo $text_default_store; ?></option>
            <?php foreach ($stores as $store) { ?>
            <option value="<?php echo $store['store_id']; ?>"<?php echo $store_id == $store['store_id'] ? ' selected="selected"' : ''; ?>><?php echo $store['name']; ?></option>
            <?php } ?>
	</select>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
		  <ul class="nav nav-tabs">
			<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
			<li><a href="#tab-field" data-toggle="tab"><?php echo $tab_field; ?></a></li>
			<li><a href="#tab-info" data-toggle="tab"><i class="fa fa-lightbulb-o"></i> <?php echo $tab_info; ?></a></li>
                  </ul>
		  <div class="tab-content">
                      
            <div class="tab-pane active" id="tab-general">
                                            <h4><img src = "view/image/warning.png" height="22"> Module works in DEMO mode. All features are available in the <a href="https://tobiksoft.com/quick-registration-pro"> FULL VERSION <img src="view/image/pro.png" height="22" ></a></h4>
                        <legend>Main</legend>
			  <div class="row">
			    <div class="form-group col-sm-6">
                                <label class="col-sm-4 control-label" for="input-status"><span title="<?php echo $help_status; ?>" data-toggle="tooltip"><?php echo $entry_status; ?></span></label>
				  <div class="col-sm-8">
                                    <div align="center" class="onoffswitch">

                                        <input type="checkbox" name="quickregistration_status" class="onoffswitch-checkbox" id="quickregistration_status" value="1" <?php echo ($quickregistration_status == '1') ? 'checked="checked"' : '' ; ?>  >
                                        <label class="onoffswitch-label" for="quickregistration_status">
                                            <span class="onoffswitch-inner"></span>
                                            <span class="onoffswitch-switch"></span>
                                        </label>
                                    </div>
				  </div>
				</div>

			    <div class="form-group col-sm-6">
				  <label class="col-sm-4 control-label" for="input-proceed-button-text"><span title="<?php echo $help_proceed_button_text; ?>" data-toggle="tooltip"><?php echo $entry_proceed_button_text; ?></span></label>
				  <div class="col-sm-8">
					<?php foreach ($languages as $language) { ?>
					  <div class="input-group">
						<span class="input-group-addon"><img src="<?php echo version_compare(VERSION, '2.2.0.0', '<') ? 'view/image/flags/' . $language['image'] : 'language/' . $language['code'] . '/' . $language['code'] . '.png'; ?>" title="<?php echo $language['name']; ?>" /></span>
						<input type="text" name="quickregistration_proceed_button_text[<?php echo $language['language_id']; ?>]" value="<?php echo !empty($quickregistration_proceed_button_text[$language['language_id']]) ? $quickregistration_proceed_button_text[$language['language_id']] : ''; ?>" class="form-control" />
					  </div>
					<?php } ?>
				  </div>
                            </div>
			  </div>

                        <legend>Custom HTML (for advanced users)</legend>
			  <div class="row">
				<div class="form-group col-sm-6">
				  <label class="col-sm-4 control-label" for="input-html-header"><span title="<?php echo $help_html_header; ?>" data-toggle="tooltip"><?php echo $entry_html_header; ?></span></label>
				  <div class="col-sm-8">
					<?php foreach ($languages as $language) { ?>
					  <div class="input-group">
						<span class="input-group-addon"><img src="<?php echo version_compare(VERSION, '2.2.0.0', '<') ? 'view/image/flags/' . $language['image'] : 'language/' . $language['code'] . '/' . $language['code'] . '.png'; ?>" title="<?php echo $language['name']; ?>" /></span>
						<textarea name="quickregistration_html_header[<?php echo $language['language_id']; ?>]" rows="4" cols="30" class="form-control"><?php echo !empty($quickregistration_html_header[$language['language_id']]) ? $quickregistration_html_header[$language['language_id']] : ''; ?></textarea>
					  </div>
					<?php } ?>
				  </div>
				</div>
				<div class="form-group col-sm-6">
				  <label class="col-sm-4 control-label" for="input-html-footer"><span title="<?php echo $help_html_footer; ?>" data-toggle="tooltip"><?php echo $entry_html_footer; ?></span></label>
				  <div class="col-sm-8">
					<?php foreach ($languages as $language) { ?>
					  <div class="input-group">
						<span class="input-group-addon"><img src="<?php echo version_compare(VERSION, '2.2.0.0', '<') ? 'view/image/flags/' . $language['image'] : 'language/' . $language['code'] . '/' . $language['code'] . '.png'; ?>" title="<?php echo $language['name']; ?>" /></span>
						<textarea name="quickregistration_html_footer[<?php echo $language['language_id']; ?>]" rows="4" cols="30" class="form-control"><?php echo !empty($quickregistration_html_footer[$language['language_id']]) ? $quickregistration_html_footer[$language['language_id']] : ''; ?></textarea>
					  </div>
					<?php } ?>
				  </div>
				</div>
			  </div>

                            <legend>Custom CSS (for advanced users)</legend>
                              <div class="row">
				<div class="form-group col-sm-12">
				  <label class="col-sm-2 control-label" for="input-custom-css"><?php echo $entry_custom_css; ?></label>
				  <div class="col-sm-10">
				    <textarea name="quickregistration_custom_css" id="input-custom-css" class="form-control" rows="5"><?php echo $quickregistration_custom_css; ?></textarea>
				  </div>
				</div>
                              </div>
			</div>
                      
			<div class="tab-pane table-responsive" id="tab-field">
                    
                            <h4><img src = "view/image/warning.png" height="22"> Module works in DEMO mode. All features are available in the <a href="https://tobiksoft.com/quick-registration-pro"> FULL VERSION <img src="view/image/pro.png" height="22" ></a></h4>
                            
                          <legend>Registration Fields</legend>

                          
                          
                          
			  <table class="table table-bordered table-hover table-striped">
				<tr>
				  <td></td>
				  <td class="text-center"><?php echo $text_display; ?></td>
				  <td class="text-center"><?php echo $text_required; ?></td>
				  <td><?php echo $text_presets; ?></td>
				</tr>
				<?php foreach ($fields as $field) { ?>
				  <?php if ($field == 'country') { ?>
				  <tr>
					<td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></span></td>
                                        
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                            <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                            </div></span>
                                        </td>
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                                <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[required]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[required]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['required']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[required]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                                </div></span>
                                        </td>
                                        <td>
                                         <div class="row reg-fields">
                                          <div class="col-sm-4 reg-field"><?php echo $text_default; ?></div>
                                          <div class="col-sm-8"><select name="quickregistration_field_<?php echo $field; ?>[default]" class="form-control">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($countries as $country) { ?>
						  <?php if (!empty(${'quickregistration_field_' . $field}['default']) && ${'quickregistration_field_' . $field}['default'] == $country['country_id']) { ?>
						  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
						  <?php } ?>
						<?php } ?>
					  </select></div>
                                         </div>
                                        </td>
				  </tr>
                                  <?php } elseif ($field == 'email') { ?>
				  <tr>
					<td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></span></td>
                                        
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                            <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> onclick="return false" >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                            </div></span>
                                        </td>
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                            <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[required]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[required]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['required']) ? ' checked' : ''; ?> onclick="return false" >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[required]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                            </div></span>
                                        </td>
                                        <td>
                                         <div class="row reg-fields">
                                          <div class="col-sm-4 reg-field"><?php echo $text_placeholder; ?></div>
                                          <div class="col-sm-8"><input type="text" name="quickregistration_field_<?php echo $field; ?>[placeholder]" value="<?php echo !empty(${'quickregistration_field_' . $field}['placeholder']) ? ${'quickregistration_field_' . $field}['placeholder'] : ''; ?>" class="form-control" /></div>
                                         </div>
                                        </td>
				  </tr>
				  <?php } elseif ($field == 'zone') { ?>
				  <tr>
                                      <td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></span></td>
                                        
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                            <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                            </div></span>
                                        </td>
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                            <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[required]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[required]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['required']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[required]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                            </div></span>
                                        </td>
                                        <td class="text-center"></td>
				  </tr>
				  <?php } elseif ($field == 'customer_group' || $field == 'address_text' || $field == 'details_text' || $field == 'password_text') { ?>
				  <tr>
                                      <td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></span></td>
					                                        
                                        <td align="center"><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">
                                            <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                            </div></span>
                                        </td>
					<td class="text-center"></td>
					<td class="text-center"></td>
				  </tr>
				  <?php } elseif ($field == 'newsletter') { ?>
				  <tr>
                                      <td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></span></td>
                                        
                                        <td align="center"><div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div>
                                        </td>
                                        <td align="center"><div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[required]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[required]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['required']) ? ' checked' : ''; ?> onclick="return false" >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[required]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div>
                                        </td>
                                        <td>
                                         <div class="row reg-fields">
                                          <div class="col-sm-4 reg-field"><?php echo $text_default; ?></div>
                                          <div class="col-sm-8 text-center"><input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[default]"<?php echo !empty(${'quickregistration_field_' . $field}['default']) ? ' checked' : ''; ?> /></div>
                                         </div>
                                        </td>
				  </tr>
				  <?php } elseif ($field == 'agree') { ?>
				  <tr>
					<td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></td></span>
                                        
                                        <td align="center"><div class="onoffswitch">
                                                  <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> onclick="return false" >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div>
                                        </td>
                                        <td align="center"><div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[required]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[required]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['required']) ? ' checked' : ''; ?> onclick="return false" >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[required]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div>
                                        </td>
                                        <td>
                                         <div class="row reg-fields">
                                          <div class="col-sm-4 reg-field"><?php echo $text_default; ?></div>
                                          <div class="col-sm-8 text-center"><input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[default]"<?php echo !empty(${'quickregistration_field_' . $field}['default']) ? ' checked' : ''; ?> /></div>
                                         </div>
                                        </td>
				  </tr>
				  <?php } else { ?>
				  <tr>
                                      <td><span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version."><?php echo ${'entry_field_' . $field}; ?></span></td>
                                        
                                         <td align="center"> <span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">                                  
                                        <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[display]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[display]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['display']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[display]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div></span>
                                    </td>
                                        
					<?php if ($field == 'postcode1') { ?>
					<td class="text-center">NA</td>
					<?php } else { ?>
                                        
                                         <td align="center">  <span data-toggle="tooltip" title="DEMO mode. This feature is available in the Full Version.">                                 
                                        <div class="onoffswitch">
                                            <input type="checkbox" name="quickregistration_field_<?php echo $field; ?>[required]" class="onoffswitch-checkbox" id="quickregistration_field_<?php echo $field; ?>[required]" value="1" <?php echo !empty(${'quickregistration_field_' . $field}['required']) ? ' checked' : ''; ?> >
                                            <label class="onoffswitch-label" for="quickregistration_field_<?php echo $field; ?>[required]">
                                                <span class="onoffswitch-inner"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div></span>
                                    </td>

					<?php } ?>
                                        <td>
                                         <div class="row reg-fields">
                                          <div class="col-sm-4 reg-field"><?php echo $text_placeholder; ?></div>
                                          <div class="col-sm-8"><input type="text" name="quickregistration_field_<?php echo $field; ?>[placeholder]" value="<?php echo !empty(${'quickregistration_field_' . $field}['placeholder']) ? ${'quickregistration_field_' . $field}['placeholder'] : ''; ?>" class="form-control" /></div>
                                         </div>
                                        </td>
				  </tr>
				  <?php } ?>
				<?php } ?>
			  </table>


			</div>
       
                      
                      
                      
                      
<div class="tab-pane" id="tab-info">
                                <h4><img src = "view/image/warning.png" height="22"> Module works in DEMO mode. All features are available in the <a href="https://tobiksoft.com/quick-registration-pro"> FULL VERSION <img src="view/image/pro.png" height="22" ></a></h4>
    <div class="accordion vertical">
        <ul>
		
            <li>
                <input type="checkbox" id="checkbox-16" name="checkbox-accordion" />
                <label for="checkbox-16" class="manuals">YOU WILL ALSO LIKE THIS</label>
                <div class="content">
                    <p><a href="https://tobiksoft.com/ts-quick-checkout"><img src="https://tobiksoft.com/market/image/ads/ads-quick-ch.jpg" height="250" ></a></p>
                    <p><a href="https://tobiksoft.com/quick-registration-pro"><img src="https://tobiksoft.com/market/image/ads/ads-quick-reg.jpg" height="250" ></a></p>
                    <p><a href="https://tobiksoft.com/ts-quick-registration-bundle"><img src="https://tobiksoft.com/market/image/ads/ads-quick-bundle.jpg" height="250" ></a></p>
                    <p><a href="https://tobiksoft.com/promo-stickers"><img src="https://tobiksoft.com/market/image/ads/ads-promo.jpg" height="250" ></a></p>
                </div>
            </li>
		
            <li>
                <input type="checkbox" id="checkbox-1" name="checkbox-accordion" />
                <label for="checkbox-1" class="manuals">Install</label>
                <div class="content">
                    <h3>Installation</h3>
                    <p><i class="fa fa-check-square-o"></i>  First You should to backup your Opencart site and database.</p>
                    <p><i class="fa fa-check-square-o"></i>  Unzip the archive.</p>
                    <p><i class="fa fa-check-square-o"></i>  Choose your version of Opencart.</p>
                    <p><i class="fa fa-check-square-o"></i>  Go to: Extensions - Extension installer - Upload your ocmod file (filename.ocmod.zip).</p>
                    <p><i class="fa fa-check-square-o"></i>  Go to: Extensions - Modifications - and click REFRESH button.</p>
                    <p><i class="fa fa-check-square-o"></i>  Goto admin of your shop and navigate to extensions - modules - "{TS} Quick Registration". And click Install button and then Edit.</p>
                    <p><i class="fa fa-check-square-o"></i>  Then press - Edit.</p>
                    <p><i class="fa fa-check-square-o"></i>  Fill all required license data and press "Activate" button.</p>
                    <p><i class="fa fa-check-square-o"></i>  Turn on the {TS} Quick Registration by click Status ON (General Tab). Set your own settings and press Save button. </p>
                    <p><i class="fa fa-check-square-o"></i>  Done.</p>
                </div>
            </li>
            <li>
                <input type="checkbox" id="checkbox-2" name="checkbox-accordion" />
                <label for="checkbox-2" class="manuals">Update</label>
                <div class="content">
                    <h3>Update</h3>
                    <p><i class="fa fa-check-square-o"></i>  First You should to backup your Opencart site and database.</p>
                    <p><i class="fa fa-check-square-o"></i>  Unzip the archive.</p>
                    <p><i class="fa fa-check-square-o"></i>  Choose your version of Opencart.</p>
                    <p><i class="fa fa-check-square-o"></i>  Unzip ocmod file (filename.ocmod.zip).</p>
                    <p><i class="fa fa-check-square-o"></i>  Copy all from 'upload' folder to your web-root folder.</p>
                    <p><i class="fa fa-check-square-o"></i>  Open and Save again settings of {TS} Quick Registration module.</p>
                    <p><i class="fa fa-check-square-o"></i>  Done.</p>
                </div>
            </li>
            <li>
                <input type="checkbox" id="checkbox-3" name="checkbox-accordion" />
                <label for="checkbox-3" class="manuals">Usage</label>
                <div class="content">
                    <h3>Usage</h3>
                    <p><i class="fa fa-check-square-o"></i>  Open settings of "{TS} Quick Registration" module. Setup each tab of settings how you need and press Save button.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-4" name="checkbox-accordion" />
                <label for="checkbox-4" class="manuals">Uninstall</label>
                <div class="content">
                    <h3>Uninstall</h3>
                    <p><i class="fa fa-check-square-o"></i>  Go to: extensions - modules - locate "{TS} Quick Registration" module and click Uninstall button.</p>
                    <p><i class="fa fa-check-square-o"></i>  Go to: Extensions - Modifications. Select "{TS} Quick Registration" - and click DELETE button.</p>
                    <p><i class="fa fa-check-square-o"></i>  Then click REFRESH button on same page.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-5" name="checkbox-accordion" />
                <label for="checkbox-5" class="manuals">How to change language</label>
                <div class="content">
                    <h3>How to change language</h3>
                    <p> By default language files are located: "admin/language/en-gb/module/quickregistration.php". You should modify them yourself. Changes will be shown on your website immediately.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-8" name="checkbox-accordion" />
                <label for="checkbox-8" class="manuals">What versions of OpenCart are supported?</label>
                <div class="content">
                    <h3>What versions of OpenCart are supported?</h3>
                    <p>This extension is compatible with version of Opencart from 2.0.0.0 till latest.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-12" name="checkbox-accordion" />
                <label for="checkbox-12" class="manuals">What isn’t covered by the support?</label>
                <div class="content">
                    <h3>What isn’t covered by the support?</h3>
                    <p>The support is limited to providing bug and issue support. We will not cover custom development and custom design.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-9" name="checkbox-accordion" />
                <label for="checkbox-9" class="manuals">How to open support ticket?</label>
                <div class="content">
                    <h3>How to open support ticket?</h3>
                    <p>Open a SUPPORT TICKET (www.Opencart.com -> page of module -> 'QUICK SUPPORT' button) with us for quick response. </p>
                    <p>Fill in the form and press 'Open a Ticket' button. We would need you to provide as much info as possible about the issue you are having. Right after this a member from our team will get in touch with you with an estimate.</p>    
                    <p>Your issue will be fixed in 48h.</p>
                    <p>Please do not comment in extension page for technical support. We CANNOT assist through the comments section due to the confidential data which you may be sharing with us.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-10" name="checkbox-accordion" />
                <label for="checkbox-10" class="manuals">What exactly do you mean by up to 48 hours?</label>
                <div class="content">
                    <h3>What exactly do you mean by up to 48 hours?</h3>
                    <p>The up to 48 hours guaranteed reply time means that our team will get back to any reported issue in up to 48 hours except (weekends and national holidays). Please mind that debugging an issue might sometimes take more than 48 hours in which case you will be notified.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-6" name="checkbox-accordion" />
                <label for="checkbox-6" class="manuals">How do I provide access to my site?</label>
                <div class="content">
                    <h3>How do I provide access to my site?</h3>
                    <p>In order to fix your issues we will need your web store admin + FTP credentials. Once we finish up the work you can change your credentials.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-7" name="checkbox-accordion" />
                <label for="checkbox-7" class="manuals">How are bugs fixed?</label>
                <div class="content">
                    <h3>How are bugs fixed?</h3>
                    <p>All troubleshooting and issues are fixed using OpenCart’s coding standards, which means that we will not modify your core, thus keeping everything crisp and clean.</p>
                </div>
            </li>

            <li>
                <input type="checkbox" id="checkbox-11" name="checkbox-accordion" />
                <label for="checkbox-11" class="manuals">How do you report finished work?</label>
                <div class="content">
                    <h3>How do you report finished work?</h3>
                    <p>After we finish up the work we will send you a report with the files that we changed.</p>
                </div>
            </li>

        </ul>
    </div>
</div>

                  </div>
		</form>
      </div>
    </div>
  </div>
</div>

<style type="text/css">
.form-group + .form-group {
	border: none;
}
</style>

<script type="text/javascript"><!--
function show(element) {
	$(element).tab('show');
	
	$('a[href=\'' + element + '\']').parent('li').siblings().removeClass('active');
	
	$('a[href=\'' + element + '\']').parent('li').addClass('active');
	
	return false;
}


$(document).ready(function() {
	$('.date').datetimepicker();
});

$('select[name=\'quickregistration_field_country[default]\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=extension/module/quickregistration/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',		
		success: function(json) {
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo !empty($quickregistration_field_zone['default']) ? $quickregistration_field_zone['default'] : ''; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'quickregistration_field_zone[default]\']').html(html);
		}
	});
});

$('select[name=\'quickregistration_field_country[default]\']').trigger('change');


function store() {
	location = 'index.php?route=extension/module/quickregistration&token=<?php echo $token; ?>&store_id=' + $('select[name=\'store_id\']').val();
}
//--></script>
<?php echo $footer; ?>
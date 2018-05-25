<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	   <a href="<?php echo $color_kits; ?>" data-toggle="tooltip" class="btn btn-default"><?php echo $button_edit_kits ?></a>
		<button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
	<?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-inline">

	
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_settings; ?></h3>
      </div>
      <div class="panel-body">
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <td class="text-left"><?php echo $text_descr_col ?></td>
			<td class="text-center"><?php echo $text_val_col ?></td>
   		</tr>
        </thead>
        <tbody>
		<?php foreach ($languages as $language) { ?>
		 <tr>
            <td class="text-left"><?php echo $text_title ?> - <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></td>
			<td class="text-center"><input type="text" name="color_kit[title][<?php echo $language['language_id']; ?>]" class="form-control" value="<?php echo isset($title[$language['language_id']]) ? $title[$language['language_id']] : ''; ?>" /></td>
   		</tr>
		<?php } ?>
        <tr>
            <td class="text-left"><?php echo $text_status_visibility ?></td>
			<td class="text-center"><input name="color_kit[name]" class="form-control" value="<?php echo $name ?>" style="width: 50px" /></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_limit_colors ?></td>
			<td class="text-center"><input name="color_kit[visible]" class="form-control" value="<?php echo $visible ?>" style="width: 50px" /></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_limit_colors_popup ?></td>
			<td class="text-center"><input name="color_kit[limit]" class="form-control" value="<?php echo $limit ?>" style="width: 50px"/></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_size ?></td>
			<td class="text-center"><input name="color_kit[width]" class="form-control" value="<?php echo $width ?>" style="width: 50px"/> <?php echo $text_width ?>
		<input name="color_kit[height]" class="form-control" value="<?php echo $height ?>" style="width: 50px"/> <?php echo $text_height ?></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_ico_size ?></td>
			<td class="text-center"><input name="color_kit[ico_width]" class="form-control" value="<?php echo $ico_width ?>" style="width: 50px"/> <?php echo $text_width ?>
	<input name="color_kit[ico_height]"  class="form-control"value="<?php echo $ico_height ?>" style="width: 50px"/> <?php echo $text_height ?></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_preview_size ?></td>
			<td class="text-center"><input name="color_kit[preview_width]" class="form-control" value="<?php echo $preview_width ?>" style="width: 50px"/> <?php echo $text_width ?>
	<input name="color_kit[preview_height]"  class="form-control"value="<?php echo $preview_height ?>" style="width: 50px"/> <?php echo $text_height ?></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_category_ico_size ?></td>
			<td class="text-center"><input name="color_kit[category_ico_width]" class="form-control" value="<?php echo $category_ico_width ?>" style="width: 50px"/> <?php echo $text_width ?>
	<input name="color_kit[category_ico_height]"  class="form-control"value="<?php echo $category_ico_height ?>" style="width: 50px"/> <?php echo $text_height ?></td>
   		</tr>
		<tr>
            <td class="text-left"><?php echo $text_enable_popup ?></td>
			<td class="text-center"><input name="color_kit[enable_popup]" class="form-control" value="<?php if(isset($enable_popup)){ echo $enable_popup; } else { echo '1';} ?>" style="width: 50px" /></td>
   		</tr>	
        </tbody>
      </table>
	  </div>
      </div>
    </div>
	
	<h2><?php echo $text_color_templates ?></h2>
	
	    <table id="option-value" class="table">
          <thead>
            <tr>
              <th><span class="required">*</span> <?php echo $text_entry_name; ?></th>
              <th><?php echo $text_entry_color; ?></th>
              <th><?php echo $entry_sort_order; ?></th>
              <td></td>
            </tr>
          </thead>	
		  
		  <?php $option_value_row = 0; ?>
		  <?php if(isset($color_options)) { ?>
			<?php foreach ($color_options as $option_value) { ?>
			<tbody id="option-value-row<?php echo $option_value_row; ?>">
            <tr>
              <td class="text-left"><input type="hidden" name="option_value[<?php echo $option_value_row; ?>][option_id]" value="<?php echo $option_value['option_id']; ?>" />
			     <?php foreach ($languages as $language) { ?>
				 <div class="input-group"><span class="input-group-addon">
                <img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" />
				</span>
				<input type="text" name="option_value[<?php echo $option_value_row; ?>][r_opt_description][<?php echo $language['language_id']; ?>][name]" class="form-control" value="<?php echo isset($option_value['r_opt_description'][$language['language_id']]) ? $option_value['r_opt_description'][$language['language_id']]['name'] : ''; ?>" />
                </div>
                <?php if (isset($error_option_value[$option_value_row][$language['language_id']])) { ?>
                <span class="error"><?php echo $error_option_value[$option_value_row][$language['language_id']]; ?></span>
                <?php } ?>
                <?php } ?>
				
			  </td>
			  
			<td class="text-left"><input class="input-colors form-control" style="height: 30px;" type="text" name="option_value[<?php echo $option_value_row; ?>][color]" value="<?php echo $option_value['color']; ?>" /></td>
			<td class="text-right"><input type="text" class="form-control" name="option_value[<?php echo $option_value_row; ?>][sort]" value="<?php echo $option_value['sort']; ?>" size="1" /></td>	
			<td class="text-left"><a onclick="$('#option-value-row<?php echo $option_value_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a></td>			
			</tr>  
			 </tbody> 
			 <?php $option_value_row++; ?>
			  <?php } ?>
			<tfoot>
            <tr>
              <td colspan="3"></td>
              <td class="text-right"><a onclick="addOption();" class="btn btn-info"><?php echo $button_add; ?></a></td>
            </tr>
          </tfoot>
			
		  <?php } ?>
		</table>  
		  
		
	  </form>
	</div>
  </div>


<script type="text/javascript"><!--
var option_value_row = <?php echo $option_value_row; ?>;

function addOption() {
	html  = '<tbody id="option-value-row' + option_value_row + '">';
	html += '  <tr>';	
    html += '    <td class="text-left"><input type="hidden" name="option_value[' + option_value_row + '][option_id]" value="" />';
	<?php foreach ($languages as $language) { ?>
	html += '<div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" /></span><input type="text" class="form-control" name="option_value[' + option_value_row + '][r_opt_description][<?php echo $language['language_id']; ?>][name]" value="" /></div>';
    <?php } ?>
	html += '</td>';
	html += '<td class="text-left"><input type="text" style="height: 30px;" class="input-colors form-control" name="option_value[' + option_value_row + '][color]" value="" /></td>';
	html += '<td class="text-right"><input type="text" class="form-control" name="option_value[' + option_value_row + '][sort]" value="" size="1" /></td>';
	html += '<td class="text-left"><a onclick="$(\'#option-value-row' + option_value_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a></td>';
	html += '</tr>';	
    html += '</tbody>';
	
	$('#option-value tfoot').before(html);
	addColor();
	option_value_row++;
}
function addColor() {
	$('.input-colors').each( function() {
		$(this).minicolors({
                    control: $(this).attr('data-control') || 'hue',
                    defaultValue: $(this).attr('data-defaultValue') || '',
                    inline: $(this).attr('data-inline') === 'true',
                    letterCase: $(this).attr('data-letterCase') || 'lowercase',
                    opacity: $(this).attr('data-opacity'),
                    position: $(this).attr('data-position') || 'top left',
                    change: function(hex, opacity) {
                        var log;
                        try {
                            log = hex ? hex : 'transparent';
                            if( opacity ) log += ', ' + opacity;
                            console.log(log);
                        } catch(e) {}
                    },
			theme: 'default'
		});
	});
}
//--></script> 
<script type="text/javascript"><!--
$(document).ready( function() {
addColor();
});
//--></script>
<?php echo $footer; ?>
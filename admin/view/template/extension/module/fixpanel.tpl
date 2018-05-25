<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-fixpanel" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
      
    <div class="content" id="fixpanel_content"> 
	
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-fixpanel" class="form-horizontal">
		<input type="hidden" name="fixpanel_name" value="Panel"/>
		<input type="hidden" name="fixpanel_status" id="input-status" class="form-control" value="1"/>
		<ul class="nav nav-tabs">
			<li><a href="#tab-main-settings" data-toggle="tab"><?php echo $text_main_setting ?></a><li>
			<li><a href="#tab-default-links" data-toggle="tab"><?php echo $text_default_links ?></a><li>
			<li><a href="#tab-custom-links" data-toggle="tab"><?php echo $text_custom_links ?></a><li>
			<li><a href="#tab-social-links" data-toggle="tab"><?php echo $text_soc_links ?></a><li>
			<li><a href="#tab-design" data-toggle="tab"><?php echo $text_design ?></a><li>
		</ul>
		<div class="tab-content">
		<div id="tab-main-settings" class="tab-pane active">
			<h3><?php echo $text_main_setting ?></h3>
			<p>
				<label><?php echo $text_phone; ?></label>
				<?php if ($phone) { ?>
					<input type="text" name="fixpanel[phone]" value="<?php echo $phone; ?>" class="form-control"/><br />
				<?php } else { ?>
					<input type="text" name="fixpanel[phone]" class="form-control"/><br />
				<?php } ?>
			</p>
			<p>
				<label><?php echo $text_add_phone; ?></label>
				<?php if ($add_phone) { ?>
					<input type="text" name="fixpanel[add_phone]" value="<?php echo $add_phone; ?>" class="form-control"/><br />
				<?php } else { ?>
					<input type="text" name="fixpanel[add_phone]" class="form-control"/><br />
				<?php } ?>
			</p>
			<p>
				<label><?php echo $text_address; ?></label>
				<?php if (isset($address)) { ?>
					<input type="text" name="fixpanel[address]" value="<?php echo $address; ?>" class="form-control"/><br />
				<?php } else { ?>
					<input type="text" name="fixpanel[address]" class="form-control"/><br />
				<?php } ?>
			</p>
			<p>
				<label><?php echo $text_map; ?></label>
				<?php if ($map) { ?>
					<input type="text" name="fixpanel[map]" value="<?php echo $map; ?>" class="form-control"/><br />
				<?php } else { ?>
					<input type="text" name="fixpanel[map]" class="form-control"/><br />
				<?php } ?>
			</p>
			<p>
				<label><?php echo $text_theme; ?></label>
				<?php if ($theme) { ?>
					 <select name="fixpanel[theme]" class="form-control">
						<option value="light"<?php if ($theme=='light') echo ('selected="selected"');?>><?php echo $text_light; ?></option>
						<option value="dark"<?php if ($theme=='dark') echo ('selected="selected"');?>><?php echo $text_dark; ?></option>
						<option value="minimalizm"<?php if ($theme=='minimalizm') echo ('selected="selected"');?>><?php echo $text_minimal; ?></option>
					 </select>
					 <?php } else { ?>
					 <select name="fixpanel[theme]" class="form-control">
						<option value="light" selected="selected"><?php echo $text_light; ?></option>
						<option value="dark"><?php echo $text_dark; ?></option>
						<option value="minimalizm"><?php echo $text_minimal; ?></option>
					 </select>			 
				 <?php } ?>
			</p>
			<p>
				<label><?php echo $text_position; ?></label>
				<?php if ($position) { ?>
					<select name="fixpanel[position]" class="form-control">
						<option value="top"<?php if ($position=='top') echo ('selected="selected"');?>><?php echo $text_position_top; ?></option>
						<option value="bottom"<?php if ($position=='bottom') echo ('selected="selected"');?>><?php echo $text_position_bottom; ?></option>
					</select>
				<?php } else { ?>
					<select name="fixpanel[position]" class="form-control">
						<option value="top" selected="selected"><?php echo $text_position_top; ?></option>
						<option value="bottom"><?php echo $text_position_bottom; ?></option>
					</select>			 
				<?php } ?>
			</p>
						
</div>	
		
<div id="tab-default-links" class="tab-pane">
	<h3><?php echo $text_default_links ?>
		<?php if ($oc_link==1) { ?>
			<input type="radio" name="fixpanel[oc_link]" id="ol_yes" value="1" checked="checked" />
			<?php echo $text_yes; ?>
			<input type="radio" name="fixpanel[oc_link]" id="ol_no" value="0" />
			<?php echo $text_no; ?>
		<?php } else { ?>
			<input type="radio" name="fixpanel[oc_link]" id="ol_yes" value="1" />
			<?php echo $text_yes; ?>
			<input type="radio" name="fixpanel[oc_link]" id="ol_no" value="0" checked="checked" />
			<?php echo $text_no; ?>
		<?php } ?>
	</h3>
	<div class="block_oc_link <?php if($oc_link==1){ ?>enabled<?php } else { ?>disabled<?php } ?>">
			<p>
			<label><?=$text_lk?></label>
				<?php if ($link_lk) { ?>
				  <input type="radio" name="fixpanel[link_lk]" value="1" checked="checked" />
				  <?php echo $text_yes; ?>
				  <input type="radio" name="fixpanel[link_lk]" value="0" />
				  <?php echo $text_no; ?>
				  <?php } else { ?>
				  <input type="radio" name="fixpanel[link_lk]" value="1" />
				  <?php echo $text_yes; ?>
				  <input type="radio" name="fixpanel[link_lk]" value="0" checked="checked" />
				  <?php echo $text_no; ?>
				  <?php } ?>
			</p>
			
			<p>
			<label><?=$text_cart?></label>
				<?php if ($link_cart) { ?>
				  <input type="radio" name="fixpanel[link_cart]" value="1" checked="checked" />
				  <?php echo $text_yes; ?>
				  <input type="radio" name="fixpanel[link_cart]" value="0" />
				  <?php echo $text_no; ?>
				  <?php } else { ?>
				  <input type="radio" name="fixpanel[link_cart]" value="1" />
				  <?php echo $text_yes; ?>
				  <input type="radio" name="fixpanel[link_cart]" value="0" checked="checked" />
				  <?php echo $text_no; ?>
				  <?php } ?>
			</p>
			
			<p>
			<label><?=$text_feedback?></label>
				<?php if ($link_feedback) { ?>
				  <input type="radio" name="fixpanel[link_feedback]" value="1" checked="checked" />
				  <?php echo $text_yes; ?>
				  <input type="radio" name="fixpanel[link_feedback]" value="0" />
				  <?php echo $text_no; ?>
				  <?php } else { ?>
				  <input type="radio" name="fixpanel[link_feedback]" value="1" />
				  <?php echo $text_yes; ?>
				  <input type="radio" name="fixpanel[link_feedback]" value="0" checked="checked" />
				  <?php echo $text_no; ?>
				  <?php } ?>
			</p>
	</div>
</div>

<div id="tab-custom-links" class="tab-pane">
	<div class="block_custom_link">
	<h3 id="title_custom"><?php echo $text_custom_links ?></h3>
		<table id="module" class="list table table-striped table-bordered table-hover">
			<thead>
				<tr>
				  <td class="left"><?php echo $entry_link; ?></td>
				  <td class="left"><?php echo $entry_image; ?></td>
				  <td class="left"><?php echo $entry_name; ?></td>
				  <td class="left"><?php echo $entry_sort_order; ?></td>
				  <td></td>
				</tr>
			</thead>
			<?php $module_row = 0; ?>
			<tbody>
			<?php foreach ($datal as $key => $value) { ?>
			<tr id="module-row<?php echo $module_row; ?>">
					<td class="text-left"><input type="text" name="fixpanel_custom[<?php echo $module_row; ?>][link]" value="<?php echo $value['link']; ?>" class="form-control" /></td>	
							
					<td class="text-center">
						<a href="" id="thumb<?php echo $module_row; ?>" data-toggle="image" class="img-thumbnail">
							<img src="/image/<?php echo $value['image']; ?>" alt="" title="" data-placeholder="/image/placeholder.png" width="24" height="24" class="img-thumbnail" />
						</a>
				        <input type="hidden" name="fixpanel_custom[<?php echo $module_row; ?>][image]" value="<?php echo $value['image']; ?>" id="image<?php echo $module_row; ?>" />
			        </td>

			<td class="left">				  
			<?php foreach ($languages as $language) { ?>
				<div class="input-group">
				    <span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>
				    <input type="text" name="fixpanel_custom[<?php echo $module_row; ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo isset($value['name'][$language['language_id']]) ? $value['name'][$language['language_id']] : ''; ?>" class="form-control"/>
				</div>
			<?php } ?>
			</td>				  
							  
					<td class="text-center" style="width: 10%;""><input type="text" name="fixpanel_custom[<?php echo $module_row; ?>][sort]" size="2" value="<?php echo $value['sort']; ?>" class="form-control"/></td>
					<td class="text-left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a></td>
					
				</tr>

			<?php $module_row++; ?>
			<?php } ?>

			</tbody>
					  <tfoot>
			            <tr>
			              <td colspan="4"></td>
						  <td class="left"><a onclick="addlink();" class="btn btn-success"><i class="fa fa-plus-circle"></i></a></td>
					</tfoot>
			</table>
	</div>		
</div>	


<div id="tab-social-links" class="tab-pane">
		<h3><?php echo $text_soc_links; ?></h3>
			
		<p>	
		<label><?php echo $text_soc_link_vk; ?></label>
			<?php if ($link_vk) { ?>
				<input type="text" name="fixpanel[link_vk]" value="<?php echo $link_vk; ?>" class="form-control"/><br />
			<?php } else { ?>
				<input type="text" name="fixpanel[link_vk]" class="form-control"/><br />
			<?php } ?>
		</p>
		<p>	
		<label><?php echo $text_soc_link_fb; ?></label>
			<?php if ($link_fb) { ?>
				<input type="text" name="fixpanel[link_fb]" value="<?php echo $link_fb; ?>" class="form-control"/><br />
			<?php } else { ?>
				<input type="text" name="fixpanel[link_fb]" class="form-control"/><br />
			<?php } ?>
		</p>
		<p>	
		<label><?php echo $text_soc_link_tw; ?></label>
			<?php if ($link_tw) { ?>
				<input type="text" name="fixpanel[link_tw]" value="<?php echo $link_tw; ?>" class="form-control"/><br />
			<?php } else { ?>
				<input type="text" name="fixpanel[link_tw]" class="form-control"/><br />
			<?php } ?>
		</p>
		<p>	
		<label><?php echo $text_soc_link_gp; ?></label>
			<?php if ($link_gp) { ?>
				<input type="text" name="fixpanel[link_gp]" value="<?php echo $link_gp; ?>" class="form-control"/><br />
			<?php } else { ?>
				<input type="text" name="fixpanel[link_gp]" class="form-control"/><br />
			<?php } ?>
		</p>
		<p>	
		<label><?php echo $text_soc_link_inst; ?></label>
			<?php if ($link_inst) { ?>
				<input type="text" name="fixpanel[link_inst]" value="<?php echo $link_inst; ?>" class="form-control"/><br />
			<?php } else { ?>
				<input type="text" name="fixpanel[link_inst]" class="form-control"/><br />
			<?php } ?>
		</p>
</div>
<div id="tab-design" class="tab-pane">
		<h3><?php echo $text_design; ?></h3>
		<p>
			<label>Цвет ссылок</label> <input name="fixpanel[color_links]" class="input-colors form-control" type="text" data-control="hue" style="height: 28px;" value="<?php echo ($color_links) ? $color_links : '#ffffff' ; ?>" />
		</p><p>	
			<label>Цвет ссылок при наведении</label> <input name="fixpanel[color_links_h]" class="input-colors form-control" type="text" style="height: 28px;" data-control="hue" value="<?php echo ($color_links_h) ? $color_links_h : '#ffffff' ; ?>" />
		</p><p>	 
			<label>Цвет телефона</label> <input name="fixpanel[color_phone]" class="input-colors form-control" type="text" data-control="hue" style="height: 28px;" value="<?php echo ($color_phone) ? $color_phone : '#ffffff' ; ?>" />
		</p><p>
			<label>Фон</label> <input name="fixpanel[color_back]" class="input-colors form-control" type="text" data-control="hue" style="height: 28px;" value="<?php echo ($color_back) ? $color_back : '#ffffff' ; ?>" />
		</p><p>
			<label>Цвет рамок</label> <input name="fixpanel[color_border]" class="input-colors form-control" type="text" data-control="hue" style="height: 28px;" value="<?php echo ($color_border) ? $color_border : '#ffffff' ; ?>" />
		</p>

</div>

	</div>
	  </form>
    </div>
  </div>
</div>



<script type="text/javascript">
var module_row = <?php echo $module_row; ?>;

function addlink() {	

	html  = '<tr id="module-row' + module_row + '">';
	html += '<td class="text-left"><input type="text" name="fixpanel_custom[' + module_row + '][link]" placeholder="/link" class="form-control" /></td>';	

	html += '<td class="text-center"><a href="" id="thumb' + module_row + '" data-toggle="image" class="img-thumbnail"><img width="24" height="24" src="/image/placeholder.png" alt="" title="" data-placeholder="/image/placeholder.png" class="img-thumbnail" /></a><input type="hidden" name="fixpanel_custom[' + module_row + '][image]" value="" id="image' + module_row + '" /></td>';

	html += '<td class="text-left">';
	<?php foreach ($languages as $language) { ?>
		html  += '<div id="language-'+ module_row + '-<?php echo $language['language_id']; ?>"><div class="input-group"><span class="input-group-addon"><img src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" /></span>';
		html  += '<input type="text" name="fixpanel_custom[' + module_row + '][name][<?php echo $language['language_id']; ?>]" class="form-control"></div></div>';
	<?php } ?>
	html += '</td>';
	
	html += '<td class="text-center"><input type="text" name="fixpanel_custom[' + module_row + '][sort]" size="2" value="0" class="form-control" /></td>';
	html += '<td class="text-left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a></td>';
	
	html += '</tr>';
	
	$('#module tbody').append(html);
	
	module_row++;
}
</script> 

<script>
$(document).ready(function(){

	<?php if($oc_link==1){ ?>
		$('#ol_yes').click();
	<?php } ?>
     
	$('#ol_yes').change(function(){
        $('.block_oc_link').removeClass('disabled');
		$('.block_oc_link').addClass('enabled');
	});
	$('#ol_no').change(function(){
		$('.block_oc_link').removeClass('enabled');
		$('.block_oc_link').addClass('disabled');
	});

})
</script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" width="24px" height="24px" id="' + thumb + '" />');
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
//--></script> 

<script type="text/javascript"><!--

$(document).ready( function() {
            $('.input-colors').each( function() {

                $(this).minicolors({
                    control: $(this).attr('data-control') || 'hue',
                    defaultValue: $(this).attr('data-defaultValue') || '',
                    inline: $(this).attr('data-inline') === 'true',
                    letterCase: $(this).attr('data-letterCase') || 'lowercase',
                    opacity: $(this).attr('data-opacity'),
                    position: $(this).attr('data-position') || 'bottom left',
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

        });
//--></script>
<?php echo $footer; ?>
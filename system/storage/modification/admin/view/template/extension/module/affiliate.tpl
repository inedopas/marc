<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-affiliate" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-affiliate" class="form-horizontal">

      <?php  
        if (file_exists(DIR_TEMPLATE.'module/affiliate_settings.tpl')) {
          require_once(DIR_TEMPLATE.'module/affiliate_settings.tpl');
        } 
      ?>
            

      <table class="table table-bordered">
      <tr>
          <td class="right"><?php echo $entry_customer_lifetime; ?> </br>
        <select name="affiliate_customer_lifetime">
                <?php if ($affiliate_customer_lifetime) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?></td>
          <td><?php echo $entry_product_commission; ?></br>
        <select name="affiliate_product_commission">
                <?php if ($affiliate_product_commission) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?></td>
      </tr>
      </table>
      <table id="level" class="table table-bordered table-hover">
        <thead>
        <tr>
          <td class="left"><?php echo $entry_affiliate_level; ?></td>
          <td class="left"><?php echo $entry_affiliate_commission; ?></td>
          <td class="left"><?php echo $entry_affiliate_count; ?></td>
          <td></td>
        </tr>
        </thead>
        <?php $level_row = 1; ?>
        <?php foreach ($levels as $level) { ?>
        <tbody id="level-row<?php echo $level_row; ?>">
        <tr>
          <td class="left">
            <input type="text" name="affiliate_level_commission[<?php echo $level_row; ?>][level_id]" value="<?php echo $level['level_id']; ?>" size="3" />
          </td>
          <td class="left">
            <input type="text" name="affiliate_level_commission[<?php echo $level_row; ?>][level_commission]" value="<?php echo $level['level_commission']; ?>" size="3" />
          </td>
          <td class="left">
            <input type="text" name="affiliate_level_commission[<?php echo $level_row; ?>][level_affiliate]" value="<?php echo $level['level_affiliate']; ?>" size="3" />
          </td>
          <td class="left"><a onclick="$('#level-row<?php echo $level_row; ?>').remove();" data-original-title="Delete" type="button" data-toggle="tooltip" title="" class="btn btn-danger"><i class="fa fa-trash-o"></a></td>
        </tr>
        </tbody>
        <?php $level_row++; ?>
        <?php } ?>
         <tfoot>
        <tr>
          <td colspan="3"></td>
          <td class="left"><a onclick="addLevel();" data-original-title="<?php echo $button_add_level; ?>" data-toggle="tooltip" title="" class="btn btn-primary" ><i class="fa fa-plus"></i></a></td>
        </tr>
        </tfoot>
      </table>
      
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="affiliate_status" id="input-status" class="form-control">
                <?php if ($affiliate_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
var level_row = <?php echo $level_row; ?>;

function addLevel() {  
  html  = '<tbody id="level-row' + level_row + '">';
  html += '  <tr>';
  html += '   <td class="left"> <input type="text" name="affiliate_level_commission[' + level_row + '][level_id]" value="'+level_row+'" size="3" /></td>';
  html += '   <td class="left"> <input type="text" name="affiliate_level_commission[' + level_row + '][level_commission]" value="5" size="3" /></td>';
  html += '   <td class="left"> <input type="text" name="affiliate_level_commission[' + level_row + '][level_affiliate]" value="0" size="3" /></td>';
  html += '    <td class="left"><a onclick="$(\'#level-row' + level_row + '\').remove();" data-original-title="Delete" type="button" data-toggle="tooltip" title="" class="btn btn-danger"><i class="fa fa-trash-o"></a></td>';
  html += '  </tr>';
  html += '</tbody>';
    
  $('#level tfoot').before(html);
  
  level_row++;
}
//--></script> 

<?php echo $footer; ?>
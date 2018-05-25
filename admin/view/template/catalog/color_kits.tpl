<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	   <a href="<?php echo $kits_auto; ?>" class="btn btn-default" role="button"><?php echo $button_auto ?></a>
	  <a href="<?php echo $color_list; ?>" class="btn btn-default" role="button"><?php echo $button_color_list; ?></a>
	  <a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
        <ul class="breadcrumb">
			<li><a href="index.php?route=extension/module/colors&token=<?php echo $token; ?>">Назад</a></li>
      </ul>
	  
   <div class="panel panel-default">

    <div class="panel-body">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="table table-striped">
          <thead>
            <tr>
			<th width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></th>
              <th><?php if ($sort == 'ck.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_kits; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_kits; ?></a>
                <?php } ?></th>
              <th><a href="<?php echo $sort_tpl; ?>"><?php echo $column_tpl; ?></a></th>
              <th><a href="<?php echo $sort_name; ?>"><?php echo $column_status; ?></a></th>
              <th><?php echo $column_action; ?></th> 
            </tr>
            <tr class="filter">
              <td></td>
              <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" class="form-control"/></td>
              <td colspan="3"><a onclick="filter();" class="btn btn-default"><?php echo $text_search; ?></a></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($color_kits)) { ?>
            <?php foreach ($color_kits as $color_kit) { ?>
            <tr>
			  <td><input type="checkbox" name="selected[]" value="<?php echo $color_kit['color_kit_id']; ?>" class="form-control"/></td>
              <td><strong><?php echo $color_kit['name']; ?></strong></td>
              <td><strong><?php echo $color_kit['tpl']; ?></strong></td>
              <td>
			  <button type="button" class="btn btn-<?php if($color_kit['status'] == 1){ ?>success<?php } else { ?>default<?php }?> btn-sm"><?php echo $color_kit['status']; ?></button>
			  </td>
              <td><?php foreach ($color_kit['action'] as $action) { ?>
               <a href="<?php echo $action['href']; ?>"  class="btn btn-primary btn-sm" role="button"><?php echo $action['text']; ?></a>
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script>
    function filter() {
      var url = 'index.php?route=catalog/color_kits&token=<?php echo $token; ?>';
      var filter_name = $('[name=\'filter_name\']').val();

      if (filter_name) {
        url += '&filter_name=' + encodeURIComponent(filter_name);
      }

      location = url;
    }
</script>
<?php echo $footer; ?>
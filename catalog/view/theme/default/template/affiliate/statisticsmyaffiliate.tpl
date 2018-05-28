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
      <h1><?php echo $heading_title; ?></h1>
      <div class="panel-body">
        <div class="well">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label class="control-label" for="input-date-start"><?php echo $entry_date_start; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" placeholder="<?php echo $entry_date_start; ?>" data-format="YYYY-MM-DD" id="input-date-start" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <div class="form-group">
                <label class="control-label" for="input-date-end"><?php echo $entry_date_end; ?></label>
                <div class="input-group date">
                  <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" placeholder="<?php echo $entry_date_end; ?>" data-format="YYYY-MM-DD" id="input-date-end" class="form-control" />
                  <span class="input-group-btn">
                  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                  </span></div>
              </div>
              <div class="form-group">
				<button type="button" id="button-filter" class="btn btn-primary pull-left"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
				<div class="pull-right"><a data-original-title="Clear" onclick="clearvalue();" data-toggle="tooltip" title="" class="btn btn-danger"><i class="fa fa-eraser"></i></a></div>
              </div>
            </div>
          </div>
        </div>
	  </div>
        <div class="table-responsive">
			<table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr align="center">
						<td><?php echo $column_level; ?></td>
					    <td><?php echo $column_name; ?></td>
                        <td><?php echo $column_count_orders; ?></td>
                        <td><?php echo $column_count_shopping; ?></td>
                        <td><?php echo $column_sum_orders; ?></td>
                        <td><?php echo $column_sum_shopping; ?></td>
                        <td><?php echo $column_sum_credited; ?></td>
                    </tr>

                </thead>
                <tbody>
                    <?php if (isset($affiliates)) { ?>
				    <?php foreach ($affiliates as $affiliate) { ?>
                    <tr align="center">
						<td><?php echo $affiliate['level']; ?></td>
					    <td><?php echo $affiliate['affiliate']; ?></td>
                        <td><?php echo $affiliate['count_orders']; ?></td>
                        <td><?php echo $affiliate['count_shopping']; ?></td>
                        <td><?php echo $affiliate['sum_orders']; ?></td>
                        <td><?php echo $affiliate['sum_shopping']; ?></td>
                        <td><?php echo $affiliate['commission']; ?></td>
                    </tr>
					 <?php } ?>
                    <?php } else { ?>
                    <tr>
                        <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>
        <div class="buttons clearfix">
          <div class="pull-right"><a href="<?php echo $back; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
        </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script> 
<script type="text/javascript"><!--
function clearvalue() {
	url = 'index.php?route=affiliate/statisticsmyaffiliate';
	
        $('input[name=\'filter_date_start\']').val("");
		$('input[name=\'filter_date_end\']').val("");
	
	location = url;
}
//--></script> 
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=affiliate/statisticsmyaffiliate';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').val();
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').val();
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}

	location = url;
});
//--></script> 
<?php echo $footer; ?> 
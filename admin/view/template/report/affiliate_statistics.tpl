<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-bar-chart"></i> <?php echo $text_list; ?></h3>
      </div>
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
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label class="control-label" for="input-affiliate"><?php echo $entry_affiliate; ?></label>
                <input type="text" name="filter_affiliate" value="<?php echo $filter_affiliate; ?>" id="input-affiliate" class="form-control" />
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
        <div class="table-responsive">
          <table class="table table-bordered">
            <thead>
              <tr>
				<td class="left"><?php echo $column_affiliate; ?></td>
				<td class="left"><?php echo $column_email; ?></td>
				<td class="right"><?php echo $column_count_transitions; ?></td>
				<td class="right"><?php echo $column_count_orders; ?></td>
				<td class="right"><?php echo $column_count_shopping; ?></td>
				<td class="right"><?php echo $column_sum_orders; ?></td>
				<td class="right"><?php echo $column_sum_shopping; ?></td>
				<td class="right"><?php echo $column_sum_credited; ?></td>
				<td class="right"><?php echo $column_sum_paid; ?></td>
              </tr>
            </thead>
            <tbody>
			  <?php if ($affiliates) { ?>
			  <?php foreach ($affiliates as $affiliate) { ?>
			  <tr>
				<td class="left"><?php echo $affiliate['affiliate']; ?></td>
				<td class="left"><?php echo $affiliate['email']; ?></td>
				<td class="right"><?php echo $affiliate['count_transitions']; ?></td>
				<td class="right"><?php echo $affiliate['count_orders']; ?></td>
				<td class="right"><?php echo $affiliate['count_shopping']; ?></td>
				<td class="right"><?php echo $affiliate['sum_orders']; ?></td>
				<td class="right"><?php echo $affiliate['sum_shopping']; ?></td>
				<td class="right"><?php echo $affiliate['sum_credited']; ?></td>
				<td class="right"><?php echo $affiliate['sum_paid']; ?></td>
			  </tr>
			  <?php } ?>
			  <?php } else { ?>
              <tr>
                <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
	url = 'index.php?route=report/affiliate_statistics&token=<?php echo $token; ?>';
	
	var filter_affiliate = $('input[name=\'filter_affiliate\']').val();
	
	if (filter_affiliate) {
		url += '&filter_affiliate=' + encodeURIComponent(filter_affiliate);
	}
	
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
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});
//--></script></div>
<?php echo $footer; ?>
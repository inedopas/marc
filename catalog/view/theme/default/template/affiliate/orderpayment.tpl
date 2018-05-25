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
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal" id="orderpayment">
        <div class="table-responsive">
            <table class="table-striped table-hover">
                <tbody>
                    <tr>
                        <td><h2><?php echo $text_request_balanse; ?></h2></td>
                        <td class="text-right"><h2><?php echo $balance; ?></h2></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_request_payment; ?></td>

                        <td><span class="required">*</span><input type="text" name="request_payment" value="<?php
                                  if($error_min){
                                 if((double)$max_balance_double > (double)$request_payment){
                                       echo (double)$min_balance_double;
   							     } else { echo '0.00';}
                            }
                                  if($error_max){
                                        echo (double)$max_balance_double; 
                                  }
                                                                  ?>" /></td>
                        <td><?php echo $title_request_payment; ?></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <?php if($error_max) { ?> <td class="error"> <?php echo $error_max; ?> </td> <?php } ?> 
                        <?php if($error_min) { ?> <td class="error"> <?php echo $error_min; ?> </td> <?php } ?> 
                        <?php if($error_nil) { ?> <td class="error"> <?php echo $error_nil; ?> </td> <?php } ?> 
                    </tr>
                    <tr>
                        <td><?php echo $text_request_payment_history; ?></h2></td>
                        <td class="text-right"><?php echo $request_payment_history; ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="buttons clearfix">
          <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
          <div class="pull-right">
            <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" />
          </div>
        </div>
      </form>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
    $('input[name=\'orderpayment\']').bind('change', function() {
    $('.orderpayment').hide();
	
    $('#orderpayment-' + this.value).show();
});

$('input[name=\'orderpayment\']:checked').trigger('change');
//--></script> 
<?php echo $footer; ?> 
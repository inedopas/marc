<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-3'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div>
        <div class="panel panel-default share account-page-body">
          <div class="panel-heading panel-heading-gray title"><?php echo 'Здравствуйте '.$customer_info['firstname'].' !' ?></div>
          <div class="panel-body">
            <div class="row">
              <div class="col-sm-6 col-md-3">
                  <div class="panel panel-primary">
                      <div class="panel-heading">
                          <div class="row">
                              <div class="col-xs-3">
                                  <i class="fa fa-heart fa-4x"></i>
                              </div>
                              <div class="col-xs-9 text-right right-5">
                                  <div class="huge"><?php echo $total_wishlist ?></div>
                                  <div><?php echo $total_wish_list ?></div>
                              </div>
                          </div>
                      </div>
                      <a href="<?php echo $wishlist?>">
                          <div class="panel-footer">
                              <span class="pull-left"><?php echo $view_details ?></span>
                              <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                              <div class="clearfix"></div>
                          </div>
                      </a>
                  </div>
              </div>
              <div class="col-sm-6 col-md-3">
                  <div class="panel panel-green">
                      <div class="panel-heading">
                          <div class="row">
                              <div class="col-xs-3">
                                  <i class="fa fa-shopping-cart fa-4x"></i>
                              </div>
                              <div class="col-xs-9 text-right right-5">
                                  <div class="huge"><?php echo $order_total ?></div>
                                  <div><?php echo $total_order ?></div>
                              </div>
                          </div>
                      </div>
                      <a href="<?php echo $order ?>">
                          <div class="panel-footer">
                              <span class="pull-left"><?php echo $view_details ?></span>
                              <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                              <div class="clearfix"></div>
                          </div>
                      </a>
                  </div>
              </div>
              <div class="col-sm-6 col-md-6">
                  <div class="panel panel-red">
                      <div class="panel-heading">
                          <div class="row">
                              <div class="col-xs-3">
                                  <i class="fa fa-list-alt fa-4x"></i>
                              </div>
                              <div class="col-xs-9 text-right right-5">
                                  <div class="huge"><?php echo $orderproduct.' ('.$orderprice.')'; ?></div>
                                  <div><?php echo $order_product ?></div>
                              </div>
                          </div>
                      </div>
                      <a href="<?php echo $order ?>">
                          <div class="panel-footer">
                              <span class="pull-left"><?php echo $view_details ?></span>
                              <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                              <div class="clearfix"></div>
                          </div>
                      </a>
                  </div>
              </div>
            </div>
            <div class="row row-eq-height">
              <div class="col-sm-6">
                <div class="panel panel-default">
                    <div class="panel-heading"><?php echo $entry_profile ?></div>
                    <div class="panel-body">
                      <div><?php echo $entry_firstname.' : '.$customer_info['firstname'].' '.$customer_info['lastname'] ?></div>
                      <div><?php echo $entry_email.' : '.$customer_info['email'] ?></div>
                      <div><?php echo $entry_telephone.' : '.$customer_info['telephone'] ?></div>
                    </div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="panel panel-default">
                  <div class="panel-heading"><?php echo $title_address ?></div>
                  <div class="panel-body">
                    <address>
                      <?php echo $customer_info['address_1'] ?><br>
                      <?php echo $customer_info['address_2'] ?><br>
                      <?php echo $customer_info['city'].' - '.$customer_info['postcode'] ?>
                    </address>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="panel panel-default">
                <div class="panel-heading"><?php echo $text_order; ?></div>
                <div class="panel-body">
                  <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                      <thead>
                        <tr>
                          <td class="text-right"><?php echo $column_order_id; ?></td>
                          <td class="text-left"><?php echo $column_status; ?></td>
                          <td class="text-left"><?php echo $column_date_added; ?></td>
                          <td class="text-right"><?php echo $column_product; ?></td>
                          <td class="text-left"><?php echo $column_customer; ?></td>
                          <td class="text-right"><?php echo $column_total; ?></td>
                          <td></td>
                        </tr>
                      </thead>
                      <tbody>
                        <?php if($orders_info){
                          foreach ($orders_info as $order) { ?>
                          <tr>
                            <td class="text-right">#<?php echo $order['order_id']; ?></td>
                            <td class="text-left"><?php echo $order['status']; ?></td>
                            <td class="text-left"><?php echo $order['date_added']; ?></td>
                            <td class="text-right"><?php echo $order['products']; ?></td>
                            <td class="text-left"><?php echo $order['name']; ?></td>
                            <td class="text-right"><?php echo $order['total']; ?></td>
                            <td class="text-right"><a href="<?php echo $order['href']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></td>
                          </tr>
                          <?php }
                        }else{ ?>
                          <tr><td colspan="100%" class="text-center"><p><?php echo $text_empty; ?></p></td></tr>
                        <?php } ?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <?php echo $content_bottom; ?>
    </div>
    <div class="col-sm-3"> <?php echo $column_right; ?></div>
  </div>
</div>
<?php echo $footer; ?>
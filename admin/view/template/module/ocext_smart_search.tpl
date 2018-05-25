<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    
    <div class="page-header">
        <div class="container-fluid">
          <div class="pull-right">
              <a href="<?php echo $back; ?>" data-toggle="tooltip" title="<?php echo $button_back; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
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
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
              <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
            <?php if ($success) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
              <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-body">
                <ul class="nav nav-tabs" id="alltabs">
                    <li onclick="openTab('tab-statistic')" class="tab-statistic"><a href="#tab-statistic"  data-toggle="tab" ><?php echo $tab_statistic; ?></a></li>
                    <li onclick="openTab('tab-setting')" class="tab-setting"><a href="#tab-setting" data-toggle="tab" ><?php echo $tab_setting; ?></a></li>
                </ul>
                <div class="tab-content">
                    
                    
                    
                    <div class="tab-pane" id="tab-statistic">
                        
                        
            <form action="<?php echo $action_statistic; ?>" method="post" enctype="multipart/form-data" id="form-statistic">
                    <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <td class="center"><?php echo $column_id; ?></td>
                            <td class="center"><?php echo $column_keyword; ?></td>
                            <td class="center"><?php echo $column_used; ?></td>
                            <td class="center"><?php echo $column_index_elements; ?></td>
                            <td class="center"><?php echo $column_date_added; ?></td>
                            
                          </tr>
                        </thead>
                        <tbody>
                          <?php if ($smart_search_statistic) { ?>
                          <?php foreach ($smart_search_statistic as $statistic) { ?>
                          <tr>
                              <td><?php echo $statistic['id']; ?></td>
                              <td><?php echo $statistic[ 'keyword' ]; ?></td>
                              <td><?php echo $statistic['used']; ?></td>
                              <td><a target="_blank" href="/index.php?route=product/search&search=<?php echo $statistic[ 'keyword' ]; ?>"><?php echo $statistic['index_elements']; ?></a></td>
                              <td><?php echo $statistic['date_added']; ?></td>
                          </tr>
                          <?php } ?>
                          <?php } else { ?>
                          <tr>
                            <td class="center" colspan="10"><?php echo $text_no_results; ?></td>
                          </tr>
                          <?php } ?>
                        </tbody>
                      </table>
                    </div>
                    <div class="pagination"><?php echo $pagination; ?></div>
                
                </form>
                        
                        
                    </div> 
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    <div class="tab-pane" id="tab-setting">
                    <div class="table-responsive">
                    
                        <h3><?php echo $text_smart_search_status_general ?></h3>
                      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting"> 
                        <table class="table table-bordered table-hover">
                     <tr>
                                    <td><?php echo $text_smart_search_status; ?></td>
                                    <td>
                                        <select name="ocext_smart_search_status">
                                        <?php if ($ocext_smart_search_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                        </select>
                                    </td>
                                </tr>   
                                <tr>
                                    <td><?php echo $text_smart_search_strict_master_function; ?></td>
                                    <td>
                                        <select name="ocext_smart_search_strict_master_function">
                                        <?php if ($ocext_smart_search_strict_master_function) { ?>
                                        <option <?php if(isset($ocext_smart_search_strict_master_function[2000])){ ?> selected="selected" <?php } ?> value="2000" ><?php echo $text_smart_search_strict_master_function_2000; ?></option>
                                        <option <?php if(isset($ocext_smart_search_strict_master_function[1500])){ ?> selected="selected" <?php } ?> value="1500" ><?php echo $text_smart_search_strict_master_function_1500; ?></option>
                                        <option <?php if(isset($ocext_smart_search_strict_master_function[1000])){ ?> selected="selected" <?php } ?> value="1000" ><?php echo $text_smart_search_strict_master_function_1000; ?></option>
                                        <option <?php if(isset($ocext_smart_search_strict_master_function[500])){ ?> selected="selected" <?php } ?> value="500"><?php echo $text_smart_search_strict_master_function_500; ?></option>
                                        <?php } else { ?>
                                        <option value="2000"><?php echo $text_smart_search_strict_master_function_2000; ?></option>
                                        <option value="1500"><?php echo $text_smart_search_strict_master_function_1500; ?></option>
                                        <option value="1000"><?php echo $text_smart_search_strict_master_function_1000; ?></option>
                                        <option value="500" selected="selected"><?php echo $text_smart_search_strict_master_function_500; ?></option>
                                        <?php } ?>
                                        </select>
                                    </td>
                                </tr>
                                
                                
                                
                                
                                
                                
                        </table>  
                    <h3><?php echo $text_title_index_setting ?></h3>
                    
                    <table class="table table-bordered table-hover">
                        <tr>
                        <td><?php echo $text_smart_search_attribute; ?></td>
                        <td>
                              <select name="ocext_smart_search_attribute">
                                  <?php if ($ocext_smart_search_attribute) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        <tr>
                        <td><?php echo $text_smart_search_option; ?></td>
                        <td>
                              <select name="ocext_smart_search_option">
                                  <?php if ($ocext_smart_search_option) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        <tr>
                        <td><?php echo $text_smart_search_category; ?></td>
                        <td>
                              <select name="ocext_smart_search_category">
                                  <?php if ($ocext_smart_search_category) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        <tr>
                        <td><?php echo $text_smart_search_manufacturer; ?></td>
                        <td>
                              <select name="ocext_smart_search_manufacturer">
                                  <?php if ($ocext_smart_search_manufacturer) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        <tr>
                        <td><?php echo $text_ocext_smart_search_disable_prod; ?></td>
                        <td>
                              <select name="ocext_smart_search_disable_prod">
                                  <?php if ($ocext_smart_search_disable_prod) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        <tr>
                        <td><?php echo $text_ocext_smart_search_null_price; ?></td>
                        <td>
                              <select name="ocext_smart_search_null_price">
                                  <?php if ($ocext_smart_search_null_price) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_smart_search_count_relevant_result; ?></td>
                        <td>
                            <input type="text" name="ocext_smart_search_relevant_result" value="<?php echo $ocext_smart_search_relevant_result; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_smart_search_index_level; ?></td>
                        <td>
                              <select name="ocext_smart_search_index_level">
                                  <?php if ($ocext_smart_search_index_level) { ?>
                                    <option value="1" selected="selected"><?php echo $text_ocext_smart_search_index_level_1; ?></option>
                                    <option value="0"><?php echo $text_ocext_smart_search_index_level_0; ?></option>
                                  <?php } else { ?>
                                    <option value="1"><?php echo $text_ocext_smart_search_index_level_1; ?></option>
                                    <option value="0" selected="selected"><?php echo $text_ocext_smart_search_index_level_0; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_smart_search_review; ?></td>
                        <td>
                              <select name="ocext_smart_search_review">
                                  <?php if ($ocext_smart_search_review) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_status; ?></td>
                        <td>
                              <select name="ocext_ajax_status">
                                  <?php if ($ocext_ajax_status) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_products; ?></td>
                        <td>
                              <input type="text" name="ocext_ajax_products" value="<?php echo $ocext_ajax_products; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_products_price; ?></td>
                        <td>
                              <select name="ocext_ajax_products_price">
                                  <?php if ($ocext_ajax_products_price) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_products_image; ?></td>
                        <td>
                              <select name="ocext_ajax_products_image">
                                  <?php if ($ocext_ajax_products_image) { ?>
                                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                  <option value="0"><?php echo $text_disabled; ?></option>
                                  <?php } else { ?>
                                  <option value="1"><?php echo $text_enabled; ?></option>
                                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                  <?php } ?>
                              </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_products_category; ?></td>
                        <td>
                            <select name="ocext_ajax_products_category">
                                    <?php if ($ocext_ajax_products_category) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                            </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_category; ?></td>
                        <td>
                              <input type="text" name="ocext_ajax_category" value="<?php echo $ocext_ajax_category; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_text_calculate_products_categories; ?></td>
                        <td>
                              <select name="ocext_ajax_cal_prod_cat">
                                    <?php if ($ocext_ajax_cal_prod_cat) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                            </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_manufacturer; ?></td>
                        <td>
                              <input type="text" name="ocext_ajax_manufacturer" value="<?php echo $ocext_ajax_manufacturer; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_text_calculate_products_manufacturer; ?></td>
                        <td>
                              <select name="ocext_ajax_cal_prod_manuf">
                                    <?php if ($ocext_ajax_cal_prod_manuf) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
                            </select>
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_search_input; ?></td>
                        <td>
                              <input type="text" name="ocext_ajax_search_input" value="<?php echo $ocext_ajax_search_input; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_text_more_results; ?></td>
                        <td>
                              <input type="text" name="ocext_ajax_text_more_results_value" value="<?php echo $ocext_ajax_text_more_results_value; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_ocext_ajax_text_no_results; ?></td>
                        <td>
                              <input type="text" name="ocext_ajax_text_no_results_value" value="<?php echo $ocext_ajax_text_no_results_value; ?>" />
                        </td>
                        </tr>
                        
                        <tr>
                        <td><?php echo $text_smart_search_min_symbols; ?></td>
                        <td>
                            <input type="text" name="ocext_smart_search_min_symbols" value="<?php echo $ocext_smart_search_min_symbols; ?>" />
                        </td>
                        </tr>
                        <tr>
                            <td>
                              <a class="btn btn-primary" onclick="$('#form-setting').submit();" class="button"><?php echo $button_save; ?></a>
                            </td>
                            <td>

                            </td>
                        </tr>
                      </table>
                            </form>
                    <h3><?php echo $text_index_start ?></h3>
                         <form action="<?php echo $action_index; ?>" method="post" enctype="multipart/form-data" id="form-index">
                    
                
                    <table class="table table-bordered table-hover">
                        <tr>
                            <td>
                              <?php echo $text_smart_search_limit; ?> 
                            </td>
                            <td>
                                <input id="smart_search_limit" value="5" />
                            </td>
                        </tr>
                    <tr>
                            <td>
                              <?php echo $text_index_stat_total_index_keywords; ?>: <?php echo $total_index_keywords ?>  
                            </td>
                            <td>
                                <a class="btn btn-primary" onclick="setIndexSmartSearchAjax();" class="button"><?php echo $button_set_index; ?></a>
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="2">
                                <div id="ocext_notification_smart_search" class="alert alert-info" style="display:none"><i class="fa fa-info-circle"></i>
                                    <img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" />&nbsp;&nbsp;
                                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                                </div>
                            </td>
                        </tr>
                        
                      </table>
                             </form>
                        </div>
                        
                        <hr>
                        <?php if ((!$error_warning) && (!$success)) { ?>
                        <div id="ocext_notification" class="alert alert-info"><i class="fa fa-info-circle"></i>
                                <div id="ocext_loading"><img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /></div>
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                        </div>
                        <?php } ?>
                        
                    </div>
                
                
            </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript"><!--
    
    $(document).ready(function() {
        openTab('<?php echo $open_tab; ?>');
    });
    
    function openTab(tab){
        $('.tab-pane').hide();
        $('.nav-tabs li').removeClass('active');
        $('#'+tab).show();
        $('.'+tab).addClass('active');
        $('#'+tab).addClass('active');
    }
    
//--></script>
<script type="text/javascript"><!--
var start = 0;
var finished = 0;
var limit = 5;
var total = 0;
function setIndexSmartSearchAjax() {
        
        var self_limit = parseInt($('#smart_search_limit').val());
        if(self_limit!=0 && !isNaN(self_limit)){
            limit = self_limit;
        }
        if(start==0){
            $('#ocext_notification_smart_search').html('<i class="fa fa-info-circle"></i>&nbsp;&nbsp;<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /><button type="button" class="close" data-dismiss="alert">&times;</button>&nbsp;&nbsp;<?php echo $text_smart_search_finished ?>: <b><?php echo $text_smart_search_wite ?></b> / <b><?php echo $text_smart_search_wite ?></b> ');
            $('#ocext_notification_smart_search').show();
        }
	$.ajax({
            type: 'GET',
            url: 'index.php?route=module/ocext_smart_search/setIndexSmartSearch&limit='+limit+'&start='+start+'&token=<?php echo $token; ?>',
            dataType: 'json',
            success: function(json) {
                    if (json['error'] && json['error']!='') {
                            $('#ocext_notification_smart_search').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['error']);
                            $('#ocext_notification_smart_search').show();
                    } else {
                        finished = start + limit;
                        total = json['total'];
                        start = finished;
                        if(start<=total){
                            $('#ocext_notification_smart_search').html('<i class="fa fa-info-circle"></i>&nbsp;&nbsp;<img src="<?php echo HTTP_SERVER; ?>/view/image/ocext/loading.gif" /><button type="button" class="close" data-dismiss="alert">&times;</button>&nbsp;&nbsp;<?php echo $text_smart_search_finished ?>: <b>'+finished+'</b> / <b>'+total+'</b>');
                            $('#ocext_notification_smart_search').show();
                            setIndexSmartSearchAjax();
                        }else{
                            $('#ocext_notification_smart_search').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['message']);
                            $('#ocext_notification_smart_search').show();
                            finished = 0;
                            total = 0;
                            start = 0;
                        }
                    }
            },
            failure: function(){
                
            },
            error: function() {
                
            }
    });
}

function getNotifications() {
	$.ajax({
            type: 'GET',
            url: 'index.php?route=module/ocext_smart_search/getNotifications&token=<?php echo $token; ?>',
            dataType: 'json',
            success: function(json) {
                    if (json['error']) {
                            $('#ocext_notification').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['error']);
                    } else if (json['message'] && json['message']!='' ) {
                            $('#ocext_notification').html('<i class="fa fa-info-circle"></i><button type="button" class="close" data-dismiss="alert">&times;</button> '+json['message']);
                    }else{
                        $('#ocext_notification').remove();
                    }
            },
            failure: function(){
                    $('#ocext_notification').remove();
            },
            error: function() {
                    $('#ocext_notification').remove();
            }
    });
}
getNotifications();

//--></script> 
<?php echo $footer; ?>
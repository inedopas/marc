<?php if($coupon) { ?>
  <p><?php echo $text_coupon; ?></p>
<?php } ?>
<form class="form-horizontal">
  <div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
      <tbody>
        <tr>
          <td><?php echo $entry_code; ?></td>
          <td><?php echo $text_home_url; ?></td>
        </tr>
        <tr>
          <td>
            <textarea cols="40" rows="5" placeholder="<?php echo $entry_code; ?>" id="input-code" class="form-control"><?php echo $code; ?></textarea>
          </td>
          <td>
            <textarea cols="40" rows="5" placeholder="<?php echo $text_home_url; ?>" id="input-home_url" class="form-control"><?php echo $home; ?></textarea>
          </td>
        </tr>
        <tr>
          <td></td>
            <td>
<script type="text/javascript">(function() {
  if (window.pluso)if (typeof window.pluso.start == "function") return;
  if (window.ifpluso==undefined) { window.ifpluso = 1;
    var d = document, s = d.createElement('script'), g = 'getElementsByTagName';
    s.type = 'text/javascript'; s.charset='UTF-8'; s.async = true;
    s.src = ('https:' == window.location.protocol ? 'https' : 'http')  + '://share.pluso.ru/pluso-like.js';
    var h=d[g]('body')[0];
    h.appendChild(s);
  }})();</script>
<div class="pluso" data-background="transparent" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,facebook,twitter,google,moimir,email,print" data-url='<?php echo $home; ?>' data-title='<?php echo $name; ?>' data-image='<?php echo $logo; ?>' ></div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label" for="input-generator"><span data-toggle="tooltip" title="<?php echo $help_generator; ?>"><?php echo $entry_generator; ?></span></label>
    <div class="col-sm-10">
      <input type="text" name="product" value="" placeholder="<?php echo $entry_generator; ?>" id="input-generator" class="form-control" />
    </div>
  </div>
  <div class="form-group">
    <label class="col-sm-2 control-label" for="input-link"><?php echo $entry_link; ?></label>
    <div class="col-sm-10">
      <textarea name="link" cols="40" rows="5" placeholder="<?php echo $entry_link; ?>" id="input-link" class="form-control"></textarea>
    </div>
  </div>
  <?php if($affiliate_category_visible) { 
    if (file_exists(DIR_TEMPLATE.'default/template/affiliate/trackingproduct.tpl')) {
      require_once(DIR_TEMPLATE.'default/template/affiliate/trackingproduct.tpl');
    } 
  } ?>
</form>
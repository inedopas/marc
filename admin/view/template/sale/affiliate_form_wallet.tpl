<div class="col-sm-10">

  <?php if ($affiliate_bonus) { ?>
	  <div class="radio">
		<label>
		  <input type="radio" name="payment" value="bonus" id="bonus" <?php if ($payment == 'bonus') { ?> checked="checked" <?php } ?>/> <?php echo $text_bonus; ?>
		 </label>
	  </div>
  <?php } ?>
  
  <?php if ($affiliate_cheque) { ?>
	  <div class="radio">
		<label>
		  <input type="radio" name="payment" value="cheque" id="cheque" <?php if ($payment == 'cheque') { ?> checked="checked" <?php } ?>/> <?php echo $text_cheque; ?>
		 </label>
	  </div>
  <?php } ?>

  <?php if ($affiliate_paypal) { ?>
	  <div class="radio">
		<label>
		  <input type="radio" name="payment" value="paypal" id="paypal" <?php if ($payment == 'paypal') { ?> checked="checked" <?php } ?>/> <?php echo $text_paypal; ?>
		 </label>
	  </div>
  <?php } ?>
  
  <?php if ($affiliate_bank) { ?>
	  <div class="radio">
		<label>
		  <input type="radio" name="payment" value="bank" id="bank" <?php if ($payment == 'bank') { ?> checked="checked" <?php } ?>/> <?php echo $text_bank; ?>
		 </label>
	  </div>
  <?php } ?>

  <?php if ($affiliate_qiwi) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="qiwi" id="qiwi" <?php if ($payment == 'qiwi') { ?> checked="checked" <?php } ?>/> <?php echo $text_qiwi; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_card) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="card" id="card" <?php if ($payment == 'card') { ?> checked="checked" <?php } ?>/> <?php echo $text_card; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_yandex) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="yandex" id="yandex" <?php if ($payment == 'yandex') { ?> checked="checked" <?php } ?>/> <?php echo $text_yandex; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wmr) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wmr" id="webmoney_wmr" <?php if ($payment == 'webmoney_wmr') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wmr; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wmz) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wmz" id="webmoney_wmz" <?php if ($payment == 'webmoney_wmz') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wmz; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wmu) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wmu" id="webmoney_wmu" <?php if ($payment == 'webmoney_wmu') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wmu; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wme) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wme" id="webmoney_wme" <?php if ($payment == 'webmoney_wme') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wme; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wmy) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wmy" id="webmoney_wmy" <?php if ($payment == 'webmoney_wmy') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wmy; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wmb) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wmb" id="webmoney_wmb" <?php if ($payment == 'webmoney_wmb') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wmb; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_webmoney_wmg) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="webmoney_wmg" id="webmoney_wmg" <?php if ($payment == 'webmoney_wmg') { ?> checked="checked" <?php } ?>/> <?php echo $text_webmoney_wmg; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_alert_pay) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="alert_pay" id="alert_pay" <?php if ($payment == 'alert_pay') { ?> checked="checked" <?php } ?>/> <?php echo $text_alert_pay; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_moneybookers) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="moneybookers" id="moneybookers" <?php if ($payment == 'moneybookers') { ?> checked="checked" <?php } ?>/> <?php echo $text_moneybookers; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_liqpay) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="liqpay" id="liqpay" <?php if ($payment == 'liqpay') { ?> checked="checked" <?php } ?>/> <?php echo $text_liqpay; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_sage_pay) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="sage_pay" id="sage_pay" <?php if ($payment == 'sage_pay') { ?> checked="checked" <?php } ?>/> <?php echo $text_sage_pay; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_two_checkout) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="two_checkout" id="two_checkout" <?php if ($payment == 'two_checkout') { ?> checked="checked" <?php } ?>/> <?php echo $text_two_checkout; ?>
   </label>
   </div>
  <?php } ?>

  <?php if ($affiliate_google_wallet) { ?>
   <div class="radio">
  <label>
    <input type="radio" name="payment" value="google_wallet" id="google_wallet" <?php if ($payment == 'google_wallet') { ?> checked="checked" <?php } ?>/> <?php echo $text_google_wallet; ?>
   </label>
   </div>
  <?php } ?>

</div>
</div>

<div class="form-group payment" id="payment-cheque">
	<label class="col-sm-2 control-label" for="input-cheque"><?php echo $entry_cheque; ?></label>
	<div class="col-sm-10">
	  <input type="text" name="cheque" value="<?php echo $cheque; ?>" placeholder="<?php echo $entry_cheque; ?>" id="input-cheque" class="form-control" />
	</div>
</div>

<div class="form-group payment" id="payment-paypal">
	<label class="col-sm-2 control-label" for="input-paypal"><?php echo $entry_paypal; ?></label>
	<div class="col-sm-10">
	  <input type="text" name="paypal" value="<?php echo $paypal; ?>" placeholder="<?php echo $entry_paypal; ?>" id="input-paypal" class="form-control" />
	</div>
</div>

<div class="payment" id="payment-bank">
	<div class="form-group">
	  <label class="col-sm-2 control-label" for="input-bank-name"><?php echo $entry_bank_name; ?></label>
	  <div class="col-sm-10">
		<input type="text" name="bank_name" value="<?php echo $bank_name; ?>" placeholder="<?php echo $entry_bank_name; ?>" id="input-bank-name" class="form-control" />
	  </div>
	</div>
	<div class="form-group">
	  <label class="col-sm-2 control-label" for="input-bank-branch-number"><?php echo $entry_bank_branch_number; ?></label>
	  <div class="col-sm-10">
		<input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" placeholder="<?php echo $entry_bank_branch_number; ?>" id="input-bank-branch-number" class="form-control" />
	  </div>
	</div>
	<div class="form-group">
	  <label class="col-sm-2 control-label" for="input-bank-swift-code"><?php echo $entry_bank_swift_code; ?></label>
	  <div class="col-sm-10">
		<input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" placeholder="<?php echo $entry_bank_swift_code; ?>" id="input-bank-swift-code" class="form-control" />
	  </div>
	</div>
	<div class="form-group">
	  <label class="col-sm-2 control-label" for="input-bank-account-name"><?php echo $entry_bank_account_name; ?></label>
	  <div class="col-sm-10">
		<input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" placeholder="<?php echo $entry_bank_account_name; ?>" id="input-bank-account-name" class="form-control" />
	  </div>
	</div>
	<div class="form-group">
	  <label class="col-sm-2 control-label" for="input-bank-account-number"><?php echo $entry_bank_account_number; ?></label>
	  <div class="col-sm-10">
		<input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" placeholder="<?php echo $entry_bank_account_number; ?>" id="input-bank-account-number" class="form-control" />
	  </div>
	</div>
</div>

<div class="form-group payment" id="payment-qiwi">
 <label class="col-sm-2 control-label" for="input-qiwi"><?php echo $entry_qiwi; ?></label>
 <div class="col-sm-10">
   <input type="text" name="qiwi" value="<?php echo $qiwi; ?>" placeholder="<?php echo $entry_qiwi; ?>" id="input-qiwi" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-card">
 <label class="col-sm-2 control-label" for="input-card"><?php echo $entry_card; ?></label>
 <div class="col-sm-10">
   <input type="text" name="card" value="<?php echo $card; ?>" placeholder="<?php echo $entry_card; ?>" id="input-card" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-yandex">
 <label class="col-sm-2 control-label" for="input-yandex"><?php echo $entry_yandex; ?></label>
 <div class="col-sm-10">
   <input type="text" name="yandex" value="<?php echo $yandex; ?>" placeholder="<?php echo $entry_yandex; ?>" id="input-yandex" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wmr">
 <label class="col-sm-2 control-label" for="input-webmoney_wmr"><?php echo $entry_webmoney_wmr; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wmr" value="<?php echo $webmoney_wmr; ?>" placeholder="<?php echo $entry_webmoney_wmr; ?>" id="input-webmoney_wmr" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wmz">
 <label class="col-sm-2 control-label" for="input-webmoney_wmz"><?php echo $entry_webmoney_wmz; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wmz" value="<?php echo $webmoney_wmz; ?>" placeholder="<?php echo $entry_webmoney_wmz; ?>" id="input-webmoney_wmz" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wmu">
 <label class="col-sm-2 control-label" for="input-webmoney_wmu"><?php echo $entry_webmoney_wmu; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wmu" value="<?php echo $webmoney_wmu; ?>" placeholder="<?php echo $entry_webmoney_wmu; ?>" id="input-webmoney_wmu" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wme">
 <label class="col-sm-2 control-label" for="input-webmoney_wme"><?php echo $entry_webmoney_wme; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wme" value="<?php echo $webmoney_wme; ?>" placeholder="<?php echo $entry_webmoney_wme; ?>" id="input-webmoney_wme" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wmy">
 <label class="col-sm-2 control-label" for="input-webmoney_wmy"><?php echo $entry_webmoney_wmy; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wmy" value="<?php echo $webmoney_wmy; ?>" placeholder="<?php echo $entry_webmoney_wmy; ?>" id="input-webmoney_wmy" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wmb">
 <label class="col-sm-2 control-label" for="input-webmoney_wmb"><?php echo $entry_webmoney_wmb; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wmb" value="<?php echo $webmoney_wmb; ?>" placeholder="<?php echo $entry_webmoney_wmb; ?>" id="input-webmoney_wmb" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-webmoney_wmg">
 <label class="col-sm-2 control-label" for="input-webmoney_wmg"><?php echo $entry_webmoney_wmg; ?></label>
 <div class="col-sm-10">
   <input type="text" name="webmoney_wmg" value="<?php echo $webmoney_wmg; ?>" placeholder="<?php echo $entry_webmoney_wmg; ?>" id="input-webmoney_wmg" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-alert_pay">
 <label class="col-sm-2 control-label" for="input-alert_pay"><?php echo $entry_alert_pay; ?></label>
 <div class="col-sm-10">
   <input type="text" name="alert_pay" value="<?php echo $alert_pay; ?>" placeholder="<?php echo $entry_alert_pay; ?>" id="input-alert_pay" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-moneybookers">
 <label class="col-sm-2 control-label" for="input-moneybookers"><?php echo $entry_moneybookers; ?></label>
 <div class="col-sm-10">
   <input type="text" name="moneybookers" value="<?php echo $moneybookers; ?>" placeholder="<?php echo $entry_moneybookers; ?>" id="input-moneybookers" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-liqpay">
 <label class="col-sm-2 control-label" for="input-liqpay"><?php echo $entry_liqpay; ?></label>
 <div class="col-sm-10">
   <input type="text" name="liqpay" value="<?php echo $liqpay; ?>" placeholder="<?php echo $entry_liqpay; ?>" id="input-liqpay" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-sage_pay">
 <label class="col-sm-2 control-label" for="input-sage_pay"><?php echo $entry_sage_pay; ?></label>
 <div class="col-sm-10">
   <input type="text" name="sage_pay" value="<?php echo $sage_pay; ?>" placeholder="<?php echo $entry_sage_pay; ?>" id="input-sage_pay" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-two_checkout">
 <label class="col-sm-2 control-label" for="input-two_checkout"><?php echo $entry_two_checkout; ?></label>
 <div class="col-sm-10">
   <input type="text" name="two_checkout" value="<?php echo $two_checkout; ?>" placeholder="<?php echo $entry_two_checkout; ?>" id="input-two_checkout" class="form-control" />
 </div>
</div>

<div class="form-group payment" id="payment-google_wallet">
 <label class="col-sm-2 control-label" for="input-google_wallet"><?php echo $entry_google_wallet; ?></label>
 <div class="col-sm-10">
   <input type="text" name="google_wallet" value="<?php echo $google_wallet; ?>" placeholder="<?php echo $entry_google_wallet; ?>" id="input-google_wallet" class="form-control" />
 </div>
</div>
</div>
<?php if ($affiliate_id) { ?>
<div class="tab-pane" id="tab-transaction">
  <div id="transaction"></div>
  <br />
  <?php if((int)$request_payment>0) { ?>
  <div class="form-group">
	<label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description; ?></label>
	<div class="col-sm-10">
	  <input type="text" name="description" value="<?php echo $entry_payment_comment.$info_payment; ?>" placeholder="<?php echo $entry_description; ?>" id="input-description" class="form-control" />
	</div>
  </div>
  <div class="form-group">
	<label class="col-sm-2 control-label" for="input-amount"><?php echo $entry_amount; ?></label>
	<div class="col-sm-10">
	  <input type="text" name="amount" value="<?php echo '-'.$request_payment; ?>" placeholder="<?php echo $entry_amount; ?>" id="input-amount" class="form-control" />
	</div>
  </div>
  <?php } else { ?>
  <div class="form-group">
	<label class="col-sm-2 control-label" for="input-description"><?php echo $entry_description; ?></label>
	<div class="col-sm-10">
	  <input type="text" name="description" value="" placeholder="<?php echo $entry_description; ?>" id="input-description" class="form-control" />
	</div>
  </div>
  <div class="form-group">
	<label class="col-sm-2 control-label" for="input-amount"><?php echo $entry_amount; ?></label>
	<div class="col-sm-10">
	  <input type="text" name="amount" value="" placeholder="<?php echo $entry_amount; ?>" id="input-amount" class="form-control" />
	</div>
  </div>
  <?php } ?>
  <div class="text-right">
	<button type="button" id="button-transaction" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_transaction_add; ?></button>
  </div>
</div>
<?php } ?>
<?php  
if($elements) {
  foreach ($elements as $key_element => $value_element) {
    if(!$value_element['isexists']) { echo $value_element['info']; if($value_element['dopinfo']) { echo $value_element['dopinfo']; } }
    if($value_element['isexists']) { if($value_element['version']) { echo $value_element['versioninfo']; } }
  }
  echo '</br></br>';
}
?>
<table class="table table-bordered">
	<thead>
		<tr>
			<td colspan="5" ><?php echo $entry_payment; ?></td>
		</tr>
	</thead>
	</tbody>
		<tr>
			<td rowspan="6">
				<input type="checkbox" name="affiliate_bonus" id="affiliate_bonus" <?php if ($affiliate_bonus) { ?> checked="checked" <?php } ?> />
        <?php if ($is_affiliate_dopfun) { ?>
          <label for="affiliate_bonus"><?php echo $text_bonus; ?></label>
        <?php } else if ($mod_affiliate_dopfun) { ?>
          <label><?php echo $mod_affiliate_dopfun; ?></label>
        <?php } ?>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="affiliate_cheque" id="affiliate_cheque" <?php if ($affiliate_cheque) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_cheque"><?php echo $text_cheque; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_paypal" id="affiliate_paypal" <?php if ($affiliate_paypal) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_paypal"><?php echo $text_paypal; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_bank" id="affiliate_bank" <?php if ($affiliate_bank) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_bank"><?php echo $text_bank; ?></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="affiliate_qiwi" id="affiliate_qiwi" <?php if ($affiliate_qiwi) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_qiwi"><?php echo $text_qiwi; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_card" id="affiliate_card" <?php if ($affiliate_card) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_card"><?php echo $text_card; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_yandex" id="affiliate_yandex" <?php if ($affiliate_yandex) { ?> checked="checked"<?php } ?> />
				<label for="affiliate_yandex"><?php echo $text_yandex; ?></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wmr" id="affiliate_webmoney_wmr" <?php if ($affiliate_webmoney_wmr) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_webmoney_wmr"><?php echo $text_webmoney_wmr; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wmz" id="affiliate_webmoney_wmz" <?php if ($affiliate_webmoney_wmz) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_webmoney_wmz"><?php echo $text_webmoney_wmz; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wmu" id="affiliate_webmoney_wmu" <?php if ($affiliate_webmoney_wmu) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_webmoney_wmu"><?php echo $text_webmoney_wmu; ?></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wme" id="affiliate_webmoney_wme" <?php if ($affiliate_webmoney_wme) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_webmoney_wme"><?php echo $text_webmoney_wme; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wmy" id="affiliate_webmoney_wmy" <?php if ($affiliate_webmoney_wmy) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_webmoney_wmy"><?php echo $text_webmoney_wmy; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wmb" id="affiliate_webmoney_wmb" <?php if ($affiliate_webmoney_wmb) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_webmoney_wmb"><?php echo $text_webmoney_wmb; ?></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="affiliate_webmoney_wmg" id="affiliate_webmoney_wmg" <?php if ($affiliate_webmoney_wmg) { ?> checked="checked" <?php } ?> />
				<label for="affiliate_webmoney_wmg"><?php echo $text_webmoney_wmg; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_alert_pay" id="affiliate_alert_pay" <?php if ($affiliate_alert_pay) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_alert_pay"><?php echo $text_alert_pay; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_moneybookers" id="affiliate_moneybookers" <?php if ($affiliate_moneybookers) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_moneybookers"><?php echo $text_moneybookers; ?></label>
			</td>
		</tr>
		<tr>
			<td>
				<input type="checkbox" name="affiliate_liqpay" id="affiliate_liqpay" <?php if ($affiliate_liqpay) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_liqpay"><?php echo $text_liqpay; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_sage_pay" id="affiliate_sage_pay" <?php if ($affiliate_sage_pay) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_sage_pay"><?php echo $text_sage_pay; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_two_checkout" id="affiliate_two_checkout" <?php if ($affiliate_two_checkout) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_two_checkout"><?php echo $text_two_checkout; ?></label>
			</td>
			<td>
				<input type="checkbox" name="affiliate_google_wallet" id="affiliate_google_wallet" <?php if ($affiliate_google_wallet) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_google_wallet"><?php echo $text_google_wallet; ?></label>
			</td>
		</tr>
	</tbody>
</table>
<table class="table table-bordered">
  <thead>
	<tr>
	  <td colspan="6" >...</td>
	</tr>
  </thead>
	<tbody>
		<tr>
			<td class="middle">
				<input type="checkbox" name="affiliate_add" id="affiliate_add" <?php if ($affiliate_add) { ?>checked="checked" <?php } ?> />
				<label for="affiliate_add"><?php echo $entry_add; ?></label>
			</td>
			<td class="middle">
				<input type="checkbox" name="affiliate_number_tracking" id="affiliate_number_tracking" <?php if ($affiliate_number_tracking) { ?> checked="checked" <?php } ?>/>
				<label for="affiliate_number_tracking"><?php echo $entry_number_tracking; ?></label>
			</td>
			<td class="middle">
        <?php if ($is_affiliate_trackingproduct) { ?>
          <input type="checkbox" name="affiliate_category_visible" id="affiliate_category_visible" <?php if ($affiliate_category_visible) { ?> checked="checked" <?php } ?>/>
          <label for="affiliate_category_visible"><?php echo $entry_category_visible; ?></label>
        <?php } else if ($mod_affiliate_trackingproduct) { ?>
          <input disabled="false" type="checkbox" name="affiliate_category_visible" id="affiliate_category_visible"/>
          <label for="affiliate_category_visible"><?php echo $entry_category_visible; ?></label>
          <label><?php echo $mod_affiliate_trackingproduct; ?></label>
        <?php } ?>
			</td>
			<td rowspan="2" class="middle"><?php echo $entry_affiliate_sumbol; ?>
			   <select name="affiliate_sumbol">
					<?php for ($i=1; $i<3; $i++) { ?>
					<?php if ($i == $affiliate_sumbol) { ?>
					<option value="<?php echo $i; ?>" selected="selected">
						<?php if ($i == 1) { echo '&'; } else { echo '?'; } ?></option>
					<?php } else { ?>
					<option value="<?php echo $i; ?>">
						<?php if ($i == 1) { echo '&'; } else { echo '?'; } ?></option>
					<?php } ?>
					<?php } ?>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<?php echo $entry_days; ?> </br>
				<input type="text" name="affiliate_days" value="<?php echo $affiliate_days; ?>" />
			</td>
			<td>
				<?php echo $entry_total; ?></br>
				<input type="text" name="affiliate_total" value="<?php echo $affiliate_total; ?>" />
			</td>
			<td>
				<?php echo $entry_order_status; ?></br>
				<select name="affiliate_order_status_id">
					<?php foreach ($order_statuses as $order_status) { ?>
						<?php if ($order_status['order_status_id'] == $affiliate_order_status_id) { ?>
							<option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
						<?php } else { ?>
							<option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
						<?php } ?>
					<?php } ?>
				</select>
			</td>
		</tr>
	</tbody>
</table>
<div class="account-left-menu">
  <h2><?php echo $text_my_account; ?></h2>
  <ul class="list-unstyled">
    <li><i class="fa fa-user"></i><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
    <li><i class="fa fa-unlock-alt"></i><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
    <li><i class="fa fa-home"></i><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
    <li><i class="fa fa-heart"></i><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
  </ul>
  <h2><?php echo $text_my_orders; ?></h2>
  <ul class="list-unstyled">
    <li><i class="fa fa-shopping-cart"></i><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
    <li><i class="fa fa-arrow-circle-down"></i><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
    <?php if ($reward) { ?>
    <li><i class="fa fa-mail-reply"></i><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
    <?php } ?>
    <li><i class="fa fa-undo"></i><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
    <li><i class="fa fa-money"></i><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    <li><i class="fa fa-recycle"></i><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
  </ul>
  <h2><?php echo $text_my_newsletter; ?></h2>
  <ul class="list-unstyled">
    <li><i class="fa fa-file-text-o "></i><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
  </ul>
</div>
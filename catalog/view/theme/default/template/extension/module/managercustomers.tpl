<?php foreach ($managers as $manager): ?>
<div class="manager-info" style="text-align:center;width: 88%;margin-left: 7px;">
<div class="manager-head" style="    color: #333;
    background-color: #f5f5f5;
    border-color: #fff;
    padding: 10px 10px;
    border-bottom: 1px solid transparent;
    border-top-right-radius: 3px;
    border-top-left-radius: 3px;">Ваш персональный менеджер</div>
<div class="manager-info_name" style="color: #fff;
    background-color: #428bca;
    border-color: #428bca;">
 <i class="fa fa-user" style="margin-right: 5px;"></i> <b><?php echo $manager['firstname']; ?> <?php echo $manager['lastname']; ?></b>
</div>

<?php if (!empty($manager['image'])): ?>
<div class="manager-info_image">
<img src="/image/<?php echo $manager['image']; ?>" alt="">
</div>
<?php endif; ?>

<?php if (!empty($manager['telephone'])): ?>
<div class="manager-info_phone" style="color: #fff;
    background-color: #428bca;
    border-color: #428bca;">
<i class="fa fa-phone" style="margin-right: 5px;color:#fff;"></i><a href="tel:<?php echo $manager['telephone']; ?>" style="color:#fff;"><?php echo $manager['telephone'] ?></a>
</div>
<?php endif; ?>

<?php if (!empty($manager['email'])): ?>
<div class="manager-info_email" style="color: #fff;
    background-color: #428bca;
    border-color: #428bca;">
    <i class="fa fa-envelope" style="margin-right:5px;color:#fff;"></i><a href="mailto:<?php echo $manager['email']; ?>" style="color:#fff;"><?php echo $manager['email']; ?></a>
</div>
<?php endif; ?>
</div>
<?php endforeach; ?>
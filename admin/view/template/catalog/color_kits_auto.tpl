<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	   <a href="<?php echo $kits_auto; ?>" class="btn btn-default" role="button"><?php echo $button_auto ?></a>
	  <a href="<?php echo $color_list; ?>" class="btn btn-default" role="button"><?php echo $button_color_list; ?></a>
	  <a href="<?php echo $insert; ?>" data-toggle="tooltip" title="Список наборов" class="btn btn-primary"><?php echo $button_sets ?></a>

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
  
  <?php if (isset($success)) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>

    <div class="panel-body">
		<form action="<?php echo $action ?>" method="POST" class="form-inline">
		<div class="row">
			<div class="col-xs-12">
				<p><?php echo $text_found ?> <strong><?php echo count($products); ?></strong></p>
				<div class="form-group">
					<label><?php echo $text_found ?> :</label>
					<input name="status" class="form-control" style="width: 50px;" value="1">
				</div>
				<div class="form-group">
					<label><?=$text_tpl?></label>
					<select name="template" class="form-control">
						<option value="color"><?=$template_colors?></option>
						<option value="photos"><?=$save_photos?></option>
					</select>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-6">
				<ul class="list-group" style="overflow-y: scroll;height: 100%;max-height:800px;">
				<?php foreach($products as $key => $product){ ?>
				  <li class="list-group-item">
					  <input name="colorkit[<?=$key?>][name_group]" value="<?=$key?>" type="hidden">
					<span class="badge"><?php echo count($product) ?></span>
					  <span class="glyphicon glyphicon-remove del_group" style="color: #F00" aria-hidden="true"></span>
					<strong><?php echo $key ?></strong>
					<div>
						<?php foreach($product as $item){ ?>
						<input name="colorkit[<?=$key?>][rows][<?=$item['product_id']?>][product_id]" value="<?=$item['product_id']?>" type="hidden">
						<input name="colorkit[<?=$key?>][rows][<?=$item['product_id']?>][option_id]" value="<?=$item['option_id']?>" type="hidden">
							--- <?php echo $item['product_name'] ?> [<strong><?php echo $item['color'] ?></strong>]<br />
						<?php } ?>	
					 </div>
				  </li>
				 <?php } ?> 
				</ul>
			</div>
		</div>

	<div class="row">
		<div class="col-xs-12">
			<div class="form-group">
				<button class="btn btn-success" type="submit"><?php echo $button_add_auto ?> </button>
			</div>
		</div>
	</div>
</form>
</div>
</div>



<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<?php echo $footer; ?>
	<script>
		$(".del_group").on("click",function(){
			$(this).parent().remove();
		})
	</script>
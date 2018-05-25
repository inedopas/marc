<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); ?>
<?php $grid_center = 12; 
if($column_left != '') $grid_center = $grid_center-3; 
if($column_right != '') $grid_center = $grid_center-3;

require_once( DIR_TEMPLATE.$config->get($config->get('config_theme') . '_directory')."/lib/module.php" );
$modules_old_opencart = new Modules($registry); ?>

<!-- MAIN CONTENT
	================================================== -->


<div class="main-content <?php if($theme_options->get( 'content_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'content_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'content_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?> home">
	<div class="background-content"></div>
	<div class="background">
		<div class="shadow"></div>
		<div class="pattern">
			<div class="container">
				<?php 
				$preface_left = $modules_old_opencart->getModules('preface_left');
				$preface_right = $modules_old_opencart->getModules('preface_right');
				?>
				<?php if( count($preface_left) || count($preface_right) ) { ?>
				<div class="row">
					<div class="col-sm-8">
						<?php
						if( count($preface_left) ) {
							foreach ($preface_left as $module) {
								echo $module;
							}
						} ?>
					</div>
					
					<div class="col-sm-4">
						<?php
						if( count($preface_right) ) {
							foreach ($preface_right as $module) {
								echo $module;
							}
						} ?>
					</div>
				</div>
				<?php } ?>
				
				<?php 
				$preface_fullwidth = $modules_old_opencart->getModules('preface_fullwidth');
				if( count($preface_fullwidth) ) { ?>
				<div class="row">
					<div class="col-sm-12">
						<?php
							foreach ($preface_fullwidth as $module) {
								echo $module;
							}
						?>
					</div>
				</div>
				<?php } ?>
				
				<div class="row">				
					<?php 
					$columnleft = $modules_old_opencart->getModules('column_left');
					if( count($columnleft) ) { ?>
					<div class="col-md-3" id="column_left">
						<?php
						foreach ($columnleft as $module) {
							echo $module;
						}
						?>
					</div>
					<?php } ?>
					<?php $grid_center = 12; if( count($columnleft) ) { $grid_center = 9; } ?>
					<div class="col-md-<?php echo $grid_center; ?>">
						<?php 
						$content_big_column = $modules_old_opencart->getModules('content_big_column');
						if( count($content_big_column) ) { 
							foreach ($content_big_column as $module) {
								echo $module;
							}
						} ?>
						
						<div class="row">
							<?php 
							$grid_content_top = 12; 
							$grid_content_right = 3;
							$column_right = $modules_old_opencart->getModules('column_right'); 
							if( count($column_right) ) {
								if($grid_center == 9) {
									$grid_content_top = 8;
									$grid_content_right = 4;
								} else {
									$grid_content_top = 9;
									$grid_content_right = 3;
								}
							}
							?>
							<div class="col-md-<?php echo $grid_content_top; ?>">
								<?php 
								$content_top = $modules_old_opencart->getModules('content_top');
								if( count($content_top) ) { 
									foreach ($content_top as $module) {
										echo $module;
									}
								} ?>
							</div>
							
							<?php if( count($column_right) ) { ?> 
							<div class="col-md-<?php echo $grid_content_right; ?>">
								<?php foreach ($column_right as $module) {
									echo $module;
								} ?>
							</div>
							<?php } ?>
						</div>
					</div>
				</div>
				
				<div class="row">	
					<div class="col-sm-12">	
						<?php 
						$contentbottom = $modules_old_opencart->getModules('content_bottom');
						if( count($contentbottom) ) { ?>
							<?php
							foreach ($contentbottom as $module) {
								echo $module;
							}
							?>
						<?php } ?>
						
					</div>
				</div>
                <div class="center-column content-with-background" style="background-color: #19a1df;margin-top: 10px;border-radius: 70px;display: none;">
                <div class="row">
                  <!-- <div class="col-sm-6">
                    <div class="well">
                      <h2><?php echo $text_new_customer; ?></h2>
                      <p><strong><?php echo $text_register; ?></strong></p>
                      <p style="padding-bottom: 10px"><?php echo $text_register_account; ?></p>
                      <a href="<?php echo $register; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
                  </div> -->
                  <div class="col-sm-12">
                    <div class="well">
                      <div class="col-sm-3">
                      	<h2 style="color: white; font-size: 24px; padding: 39px; padding-right: 0px;"><?php echo $text_returning_customer; ?></h2>
                  	  </div>
                      <!-- <p><strong><?php echo $text_i_am_returning_customer; ?></strong></p> -->
                      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" style="text-align: center;">
                        <div class="col-sm-3 form-group" style="padding-top: 30px;margin-right: 5px;">
                          <!-- <label class="control-label" for="input-email"><?php echo $entry_email; ?></label> -->
                          <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" style="border-radius: 18px;" />
                        </div>
                        <div class="col-sm-3 form-group" style="padding-bottom: 10px; padding-top: 30px;margin-right: 5px;">
                          <!-- <label class="control-label" for="input-password"><?php echo $entry_password; ?></label> -->
                          <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" style="border-radius: 18px;" />
                          <a style="color: white;" class="forgotpass" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></div>
                        <input type="submit" value="<?php echo $button_login; ?>" style="margin-top: 31px; border-radius: 24px;" class="btn btn-primary" />
                        <?php if ($redirect) { ?>
                        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                        <?php } ?>
                      </form>
                    </div>
                  </div>
                </div>
                </div>
			</div>
		</div>
	</div>
</div>

<?php echo $footer; ?>
<div class="text-center""><span style="padding:25px 25px 0 25px;">ООО " Марказит"  Marc Jewelry .
 </div>
<div style="margin:0 auto;max-width:1350px;padding: 25px 25px">
<h1 style="text-align: center;" style="text-align: center;">Каталог интернет-магазина серебряных украшений “Марказит”</h1>
<p>Серебро - излюбленный материал у ювелиров. Оно принимает любой камень, другие металлы, поддается всевозможным видам обработки: черчению, полировке до зеркального блеска, матированию, золочению. Ассортимент многообразен и бесконечен. У нас вы выберете украшение для особого случая или просто под свой характер. 
В каталоге: браслеты, серьги, броши, колье, кольца, часы из серебра с марказитами, комплекты из серебряных украшений.
В нашем магазине представлены ювелирные изделия с марказитами огранки SWAROVSKI. Только чистое стерлинговое серебро и искусное мастерство ювелиров.
</p>
<h2 style="text-align: center;">Серебряные украшения с марказитом: благородный блеск, выдающий безупречное чувство стиля</h2>
<p>Серебро… Обладая какой-то магической силой, оно на протяжении тысячелетий притягивает и удерживает взгляды людей, вызывая восхищение, неподдельный восторг. Этот драгоценный металл ценился с зарождения ювелирного искусства, много веков оставаясь дороже золота. Хотя сегодня серебряные украшения купить может каждый, материал по-прежнему привлекает настоящих эстетов и способен выдать в своем обладателе безупречное чувство стиля.
В мире ювелирных изделий особенно благородно смотрятся серебряные изделия с марказитом огранки SWAROVSKI и другими полудрагоценными минералами: ониксом, бирюзой, гранатом. Огромный выбор изысканных украшений в нашем магазине.</p>
<h2 style="text-align: center;">Марказиты в серебре - нестареющая классика</h2>
<p>Капельное серебро или марказит - полудрагоценный минерал, результат огранки лучистого колчедана (полисульфида железа). Это уникальный камень, обладающий неповторимым металлическим блеском, способностью сверкать словно диамант под лучами света. 
Особенно красиво смотрятся марказиты в серебре, материалы просто созданы для совместного использования в ювелирном искусстве. Безупречно выглядят украшения, где капельное серебро обрамляет полудрагоценные камни, например хризопраз, оникс, бирюзу, гранат, аметист, агат. 
Пару слов о целебных свойствах минерала. Лучистый колчедан еще во времена Римской империи был известен способностью успокаивать нервную систему, бороться с опухолями, заболеваниями глаз, улучшать настроение, умственную деятельность.
Украшения с марказитом - та самая сдержанная роскошь. Они смотрятся просто, без излишнего пафоса. В этом очарование, красота, которую по достоинству оценят настоящие эстеты.
</p>
<h2 style="text-align: center;">Как выбрать?</h2>
<p>Серебро издавна символизировало девичью чистоту. Но сегодня ювелиры способны сотворить настоящее чудо, предлагая огромный выбор изделий разной фактуры, причудливых форм, чтобы удовлетворить пожелания покупателя: как юных леди и прекрасных дам, так и сильного пола. 
Но перед покупкой важно убедиться, что украшение дополнит ваш образ, станет обрамлением для истинной “драгоценности”. В этом помогут несколько несложных правил:
- утонченные, нежные с витиеватыми плетениями браслеты из серебра помогут подчеркнуть хрупкость тонких запястий;
- широкое запястье - широкий, массивный браслет, он подчеркнет женственность, сексуальность;
- серьги должны сочетаться с формой лица, прической: струящиеся серьги помогут выглядеть еще эффектней обладательницам стройной шеи и удлиненного лица, пусеты и капельки идеально сочетаются с округлым лицом;
- сочетайте драгоценности с цветом глаз, кожи, волос;
- рыжеволосым подойдут фиолетовые, зеленые камни, блондинкам к лицу нежные оттенки (бирюза, жемчуг), брюнеткам - теплые тона (янтарь, оникс);
- украшения с ониксом, розовым кварцем, бирюзой, жемчугом эффектно смотрятся на загорелой коже;
- на белоснежной коже великолепно выглядят яркие (агат, яшма) и холодные (турмалин, лазурит) камни.</p>
</div>
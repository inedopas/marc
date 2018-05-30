<?php 

$language_id = 2;
foreach($data['languages'] as $language) {
	if($language['language_id'] != 1) {
		$language_id = $language['language_id'];
	}
}


$query = $this->db->query("
	DROP TABLE IF EXISTS `".DB_PREFIX ."camera_slider`
");

$query = $this->db->query("
		CREATE TABLE IF NOT EXISTS `".DB_PREFIX."camera_slider` (
			`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			`name` text,
			`settings` text,
			`content` text,
			PRIMARY KEY (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1
");

$query = $this->db->query("
	INSERT INTO `".DB_PREFIX."camera_slider` (`id`, `name`, `settings`, `content`) VALUES
	(1, 'Marcjewelry slider', 'a:3:{s:13:\"slider_height\";s:3:\"666\";s:12:\"slider_width\";s:4:\"1570\";s:11:\"layout_type\";s:1:\"0\";}', 'a:1:{i:1;a:2:{i:1;a:3:{s:6:\"status\";s:1:\"1\";s:6:\"slider\";s:27:\"catalog/toys2/slider-01.png\";s:4:\"link\";s:1:\"#\";}i:" . $language_id . ";a:3:{s:6:\"status\";s:1:\"1\";s:6:\"slider\";s:27:\"catalog/toys2/slider-01.png\";s:4:\"link\";s:1:\"#\";}}}')
");

$output = array();
$output["camera_slider_module"] = array (
  0 =>
  array (
    'slider_id' => '1',
    'layout_id' => '1',
    'position' => 'slideshow',
    'sort_order' => '1',
    'status' => '1',
  ),
);

$this->model_setting_setting->editSetting( "camera_slider", $output );
?>

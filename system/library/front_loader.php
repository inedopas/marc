<?php

	$sc_ver = VERSION;
	if (!defined('SC_VERSION')) define('SC_VERSION', (int)substr(str_replace('.','',$sc_ver), 0,2));
	require_once(DIR_SYSTEM . 'helper/seocmsprofunc.php');

	if (!isset($registry)) {
		$registry = $this->registry;
	}

    $registry->set('sc_time_start', microtime(true));

 	$this->file = DIR_APPLICATION.'controller/common/front.php';
    require_once($this->file);
	$SeoCMSFront = new ControllerCommonFront($registry);
	$SeoCMSFront->install();

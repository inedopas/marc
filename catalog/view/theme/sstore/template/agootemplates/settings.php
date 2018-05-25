<?php
if (SC_VERSION < 20) {
$ascp_settings_settings = Array(
'box_begin' => '<div class="box">
<div class="box-heading">{TITLE}</div>
<div class="box-content">',
'box_end' => '</div>
</div>'
);
} else {$ascp_settings_settings = Array(
'box_begin' => '<div class="box-main news-style">
<div class="news-set center">
<h4 class="inner">
<span>{TITLE}</span>
</h4>
</div>
<div>',
'box_end' => '</div>
</div>',
'css' => Array('css' => '
.ascp-list-title {
	color: #252525 !important;
	font-size: 15px !important;
	text-align: center !important;
}

.column_width_:hover {
	box-shadow: 0 0 16px rgba(0, 0, 0, 0.1) !important;
}

.seocmspro_content .content-records {
    border: 1px solid #f4f3f3;
    margin-bottom: 30px;
    min-height: 370px;
	padding: 5px !important;
}
.seocmspro_content ul li {
    list-style-type: none !important;
    display: inline !important;
}


')
);
}
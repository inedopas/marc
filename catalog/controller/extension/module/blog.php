<?php
if (!class_exists('ControllerExtensionModuleBlog')) {
	class ControllerExtensionModuleBlog extends Controller {
		public function index($arg) {
				agoo_cont('module/blog', $this->registry);
				$html = $this->controller_module_blog->index($arg);
				return $html;
		}
	}
}

<?php
class Response {
	private $headers = array();
	private $level = 0;
	private $output;

	public function addHeader($header) {
		$this->headers[] = $header;
	}

	public function redirect($url, $status = 302) {
		header('Location: ' . str_replace(array('&amp;', "\n", "\r"), array('&', '', ''), $url), true, $status);
		exit();
	}

	public function setCompression($level) {
		$this->level = $level;
	}

	public function getOutput() {
		return $this->output;
	}
	
	public function setOutput($output) {
		$this->output = $output;
	}

	private function compress($data, $level = 0) {
		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)) {
			$encoding = 'gzip';
		}

		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'x-gzip') !== false)) {
			$encoding = 'x-gzip';
		}

		if (!isset($encoding) || ($level < -1 || $level > 9)) {
			return $data;
		}

		if (!extension_loaded('zlib') || ini_get('zlib.output_compression')) {
			return $data;
		}

		if (headers_sent()) {
			return $data;
		}

		if (connection_status()) {
			return $data;
		}

		$this->addHeader('Content-Encoding: ' . $encoding);

		return gzencode($data, (int)$level);
	}

	public function output() {
		if ($this->output) {
			 
	        $output = $this->level ? $this->compress(minify($this->output,1), $this->level) : minify($this->output,1);
	      
			if (!headers_sent()) {
				foreach ($this->headers as $header) {
					header($header, true);
				}
			}
			echo $output;
		}
	}
}


define('SAFE', 1);
define('EXTREME', 2);
define('EXTREME_SAVE_COMMENTS', 4);
define('EXTREME_SAVE_PRE', 3);

function minify($html, $level=2)
{
	switch((int)$level)
	{
		case 0:
			//Не изменяем
		break;
		
		case 1: //Стандартное изменение
		
			// Replace all whitespace characters between tags with a single space
			$html = preg_replace("`>\s+<`", "> <", $html);
		break;
		
		case 2: //Экстримально
			
			// Сохраняем все что в тегах <pre> и <code>
			$place_holders = array(
				'<!-->' => '_!--_',
			);
			
			//Заполняем
			$html = strtr($html, $place_holders);
			
			// Удаляем все комментарии
			$html = preg_replace('/<!--[^(\[|(<!))](.*)-->/Uis', '', $html);
			
			// Заменяем все символы пробела на один пробел
			$html = preg_replace("`\s+`", " ", $html);
			
			// Удаляем пробемы между тегами
			$html = preg_replace("`> <`", "><", $html);
			
			// Удаляем пробелы между соседними тегами
			$html = str_replace("</a><a", "</a> <a", $html);
			
			// Восстанавливаем
			$html = strtr($html, array_flip($place_holders));
		break;
		
		case 3: //Экстримально с сохранением pre и code
			// Сохраняем все что в тегах <pre> и <code>
			$place_holders = array(
				'<!-->' => '_!--_',
				'<pre>' => '_pre_',
				'</pre>' => '_/pre_',
				'<code>' => '_code_',
				'</code>' => '_/code_'
			);
			
			//Заполняем
			$html = strtr($html, $place_holders);
			
			// Удаляем все комментарии
			$html = preg_replace('/<!--[^(\[|(<!))](.*)-->/Uis', '', $html);
			
			// Заменяем все символы пробела на один пробел
			$html = preg_replace(">`\s+`<", "> <", $html);
			
			// Удаляем пробемы между тегами
			$html = preg_replace("`> <`", "><", $html);
			
			// Удаляем пробелы между соседними тегами
			$html = str_replace("</a><a", "</a> <a", $html);
			
			$html = strtr($html, array_flip($place_holders));
		
		break;
		
		case 4: //Экстримально
			
			// Заменяем все символы пробела на один пробел
			$html = preg_replace("`\s+`", " ", $html);
			
			// Удаляем пробемы между тегами
			$html = preg_replace("`> <`", "><", $html);
			
			// Удаляем пробелы между соседними тегами
			$html = str_replace("</a><a", "</a> <a", $html);
		break;
	}

	//Приводим & в вид
	//$html = str_replace("&amp;", "&", $html);
	//$html = str_replace("&", "&amp;", $html);
	
	//Заменяем символы
	$replace = array(
		'&nbsp;' => '&#160;',
		'&copy;' => '&#169;',
		'&acirc;' => '&#226;',
		'&cent;' => '&#162;',
		'&raquo;' => '&#187;',
		'&laquo;' => '&#171;'
	);
	
	//$html = strtr($html, $replace);
	
	//Возвращаем HTML
	return $html;
}		

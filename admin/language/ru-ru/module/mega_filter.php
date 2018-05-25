<?php
// Heading
$_['heading_title'] = 'Умный поик' . ( file_exists( DIR_SYSTEM . 'library/mfilter_plus.php') ? '/PLUS' : '' );
$_['mfp_language_pack_version'] = '2.0.8';

// Text
$_['text_edit']						= 'Edit';
$_['text_module']					= 'Модули';
$_['text_success']					= 'Успешно: Вы модифицировали модуль ' . $_['heading_title'] . '!';
$_['text_column_left']				= 'Левый сайдбар';
$_['text_column_right']				= 'Правый сайдбар';
$_['text_content_top']				= 'Топ Позиция';
$_['text_group']					= 'Group';
$_['text_type_checkbox']			= 'Checkbox';
$_['text_type_select']				= 'Select';
$_['text_type_radio']				= 'Radio';
$_['text_type_image']				= 'Images (Checkbox)';
$_['text_type_image_radio']			= 'Images (Radio)';
$_['text_type_image_list_radio']	= 'Image List Radio';
$_['text_type_image_list_checkbox']	= 'Image List Checkbox';
$_['text_type_slider']				= 'Слайдер';
$_['text_type_text']				= 'Text';
$_['text_attribute_name']			= 'Имя Атрибута';
$_['text_attribute_group_name']		= 'Attribute Group Name';
$_['text_option_name']				= 'Имя Опции';
$_['text_filter_name']				= 'Фильтр Название Группы';
$_['text_enabled']					= 'Включено';
$_['text_settings']					= 'Настройки';
$_['text_type']						= 'Тип';
$_['text_display_as_type']			= 'Показать как тип';
$_['text_sort_order']				= 'Порядок сортировки';
$_['text_sort_order_values']		= 'Порядок сортировки значений';
$_['text_collapsed_by_default']		= 'По умолчанию свернута';
$_['text_pc'] 						= 'PC';
$_['text_mobile'] 					= 'Модуль';
$_['text_immediately']				= 'Сразу';
$_['text_immediately_help']			= 'Обновлять результаты сразу же после изменения любого параметра';
$_['text_with_delay']				= 'С задержкой';
$_['text_with_delay_help']			= 'Обновлять результаты с задержкой: ';
$_['text_with_delay_guide']			= 'Прежде, чем результаты будут обновляться, клиент может изменить несколько параметров фильтра...';
$_['text_using_button']				= 'Использование кнопки';
$_['text_using_button_help']		= 'Будет отображаться кнопка "Применить';
$_['text_milliseconds']				= 'миллисекунд';
$_['text_place_button']				= 'Поместить кнопку';
$_['text_place_button_bottom']		= 'снизу';
$_['text_place_button_top']			= 'сверху';
$_['text_place_button_bottom_top']	= 'сверху и снизу';
$_['text_by_default']				= '-- по умолчанию --';
$_['text_display_list_of_items']	= 'Отображение списка элементов (только для checkbox/radio)';
$_['text_with_scroll']				= 'С полосой прокрутки ';
$_['text_with_button_more']			= 'С кнопкой подробнее';
$_['text_checkbox_guide']			= 'Если пуст, то его доступным для всех';
$_['text_autocomplete']				= '(Автозаполнение)';
$_['text_loading']					= 'Загрузка';
$_['text_before_change_tab']		= '&#171; Если вы внесли какие-либо изменения, прежде чем менять вкладку, нажмите кнопку Сохранить';
$_['text_none']						= 'Ни один';
$_['text_attribute_separator_guide']= 'Атрибуты, разделенные разделителем будет рассматриваться как отдельные атрибуты.';
$_['text_pixels_from_top'] = 'пикселей сверху';
$_['text_content_selector_guide'] = 'Только для продвинутых пользователей, например (по умолчанию OpenCart макет):';
$_['text_string_asc'] = 'Строка по возрастанию';
$_['text_string_desc'] = 'Строка по убыванию';
$_['text_numeric_asc'] = 'Нумерация по возрастанию';
$_['text_numeric_desc'] = 'Нумерация по убыванию';
$_['text_hide_header'] = 'Скрыть заголовок';
$_['text_show_header'] = 'Показывать заголовок';
$_['text_disabled'] = 'Отключить';
$_['text_show_button_search'] = 'Показать кнопку Поиск';
$_['text_and_show_header'] = 'и показать заголовок';
$_['text_in_stock_default_selected'] = 'Опция "В наличии" выбрана по умолчанию/Скрыть наличие товаров';
$_['text_sum_product_quantity'] = 'Трактовать произведение как "out of stock" только после исчерпания количества для всех вариантов';
$_['text_list'] = 'Список';
$_['text_sort_values'] = 'Сортировка по умолчанию значения';
$_['text_select_group'] = '- выберите группу -';
$_['text_select_attribute'] = '- выберите атрибут -';
$_['text_select_filter'] = '- выберите фильтр -';
$_['text_list_is_empty'] = 'Список пуст';
$_['text_save'] = 'Сохранить';
$_['text_reset'] = 'Сброс';
$_['text_display_based_on_category'] = 'Показать фильтры на основе категории';
$_['text_images'] = 'Изображения';
$_['text_attribute_value'] = 'Значение Атрибута';
$_['text_image'] = 'Изображение';
$_['text_browse'] = 'Обзор';
$_['text_clear'] = 'Очистить';
$_['text_related'] = 'Связанные';
$_['text_tree'] = 'Дерево';
$_['text_cat_checkbox'] = 'флажок';
$_['text_image_manager'] = 'Менеджер изображений';
$_['text_categories'] = 'Категории';
$_['text_add_level'] = 'Добавить уровень';
$_['text_current_category'] = 'Определить категории по URL';
$_['text_top_category'] = 'Топ Категория';
$_['text_or_select_category'] = 'Выберите категорию по умолчанию:';
$_['text_apply_also_to_childs'] = 'Применяют также для порожденных';
$_['text_auto_levels'] = 'Авто уровни';
$_['text_step'] = 'Шаг';
$_['text_please_wait'] = 'Пожалуйста, подождите...';
$_['text_progress'] = 'Ход';
$_['text_installation_in_progress'] = 'Идет установка, подождите пожалуйста...';
$_['text_loading_please_wait'] = 'Загрузка, подождите пожалуйста...';
$_['text_saving_please_wait'] = 'Сохранение, пожалуйста, подождите...';
$_['text_display_live_filter'] = 'Отображение "живого" фильтра';
$_['text_start_level'] = 'Активировать когда уровень >= ';
$_['text_start_level_help'] = 'Например, если у вас есть категории: Настольные/PC/... и установить уровень 2 этот параметр активируется, когда пользователь переходит в категорию PC';
$_['text_rebuild_index'] = 'Перестроение индекса';
$_['text_tree_categories_info'] = 'При использовании этого модуля, мы рекомендуем вам включить опцию "Показать также продукты из подкатегорий в каждой категории" в разделе "Настройки/Прочее"';
$_['text_clear_cache'] = 'Очистить кэш сейчас';
$_['text_reset_to_default_values'] = 'Сброс к значениям по умолчанию';
$_['text_are_you_sure'] = 'Вы уверены!?';
$_['text_yes'] = 'Да';
$_['text_no'] = 'Нет';
$_['text_oc_155'] = 'Эта функция требует OpenCart версии 1.5.5 или более поздней версии';
$_['text_stock_for_options_plus'] = 'Проверять также наличие опций. Если эта функция включена, то она может оказать негативное влияние на скорость фильтрации/поиска';
$_['text_content_selector'] = 'Content selector (in JavaScript)';
$_['text_url'] = 'URL';
$_['text_url_params'] = 'URL параметры';
$_['text_seo_url'] = 'SEO Url';
$_['text_insert'] = 'Вставить';
$_['text_stores'] = 'магазины';
$_['text_need_support'] = 'Need support ?';
$_['text_open_ticket'] = 'Open ticket';
$_['text_replace_settings'] = 'Save and replace settings in all existing modules (not applicable settings from tab \'Base Attributes\')';
$_['text_define_own_styles'] = 'To define own styles for this module please use prefix <code>.mfilter-box-%s</code>';
$_['text_set_tooltip'] = 'Set tooltip';
$_['text_close'] = 'Закрыть';
$_['text_display_always_as_widget'] = 'Position isn\'t available when you activate the option "Display always as widget"';
$_['text_standard_scroll'] = 'Стандартный прокрутки';
$_['text_select_all'] = 'Выбрать все';
$_['text_unselect_all'] = 'Снять все';
$_['text_go_to_mfv'] = 'Go to vehicle configuration';
$_['text_find_by'] = 'Найти по';
$_['text_on_everything_on_all_pages'] = 'On everything on all pages';
$_['text_off_everything_on_all_pages'] = 'Off everything on all pages';
$_['text_remove'] = 'Remove';
$_['text_add'] = 'Add';
$_['text_no_results_or_you_have_already_added'] = 'No results or you have already added all existing items to custom tab';
$_['text_if_something_doesnt_work'] = 'If something doesn\'t work, before opening a new ticket, please try to clear the cache of VQMod/OCMod';
$_['text_default_tab_info_attributes'] = 'Here you can configure global settings for all attributes that aren\'t in "Custom" and "Default groups settings" tab';
$_['text_default_tab_info_options'] = 'Here you can configure global settings for all options that aren\'t in "Custom" tab';
$_['text_default_tab_info_filters'] = 'Here you can configure global settings for all filters that aren\'t in "Custom" tab';
$_['text_default_groups_tab_info_attributes'] = 'Here you can configure global settings for all attributes that aren\'t in "Custom" tab';
$_['text_custom_tab_info_attributes'] = 'Here you can customize settings for each attribute';
$_['text_custom_tab_info_options'] = 'Here you can customize settings for each option';
$_['text_custom_tab_info_filters'] = 'Here you can customize settings for each filter';
$_['text_add_attribute'] = 'Add attribute';
$_['text_add_attribute_group'] = 'Add attribute group';
$_['text_add_option'] = 'Add option';
$_['text_add_filter'] = 'Add filter';
$_['text_this_item_is_already_added'] = '<br />&nbsp;&nbsp;this item is already added to the custom list';
$_['text_over_filter'] = 'Over filter';
$_['text_over_results'] = 'Over results';

// Attribs
$_['attrib_price']	= 'Фильтр Цены';
$_['attrib_manufacturers'] = 'Производителей';
$_['attrib_stock_status'] = 'Фильтр Наличия';
$_['attrib_rating'] = 'Фильтр Рейтинга';
$_['attrib_search'] = 'Поле поиска';
$_['attrib_model'] = 'Model';
$_['attrib_sku'] = 'SKU';
$_['attrib_upc'] = 'UPC';
$_['attrib_ean'] = 'EAN';
$_['attrib_jan'] = 'JAN';
$_['attrib_isbn'] = 'ISBN';
$_['attrib_mpn'] = 'MPN';
$_['attrib_location'] = 'расположение';
$_['attrib_length'] = 'длина';
$_['attrib_width'] = 'ширина';
$_['attrib_height'] = 'высота';
$_['attrib_weight'] = 'Weight';
$_['attrib_tags'] = 'Tags';

// Button
$_['button_add_module'] = 'Добавить модуль';

// Entry
$_['entry_ext_version'] = 'Версия:';
$_['entry_email'] = 'Email:';
$_['entry_plus_version'] = '+ версия:';
$_['entry_title'] = 'Название:';
$_['entry_layout'] = 'Макет:';
$_['entry_position'] = 'Позиция:';
$_['entry_status'] = 'Статус:';
$_['entry_sort_order'] = 'Порядок сортировки:';
$_['entry_show_products'] = 'Показывать количество товаров:';
$_['entry_calculate_number_of_products'] = 'Рассчитать количество продуктов:';
$_['entry_show_reset_button'] = 'Показывать кнопку сброса:';
$_['entry_show_top_reset_button'] = 'Показывать кнопку Сброс на верху:';
$_['entry_css_style'] = 'CSS стиль:';
$_['entry_color_counter_background'] = 'Цвет фона счетчика:';
$_['entry_color_counter_text'] = 'Цвет текста счетчика:';
$_['entry_color_header_background'] = 'Цвет фона заголовка:';
$_['entry_color_header_text'] = 'Цвет текста заголовка:';
$_['entry_auto_scroll_to_results'] = 'Автопрокрутка результатов:';
$_['entry_max_height'] = 'Максимальная высота:';
$_['entry_limit_of_items'] = 'Лимит товаров:';
$_['entry_name'] = 'Название:';
$_['entry_show_in_categories'] = 'Показывать в категориях:';
$_['entry_hide_in_categories'] = 'Скрыть в категориях:';
$_['entry_store'] = 'Интернет-магазин:';
$_['entry_default_values'] = 'Значение по умолчанию:';
$_['entry_layout_category'] = 'категория размещения:';
$_['entry_attribute_separator'] = 'Атрибут сепаратор:';
$_['entry_add'] = 'Добавить:';
$_['entry_show_products_from_subcategories'] = 'Показывать также продукты из подкатегорий в каждой категории:';
$_['entry_content_selector'] = 'Содержимое селектора (в JavaScript):';
$_['entry_in_stock_status'] = 'Статус Наличия:';
$_['entry_set_default_sort_for'] = 'Установить по умолчанию для сортировки:';
$_['entry_javascript'] = 'пользовательский код JavaScript:';
$_['entry_set_images'] = 'Установить изображения:';
$_['entry_root_category'] = 'Корневая категория:';
$_['entry_level_name'] = 'Название уровня:';
$_['entry_show_button'] = 'Показывать кнопку:';
$_['entry_always_show_go_back_to_top'] = 'Always show button "Go to top" if possible';
$_['entry_show_loader_over_results'] = 'Посмотреть погрузчик по сравнению с результатами**:';
$_['entry_show_loader_over_filter'] = 'Посмотреть погрузчик через фильтр**:';
$_['entry_refresh_results'] = 'Обновить результаты:';
$_['entry_hide_inactive_values'] = 'Скрыть неактивные значения:';
$_['entry_not_remember_filter_for_subcategories'] = 'Не запоминать настройки фильтров для подкатегорий**';
$_['entry_color_search_button_background'] = 'Цвет фона кнопки поиска:';
$_['entry_color_slider_background'] = 'Цвет фона слайдера:';
$_['entry_color_header_border_bottom'] = 'Цвет нижней границы заголовка:';
$_['entry_limit_live_filter'] = 'Отображать, если элементов больше, чем (введите значение > 0):<span class="help">этот параметр работает только с типами: checkbox, radio, image list checkbox, image list radio.</span>';
$_['entry_enable_cache'] = 'Включить кеш:<span class="help">Данные обновляются раз в 24 часа.</span>';
$_['entry_add_new_type'] = 'Добавить новый тип:';
$_['entry_manual_init'] = 'Инициализировать фильтр вручную:';
$_['entry_display_options_inline_horizontal'] = 'Display options in one line in horizontal mode:';
$_['entry_image_size'] = 'Размер изображения [Ш x В]:';
$_['entry_change_top_to_column_on_mobile'] = 'Изменить позицию "Топ" раздвижного виджета на мобильных устройствах';
$_['entry_type_of_condition'] = 'Тип состоянии между вариантами той же группы:';
$_['entry_home_page_by_ajax'] = 'Результаты нагрузки по AJAX на домашнюю страницу';
$_['entry_customer_groups'] = 'группы клиентов:';
$_['entry_ajax_pagination'] = 'AJAX нумерация страниц:';
$_['entry_forum'] = 'Forum:';
$_['entry_support'] = 'Support:';
$_['entry_widget_button_background'] = 'Цвет фона кнопки виджета:';
$_['entry_documentation'] = 'документация:';
$_['entry_display_always_as_widget'] = 'Display always as widget:';
$_['entry_color_of_loader_over_results'] = 'Color of loader over results:';
$_['entry_color_of_loader_over_filter'] = 'Color of loader over filter:';
$_['entry_language_pack_version'] = 'Language pack version:';
$_['entry_meta_title'] = 'Meta title:';
$_['entry_meta_description'] = 'Meta description:';
$_['entry_meta_keyword'] = 'Meta keyword:';
$_['entry_description'] = 'Description (for categories):';
$_['entry_h1'] = 'H1 (for categories):';
$_['entry_labels'] = 'Labels:';
$_['entry_display_selected_filters'] = 'Display selected filters:';
$_['entry_minify_support'] = 'Support minify of JS/CSS:<br /><small>(Enable this option only if your template or cache module has option to minify. This option may not work with RTL)</small>';
$_['entry_widget_with_swipe'] = 'Show/hide widget via swipe:';
$_['entry_combine_js_css_fiels'] = 'Combine JS/CSS files:<br /><small>(MFP contains a few of JS/CSS files. Enable this option if you want to combine all of them to 1 JS and 1 CSS file)</small>';

// ext
$_['ext_email'] = '<a href="mailto:info@ocdemo.eu" target="_blank">info@ocdemo.eu</a>';

// Tab
$_['tab_layout'] = 'Макет';
$_['tab_settings'] = 'Настройки';
$_['tab_seo'] = 'SEO';
$_['tab_aliases'] = 'Aliases';
$_['tab_attributes'] = 'Атрибуты';
$_['tab_options'] = 'Опции';
$_['tab_filters'] = 'Фильтры';
$_['tab_javascript'] = 'JavaScript';
$_['tab_about']	= 'Поддержка';
$_['tab_refresh_results'] = 'Обновить';
$_['tab_base_attributes'] = 'База Атрибутов';
$_['tab_other']	= 'Прочее';
$_['tab_style'] = 'Стиль';
$_['tab_categories'] = 'Категории';
$_['tab_display_list_of_items'] = 'Просмотр списка элементов';
$_['tab_configuration'] = 'Configuration';
$_['tab_module'] = 'Module';
$_['tab_vehicles'] = 'Vehicles';
$_['tab_default'] = 'Default settings';
$_['tab_default_groups'] = 'Default groups settings';
$_['tab_custom'] = 'Custom';

// Error
$_['error_permission'] = 'предупреждение: У вас не достаточно прав для модификации модуля ' . $_['heading_title'] . '!';
$_['error_tree_categories_duplicate'] = 'Вы не можете добавить более одного дерева модуля!';
$_['error_cat_checkbox_categories_duplicate'] = 'You can\'t add more than one checkbox module!';
$_['error_upgrade_template_file'] = 'Следующие файлы шаблонов, кажется, устарели. Пожалуйста, обновите их:<br />%s';
$_['error_missing_template_file'] = 'Файл шаблона /catalog/view/theme/default/template/module/mega_filter.tpl не существует. Пожалуйста, загрузите его на сервер';
$_['error_cache_dir'] = 'Внимание: Папка Cache (/system/cache_mfp) не существует или у вас нет разрешения на запись!';
$_['error_css_file'] = 'Внимание: Файл /catalog/view/theme/default/stylesheet/mf/style-2.css не существует или у вас нет разрешения на запись!';
$_['error_invalid_url'] = 'Invalid URL';
$_['error_invalid_seo_url'] = 'Invalid SEO Url';
$_['error_tree_checkbox_categories'] = 'You can\'t add "tree" and "checkbox" module in the same time!';
$_['error_mf_dir'] = 'Warning: Folder <code>/catalog/view/theme/default/stylesheet/mf</code> or <code>/catalog/view/javascript/mf</code> doesn\'t exist or you don\'t have write permission! You can\'t use the option "Combine JS/CSS files"';

// Success
$_['success_install'] = 'Success: ' . $_['heading_title'] . ' установлен!';
$_['success_uninstall'] = 'Success: ' . $_['heading_title'] . ' удалить!';
$_['success_updated'] = 'Success: ' . $_['heading_title'] . ' обновлены!';
$_['success_updated_modified_url'] = 'SEO Url has been modified since the same value already exists in the database.';
$_['success_cache_clear'] = 'Успешно: Все файлы в кол-ве (% S) в кэше были удалены!';
?>
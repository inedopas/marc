<?php
class ControllerExtensionModuleSearch extends Controller {
    public function index() {

        $this->load->language('extension/module/search');
        $data['heading_title'] = $this->language->get('heading_title');

        $this->load->language('common/search');

        $data['text_search'] = $this->language->get('text_search');

        if (isset($this->request->get['search'])) {
            $data['search'] = $this->request->get['search'];
        } else {
            $data['search'] = '';
        }

        return $this->load->view('extension/module/search', $data);

    }

    public function info() {
        $this->response->setOutput($this->index());
    }
}

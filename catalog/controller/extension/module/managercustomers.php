<?php

class ControllerExtensionModuleManagerCustomers extends Controller
{
    public function index()
    {
        $data['managers'] = [];
        $customer_group_id = $this->customer->getGroupId();
        $user_group_id = null;

        $this->load->model('extension/module/managercustomers');

        $user_groups = $this->cache->get('managercustomers_usergroups');

        if (empty($user_groups)) {
            $user_groups = $this->model_extension_module_managercustomers->getUserGroups();
            $this->cache->set('managercustomers_usergroups', $user_groups);
        }

        if (!is_array($user_groups)) {
            return $this->load->view('extension/module/managercustomers', $data);
        }

        foreach ($user_groups as $group) {

            if (in_array($customer_group_id, json_decode($group['customer_groups']))) {
                $user_group_id = (int)$group['user_group_id'];
                continue;
            }
        }
        
        if (null === $user_group_id) {
            return $this->load->view('extension/module/managercustomers', $data);
        }

        $users = $this->cache->get('managercustomers_users' . $user_group_id);

        if (empty($users)) {
            $users = $this->model_extension_module_managercustomers->getUsersByGroup($user_group_id);
            $this->cache->set('managercustomers_users' . $user_group_id, $users);
        }

        $data['managers'] = $users;
        return $this->load->view('extension/module/managercustomers', $data);
    }
}

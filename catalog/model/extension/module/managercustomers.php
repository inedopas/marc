<?php
class ModelExtensionModuleManagerCustomers extends Model
{
    public function getUserGroups()
    {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX .
            "user_group` WHERE customer_groups != ''");

        return $query->rows;
    }

    public function getUsersByGroup($group_id)
    {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX .
            "user` WHERE user_group_id = {$group_id} AND status = 1");

        return $query->rows;
    }
}
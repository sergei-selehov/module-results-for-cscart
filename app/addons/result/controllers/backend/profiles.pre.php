<?php

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($mode == 'update' || $mode == 'add') {
        $date = fn_parse_date($_REQUEST['user_data']['result_employment_date']);
        if ($date == 0) {
            $date = time();
        }
        $_REQUEST['user_data']['result_employment_date'] = $date;
        
        $_REQUEST['user_data']['result_salary'] = (int)$_REQUEST['user_data']['result_salary'];
        if (empty($_REQUEST['user_data']['result_calc'])) {
            $_REQUEST['user_data']['result_calc'] = 'N';
        }
        if (empty($_REQUEST['user_data']['result_head'])) {
            $_REQUEST['user_data']['result_head'] = 'N';
        }
        if (empty($_REQUEST['user_data']['result_remote'])) {
            $_REQUEST['user_data']['result_remote'] = 'N';
        }
    }
}

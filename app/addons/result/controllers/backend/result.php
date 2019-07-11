<?php

use Tygh\Registry;

// Администратор
$getArrayId = fn_get_result_settings('admins_id');
foreach ($getArrayId as $id){
    if ($id == $auth['user_id']){
        $isAdmin = true;
    }
}

//Настройки
$settingsResult = fn_get_result_settings();

//Секция POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if ($isAdmin) {
        if ($mode == 'settings') {
            fn_post_result_settings($_REQUEST['settingsResult']);
            fn_set_notification('N', __('notice'), 'Настройки сохранены');
            return array(CONTROLLER_STATUS_OK, "result.settings");
        }
        if ($mode == 'rating_settings') {
            fn_post_rating_settings($_REQUEST['rating_setting']);
            fn_set_notification('N', __('notice'), 'Настройки оценки звонков Call-менеджера сохранены');
            return array(CONTROLLER_STATUS_OK, "result.rating_settings");
        }
    }
    if ($mode == 'rating') {
        fn_post_rating_call_managers($_REQUEST['rating']);
        fn_set_notification('N', __('notice'), 'Рейтинг успешно сохранен');
        return array(CONTROLLER_STATUS_OK, "result.rating");
    }

    $_REQUEST[''];
    return array(CONTROLLER_STATUS_OK, "result.manage");
}

// Секция GET
if ($mode == 'manage') {
    if (!isset($_REQUEST['object'])){
        $managers = NULL;
        $visits = NULL;
        $plan_visits = NULL;
        $params = $_REQUEST;
    } else {
        if (!empty($_REQUEST['yer']) && !empty($_REQUEST['month'])){
            list($managers, $visits, $plan_visits, $params) = fn_get_results_data($_REQUEST);
            if (empty($managers)){
                fn_set_notification('E', __('error'), 'Данные не найдены');
            } else {
                fn_set_notification('N', __('notice'), 'Данные успешно выгружены из БД');
            }
        } else {
            list($managers, $visits, $plan_visits, $params) = fn_get_results($_REQUEST, $isAdmin);
        }
    }

    if (!empty($_REQUEST['cron']) && $_REQUEST['cron'] == 'Y'){
        fn_insert_cron_result($managers);
        //CronJob 1 в месяц
    }

    $urlUsers = fn_get_string_user_id_usergroup(fn_get_result_settings('usergroup_id'));
    $idUserAuth = $_SESSION['auth']['user_id'];
    fn_calculate_num_paid();

    Tygh::$app['view']->assign(array(
        'managers' => $managers,
        'count' => $count,
        'isAdmin' => $isAdmin,
        'urlUsers' => $urlUsers,
        'idUserAuth' => $idUserAuth,
        'plan_visits' => $plan_visits,
        'visits' => $visits,
        'search' => $params,
        'settingsResult' => $settingsResult
    ));
} elseif ($mode == 'rating_settings') {
    if ($isAdmin) {
        $rating_settings = fn_get_rating_settings();

        Tygh::$app['view']->assign(array(
            'rating_settings' => $rating_settings
        ));
    }
} elseif ($mode == 'settings') {
    if ($isAdmin) {
        if (isset($_REQUEST['calculate_average_num']) && $_REQUEST['calculate_average_num'] == 'Y') {
            $calculate_average_num = fn_calculate_average_num();
            fn_set_notification('N', __('notice'), 'Среднее количество номенклатуры во всех заказах менеджера ' . $calculate_average_num);
            return array(CONTROLLER_STATUS_OK, "result.settings");
        }
        if (isset($_REQUEST['calculate_num_paid']) && $_REQUEST['calculate_num_paid'] == 'Y') {
            $calculate_num_paid = fn_calculate_num_paid();
            fn_set_notification('N', __('notice'), 'Количествово активных менеджеров ' . $calculate_num_paid);
            return array(CONTROLLER_STATUS_OK, "result.settings");
        }

        Tygh::$app['view']->assign(array(
            'settingsResult' => $settingsResult
        ));
    }
} elseif ($mode == 'rating') {
    if (isset($_REQUEST['insert_ratings']) && $_REQUEST['insert_ratings'] == 'Y') {
        fn_insert_ratings();
        //CronJob 1 в месяц
    }
    $ratings = fn_get_rating_call_managers($_REQUEST);

    Tygh::$app['view']->assign(array(
        'isAdmin' => $isAdmin,
        'ratings' => $ratings
    ));
}
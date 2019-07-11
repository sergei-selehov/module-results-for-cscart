<?php

use Tygh\Registry;
use Tygh\Http;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

date_default_timezone_set('UTC');

/**
 * Хук для мультиселекта в фильтрах заказов
 *
 * @param &$params
 * @param $fields
 * @param $sortings
 * @param &$condition
 * @param $join
 * @param $group
 */
function fn_result_get_orders(&$params, $fields, $sortings, &$condition, $join, $group)
{
    if (!empty($params['managers'])) {
        $condition .= db_quote(' AND ?:orders.issuer_id IN (?a) ', $params['managers']);
    }
}

/**
 * Хук профиля пользователя
 *
 * @param $params
 * @param $fields
 * @param $sortings
 * @param $condition
 * @param $join
 * @param $auth
 */
function fn_result_get_users($params, &$fields, $sortings, &$condition, $join, $auth)
{
    $fields['result_salary'] = '?:users.result_salary';
    $fields['result_employment_date'] = '?:users.result_employment_date';
    $fields['result_calc'] = '?:users.result_calc';
    $fields['result_head'] = '?:users.result_head';
    $fields['result_remote'] = '?:users.result_remote';

    if (!empty($params['result_calc'])) {
        $condition['result_calc'] = db_quote(" AND ?:users.result_calc=(?s)", $params['result_calc']);
    }
    if (!empty($params['result_head'])) {
        $condition['result_head'] = db_quote(" AND ?:users.result_head=(?s)", $params['result_head']);
    }
    if (!empty($params['result_remote'])) {
        $condition['result_remote'] = db_quote(" AND ?:users.result_remote=(?s)", $params['result_remote']);
    }
}

/**
 * Получаем данные с Яндекс Метрики
 *
 * @param $time_from
 * @param $time_to
 *
 * @return int
 */
function fn_result_get_visits($time_from, $time_to)
{
    static $v;
    if (!empty($v)) {
        return $v;
    }

    $time_from = empty($time_from) ? 1325376000 : fn_parse_date($time_from);
    $time_to = empty($time_to) ? TIME : fn_parse_date($time_to, true);

    $q = "https://api-metrika.yandex.net/stat/v1/data/";
    $data = [
        'metrics' => 'ym:s:visits',
        'id' => fn_get_result_settings('yandex_id_metrics'),
        'date1' => date('Y-m-d', $time_from),
        'date2' => date('Y-m-d', $time_to),
    ];
    // вынести в настройки
    $e = [
        'headers' => [
            'Authorization: Bearer ' . fn_get_result_settings('yandex_token_auth')
        ]
    ];

    $res = Http::get($q, $data, $e);
    $res = json_decode($res, true);
    //fn_print_die(array_shift($v['totals']));
    if (empty($res['totals']) || empty($res['totals'][0])) {
        $v = 0;
    } else {
        $v = intval($res['totals'][0]);
    }
    return $v;
}

/**
 * Получаем данные с Google Table
 *
 * @param $date
 *
 * @return array
 */
function fn_google_table($date)
{
    $apiKey = fn_get_result_settings('google_api_key');
    $nameList = $date;
    $range = fn_get_result_settings('google_range_from') . ':' . fn_get_result_settings('google_range_to');
    $idSpreadsheets = fn_get_result_settings('google_id_table');
    $url = 'https://sheets.googleapis.com/v4/spreadsheets/' . $idSpreadsheets . '/values/' . $nameList . '!' . $range . '?majorDimension=COLUMNS&key=' . $apiKey;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HTTPGET, 1);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($ch);
    curl_close($ch);

    $json = json_decode($result);

    return $json;
}

/**
 * Расчет заработной платы
 *
 * @param $performance
 * @param $salary
 *
 * @return int
 */
function fn_result_pay_manager($performance, $salary)
{
    $res = 0;
    if ($performance <= 94) {
        $res = $performance;
    } elseif ($performance == 95) {
        $res = 100;
    } elseif ($performance == 96) {
        $res = 110;
    } elseif ($performance == 97) {
        $res = 120;
    } elseif ($performance == 98) {
        $res = 130;
    } elseif ($performance == 99) {
        $res = 140;
    } elseif ($performance == 100) {
        $res = 150;
    } elseif ($performance > 100) {
        $res = $performance - 100 + 150;
    }

    $r = [
        75 => 75,
        76 => 76,
        77 => 77,
        78 => 78,
        79 => 79,
        80 => 80,
        81 => 81,
        82 => 82,
        83 => 83,
        84 => 84,
        85 => 85,
        86 => 86,
        87 => 87,
        88 => 88,
        89 => 89,
        90 => 90,
        91 => 91,
        92 => 92,
        93 => 93,
        94 => 94,
        95 => 100,
        96 => 110,
        97 => 120,
        98 => 130,
        99 => 140,
        100 => 150,
        101 => 152,
        102 => 154,
        103 => 156,
        104 => 158,
        105 => 160,
        106 => 162,
        107 => 164,
        108 => 166,
        109 => 168,
        110 => 180,
        111 => 182,
        112 => 184,
        113 => 186,
        114 => 188,
        115 => 190,
        116 => 192,
        117 => 194,
        118 => 196,
        119 => 198,
        120 => 210,
        121 => 212,
        122 => 214,
        123 => 216,
        124 => 218,
        125 => 220,
        126 => 222,
        127 => 224,
        128 => 226,
        129 => 228,
        130 => 240,
        131 => 242,
        132 => 244,
        133 => 246,
        134 => 248,
        135 => 250,
        136 => 252,
        137 => 254,
        138 => 256,
        139 => 258,
        140 => 270,
        141 => 272,
        142 => 274,
        143 => 276,
        144 => 278,
        145 => 280,
        146 => 282,
        147 => 284,
        148 => 286,
        149 => 288,
        150 => 290,
        151 => 292,
        152 => 294,
        153 => 296,
        154 => 298,
        155 => 300,
        156 => 302,
        157 => 304,
        158 => 306,
        159 => 308,
        160 => 310,
        161 => 312,
        162 => 314,
        163 => 316,
        164 => 318,
        165 => 320,
        166 => 322,
        167 => 324,
        168 => 326,
        169 => 328,
        170 => 330,
        171 => 332,
        172 => 334,
        173 => 336,
        174 => 338,
        175 => 340,
        176 => 342,
        177 => 344,
        178 => 346,
        179 => 348,
        180 => 350,
        181 => 352,
        182 => 354,
        183 => 356,
        184 => 358,
        185 => 360,
        186 => 362,
        187 => 364,
        188 => 366,
        189 => 368,
        190 => 370,
        191 => 372,
        192 => 374,
        193 => 376,
        194 => 378,
        195 => 380,
        196 => 382,
        197 => 384,
        198 => 386,
        199 => 388,
        200 => 390,
    ];

    if (isset($r[$performance])) {
        $res = $r[$performance];
    }

    $total = ($salary * $res / 100) + $salary;
    //$total = ($salary * $res / 100);
    return $total;
}

///**
// * Настройки расчета результативности
// *
// * @return array
// */
//function fn_get_result_settings()
//{
//    $settings = db_get_row("SELECT * FROM ?:result_settings");
//    return $settings;
//}

/**
 * Настройки результативности
 *
 * @param $fields
 *
 * @return array
 */
function fn_get_result_settings($fields = null)
{
    $settings = array();
    foreach (db_get_array("SELECT * FROM ?:result_settings") as $setting) {
        if (empty($fields)) {
            $settings[$setting['name_options']] = $setting['parameter'];
            if ($setting['parameter'][0] == '[' && $setting['parameter'][strlen($setting['parameter']) - 1] == ']') {
                $settings[$setting['name_options']] = json_decode($setting['parameter']);
            }
        } else {
            if ($setting['name_options'] == $fields) {
                if ($setting['parameter'][0] == '[' && $setting['parameter'][strlen($setting['parameter']) - 1] == ']') {
                    return json_decode($setting['parameter']);
                }
                return $setting['parameter'];
            }
        }
    }
    return $settings;
}

/**
 * Редактирование настроек
 *
 * @param $data
 *
 * @return bool
 */
function fn_post_result_settings($data)
{
    $settings = db_get_array("SELECT * FROM ?:result_settings");
    if (!empty($settings)) {
        foreach ($data as $name_options => $parameter) {
            if (is_array($parameter)) {
                $parameter = json_encode($parameter);
            }
            if (!in_array($name_options, array_column($settings, 'name_options')) && !empty($parameter)) {
                db_query('INSERT INTO ?:result_settings (name_options, parameter) VALUES (?s, ?s)', $name_options, $parameter);
            }
            foreach ($settings as $setting) {
                if ($setting['name_options'] == $name_options && !empty($parameter) && $parameter != $setting['name_options']) {
                    db_query('UPDATE ?:result_settings SET parameter = ?s WHERE name_options = ?s', $parameter, $name_options);
                } else {
                    continue;
                }
            }
        }
    } else {
        foreach ($data as $name_options => $parameter) {
            db_query('INSERT INTO ?:result_settings (name_options, parameter) VALUES (?s, ?s)', $name_options, $parameter);
        }
    }

    return true;
}

/**
 * Расчет среднего количества номенклатуры во всех заказах менеджера
 *
 * @return int
 */
function fn_calculate_average_num()
{
    $time_from = date("Y-m-d", strtotime('-6 month'));
    $time_to = date("Y-m-d", TIME);

    $orders = fn_get_orders([
        'time_from' => $time_from,
        'time_to' => $time_to
    ])[0];

    $sumOrd = 0;
    foreach ($orders as $order) {
        $orderDetails = db_get_array("SELECT DISTINCT product_id FROM ?:order_details WHERE order_id = ?i", $order['order_id']);
        $sumOrd = $sumOrd + count($orderDetails);
    }

    $calculate = $sumOrd / count($orders);
    fn_post_result_settings(array('average_num_items_orders2' => $calculate));

    return $calculate;
}

/**
 * Расчет среднего количества оплаченных заказов у персонального менеджера
 *
 * @return int
 */
function fn_calculate_num_paid()
{
    $usersActive = fn_get_users([
        'usergroup_id' => fn_get_result_settings('usergroup_id'),
        'status' => 'A',
        'result_calc' => 'Y',
        'result_head' => 'N',
        'result_remote' => 'N'
    ], $auth)[0];
    fn_post_result_settings(array('num_paid_order_personal_manager2' => count($usersActive)));

    return count($usersActive);
}

/**
 * Получение рейтинга call-менеджеров
 *
 * @param $params
 *
 * @return array
 */
function fn_get_rating_call_managers($params)
{
    $time_from = empty($params['time_from']) ? 0 : fn_parse_date($params['time_from']);
    $time_to = empty($params['time_to']) ? 0 : fn_parse_date($params['time_to']);

    $ratingsDB = db_get_array("SELECT * FROM ?:rating_call_managers WHERE time_from <= ?i AND time_to >= ?i", $time_from, $time_to);
    $ratings = [];
    foreach ($ratingsDB as $rating) {
        $user = fn_get_users(['user_id' => $rating['manager_id'], 'status' => 'A', 'result_calc' => 'Y'], $auth)[0][0];
        $userName = $user['lastname'] . ' ' . $user['firstname'];
        $rating = [
            'manager_id' => $rating['manager_id'],
            'manager_name' => $userName,
            'status' => 'A',
            'options' => json_decode($rating['options'], true),
            'time_from' => $rating['time_from'],
            'time_to' => $rating['time_to']
        ];
        array_push($ratings, $rating);
    }
    return $ratings;
}

/**
 * Получение рейтинга определенного call-менеджера
 *
 * @param $user_id
 * @param $time_from
 * @param $time_to
 *
 * @return array
 */
function fn_get_rating_options_find($user_id, $time_from, $time_to)
{
    $rating = db_get_row("SELECT * FROM ?:rating_call_managers WHERE manager_id = ?i AND time_from <= ?i AND time_to >= ?i", $user_id, $time_from, $time_to);
    $rating = json_decode($rating['options'], true);
    return $rating;
}

/**
 * Редактирование/Добавление рейтинга call-менеджера в БД
 *
 * @param $data
 *
 * @return bool
 */
function fn_post_rating_call_managers($data)
{
    $time_from = fn_parse_date($data['time_from']);
    $time_to = fn_parse_date($data['time_to']);

    $rating = db_get_array("SELECT * FROM ?:rating_call_managers WHERE time_from <= ?i AND time_to >= ?i", $time_from, $time_to);
    if (empty($rating)) {
        db_query('INSERT INTO ?:rating_call_managers (manager_id, options, time_from, time_to ) VALUES (?i, ?s, ?i, ?i)', $data['manager_id'], json_encode($data['options']), $time_from, $time_to);
    } else {
        db_query('UPDATE ?:rating_call_managers SET options = ?s WHERE manager_id = ?i AND time_from <= ?i AND time_to >= ?i',
            json_encode($data['options']), $data['manager_id'], $time_from, $time_to);
    }
    return true;
}

/**
 * Редактирование настроек рейтинга call-менеджера
 *
 * @param $data
 *
 * @return bool
 */
function fn_post_rating_settings($data)
{
    if (!empty($data)) {
        $time_from = strtotime('first day of this month', mktime(0, 0, 0)); // Начало текущего месяца 00:00:00
        $time_to = strtotime('last day of this month', mktime(23, 59, 59)); // Конец текущего месяца 23:59:59
        db_query('UPDATE ?:rating_settings SET ?u', $data);

        $param = ['time_from' => $time_from, 'time_to' => $time_to];
        $ratings = fn_get_rating_call_managers($param);
        foreach ($ratings as $rating) {
            $options['options'] = json_encode(array_replace($rating['options'], $data));
            $rating = array_replace($rating, $options);
            db_query('UPDATE ?:rating_call_managers SET options = ?s WHERE manager_id = ?i AND time_from <= ?i AND time_to >= ?i', $rating['options'], $rating['manager_id'], $time_from, $time_to);
        }
    }
    return true;
}

/**
 * Запись результативности в БД раз в месяц CronJob
 *
 * @param $data
 *
 * @return bool
 */
function fn_insert_cron_result($data)
{
    foreach ($data as $manager) {
        $arrayManager = [
            'result_salary' => $manager['result_salary'],
            'work_experience' => $manager['work_experience'],
            'pay' => $manager['pay'],
            'result' => $manager['result']
        ];
        $arrayManager = json_encode($arrayManager);
        db_query('INSERT INTO ?:results (manager_id, options, time_from, time_to) VALUES (?i, ?s, ?i, ?i)', $manager['user_id'], $arrayManager, $manager['result']['time_from'], $manager['result']['time_to']);
    }
    return true;
}

/**
 * Получение настроек рейтинга call-менеджера
 *
 * @return array
 */
function fn_get_rating_settings()
{
    $callSettings = db_get_row("SELECT * FROM ?:rating_settings");
    return $callSettings;
}

/**
 * Запись рейтинга call-менеджера из GoogleTable в БД
 *
 * @return bool
 */
function fn_insert_ratings()
{
    $date = 'апр';
    $jsonG = fn_google_table($date);
    $jsonTable1 = $jsonG->values;

    $time_from = strtotime('first day of this month', mktime(0, 0, 0)); // Начало текущего месяца 00:00:00
    $time_to = strtotime('last day of this month', mktime(23, 59, 59)); // Конец текущего месяца 23:59:59

    $users = fn_get_users(array(
        'usergroup_id' => fn_get_result_settings('usergroup_id'),
        'status' => 'A',
        'result_calc' => 'Y'
    ), $auth);
    $rating = db_get_array("SELECT * FROM ?:rating_call_managers WHERE time_from <= ?i AND time_to >= ?i", $time_from, $time_to);

    foreach ($users[0] as $user) {
        $nameUser = $user['lastname'] . ' ' . $user['firstname'];

        foreach ($jsonTable1 as $table) {
            $table = str_replace(",", ".", $table);
            $weight = substr($table[rand(1, 9)], -1);

            if ($weight == '%') {
                $weightTable = [
                    'greeting_weight' => substr($table[1], 0, -1),
                    'courtesy_weight' => substr($table[2], 0, -1),
                    'help_client_weight' => substr($table[3], 0, -1),
                    'work_objections_weight' => substr($table[4], 0, -1),
                    'thanks_weight' => substr($table[5], 0, -1),
                    'stock_notice_weight' => substr($table[6], 0, -1),
                    'promise_callback_weight' => substr($table[7], 0, -1),
                    'product_knowledge_weight' => substr($table[8], 0, -1),
                    'discipline_weight' => substr($table[9], 0, -1)
                ];
                fn_post_rating_settings($weightTable);
            }

            if ($table[0] == $nameUser) {

                $planTable = [
                    'greeting_plan' => 5,
                    'courtesy_plan' => 5,
                    'help_client_plan' => 5,
                    'work_objections_plan' => 5,
                    'thanks_plan' => 5,
                    'stock_notice_plan' => 5,
                    'promise_callback_plan' => $table[7],

                    'product_knowledge_plan' => 5,
                    'discipline_plan' => 5,

                    'count_call_plan' => 0,
                ];

                $factTable = [
                    'greeting_fact' => $table[1],
                    'courtesy_fact' => $table[2],
                    'help_client_fact' => $table[3],
                    'work_objections_fact' => $table[4],
                    'thanks_fact' => $table[5],
                    'stock_notice_fact' => $table[6],
                    'promise_callback_fact' => $table[12],

                    'product_knowledge_fact' => $table[8] ? $table[8] : 0,
                    'discipline_fact' => $table[9] ? $table[9] : 0,

                    'count_call_fact' => $table[14]
                ];

                $percentTable = [
                    'greeting_percent' => round($factTable['greeting_fact'] / $planTable['greeting_plan'], 2) * 100,
                    'courtesy_percent' => round($factTable['courtesy_fact'] / $planTable['courtesy_plan'], 2) * 100,
                    'help_client_percent' => round($factTable['help_client_fact'] / $planTable['help_client_plan'], 2) * 100,
                    'work_objections_percent' => round($factTable['work_objections_fact'] / $planTable['work_objections_plan'], 2) * 100,
                    'thanks_percent' => round($factTable['thanks_fact'] / $planTable['thanks_plan'], 2) * 100,
                    'stock_notice_percent' => round($factTable['stock_notice_fact'] / $planTable['stock_notice_plan'], 2) * 100,
                    'promise_callback_percent' => round($factTable['promise_callback_fact'] / $planTable['promise_callback_plan'], 2) * 100,

                    'product_knowledge_fact' => round($factTable['product_knowledge_fact'] / $planTable['product_knowledge_plan'], 2) * 100,
                    'discipline_fact' => round($factTable['discipline_fact'] / $planTable['discipline_plan'], 2) * 100,

                    'count_call_fact' => $table[14]
                ];

                $json = [
                    'greeting_weight' => $weightTable['greeting_weight'],
                    'greeting_plan' => $planTable['greeting_plan'],
                    'greeting_fact' => $factTable['greeting_fact'],
                    'greeting_percent' => $percentTable['greeting_percent'],

                    'courtesy_weight' => $weightTable['courtesy_weight'],
                    'courtesy_plan' => $planTable['courtesy_plan'],
                    'courtesy_fact' => $factTable['courtesy_fact'],
                    'courtesy_percent' => $percentTable['courtesy_percent'],

                    'help_client_weight' => $weightTable['help_client_weight'],
                    'help_client_plan' => $planTable['help_client_plan'],
                    'help_client_fact' => $factTable['help_client_fact'],
                    'help_client_percent' => $percentTable['help_client_percent'],

                    'work_objections_weight' => $weightTable['work_objections_weight'],
                    'work_objections_plan' => $planTable['work_objections_plan'],
                    'work_objections_fact' => $factTable['work_objections_fact'],
                    'work_objections_percent' => $percentTable['work_objections_percent'],

                    'thanks_weight' => $weightTable['thanks_weight'],
                    'thanks_plan' => $planTable['thanks_plan'],
                    'thanks_fact' => $factTable['thanks_fact'],
                    'thanks_percent' => $percentTable['thanks_percent'],

                    'stock_notice_weight' => $weightTable['stock_notice_weight'],
                    'stock_notice_plan' => $planTable['stock_notice_plan'],
                    'stock_notice_fact' => $factTable['stock_notice_fact'],
                    'stock_notice_percent' => $percentTable['stock_notice_percent'],

                    'promise_callback_weight' => $weightTable['promise_callback_weight'],
                    'promise_callback_plan' => $planTable['promise_callback_plan'],
                    'promise_callback_fact' => $factTable['promise_callback_fact'],
                    'promise_callback_percent' => $percentTable['promise_callback_percent'],

                    'product_knowledge_weight' => $weightTable['product_knowledge_weight'],
                    'product_knowledge_plan' => $planTable['product_knowledge_plan'],
                    'product_knowledge_fact' => $factTable['product_knowledge_fact'],
                    'product_knowledge_percent' => $percentTable['product_knowledge_percent'],

                    'discipline_weight' => $weightTable['discipline_weight'],
                    'discipline_plan' => $planTable['discipline_plan'],
                    'discipline_fact' => $factTable['discipline_fact'],
                    'discipline_percent' => $percentTable['discipline_percent'],

                    'count_call_weight' => $weightTable['count_call_weight'],
                    'count_call_plan' => $planTable['count_call_plan'],
                    'count_call_fact' => $factTable['count_call_fact'],
                    'count_call_percent' => $percentTable['count_call_percent']
                ];

                $finishPercent = ceil(((($weightTable['greeting_weight'] * $percentTable['greeting_percent']) +
                            ($weightTable['courtesy_weight'] * $percentTable['courtesy_percent']) +
                            ($weightTable['help_client_weight'] * $percentTable['help_client_percent']) +
                            ($weightTable['work_objections_weight'] * $percentTable['work_objections_percent']) +
                            ($weightTable['thanks_weight'] * $percentTable['thanks_percent']) +
                            ($weightTable['stock_notice_weight'] * $percentTable['stock_notice_percent']) +
                            ($weightTable['promise_callback_weight'] * $percentTable['promise_callback_fact_percent']) +
                            ($weightTable['product_knowledge_weight'] * $percentTable['product_knowledge_percent']) +
                            ($weightTable['discipline_weight'] * $percentTable['discipline_percent'])) * 100) / 10000);
                $json = array_merge($json, ['finish' => $finishPercent]);
                $json = json_encode($json);

                if (isset($rating) && $rating != array()) {
                    db_query('UPDATE ?:rating_call_managers SET options = ?s WHERE manager_id = ?i AND time_from <= ?i AND time_to >= ?i', $json, $user['user_id'], $time_from, $time_to);
                } else {
                    db_query('INSERT INTO ?:rating_call_managers (manager_id, options, time_from, time_to) VALUES (?i, ?s, ?i, ?i)', $user['user_id'], $json, $time_from, $time_to);
                }
            }
        }
    }

    return true;
}

function fn_get_string_user_id_usergroup($usergroup_id)
{
    $users = fn_get_users(['usergroup_id' => $usergroup_id, 'status' => 'A'], $auth)[0];
    $url = '';
    foreach ($users as $user) {
        $strUsersId [] = $user['user_id'];
        $url .= "&managers[]=" . $user['user_id'];
    }
    return $url;
}

/**
 * Получение сохраненной результативности
 *
 * @param $params
 *
 * @return array
 */
function fn_get_results_data($params)
{
    $time_from = mktime(0, 0, 0, $params['month'], 1, $params['yer']);
    $time_to = mktime(23, 59, 59, $params['month'], date("t", $time_from), $params['yer']);

    $users = fn_get_users([
        'usergroup_id' => fn_get_result_settings('usergroup_id'),
        'status' => 'A',
        'result_calc' => 'Y'
    ], $auth);
    $results = db_get_array("SELECT * FROM ?:results WHERE time_from = ?i AND time_to = ?i", $time_from, $time_to);
    $usersArray = [];
    foreach ($results as $result) {
        foreach ($users[0] as $user) {
            if ($user['user_id'] == $result['manager_id']) {
                $arrayUser = array_merge($user, json_decode($result['options'], true));
                array_push($usersArray, $arrayUser);
            }
        }
    }
    $yn_metric = fn_result_get_visits($time_from, $time_to);
    return ['managers' => $usersArray, 'visits' => $yn_metric, 'plan_visits' => null, 'params' => $params];
}

function fn_get_results($params, $isAdmin)
{
    //Яндекс Метрика
    $yn_metric = fn_result_get_visits(empty($params['time_from']) ? '' : $params['time_from'], empty($params['time_to']) ? '' : $params['time_to']);

    $time_from_r = strtotime('first day of this month', mktime(0, 0, 0)); // Начало текущего месяца 00:00:00
    $time_to_r = strtotime('last day of this month', mktime(23, 59, 59)); // Конец текущего месяца 23:59:59

    $usersArray = [];
    $users = fn_get_users(['usergroup_id' => fn_get_result_settings('usergroup_id'), 'status' => 'A'], $auth)[0];

    // КП - O
    // ЧАСТИЧНО ОПЛАЧЕН - K
    // ЧАСТИЧНО ОТГРУЖЕН - Q
    // ЖДЕМ ОТЗЫВ - M
    // Неудача - F

    // НОВЫЙ - E
    // ОПЛАТА ПРОСРОЧЕНА - J
    // ПЕРЕДАН НА ДОСТАВКУ - W
    // ВЫПОЛНЕН - C
    // Оплачен - P


    // ОТЛОЖЕН - D
    // ОБРАБАТЫВАЕТСЯ - A
    // ДОСТАВЛЯЕТСЯ - H
    // ОТМЕНЁН - I
    // Подтвержден - Y

    // ЖДЕМ ОПЛАТУ - L
    // КОМПЛЕКТУЕТСЯ - B
    // В ПУНКТЕ САМОВЫВОЗА - X
    // ВОЗВРАЩЕН - G

    $allOrdersManagers = [];
    $transferOrdersManagers = [];
    $increasePaidOrdersManagers = [];

    foreach ($users as $user) {
        $allOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $transferOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'status' => Array('D', 'L', 'K', 'J', 'A', 'B', 'Q', 'W', 'H', 'X', 'M', 'C', 'I', 'G', 'F', 'P', 'Y'),
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $increasePaidOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'status' => Array('K', 'Q', 'M', 'W', 'C', 'P', 'A', 'H', 'B', 'X', 'G'),
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $allOrdersManagers = array_merge($allOrdersManagers, $allOrdersManager);
        $transferOrdersManagers = array_merge($transferOrdersManagers, $transferOrdersManager);
        $increasePaidOrdersManagers = array_merge($increasePaidOrdersManagers, $increasePaidOrdersManager);
    }

    $sumIncreasePaidOrdersManagers = 0;
    foreach ($increasePaidOrdersManagers as $key => $value) {
        $sumIncreasePaidOrdersManagers = $sumIncreasePaidOrdersManagers + $value['total'];
    }

    foreach ($users as $user) {
        $paidOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'status' => ['K', 'Q', 'M', 'W', 'C', 'P', 'A', 'H', 'B', 'X', 'G'],
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $crCountNum = 0;
        $sumPaidOrdersManager = 0;
        foreach ($paidOrdersManager as $order) {
            $sumPaidOrdersManager = $sumPaidOrdersManager + $order['total'];

            $orderDetails1 = db_get_array("SELECT DISTINCT product_id FROM ?:order_details WHERE order_id = ?i", $order['order_id']);
            $crCountNum = $crCountNum + count($orderDetails1);
        }

        $countPaidOrdersManager = count($paidOrdersManager);
        $countNum = empty($countPaidOrdersManager) ? 0 : $crCountNum / $countPaidOrdersManager;
        $crSumPaidOrdersManager = is_nan($sumPaidOrdersManager / $countPaidOrdersManager) ? 0 : $sumPaidOrdersManager / $countPaidOrdersManager;

        //Руководитель
        if ($user['result_head'] == 'Y') {
            $paidOrdersManager = array();
            $countUsers = 0;
            $crCountNumSum = 0;
            $crSumPaidOrdersManagerSum = 0;
            foreach ($users as $user_active) {
                $experience = fn_work_experience($user_active['result_employment_date']);
                $first = stristr($experience, '.', true);
                $last = ltrim(stristr($experience, '.'), '.');
                $param = $first . ($first + $first) + $last;

                if ($user_active['result_head'] != 'Y' && $user_active['result_calc'] == 'Y' && $user_active['result_remote'] != 'Y' && $param >= 3) {
                    $paidOrdersManagerActive = fn_get_orders([
                        'issuer_id' => $user_active['user_id'],
                        'status' => ['K', 'Q', 'M', 'W', 'C', 'P', 'A', 'H', 'B', 'X', 'G'],
                        'time_from' => $params['time_from'],
                        'time_to' => $params['time_to'],
                        'period' => $params['period'],
                    ])[0];

                    $crCountNumActive = 0;
                    $sumPaidOrdersManagerActive = 0;
                    foreach ($paidOrdersManagerActive as $order) {
                        $sumPaidOrdersManagerActive = $sumPaidOrdersManagerActive + $order['total'];

                        $orderDetails1 = db_get_array("SELECT DISTINCT product_id FROM ?:order_details WHERE order_id = ?i", $order['order_id']);
                        $crCountNumActive = $crCountNumActive + count($orderDetails1);
                    }

                    $crCountNumActiveEach = empty(count($paidOrdersManagerActive)) ? 0 : $crCountNumActive / count($paidOrdersManagerActive);
                    $crCountNumSum = $crCountNumSum + $crCountNumActiveEach;

                    $sumPaidOrdersManagerActiveEach = is_nan($sumPaidOrdersManagerActive / count($paidOrdersManagerActive)) ? 0 : $sumPaidOrdersManagerActive / count($paidOrdersManagerActive);
                    $crSumPaidOrdersManagerSum = $crSumPaidOrdersManagerSum + $sumPaidOrdersManagerActiveEach;

                    $paidOrdersManager = array_merge($paidOrdersManagerActive, $paidOrdersManager);
                    $countUsers++;
                }
            }
            $countNum = $crCountNumSum / $countUsers;
            $crSumPaidOrdersManager = $crSumPaidOrdersManagerSum / $countUsers;
            $countPaidOrdersManager = count($paidOrdersManager) / $countUsers;
        }

        $time_from = empty($params['time_from']) ? 0 : fn_parse_date($params['time_from']);
        $time_to = empty($params['time_to']) ? 0 : fn_parse_date($params['time_to']);

        $rating = fn_get_rating_options_find($user['user_id'], $time_from, $time_to);
        $settings = fn_get_result_settings();

        // 1) Оформление всех заявок/обращений
        $reg_request_fact = count($allOrdersManagers);
        $reg_request_plan = round($yn_metric * $settings['reg_request2'], -2) / 100;
        $reg_request_percent = round($reg_request_fact / $reg_request_plan, 2) * 100;

        // 2) Перевод заявок/обращений в заказы
        $transfer_request_orders_fact = count($transferOrdersManagers);
        $transfer_request_orders_plan = round($yn_metric * $settings['transfer_request_orders2'], -2) / 100;
        $transfer_request_orders_percent = round($transfer_request_orders_fact / $transfer_request_orders_plan, 2) * 100;

        // 3) Увеличение количества оплаченных заказов
        $inc_paid_orders_fact = count($increasePaidOrdersManagers);
        $inc_paid_orders_plan = round($yn_metric * $settings['inc_paid_orders2'], -2) / 100;
        $inc_paid_orders_percent = round($inc_paid_orders_fact / $inc_paid_orders_plan, 2) * 100;

        // 4) Количество оплаченных заказов у персонального менеджера
        $num_paid_order_personal_manager_fact = round($countPaidOrdersManager);
        $num_paid_order_personal_manager_plan = round($inc_paid_orders_fact / $settings['num_paid_order_personal_manager2']);
        $num_paid_order_personal_manager_percent = round(is_nan($num_paid_order_personal_manager_fact / $num_paid_order_personal_manager_plan) ? 0 : $num_paid_order_personal_manager_fact / $num_paid_order_personal_manager_plan, 2) * 100;

        // 5) Среднее количество номенклатуры во всех заказах менеджера
        $average_num_items_orders_fact = number_format($countNum, 2, '.', '');
        $average_num_items_orders_plan = $settings['average_num_items_orders2'];
        $average_num_items_orders_percent = round($average_num_items_orders_fact / $average_num_items_orders_plan, 2) * 100;

        // 6) Оценка call-аналитика и старшего менеджера
        $rating_senior_manager_fact = empty($rating['finish']) ? 0 : $rating['finish'];
        $rating_senior_manager_plan = $settings['rating_senior_manager2'];
        $rating_senior_manager_percent = round($rating_senior_manager_fact / $rating_senior_manager_plan, 2) * 100;

        // 7) Средний чек
        $average_check_fact = $crSumPaidOrdersManager;
        $average_check_plan = is_nan($sumIncreasePaidOrdersManagers / $inc_paid_orders_fact) ? 0 : $sumIncreasePaidOrdersManagers / $inc_paid_orders_fact;
        $average_check_percent = round(is_nan($average_check_fact / $average_check_plan) ? 0 : $average_check_fact / $average_check_plan, 2) * 100;

        $percentAll = round(((($settings['reg_request'] * $reg_request_percent) +
                    ($settings['transfer_request_orders'] * $transfer_request_orders_percent) +
                    ($settings['inc_paid_orders'] * $inc_paid_orders_percent) +
                    ($settings['num_paid_order_personal_manager'] * $num_paid_order_personal_manager_percent) +
                    ($settings['average_num_items_orders'] * $average_num_items_orders_percent) +
                    ($settings['rating_senior_manager'] * $rating_senior_manager_percent) +
                    ($settings['average_check'] * $average_check_percent)) * 100) / 10000);

        $work_experience = fn_work_experience($user['result_employment_date']);
        $pay = fn_result_pay_manager($percentAll, $user['result_salary']);

        $ordersArray = [
            'manager_id' => $user['user_id'],

            'reg_request_fact' => $reg_request_fact,
            'reg_request_plan' => $reg_request_plan,
            'reg_request_percent' => $reg_request_percent,

            'transfer_request_orders_fact' => $transfer_request_orders_fact,
            'transfer_request_orders_plan' => $transfer_request_orders_plan,
            'transfer_request_orders_percent' => $transfer_request_orders_percent,

            'inc_paid_orders_fact' => $inc_paid_orders_fact,
            'inc_paid_orders_plan' => $inc_paid_orders_plan,
            'inc_paid_orders_percent' => $inc_paid_orders_percent,

            'num_paid_order_personal_manager_fact' => $num_paid_order_personal_manager_fact,
            'num_paid_order_personal_manager_plan' => $num_paid_order_personal_manager_plan,
            'num_paid_order_personal_manager_percent' => $num_paid_order_personal_manager_percent,

            'average_num_items_orders_fact' => $average_num_items_orders_fact,
            'average_num_items_orders_plan' => $average_num_items_orders_plan,
            'average_num_items_orders_percent' => $average_num_items_orders_percent,

            'rating_senior_manager_fact' => $rating_senior_manager_fact,
            'rating_senior_manager_plan' => $rating_senior_manager_plan,
            'rating_senior_manager_percent' => $rating_senior_manager_percent,

            'average_check_fact' => $average_check_fact,
            'average_check_plan' => $average_check_plan,
            'average_check_percent' => $average_check_percent,

            'percentAll' => $percentAll,
            'pay' => $pay,
            'time_from' => $time_from_r,
            'time_to' => $time_to_r,
        ];

        $user = array_merge($user, ['work_experience' => $work_experience]);

        if (!empty($isAdmin) || $params['isAdmin'] == 'passAdminForCronJob') {
            $user = array_merge($user, ['result' => $ordersArray]);
        }

        if (empty($params['isAdmin'])) {
            $planManager = fn_get_plan_results($params, $user['user_id']);
            $user = array_merge($user, ['plan_result' => $planManager['plan_result']]);
        }
        array_push($usersArray, $user);
    }


    $plan_visits = fn_get_result_settings('result_visits');
    //Sort
    list($usersArray, $params) = fn_sort_result($usersArray, $params, 'lastname');

    return array($usersArray, $yn_metric, $plan_visits, $params);
}

function fn_get_plan_results($params, $user_id)
{
    $yn_metric = fn_get_result_settings('result_visits');
    $resultCountOrders = fn_get_result_settings('result_count_orders');
    $averageCheck = fn_get_result_settings('result_average_check');

    $usersArray = [];
    $users = fn_get_users(['usergroup_id' => fn_get_result_settings('usergroup_id'), 'status' => 'A'], $auth)[0];

    // КП - O
    // ЧАСТИЧНО ОПЛАЧЕН - K
    // ЧАСТИЧНО ОТГРУЖЕН - Q
    // ЖДЕМ ОТЗЫВ - M
    // Неудача - F

    // НОВЫЙ - E
    // ОПЛАТА ПРОСРОЧЕНА - J
    // ПЕРЕДАН НА ДОСТАВКУ - W
    // ВЫПОЛНЕН - C
    // Оплачен - P

    // ОТЛОЖЕН - D
    // ОБРАБАТЫВАЕТСЯ - A
    // ДОСТАВЛЯЕТСЯ - H
    // ОТМЕНЁН - I
    // Подтвержден - Y

    // ЖДЕМ ОПЛАТУ - L
    // КОМПЛЕКТУЕТСЯ - B
    // В ПУНКТЕ САМОВЫВОЗА - X
    // ВОЗВРАЩЕН - G

    $allOrdersManagers = [];
    $transferOrdersManagers = [];
    $increasePaidOrdersManagers = [];

    foreach ($users as $user) {
        $allOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $transferOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'status' => Array('D', 'L', 'K', 'J', 'A', 'B', 'Q', 'W', 'H', 'X', 'M', 'C', 'I', 'G', 'F', 'P', 'Y'),
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $increasePaidOrdersManager = fn_get_orders([
            'issuer_id' => $user['user_id'],
            'status' => Array('K', 'Q', 'M', 'W', 'C', 'P', 'A', 'H', 'B', 'X', 'G'),
            'time_from' => $params['time_from'],
            'time_to' => $params['time_to'],
            'period' => $params['period'],
        ])[0];

        $allOrdersManagers = array_merge($allOrdersManagers, $allOrdersManager);
        $transferOrdersManagers = array_merge($transferOrdersManagers, $transferOrdersManager);
        $increasePaidOrdersManagers = array_merge($increasePaidOrdersManagers, $increasePaidOrdersManager);
    }

    $sumIncreasePaidOrdersManagers = 0;
    foreach ($increasePaidOrdersManagers as $key => $value) {
        $sumIncreasePaidOrdersManagers = $sumIncreasePaidOrdersManagers + $value['total'];
    }

    foreach ($users as $user) {
        if ($user_id == $user['user_id']) {
            $paidOrdersManager = fn_get_orders([
                'issuer_id' => $user['user_id'],
                'status' => Array('K', 'Q', 'M', 'W', 'C', 'P', 'A', 'H', 'B', 'X', 'G'),
                'time_from' => $params['time_from'],
                'time_to' => $params['time_to'],
                'period' => $params['period'],
            ])[0];

            $crCountNum = 0;
            $sumPaidOrdersManager = 0;
            foreach ($paidOrdersManager as $key => $val) {
                $sumPaidOrdersManager = $sumPaidOrdersManager + $val['total'];

                $orderDetails1 = db_get_array("SELECT DISTINCT product_id FROM ?:order_details WHERE order_id = ?i", $val['order_id']);
                $crCountNum = $crCountNum + count($orderDetails1);
            }

            $countPaidOrdersManager = count($paidOrdersManager);
            $countNum = empty($countPaidOrdersManager) ? 0 : $crCountNum / $countPaidOrdersManager;
            $crSumPaidOrdersManager = is_nan($sumPaidOrdersManager / $countPaidOrdersManager) ? 0 : $sumPaidOrdersManager / $countPaidOrdersManager;

            //Руководитель
            if ($user['result_head'] == 'Y') {
                $paidOrdersManager = array();
                $countUsers = 0;
                $crCountNumSum = 0;
                $crSumPaidOrdersManagerSum = 0;
                foreach ($users as $user_active) {
                    $experience = fn_work_experience($user_active['result_employment_date']);
                    $first = stristr($experience, '.', true);
                    $last = ltrim(stristr($experience, '.'), '.');
                    $param = $first . ($first + $first) + $last;

                    if ($user_active['result_head'] != 'Y' && $user_active['result_calc'] == 'Y' && $user_active['result_remote'] != 'Y' && $param >= 3) {
                        $paidOrdersManagerActive = fn_get_orders([
                            'issuer_id' => $user_active['user_id'],
                            'status' => ['K', 'Q', 'M', 'W', 'C', 'P', 'A', 'H', 'B', 'X', 'G'],
                            'time_from' => $params['time_from'],
                            'time_to' => $params['time_to'],
                            'period' => $params['period'],
                        ])[0];

                        $crCountNumActive = 0;
                        $sumPaidOrdersManagerActive = 0;
                        foreach ($paidOrdersManagerActive as $order) {
                            $sumPaidOrdersManagerActive = $sumPaidOrdersManagerActive + $order['total'];

                            $orderDetails1 = db_get_array("SELECT DISTINCT product_id FROM ?:order_details WHERE order_id = ?i", $order['order_id']);
                            $crCountNumActive = $crCountNumActive + count($orderDetails1);
                        }

                        $crCountNumActiveEach = empty(count($paidOrdersManagerActive)) ? 0 : $crCountNumActive / count($paidOrdersManagerActive);
                        $crCountNumSum = $crCountNumSum + $crCountNumActiveEach;

                        $sumPaidOrdersManagerActiveEach = is_nan($sumPaidOrdersManagerActive / count($paidOrdersManagerActive)) ? 0 : $sumPaidOrdersManagerActive / count($paidOrdersManagerActive);
                        $crSumPaidOrdersManagerSum = $crSumPaidOrdersManagerSum + $sumPaidOrdersManagerActiveEach;

                        $paidOrdersManager = array_merge($paidOrdersManagerActive, $paidOrdersManager);
                        $countUsers++;
                    }
                }
                $countNum = $crCountNumSum / $countUsers;
                $crSumPaidOrdersManager = $crSumPaidOrdersManagerSum / $countUsers;
                $countPaidOrdersManager = count($paidOrdersManager) / $countUsers;
            }

            $time_from = empty($params['time_from']) ? 0 : fn_parse_date($params['time_from']);
            $time_to = empty($params['time_to']) ? 0 : fn_parse_date($params['time_to']);

            $rating = fn_get_rating_options_find($user['user_id'], $time_from, $time_to);
            $settings = fn_get_result_settings();

            // 1) Оформление всех заявок/обращений
            $reg_request_fact = count($allOrdersManagers);
            $reg_request_plan = round($yn_metric * $settings['reg_request2'], -2) / 100;
            $reg_request_percent = round($reg_request_fact / $reg_request_plan, 2) * 100;

            // 2) Перевод заявок/обращений в заказы
            $transfer_request_orders_fact = count($transferOrdersManagers);
            $transfer_request_orders_plan = round($yn_metric * $settings['transfer_request_orders2'], -2) / 100;
            $transfer_request_orders_percent = round($transfer_request_orders_fact / $transfer_request_orders_plan, 2) * 100;

            // 3) Увеличение количества оплаченных заказов
            $inc_paid_orders_fact = count($increasePaidOrdersManagers);
            $inc_paid_orders_plan = round($yn_metric * $settings['inc_paid_orders2'], -2) / 100;
            $inc_paid_orders_percent = round($inc_paid_orders_fact / $inc_paid_orders_plan, 2) * 100;

            // 4) Количество оплаченных заказов у персонального менеджера
            $num_paid_order_personal_manager_fact = round($countPaidOrdersManager);
            $num_paid_order_personal_manager_plan = $resultCountOrders;
            $num_paid_order_personal_manager_percent = round(is_nan($num_paid_order_personal_manager_fact / $num_paid_order_personal_manager_plan) ? 0 : $num_paid_order_personal_manager_fact / $num_paid_order_personal_manager_plan, 2) * 100;

            // 5) Среднее количество номенклатуры во всех заказах менеджера
            $average_num_items_orders_fact = number_format($countNum, 2, '.', '');
            $average_num_items_orders_plan = $settings['average_num_items_orders2'];
            $average_num_items_orders_percent = round($average_num_items_orders_fact / $average_num_items_orders_plan, 2) * 100;

            // 6) Оценка call-аналитика и старшего менеджера
            $rating_senior_manager_fact = empty($rating['finish']) ? 0 : $rating['finish'];
            $rating_senior_manager_plan = $settings['rating_senior_manager2'];
            $rating_senior_manager_percent = round($rating_senior_manager_fact / $rating_senior_manager_plan, 2) * 100;

            // 7) Средний чек
            $average_check_fact = $crSumPaidOrdersManager;
            $average_check_plan = $averageCheck;
            $average_check_percent = round(is_nan($average_check_fact / $average_check_plan) ? 0 : $average_check_fact / $average_check_plan, 2) * 100;

            $percentAll = round(((($settings['reg_request'] * $reg_request_percent) +
                        ($settings['transfer_request_orders'] * $transfer_request_orders_percent) +
                        ($settings['inc_paid_orders'] * $inc_paid_orders_percent) +
                        ($settings['num_paid_order_personal_manager'] * $num_paid_order_personal_manager_percent) +
                        ($settings['average_num_items_orders'] * $average_num_items_orders_percent) +
                        ($settings['rating_senior_manager'] * $rating_senior_manager_percent) +
                        ($settings['average_check'] * $average_check_percent)) * 100) / 10000);

            $pay = fn_result_pay_manager($percentAll, $user['result_salary']);

            $ordersArray = [
                'manager_id' => $user['user_id'],

                'reg_request_fact' => $reg_request_fact,
                'reg_request_plan' => $reg_request_plan,
                'reg_request_percent' => $reg_request_percent,

                'transfer_request_orders_fact' => $transfer_request_orders_fact,
                'transfer_request_orders_plan' => $transfer_request_orders_plan,
                'transfer_request_orders_percent' => $transfer_request_orders_percent,

                'inc_paid_orders_fact' => $inc_paid_orders_fact,
                'inc_paid_orders_plan' => $inc_paid_orders_plan,
                'inc_paid_orders_percent' => $inc_paid_orders_percent,

                'num_paid_order_personal_manager_fact' => $num_paid_order_personal_manager_fact,
                'num_paid_order_personal_manager_plan' => $num_paid_order_personal_manager_plan,
                'num_paid_order_personal_manager_percent' => $num_paid_order_personal_manager_percent,

                'average_num_items_orders_fact' => $average_num_items_orders_fact,
                'average_num_items_orders_plan' => $average_num_items_orders_plan,
                'average_num_items_orders_percent' => $average_num_items_orders_percent,

                'rating_senior_manager_fact' => $rating_senior_manager_fact,
                'rating_senior_manager_plan' => $rating_senior_manager_plan,
                'rating_senior_manager_percent' => $rating_senior_manager_percent,

                'average_check_fact' => $average_check_fact,
                'average_check_plan' => $average_check_plan,
                'average_check_percent' => $average_check_percent,

                'percentAll' => $percentAll,
                'pay' => $pay,
            ];
            $user = array_merge($user, ['plan_result' => $ordersArray]);
            array_push($usersArray, $user);
        }
    }

    return $usersArray[0];
}

function fn_sort_result($arrayResult, $params, $default_by = '')
{
    if ($params['sort_order'] == 'desc' || empty($params['sort_order'])) {
        $sort = array('sort_order' => 'desc', 'sort_by' => $params['sort_by'], 'sort_order_rev' => 'asc');
    } else {
        $sort = array('sort_order' => 'asc', 'sort_by' => $params['sort_by'], 'sort_order_rev' => 'desc');
    }
    $params = array_merge($params, $sort);
    $field = !empty($params['sort_by']) ? $params['sort_by'] : $params['sort_by'] = $default_by;
    $dir = $params['sort_order'] == 'asc' ? SORT_ASC : SORT_DESC;

    if (empty(strpos($field, 'result_'))) {
        $field_r = str_replace('result_', '', $field);
        $array = 'result';
        $arrayResult = fn_multi_sort($arrayResult, $array, $dir, $field_r);
    }
    if (empty(strpos($field, 'plan_'))) {
        $field_p = str_replace('plan_', '', $field);
        $array = 'plan_result';
        $arrayResult = fn_multi_sort($arrayResult, $array, $dir, $field_p);
    }
    $arrayResult = fn_multi_sort($arrayResult, $field, $dir);

    return array($arrayResult, $params);
}

function fn_multi_sort($array, $field_1, $dir = SORT_ASC, $field_2 = null)
{
    if (empty($field_2)) {
        if ($field_1 == 'work_experience') {
            $params = array_column($array, $field_1);
            foreach ($params as $key => $param) {
                $first = stristr($param, '.', true);
                $last = ltrim(stristr($param, '.'), '.');
                $param = $first . ($first + $first) + $last;
                $params[$key] = $param;
            }
            array_multisort($params, SORT_NUMERIC, $dir, $array);
        } else {
            $params = array_column($array, $field_1);
            array_multisort($params, $dir, $array);
        }
    } else {
        $paramsArr = array_column($array, $field_1);
        $params = array_column($paramsArr, $field_2);
        array_multisort($params, $dir, $paramsArr, $array);
    }

    return $array;
}

function fn_work_experience($result_employment_date)
{
    $date_start = new DateTime(date("Y-m-d", $result_employment_date));
    $date_today = new DateTime(date("Y-m-d", strtotime('today')));
    $interval = $date_start->diff($date_today);
    $work_experience = $interval->format('%y.%m');

    return $work_experience;
}

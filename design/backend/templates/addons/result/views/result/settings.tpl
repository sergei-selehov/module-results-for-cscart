{assign var="allow_save" value=$settings|fn_allow_save_object:"result"}

{** banners section **}

{capture name="mainbox"}
    <form action="{""|fn_url}" method="post" class="form-horizontal setting-wide cm-processed-form cm-check-changes" name="settings_form" enctype="multipart/form-data">
        {capture name="tabsbox"}
            <div id="content_settings">
                <h4 class="subheader">Настройки результативности</h4>
                <table class="table table-middle" width="100%">
                    <thead>
                    <tr class="cm-first-sibling">
                        <th width="70%">Параметр</th>
                        <th width="15%">Вес (%)</th>
                        <th width="15%">Конверсия (%)</th>
                    </tr>
                    </thead>
                    <tbody style="border-bottom: 1px solid #ddd;">
                    <tr>
                        <td>
                            <label for="reg_request" class="control-label cm-required">Оформление всех заявок/обращений :</label>
                            <label for="reg_request2" class="control-label cm-required hidden">Оформление всех заявок/обращений</label>
                        </td>
                        <td>
                            <input type="text" name="settingsResult[reg_request]" id="reg_request" size="55" value="{$settingsResult.reg_request}">
                        </td>
                        <td>
                            <input type="text" name="settingsResult[reg_request2]" id="reg_request2" size="55" value="{$settingsResult.reg_request2}">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="transfer_request_orders" class="control-label cm-required">Перевод заявок/обращений в заказы :</label>
                            <label for="transfer_request_orders2" class="control-label cm-required hidden">Перевод заявок/обращений в заказы</label>
                        </td>
                        <td>
                            <input type="text" name="settingsResult[transfer_request_orders]" id="transfer_request_orders" size="55" value="{$settingsResult.transfer_request_orders}">
                        </td>
                        <td>
                            <input type="text" name="settingsResult[transfer_request_orders2]" id="transfer_request_orders2" size="55" value="{$settingsResult.transfer_request_orders2}">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="inc_paid_orders" class="control-label cm-required">Увеличение количества оплаченных заказов :</label>
                            <label for="inc_paid_orders2" class="control-label cm-required hidden">Увеличение количества оплаченных заказов</label>
                        </td>
                        <td>
                            <input type="text" name="settingsResult[inc_paid_orders]" id="inc_paid_orders" size="55" value="{$settingsResult.inc_paid_orders}">
                        </td>
                        <td>
                            <input type="text" name="settingsResult[inc_paid_orders2]" id="inc_paid_orders2" size="55" value="{$settingsResult.inc_paid_orders2}">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="num_paid_order_personal_manager" class="control-label cm-required">Количество оплаченных заказов у персонального менеджера :</label>
                            {include file="buttons/button.tpl" but_text="Расчитать" but_href="result.settings?calculate_num_paid=Y" but_role="action"}
                            <label for="num_paid_order_personal_manager2" class="control-label cm-required hidden">Количество оплаченных заказов у персонального менеджера</label>
                        </td>
                        <td>
                            <input style="margin-top: 20px;" type="text" name="settingsResult[num_paid_order_personal_manager]" id="num_paid_order_personal_manager" size="55" value="{$settingsResult.num_paid_order_personal_manager}">
                        </td>
                        <td>
                            <text>Кол-во активных менеджеров:</text>
                            <input type="text" name="settingsResult[num_paid_order_personal_manager2]" id="num_paid_order_personal_manager2" size="55" value="{$settingsResult.num_paid_order_personal_manager2}">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="average_num_items_orders" class="control-label cm-required" style="margin-right: 30px">Среднее количество номенклатуры во всех заказах менеджера : </label>
                            {include file="buttons/button.tpl" but_text="Расчитать" but_href="result.settings?calculate_average_num=Y" but_role="action"}
                            <label for="average_num_items_orders2" class="control-label cm-required hidden">Среднее количество номенклатуры во всех заказах менеджера</label>
                        </td>
                        <td>
                            <input type="text" name="settingsResult[average_num_items_orders]" id="average_num_items_orders" size="55" value="{$settingsResult.average_num_items_orders}">
                        </td>
                        <td>
                            <input type="text" name="settingsResult[average_num_items_orders2]" id="average_num_items_orders2" size="55" value="{number_format($settingsResult.average_num_items_orders2, 2, '.', '')}">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="rating_senior_manager" class="control-label cm-required">Оценка call-аналитика и старшего менеджера :</label>
                            <label for="rating_senior_manager2" class="control-label cm-required hidden">Оценка call-аналитика и старшего менеджера</label>
                        </td>
                        <td>
                            <input style="margin-top: 20px;" type="text" name="settingsResult[rating_senior_manager]" id="rating_senior_manager" size="55" value="{$settingsResult.rating_senior_manager}">
                        </td>
                        <td>
                            <text>Максимальная оценка менеджера:</text>
                            <input type="text" name="settingsResult[rating_senior_manager2]" id="rating_senior_manager2" size="55" value="{$settingsResult.rating_senior_manager2}">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="average_check" class="control-label cm-required">Средний чек :</label>
                            <label for="average_check2" class="control-label cm-required hidden">Средний чек</label>
                        </td>
                        <td>
                            <input type="text" name="settingsResult[average_check]" id="average_check" size="55" value="{$settingsResult.average_check}">
                        </td>
                        <td>
                            {*<input type="text" name="settingsResult[average_check2]" id="average_check2" size="55" value="{$settingsResult.average_check2}">*}
                        </td>
                    </tr>
                    </tbody>
                </table>
                <h4 class="subheader">Расчет плановой результативности</h4>
                <div class="control-group">
                    <label for="visits" class="control-label" style="width: auto;">Визиты:</label>
                    <div class="controls">
                        <input type="number" id="visits" name="settingsResult[result_visits]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.result_visits}" placeholder="Визиты" autocomplete="off">
                    </div>
                </div>
                <div class="control-group">
                    <label for="count_orders" class="control-label" style="width: auto;">Кол-во оплаченных заказов у перс. менеджера:</label>
                    <div class="controls">
                        <input type="number" id="count_orders" name="settingsResult[result_count_orders]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.result_count_orders}" placeholder="Кол-во оплаченных заказов ..." autocomplete="off">
                    </div>
                </div>
                <div class="control-group">
                    <label for="average_check" class="control-label" style="width: auto;">Средний чек:</label>
                    <div class="controls">
                        <input type="number" id="average_check" name="settingsResult[result_average_check]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.result_average_check}" placeholder="Средний чек" autocomplete="off">
                    </div>
                </div>
                <div class="control-group">
                    <label for="usergroup_id" class="control-label" style="width: auto;">Группа пользователей:</label>
                    <div class="controls">
                        {include file="addons/result/views/result/components/select_usergroup.tpl" id="group" name="settingsResult[usergroup_id]" usergroups=["type"=>"A", "status"=>"A"]|fn_get_usergroups:$smarty.const.DESCR_SL usergroup_id=$settingsResult.usergroup_id}
                    </div>
                </div>
                <div class="control-group">
                    <label for="admins_id" class="control-label" style="width: auto;">Администраторы:</label>
                    <div class="controls">
                        {include file="addons/result/views/result/components/select_admin.tpl" id="group" name="settingsResult[admins_id][]" selected=$settingsResult.admins_id}
                    </div>
                </div>
                <h4 class="subheader">Яндекс Метрика API</h4>
                <div class="control-group">
                    <label for="id_metric" class="control-label" style="width: auto;">ID Счетчика:</label>
                    <div class="controls">
                        <input type="text" id="id_metric" name="settingsResult[yandex_id_metrics]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.yandex_id_metrics}" placeholder="ID счетчика Яндекс Метрики" autocomplete="off">
                    </div>
                </div>

                <div class="control-group">
                    <label for="token_auth" class="control-label" style="width: auto;">Token Auth:</label>
                    <div class="controls">
                        <input type="text" id="token_auth" name="settingsResult[yandex_token_auth]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.yandex_token_auth}" placeholder="Token Auth Яндекс Метрики" autocomplete="off">
                    </div>
                </div>
                <h4 class="subheader">Google Table API</h4>
                <div class="control-group">
                    <label for="id_table" class="control-label" style="width: auto;">ID Таблицы:</label>
                    <div class="controls">
                        <input type="text" id="id_table" name="settingsResult[google_id_table]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.google_id_table}" placeholder="ID таблицы Google Table" autocomplete="off">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" style="width: auto;">Диапазон яйчеек:</label>
                    <div class="controls">
                        <input type="text" id="range_from" name="settingsResult[google_range_from]" class="cm-autocomplete-off" style="width: 100px;" value="{$settingsResult.google_range_from}" placeholder="Столбец:строка" autocomplete="off">
                        -
                        <input type="text" id="range_to" name="settingsResult[google_range_to]" class="cm-autocomplete-off" style="width: 100px;" value="{$settingsResult.google_range_to}"  placeholder="Столбец:строка" autocomplete="off">
                    </div>
                </div>
                <div class="control-group">
                    <label for="api_key" class="control-label" style="width: auto;">API Key:</label>
                    <div class="controls">
                        <input type="text" id="api_key" name="settingsResult[google_api_key]" class="cm-autocomplete-off" style="width: 228px;" value="{$settingsResult.google_api_key}" placeholder="API Key Google Table" autocomplete="off">
                    </div>
                </div>
            </div>
        {/capture}
        {include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

        {capture name="buttons"}
            {include file="buttons/save.tpl" but_role="submit-link" but_target_form="settings_form" but_name="dispatch[result.settings]"}
        {/capture}

    </form>
{/capture}

{$title = "Настройки"}

{include file="common/mainbox.tpl" title=$title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons select_languages=true}

{** banner section **}
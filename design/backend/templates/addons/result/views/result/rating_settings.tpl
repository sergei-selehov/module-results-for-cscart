{assign var="allow_save" value=$rating_settings|fn_allow_save_object:"result"}

{** banners section **}

{capture name="mainbox"}
    <form action="{""|fn_url}" method="post" class="form-horizontal setting-wide cm-processed-form cm-check-changes" name="rating_settings_form" enctype="multipart/form-data">
        {capture name="tabsbox"}
            <div id="content_setting">
                {if $rating_settings}
                    <label class="control-label cm-required">Изменение применяються только на текущий месяц и последующие</label>
                    <table class="table table-middle" width="100%">
                        <thead>
                        <tr class="cm-first-sibling">
                            <th width="70%">Параметр</th>
                            <th width="15%">Вес (%)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <label for="elm_rating_settings_greeting_weight" class="control-label cm-required">Приветствие :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[greeting_weight]" id="elm_rating_settings_greeting_weight" size="55" value="{$rating_settings.greeting_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_courtesy_weight" class="control-label cm-required">Вежливость и культура речи :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[courtesy_weight]" id="elm_rating_setting_courtesy_weight" size="55" value="{$rating_settings.courtesy_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_help_client_weight" class="control-label cm-required">Желание помочь клиенту :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[help_client_weight]" id="elm_rating_setting_help_client_weight" size="55" value="{$rating_settings.help_client_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_work_objections_weight" class="control-label cm-required">Работа с возражениями :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[work_objections_weight]" id="elm_rating_setting_work_objections_weight" size="55" value="{$rating_settings.work_objections_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_thanks_weight" class="control-label cm-required" style="margin-right: 30px">Благодарность за звонок : </label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[thanks_weight]" id="elm_rating_setting_thanks_weight" size="55" value="{$rating_settings.thanks_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_stock_notice_weight" class="control-label cm-required">Допродажа, уведомление об акции :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[stock_notice_weight]" id="elm_rating_setting_stock_notice_weight" size="55" value="{$rating_settings.stock_notice_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_promise_callback_weight" class="control-label cm-required">Обещание перезвонить :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[promise_callback_weight]" id="elm_rating_setting_promise_callback_weight" size="55" value="{$rating_settings.promise_callback_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_product_knowledge_weight" class="control-label cm-required">Знание продукта :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[product_knowledge_weight]" id="elm_rating_setting_product_knowledge_weight" size="55" value="{$rating_settings.product_knowledge_weight}">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="elm_rating_setting_discipline_weight" class="control-label cm-required">Дисциплина :</label>
                            </td>
                            <td>
                                <input type="text" name="rating_setting[discipline_weight]" id="elm_rating_setting_discipline_weight" size="55" value="{$rating_settings.discipline_weight}">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                {/if}
            </div>

        {/capture}
        {include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

        {capture name="buttons"}
                {include file="buttons/save.tpl" but_role="submit-link" but_target_form="rating_settings_form" but_name="dispatch[result.rating_settings]"}
        {/capture}

    </form>
{/capture}

{$title = "Настройки рейтинга Call-менеджера"}

{include file="common/mainbox.tpl" title=$title content=$smarty.capture.mainbox buttons=$smarty.capture.buttons select_languages=true}

{** banner section **}
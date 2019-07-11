{assign var="allow_save" value=$rating|fn_allow_save_object:"result"}

{** banners section **}

{capture name="mainbox"}

    {assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

    {assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
    {assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}

    {capture name="buttons"}
        {if $isAdmin}
            {capture name="tools_list"}
                <li>{btn type="list" text=__("settings") href="result.rating_settings"}</li>
            {/capture}
            {dropdown content=$smarty.capture.tools_list class="mobile-hide"}
        {/if}
    {/capture}

        {capture name="tabsbox"}
            {if $isAdmin}
                <p>{include file="buttons/button.tpl" but_text="Выгрузить" but_href="result.rating?insert_ratings=Y" but_role="action"}</p>
            {/if}
            <div id="content_setting">
                {if $ratings}
                    <div class="table-responsive-wrapper">
                        <table class="table table-middle" width="100%">
                            <thead></thead>
                            <tbody class="hover" id="box_managers_list_{$manager.user_id}">
                            <tr class="cm-first-sibling">
                                <th width="20%">Менеджер</th>
                                <th width="20%"></th>
                                <th width="20%"></th>
                                <th width="20%"></th>
                                <th></th>
                            </tr>
                            </tbody>
                            {** Manager **}
                            {foreach from=$ratings item=rating}
                                {if isset($rating.manager_id)}
                                    <form action="{""|fn_url}" method="post" class="form-horizontal setting-wide cm-processed-form cm-check-changes" name="rating_form_{$rating.manager_id}" enctype="multipart/form-data">
                                        <input type="hidden" class="cm-no-hide-input" name="rating[manager_id]" value="{$rating.manager_id}" />
                                        <input type="hidden" class="cm-no-hide-input" name="rating[time_from]" value="{$_REQUEST.time_from}" />
                                        <input type="hidden" class="cm-no-hide-input" name="rating[time_to]" value="{$_REQUEST.time_to}" />
                                        <tbody>
                                        <tr>
                                            <td width="20%" class="cm-extended-managers">
                                                <span alt="Расширить подсписок элементов" title="Расширить подсписок элементов" id="on_managers_{$rating.manager_id}" class="cm-combination-managers">
                                                    <span class="icon-caret-right"></span>
                                                </span>
                                                <span alt="Свернуть список" title="Свернуть список" id="off_managers_{$rating.manager_id}" class="hidden cm-combination-managers">
                                                    <span class="icon-caret-down"></span>
                                                </span>
                                                <a href="{"profiles.update?user_id=`$rating.manager_id`"|fn_url}" class="underlined">{$rating.manager_name}</a>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td><input type="number" name="rating[options][finish]" style="width: 45px;" value="{$rating.options.finish}" placeholder="%" />%</td>
                                        </tr>
                                        </tbody>
                                        <tbody id="managers_{$rating.manager_id}" class="hidden row-more">
                                            <tr class="no-border">
                                                <td colspan="5" class="row-more-body top row-gray">
                                                    <table class="table table-condensed">
                                                        <thead>
                                                        <tr class="no-hover">
                                                            <th>Показатели</th>
                                                            <th>Вес(%)</th>
                                                            <th>План</th>
                                                            <th>Факт</th>
                                                            <th>Вып(%)</th>
                                                            <th></th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>Приветствие</td>
                                                            <td><input type="number" name="rating[options][greeting_weight]" style="width: 45px;" value="{$rating.options.greeting_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][greeting_plan]" style="width: 45px;" value="{$rating.options.greeting_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][greeting_fact]" style="width: 45px;" value="{$rating.options.greeting_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][greeting_percent]" style="width: 45px;" value="{$rating.options.greeting_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Вежливость и культура речи</td>
                                                            <td><input type="number" name="rating[options][courtesy_weight]" style="width: 45px;" value="{$rating.options.courtesy_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][courtesy_plan]" style="width: 45px;" value="{$rating.options.courtesy_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][courtesy_fact]" style="width: 45px;" value="{$rating.options.courtesy_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][courtesy_percent]" style="width: 45px;" value="{$rating.options.courtesy_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Желание помочь клиенту</td>
                                                            <td><input type="number" name="rating[options][help_client_weight]" style="width: 45px;" value="{$rating.options.help_client_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][help_client_plan]" style="width: 45px;" value="{$rating.options.help_client_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][help_client_fact]" style="width: 45px;" value="{$rating.options.help_client_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][help_client_percent]" style="width: 45px;" value="{$rating.options.help_client_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Работа с возражениями</td>
                                                            <td><input type="number" name="rating[options][work_objections_weight]" style="width: 45px;" value="{$rating.options.work_objections_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][work_objections_plan]" style="width: 45px;" value="{$rating.options.work_objections_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][work_objections_fact]" style="width: 45px;" value="{$rating.options.work_objections_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][work_objections_percent]" style="width: 45px;" value="{$rating.options.work_objections_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Благодарность за звонок</td>
                                                            <td><input type="number" name="rating[options][thanks_weight]" style="width: 45px;" value="{$rating.options.thanks_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][thanks_plan]" style="width: 45px;" value="{$rating.options.thanks_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][thanks_fact]" style="width: 45px;" value="{$rating.options.thanks_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][thanks_percent]" style="width: 45px;" value="{$rating.options.thanks_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Допродажа, уведомление об акции</td>
                                                            <td><input type="number" name="rating[options][stock_notice_weight]" style="width: 45px;" value="{$rating[options].options.stock_notice_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][stock_notice_plan]" style="width: 45px;" value="{$rating.options.stock_notice_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][stock_notice_fact]" style="width: 45px;" value="{$rating.options.stock_notice_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][stock_notice_percent]" style="width: 45px;" value="{$rating.options.stock_notice_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Обещание перезвонить</td>
                                                            <td><input type="number" name="rating[options][promise_callback_weight]" style="width: 45px;" value="{$rating.options.promise_callback_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][promise_callback_plan]" style="width: 45px;" value="{$rating.options.promise_callback_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][promise_callback_fact]" style="width: 45px;" value="{$rating.options.promise_callback_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][promise_callback_percent]" style="width: 45px;" value="{$rating.options.promise_callback_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Знание продукта</td>
                                                            <td><input type="number" name="rating[options][product_knowledge_weight]" style="width: 45px;" value="{$rating.options.product_knowledge_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][product_knowledge_plan]" style="width: 45px;" value="{$rating.options.product_knowledge_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][product_knowledge_fact]" style="width: 45px;" value="{$rating.options.product_knowledge_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][product_knowledge_percent]" style="width: 45px;" value="{$rating.options.product_knowledge_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Дисциплина</td>
                                                            <td><input type="number" name="rating[options][discipline_weight]" style="width: 45px;" value="{$rating.options.discipline_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][discipline_plan]" style="width: 45px;" value="{$rating.options.discipline_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][discipline_fact]" style="width: 45px;" value="{$rating.options.discipline_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][discipline_percent]" style="width: 45px;" value="{$rating.options.discipline_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Количество звонков</td>
                                                            <td><input type="number" name="rating[options][count_call_weight]" style="width: 45px;" value="{$rating.options.count_call_weight}" placeholder="Вес" />%</td>
                                                            <td><input type="number" name="rating[options][count_call_plan]" style="width: 45px;" value="{$rating.options.count_call_plan}" placeholder="План" /></td>
                                                            <td><input type="number" name="rating[options][count_call_fact]" style="width: 45px;" value="{$rating.options.count_call_fact}" placeholder="Факт" /></td>
                                                            <td><input type="number" name="rating[options][count_call_percent]" style="width: 45px;" value="{$rating.options.count_call_percent}" placeholder="Вып" />%</td>
                                                            <td></td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                    {include file="buttons/save.tpl" but_role="submit-link" but_target_form="rating_form_{$rating.manager_id}" but_name="dispatch[result.rating]"}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </form>
                                {/if}
                            {/foreach}
                            {** End Manager **}
                        </table>
                    </div>

                {else}
                    <p class="no-items">{__("no_data")}</p>
                {/if}
            </div>
        {/capture}
        {include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}
{/capture}

{capture name="sidebar"}
    {hook name="result:manage_sidebar"}
        {include file="addons/result/views/result/components/rating_search_form.tpl" dispatch="result.rating" no_adv_link=true}
    {/hook}
{/capture}

{include file="common/mainbox.tpl" title="Рейтинг Call-менеджеров" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons select_languages=true sidebar=$smarty.capture.sidebar}

{** banner section **}
{** Result section **}
{capture name="mainbox"}

    {include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id="pagination_contents"}
    {assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
    {assign var="rev" value=$smarty.request.content_id|default:"pagination_contents"}
    {assign var="c_icon" value="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
    {assign var="c_dummy" value="<i class=\"icon-dummy\"></i>"}
    {if $isAdmin}
        {capture name="buttons"}
            {capture name="tools_list"}
                <li>{btn type="list" text="Настройка" href="result.settings"}</li>
                <li>{btn type="list" text="Оценка звонков Call-менеджера" href="result.rating"}</li>
            {/capture}
            {dropdown content=$smarty.capture.tools_list class="mobile-hide"}
        {/capture}
    {/if}
    {if $managers}
        <div class="table-responsive-wrapper">
            <table class="table table-middle" width="100%">
                <thead></thead>
                {if $isAdmin}
                    <h6 style="position: absolute;margin-left: 63%;margin-block-start: 0%;color: #999;">Плановая</h6>
                    <h6 style="position: absolute;margin-left: 38%;margin-block-start: 0%;color: #999;">Зарплатная</h6>
                {/if}
                <tbody class="hover" id="box_managers_list_1">
                <tr class="cm-first-sibling" {if $isAdmin} style="height: 50px;" {/if}>
                    <th {if $isAdmin} width="15%" {else} width="20%" {/if}>
                        <a class="cm-ajax" style="color: black;" href="{"`$c_url`&sort_by=lastname&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>Менеджер{if $search.sort_by == "lastname"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                    <th {if $isAdmin} width="11%" {else} width="20%" {/if}>
                        <a class="cm-ajax" style="color: black;" href="{"`$c_url`&sort_by=work_experience&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>Стаж работы{if $search.sort_by == "work_experience"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>

                    {if $isAdmin}
                        {*Зарплатная*}
                        <th width="6%" style="border-left: 1px solid #ddd;">
                            <a class="cm-ajax" style="color: black;" href="{"`$c_url`&sort_by=result_percentAll&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>Вып{if $search.sort_by == "result_percentAll"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                        </th>
                        <th width="10%">
                            <a class="cm-ajax" style="color: black;" href="{"`$c_url`&sort_by=result_pay&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>Зарплата{if $search.sort_by == "result_pay"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                        </th>
                        <th width="13%" style="border-right: 1px solid #ddd;">Посещений: {$visits}</th>
                        {*Зарплатная*}
                    {/if}

                    {*Плановая*}
                    <th {if $isAdmin} width="6%" {else} width="20%" {/if}>
                        <a class="cm-ajax" style="color: black;" href="{"`$c_url`&sort_by=plan_percentAll&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>Вып{if $search.sort_by == "plan_percentAll"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                    <th {if $isAdmin} width="10%" {else} width="20%" {/if}>
                        {if $isAdmin}
                            <a class="cm-ajax" style="color: black;" href="{"`$c_url`&sort_by=plan_pay&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>Зарплата{if $search.sort_by == "plan_pay"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                        {else}
                            Зарплата
                        {/if}
                    </th>
                    <th {if $isAdmin} width="13%" {else} width="20%" {/if}>Посещений: {$plan_visits}</th>
                    {*Плановая*}
                </tr>
                </tbody>
                {** Manager **}
                {foreach from=$managers item=manager}
                    {if isset($manager.user_id) && $manager.result_calc == "Y" && $manager.result_head == "N" && $manager.result_remote == "N"}
                        <tbody style="border-bottom: 1px solid #ddd;">
                        <tr>
                            <td width="20%" class="cm-extended-managers">
                                <span alt="Расширить подсписок элементов" title="Расширить подсписок элементов" id="on_managers_{$manager.user_id}" class="cm-combination-managers">
                                    <span class="icon-caret-right"></span>
                                </span>
                                <span alt="Свернуть список" title="Свернуть список" id="off_managers_{$manager.user_id}" class="hidden cm-combination-managers">
                                    <span class="icon-caret-down"></span>
                                </span>
                                <a href="{"profiles.update?user_id=`$manager.user_id`"|fn_url}" class="underlined">{$manager.lastname} {$manager.firstname}</a>
                            </td>
                            <td>{$manager.work_experience}</td>
                            {if $isAdmin}
                                {*Зарплатная*}
                                <td style="border-left: 1px solid #ddd;">{$manager.result.percentAll}%</td>
                                <td>{if $idUserAuth == $manager.user_id || $isAdmin}{include file="common/price.tpl" value=$manager.result.pay}{/if}</td>
                                <td style="border-right: 1px solid #ddd;"></td>
                                {*Зарплатная*}
                            {/if}
                            {*Плановая*}
                            <td>{$manager.plan_result.percentAll}%</td>
                            <td>{if $idUserAuth == $manager.user_id || $isAdmin}{include file="common/price.tpl" value=$manager.plan_result.pay}{/if}</td>
                            {*Плановая*}
                            <td></td>
                        </tr>
                        </tbody>
                        <tbody id="managers_{$manager.user_id}" class="hidden row-more">
                        <tr class="no-border">
                            <td colspan="8" class="row-more-body top row-gray">
                                <table class="table table-condensed">
                                    {if $isAdmin}
                                        <h6 style="position: absolute;margin-left: 58%;margin-block-start: -1%;color: #999;">Плановая</h6>
                                        <h6 style="position: absolute;margin-left: 37%;margin-block-start: -1%;color: #999;">Зарплатная</h6>
                                    {/if}
                                    <thead>
                                    <tr class="no-hover">
                                        <th {if $isAdmin} style="width: 43.5%;" {else} style="width: 60%;" {/if}>Показатели матрицы</th>
                                        {if $isAdmin}
                                            <th>Вес</th>
                                            <th>План</th>
                                            <th>Факт</th>
                                            <th style="border-right: 1px solid #ddd;">Вып</th>
                                            <td></td>
                                        {/if}
                                        <th>Вес</th>
                                        <th>План</th>
                                        <th>Факт</th>
                                        <th>Вып</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Оформление всех заявок/обращений</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.reg_request}%</td>
                                            <td>{$manager.result.reg_request_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.reg_request_fact} {else} {$manager.reg_request_fact} {/if}</a>
                                            </td>
                                            <td style="border-right: 1px solid #ddd;">{$manager.result.reg_request_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.reg_request}%</td>
                                        <td>{$manager.plan_result.reg_request_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.reg_request_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.reg_request_percent}%</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Перевод заявок/обращений в заказы</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.transfer_request_orders}%</td>
                                            <td>{$manager.result.transfer_request_orders_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=D&status[]=L&status[]=K&status[]=J&status[]=A&status[]=B&status[]=Q&status[]=W&status[]=H&status[]=X&status[]=M&status[]=C&status[]=I&status[]=G&status[]=F&status[]=P&status[]=Y&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.transfer_request_orders_fact} {/if}</a>
                                            </td>
                                            <td style="border-right: 1px solid #ddd;">{$manager.result.transfer_request_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.transfer_request_orders}%</td>
                                        <td>{$manager.plan_result.transfer_request_orders_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=D&status[]=L&status[]=K&status[]=J&status[]=A&status[]=B&status[]=Q&status[]=W&status[]=H&status[]=X&status[]=M&status[]=C&status[]=I&status[]=G&status[]=F&status[]=P&status[]=Y&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.transfer_request_orders_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.transfer_request_orders_percent}%</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Увеличение количества оплаченных заказов</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.inc_paid_orders}%</td>
                                            <td>{$manager.result.inc_paid_orders_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.inc_paid_orders_fact} {/if}</a>
                                            </td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.inc_paid_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.inc_paid_orders}%</td>
                                        <td>{$manager.plan_result.inc_paid_orders_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.inc_paid_orders_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.inc_paid_orders_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Количество оплаченных заказов у персонального менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.num_paid_order_personal_manager}%</td>
                                            <td>{$manager.result.num_paid_order_personal_manager_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&issuer=`$manager.firstname`+`$manager.lastname`&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`"|fn_url}">{if isset($manager.result)} {$manager.result.num_paid_order_personal_manager_fact} {/if}</a>
                                            </td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.num_paid_order_personal_manager_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.num_paid_order_personal_manager}%</td>
                                        <td>{$manager.plan_result.num_paid_order_personal_manager_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&issuer=`$manager.firstname`+`$manager.lastname`&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`"|fn_url}">{$manager.plan_result.num_paid_order_personal_manager_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.num_paid_order_personal_manager_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Среднее количество номенклатуры во всех заказах менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.average_num_items_orders}%</td>
                                            <td>{number_format($manager.result.average_num_items_orders_plan, 2, '.', '')}</td>
                                            <td>{$manager.result.average_num_items_orders_fact}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.average_num_items_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.average_num_items_orders}%</td>
                                        <td>{number_format($manager.plan_result.average_num_items_orders_plan, 2, '.', '')}</td>
                                        <td>{$manager.plan_result.average_num_items_orders_fact}</td>
                                        <td>{$manager.plan_result.average_num_items_orders_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Оценка call-аналитика и старшего менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.rating_senior_manager}%</td>
                                            <td>{$manager.result.rating_senior_manager_plan}</td>
                                            <td>{$manager.result.rating_senior_manager_fact}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.rating_senior_manager_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.rating_senior_manager}%</td>
                                        <td>{$manager.plan_result.rating_senior_manager_plan}</td>
                                        <td>{$manager.plan_result.rating_senior_manager_fact}</td>
                                        <td>{$manager.plan_result.rating_senior_manager_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Средний чек</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.average_check}%</td>
                                            <td>{include file="common/price.tpl" value=round($manager.result.average_check_plan)}</td>
                                            <td>{include file="common/price.tpl" value=round($manager.result.average_check_fact)}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{round($manager.result.average_check_percent)}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.average_check}%</td>
                                        <td>{include file="common/price.tpl" value=round($manager.plan_result.average_check_plan)}</td>
                                        <td>{include file="common/price.tpl" value=round($manager.plan_result.average_check_fact)}</td>
                                        <td>{round($manager.plan_result.average_check_percent)}%</td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        </tbody>
                    {/if}
                {/foreach}
                {** End Manager **}

                {** Remote **}
                {foreach from=$managers item=manager}
                    {if isset($manager.user_id) && $manager.result_calc == "Y" && $manager.result_remote == "Y"}
                        {if $a++ < 1}
                            <th colspan="8" style="position: relative;text-align: center;background-color: white;border-bottom: 2px solid #ddd;">
                                <div style=" position: absolute;top: 50%;left: 0; right: 0;height: 1px;background: #000;"></div>
                                <div style='z-index: 2;position: relative;display: inline-block;background: white;padding-left: 10px;padding-right: 10px;'>Удаленные операторы</div><br/>
                            </th>
                        {/if}
                        <tbody style="border-bottom: 1px solid #ddd;">
                        <tr>
                            <td width="20%" class="cm-extended-managers">
                                <span alt="Расширить подсписок элементов" title="Расширить подсписок элементов" id="on_managers_{$manager.user_id}" class="cm-combination-managers">
                                    <span class="icon-caret-right"></span>
                                </span>
                                <span alt="Свернуть список" title="Свернуть список" id="off_managers_{$manager.user_id}" class="hidden cm-combination-managers">
                                    <span class="icon-caret-down"></span>
                                </span>
                                <a href="{"profiles.update?user_id=`$manager.user_id`"|fn_url}" class="underlined">{$manager.lastname} {$manager.firstname}</a>
                            </td>
                            <td>{$manager.work_experience}</td>

                            {if $isAdmin}
                                {*Зарплатная*}
                                <td style="border-left: 1px solid #ddd;">{$manager.result.percentAll}%</td>
                                <td>{if $idUserAuth == $manager.user_id || $isAdmin}{include file="common/price.tpl" value=$manager.result.pay}{/if}</td>
                                <td style="border-right: 1px solid #ddd;"></td>
                                {*Зарплатная*}
                            {/if}

                            {*Плановая*}
                            <td>{$manager.plan_result.percentAll}%</td>
                            <td>{if $idUserAuth == $manager.user_id || $isAdmin}{include file="common/price.tpl" value=$manager.plan_result.pay}{/if}</td>
                            {*Плановая*}

                            <td></td>
                        </tr>
                        </tbody>
                        <tbody id="managers_{$manager.user_id}" class="hidden row-more">
                        <tr class="no-border">
                            <td colspan="8" class="row-more-body top row-gray">
                                <table class="table table-condensed">
                                    {if $isAdmin}
                                        <h6 style="position: absolute;margin-left: 58%;margin-block-start: -1%;color: #999;">Плановая</h6>
                                        <h6 style="position: absolute;margin-left: 37%;margin-block-start: -1%;color: #999;">Зарплатная</h6>
                                    {/if}
                                    <thead>
                                    <tr class="no-hover">
                                        <th {if $isAdmin} style="width: 43.5%;" {else} style="width: 60%;" {/if}>Показатели матрицы</th>
                                        {if $isAdmin}
                                            <th>Вес</th>
                                            <th>План</th>
                                            <th>Факт</th>
                                            <th style="border-right: 1px solid #ddd;">Вып</th>
                                            <td></td>
                                        {/if}
                                        <th>Вес</th>
                                        <th>План</th>
                                        <th>Факт</th>
                                        <th>Вып</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Оформление всех заявок/обращений</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.reg_request}%</td>
                                            <td>{$manager.result.reg_request_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.reg_request_fact} {else} {$manager.reg_request_fact} {/if}</a>
                                            </td>
                                            <td style="border-right: 1px solid #ddd;">{$manager.result.reg_request_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.reg_request}%</td>
                                        <td>{$manager.plan_result.reg_request_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.reg_request_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.reg_request_percent}%</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Перевод заявок/обращений в заказы</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.transfer_request_orders}%</td>
                                            <td>{$manager.result.transfer_request_orders_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=D&status[]=L&status[]=K&status[]=J&status[]=A&status[]=B&status[]=Q&status[]=W&status[]=H&status[]=X&status[]=M&status[]=C&status[]=I&status[]=G&status[]=F&status[]=P&status[]=Y&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.transfer_request_orders_fact} {/if}</a>
                                            </td>
                                            <td style="border-right: 1px solid #ddd;">{$manager.result.transfer_request_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.transfer_request_orders}%</td>
                                        <td>{$manager.plan_result.transfer_request_orders_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=D&status[]=L&status[]=K&status[]=J&status[]=A&status[]=B&status[]=Q&status[]=W&status[]=H&status[]=X&status[]=M&status[]=C&status[]=I&status[]=G&status[]=F&status[]=P&status[]=Y&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.transfer_request_orders_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.transfer_request_orders_percent}%</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Увеличение количества оплаченных заказов</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.inc_paid_orders}%</td>
                                            <td>{$manager.result.inc_paid_orders_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.inc_paid_orders_fact} {/if}</a>
                                            </td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.inc_paid_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.inc_paid_orders}%</td>
                                        <td>{$manager.plan_result.inc_paid_orders_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.inc_paid_orders_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.inc_paid_orders_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Количество оплаченных заказов у персонального менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.num_paid_order_personal_manager}%</td>
                                            <td>{$manager.result.num_paid_order_personal_manager_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&issuer=`$manager.firstname`+`$manager.lastname`&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`"|fn_url}">{if isset($manager.result)} {$manager.result.num_paid_order_personal_manager_fact} {/if}</a>
                                            </td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.num_paid_order_personal_manager_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.num_paid_order_personal_manager}%</td>
                                        <td>{$manager.plan_result.num_paid_order_personal_manager_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&issuer=`$manager.firstname`+`$manager.lastname`&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`"|fn_url}">{$manager.plan_result.num_paid_order_personal_manager_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.num_paid_order_personal_manager_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Среднее количество номенклатуры во всех заказах менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.average_num_items_orders}%</td>
                                            <td>{number_format($manager.result.average_num_items_orders_plan, 2, '.', '')}</td>
                                            <td>{$manager.result.average_num_items_orders_fact}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.average_num_items_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.average_num_items_orders}%</td>
                                        <td>{{number_format($manager.plan_result.average_num_items_orders_plan, 2, '.', '')}}</td>
                                        <td>{$manager.plan_result.average_num_items_orders_fact}</td>
                                        <td>{$manager.plan_result.average_num_items_orders_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Оценка call-аналитика и старшего менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.rating_senior_manager}%</td>
                                            <td>{$manager.result.rating_senior_manager_plan}</td>
                                            <td>{$manager.result.rating_senior_manager_fact}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.rating_senior_manager_percent}
                                                %
                                            </td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.rating_senior_manager}%</td>
                                        <td>{$manager.plan_result.rating_senior_manager_plan}</td>
                                        <td>{$manager.plan_result.rating_senior_manager_fact}</td>
                                        <td>{$manager.plan_result.rating_senior_manager_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Средний чек</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.average_check}%</td>
                                            <td>{include file="common/price.tpl" value=round($manager.result.average_check_plan)}</td>
                                            <td>{include file="common/price.tpl" value=round($manager.result.average_check_fact)}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{round($manager.result.average_check_percent)}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.average_check}%</td>
                                        <td>{include file="common/price.tpl" value=round($manager.plan_result.average_check_plan)}</td>
                                        <td>{include file="common/price.tpl" value=round($manager.plan_result.average_check_fact)}</td>
                                        <td>{round($manager.plan_result.average_check_percent)}%</td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        </tbody>
                    {/if}
                {/foreach}
                {** End Remote **}

                {** Head **}
                {foreach from=$managers item=manager}
                    {if isset($manager.user_id) && $manager.result_calc == "Y" && $manager.result_head == "Y"}
                        {if $s++ < 1}
                            <th colspan="8" style="position: relative;text-align: center;background-color: white;border-bottom: 2px solid #ddd;">
                                <div style=" position: absolute;top: 50%;left: 0; right: 0;height: 1px;background: #000;"></div>
                                <div style='z-index: 2;position: relative;display: inline-block;background: white;padding-left: 10px;padding-right: 10px;'>Руководители</div><br/>
                            </th>
                        {/if}
                        <tbody style="border-bottom:1px solid #ddd;">
                        <tr>
                            <td width="20%" class="cm-extended-managers">
                                <span alt="Расширить подсписок элементов" title="Расширить подсписок элементов" id="on_managers_{$manager.user_id}" class="cm-combination-managers">
                                    <span class="icon-caret-right"></span>
                                </span>
                                <span alt="Свернуть список" title="Свернуть список" id="off_managers_{$manager.user_id}" class="hidden cm-combination-managers">
                                    <span class="icon-caret-down"></span>
                                </span>
                                <a href="{"profiles.update?user_id=`$manager.user_id`"|fn_url}" class="underlined">{$manager.lastname} {$manager.firstname}</a>
                            </td>
                            <td>{$manager.work_experience}</td>

                            {if $isAdmin}
                                {*Зарплатная*}
                                <td style="border-left: 1px solid #ddd;">{$manager.result.percentAll}%</td>
                                <td>{if $idUserAuth == $manager.user_id || $isAdmin}{include file="common/price.tpl" value=$manager.result.pay}{/if}</td>
                                <td style="border-right: 1px solid #ddd;"></td>
                                {*Зарплатная*}
                            {/if}

                            {*Плановая*}
                            <td>{$manager.plan_result.percentAll}%</td>
                            <td>{if $idUserAuth == $manager.user_id || $isAdmin}{include file="common/price.tpl" value=$manager.plan_result.pay}{/if}</td>
                            {*Плановая*}

                            <td></td>
                        </tr>
                        </tbody>
                        <tbody id="managers_{$manager.user_id}" class="hidden row-more">
                        <tr class="no-border">
                            <td colspan="8" class="row-more-body top row-gray">
                                <table class="table table-condensed">
                                    {if $isAdmin}
                                        <h6 style="position: absolute;margin-left: 58%;margin-block-start: -1%;color: #999;">Плановая</h6>
                                        <h6 style="position: absolute;margin-left: 37%;margin-block-start: -1%;color: #999;">Зарплатная</h6>
                                    {/if}
                                    <thead>
                                    <tr class="no-hover">
                                        <th {if $isAdmin} style="width: 43.5%;" {else} style="width: 60%;" {/if}>Показатели матрицы</th>
                                        {if $isAdmin}
                                            <th>Вес</th>
                                            <th>План</th>
                                            <th>Факт</th>
                                            <th style="border-right: 1px solid #ddd;">Вып</th>
                                            <td></td>
                                        {/if}
                                        <th>Вес</th>
                                        <th>План</th>
                                        <th>Факт</th>
                                        <th>Вып</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Оформление всех заявок/обращений</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.reg_request}%</td>
                                            <td>{$manager.result.reg_request_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.reg_request_fact} {else} {$manager.reg_request_fact} {/if}</a>
                                            </td>
                                            <td style="border-right: 1px solid #ddd;">{$manager.result.reg_request_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.reg_request}%</td>
                                        <td>{$manager.plan_result.reg_request_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.reg_request_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.reg_request_percent}%</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Перевод заявок/обращений в заказы</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.transfer_request_orders}%</td>
                                            <td>{$manager.result.transfer_request_orders_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=D&status[]=L&status[]=K&status[]=J&status[]=A&status[]=B&status[]=Q&status[]=W&status[]=H&status[]=X&status[]=M&status[]=C&status[]=I&status[]=G&status[]=F&status[]=P&status[]=Y&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.transfer_request_orders_fact} {/if}</a>
                                            </td>
                                            <td style="border-right: 1px solid #ddd;">{$manager.result.transfer_request_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.transfer_request_orders}%</td>
                                        <td>{$manager.plan_result.transfer_request_orders_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=D&status[]=L&status[]=K&status[]=J&status[]=A&status[]=B&status[]=Q&status[]=W&status[]=H&status[]=X&status[]=M&status[]=C&status[]=I&status[]=G&status[]=F&status[]=P&status[]=Y&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.transfer_request_orders_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.transfer_request_orders_percent}%</td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Увеличение количества оплаченных заказов</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.inc_paid_orders}%</td>
                                            <td>{$manager.result.inc_paid_orders_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.inc_paid_orders_fact} {/if}</a>
                                            </td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.inc_paid_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.inc_paid_orders}%</td>
                                        <td>{$manager.plan_result.inc_paid_orders_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{$manager.plan_result.inc_paid_orders_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.inc_paid_orders_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Количество оплаченных заказов у персонального менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.num_paid_order_personal_manager}%</td>
                                            <td>{$manager.result.num_paid_order_personal_manager_plan}</td>
                                            <td>
                                                <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`$urlUsers"|fn_url}">{if isset($manager.result)} {$manager.result.num_paid_order_personal_manager_fact} {/if}</a>
                                            </td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.num_paid_order_personal_manager_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.num_paid_order_personal_manager}%</td>
                                        <td>{$manager.plan_result.num_paid_order_personal_manager_plan}</td>
                                        <td>
                                            <a href="{"?is_search=Y&dispatch[orders.manage]=Найти&issuer=`$manager.firstname`+`$manager.lastname`&status[]=K&status[]=Q&status[]=M&status[]=W&status[]=C&status[]=P&status[]=A&status[]=H&status[]=B&status[]=X&status[]=G&period=`$_REQUEST['period']`&time_from=`$_REQUEST['time_from']`&time_to=`$_REQUEST['time_to']`"|fn_url}">{$manager.plan_result.num_paid_order_personal_manager_fact}</a>
                                        </td>
                                        <td>{$manager.plan_result.num_paid_order_personal_manager_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Среднее количество номенклатуры во всех заказах менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.average_num_items_orders}%</td>
                                            <td>{number_format($manager.result.average_num_items_orders_plan, 2, '.', '')}</td>
                                            <td>{$manager.result.average_num_items_orders_fact}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.average_num_items_orders_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.average_num_items_orders}%</td>
                                        <td>{number_format(number_format($manager.plan_result.average_num_items_orders_plan, 2, '.', ''), 2, '.', '')}</td>
                                        <td>{$manager.plan_result.average_num_items_orders_fact}</td>
                                        <td>{$manager.plan_result.average_num_items_orders_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Оценка call-аналитика и старшего менеджера</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.rating_senior_manager}%</td>
                                            <td>{$manager.result.rating_senior_manager_plan}</td>
                                            <td>{$manager.result.rating_senior_manager_fact}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{$manager.result.rating_senior_manager_percent}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.rating_senior_manager}%</td>
                                        <td>{$manager.plan_result.rating_senior_manager_plan}</td>
                                        <td>{$manager.plan_result.rating_senior_manager_fact}</td>
                                        <td>{$manager.plan_result.rating_senior_manager_percent}%</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Средний чек</td>
                                        {if $isAdmin}
                                            <td>{$settingsResult.average_check}%</td>
                                            <td>{include file="common/price.tpl" value=round($manager.result.average_check_plan)}</td>
                                            <td>{include file="common/price.tpl" value=round($manager.result.average_check_fact)}</td>
                                            <td {if $isAdmin} style="border-right: 1px solid #ddd;" {/if}>{round($manager.result.average_check_percent)}%</td>
                                            <td></td>
                                        {/if}
                                        <td>{$settingsResult.average_check}%</td>
                                        <td>{include file="common/price.tpl" value=round($manager.plan_result.average_check_plan)}</td>
                                        <td>{include file="common/price.tpl" value=round($manager.plan_result.average_check_fact)}</td>
                                        <td>{round($manager.plan_result.average_check_percent)}%</td>
                                        <td></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        </tbody>
                    {/if}
                {/foreach}
                {** End Head **}
            </table>
        </div>
    {else}
        <p class="no-items">{__("no_data")}</p>
    {/if}

    {include file="common/pagination.tpl" div_id=$smarty.request.content_id}

{/capture}

{capture name="sidebar"}
    {hook name="result:manage_sidebar"}
        {include file="addons/result/views/result/components/result_search_form.tpl" no_adv_link=true}
    {/hook}
{/capture}

{include file="common/mainbox.tpl" title="Результативность" content=$smarty.capture.mainbox buttons=$smarty.capture.buttons adv_buttons=$smarty.capture.adv_buttons select_languages=true sidebar=$smarty.capture.sidebar content_id="manage_result"}

{** Result and section **}
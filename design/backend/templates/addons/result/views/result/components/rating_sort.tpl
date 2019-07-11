{if $in_popup}
<div class="adv-search">
    <div class="group">
        {else}
        <div class="sidebar-row">
            <h6>{__("search")}</h6>
            {/if}
            <form name="rating_sort_form" action="{""|fn_url}" method="get" class="{$form_meta}">
                {if $smarty.request.redirect_url}
                    <input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
                {/if}

                {if $selected_section != ""}
                    <input type="hidden" id="selected_section" name="selected_section" value="{$selected_section}" />
                {/if}

                {if $put_request_vars}
                    {array_to_fields data=$smarty.request skip=["callback"]}
                {/if}

                {$extra nofilter}

                {capture name="simple_search"}
                    <div id="simple_search_common">
                        <div id="simple_search">
                            <div class="sidebar-field">
                                <label for="period_selects">Период:</label>
                                <select name="period" id="period_selects">
                                    <option value="M" {if $_REQUEST['period'] == "M"}selected="selected"{/if}>Текущий месяц</option>
                                    <option value="LM" {if $_REQUEST['period'] == "LM" || $_REQUEST['period'] == ""}selected="selected"{/if}>Предыдущий месяц</option>
                                </select>

                            </div>
                            <div class="sidebar-field">
                                <label>Выбрать даты:</label>
                                <div class="calendar">
                                    <input type="date" id="f_date" name="time_from" class="input-date cm-calendar hasDatepicker" value="{if isset($_REQUEST['time_from']) && $_REQUEST['time_from'] != ''}{$_REQUEST['time_from']}{/if}" size="10">
                                    <span data-ca-external-focus-id="f_date" class="icon-calendar cm-external-focus"></span>
                                </div>
                                -
                                <div class="calendar">
                                    <input type="date" id="t_date" name="time_to" class="input-date cm-calendar hasDatepicker" value="{if isset($_REQUEST['time_to']) && $_REQUEST['time_to'] != ''}{$_REQUEST['time_to']}{/if}" size="10">
                                    <span data-ca-external-focus-id="t_date" class="icon-calendar cm-external-focus"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                {/capture}

                {include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="rating"}
            </form>
            {if $in_popup}
        </div></div>
    {else}
</div><hr>
{/if}
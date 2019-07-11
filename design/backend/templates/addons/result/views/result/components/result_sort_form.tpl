{if $in_popup}
    <div class="adv-search">
    <div class="group">
{else}
    <div class="sidebar-row">
    <h6>{__("search")}</h6>
{/if}

<form name="result_sort_form" action="{""|fn_url}" method="get" class="{$form_meta}">

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
                            <option value="A" selected="selected">Все</option>
                                <option value="M" {if $_REQUEST['period'] == "M"}selected="selected"{/if}>Текущий месяц</option>
                                <option value="LM" {if $_REQUEST['period'] == "LM"}selected="selected"{/if}>Предыдущий месяц</option>
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

    {include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search dispatch=$dispatch view_type="result"}

</form>

<form name="result_sort_form_data" action="{""|fn_url}" method="get" class="{$form_meta}">

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

    {capture name="simple_search_data"}
        <div class="sidebar-field">
            <label for="period_selects">Год:</label>
            <select name="yer" id="period_selects">
                <option value="2019" {if $_REQUEST['yer'] == "2019"} selected="selected" {/if}>2019</option>
                <option value="2020" {if $_REQUEST['yer'] == "2020"} selected="selected" {/if}>2020</option>
                <option value="2021" {if $_REQUEST['yer'] == "2021"} selected="selected" {/if}>2021</option>
            </select>
            <label for="period_selects">Месяц:</label>
            <select name="month" id="period_selects">
                <option value="01" {if $_REQUEST['month'] == "01"}selected="selected"{/if}>Январь</option>
                <option value="02" {if $_REQUEST['month'] == "02"}selected="selected"{/if}>Февраль</option>
                <option value="03" {if $_REQUEST['month'] == "03"}selected="selected"{/if}>Март</option>
                <option value="04" {if $_REQUEST['month'] == "04"}selected="selected"{/if}>Апрель</option>
                <option value="05" {if $_REQUEST['month'] == "05"}selected="selected"{/if}>Май</option>
                <option value="06" {if $_REQUEST['month'] == "06"}selected="selected"{/if}>Июнь</option>
                <option value="07" {if $_REQUEST['month'] == "07"}selected="selected"{/if}>Июль</option>
                <option value="08" {if $_REQUEST['month'] == "08"}selected="selected"{/if}>Август</option>
                <option value="09" {if $_REQUEST['month'] == "09"}selected="selected"{/if}>Сентябрь</option>
                <option value="10" {if $_REQUEST['month'] == "10"}selected="selected"{/if}>Октябрь</option>
                <option value="11" {if $_REQUEST['month'] == "11"}selected="selected"{/if}>Ноябрь</option>
                <option value="12" {if $_REQUEST['month'] == "12"}selected="selected"{/if}>Декабрь</option>
            </select>
        </div>
    {/capture}

    {include file="common/advanced_search.tpl" no_adv_link=true simple_search=$smarty.capture.simple_search_data dispatch=$dispatch view_type="result"}

</form>


{if $in_popup}
    </div></div>
{else}
    </div><hr>
{/if}
{if $display != "form"}
<div class="nowrap">
    <div class="form-inline">
        {else}
        <div class="sidebar-field">
            {/if}
            <label for="{$prefix}period_selects">{__("period")}:</label>
            <select name="{$prefix}period" id="{$prefix}period_selects">
                <option value="A" {if $period == "A" || !$period || $_REQUEST['period'] == "A"}selected="selected"{/if}>Выбрать</option>
                {if $days != "false"}
                    <option value="D" {if $period == "D" || $_REQUEST['period'] == 'D'}selected="selected"{/if}>{__("this_day")}</option>
                    <option value="LD" {if $period == "LD" || $_REQUEST['period'] == 'LD'}selected="selected"{/if}>{__("yesterday")}</option>
                {/if}
                <option value="M" {if $period == "M" || $_REQUEST['period'] == 'M'}selected="selected"{/if}>{__("this_month")}</option>
                <option value="LM" {if $period == "LM" || $_REQUEST['period'] == 'LM'}selected="selected"{/if}>{__("previous_month")}</option>
                <option value="C" {if $period == "C" || $_REQUEST['period'] == 'C'}selected="selected"{/if}>{__("custom")}</option>
            </select>

            {if $display != "form"}
            &nbsp;&nbsp;
            {else}
        </div>
        <div class="sidebar-field">
            {/if}
            {if $time_date != "false"}
                <label{if $display != "form"} class="label-html"{/if}>{__("select_dates")}:</label>

                {assign var="time_from" value="`$prefix`time_from"}
                {assign var="time_to" value="`$prefix`time_to"}

                {if $display == "form"}
                    {assign var="date_meta" value="input-date"}
                {else}
                    {assign var="date_meta" value="input-small"}
                {/if}

                {include file="common/calendar.tpl" date_id="`$prefix`f_date" date_name="`$prefix`time_from" date_val="{if $_REQUEST['time_from']}{$_REQUEST['time_from']}{else}{$search.$time_from}{/if}" start_year=$settings.Company.company_start_year extra="onchange=\"Tygh.$('#`$prefix`period_selects').val('C');\"" date_meta=$date_meta}
                {if $display == "form"}
                    -
                {else}
                    &nbsp;&nbsp;-&nbsp;&nbsp;
                {/if}
                {include file="common/calendar.tpl" date_id="`$prefix`t_date" date_name="`$prefix`time_to"  date_val="{if $_REQUEST['time_to']}{$_REQUEST['time_to']}{else}{$search.$time_to}{/if}" start_year=$settings.Company.company_start_year extra="onchange=\"Tygh.$('#`$prefix`period_selects').val('C');\"" date_meta=$date_meta}
            {/if}

            {if $additional_search != "false"}
                <h6>Сохраненное</h6>
                <div class="sidebar-field">
                    <label for="period_selects">Год:</label>
                    <select name="yer" id="period_selects">
                        <option value="" {if $_REQUEST['yer'] == ""} selected="selected" {/if}>Выбрать</option>
                        <option value="2019" {if $_REQUEST['yer'] == "2019"} selected="selected" {/if}>2019</option>
                        <option value="2020" {if $_REQUEST['yer'] == "2020"} selected="selected" {/if}>2020</option>
                        <option value="2021" {if $_REQUEST['yer'] == "2021"} selected="selected" {/if}>2021</option>
                    </select>
                    <label for="period_selects">Месяц:</label>
                    <select name="month" id="period_selects">
                        <option value="" {if $_REQUEST['month'] == ""}selected="selected"{/if}>Выбрать</option>
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
            {/if}

            {if $display != "form"}
        </div>
    </div>
    {else}
</div>
{/if}

{script src="js/tygh/period_selector.js"}
<script type="text/javascript">
    Tygh.$(document).ready(function() {$ldelim}
    Tygh.$('#{$prefix}period_selects').cePeriodSelector({$ldelim}
        from: '{$prefix}f_date',
        to: '{$prefix}t_date'
    {$rdelim});
    {$rdelim});
</script>
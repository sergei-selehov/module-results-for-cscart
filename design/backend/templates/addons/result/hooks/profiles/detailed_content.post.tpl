{if $user_data.user_type == "A"}
{include file="common/subheader.tpl" title="Сотрудник"}

    <div class="control-group">
        <label class="control-label" for="elm_employment_date">Дата приема на работу:</label>
        <div class="controls">
            {include file="common/calendar.tpl" date_id="elm_employment_date" date_name="user_data[result_employment_date]" date_val=$user_data.result_employment_date|default:$smarty.const.TIME start_year=$settings.Company.company_start_year}
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="elm_user_salary">Оклад</label>
        <div class="controls">
            <input type="text" name="user_data[result_salary]" id="elm_user_salary" size="30" value="{$user_data.result_salary}"/>
        </div>
    </div>

    <div class="control-group">
        <div class="controls">
            <label class="checkbox" for="elm_result_calc">
                <input class="cm-combination" type="checkbox" id="elm_result_calc" name="user_data[result_calc]" value="Y" {if $user_data.result_calc == 'Y'}checked{/if}>Расчитывать результативность</label>
        </div>
    </div>

    <div class="control-group">
        <div class="controls">
            <label class="checkbox" for="elm_result_head">
                <input class="cm-combination" type="checkbox" id="elm_result_head" name="user_data[result_head]" value="Y" {if $user_data.result_head == 'Y'}checked{/if}>Руководитель</label>
        </div>
    </div>

    <div class="control-group">
        <div class="controls">
            <label class="checkbox" for="elm_result_remote">
                <input class="cm-combination" type="checkbox" id="elm_result_remote" name="user_data[result_remote]" value="Y" {if $user_data.result_remote == 'Y'}checked{/if}>Удаленный оператор</label>
        </div>
    </div>
{/if}
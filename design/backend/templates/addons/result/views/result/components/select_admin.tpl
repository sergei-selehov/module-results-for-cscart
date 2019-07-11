{if "MULTIVENDOR"|fn_allowed_for}
    {$extra_url = "&user_type=V"}
{else}
    {$extra_url = "&user_type=A"}
{/if}

<div class="form-inline object-selector">
    <select multiple id="{$id}"
            class="cm-object-selector"
            name="{$name}"
            data-ca-enable-search="true"
            data-ca-load-via-ajax="true"
            data-ca-page-size="10"
            data-ca-data-url="{"profiles.get_user_list?lang_code=`$descr_sl`&exclude_user_types=A`$extra_url`&include_empty=true"|fn_url nofilter}"
            data-ca-placeholder="Не выбрано"
            data-ca-allow-clear="true"
            data-ca-ajax-delay="250">
        {foreach from=$selected item=select}
            <option value="{$select}" selected="selected">{fn_get_user_name($select)}</option>
        {/foreach}
    </select>
</div>
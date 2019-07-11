{capture name="usergroups_list"}
    <select name="{$name}" id="{$id}">
        <option id="{$id}_0" value="" {if empty($usergroup_id)} selected="selected" {/if}>Выбрать</option>
        {foreach from=$usergroups item=usergroup}
            <option id="{$id}_{$usergroup.usergroup_id}" value="{$usergroup.usergroup_id}" {if $usergroup.usergroup_id == $usergroup_id} selected="selected" {/if}>{$usergroup.usergroup}</option>
        {/foreach}
    </select>
{/capture}

{$smarty.capture.usergroups_list nofilter}

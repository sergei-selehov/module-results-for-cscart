<div class="sidebar-row">
    <h6>Расчет</h6>
    <form action="{""|fn_url}" name="result_form" method="get">
        <input type="hidden" name="object" value="{$smarty.request.object}">

        {capture name="simple_search"}
            {include file="addons/result/views/result/components/period_result.tpl" period=$search.period extra="" display="form" button="false" additional_search="true"}
        {/capture}

        {include file="common/advanced_search.tpl" simple_search=$smarty.capture.simple_search dispatch="result.manage" view_type="result"}

    </form>
</div>
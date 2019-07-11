<div class="sidebar-row">
    <h6>Сортировка</h6>
    <form action="{""|fn_url}" name="result_form" method="get">
        <input type="hidden" name="object" value="{$smarty.request.object}">

        {capture name="simple_search"}
            {include file="addons/result/views/result/components/period_result.tpl" period=$search.period extra="" display="form" days="false" additional_search="false"}
        {/capture}

        {include file="common/advanced_search.tpl" simple_search=$smarty.capture.simple_search dispatch="result.rating" view_type="result"}

    </form>
</div>
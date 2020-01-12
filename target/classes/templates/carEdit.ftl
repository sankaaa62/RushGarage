<#import "parts/common.ftl" as c>

<@c.page>
    Car editor
    <form action="/car/save" method="post">
        <input type="text" value="${car.carname}" name="carname">
        <input type="hidden" value="${car.id}" name="carId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit">Save</button>
    </form>
</@c.page>
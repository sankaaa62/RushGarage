<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
    <div>
        <div class="form-group mt-3">
            <form action="/car/order/add" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <input type="hidden" name="carId" value="${car.id}"/>
                <input type="hidden" name="cost" value="${car.cost}"/>

                <div class="card my-3" style="width: 50rem;">

                    <div class="card-header">
                        <h5>Rental application: ${car.carname}</h5>
                    </div>
                    <div class="card-body m-2">
                        <div class="form-group">
                            <#if car.filename??>
                                <img class="card-img-top" src="/img/${car.filename}" alt="Card image cap">
                            </#if>
                        </div>

                        <div class="form-group">
                            <b>Client: </b>
                             ${name}
                        </div>

                        <div class="form-group">
                            <b>Order cost: </b>
                             $${car.cost} per day
                        </div>

                        <div class="form-group">
                            <label for="dateStart">Choose date rent</label>
                            <input type="date" class="form-control" name="datestart" id="dateStart">
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control" name="duration" placeholder="Rent duration"/>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="text" placeholder="Comment"/>
                        </div>

                    </div>
                    <div class="card-footer text-muted">
                            <button type="submit" class="btn btn-primary">Забронировать</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</@c.page>
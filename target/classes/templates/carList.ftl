<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
    <#if isAdmin>
        <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
            Add new Car
        </a>
    </#if>

    <div class="collapse" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control" name="carname" placeholder="Введите название автомобиля"/>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="description" placeholder="Введите описание"/>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" name="cost" placeholder="Стоимость аренды"/>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Add car</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list cars as car>
            <div class="card my-3">
                <div class="card-header">
                    <#if car.carname??>
                        <h5>Model: ${car.carname}</h5>
                    <#else>
                        <h5>Model: <i>unknown</i></h5>
                    </#if>
                </div>
                <div class="card-body m-2">
                    <div>
                        <#if car.filename??>
                            <img class="card-img-top" src="/img/${car.filename}" alt="Card image cap">
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Description:</b>
                        <#if car.description??>
                            ${car.description}
                        <#else>
                            <i>none</i>
                        </#if>
                    </div>

                    <div class="mt-2">
                        <b>Order cost: </b>
                        <#if car.cost??>
                            $${car.cost} per day
                        <#else>
                            <i>is negotiable</i>
                        </#if>
                    </div>
                </div>

                <div class="card-footer text-muted">
                    <#if isAdmin>
                        <a href="/car/edit/${car.id}" class="btn btn-secondary">Edit</a>
                    </#if>
                    <a href="/car/order/${car.id}" class="btn btn-secondary">Order</a>
                </div>
            </div>
        <#else>
            No cars
        </#list>
    </div>
</@c.page>
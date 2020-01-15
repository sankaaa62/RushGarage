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
                        Заявка на бронирование ${car.carname}
                    </div>
                    <div class="card-body m-2">
                        <div>
                            <#if car.filename??>
                                <img class="card-img-top" src="/img/${car.filename}" alt="Card image cap">
                            </#if>
                        </div>
                        <span>${car.description}</span>
                        <div class="mt-2 mb-4">
                            <i>Cost: $${car.cost} per day</i>
                        </div>

                        <div class="form-group">
                            <label for="dateStart">Choose date rent</label>
                            <input type="date" class="form-control" name="datestart" id="dateStart">
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control" name="duration" placeholder="Длительность аренды"/>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="text" placeholder="Коментарий"/>
                        </div>
                        <div class="form-group">
                            <div class="custom-file">
                                <input type="file" name="file" id="customFile">
                                <label class="custom-file-label" for="customFile">Choose file</label>

                            </div>
                        </div>

                    </div>
                    <div class="card-footer text-muted">
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Забронировать</button>
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</@c.page>
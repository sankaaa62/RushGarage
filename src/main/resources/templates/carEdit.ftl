<#import "parts/common.ftl" as c>

<@c.page>
    <h3> Car editor</h3>
    <form action="/car/save" method="post" enctype="multipart/form-data">
        <input type="hidden" value="${car.id}" name="carId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">

        <div class="form-group">
            <div class="custom-file">
                <input type="file"
                       name="file"
                       id="customFile"
                >
                <label class="custom-file-label"
                       for="customFile">
                    Choose file
                </label>
            </div>
        </div>

        <div class="form-group">
            <label for="InputName">Name car</label>
            <input type="text"
                   id="InputName"
                   class="form-control"
                   placeholder="Enter new car name"
                   value="${car.carname}"
                   name="carname">
        </div>
        <div class="form-group">
            <label for="InputDescription">Description</label>
            <input type="text"
                   class="form-control"
                   id="InputDescription"
                   placeholder="Enter description"
                   value="${car.description}"
                   name="description">
        </div>
        <div class="form-group">
            <label for="InputDescription">Cost</label>
            <input type="text"
                   class="form-control"
                   id="InputCost"
                   placeholder="Enter cost order"
                   value="${car.cost}"
                   name="cost">
        </div>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</@c.page>
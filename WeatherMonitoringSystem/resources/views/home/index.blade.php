@extends('layout.base')

@section('content')

<div>

    {{-- breadcrumb --}}
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item active" aria-current="page">Home</li>
        </ol>
    </nav>
    {{--!Ends breadcrumb --}}

    <button class="btn btn-primary bg-primary" type="button" data-toggle="modal" data-target="#addDeviceModal">
        <i class="material-icons">add</i>
        Add New Device
    </button>

    {{-- data table  --}}
    <div class="table-responsive mt-4">
        <table class="table">
            <thead class="text-uppercase">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Device Key</th>
                    <th scope="col">Location</th>
                    <th scope="col">Updated At</th>
                    <th scope="col">Temperature</th>
                    <th scope="col">Pressure</th>
                    <th scope="col">Rain</th>
                    <th scope="col">Humidity</th>
                    <th scope="col">Soil Moisture</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                @if (!empty($devices))
                @foreach ($devices as $item)
                <tr>
                    <th scope="row">{{$loop->index + 1}}</th>
                    <td>{{$item['device_key']}}</td>
                    <td>{{$item['location']}}</td>
                   <td>{{  date( "m/d/Y", strtotime($item['updated_at']))  }}</td>
                    <td>{{$item['temperature']}}&#8451;</td>
                    <td>{{$item['pressure']}}mb</td>
                    <td>{{$item['rain']}}%</td>
                    <td>{{$item['humidity']}}%</td>
                    <td>{{$item['soil_moisture']}}%</td>
                    <td>
                        <div class="d-flex">
                            <a href="/device/{{$item['devices_id']}}/remove"
                                class="btn btn-float btn-danger btn-sm ml-1" type="button" data-toggle="tooltip"
                                data-placement="bottom" title="Remove Device">
                                <i class="material-icons">delete</i>
                            </a>
                        </div>
                    </td>
                </tr>
                @endforeach
                @endif
            </tbody>
        </table>


    </div>
    {{--!ends data table  --}}


</div>


@endsection


@section('modal')
<!-- Modal -->
<div class="modal fade" id="addDeviceModal" tabindex="-1" role="dialog" aria-labelledby="addDeviceModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addDeviceModalLabel">Add New Device</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/add-new-device" method="POST">
                    {{ csrf_field() }}
                    <div class="form-group">
                        <label>Device Location</label>
                        <input name="location" required type="text" class="form-control"
                            placeholder="Enter Device Location">
                    </div>
                    <div class="form-group">
                        <label>Device Key</label>
                        <input name="device_key" required type="text" class="form-control"
                            placeholder="Enter Device Key">
                    </div>
                    <button type="submit" class="btn btn-primary bg-primary">Add Device</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary " data-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>
</div>
@endsection


$(document).ready(function() {
    var pageCache;
    var planetsCache;
    var $modal = $("#residentsModal");
    var $modalStats = $("#voteStatsModal");

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-bottom-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    function init() {
        getPlanetsData('http://swapi.co/api/planets');
    }

    function getPlanetsData(url) {
        try {
            $.ajax({
                dataType: "json",
                url: url,
                success: function(response) {
                    storePageCache(response.next, response.previous);
                    showPlanets(response);
                }
            });
        } catch (e) {
            toastr["error"]("Planets could not be loaded! Try again later!", "Internal Error")
        }
    }

    function storePageCache (next, previous) {
        pageCache = {
            next: next,
            previous: previous
        };
    }

    function showPlanets(response) {
        planetsCache = [];
        
        $("#planets table").hide();

        $("#table-body").children().remove();

        $.each(response.results, function(index, value) {
            if (value.residents.length > 0) {
                planetsCache.push({
                    planet: value.name,
                    residents: getResidents(value.residents)
                });
            }

            $("#table-body").append('<tr' + (value.residents.length > 0 ? ' data-resident=' + (planetsCache.length - 1) : "") + '> \
                                        <td class="align-middle">' + value.name + '</td> \
                                        <td class="number-align align-middle">' + formatNumber(value.diameter) + '</td> \
                                        <td class="align-middle">' + value.climate + '</td> \
                                        <td class="align-middle">' + value.terrain + '</td> \
                                        <td class="number-align align-middle">' + value.surface_water + (value.surface_water !== "unknown" ? "%" : "")  + '</td> \
                                        <td class="number-align align-middle">' + formatNumber(value.population) + '</td> \
                                        <td class="residents center align-middle">' + (value.residents.length > 0 ? ('<button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#residentsModal">' + value.residents.length + '</button>') : '<button type="button" class="btn btn-outline-info" disabled>?</button>') + '</td> \
                                        <td class="vote center align-middle"><button type="button" class="vote-button btn btn-outline-success">+1</button></td> \
                                        </tr>')
        });

        setPageButtons();
        $("#planets table").show();
    }

    function setPageButtons() {
        if (pageCache.next === null) {
            $("#next-button").prop('disabled', true);
        }
        else {
            $("#next-button").prop('disabled', false);
        }

        if (pageCache.previous === null) {
            $("#previous-button").prop('disabled', true);
        }
        else {
            $("#previous-button").prop('disabled', false);
        }
    }

    function formatNumber(number) {
        var regexp = /(\d+)(\d{3})/;
        return String(number).replace(/^\d+/, function(w){
            while(regexp.test(w)){
                w = w.replace(regexp, '$1,$2');
            }
            return w;
        });
    }

    function getResidents(linkArray) {
        var residentIds = [];
        $.each(linkArray, function (index, link) {
            var arr = link.match(/people\/(\d+)\/$/);
            residentIds.push(arr[1]);
        });
        return residentIds;
    }

    $modal.on('show.bs.modal', function (e) {
        var residentsId = $(e.relatedTarget).closest('tr').data('resident');
        var residentsData = planetsCache[residentsId];
        $modal.find('#residentsModalLabel').text('Residents of ' + residentsData.planet);
        var shownModal = $(this);
        shownModal.find('#residentsBody').html('<div class="loading">loading...</div>');
        var xhrs = [];
        var retrievedResidents = [];
        try {
            $.each(residentsData.residents, function (index, resident) {
                var xhr = $.ajax({
                    dataType: "json",
                    url: 'http://swapi.co/api/people/' + resident,
                    success: function (data) {
                        retrievedResidents.push(data);
                    }
                });
                xhrs.push(xhr);
            });
        } catch (e) {
            toastr["error"]("Residents data could not be loaded! Try again later!", "Internal Error")
        }
        $.when.apply($, xhrs).done(function () {
            var tableBody = '<table class="table table-sm table-hover"> \
                                <thead class="modal-thead"> \
                                    <tr> \
                                        <th>Name</th> \
                                        <th>Height</th> \
                                        <th>Mass</th> \
                                        <th>Hair Color</th> \
                                        <th>Skin Color</th> \
                                        <th>Eye Color</th> \
                                        <th>Birth Year</th> \
                                        <th>Gender</th> \
                                    </tr> \
                                </thead> \
                                <tbody>';
            $.each(retrievedResidents, function (i, residentObj) {
                tableBody += '<tr> \
                                <td>' + residentObj.name + '</td> \
                                <td class="modal-td-right">' + residentObj.height + '</td> \
                                <td class="modal-td-right">' + residentObj.mass + '</td> \
                                <td>' + residentObj.hair_color + '</td> \
                                <td>' + residentObj.skin_color + '</td> \
                                <td>' + residentObj.eye_color + '</td> \
                                <td class="modal-td-right">' + residentObj.birth_year + '</td> \
                                <td>' + residentObj.gender + '</td> \
                              </tr>';
            });
            tableBody += '</tbody></table>';
            shownModal.find('#residentsBody').html(tableBody);
        });
    });

    $("#next-button").on('click', function(){
        if (pageCache.next !== null) {
            getPlanetsData(pageCache.next);
        }
    });

    $("#previous-button").on('click', function(){
        if (pageCache.previous !== null) {
            getPlanetsData(pageCache.previous);
        }
    });

    $("#planets tbody").on('click', '.vote-button', function(){
        planetName = $(this).closest('tr').children().first()[0].textContent;
        $.post("/vote", {planet_name: planetName})
        .done(function(data) {
            toastr["success"]("You sucessfully changed your vote!", "Success!")
        })
        .fail(function() {
            toastr["error"]("Vote could not be changed!", "Internal Error")
        })
        .always(function() {
            init();
        });
    });

    $modalStats.on('show.bs.modal', function (e) {
        var shownModal = $(this);
        shownModal.find('#votes-table-wrapper').hide();
        
        $.ajax({
            url: '/vote-stats',
            dataType: 'json',
            success: function(response) {
                $("#votingStatsBody").children().remove();

                $.each(response.vote_stats, function (index, planet) {
                    $("#votingStatsBody").append('<tr> \
                                                    <td>' + planet.planet_name + '</td> \
                                                    <td>' + planet.vote_count + '</td> \
                                                  </tr>');
                });

                shownModal.find('#loading-votes').hide();
                shownModal.find('#votes-table-wrapper').show();
            }
        });
    });

    $('body').on('hidden.bs.modal', '.modal', function() {
        $('.btn').blur();
        $('#voting-stats').blur();
    }); 

    init();

});

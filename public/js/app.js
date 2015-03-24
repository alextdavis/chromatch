var expertises = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: {
        url: '/expertises.json',
        filter: function(list) {
            return $.map(list, function(val){ return { value: val }; });
        }
    }
});

expertises.initialize();

$(function() {
    $('.validate').typeahead({
        highlight: true
    },{
        name: 'expertise',
        displayKey: 'value',
        source: expertises.ttAdapter()
    });

    $('.validate').bind('keypress', function(e) {
        if(e.keyCode==13){
            console.log("enter")
        }
    });
});
$(function () {
    $(".submit-btn").click(function (e) {
        e.preventDefault();

        $(this).closest("form").first().submit();
    });

    $(".collection #load_more").click(function () {
        $.ajax({
            url: '/results/more',
            type: 'POST',
            data: {
                offset: $(".result_item").length
            },
            success: function (data) {
                $("#load_more").before(data);
                reconnect_events();
            }
        });
    });
});

function reconnect_events() {
    $(".collection .btn-bookmark-toggle").click(function (e) {
        e.preventDefault();

        $.ajax({
            url: '/api/bookmark/toggle',
            type: 'POST',
            data: {
                user_id: $(this).data('id')
            },
            success: function (data) {
                is_bookmarked = data == "true";
                $(this).find('i').removeClass(is_bookmarked ? "fa-star-o" : "fa-star").addClass(is_bookmarked ? "fa-star" : "fa-star-o");
            },
            error: function() {
                alert("Bookmarking operation failed");
            }
        });
    });
}

$('.multiple-items').slick({
    infinite: true,
    slidesToShow: 6,
    slidesToScroll: 6,
    arrows: true,
    dots: true,
    responsive: [
        {
            breakpoint: 350,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1
            }
        },
        {
            breakpoint: 500,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 2
            }
        },
        {
            breakpoint: 750,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3
            }
        },
        {
            breakpoint: 1000,
            settings: {
                slidesToShow: 4,
                slidesToScroll: 4
            }
        },
        {
            breakpoint: 1250,
            settings: {
                slidesToShow: 5,
                slidesToScroll: 5
            }
        },
    ]
});
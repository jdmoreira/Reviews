enum Mocked {
    static let reviews: [Review] = [
        Review(name: nil, score: 4, timepassed: "12h", source: "hitta.se",
               comment: "Liked it very mych - probably one of the best thai restaurants in the city - recommend!"),

        Review(name: "Jenny Svensson", score: 3, timepassed: "1d", source: "hitta.se",
               comment: "Maybe a bit too fast food. I personally dislike that. Good otherwise."),

        Review(name: "happy56", avatar: "avatar_real", score: 5, timepassed: "1d", source: "yelp.com",
               comment: "Super good! Love the food!")]
}

extension Business.Identifier {
    static var philsBurger = "ctyfiintu"
}

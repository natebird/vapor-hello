import Vapor
import VaporPostgreSQL

// let postgresql = VaporPostgreSQL.Provider(user: "postgres")
let drop = Droplet(
    preparations: [Post.self],
    providers: [VaporPostgreSQL.Provider.self]
)

drop.get("hello") { request in
    return "Hello, world!"
}

drop.get { req in
    let lang = req.headers["Accept-Language"]?.string ?? "en"
    return try drop.view.make("welcome", [
    	"message": Node.string(drop.localization[lang, "welcome", "title"])
    ])
}

drop.resource("posts", PostController())

drop.run()

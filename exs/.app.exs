alias App.PgRepo
alias App.Ecto.Tour01.Hub
alias App.Ecto.Tour01.Hub.{User, Link, Tag, Pin, UserTag, PinTag}

# pin1 =
#   from(p in Pin, left_join: t in assoc(p, :tags), where: [id: 1], preload: [tags: t])
#   |> PgRepo.one()

# tag1 = tag1 = Tag |> PgRepo.get(1)

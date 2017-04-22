# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Shop.Repo.insert!(%Shop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

(1 .. 5000)
|> Enum.each(fn(_x) ->

    previous = Enum.random(10..1000)
    actual = round(previous * (Enum.random(20 ..90) / 100))
    Shop.Repo.insert!(
      %Shop.Sales.Product{
        previous: previous,
        actual: actual
      }
    )
  end)

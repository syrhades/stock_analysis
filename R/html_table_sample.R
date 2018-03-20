htmlTable(mx, 
          total = "tspanner",
          css.total = c("border-top: 1px dashed grey;",
                        "border-top: 1px dashed grey;",
                        "border-top: 1px solid grey; font-weight: 900"),
          tspanner = paste("Spanner", LETTERS[1:3]),
          n.tspanner = c(2,4,nrow(mx) - 6))



htmlTable(mx, 
          align="r",
          rgroup = paste("Group", LETTERS[1:3]),
          n.rgroup = c(2,4,nrow(mx) - 6),
          cgroup = rbind(c("", "Column spanners", NA),
                         c("", "Cgroup 1", "Cgroup 2&dagger;")),
          n.cgroup = rbind(c(1,2,NA),
                           c(2,2,2)),
          caption="A table with column spanners, row groups, and zebra striping",
          tfoot="&dagger; A table footer commment",
          cspan.rgroup = 2,
          col.columns = c(rep("none", 2),
                          rep("#F5FBFF", 4)),
          col.rgroup = c("none", "#F7F7F7"),
          css.cell = "padding-left: .5em; padding-right: .2em;")



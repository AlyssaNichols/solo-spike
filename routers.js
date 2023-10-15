
app.use('/api/customers', customersRouter);
app.use('/api/services', servicesRouter);
app.use('/api/user', userRouter);


router.get("/", (req, res) => {
  console.log("GET /api/customers");
  pool
    .query('SELECT * from "customers";')
    .then((response) => {
      res.send(response.rows);
    })
    .catch((error) => {
      console.log("Error GET /api/customers", error);
      res.sendStatus(500);
    });
});

router.get("/", (req, res) => {
  console.log("GET /api/services");
  pool
    .query('SELECT * from "services";')
    .then((response) => {
      res.send(response.rows);
    })
    .catch((error) => {
      console.log("Error GET /api/services", error);
      res.sendStatus(500);
    });
});

router.get("/", (req, res) => {
  console.log("GET /api/user");
  pool
    .query('SELECT * from "user";')
    .then((response) => {
      res.send(response.rows);
    })
    .catch((error) => {
      console.log("Error GET /api/user", error);
      res.sendStatus(500);
    });
});

router.delete("/:id", (req, res) => {
  pool
    .query('DELETE FROM "customers" WHERE id=$1', [req.params.id])
    .then((response) => {
      res.sendStatus(200);
    })
    .catch((error) => {
      console.log("Error DELETE /api/customers", error);
      res.sendStatus(500);
    });
});
router.delete("/:id", (req, res) => {
  pool
    .query('DELETE FROM "services" WHERE id=$1', [req.params.id])
    .then((response) => {
      res.sendStatus(200);
    })
    .catch((error) => {
      console.log("Error DELETE /api/services", error);
      res.sendStatus(500);
    });
});
router.delete("/:id", (req, res) => {
  pool
    .query('DELETE FROM "user" WHERE id=$1', [req.params.id])
    .then((response) => {
      res.sendStatus(200);
    })
    .catch((error) => {
      console.log("Error DELETE /api/user", error);
      res.sendStatus(500);
    });
});

// for invoice table to update date paid
router.put("/:id", (req, res) => {
  const queryText = `UPDATE "invoice"
                            SET "date_paid" = $1 WHERE "id" = $2;`;
  pool
    .query(queryText, [req.body.date_paid, req.params.id])
    .then((response) => {
      res.sendStatus(200);
    })
    .catch((err) => {
      console.log("error saving to database", err);
      res.sendStatus(500);
    });
});

//   // post route-FROM MOVIE ASSIGNMENT. USE AS REFERENCE
// router.post("/", (req, res) => {
//     console.log(req.body);
//     // RETURNING "id" will give us back the id of the created movie
//     const movieQueryText = `
//     INSERT INTO "movies" ("title", "poster", "description")
//     VALUES ($1, $2, $3)
//     RETURNING "id";`;

//     // FIRST QUERY MAKES MOVIE TO ADD
//     pool
//       .query(movieQueryText, [
//         req.body.title,
//         req.body.poster,
//         req.body.description,
//       ])
//       .then((result) => {
//         // ID will show in this console log
//         console.log("New Movie Id:", result.rows[0].id);
//         const newMovieId = result.rows[0].id;

//         // GENRE info
//         const genreQueryText = `
//         INSERT INTO "movies_genres" ("movie_id", "genre_id")
//         VALUES  ($1, $2);
//         `;
//         // SECOND QUERY ADDS GENRE FOR THAT NEW MOVIE
//         pool
//           .query(genreQueryText, [newMovieId, req.body.genre_id])
//           .then((result) => {
//             res.sendStatus(201);
//           })
//           .catch((err) => {
//             // catch for second query
//             console.log(err);
//             res.sendStatus(500);
//           });
//         // Catch for first query
//       })
//       .catch((err) => {
//         console.log(err);
//         res.sendStatus(500);
//       });
//   });

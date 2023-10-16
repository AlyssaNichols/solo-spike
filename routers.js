app.use("/api/customers", customersRouter);
app.use("/api/services", servicesRouter);
app.use("/api/user", userRouter);

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

//  post route to add an invoice
router.post("/", (req, res) => {
  console.log(req.body);
  console.log(req.user);
  const queryText = `
  INSERT INTO invoice ("user_id", "date_issued", "customer_id")
  VALUES (
      $1,
      $2,
      $3);`;
  pool
    .query(queryText, [
      req.user.id,
      req.body.date_issued,
      req.body.customer_id,
    ])
    .then((response) => {
      res.sendStatus(201);
    })
    .catch((err) => {
      console.log("error POSTing invoice", err);
      res.sendStatus(500);
    });
});

// to add a line item
router.post("/", (req, res) => {
  console.log(req.body);
  console.log(req.user);
  const queryText = `
    INSERT INTO line_item ("service_id", "date_performed", "service_price", "invoice_id")
VALUES
    $1, $2, $3, $4),`;
  pool
    .query(queryText, [
      req.body.service_id,
      req.body.date_performed,
      req.body.service_price,
      req.body.invoice_id,
    ])
    .then((response) => {
      res.sendStatus(201);
    })
    .catch((err) => {
      console.log("error POSTing invoice", err);
      res.sendStatus(500);
    });
});

// GET ALL INVOICE INFORMATION
router.get("/", (req, res) => {
  console.log("GET /api/invoice");
  const queryText = `SELECT i.id AS invoice_id,
    json_agg(li.service_id) AS service_ids,
    json_agg(li.date_performed) AS dates_performed,
    json_agg(li.service_price) AS service_prices,
    json_agg(s.service) AS services,
    i.total_price,
    i.customer_id,
    c.first_name,
    c.last_name,
    c.address,
    c.city,
    c.state,
    c.zip,
    c.email,
    c.phone
FROM invoice i
LEFT JOIN line_item li ON i.id = li.invoice_id
LEFT JOIN services AS s ON li.service_id = s.id
LEFT JOIN customers AS c ON i.customer_id = c.id
GROUP BY i.id, i.total_price, i.customer_id, c.first_name, c.last_name, c.address, c.city, c.state, c.zip, c.email, c.phone;`;
  pool
    .query(queryText)
    .then((response) => {
      res.send(response.rows);
    })
    .catch((error) => {
      console.log("Error GET /api/customers", error);
      res.sendStatus(500);
    });
});

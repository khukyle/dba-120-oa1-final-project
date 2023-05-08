const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql')

const app = express()
const port = process.env.PORT || 5000

app.use(bodyParser.urlencoded({ extended: false }))

app.use(bodyParser.json())

// MySQL

const pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'localhost',
  user            : 'root',
  password        : '',
  database        : 'ticket_sales'
})

// Show all sales
app.get('', (req, res) => {

  pool.getConnection((err, connection) => {
    if(err) throw err
    console.log(`connected as id${connection.threadId}`)

    connection.query('SELECT * from sales', (err, rows) => {
      connection.release()

      if (!err) {
        res.send(rows)
      } else {
        console.log(err)
      }
    })
  })
})

// Show sale by ID number
app.get('/:sale_id', (req, res) => {

  pool.getConnection((err, connection) => {
    if(err) throw err
    console.log(`connected as id${connection.threadId}`)

    connection.query('SELECT * from sales WHERE sale_id = ?', [req.params.sale_id], (err, rows) => {
      connection.release()

      if (!err) {
        res.send(rows)
      } else {
        console.log(err)
      }
    })
  })
})

// Delete a sale record
app.delete('/:sale_id', (req, res) => {

  pool.getConnection((err, connection) => {
    if(err) throw err
    console.log(`connected as id${connection.threadId}`)

    connection.query('DELETE from sales WHERE sale_id = ?', [req.params.sale_id], (err, rows) => {
      connection.release()

      if (!err) {
        res.send(`Ticket sale with the ID ${[req.params.sale_id]} has been removed.`)
      } else {
        console.log(err)
      }
    })
  })
})

// Add a sale record
app.post('', (req, res) => {

  pool.getConnection((err, connection) => {
    if(err) throw err
    console.log(`connected as id${connection.threadId}`)

    const params = req.body
    connection.query('INSERT INTO sales SET ?', params, (err, rows) => {
      connection.release()

      if (!err) {
        res.send(`Ticket sale with the ID ${params.sale_id} has been added.`)
      } else {
        console.log(err)
      }
    })
    console.log(req.body)
  })
})

// Update a sale record
app.put('', (req, res) => {

  pool.getConnection((err, connection) => {
    if(err) throw err
    console.log(`connected as id${connection.threadId}`)

    const { sale_id, customer_id, event_id, ticket_quantity, ticket_price, fees, tax, sale_total} = req.body

    connection.query('UPDATE sales SET ticket_quantity = ? WHERE = sale_id ?', [ticket_quantity, sale_id], (err, rows) => {
      connection.release()

      if (!err) {
        res.send(`Ticket quantity with the ID ${sale_id} has been updated.`)
      } else {
        console.log(err)
      }
    })
    console.log(req.body)
  })
})

app.listen(port, () => console.log(`Listen on port ${port}`))
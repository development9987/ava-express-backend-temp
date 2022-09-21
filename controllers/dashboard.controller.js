const { tasks } = require('../db/models');
const { getResultQuery } = require('../core/util');
const settingsService = require('../services/settings/settings.service');

module.exports = {
  async getPersonData(req, res) {
    const adminId = await settingsService.getAdminId(req.params.id);
    const resources = await getResultQuery(` SELECT t0.name, IF(t1.counts IS NULL,0,t1.counts) AS serving,IF(t2.counts IS NULL,0,t2.counts) AS waitlist, IF(t3.counts IS NULL,0,t3.counts) AS booking FROM resources AS t0
        LEFT JOIN (SELECT COUNT(*) AS counts ,t1.resource_id FROM customers AS t0 
            INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id
            WHERE t1.serve_time IS NOT NULL GROUP BY t1.resource_id) AS t1 ON t0.id = t1.resource_id
        LEFT JOIN (SELECT t1.resource_id,COUNT(*) AS counts FROM customers AS t0 
            INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id
            WHERE t1.serve_time IS NULL AND t1.done_time IS NULL GROUP BY t1.resource_id) AS t2 ON t2.resource_id = t0.id
        LEFT JOIN (SELECT COUNT(*) AS counts,t1.resource FROM customers AS t0 
            INNER JOIN bookings AS t1 ON t1.customer_id = t0.id GROUP BY t1.resource) AS t3 ON t0.id = t3.resource
        WHERE t0.user_id = ${adminId}`);
    res.status(200).send({
      result: resources,
      success: true,
    });
  },
  async getTaskData(req, res) {
    const adminId = await settingsService.getAdminId(req.params.id);
    const result = await tasks.findAll({
      where: {
        user_id: adminId,
      },
    });
    res.status(200).send({
      result,
      success: true,
    });
  },
  async dashboardData(req, res) {
    const adminId = await settingsService.getAdminId(req.user.id);
    const result = { first: {}, second: {}, third: {}, fource: {} };

    const first = await getResultQuery(`SELECT t1.counts AS resource,t2.counts AS booking,t3.counts AS serving, t4.counts AS waitlist 
            FROM (SELECT COUNT(*) AS counts FROM resources WHERE user_id = ${adminId}) AS t1,
            (SELECT COUNT(*) AS counts FROM customers AS t0 
            INNER JOIN bookings AS t1 ON t1.customer_id = t0.id
            WHERE t0.user_id = ${adminId} AND t1.user_id = ${adminId} AND t1.appointment_time BETWEEN '${req.params.start}' AND '${req.params.end}') AS t2,
            (SELECT COUNT(*) AS counts FROM customers AS t0 
            INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id
            WHERE t0.user_id = ${adminId} AND t1.user_id = ${adminId} AND t1.serve_time IS NOT NULL AND t1.done_time IS NULL AND t1.serve_time BETWEEN '${req.params.start}' AND '${req.params.end}') AS t3,
            (SELECT COUNT(*) AS counts FROM customers AS t0 
            INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id
            WHERE t0.user_id = ${adminId} AND t1.user_id = ${adminId} AND t1.serve_time IS NULL AND t1.wait_time BETWEEN '${req.params.start}' AND '${req.params.end}') AS t4`);
    result.first = first[0];

    const second = {};
    second.total = await getResultQuery(`SELECT t1.counts AS total,t2.counts AS todo,t3.counts AS doing,t4.counts AS done FROM (SELECT COUNT(*) AS counts FROM tasks WHERE user_id = ${adminId} AND updated_at BETWEEN '${req.params.start}' AND '${req.params.end}') AS t1 , 
            (SELECT COUNT(*) AS counts FROM tasks WHERE user_id = ${adminId} AND progress = 'todo' AND updated_at BETWEEN '${req.params.start}' AND '${req.params.end}') AS t2,
            (SELECT COUNT(*) AS counts FROM tasks WHERE user_id = ${adminId} AND progress = 'doing' AND updated_at BETWEEN '${req.params.start}' AND '${req.params.end}') AS t3,
            (SELECT COUNT(*) AS counts FROM tasks WHERE user_id = ${adminId} AND progress = 'done' AND updated_at BETWEEN '${req.params.start}' AND '${req.params.end}') AS t4`);
    result.second.total = second.total[0];
    second.resource = await getResultQuery(`SELECT IF(t1.counts IS NULL,0,t1.counts) AS todo,IF(t2.counts IS NULL,0,t2.counts) AS doing,IF(t3.counts IS NULL,0,t3.counts) AS done,IF(t4.counts IS NULL,0,t4.counts) AS total, t0.* FROM resources AS t0
            LEFT JOIN(SELECT COUNT(*) AS counts,t0.name, t0.ID FROM (SELECT COUNT(*) AS counts, t0.ID,t0.name,t3.progress FROM resources AS t0
                LEFT JOIN description_resources AS t1 ON t0.ID = t1.resource_id
                LEFT JOIN task_descriptions AS t2 ON t1.description_id = t2.id
                LEFT JOIN tasks AS t3 ON t2.task_id = t3.id AND t3.updated_at BETWEEN '${req.params.start}' AND '${req.params.end}'
                WHERE t3.progress = 'todo'
                GROUP BY t3.id,t0.ID,t3.progress) AS t0 GROUP BY t0.name) AS t1 ON t1.ID = t0.ID
            LEFT JOIN (SELECT COUNT(*) AS counts,t0.name, t0.ID FROM (SELECT COUNT(*) AS counts, t0.ID,t0.name,t3.progress FROM resources AS t0
                LEFT JOIN description_resources AS t1 ON t0.ID = t1.resource_id
                LEFT JOIN task_descriptions AS t2 ON t1.description_id = t2.id
                LEFT JOIN tasks AS t3 ON t2.task_id = t3.id AND t3.updated_at BETWEEN '${req.params.start}' AND '${req.params.end}'
                WHERE t3.progress = 'doing'
                GROUP BY t3.id,t0.ID,t3.progress) AS t0 GROUP BY t0.name) AS t2 ON t2.ID = t0.ID
            LEFT JOIN (SELECT COUNT(*) AS counts,t0.name, t0.ID FROM (SELECT COUNT(*) AS counts, t0.ID,t0.name,t3.progress FROM resources AS t0
                LEFT JOIN description_resources AS t1 ON t0.ID = t1.resource_id
                LEFT JOIN task_descriptions AS t2 ON t1.description_id = t2.id
                LEFT JOIN tasks AS t3 ON t2.task_id = t3.id AND t3.updated_at BETWEEN '${req.params.start}' AND '${req.params.end}'
                WHERE t3.progress = 'done'
                GROUP BY t3.id,t0.ID,t3.progress) AS t0 GROUP BY t0.name) AS t3 ON t3.ID = t0.ID
            LEFT JOIN (SELECT COUNT(*) AS counts,t0.name, t0.ID FROM (SELECT COUNT(*) AS counts, t0.ID,t0.name,t3.progress FROM resources AS t0
                LEFT JOIN description_resources AS t1 ON t0.ID = t1.resource_id
                LEFT JOIN task_descriptions AS t2 ON t1.description_id = t2.id
                LEFT JOIN tasks AS t3 ON t2.task_id = t3.id AND t3.updated_at BETWEEN '${req.params.start}' AND '${req.params.end}'
                WHERE t3.progress IS NOT NULL
                GROUP BY t3.id,t0.ID) AS t0 GROUP BY t0.name) AS t4 ON t4.ID = t0.ID
            WHERE t0.user_id = ${adminId}`);
    result.second.resource = second.resource;

    const third = {};
    third.dataByResource = await getResultQuery(`SELECT t0.name, IF(t1.counts IS NULL,0,t1.counts) AS serving,IF(t2.counts IS NULL,0,t2.counts) AS waitlist, IF(t3.counts IS NULL,0,t3.counts) AS booking FROM resources AS t0
            LEFT JOIN (SELECT COUNT(*) AS counts ,t1.resource_id FROM customers AS t0 
            INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id
            WHERE t1.serve_time IS NOT NULL AND t1.serve_time BETWEEN '${req.params.start}' AND '${req.params.end}' GROUP BY t1.resource_id) AS t1 ON t0.id = t1.resource_id
            LEFT JOIN (SELECT t1.resource_id,COUNT(*) AS counts FROM customers AS t0 
            INNER JOIN waitlists AS t1 ON t1.customer_id = t0.id
            WHERE t1.serve_time IS NULL AND t1.done_time IS NULL AND t1.wait_time BETWEEN '${req.params.start}' AND '${req.params.end}' GROUP BY t1.resource_id) AS t2 ON t2.resource_id = t0.id
            LEFT JOIN (SELECT COUNT(*) AS counts,t1.resource FROM customers AS t0 
                INNER JOIN bookings AS t1 ON t1.customer_id = t0.id WHERE t1.appointment_time BETWEEN '${req.params.start}' AND '${req.params.end}' GROUP BY t1.resource) AS t3 ON t0.id = t3.resource
            WHERE t0.user_id = ${adminId}`);
    result.third.dataByResource = third.dataByResource;
    third.dataByDate = await getResultQuery(`SELECT t0.dates,IF(t1.counts IS NULL,0,t1.counts) AS waitlist, IF(t2.counts IS NULL,0,t2.counts) AS serving,IF(t3.counts IS NULL,0,t3.counts) AS booking FROM 
            (SELECT  wait_time AS dates, user_id FROM waitlists WHERE user_id = ${adminId} AND wait_time IS NOT NULL AND serve_time IS NULL GROUP BY EXTRACT(DAY FROM wait_time)
                UNION
                SELECT  serve_time AS dates, user_id FROM waitlists WHERE user_id = ${adminId} AND serve_time IS NOT NULL AND done_time IS NULL GROUP BY EXTRACT(DAY FROM wait_time)
                UNION
                SELECT  appointment_time AS dates, user_id FROM bookings WHERE user_id = ${adminId} AND appointment_time IS NOT NULL GROUP BY EXTRACT(DAY FROM appointment_time)) AS t0
            LEFT JOIN (SELECT  COUNT(*) AS counts, wait_time FROM waitlists WHERE user_id = ${adminId} AND wait_time IS NOT NULL AND serve_time IS NULL GROUP BY EXTRACT(DAY FROM wait_time)) AS t1 ON t0.dates = t1.wait_time
            LEFT JOIN (SELECT  COUNT(*) AS counts, serve_time, user_id FROM waitlists WHERE user_id = ${adminId} AND serve_time IS NOT NULL AND done_time IS NULL GROUP BY EXTRACT(DAY FROM wait_time)) AS t2 ON t0.dates = t2.serve_time
            LEFT JOIN (SELECT  COUNT(*) AS counts, appointment_time, user_id FROM bookings WHERE user_id = ${adminId} AND appointment_time IS NOT NULL GROUP BY EXTRACT(DAY FROM appointment_time)) AS t3 ON t0.dates = t3.appointment_time 
            WHERE t0.dates BETWEEN '${req.params.start}' AND '${req.params.end}' ORDER BY t0.dates`);
    result.third.dataByDate = third.dataByDate;

    const fource = {};
    fource.customer = await getResultQuery(
      `SELECT * FROM customers WHERE user_id = ${adminId} AND created_at BETWEEN '${req.params.start}' AND '${req.params.end}' ORDER BY created_at DESC LIMIT 5`,
    );
    fource.user = await getResultQuery(
      `SELECT t1.* FROM users AS t0 LEFT JOIN users AS t1 ON t0.businessID = t1.businessID WHERE t0.id = ${adminId} AND t0.created_at BETWEEN '${req.params.start}' AND '${req.params.end}' ORDER BY t1.created_at DESC LIMIT 5`,
    );
    fource.task = await getResultQuery(
      `SELECT * FROM tasks WHERE user_id = ${adminId} AND created_at BETWEEN '${req.params.start}' AND '${req.params.end}' ORDER BY created_at DESC LIMIT 10`,
    );
    result.fource = fource;

    res.status(200).send({
      result,
      success: true,
    });
  },
};

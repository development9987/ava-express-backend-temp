const moment = require('moment');
const db = require('../db/models');
const settingsService = require('../services/settings/settings.service');

const { tasks, reports, task_descriptions, users, description_resources, resources } = db;
const { getResultQuery } = require('../core/util');

module.exports = {
  async getTasks(req, res) {
    const tmpId = await settingsService.getAdminId(req.params.user_id);
    const user = await users.findOne({
      where: {
        id: req.params.user_id,
      },
    });
    let tasksData;
    if (user.role == 'resource') {
      const resource = await resources.findOne({
        where: {
          name: user.username,
          email: user.email,
        },
      });
      tasksData = await getResultQuery(`SELECT t2.* FROM description_resources AS t0
            LEFT JOIN task_descriptions AS t1 ON t0.description_id = t1.id
            LEFT JOIN tasks AS t2 ON t1.task_id = t2.id
            WHERE t0.resource_id = '${resource.ID}'  AND t2.user_id = '${tmpId}' GROUP BY t2.id ORDER BY t2.created_at`);
    } else {
      tasksData = await tasks.findAll({
        where: {
          user_id: tmpId,
        },
        order: [['created_At', 'DESC']],
      });
    }
    const result = [];
    if (tasksData) {
      await Promise.all(
        tasksData.map(async (task) => {
          const taskResult = {};
          const descriptions = await task_descriptions.findAll({
            where: {
              task_id: task.id,
            },
            raw: true,
          });
          const tmpDescription = [];
          await Promise.all(
            descriptions.map(async (description) => {
              const tmp1 = await description_resources.findAll({
                where: {
                  description_id: description.id,
                },
                raw: true,
              });
              const tmpData = [];
              tmp1.forEach((element) => {
                tmpData.push(element.resource_id);
              });
              tmpDescription.push({ ...description, resources: tmpData });
            }),
          );
          taskResult.id = task.id;
          taskResult.user_id = task.user_id;
          taskResult.title = task.title;
          taskResult.task_period = JSON.parse(task.task_period);
          taskResult.created_at = task.created_at;
          taskResult.updated_at = task.updated_at;
          taskResult.progress = task.progress;
          taskResult.descriptions = tmpDescription;
          result.push(taskResult);
        }),
      );
    }
    res.status(200).send({
      success: true,
      message: 'Customer Create Successfully',
      result,
    });
  },

  async addTask(req, res) {
    const tmpId = await settingsService.getAdminId(req.body.user_id);
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    const { title, descriptions, user_id, task_period } = req.body;
    try {
      const newTask = await tasks.create({
        user_id: tmpId,
        title,
        task_period,
        progress: 'todo',
        created_at: dateTime,
        updated_at: dateTime,
      });
      const newDescriptions = [];
      await Promise.all(
        descriptions.map(async (description) => {
          let newDescription = await task_descriptions.create({
            task_id: newTask.id,
            title: description.title,
            created_at: dateTime,
            updated_at: dateTime,
            is_done: false,
          });
          newDescription = await task_descriptions.findOne({
            where: {
              id: newDescription.id,
            },
            raw: true,
          });
          await Promise.all(
            description.resources.map(async (resource) => {
              // console.log(resource);
              await description_resources.create({
                description_id: newDescription.id,
                resource_id: resource,
              });
            }),
          );
          newDescriptions.push({
            ...newDescription,
            resources: description.resources,
          });
        }),
      );
      const result = {};
      result.descriptions = newDescriptions;
      result.task_period = JSON.parse(newTask.task_period);
      result.user_id = newTask.user_id;
      result.id = newTask.id;
      result.title = newTask.title;
      result.progress = newTask.progress;
      result.created_at = newTask.created_at;
      result.updated_at = newTask.updated_at;
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async updateTask(req, res) {
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    const { title, descriptions, task_period, id } = req.body;

    try {
      if (title && task_period) {
        await tasks.update(
          {
            title,
            task_period,
            updated_at: dateTime,
          },
          {
            where: {
              id,
            },
          },
        );
      }
      const taskData = await tasks.findOne({
        where: {
          id,
        },
        raw: true,
      });
      const tmpDescription = [];
      await Promise.all(
        descriptions.map(async (description) => {
          if (description.id) {
            await task_descriptions.update(
              {
                title: description.title,
                updated_at: dateTime,
                is_done: description.is_done,
                // resources: JSON.stringify(element.resources)
              },
              {
                where: {
                  id: description.id,
                },
                raw: true,
              },
            );
            const updateDescription = await task_descriptions.findAll({
              where: {
                id: description.id,
              },
              raw: true,
            });
            await description_resources.destroy({
              where: {
                description_id: description.id,
              },
            });
            await Promise.all(
              description.resources.map(async (resource) => {
                await description_resources.create({
                  description_id: description.id,
                  resource_id: resource,
                });
              }),
            );
            tmpDescription.push({
              ...description,
              resources: description.resources,
            });
          } else {
            let createDescription = await task_descriptions.create({
              task_id: id,
              title: description.title,
              // resources: JSON.stringify(description.resources),
              created_at: dateTime,
              updated_at: dateTime,
              is_done: false,
            });
            createDescription = await task_descriptions.findOne({
              where: {
                id: createDescription.id,
              },
              raw: true,
            });
            await Promise.all(
              description.resources.map(async (resource) => {
                await description_resources.create({
                  description_id: createDescription.id,
                  resource_id: resource,
                });
              }),
            );
            tmpDescription.push({
              ...createDescription,
              resources: description.resources,
            });
          }
        }),
      );
      const result = { ...taskData };
      result.task_period = JSON.parse(taskData.task_period);
      result.descriptions = tmpDescription;
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async changeTaskProgress(req, res) {
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    try {
      await tasks.update(
        {
          progress: req.body.type,
        },
        {
          where: {
            id: req.body.id,
          },
        },
      );

      const taskData = await tasks.findOne({
        where: {
          id: req.body.id,
        },
        raw: true,
      });
      const updatedescriptions = await task_descriptions.findAll({
        where: {
          task_id: req.body.id,
        },
        raw: true,
      });
      const tmpDescription = [];
      await Promise.all(
        updatedescriptions.map(async (description) => {
          const tmpResources = [];
          const tmp1 = await description_resources.findAll({
            where: {
              description_id: description.id,
            },
            raw: true,
          });
          tmp1.forEach((resource) => {
            tmpResources.push(resource.resource_id);
          });
          tmpDescription.push({ ...description, resources: tmpResources });
        }),
      );
      const result = { ...taskData };
      result.task_period = JSON.parse(taskData.task_period);
      result.descriptions = tmpDescription;
      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },

  async deleteTask(req, res) {
    try {
      await tasks.destroy({
        where: {
          id: req.params.id,
        },
      });
      await task_descriptions.destroy({
        where: {
          task_id: req.params.id,
        },
      });
      res.status(200).send({
        success: true,
        result: req.params.id,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async deleteDescription(req, res) {
    try {
      const old_description = await task_descriptions.findOne({
        where: {
          id: req.params.id,
        },
      });
      const taskData = await tasks.findOne({
        where: {
          id: old_description.task_id,
        },
        raw: true,
      });
      await task_descriptions.destroy({
        where: {
          id: req.params.id,
        },
      });
      const updatedescriptions = await task_descriptions.findAll({
        where: {
          task_id: taskData.id,
        },
      });
      const tmpDescription = [];
      await Promise.all(
        updatedescriptions.map(async (description) => {
          const tmpResources = [];
          await description_resources
            .findAll({
              where: {
                description_id: description.id,
              },
            })
            .then((data) => {
              data.forEach((resource) => {
                tmpResources.push(resource.ID);
              });
            });
          tmpDescription.push({ ...description, resources: tmpResources });
        }),
      );
      const result = { ...taskData };
      result.task_period = JSON.parse(taskData.task_period);
      result.descriptions = tmpDescription;

      res.status(200).send({
        success: true,
        result,
      });
    } catch (e) {
      console.log(e);
    }
  },
  async getTaskReport(req, res) {
    const descriptionReportsData = await reports.findAll({
      where: {
        description_id: req.params.description_id,
      },
    });
    res.status(200).send({
      success: true,
      result: descriptionReportsData,
    });
  },
  async addReport(req, res) {
    let dateTime = new Date();
    dateTime = moment(dateTime).format('YYYY-MM-DD HH:mm:ss');
    const { description_id, reportText, resource_id } = req.body;
    const user = await users.findOne({
      where: {
        id: resource_id,
      },
    });
    const resource = await resources.findOne({
      where: {
        name: user.username,
        email: user.email,
      },
    });
    try {
      const newReport = await reports.create({
        resource_id: resource.ID,
        report: reportText,
        description_id,
        created_at: dateTime,
        updated_at: dateTime,
      });
      res.status(200).send({
        success: true,
        result: newReport,
      });
    } catch (e) {
      console.log(e);
    }
  },
};

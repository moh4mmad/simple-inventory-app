const models = require('../src/database/models');

console.log(
  `Migrating Database ${process.env.MIGRATION_ENV}...`,
);

models.sequelize
  .sync()
  .then(() => {
    console.log('OK');
    process.exit();
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

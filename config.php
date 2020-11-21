<?php

$config['db']['host'] = getenv('DB_HOST');
$config['db']['port'] = getenv('DB_PORT');
$config['db']['username'] = getenv('DB_USER');
$config['db']['password'] = getenv('DB_PASSWORD');
$config['db']['dbname'] = getenv('DB_NAME');

$config['fullUnicode'] = true;

$config['enableMail'] = false;
$config['debug'] = true;
$config['development']['enabled'] = true;
$config['development']['defaultAddOn'] = 'Acme/My-Addon';

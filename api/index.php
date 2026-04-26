<?php
/**
 * Vercel entry point for Adminer.
 *
 * Sets the working directory to adminer/ so that all relative
 * include paths inside adminer/index.php resolve correctly, then
 * delegates to adminer's own router.
 */
chdir(__DIR__ . '/../adminer');
include './index.php';

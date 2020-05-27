<?php

/**
 * @file plugins/themes/healthSciencesPIEPIE/PIEThemePlugin.inc.php
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class PIEThemePlugin
 * @ingroup plugins_themes_healthSciencesPIE
 *
 * @brief Health Sciences theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');
class PIEThemePlugin extends ThemePlugin {

	/**
	 * Load the custom styles for our theme
	 * @return null
	 */
	public function init() {

    // Initialize the parent theme
		$this->setParent('healthsciencesthemeplugin');

    // Option to show journal summary on the homepage; turned off by default
    $this->addOption('journalDescription', 'radio', array(
			'label' => 'plugins.themes.healthSciencesPIE.options.journalDescription.label',
			'description' => 'plugins.themes.healthSciencesPIE.options.journalDescription.description',
			'options' => array(
				0 => 'plugins.themes.healthSciencesPIE.options.journalDescription.disable',
				1 => 'plugins.themes.healthSciencesPIE.options.journalDescription.enable'
			)
		));

		// Load dependencies from CDN
		if (Config::getVar('general', 'enable_cdn')) {
			$this->addStyle(
				'fonts',
				'https://fonts.googleapis.com/css2?family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&display=swap',
				array('baseUrl' => '')
			);
			$this->addStyle(
				'bootstrap',
				'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css',
				array('baseUrl' => '')
			);
			$this->addStyle(
				'fontawesome',
				'https://use.fontawesome.com/releases/v5.6.1/css/all.css',
				array('baseUrl' => '')
			);
			$this->addScript(
				'jquery',
				'https://code.jquery.com/jquery-3.3.1.min.js',
				array('baseUrl' => '')
			);
			$this->addScript(
				'popper',
				'https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js',
				array('baseUrl' => '')
			);
			$this->addScript(
				'bootstrap',
				'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js',
				array('baseUrl' => '')
			);

		// Load local copies of dependencies if CDNs are not allowed
		} else {
			$this->addStyle('bootstrap', 'libs/bootstrap.min.css');
			$this->addScript('jquery', 'libs/jquery-3.3.1.min.js');
			$this->addScript('popper', 'libs/popper.min.js');
			$this->addScript('bootstrap', 'libs/bootstrap.min.js');
		}

		// Load theme stylesheet and script
		$this->addStyle('stylesheet', 'styles/index.less');
		$this->addScript('main', 'js/main.js');

		// Styles for HTML galleys
		$this->addStyle('htmlGalley', 'templates/plugins/generic/htmlArticleGalley/css/default.css', array('contexts' => 'htmlGalley'));
    $this->addStyle('htmlFont', 'https://fonts.googleapis.com/css?family=PT+Serif&display=swap', array('baseUrl' => '', 'contexts' => 'htmlGalley'));

		// Styles for right to left scripts
		$locale = AppLocale::getLocale();
		$localeDirection = AppLocale::getLocaleDirection($locale);
		if ($localeDirection === "rtl") {
			$this->addStyle('rtl', 'styles/rtl.less');
		}

		// Add JQuery UI and tag-it libraries for registration page (reviewer's interests)
		$this->addScript("jquery-ui", "libs/jquery-ui.min.js");
		$this->addScript("tag-it", "libs/tag-it.min.js");

		// Add navigation menu areas for this theme
		$this->addMenuArea(array('primary', 'user'));

		// Get extra data for templates
		HookRegistry::register ('TemplateManager::display', array($this, 'loadTemplateData'));
		HookRegistry::register ('TemplateManager::display', array($this, 'homepageJournalDescription'));
	}

	/**
	 * Get the display name of this theme
	 * @return string
	 */
	public function getDisplayName() {
			return __('plugins.themes.healthSciencesPIE.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	public function getDescription() {
			return __('plugins.themes.healthSciencesPIE.description');
	}

	/**
	 * Load custom data for templates
	 *
	 * @param string $hookName
	 * @param array $args [
	 *		@option TemplateManager
	 *		@option string Template file requested
	 *		@option string
	 *		@option string
	 *		@option string output HTML
	 * ]
	 */
	public function loadTemplateData($hookName, $args) {
		$templateMgr = $args[0];
		$request = Application::get()->getRequest();
		$context = $request->getContext();

		if (!defined('SESSION_DISABLE_INIT')) {

			// Get possible locales
			if ($context) {
				$locales = $context->getSupportedLocaleNames();
			} else {
				$locales = $request->getSite()->getSupportedLocaleNames();
			}

			// Load login form
			$loginUrl = $request->url(null, 'login', 'signIn');
			if (Config::getVar('security', 'force_login_ssl')) {
				$loginUrl = PKPString::regexp_replace('/^http:/', 'https:', $loginUrl);
			}

			$orcidImage = $this->getPluginPath() . '/templates/images/orcid.png';

			$templateMgr->assign(array(
				'languageToggleLocales' => $locales,
				'loginUrl' => $loginUrl,
				'brandImage' => 'templates/images/ojs_brand_white.png',
				'orcidImage' => $orcidImage,
			));
		}
	}

  /**
	 * @param $hookname string
	 * @param $args array [
	 *      @option TemplateManager
	 *      @option string relative path to the template
	 * ]
	 * @return boolean|void
	 * @brief Show Journal Description on the journal landing page depending on theme settings
	 */
	public function homepageJournalDescription($hookName, $args) {
		$templateMgr = $args[0];
		$template = $args[1];

		if ($template != "frontend/pages/indexJournal.tpl") return false;

		$templateMgr->assign(array(
			'showJournalDescription' => $this->getOption('journalDescription'),
		));
	}
}

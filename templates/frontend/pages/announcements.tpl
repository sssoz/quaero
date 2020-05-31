{**
 * templates/frontend/pages/announcements.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view a journal's or press's description, contact
 *  details, policies and more.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{include file="frontend/components/header.tpl" pageTitle="announcement.announcements"}

<main class="container">
  <div class="row justify-content-center">

    <section class="col col-lg-9 page">
      <header class="page-header">
        <h1>{translate key="announcement.announcements"}</h1>
        <p>{$announcementsIntroduction|strip_unsafe_html}</p>
        <p>
          {include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="announcements" sectionTitleKey="announcement.announcements"}
        </p>
      </header>

      <div class="page-content">
        {foreach from=$announcements item=announcement}
          {include file="frontend/objects/announcement_summary.tpl"}
        {/foreach}
      </div>
    </section>
	</div>
</main>

{include file="frontend/components/footer.tpl"}

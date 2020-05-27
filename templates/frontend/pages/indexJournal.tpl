{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

{if $homepageImage}
	<div class="homepage-image{if $issue} homepage-image-behind-issue{/if}">
		<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
	</div>
{/if}

<main class="container">

  <div class="row justify-content-center">

    {if $showJournalDescription && $currentJournal->getLocalizedDescription()}
    <section class="col-11 col-lg-9 page-issue">
      <div class="container">
        <header class="row">
          <h2 class="col-md-6">
            {translate key="navigation.about"}
          </h2>
        </header>
        {$currentJournal->getLocalizedDescription()}
        <p>
          {capture assign="aboutPageUrl"}{url router=$smarty.const.ROUTE_PAGE page="about"}{/capture}
          <a href="{$aboutPageUrl}" class="btn">{translate key="common.readMore"}</a>
        </p>
      </div>
    </section>
    {/if}

    <div class="col-11 col-lg-9 page-issue">
      <header class="page-header page-issue-header">
        {if $issue}
          <p>{translate key="journal.currentIssue"}</p>

          <h2>
            {$issue->getIssueSeries()|escape}
          </h2>

          <time datetime="{$issue->getDatePublished()}">
            {translate key="plugins.themes.healthSciencesPIE.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
          </time>

          {* make the entire block conditional if there aren't any additional issue data *}
          {if  $issue->getLocalizedCoverImageUrl() || $issue->hasDescription() || $issueGalleys}
            <div class="row justify-content-center homepage-issue-header">
              {if $issue->getLocalizedCoverImageUrl()}
                <div class="col-lg-3">
                  <a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
                    <img class="img-fluid homepage-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
                  </a>
                </div>
              {/if}
              {if $issue->hasDescription() || $journalDescription || $issueGalleys}
                <div class="col-lg-9">
                  <div class="homepage-issue-description-wrapper">
                    {if $issue->hasDescription()}
                      <div class="homepage-issue-description">
                        <div class="h2">
                          {if $issue->getLocalizedTitle()}
                            {$issue->getLocalizedTitle()|escape}
                          {else}
                            {translate key="plugins.themes.healthSciencesPIE.issueDescription"}
                          {/if}
                        </div>
                        {$issue->getLocalizedDescription()|strip_unsafe_html}
                        <div class="homepage-issue-description-more">
                          <a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="common.more"}</a>
                        </div>
                      </div>
                    {elseif $journalDescription}
                      <div class="homepage-journal-description long-text" id="homepageDescription">
                        {$journalDescription|strip_unsafe_html}
                      </div>
                      <div class="homepage-description-buttons hidden" id="homepageDescriptionButtons">
                        <a class="homepage-journal-description-more hidden" id="homepageDescriptionMore">{translate key="common.more"}</a>
                        <a class="homepage-journal-description-less hidden" id="homepageDescriptionLess">{translate key="common.less"}</a>
                      </div>
                    {/if}
                    {if $issueGalleys}
                      <div class="homepage-issue-galleys">
                        <div class="h3">
                          {translate key="issue.fullIssue"}
                        </div>
                        {foreach from=$issueGalleys item=galley}
                          {include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
                        {/foreach}
                      </div>
                    {/if}
                  </div>
                </div>
              {/if}
            </div>
          {/if}
        {/if}
      </header>

      {* display announcements before full issue *}
      {if $numAnnouncementsHomepage && $announcements|@count}
      <section class="row homepage-announcements">
        <h2 class="sr-only">{translate key="announcement.announcementsHome"}</h2>
        {foreach from=$announcements item=announcement}
          <article class="col-md-4 homepage-announcement">
            <h3 class="homepage-announcement-title">{$announcement->getLocalizedTitle()|escape}</h3>
            <p>{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
              <br>
              <a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
                {capture name="more" assign="more"}{translate key="common.more"}{/capture}
                {translate key="plugins.themes.healthSciencesPIE.more" text=$more}
              </a>
            </p>
            <footer>
              <small class="homepage-announcement-date">{$announcement->getDatePosted()|date_format:$dateFormatLong}</small>
            </footer>
          </article>
        {/foreach}
      </section>
      {/if}

      {if $issue}
        {include file="frontend/objects/issue_toc.tpl" sectionHeading="h3"}
      {/if}
    </div>
  </div><!-- .row -->

  <p class="text-center">
    <a class="btn" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
      {translate key="journal.viewAllIssues"}
    </a>
  </p>

  {* Additional Homepage Content *}
  {if $additionalHomeContent}
    <div class="col-12 col-lg-9">{$additionalHomeContent}</div>
  {/if}
</main>

{include file="frontend/components/footer.tpl"}

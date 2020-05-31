{**
 * templates/frontend/objects/article_details.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Article which displays all details about the article.
 *  Expected to be primary object on the page.
 *
 * Core components are produced manually below. Additional components can added
 * via plugins using the hooks provided:
 *
 * Templates::Article::Main
 * Templates::Article::Details
 *
 * @uses $article Article This article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 * @uses $primaryGalleys array List of article galleys that are not supplementary or dependent
 * @uses $supplementaryGalleys array List of article galleys that are supplementary
 * @uses $keywords array List of keywords assigned to this article
 * @uses $pubIdPlugins Array of pubId plugins which this article may be assigned
 * @uses $copyright string Copyright notice. Only assigned if statement should
 *   be included with published articles.
 * @uses $copyrightHolder string Name of copyright holder
 * @uses $copyrightYear string Year of copyright
 * @uses $licenseUrl string URL to license. Only assigned if license should be
 *   included with published articles.
 * @uses $ccLicenseBadge string An image and text with details about the license
 *}

<header class="page-header page-header-centered justify-content-md-center">
  {* Title and issue details *}
  {if $section}
    <p class="article-details-meta article-details-meta-upper">{$section->getLocalizedTitle()|escape}</p>
  {/if}
  <h1>{$publication->getLocalizedFullTitle()|escape}</h1>
  <p class="article-details-meta">
    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{$issue->getIssueSeries()|escape}</a>
  </p>

  {* Notification that this is an old version *}
  {if $currentPublication->getId() !== $publication->getId()}
  <p class="alert alert-primary" role="alert">
    {capture assign="latestVersionUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}
    {translate key="submission.outdatedVersion"
      datePublished=$publication->getData('datePublished')|date_format:$dateFormatShort
      urlRecentVersion=$latestVersionUrl|escape
    }
  </p>
  {/if}

  {* DOI *}
  {foreach from=$pubIdPlugins item=pubIdPlugin}
    {if $pubIdPlugin->getPubIdType() != 'doi'}
      {continue}
    {/if}
    {assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
    {if $pubId}
      {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
      <p class="article-details-meta">
        <a href="{$doiUrl}">{$doiUrl}</a>
      <p class="article-details-meta">
    {/if}
  {/foreach}

  {* Date published & updated *}
  {if $publication->getData('datePublished')}
    <p class="article-details-meta">
      {translate key="submissions.published"}
      {* If this is the original version *}
      {if $firstPublication->getID() === $publication->getId()}
        {$firstPublication->getData('datePublished')|date_format:$dateFormatShort}
      {* If this is an updated version *}
      {else}
        {translate key="submission.updatedOn" datePublished=$firstPublication->getData('datePublished')|date_format:$dateFormatShort dateUpdated=$publication->getData('datePublished')|date_format:$dateFormatShort}
      {/if}
    </p>
  {/if}

  {if $publication->getData('authors')}
    <ul class="unstyled-list-inline article-details-meta">
      {foreach from=$publication->getData('authors') item=authorString key=authorStringKey}
        {strip}
          <li>
            {if $authorString->getLocalizedBiography()}
            <a href="#" data-toggle="modal" data-target="#authorBiographyModal{$authorKey+1}">
              {$authorString->getFullName()|escape}
              <sup>&plus;</sup>
            </a>
            {else}
            <strong>{$authorString->getFullName()|escape}</strong>
            {/if}
            {if $authorString->getOrcid()}
              <a class="orcidImage" href="{$authorString->getOrcid()|escape}">
                <img src="{$baseUrl}/{$orcidImage}">
                {$author->getOrcid()|escape}
              </a>
            {/if}
            {if $authorString->getLocalizedAffiliation()}
              &nbsp;({$authorString->getLocalizedAffiliation()|escape})
            {/if}
          </li>
        {/strip}
      {/foreach}
    </ul>

  {/if}
</header>

<div class="page-content justify-content-md-center">

  {* Abstract *}
  <section>
    <h2>{translate key="article.abstract"}</h2>
    {if $publication->getLocalizedData('abstract')}
      {$publication->getLocalizedData('abstract')|strip_unsafe_html}
    {else}
      <p><em>{translate key="plugins.themes.healthSciencesPIE.article.noAbstracts"}</em></p>
    {/if}
  </section>

  {* Galley buttons *}
  {if $primaryGalleys}
    <section>
      <h2 class="sr-only">{translate key="plugins.importexport.common.export.representations"}</h2>
      <p>
        {foreach from=$primaryGalleys item=galley}
          {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley purchaseFee=$currentJournal->getSetting('purchaseArticleFee') purchaseCurrency=$currentJournal->getSetting('currency')}
        {/foreach}
      </p>
    </section>
  {/if}

  {* References *}
  {if $parsedCitations || $publication->getData('citationsRaw')}
    <section>
      <h2>
        {translate key="submission.citations"}
      </h2>
      <ol>
        {if $parsedCitations}
          {foreach from=$parsedCitations item=parsedCitation}
            <li>{$parsedCitation->getCitationWithLinks()|strip_unsafe_html}</li>
          {/foreach}
        {else}
          {$publication->getData('citationsRaw')|escape|nl2br}
        {/if}
      </ol>
    </section>
  {/if}

  {* Licensing info *}
  {if $copyright || $licenseUrl}
    <section>
      {if $licenseUrl}
        {if $ccLicenseBadge}
          {$ccLicenseBadge}
            {if $copyrightHolder}
              <p>{translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder copyrightYear=$copyrightYear}</p>
            {/if}
        {else}
          <a href="{$licenseUrl|escape}" class="copyright" rel="noopener">
            {if $copyrightHolder}
              {translate key="submission.copyrightStatement" copyrightHolder=$copyrightHolder|escape copyrightYear=$copyrightYear|escape}
            {else}
              {translate key="submission.license"}
            {/if}
          </a>
        {/if}
      {else}
        {$copyright}
      {/if}
    </section>
  {/if}

  {call_hook name="Templates::Article::Main"}

  <aside>

    {* Display other versions *}
    {if $publication->getData('datePublished')}
      {if count($article->getPublishedPublications()) > 1}
        <section class="article-details-block">
          <h2>
            {translate key="submission.versions"}
          </h2>
          <ul>
          {foreach from=array_reverse($article->getPublishedPublications()) item=iPublication}
            {capture assign="name"}{translate key="submission.versionIdentity" datePublished=$iPublication->getData('datePublished')|date_format:$dateFormatShort version=$iPublication->getData('version')}{/capture}
            <li>
              {if $iPublication->getId() === $publication->getId()}
                {$name}
              {elseif $iPublication->getId() === $currentPublication->getId()}
                <a href="{url page="article" op="view" path=$article->getBestId()}">{$name}</a>
              {else}
                <a href="{url page="article" op="view" path=$article->getBestId()|to_array:"version":$iPublication->getId()}">{$name}</a>
              {/if}
            </li>
          {/foreach}
          </ul>
        </section>
      {/if}
    {/if}

    {* Supplementary galleys *}
    {if $supplementaryGalleys}
      <section>
        <h2>{translate key="plugins.themes.healthSciencesPIE.article.supplementaryFiles"}</h2>
        {foreach from=$supplementaryGalleys item=galley}
          <div class="article-details-galley">
            {include file="frontend/objects/galley_link.tpl" parent=$article galley=$galley isSupplementary="1"}
          </div>
        {/foreach}
      </section>
    {/if}

    {* Keywords *}
    {if !empty($keywords[$currentLocale])}
      <section>
        <h2>
          {translate key="article.subject"}
        </h2>
        <ul class="unstyled-list-inline">
          {foreach from=$keywords item=keyword}
            {foreach name=keywords from=$keyword item=keywordItem}
              <li>{$keywordItem|escape}{if !$smarty.foreach.keywords.last},{/if}</li>
            {/foreach}
          {/foreach}
        </ul>
      </section>
    {/if}

    {* How to cite *}
    {if $citation}
      <section>
        <h2>
          {translate key="submission.howToCite"}
        </h2>
        <p id="citationOutput" class="article-details-how-to-cite-citation" role="region" aria-live="polite">
          {$citation}
        </p>
        <div class="dropdown">
          <button class="btn dropdown-toggle" type="button" id="cslCitationFormatsButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-csl-dropdown="true">
            {translate key="submission.howToCite.citationFormats"}
          </button>
          <div class="dropdown-menu" aria-labelledby="cslCitationFormatsButton">
            {foreach from=$citationStyles item="citationStyle"}
              <a
                class="dropdown-item"
                aria-controls="citationOutput"
                href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
                data-load-citation
                data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
              >
                {$citationStyle.title|escape}
              </a>
            {/foreach}
            {if count($citationDownloads)}
              <h3 class="dropdown-header">
                {translate key="submission.howToCite.downloadCitation"}
              </h3>
              {foreach from=$citationDownloads item="citationDownload"}
                <a class="dropdown-item" href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
                  {$citationDownload.title|escape}
                </a>
              {/foreach}
            {/if}
          </div>
        </div>
      </section>
    {/if}

    {* Authors’ biographies *}
    {assign var="authorCount" value=$publication->getData('authors')|@count}
    {assign var="authorBioIndex" value=0}
    <section>
      <h2 class="sr-only">{translate key="plugins.themes.healthSciencesPIE.article.authorBio"}</h2>
      {foreach from=$publication->getData('authors') item=author key=authorKey}
        {if $author->getLocalizedBiography()}
        <section
            class="modal fade"
            id="authorBiographyModal{$authorKey+1}"
            tabindex="0"
            role="dialog"
            aria-labelledby="authorBiographyModalTitle{$authorKey+1}"
            aria-hidden="true"
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <header>
                <h3 id="authorBiographyModalTitle{$authorKey+1}">
                  {$author->getFullName()|escape}
                </h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="{translate|escape key="common.close"}">
                  <span aria-hidden="true">&times;</span>
                </button>
              </header>
              {if $authorString->getLocalizedAffiliation()}
                <p>{$authorString->getLocalizedAffiliation()|escape}</p>
                <hr/>
              {/if}
              {$author->getLocalizedBiography()|strip_unsafe_html}
            </div>
          </div>
        </section>
        {/if}
      {/foreach}
    </section>

    {* PubIds (other than DOI; requires plugins) *}
    {foreach from=$pubIdPlugins item=pubIdPlugin}
      {if $pubIdPlugin->getPubIdType() == 'doi'}
        {continue}
      {/if}
      {assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
      {if $pubId}
        <section>
          <h2>
            {$pubIdPlugin->getPubIdDisplayType()|escape}
          </h2>
          <div class="article-details-pubid-value">
            {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
              <a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">
                {$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
              </a>
            {else}
              {$pubId|escape}
            {/if}
          </div>
        </section>
      {/if}
    {/foreach}

    {call_hook name="Templates::Article::Details"}
  </aside>

  <div class="article-footer-hook">
    {call_hook name="Templates::Article::Footer::PageFooter"}
  </div>
</div>

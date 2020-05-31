{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-12 col-lg-9 page">
      <header class="page-header justify-content-md-center">
    		<h1>{translate key="common.search"}</h1>
    	</header>

      <div class="page-content justify-content-md-center">
        <section>
          <h2>{translate key="plugins.themes.healthSciencesPIE.search.params"}</h2>

          {capture name="searchFormUrl"}{url op="search" escape=false}{/capture}
          {$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|parse_str:$formUrlParameters}
          <form class="form-search" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}">
            {foreach from=$formUrlParameters key=paramKey item=paramValue}
              <input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
            {/foreach}

            <div class="row">
              <p class="col-6">
                <label for="query">
                  {translate key="common.searchQuery"}
                </label>
                <input type="text" id="query" name="query" value="{$query|escape}">
              </p>

              <p class="col-6">
                <label for="authors">
                  {translate key="search.author"}
                </label>
                <input type="text" id="authors" name="authors" value="{$authors|escape}">
              </p>
            </div>

            <p class="ymd-selects">
              <label for="dateFromYear">
                {translate key="search.dateFrom"}
              </label>
              {html_select_date prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
            </p>
            <p class="ymd-selects">
              <label for="dateToYear">
                {translate key="search.dateTo"}
              </label>
              {html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
            </p>
            <button class="btn btn-primary" type="submit">{translate key="common.search"}</button>
          </form>
        </section>

        <hr/>

        <section>
          <h2>
            {if $query}
              {translate key="plugins.themes.healthSciencesPIE.search.resultsFor" query=$query|escape}
            {elseif $authors}
              {translate key="plugins.themes.healthSciencesPIE.search.resultsFor" query=$authors|escape}
            {/if}
          </h2>
          {* No results found *}
          {if $results->wasEmpty()}
            {if $error}
              <div class="alert alert-danger" role="alert">{$error|escape}</div>
            {else}
              <div class="alert alert-primary" role="alert">{translate key="search.noResults"}</div>
            {/if}

          {* Results pagination *}
          {else}
          <ul class="unstyled-list issue-toc">
            {iterate from=results item=result}
              <li>
              {include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true}
              </li>
            {/iterate}
          </ul>
            {page_info iterator=$results}
            {page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
          {/if}
        </section>
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}

{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $submissionChecklist array List of requirements for submissions
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-lg-9 page">
      <header class="page-header justify-content-md-center">
        <h1>{translate key="about.submissions"}</h1>

        {* Login/register prompt *}
        {if $isUserLoggedIn}
          {capture assign="newSubmission"}<a href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
          {capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
          <p class="alert alert-primary">
            {translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
          </p>
        {else}
          {capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
          {capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
          <p class="alert alert-primary">
            {translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
          </p>
        {/if}

    	</header>

      <div class="page-content justify-content-md-center">

        {if $submissionChecklist}
          <section>
            <h2>
              {translate key="about.submissionPreparationChecklist"}
            </h2>
            {translate key="about.submissionPreparationChecklist.description"}
            <ul>
              {foreach from=$submissionChecklist item=checklistItem}
                <li>
                  {$checklistItem.content}
                </li>
              {/foreach}
            </ul>
            <p>{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.submissionPreparationChecklist"}</p>
          </section>
        {/if}

        {if $currentContext->getLocalizedSetting('authorGuidelines')}
          <section>
            <h2>
              {translate key="about.authorGuidelines"}
            </h2>
            {$currentContext->getLocalizedSetting('authorGuidelines')}
            <p>{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.authorGuidelines"}</p>
          </section>
        {/if}

        {if $currentContext->getLocalizedSetting('copyrightNotice')}
          <section>
            <h2>
              {translate key="about.copyrightNotice"}
            </h2>
            {$currentContext->getLocalizedSetting('copyrightNotice')}
            <p>{include file="frontend/components/editLink.tpl" page="management" op="settings" path="distribution" anchor="permissions" sectionTitleKey="about.copyrightNotice"}</p>
          </section>
        {/if}

        {if $currentContext->getLocalizedSetting('privacyStatement')}
          <section>
            <h2>
              {translate key="about.privacyStatement"}
            </h2>
            {$currentContext->getLocalizedSetting('privacyStatement')}
            <p>{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.privacyStatement"}</p>
          </section>
        {/if}
      </div>
    </div>
  </div>
</main>


{include file="frontend/components/footer.tpl"}

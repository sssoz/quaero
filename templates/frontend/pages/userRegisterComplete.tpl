{**
 * templates/frontend/pages/userRegisterComplete.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief A landing page displayed to users upon successful registration
 *}
{include file="frontend/components/header.tpl"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-md-6 page">
      <header class="page-header justify-content-md-center">
    		<h1>{translate key=$pageTitle}</h1>
        <p>
          {translate key="user.login.registrationComplete.instructions"}
        </p>
    	</header>

      <div class="page-content justify-content-md-center">
        <ul class="registration-complete-actions">
          {if array_intersect(array(ROLE_ID_MANAGER, ROLE_ID_SUB_EDITOR, ROLE_ID_ASSISTANT, ROLE_ID_REVIEWER), (array)$userRoles)}
            <li>
              <a href="{url page="submissions"}">
                {translate key="user.login.registrationComplete.manageSubmissions"}
              </a>
            </li>
          {/if}
          {if $currentContext}
            <li>
              <a href="{url page="submission" op="wizard"}">
                {translate key="user.login.registrationComplete.newSubmission"}
              </a>
            </li>
          {/if}
          <li>
            <a href="{url router=$smarty.const.ROUTE_PAGE page="user" op="profile"}">
              {translate key="user.editMyProfile"}
            </a>
          </li>
          <li >
            <a href="{url page="index"}">
              {translate key="user.login.registrationComplete.continueBrowsing"}
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</main>


{include file="frontend/components/footer.tpl"}

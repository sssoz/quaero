{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 * @uses $primaryLocale string The primary locale for this journal/press
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-lg-9 page">
      <header class="page-header justify-content-md-center">
    			<h1>{translate key="user.register"}</h1>
    	</header>

      <div class="page-content justify-content-md-center">
        <form class="form-register" id="register" method="post" action="{url op="register"}">
          {csrf}
          <input type="hidden" name="source" value="{$source|escape}" />

          {include file="common/formErrors.tpl"}

          {include file="frontend/components/registrationForm.tpl"}

          {include file="frontend/components/registrationFormContexts.tpl"}

          {* recaptcha spam blocker *}
          {if $reCaptchaHtml}
            <div class="form-group">
              {$reCaptchaHtml}
            </div>
          {/if}

          <button class="btn btn-primary" type="submit">
            {translate key="user.register"}
          </button>
          <p>
            {translate key="plugins.themes.healthSciencesPIE.register.haveAccount"}
            {capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
            <a href="{url page="login" source=$rolesProfileUrl}" class="login">
              {translate key="plugins.themes.healthSciencesPIE.register.loginHere"}
            </a>
          </p>
        </form>
    	</div>

    </div>

  </div>

</main>

{include file="frontend/components/footer.tpl"}

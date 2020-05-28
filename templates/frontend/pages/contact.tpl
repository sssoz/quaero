{**
 * templates/frontend/pages/contact.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the press's contact details.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $mailingAddress string Mailing address for the journal/press
 * @uses $contactName string Primary contact name
 * @uses $contactTitle string Primary contact title
 * @uses $contactAffiliation string Primary contact affiliation
 * @uses $contactPhone string Primary contact phone number
 * @uses $contactEmail string Primary contact email address
 * @uses $supportName string Support contact name
 * @uses $supportPhone string Support contact phone number
 * @uses $supportEmail string Support contact email address
 *}
{include file="frontend/components/header.tpl" pageTitle="about.contact"}
<main class="container">

  <div class="row justify-content-center">

    <div class="col-11 col-lg-9 page">
      <header class="page-header justify-content-md-center">
    		<h1>
          {translate key="about.contact"}
        </h1>
    	</header>

      <div class="page-content justify-content-md-center">
        {* Contact section *}
        {if $mailingAddress}
          <address class="address">
            {$mailingAddress|nl2br|strip_unsafe_html}
          </address>
        {/if}

        {* Primary contact *}
        {if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}
          <address>
            <h2>
              {translate key="about.contact.principalContact"}
            </h2>

            {if $contactName}{$contactName|escape}<br/>{/if}

            {if $contactTitle}{$contactTitle|escape}<br/>{/if}

            {if $contactAffiliation}{$contactAffiliation|strip_unsafe_html}<br/>{/if}

            {if $contactPhone}
            {translate key="about.contact.phone"}
            {$contactPhone|escape}<br/>
            {/if}

            {if $contactEmail}
            <a href="mailto:{$contactEmail|escape}">
              {$contactEmail|escape}
            </a><br/>
            {/if}
          </address>
        {/if}

        {* Technical contact *}
        {if $supportName || $supportPhone || $supportEmail}
          <address>
            <h2>
              {translate key="about.contact.supportContact"}
            </h2>

            {if $supportName}{$supportName|escape}<br/>{/if}

            {if $supportPhone}
            {translate key="about.contact.phone"}
            {$supportPhone|escape}<br/>
            {/if}

            {if $supportEmail}
            <a href="mailto:{$supportEmail|escape}">
              {$supportEmail|escape}
            </a><br/>
            {/if}
          </address>
        {/if}

        <p>
          {include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="contact" sectionTitleKey="about.contact"}
        </p>
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}

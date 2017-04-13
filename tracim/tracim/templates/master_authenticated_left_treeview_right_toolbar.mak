<%inherit file="local:templates.master_authenticated"/>
<%namespace name="TIM" file="tracim.templates.pod"/>

<%def name="TITLE_ROW()"></%def>
<%def name="SIDEBAR_LEFT_CONTENT()"></%def>
<%def name="SIDEBAR_RIGHT_CONTENT()"></%def>
<%def name="REQUIRED_DIALOGS()"></%def>
<%def name="FOOTER_CONTENT_LIKE_SCRIPTS_AND_CSS()"></%def>

<%def name="content_wrapper()">
    ## SIDEBAR LEFT
    <div id="sidebar-left" class="sidebar bg-primary">
        <div class="btn-group" style="position: absolute; right: 2px; top: 4px; ">
            <button id="toggle-left-sidebar-width" type="button" class="btn btn-link"><i class="fa fa-angle-double-right"></i></button>
        </div>
        ${self.SIDEBAR_LEFT_CONTENT()}
    </div>
    ## SIDEBAR LEFT [END]

    ## SIDEBAR RIGHT
    <div id="sidebar-right" class="sidebar bg-secondary">
        ${self.SIDEBAR_RIGHT_CONTENT()}
    </div> <!-- # End of side bar right -->
    ## SIDEBAR RIGHT [END]

    <div class="content__wrapper edit-mode-margin">
        ${self.TITLE_ROW()}
        ${self.body()}
    </div>
    ${self.REQUIRED_DIALOGS()}

    ###########################################
    ##
    ## GENERIC STUFF LIKE SCRIPTS
    ##
    ###########################################
    <script src="${tg.url('/assets/js/jquery.min.js')}"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${tg.url('/assets/js/ie10-viewport-bug-workaround.js')}"></script>
    <!-- TinyMCE ================================================== -->
    <script src="${tg.url('/assets/tinymce/js/tinymce/tinymce.min.js')}"></script>
    ${TIM.TINYMCE_INIT_SCRIPT('.pod-rich-textarea')}

##     <link rel="stylesheet" href="${tg.url('/assets/tablesorter/themes/tracim/style.css')}"/>
##    <script src="${tg.url('/assets/tablesorter/jquery.tablesorter.min.js')}"></script>


    <link rel="stylesheet" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css"/>
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
</%def>


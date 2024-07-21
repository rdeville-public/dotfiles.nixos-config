{
  lib,
  config,
  ...
}: {
  programs = {
    mr = {
      enable = true;
    };
  };

  xdg = {
    configFile = {
      mr = {
        source = ./lib;
      };
    };
  };

  home = {
    file = {
      ".mrconfig" = lib.mkForce {
        text = ''
          [DEFAULT]
          lib =
            export MR_LOG_FILE="''${HOME}/.cache/mr/myrepos.$(date +%Y-%m-%d-%H-%M).log"
            # Load method library
            DEBUG_LEVEL="''${DIRENV_DEBUG_LEVEL:-"INFO"}"
            for file in "''${HOME}/${config.xdg.configFile.mr.target}"/*
            do
              source "''${file}"
            done
            _log "INFO" "Log will be stored in **''${MR_LOG_FILE}**"
            {
              echo "" ;
              echo "Processing ''${MR_REPO}" ;
              echo "==========================================================";
            } &>>''${MR_LOG_FILE}

          pull          = mr_update "$@"
          update        =
            echo "Processing ''${MR_REPO}" &>>''${MR_LOG_FILE}
            mr_update "$@"
          push          =
            echo "Processing ''${MR_REPO}" &>>''${MR_LOG_FILE}
            mr_push "$@"
          status        = mr_status "$@"
          addmirror     =
            echo "Processing ''${MR_REPO}" &>>''${MR_LOG_FILE}
            mr_add_mirror "$@"
          publish       = mr_publish "$@"
          remote        = git remote "$@"
          branch        = git branch "$@"
          glab          = glab "$@"
          git           = git "$@"

          # Teach mr how to `mr gc` in git repos.
          git_gc = git gc "$@"

          include =
            cat "''${XDG_DATA_DIR:-''${HOME}/.local/share}/mr/hosts/''${HOST}/''${USER}.git"

          # vim: ft=conf
        '';
      };
    };
  };
}

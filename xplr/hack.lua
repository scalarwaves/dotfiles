alias xcd='cd "$(xplr --print-pwd-as-result)"'
xplr.config.modes.builtin.default.key_bindings.on_key.m = {
  help = "bookmark",
  messages = {
    {
      BashExecSilently = [===[
        PTH="${XPLR_FOCUS_PATH:?}"
        if echo "${PTH:?}" >> "${XPLR_SESSION_PATH:?}/bookmarks"; then
          echo "LogSuccess: ${PTH:?} added to bookmarks" >> "${XPLR_PIPE_MSG_IN:?}"
        else
          echo "LogError: Failed to bookmark ${PTH:?}" >> "${XPLR_PIPE_MSG_IN:?}"
        fi
      ]===],
    },
  },
}

xplr.config.modes.builtin.default.key_bindings.on_key["`"] = {
  help = "go to bookmark",
  messages = {
    {
      BashExec = [===[
        PTH=$(cat "${XPLR_SESSION_PATH:?}/bookmarks" | fzf --no-sort)
        if [ "$PTH" ]; then
          echo FocusPath: "'"${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
        fi
      ]===],
    },
  },
}
xplr.config.modes.builtin.go_to.key_bindings.on_key.b = {
  help = "bookmark jump",
  messages = {
    "PopMode",
    { BashExec = [===[
        field='\(\S\+\s*\)'
        esc=$(printf '\033')
        N="${esc}[0m"
        R="${esc}[31m"
        G="${esc}[32m"
        Y="${esc}[33m"
        B="${esc}[34m"
        pattern="s#^${field}${field}${field}${field}#$Y\1$R\2$N\3$B\4$N#"
        PTH=$(sed 's#: # -> #' "$PATHMARKS_FILE"| nl| column -t \
        | gsed "${pattern}" \
        | fzf --ansi \
            --height '40%' \
            --preview="echo {}|sed 's#.*->  ##'| xargs exa --color=always" \
            --preview-window="right:50%" \
        | sed 's#.*->  ##')
        if [ "$PTH" ]; then
          echo ChangeDirectory: "'"${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
        fi
      ]===]
    },
  }
}
xplr.config.modes.builtin.go_to.key_bindings.on_key.h = {
  help = "history",
  messages = {
    "PopMode",
    {
      BashExec = [===[
        PTH=$(cat "${XPLR_PIPE_HISTORY_OUT:?}" | sort -u | fzf --no-sort)
        if [ "$PTH" ]; then
          echo ChangeDirectory: "'"${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
        fi
      ]===],
    },
  },
}
xplr.config.modes.builtin.default.key_bindings.on_key.S = {
  help = "serve $PWD",
  messages = {
    {
      BashExec = [===[
        IP=$(ip addr | grep -w inet | cut -d/ -f1 | grep -Eo '[0-9]{1,3}\.[0-9]{      1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | fzf --prompt 'Select IP > ')
        echo "IP: ${IP:?}"
        read -p "Port (default 5000): " PORT
        echo
        sfz --all --cors --no-ignore --bind ${IP:?} --port ${PORT:-5000} . &
        sleep 1 && read -p '[press enter to exit]'
        kill -9 %1
      ]===],
    },
  },
}
xplr.config.modes.builtin.default.key_bindings.on_key.P = {
  help = "preview",
  messages = {
    {
      BashExecSilently = [===[
        FIFO_PATH="/tmp/xplr.fifo"

        if [ -e "$FIFO_PATH" ]; then
          echo StopFifo >> "$XPLR_PIPE_MSG_IN"
          rm -f -- "$FIFO_PATH"
        else
          mkfifo "$FIFO_PATH"
          "$HOME/.local/bin/imv-open.sh" "$FIFO_PATH" "$XPLR_FOCUS_PATH" &
          echo "StartFifo: '$FIFO_PATH'" >> "$XPLR_PIPE_MSG_IN"
        fi
      ]===],
    },
  },
}
local function stat(node)
  return node.mime_essence
end

local function read(path, lines)
  local out = ""
  local p = io.open(path)

  if p == nil then
    return stat(path)
  end

  local i = 0
  for line in p:lines() do
    out = out .. line .. "\n"
    if i == lines then
      break
    end
    i = i + 1
  end
  p:close()

  return out
end

xplr.config.layouts.builtin.default = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 60 },
        { Percentage = 40 },
      },
    },
    splits = {
      "Table",
      {
        CustomContent = {
          title = "preview",
          body = { DynamicParagraph = { render = "custom.preview_pane.render" } },
        },
      },
    },
  },
}

xplr.fn.custom.preview_pane = {}
xplr.fn.custom.preview_pane.render = function(ctx)
  local n = ctx.app.focused_node

  if n and n.canonical then
    n = n.canonical
  end

  if n then
    if n.is_file then
      return read(n.absolute_path, ctx.layout_size.height)
    else
      return stat(n)
    end
  else
    return ""
  end
end

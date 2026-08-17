#!/usr/bin/env bash
#
# Renders one waybar module for a single Hyprland workspace.
#
# Why this exists instead of waybar's built-in hyprland/workspaces module:
# Hyprland 0.56 picks its IPC command parser based on the active config format.
# With hypr/hyprland.lua in place, socket1 wraps every `dispatch` payload as
# `return hl.dispatch(<payload>)` and evaluates it as Lua. Waybar hardcodes the
# hyprlang form -- `dispatch workspace 5` -- which is a Lua *syntax* error, so
# clicks are silently dropped. Read-only IPC is unaffected, which is why the
# built-in module still displayed the right numbers while doing nothing on click.
# The on-click handlers in config.jsonc send the Lua form instead.
#
# Refreshes are driven by hl.on(...) handlers in hyprland.lua, which signal
# waybar on the relevant workspace and window events.
#
# Usage: hypr-ws.sh <workspace-id>
#
# Prints one line of waybar JSON. Empty text hides the module, which reproduces
# hyprland/workspaces' behaviour of only showing workspaces that exist -- i.e.
# occupied, active, or persistent ones.

set -uo pipefail

id=${1:?usage: hypr-ws.sh <workspace-id>}

# One hyprctl round trip for all three queries; `jq -s` slurps the concatenated
# JSON documents into a 3-element array. A full refresh of all ten modules costs
# ~19ms, which is dominated by process startup -- caching the query between them
# saved 1ms and was not worth the staleness it introduced.
out=$(
	hyprctl -j --batch "workspaces ; activeworkspace ; clients" 2>/dev/null |
		jq -s -c --arg id "$id" '
			($id | tonumber) as $n
			| .[1].id as $active
			| (.[2] | map(select(.urgent) | .workspace.id)) as $urgent
			| (.[0] | map(select(.id == $n)) | first) as $w
			| if $w == null then
			    { text: "" }
			  else
			    { text:  $id,
			      class: ( ["ws"]
			               + (if $active == $n then ["active"] else [] end)
			               + (if ($urgent | index($n)) != null then ["urgent"] else [] end)
			               + (if $w.windows == 0 then ["empty"] else ["occupied"] end) ),
			      tooltip: ( "Workspace " + $id + " — "
			                 + (if $w.windows == 1 then "1 window"
			                    else ($w.windows | tostring) + " windows" end) ) }
			  end
		' 2>/dev/null
)

# Hyprland unreachable or malformed reply: hide the module rather than let waybar
# render a stale or half-parsed label.
[[ -n $out ]] || out='{"text":""}'
printf '%s\n' "$out"

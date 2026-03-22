{ themesLib }:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.themes.bat;
  p = config.themes.palette;
  themeName = "nix-themes-${config.themes.theme}-${config.themes.variant}";

  # Helper for tmTheme XML scope rule generation
  rule =
    name: scope: colors:
    let
      nameEntry = lib.optionalString (name != "") "<key>name</key><string>${name}</string>\n        ";
      colorEntries = lib.concatStringsSep "\n          " (
        lib.mapAttrsToList (k: v: "<key>${k}</key><string>${v}</string>") colors
      );
    in
    ''
      <dict>
        ${nameEntry}<key>scope</key>
        <string>${scope}</string>
        <key>settings</key>
        <dict>
          ${colorEntries}
        </dict>
      </dict>
    '';

  tmTheme = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>name</key>
        <string>${themeName}</string>
        <key>semanticClass</key>
        <string>theme.${if p.meta.dark then "dark" else "light"}.nix-themes</string>
        <key>author</key>
        <string>nix-themes</string>
        <key>colorSpaceName</key>
        <string>sRGB</string>
        <key>settings</key>
        <array>
          <dict>
            <key>settings</key>
            <dict>
              <key>background</key>
              <string>${p.base.hex}</string>
              <key>foreground</key>
              <string>${p.text.hex}</string>
              <key>caret</key>
              <string>${p.rosewater.hex}</string>
              <key>lineHighlight</key>
              <string>${p.surface0.hex}</string>
              <key>misspelling</key>
              <string>${p.red.hex}</string>
              <key>accent</key>
              <string>${p.mauve.hex}</string>
              <key>selection</key>
              <string>${p.overlay2.hex}40</string>
              <key>activeGuide</key>
              <string>${p.surface1.hex}</string>
              <key>gutterForeground</key>
              <string>${p.overlay1.hex}</string>
            </dict>
          </dict>
          ${rule "Basic text & variables"
            "text, source, variable.other.readwrite, punctuation.definition.variable"
            { foreground = p.text.hex; }
          }
          ${rule "Parentheses, Brackets, Braces" "punctuation" {
            foreground = p.overlay2.hex;
            fontStyle = "";
          }}
          ${rule "Comments" "comment, punctuation.definition.comment" {
            foreground = p.overlay2.hex;
            fontStyle = "italic";
          }}
          ${rule "" "string, punctuation.definition.string" { foreground = p.green.hex; }}
          ${rule "" "constant.character.escape" { foreground = p.pink.hex; }}
          ${rule "Booleans, constants, numbers"
            "constant.numeric, variable.other.constant, entity.name.constant, constant.language.boolean, constant.language.false, constant.language.true, keyword.other.unit.user-defined, keyword.other.unit.suffix.floating-point"
            { foreground = p.peach.hex; }
          }
          ${rule ""
            "keyword, keyword.operator.word, keyword.operator.new, variable.language.super, support.type.primitive, storage.type, storage.modifier, punctuation.definition.keyword"
            {
              foreground = p.mauve.hex;
              fontStyle = "";
            }
          }
          ${rule "" "entity.name.tag.documentation" { foreground = p.mauve.hex; }}
          ${rule "Punctuation"
            "punctuation.separator, punctuation.terminator, punctuation.accessor, punctuation.definition.params, meta.brace"
            {
              foreground = p.overlay2.hex;
              fontStyle = "";
            }
          }
          ${rule "Operators"
            "keyword.operator, punctuation.definition.decorator, punctuation.definition.tag"
            {
              foreground = p.sky.hex;
              fontStyle = "";
            }
          }
          ${rule "Function names"
            "entity.name.function, variable.function, support.function, meta.require, support.function.any-method, variable.annotation"
            { foreground = p.blue.hex; }
          }
          ${rule "Class names"
            "entity.name.class, entity.name.namespace, entity.name.scope-resolution, entity.name.type, meta.class entity.name.function, support.class, entity.name.exception, entity.name.tag.yaml"
            {
              foreground = p.yellow.hex;
              fontStyle = "";
            }
          }
          ${rule "Type annotations"
            "meta.type.annotation, support.type, entity.name.type.class, entity.name.type.module"
            { foreground = p.yellow.hex; }
          }
          ${rule "Constructor"
            "entity.name.function.constructor, entity.name.function.destructor, variable.other.object.property"
            { foreground = p.sapphire.hex; }
          }
          ${rule "Variables" "variable, variable.other, variable.other.object, variable.other.property"
            { foreground = p.text.hex; }
          }
          ${rule "Builtins" "support.variable, variable.language, support.type.sys-types" {
            foreground = p.red.hex;
          }}
          ${rule "Tags" "entity.name.tag, punctuation.definition.tag" { foreground = p.blue.hex; }}
          ${rule "Tag attributes" "entity.other.attribute-name" { foreground = p.yellow.hex; }}
          ${rule "Link, URL" "markup.underline.link, string.other.link" {
            foreground = p.blue.hex;
            fontStyle = "underline";
          }}
          ${rule "Markup heading" "markup.heading, punctuation.definition.heading, entity.name.section"
            {
              foreground = p.blue.hex;
              fontStyle = "bold";
            }
          }
          ${rule "Markup bold" "markup.bold, punctuation.definition.bold" {
            foreground = p.red.hex;
            fontStyle = "bold";
          }}
          ${rule "Markup italic" "markup.italic, punctuation.definition.italic" {
            foreground = p.red.hex;
            fontStyle = "italic";
          }}
          ${rule "Markup code" "markup.raw, markup.fenced_code" { foreground = p.green.hex; }}
          ${rule "Markup quote" "markup.quote" {
            foreground = p.pink.hex;
            fontStyle = "italic";
          }}
          ${rule "Markup list" "markup.list, punctuation.definition.list_item" {
            foreground = p.teal.hex;
          }}
          ${rule "Diff added" "markup.inserted, diff.inserted" { foreground = p.green.hex; }}
          ${rule "Diff removed" "markup.deleted, diff.deleted" { foreground = p.red.hex; }}
          ${rule "Diff changed" "markup.changed" { foreground = p.blue.hex; }}
          ${rule "Import/module" "keyword.control.import, keyword.control.export, keyword.other.import"
            {
              foreground = p.mauve.hex;
              fontStyle = "italic";
            }
          }
          ${rule "Decorator/Annotation"
            "meta.decorator, meta.annotation, punctuation.definition.annotation"
            { foreground = p.pink.hex; }
          }
          ${rule "Regex" "string.regexp" { foreground = p.pink.hex; }}
          ${rule "Special variables" "variable.parameter" {
            foreground = p.maroon.hex;
            fontStyle = "italic";
          }}
          ${rule "Member access" "variable.other.member, variable.other.object.property" {
            foreground = p.blue.hex;
          }}
        </array>
      </dict>
    </plist>
  '';

  themeDir = pkgs.writeTextDir "${themeName}.tmTheme" tmTheme;
in

{
  options.themes.bat = themesLib.mkThemeOption { name = "bat"; };

  config = lib.mkIf cfg.enable {

    programs.bat = {
      config.theme = themeName;
      themes.${themeName} = {
        src = themeDir;
        file = "${themeName}.tmTheme";
      };
    };
  };
}

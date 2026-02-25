import re
import sys
from pathlib import Path


def ensure_body_class(html: str) -> str:
    match = re.search(r"<body([^>]*)>", html)
    if not match:
        return html
    attrs = match.group(1)
    if "class=" in attrs:
        if "lifeguide-body" in attrs:
            return html
        new_attrs = re.sub(
            r"class=\"([^\"]*)\"",
            lambda m: "class=\"{} lifeguide-body\"".format(m.group(1)),
            attrs,
        )
    else:
        new_attrs = attrs + ' class="lifeguide-body"'
    return html.replace(match.group(0), "<body{}>".format(new_attrs), 1)


def promote_toc(html: str) -> str:
    if "class=\"toc\"" in html:
        return html
    toc_pattern = re.compile(
        r"<div[^>]*(id=\"TOC\"|id=\"toc\"|class=\"tableofcontents\")[^>]*>(.*?)</div>",
        re.DOTALL,
    )
    match = toc_pattern.search(html)
    if not match:
        return html
    toc_html = match.group(2)
    html = html[:match.start()] + html[match.end():]
    html = re.sub(
        r"(<body[^>]*>)",
        r"\1\n<button class=\"toc-toggle\" type=\"button\" aria-expanded=\"true\">目录</button>\n"
        r"<nav class=\"toc\">\n" + toc_html + "\n</nav>",
        html,
        count=1,
    )
    return html


def main() -> int:
    if len(sys.argv) < 2:
        print("Usage: postprocess_html.py <html_dir>")
        return 1
    html_dir = Path(sys.argv[1])
    if not html_dir.exists():
        print("Directory not found:", html_dir)
        return 1

    for file_path in html_dir.glob("*.html"):
        text = file_path.read_text(encoding="utf-8", errors="ignore")
        text = ensure_body_class(text)
        text = promote_toc(text)
        if "toc-toggle" in text and "toc-collapsed" not in text:
            text = re.sub(
                r"</body>",
                "<script>"
                "(function(){var b=document.querySelector('.toc-toggle');"
                "if(!b){return;}"
                "b.addEventListener('click',function(){"
                "document.body.classList.toggle('toc-collapsed');"
                "var expanded=!document.body.classList.contains('toc-collapsed');"
                "b.setAttribute('aria-expanded', expanded ? 'true' : 'false');"
                "});})();"
                "</script></body>",
                text,
                count=1,
            )
        file_path.write_text(text, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

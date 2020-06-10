# depends: python rich

rich () {
  python -c "from rich.console import Console
from rich.markdown import Markdown
c = Console()
with open('$@') as f:
 c.print(Markdown(f.read()))"
}

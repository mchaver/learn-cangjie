WebSearchCangjie 拆字規則 SVG decomposition visualization open source
WebSearchopen-cangjie database character decomposition
WebFetchhttps://github.com/open-cangjie
WebSearch"Cangjie input" "decomposition" database JSON SVG visualization 2023 2024

Based on my research, here are the publicly available resources for Cangjie character decomposition visualization:
Best Options for Cangjie Decomposition SVGs
1. Make Me a Hanzi (Most Comprehensive)

    URL: https://www.skishore.me/makemeahanzi/ | https://github.com/skishore/makemeahanzi
    What it provides:
        SVG stroke order data for Chinese characters
        JSON data with Ideographic Description Sequence (IDS) decomposition
        Animated SVG tarball available
        Strokes laid out on 1024x1024 coordinate system
    License: Open source
    Note: Focuses on stroke order rather than Cangjie-specific decomposition, but provides the SVG foundation

2. HanziVG

    URL: https://github.com/Connum/hanzivg
    What it provides:
        SVG stroke order files for Traditional and Simplified Chinese
        Based on KanjiVG
    Good for: Visual stroke-level decomposition

3. CJK Decomposition Database

    URL: https://github.com/amake/cjk-decomp
    What it provides:
        Decomposition data for ~75,000 CJK characters
        Text-based decomposition (not SVG)
    Good for: Understanding character component structure

4. Cangjie-Specific Tools

cangjie-code

    URL: https://github.com/geniusgordon/cangjie-code
    Converts Chinese characters to Cangjie v5 codes

chinese2cangjie

    Includes char2cangjie.json dictionary files

The Gap: True Cangjie 拆字規則 SVG Visualization

Unfortunately, there doesn't appear to be a comprehensive open-source SVG library specifically showing Cangjie 拆字規則 (decomposition rules with visual highlighting of Cangjie radicals).
What You Could Build

You could create this by combining:

    Make Me a Hanzi SVG data (for character shapes)
    Cangjie decomposition databases (for radical breakdown)
    Custom SVG overlays showing which strokes belong to each Cangjie radical

This would be a valuable contribution to the Cangjie learning community! Would you like help designing a system to visualize Cangjie decomposition rules using these resources?

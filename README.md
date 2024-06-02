aya-dance-video-index
=====================

中文说明在该文件的后半部分。

This repository is the index of community-contributed dance videos for [AyaDance](https://vrchat.com/home/world/wrld_9ad22e66-8f3a-443e-81f9-87c350ed5113),
a VRChat world for dancing with fancy features.

We don't host video files in this repository. Instead, we build an index of videos from many platforms containing
only the necessary metadata, like the video URL, the category of the video, the duration, etc.

## How to contribute a dance video?

Currently, we only accept dance videos from YouTube, (and other video platforms in the future, e.g. BiliBili). 
To contribute a dance video, you need to:

1. Fork this repository.
2. Create a new markdown file in the `videos` directory, or better, in a subdirectory of `videos` if you want to categorize your video.
   We recommend you to organize videos by their authors, or dance styles, or any other criteria you think is appropriate.
   The file name should be **a short unique identifier** of the video (like the song name: `Song-可惜没如果.md`),
   and should not contain any special characters (spaces are allowed, but not recommended).
3. Fill in the metadata of the video **in the frontmatter of the markdown file**. The metadata should include:

   - `URL`: the URL of the video on YouTube.
   - `CategoryID`: the ID of the category the video belongs to. You can find the category ID in the `categories.json` file.
   - `CategoryName`: the name of the category the video belongs to. You can find the category name in the `categories.json` file.
   
   If you are not sure about the format, 
   you can refer to the existing markdown files in the `videos` directory for examples,
   or check out existing PRs [like this one: Add 呐喊 Screaming | VRChat Fitness Dance | Song^_^](https://github.com/ClownpieceStripedAbyss/aya-dance-video-index/pull/3) for examples,
   or ask the maintainers for help (please at least try to fill in the metadata by yourself first).
4. Write a brief description of the video in the markdown file, after the frontmatter.
   Usually the video title is enough, but you can also add some other information if you want.
   
   A minimal but complete template is as follows:
   ```markdown
    ---
    URL: https://www.youtube.com/watch?v=jGHFpv_oDS0
    CategoryID: 13
    CategoryName: Others (J-POP)
    ---
    
    【Full Dance】振付師が III / 宝鐘マリン&Kobo Kanaeru 踊ってみた【わた×まりやん】
   ```
   
5. Commit your changes and create a pull request.
6. Wait for the maintainers to review your pull request. If everything is correct, 
   your pull request will be merged and your video will be added to the index.
7. Wait for the index to be updated. The index is updated every 3:00 AM HKT every day.
   After the update, you can find the added video in the [AyaDance World](https://vrchat.com/home/world/wrld_9ad22e66-8f3a-443e-81f9-87c350ed5113).
   We also host a web version of the index at [aya.kiva.moe](https://aya.kiva.moe), where you can find all the videos indexed.
   The web version is updated every 4:00 AM HKT every day, so you may need to wait a little longer to see your video on the web.
   We forced a 1-hour delay to ensure the new video files are synced to the production server.



## Credit

- We use [yt-dlp](https://github.com/yt-dlp/yt-dlp) to download videos from YouTube and other video platforms.
- We use [aya-dance-indexer](https://github.com/ClownpieceStripedAbyss/aya-dance-indexer) to generate the metadata from the video URLs.
- We use [ChatGPT](https://chat.openai.com) to translate this README from English to other languages.





---------------





aya-dance-video-index
=====================

这是 [AyaDance](https://vrchat.com/home/world/wrld_9ad22e66-8f3a-443e-81f9-87c350ed5113) 的社区贡献舞蹈视频索引，这是一个用于跳舞的 VRChat 世界，拥有许多有趣的功能。

我们不在此仓库中托管视频文件。相反，我们构建了一个包含来自多个平台视频的索引，仅包含必要的元数据，如视频 URL、视频类别、视频时长等。

## 如何贡献舞蹈视频？

目前，我们只接受来自 YouTube 的舞蹈视频，（未来将接受其他视频平台，例如 BiliBili）。
要贡献舞蹈视频，您需要：

1. Fork 这个仓库。
2. 在 `videos` 目录下创建一个新的 markdown 文件，或者更好地，在 `videos` 的子目录下创建文件，如果您想对您的视频进行分类。
   我们建议您按作者、舞蹈风格或您认为合适的任何其他标准来组织视频。
   文件名应为 **视频的简短唯一标识符**（如歌曲名称：`Song-可惜没如果.md`），并且不应包含任何特殊字符（允许使用空格，但不推荐）。
3. 在 markdown 文件的 **前置数据区** 中填写视频的元数据。元数据应包括：

    - `URL`：视频在 YouTube 上的链接。
    - `CategoryID`：视频所属类别的 ID。您可以在 `categories.json` 文件中找到类别 ID。
    - `CategoryName`：视频所属类别的名称。您可以在 `categories.json` 文件中找到类别名称。
   
   如果您不确定格式，可以参考 `videos` 目录中的现有 markdown 文件示例，
   或查看现有的 PR 示例 [如这个：Add 呐喊 Screaming | VRChat Fitness Dance | Song^_^](https://github.com/ClownpieceStripedAbyss/aya-dance-video-index/pull/3)，
   或向维护者寻求帮助（请至少尝试自己填写元数据）。
4. 在前置数据区之后，在 markdown 文件中写一段简短的视频描述。
   通常视频标题就足够了，但如果您愿意，也可以添加其他信息。

   完整的最简易模板如下：
   ```markdown
    ---
    URL: https://www.youtube.com/watch?v=jGHFpv_oDS0
    CategoryID: 13
    CategoryName: Others (J-POP)
    ---
    
   【Full Dance】振付師が III / 宝鐘マリン&Kobo Kanaeru 踊ってみた【わた×まりやん】
   ```
   
5. 提交您的更改并创建一个 pull request。
6. 等待维护者审核您的 pull request。如果一切正确，您的 pull request 将被合并，您的视频将被添加到索引中。
7. 等待索引更新。索引每天下午 3:00 HKT 更新。
   更新后，您可以在 [AyaDance World](https://vrchat.com/home/world/wrld_9ad22e66-8f3a-443e-81f9-87c350ed5113) 中找到添加的视频。
   我们还在 [aya.kiva.moe](https://aya.kiva.moe) 上托管了索引的网页版本，您可以在该网站上找到所有索引的视频。
   网页版本每天上午 4:00 HKT 更新，因此您可能多等待一小时才能在网页上看到您的视频。
   设置 1 小时的延迟是为了确保新视频文件同步到生产服务器。


## 致谢

- 我们使用 [yt-dlp](https://github.com/yt-dlp/yt-dlp) 从 YouTube 和其他视频平台下载视频。
- 我们使用 [aya-dance-indexer](https://github.com/ClownpieceStripedAbyss/aya-dance-indexer) 从视频 URL 生成元数据。
- 我们使用 [ChatGPT](https://chat.openai.com) 将此 README 从英文翻译成其他语言。

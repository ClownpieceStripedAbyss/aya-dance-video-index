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
   - `CategoryName`: the name of the category the video belongs to. You can find the category name in the [categories.json](categories.json) file.
   - `Flip`: whether the video should be flipped horizontally. **For videos that are already mirrored, set this to `false`.**
   - `CategoryID` (optional): the ID of the category the video belongs to. You can find the category ID in the [categories.json](categories.json) file.
   
   If you are not sure about the format, 
   you can refer to the existing markdown files in the `videos` directory for examples,
   or check out existing PRs [like this one: Add 呐喊 Screaming | VRChat Fitness Dance | Song^_^](https://github.com/ClownpieceStripedAbyss/aya-dance-video-index/pull/3) for examples,
   or ask the maintainers for help (please at least try to fill in the metadata by yourself first).
4. Write a brief description of the video in the markdown file, after the frontmatter.
   Usually the video title is enough, but you can also add some other information if you want.
   
   A minimal but complete template is as follows:
   ```markdown
   ---
   URL: https://www.youtube.com/watch?v=X9TMa-X38cg
   CategoryName: Others
   Flip: true
   ---
   
   APOKI (아뽀키) 'Space' Dance Practice 연습실 영상
   ```
   
5. Commit your changes and create a pull request.
6. Wait for the maintainers to review your pull request. If everything is correct, 
   your pull request will be merged and your video will be uploaded to the _staging index_.
7. Wait for the synchronization from staging to production to finish.
   This is an automated process scheduled at 5:00 AM HKT every day, and you don't need to do anything.
   After which you can find new videos in the [AyaDance World](https://vrchat.com/home/world/wrld_9ad22e66-8f3a-443e-81f9-87c350ed5113).
   or our website [aya.kiva.moe](https://aya.kiva.moe).



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
    - `CategoryName`：视频所属类别的名称。您可以在 [categories.json](categories.json) 文件中找到类别名称。
    - `Flip`：视频是否应水平翻转。**对于已经镜像的视频，请将此设置为 `false`。**
    - `CategoryID`（可选）：视频所属类别的 ID。您可以在 [categories.json](categories.json) 文件中找到类别 ID。
   
   如果您不确定格式，可以参考 `videos` 目录中的现有 markdown 文件示例，
   或查看现有的 PR 示例 [如这个：Add 呐喊 Screaming | VRChat Fitness Dance | Song^_^](https://github.com/ClownpieceStripedAbyss/aya-dance-video-index/pull/3)，
   或向维护者寻求帮助（请至少尝试自己填写元数据）。
4. 在前置数据区之后，在 markdown 文件中写一段简短的视频描述。
   通常视频标题就足够了，但如果您愿意，也可以添加其他信息。

   完整的最简易模板如下：
   ```markdown
   ---
   URL: https://www.youtube.com/watch?v=X9TMa-X38cg
   CategoryName: Others
   Flip: true
   ---
   
   APOKI (아뽀키) 'Space' Dance Practice 연습실 영상
   ```
   
5. 提交您的更改并创建一个 pull request。
6. 等待维护者审核您的 pull request。如果一切正确，您的 pull request 将被合并，您的视频将被上传到 _暂存服务器_ 中。
7. 等待从暂存服务器到生产服务器的同步完成。
   这是一个每天早上 5:00 HKT 定时执行的自动化过程，您无需做任何事情。
   之后，您可以在 [AyaDance 世界](https://vrchat.com/home/world/wrld_9ad22e66-8f3a-443e-81f9-87c350ed5113)
   或我们的网站 [aya.kiva.moe](https://aya.kiva.moe) 中找到新的视频。


## 致谢

- 我们使用 [yt-dlp](https://github.com/yt-dlp/yt-dlp) 从 YouTube 和其他视频平台下载视频。
- 我们使用 [aya-dance-indexer](https://github.com/ClownpieceStripedAbyss/aya-dance-indexer) 从视频 URL 生成元数据。
- 我们使用 [ChatGPT](https://chat.openai.com) 将此 README 从英文翻译成其他语言。

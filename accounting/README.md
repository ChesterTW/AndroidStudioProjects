# 前言

這是一個記帳APP，名為：Spendify（請 ChatGPT 取的XD）<br>
<br>
Spendify 的所有截圖：[Google Drive](https://drive.google.com/drive/folders/1WsYfle3v3Az-mabM22Ex0Nom0-4_7QBz?usp=sharing)

 ![image](https://github.com/ChesterTW/AndroidStudioProjects/blob/main/accounting/images/home_page.png)

<br>

## 製作源由

APP Store 的記帳 APP，多是功能繁多、畫面雜亂，<br>
或是每次打開都賞你五秒的廣告，<br>
讓我覺得使用體驗不佳。<br>

所以，我自己跑來做了一個符合自己需求，且沒廣告的 APP，<br>
還能練練自己的 Code，天阿 多賺<br>

它可以紀錄日常花費，了解每個月的花費有無赤支，<br>
讓你查看本月的「花費佔比」，以及近七天的「花費紀錄」，<br>

而畫面在設計時，盡可能讓用戶減少操作、跳轉，<br>
即能「看見、使用」最重要的功能。

<br>

## 調整功能
1. 設定每月的「固定額度」<br>
2. 設定本月的「追加額度」<br>
3. 設定「每月起始日期」<br>

<br>

## 學到的
在這一個月的時間內，利用 Figma 設計 APP，和請朋友做 UI/UX 測試，不斷調適，做出舒適的 APP。學習到：<br>

1. 手機的常用手勢，能夠方便操作<br>
2. 畫面的層次架構，以及顏色與提示應用，舒適、快速的找到功能<br>

<br>

利用 ChatGPT、Youtube、StackOverflow，學習到：<br>

1. 資料輸入：<br>

  * 學會使用 `TextFieldController`<br>
  * 和 `DateTime` 的格式轉換、翻譯<br>
  * 運用 `showDatePicker` 挑選日期<br>
  * 使用 `ToggleButtons`、`CupertinoSlidingSegmentedControl` 做出直覺的選取按鈕<br>
  * 透過 `SingleChildScrollView` 渲染物件於側向滑動列中<br>
    ![image](https://github.com/ChesterTW/AndroidStudioProjects/blob/main/accounting/images/user_new_expense.png)

<br>

2. 數據存取：<br>

  * SQLite 在手機上的使用<br>
  * 使用 `SharedPreferences` 傳遞、存取數值<br>
  * 使用 `CircularProgressIndicator` 等待數值讀取<br>

<br>

3. 國泰 Setting：<br>

  * 使用 `ExpansionTile`、`ListTile` 模仿 國泰APP 的功能列。能幫助使用者快速地找到功能，而且畫面非常整潔，我覺得是一個很棒的做法。<br>
  ![image](https://github.com/ChesterTW/AndroidStudioProjects/blob/main/accounting/images/setting_page.png)

<br>

4. 伸縮 AppBar：<br>

  * 使用 `SliverAppBar` 模仿 FoodPanda 的伸縮頁面，解決 AppBar 太多占用過多畫面的問題。<br>
  * 使用 `Preference` 讓 `SliverAppBar` 伸縮的顏色能夠漸變。<br>



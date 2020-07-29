Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72C7231969
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgG2GTZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2GTY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 02:19:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47DC061794
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jul 2020 23:19:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i92so1093457pje.0
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jul 2020 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wtuxLP0ca/1lLLWZrG8eU9P0LZtnmzzX2jMre0ZG8VM=;
        b=dRLqwPgId8IZo8/ccRXzF3ObkrXodoTy5jMzxNkUy5RbHut4EIUuk1O2jmnXEsrR+l
         x9bG70WzOhTWOtV9ein3nXRQyJdDk5NLweSkcnbxEBXzCkuVHKvwKSMZZi9vx/Tj4Fxp
         +h7jmCh4qoMZ0GjZ/SkpY/dhAFvqjeKogjFWNzbUpJcMLkK4GzYF9EwzFTXbXKfkmvph
         rORmFKAfkrU9vvPSP561Ltk2V+VlL1CCc7tRrkEj1XKXeAs4832+7P70MVJofDu9vFLr
         WldmkZz59XNhjl7V6jNQZyKb/c0Z2iYsTDMgS/joZ4KRoa/Jw0mBknUOe7aUZVjSZtct
         CtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wtuxLP0ca/1lLLWZrG8eU9P0LZtnmzzX2jMre0ZG8VM=;
        b=ukMGzfkm5NX1BRiMDkJg7KyMOev7jf/uITIcSZ9sT3qxCFJxAnNJiHNemRUIsbihvI
         o7njmuZly6ZeQVJ4NO03A4Ghrg2RebMplIvji29IqKX0XALYqjZ3jQ60c+W5BCtqqQWf
         6NFJiV1Cvw2gXr/OWxUne0liNmNSqhyUUiBwWlTiL6yyEo31h4fmyz8Ci9NBvpPwwmHl
         ioi0iiTWiw+KvNnu48lWRWQWj1+0eMVGu5v/6DDfsVy2aY9Tn9p3jFJg52DsSZN5P7hw
         I7UAuyGjM9cjQDn2UuVkFgWYu6/+ypNWO42P1H4B2xEHyL8rLoLHscNHFpofUN6lfusL
         eJsw==
X-Gm-Message-State: AOAM533IFdcJv6Fh6BNv/Fq5+QSqqHoOvFLj1lc1Xl3RRcyrRKDun+Lh
        XOybAOmpOeUMYNhgd45y8iGnqgdoMdk=
X-Google-Smtp-Source: ABdhPJyIjGhzuzuO2ArOBpU0Npgzfezv2LM0ans6jSti+91guPrfBIvgBg401K34mTp/+qRBE1Faag==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr8158020pjp.143.1596003562284;
        Tue, 28 Jul 2020 23:19:22 -0700 (PDT)
Received: from [10.8.0.10] ([203.205.141.60])
        by smtp.gmail.com with ESMTPSA id io3sm964170pjb.22.2020.07.28.23.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 23:19:21 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH 1/2] ext4: rename journal_dev to s_journal_dev inside
 ext4_sb_info
Message-ID: <74c2a122-5a6c-ac97-614a-043038d61623@gmail.com>
Date:   Wed, 29 Jul 2020 14:19:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
the naming rules consistent with other variables, which is
convenient for code reading and writing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  8 ++++----
 fs/ext4/super.c | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 68e0ebe..8ca9adf 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1463,7 +1463,7 @@ struct ext4_sb_info {
     unsigned long s_commit_interval;
     u32 s_max_batch_time;
     u32 s_min_batch_time;
-    struct block_device *journal_bdev;
+    struct block_device *s_journal_bdev;
 #ifdef CONFIG_QUOTA
     /* Names of quota files with journalled quota */
     char __rcu *s_qf_names[EXT4_MAXQUOTAS];
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index dbccf46..005c0ae 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -571,8 +571,8 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
     if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
         fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
         return true;
-    if (EXT4_SB(sb)->journal_bdev &&
-        fm->fmr_device == new_encode_dev(EXT4_SB(sb)->journal_bdev->bd_dev))
+    if (EXT4_SB(sb)->s_journal_bdev &&
+        fm->fmr_device == new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
         return true;
     return false;
 }
@@ -642,9 +642,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
     memset(handlers, 0, sizeof(handlers));
     handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
     handlers[0].gfd_fn = ext4_getfsmap_datadev;
-    if (EXT4_SB(sb)->journal_bdev) {
+    if (EXT4_SB(sb)->s_journal_bdev) {
         handlers[1].gfd_dev = new_encode_dev(
-                EXT4_SB(sb)->journal_bdev->bd_dev);
+                EXT4_SB(sb)->s_journal_bdev->bd_dev);
         handlers[1].gfd_fn = ext4_getfsmap_logdev;
     }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8ce61f3..f785aee7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -935,10 +935,10 @@ static void ext4_blkdev_put(struct block_device *bdev)
 static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 {
     struct block_device *bdev;
-    bdev = sbi->journal_bdev;
+    bdev = sbi->s_journal_bdev;
     if (bdev) {
         ext4_blkdev_put(bdev);
-        sbi->journal_bdev = NULL;
+        sbi->s_journal_bdev = NULL;
     }
 }
 
@@ -1069,14 +1069,14 @@ static void ext4_put_super(struct super_block *sb)
 
     sync_blockdev(sb->s_bdev);
     invalidate_bdev(sb->s_bdev);
-    if (sbi->journal_bdev && sbi->journal_bdev != sb->s_bdev) {
+    if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
         /*
          * Invalidate the journal device's buffers.  We don't want them
          * floating about in memory - the physical journal device may
          * hotswapped, and it breaks the `ro-after' testing code.
          */
-        sync_blockdev(sbi->journal_bdev);
-        invalidate_bdev(sbi->journal_bdev);
+        sync_blockdev(sbi->s_journal_bdev);
+        invalidate_bdev(sbi->s_journal_bdev);
         ext4_blkdev_remove(sbi);
     }
 
@@ -3712,7 +3712,7 @@ int ext4_calculate_overhead(struct super_block *sb)
      * Add the internal journal blocks whether the journal has been
      * loaded or not
      */
-    if (sbi->s_journal && !sbi->journal_bdev)
+    if (sbi->s_journal && !sbi->s_journal_bdev)
         overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
     else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
         /* j_inum for internal journal is non-zero */
@@ -5057,7 +5057,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
             be32_to_cpu(journal->j_superblock->s_nr_users));
         goto out_journal;
     }
-    EXT4_SB(sb)->journal_bdev = bdev;
+    EXT4_SB(sb)->s_journal_bdev = bdev;
     ext4_init_journal_params(sb, journal);
     return journal;
 
-- 
1.8.3.1


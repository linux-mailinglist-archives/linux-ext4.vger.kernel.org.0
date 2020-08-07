Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAB23E72D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 08:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHGGUd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 02:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHGGUa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 02:20:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275AC061574
        for <linux-ext4@vger.kernel.org>; Thu,  6 Aug 2020 23:20:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so453721pfw.9
        for <linux-ext4@vger.kernel.org>; Thu, 06 Aug 2020 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jgR04DWDWPwWov88sWDqu+ZnDFC0KUVoJNi3wqndAog=;
        b=P1d0UTbFCCvBzrw7xaU7lY+4Oza4ZKI40JYtWLF+rBpfoKPaYABJS8Dyx8JHHmfrl+
         5y2pRPrur0vxcn+qg1VIrLk/ckkiRluDwv+UWBBrKZWreriW3AOIu8FsfXcLw2NjVhSu
         aNMxjU9TV8HqohBlSMB+y+IZUGfLEzEJpxTooinkdZiW+iEbkx1mncAZJ/Lc9Mv5iTls
         at+5lkunFJ0lgEswGTgC7glccYFt1V50M/PL2gb0qWzajTdhMjdzTugAxNt9rsFRVoJV
         /SVndB514sWzPbnhwajBOwGrZBiChQ08X+rtMZRsNbY1llEew3smUIrJU81Tf/JMcGb0
         2rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jgR04DWDWPwWov88sWDqu+ZnDFC0KUVoJNi3wqndAog=;
        b=biytlLV6qMUPXLsk5j0fLTYjpvFSfqK+eID7bgMB5K/GKG9W+TT2QfRbYNc1dzOm1n
         s44T5KN+vZqqkfG2ZQFXMHg/GqFCwJHHtyLIje9TfW2KK1bOZkq8Kt+DWP60me23d6AP
         gelbJsU+Riw1aXeNXreFqlhBCQh4siZ2Ysd/VJ+ejxIwPsOYLjWC1OWyDB2vg6AyQndv
         Uvx8LqBfGKklaVoI+US/x0a7nnN4eG8QzV1XnigAtCK1RZ7PMpTn6WX48tpnmol+idTF
         lhpVT8utc5Yw9wvgAytwZBs7PyC+4v0EbmGnyNQ0gEKNdh7uMhlz1EnEYf515GaPmQLy
         F+XQ==
X-Gm-Message-State: AOAM532siGheqKcoTUo90uD5jaRplt45wu2JlGcN1E5GrUjC0HkdfR5N
        Ap4/Ns6uMO5iagehHgmh/VDSZ2TvjWI=
X-Google-Smtp-Source: ABdhPJxPA7ZJ0T61TPbUsWEtehEspHUNh+x4BHsGRmroOqSwlZ6EhS0MviF9uZ0st0pzCXnoBs9lng==
X-Received: by 2002:a62:1782:: with SMTP id 124mr11363794pfx.204.1596781229628;
        Thu, 06 Aug 2020 23:20:29 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id c125sm10482613pfa.119.2020.08.06.23.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 23:20:29 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v2 1/2] ext4: rename journal_dev to s_journal_dev inside
 ext4_sb_info
Message-ID: <561ad829-542a-2ed2-349f-62ff0ac7fa19@gmail.com>
Date:   Fri, 7 Aug 2020 14:20:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
the naming rules consistent with other variables, which is
convenient for code reading and writing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/fsmap.c |  8 ++++----
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
-	struct block_device *journal_bdev;
+	struct block_device *s_journal_bdev;
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
-	if (EXT4_SB(sb)->journal_bdev &&
-	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->journal_bdev->bd_dev))
+	if (EXT4_SB(sb)->s_journal_bdev &&
+	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
 		return true;
 	return false;
 }
@@ -642,9 +642,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
 	handlers[0].gfd_fn = ext4_getfsmap_datadev;
-	if (EXT4_SB(sb)->journal_bdev) {
+	if (EXT4_SB(sb)->s_journal_bdev) {
 		handlers[1].gfd_dev = new_encode_dev(
-				EXT4_SB(sb)->journal_bdev->bd_dev);
+				EXT4_SB(sb)->s_journal_bdev->bd_dev);
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
-	bdev = sbi->journal_bdev;
+	bdev = sbi->s_journal_bdev;
 	if (bdev) {
 		ext4_blkdev_put(bdev);
-		sbi->journal_bdev = NULL;
+		sbi->s_journal_bdev = NULL;
 	}
 }
 
@@ -1069,14 +1069,14 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->journal_bdev && sbi->journal_bdev != sb->s_bdev) {
+	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
 		/*
 		 * Invalidate the journal device's buffers.  We don't want them
 		 * floating about in memory - the physical journal device may
 		 * hotswapped, and it breaks the `ro-after' testing code.
 		 */
-		sync_blockdev(sbi->journal_bdev);
-		invalidate_bdev(sbi->journal_bdev);
+		sync_blockdev(sbi->s_journal_bdev);
+		invalidate_bdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -3712,7 +3712,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * Add the internal journal blocks whether the journal has been
 	 * loaded or not
 	 */
-	if (sbi->s_journal && !sbi->journal_bdev)
+	if (sbi->s_journal && !sbi->s_journal_bdev)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
@@ -5057,7 +5057,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 			be32_to_cpu(journal->j_superblock->s_nr_users));
 		goto out_journal;
 	}
-	EXT4_SB(sb)->journal_bdev = bdev;
+	EXT4_SB(sb)->s_journal_bdev = bdev;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
-- 
1.8.3.1

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8BC2766A9
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 05:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIXDDs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Sep 2020 23:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIXDDr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Sep 2020 23:03:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99872C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 20:03:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so825821pji.1
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 20:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ndXbnHCuVwAzGh1XvZLAshCnLoLiHPzbQNRGtZLh8Ho=;
        b=rLfO54uyWVuFElvOwMxzL00Ntv1y5RMLWs/PuJ5u+13UmjaH7dHNHcku8mfCQGUieC
         RoFp88wpmLAHD6a0+7BSWwEqfNU9ZjhvnkTp6//N4nsF/xeWKAmHGsviwYBpo/uLnoQi
         ow6yl3S22yFI71Xuz5xCIRwENo4gD+eSTvZWsvvhIml7Z2Q5uw4x/aH8eEc/X0XalJ5V
         yna5YzEoZJRUXktWWcYeZOoWMz0UIjJ8aOC7k2D9wLanZmyM/z3r8uuoLv1PIB4GIr9G
         lzUk/t05rq2OCNDy1P0CLhAJdFtp0Y08Oe7gfn9r+qwc4dXuyYJUoaOpBc+eAerJNQwy
         NYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ndXbnHCuVwAzGh1XvZLAshCnLoLiHPzbQNRGtZLh8Ho=;
        b=gOeGWmFE4RWW0Jvzw/OWpWIp9rJYAHoed2Q5N6ig3WwQ6H4fs4R6w2flf6LFirfp34
         Iu9gPXD8MT3bGUos8VS3QQA2Co1SzBnF5HPDSfpUfV4GZE+hU7/yrzQAzMUmnikAlLay
         SpjRRWs9vOf8gXrYOfFYcGVPiPBAT8BQKp307GXQII3YNmu7pI7777Ir8/u3SCtVDICA
         Wx3VdomYU4vsCyuEayZl6gph02m0pYjmfmRHored0aoBxd6xqCavntBXb0p7OG5U9yyF
         dyRIIE0HI8h2Z4xcYCMBO/rInfhRxmzwwWwaFWgoXSFP3KzXzKvBeYTQyiovBt3U8yg5
         3Nfg==
X-Gm-Message-State: AOAM533wruAqJcts1z+52vq4W+AeK+dNGzmPlRSkHh56CRP1GWprjgNy
        du74gs6cNdwsMshQQaEQI5Y=
X-Google-Smtp-Source: ABdhPJzge/wReqxIpLUYnGbP5DrrYsj56mFno/5ok6Let0d/tkgstwP4WhTSlKOU1t4p9rY3sszOig==
X-Received: by 2002:a17:902:d913:b029:d0:cbe1:e712 with SMTP id c19-20020a170902d913b02900d0cbe1e712mr2693979plz.32.1600916626984;
        Wed, 23 Sep 2020 20:03:46 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 3sm979525pgw.44.2020.09.23.20.03.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 20:03:46 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     adilger@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH v2 RESEND 1/2] ext4: rename journal_dev to s_journal_dev inside ext4_sb_info
Date:   Thu, 24 Sep 2020 11:03:42 +0800
Message-Id: <1600916623-544-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
the naming rules consistent with other variables, which is
convenient for code reading and writing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
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


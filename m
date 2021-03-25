Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAC34993E
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 19:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYSMd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Mar 2021 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCYSMX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Mar 2021 14:12:23 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EECC06174A
        for <linux-ext4@vger.kernel.org>; Thu, 25 Mar 2021 11:12:23 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id d62so448560vkb.8
        for <linux-ext4@vger.kernel.org>; Thu, 25 Mar 2021 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WH0kFKojM/otohcS7eSZzBdtlMtjd7Jh1xCm+NpPHiA=;
        b=NHiCo9GaVAl88X5e3Gm8l96yLEvKO/gATx0UNug2J5E5cbExLekO+lLibAbgtiAbAG
         3col2ST9ZXYhSCbMYVJzdraYYSeEILlwiPHwgQ7zsMOTvL9Zt9RN+fDm68mnCv+7JzVw
         kMSdIS4Au9/FvoL/TY2xoiQIYOQE3q8PCvE3Ic5n8cgzsAzi8jR1uhs8whI5hTOXWW7E
         Mtt3NJJKcxihPptmiTAoG/CcTZrf77FiZoB+wpcTJ18THWRHCconGOPWHZXv0ThSFwGJ
         5QXiWJDmx7YtRbpvzjJlwPbiuyCgA6EMJ9kHP2szxJfff4pqSYLvAxFoiU728gWLQcSc
         I7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WH0kFKojM/otohcS7eSZzBdtlMtjd7Jh1xCm+NpPHiA=;
        b=F940kfdKdiwNWgBsMKI0SvGtq4NELEhweSQZaPt8ZLF4QFbZ0bMiHounixvN+sDnLH
         fsqBlwXhLS0zVmwkhHVDQMUxZ2Q37mcWkEcs4XzMx3FqIEYfqiIgZnVGqqD9+wwqTdIn
         UqkRypsf3MOnPmmTy0kXGbVJe+Nz8XvdMEKalIhZ+6QhRz7XQFUtyoM2/HeiguMNci5H
         iMPP2zj2YrsTdWhDBsAQoayWC990QVlM/5hh4xCFa3qBTWOHDfM/FWV/0P78qIjIYqCK
         R0WA/EwMPt+IcavjKdnSimi1m0tAwpqBMYTaCM/waksgrM5v5l0ujc530Fatgkd0vFaR
         nTOQ==
X-Gm-Message-State: AOAM531ycKCQEnMFUWEgpduHZmyV7TwlCs3JT2YgAyRR+/tVh+p7PXnJ
        TV8kNWS8ZFQxVxAIzc1cACiRsSnS+SF/GQ==
X-Google-Smtp-Source: ABdhPJx8U2sE4+dZveE3ZcjKWBryuBevxQJTOkCsyifPFJeQXjr/jsu/TeXxTInJJQ276znS1BBvsg==
X-Received: by 2002:ac5:ccc4:: with SMTP id j4mr6544380vkn.18.1616695942677;
        Thu, 25 Mar 2021 11:12:22 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (162.116.74.34.bc.googleusercontent.com. [34.74.116.162])
        by smtp.googlemail.com with ESMTPSA id p77sm890941vkf.39.2021.03.25.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 11:12:22 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 1/2] ext4: wipe filename upon file deletion
Date:   Thu, 25 Mar 2021 18:12:19 +0000
Message-Id: <20210325181220.1118705-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zero out filename field when file is deleted. Also, add mount option
nowipe_filename to disable this filename wipeout if desired.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/namei.c |  4 ++++
 fs/ext4/super.c | 11 ++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 826a56e3bbd2..8011418176bc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1247,6 +1247,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
 #define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow Direct Access */
 #define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing options only */
+#define EXT4_MOUNT2_WIPE_FILENAME       0x00000080 /* Wipe filename on del entry */
 
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..ae6ecabd4d97 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
 			else
 				de->inode = 0;
 			inode_inc_iversion(dir);
+
+			if (test_opt2(dir->i_sb, WIPE_FILENAME))
+				memset(de_del->name, 0, de_del->name_len);
+
 			return 0;
 		}
 		i += ext4_rec_len_from_disk(de->rec_len, blocksize);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..5e8737b3f171 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1688,7 +1688,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps,
+	Opt_prefetch_block_bitmaps, Opt_nowipe_filename,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1787,6 +1787,7 @@ static const match_table_t tokens = {
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_nombcache, "nombcache"},
+	{Opt_nowipe_filename, "nowipe_filename"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
@@ -2007,6 +2008,8 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_STRING},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_nowipe_filename, EXT4_MOUNT2_WIPE_FILENAME, MOPT_CLEAR | MOPT_2 |
+		MOPT_EXT4_ONLY},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
 #ifdef CONFIG_EXT4_DEBUG
@@ -2621,6 +2624,10 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	} else if (test_opt2(sb, DAX_INODE)) {
 		SEQ_OPTS_PUTS("dax=inode");
 	}
+
+	if (!test_opt2(sb, WIPE_FILENAME))
+		SEQ_OPTS_PUTS("nowipe_filename");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
@@ -4161,6 +4168,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (def_mount_opts & EXT4_DEFM_DISCARD)
 		set_opt(sb, DISCARD);
 
+	set_opt2(sb, WIPE_FILENAME);
+
 	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
 	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
 	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
-- 
2.31.0.291.g576ba9dcdaf-goog


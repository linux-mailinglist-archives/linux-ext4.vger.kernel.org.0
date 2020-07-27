Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6560522EB61
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgG0Lof (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgG0Lod (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:44:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 011DFB696;
        Mon, 27 Jul 2020 11:44:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 633A61E12D1; Mon, 27 Jul 2020 13:44:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6/6] ext4: Correctly restore system zone info when remount fails
Date:   Mon, 27 Jul 2020 13:44:29 +0200
Message-Id: <20200727114429.1478-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200727114429.1478-1-jack@suse.cz>
References: <20200727114429.1478-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When remounting filesystem fails late during remount handling and
block_validity mount option is also changed during the remount, we fail
to restore system zone information to a state matching the mount option.
This is mostly harmless, just the block validity checking will not match
the situation described by the mount option. Make sure these two are always
consistent.

Reported-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/block_validity.c |  8 --------
 fs/ext4/super.c          | 29 +++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 2d008c1b58f2..c54ba52f2dd4 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -220,14 +220,6 @@ int ext4_setup_system_zone(struct super_block *sb)
 	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
-	if (!test_opt(sb, BLOCK_VALIDITY)) {
-		if (sbi->system_blks)
-			ext4_release_system_zone(sb);
-		return 0;
-	}
-	if (sbi->system_blks)
-		return 0;
-
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
 	if (!system_blks)
 		return -ENOMEM;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8e055ec57a2c..37f09ecca0df 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4698,11 +4698,13 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	ext4_set_resv_clusters(sb);
 
-	err = ext4_setup_system_zone(sb);
-	if (err) {
-		ext4_msg(sb, KERN_ERR, "failed to initialize system "
-			 "zone (%d)", err);
-		goto failed_mount4a;
+	if (test_opt(sb, BLOCK_VALIDITY)) {
+		err = ext4_setup_system_zone(sb);
+		if (err) {
+			ext4_msg(sb, KERN_ERR, "failed to initialize system "
+				 "zone (%d)", err);
+			goto failed_mount4a;
+		}
 	}
 
 	ext4_ext_init(sb);
@@ -5653,9 +5655,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		ext4_register_li_request(sb, first_not_zeroed);
 	}
 
-	err = ext4_setup_system_zone(sb);
-	if (err)
-		goto restore_opts;
+	/*
+	 * Handle creation of system zone data early because it can fail.
+	 * Releasing of existing data is done when we are sure remount will
+	 * succeed.
+	 */
+	if (test_opt(sb, BLOCK_VALIDITY) && !sbi->system_blks) {
+		err = ext4_setup_system_zone(sb);
+		if (err)
+			goto restore_opts;
+	}
 
 	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
 		err = ext4_commit_super(sb, 1);
@@ -5677,6 +5686,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 #endif
+	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
+		ext4_release_system_zone(sb);
 
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
@@ -5692,6 +5703,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	sbi->s_commit_interval = old_opts.s_commit_interval;
 	sbi->s_min_batch_time = old_opts.s_min_batch_time;
 	sbi->s_max_batch_time = old_opts.s_max_batch_time;
+	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
+		ext4_release_system_zone(sb);
 #ifdef CONFIG_QUOTA
 	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
 	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-- 
2.16.4


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB925042F
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHXQ6T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 12:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbgHXQiz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741F422D3E;
        Mon, 24 Aug 2020 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287135;
        bh=bquUQtYQR6tiaYYUv+R3KHF3KhNMeapv/X03Nd/5SQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFyMm4+eYKTkMGPQIp8jW6IyeLW0WxMhKtyyraJZ/t6QfFFImy/bvJNsa2cePXd5H
         kP6zogLbXtJSUq4obyEFduqf+n04VCAxrAaPtu2sMtM/8x0nb+Pj1hE5/5n/OjiqpJ
         JcU4FsDu4ijbpCiCIVwnIF7kemFhTmPfUEQ54lXA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/21] ext4: correctly restore system zone info when remount fails
Date:   Mon, 24 Aug 2020 12:38:31 -0400
Message-Id: <20200824163845.606933-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163845.606933-1-sashal@kernel.org>
References: <20200824163845.606933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 0f5bde1db174f6c471f0bd27198575719dabe3e5 ]

When remounting filesystem fails late during remount handling and
block_validity mount option is also changed during the remount, we fail
to restore system zone information to a state matching the mount option.
This is mostly harmless, just the block validity checking will not match
the situation described by the mount option. Make sure these two are always
consistent.

Reported-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200728130437.7804-7-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/block_validity.c |  8 --------
 fs/ext4/super.c          | 29 +++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index d203cc935ff83..9d5a6bc98a71a 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -260,14 +260,6 @@ int ext4_setup_system_zone(struct super_block *sb)
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
index daabd7a2cee81..9ac34b6ae0731 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4473,11 +4473,13 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
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
@@ -5470,9 +5472,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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
@@ -5494,6 +5503,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 #endif
+	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
+		ext4_release_system_zone(sb);
 
 	/*
 	 * Some options can be enabled by ext4 and/or by VFS mount flag
@@ -5515,6 +5526,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	sbi->s_commit_interval = old_opts.s_commit_interval;
 	sbi->s_min_batch_time = old_opts.s_min_batch_time;
 	sbi->s_max_batch_time = old_opts.s_max_batch_time;
+	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->system_blks)
+		ext4_release_system_zone(sb);
 #ifdef CONFIG_QUOTA
 	sbi->s_jquota_fmt = old_opts.s_jquota_fmt;
 	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-- 
2.25.1


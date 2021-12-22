Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578347D039
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Dec 2021 11:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244254AbhLVKpa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 05:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240018AbhLVKpa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Dec 2021 05:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640169929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aI6J7S1bEQVDQksg9iAkieig/OwJe+3dI5oeRMFw3NQ=;
        b=N/LypM9hXDMf0t/wjzNLIOmw8LZwbreKh0dGF6BR6O69st2QG9k0hda3lbvRp6aefqp5DY
        HxExmORbZCWMraQPnV0S+BhNhgk3VWoRoEDkBpo4xrolx8KWYwdceohdBidIItb4Myq5eG
        500PkNK01ohXnP4mU+MDMjtfjo+HHuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-rvvyVPX7MdGIoxb_bx5LaQ-1; Wed, 22 Dec 2021 05:45:28 -0500
X-MC-Unique: rvvyVPX7MdGIoxb_bx5LaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A315081EE60;
        Wed, 22 Dec 2021 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA1A86ABBB;
        Wed, 22 Dec 2021 10:45:25 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: [PATCH 2/2] ext4: fix i_version handling on remount
Date:   Wed, 22 Dec 2021 11:45:17 +0100
Message-Id: <20211222104517.11187-2-lczerner@redhat.com>
In-Reply-To: <20211222104517.11187-1-lczerner@redhat.com>
References: <20211222104517.11187-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

i_version mount option is getting lost on remount. This is because the
'i_version' mount option differs from the util-linux mount option
'iversion', but it has exactly the same functionality. We have to
specifically notify the vfs that this is what we want by setting
appropriate flag in fc->sb_flags. Fix it and as a result we can remove
*flags argument from __ext4_remount(); do the same for
__ext4_fill_super().

In addition set out to deprecate ext4 specific 'i_version' mount option
in favor or 'iversion' by kernel version 5.20.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Fixes: cebe85d570cf ("ext4: switch to the new mount api")
---
 fs/ext4/super.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0fc511d16b6d..053b25c6b05c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2239,6 +2239,8 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
 		return 0;
 	case Opt_i_version:
+		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");
+		ext4_msg(NULL, KERN_WARNING, "Use iversion instead\n");
 		ctx_set_flags(ctx, SB_I_VERSION);
 		return 0;
 	case Opt_inlinecrypt:
@@ -2868,6 +2870,14 @@ static int ext4_apply_options(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags &= ~ctx->mask_s_flags;
 	sb->s_flags |= ctx->vals_s_flags;
 
+	/*
+	 * i_version differs from common mount option iversion so we have
+	 * to let vfs know that it was set, otherwise it would get cleared
+	 * on remount
+	 */
+	if (ctx->mask_s_flags & SB_I_VERSION)
+		fc->sb_flags |= SB_I_VERSION;
+
 #define APPLY(X) ({ if (ctx->spec & EXT4_SPEC_##X) sbi->X = ctx->X; })
 	APPLY(s_commit_interval);
 	APPLY(s_stripe);
@@ -4335,8 +4345,7 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
 	return NULL;
 }
 
-static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb,
-			     int silent)
+static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
 	struct ext4_super_block *es = NULL;
@@ -4356,6 +4365,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb,
 	int err = 0;
 	ext4_group_t first_not_zeroed;
 	struct ext4_fs_context *ctx = fc->fs_private;
+	int silent = fc->sb_flags & SB_SILENT;
 
 	/* Set defaults for the variables that will be set during parsing */
 	ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
@@ -5542,7 +5552,7 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ctx->spec & EXT4_SPEC_s_sb_block)
 		sbi->s_sb_block = ctx->s_sb_block;
 
-	ret = __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
+	ret = __ext4_fill_super(fc, sb);
 	if (ret < 0)
 		goto free_sbi;
 
@@ -6201,13 +6211,12 @@ struct ext4_mount_options {
 #endif
 };
 
-static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
-			  int *flags)
+static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
 	struct ext4_super_block *es;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	unsigned long old_sb_flags, vfs_flags;
+	unsigned long old_sb_flags;
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
@@ -6247,14 +6256,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
 		ctx->journal_ioprio =
 			sbi->s_journal->j_task->io_context->ioprio;
 
-	/*
-	 * Some options can be enabled by ext4 and/or by VFS mount flag
-	 * either way we need to make sure it matches in both *flags and
-	 * s_flags. Copy those selected flags from *flags to s_flags
-	 */
-	vfs_flags = SB_I_VERSION;
-	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
-
 	ext4_apply_options(fc, sb);
 
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
@@ -6308,13 +6309,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
 	/* Flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
-	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
+	if ((bool)(fc->sb_flags & SB_RDONLY) != sb_rdonly(sb)) {
 		if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED)) {
 			err = -EROFS;
 			goto restore_opts;
 		}
 
-		if (*flags & SB_RDONLY) {
+		if (fc->sb_flags & SB_RDONLY) {
 			err = sync_filesystem(sb);
 			if (err < 0)
 				goto restore_opts;
@@ -6462,13 +6463,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
-	/*
-	 * Some options can be enabled by ext4 and/or by VFS mount flag
-	 * either way we need to make sure it matches in both *flags and
-	 * s_flags. Copy those selected flags from s_flags to *flags
-	 */
-	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
-
 	return 0;
 
 restore_opts:
@@ -6500,7 +6494,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
 static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
-	int flags = fc->sb_flags;
 	int ret;
 
 	fc->s_fs_info = EXT4_SB(sb);
@@ -6509,7 +6502,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 	if (ret < 0)
 		return ret;
 
-	ret = __ext4_remount(fc, sb, &flags);
+	ret = __ext4_remount(fc, sb);
 	if (ret < 0)
 		return ret;
 
-- 
2.31.1


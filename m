Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE61BC59B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgD1Qp6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24859 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbgD1Qp5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXRaS5zaKE8XGzSIrU56VmehDJCzTKbV1g0OGeIwe5E=;
        b=CIA1iCU6u+OkQ/vRbIOZqWKVWQdPqCXcf4sdh5p3roHFJW+g9p5qwkk+zRkCErp3Jx5juV
        HZjuL6MJoYeqZWkJl5uKWsJfzOBwKGSfpZt+sxEHL87scu00mNYliZe4fvmWbcDuW5lo4f
        BsmkUGzV+BlfzdNxzOgaDA2aBFGjYzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-aG5FumcpOEmoYbu7qmJlIw-1; Tue, 28 Apr 2020 12:45:54 -0400
X-MC-Unique: aG5FumcpOEmoYbu7qmJlIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAAA8835B42;
        Tue, 28 Apr 2020 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAACC1002388;
        Tue, 28 Apr 2020 16:45:52 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 07/17] ext4: check ext2/3 compatibility outside handle_mount_opt()
Date:   Tue, 28 Apr 2020 18:45:26 +0200
Message-Id: <20200428164536.462-8-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so move ext2/3 compatibility check outside handle_mount_opt().
Unfortunately we will lose the ability to show exactly which option is
not compatible.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ae0ef04b3be4..5317ab324033 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -89,8 +89,8 @@ static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
 static int ext4_validate_options(struct fs_context *fc);
-static int ext4_check_quota_consistency(struct fs_context *fc,
-					struct super_block *sb);
+static int ext4_check_opt_consistency(struct fs_context *fc,
+				      struct super_block *sb);
 static void ext4_apply_quota_options(struct fs_context *fc,
 				     struct super_block *sb);
=20
@@ -1931,6 +1931,7 @@ struct ext4_fs_context {
 	unsigned short	qname_spec;
 	unsigned long	journal_devnum;
 	unsigned int	journal_ioprio;
+	unsigned int	opt_flags;	/* MOPT flags */
 };
=20
 #ifdef CONFIG_QUOTA
@@ -2050,25 +2051,14 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 		if (token =3D=3D m->token)
 			break;
=20
+	ctx->opt_flags |=3D m->flags;
+
 	if (m->token =3D=3D Opt_err) {
 		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
 			 "or missing value", param->key);
 		return -EINVAL;
 	}
=20
-	if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
-		ext4_msg(NULL, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext2",
-			 param->string);
-		return -EINVAL;
-	}
-	if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
-		ext4_msg(NULL, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext3",
-			 param->string);
-		return -EINVAL;
-	}
-
 	if (m->flags & MOPT_EXPLICIT) {
 		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
 			set_opt2(sb, EXPLICIT_DELALLOC);
@@ -2305,7 +2295,7 @@ static int parse_options(char *options, struct supe=
r_block *sb,
 	if (ret < 0)
 		return 0;
=20
-	ret =3D ext4_check_quota_consistency(&fc, sb);
+	ret =3D ext4_check_opt_consistency(&fc, sb);
 	if (ret < 0)
 		return 0;
=20
@@ -2398,6 +2388,25 @@ static int ext4_check_quota_consistency(struct fs_=
context *fc,
 #endif
 }
=20
+static int ext4_check_opt_consistency(struct fs_context *fc,
+				      struct super_block *sb)
+{
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+
+	if ((ctx->opt_flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Mount option(s) incompatible with ext2");
+		return -EINVAL;
+	}
+	if ((ctx->opt_flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Mount option(s) incompatible with ext3");
+		return -EINVAL;
+	}
+
+	return ext4_check_quota_consistency(fc, sb);
+}
+
 static int ext4_validate_options(struct fs_context *fc)
 {
 	struct ext4_sb_info *sbi =3D fc->s_fs_info;
--=20
2.21.1


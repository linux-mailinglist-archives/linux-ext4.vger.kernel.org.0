Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC861BC5A2
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgD1QqG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728335AbgD1QqG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqFcUeESBHvk57xWRzVAWI9c7p4HOTfwGhjSrI5Yheo=;
        b=FkyWb57kyovO6eK09A2lJvRdVh3xFwLUQkEtie6qo6ouuA5u0Ej8h1ijRtx79q1UT06lEE
        bCJ/56elJ7dPr2hGG6Ts+g5kT+Fbe1HIyqRoAc09ojKCnzkxhbRvLdlYgAiTnUIm/9AGV8
        DFz5gWte5/4grCu7XelvHZeT1GzDBJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-76Qetu4xNXmgtCMc6yXb7Q-1; Tue, 28 Apr 2020 12:46:01 -0400
X-MC-Unique: 76Qetu4xNXmgtCMc6yXb7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CD36100A61F;
        Tue, 28 Apr 2020 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA1C1000322;
        Tue, 28 Apr 2020 16:45:59 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 12/17] ext4: refactor ext4_remount()
Date:   Tue, 28 Apr 2020 18:45:31 +0200
Message-Id: <20200428164536.462-13-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Refactor ext4_remount() so that we can parse mount options separately.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 62 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 729a07c298e2..a340b4943544 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5926,8 +5926,10 @@ struct ext4_mount_options {
 #endif
 };
=20
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
+static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
+			  int *flags)
 {
+	struct ext4_fs_context *ctx =3D fc->fs_private;
 	struct ext4_super_block *es;
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	unsigned long old_sb_flags;
@@ -5940,10 +5942,6 @@ static int ext4_remount(struct super_block *sb, in=
t *flags, char *data)
 	int i, j;
 	char *to_free[EXT4_MAXQUOTAS];
 #endif
-	char *orig_data =3D kstrdup(data, GFP_KERNEL);
-
-	if (data && !orig_data)
-		return -ENOMEM;
=20
 	/* Store the original options */
 	old_sb_flags =3D sb->s_flags;
@@ -5964,7 +5962,6 @@ static int ext4_remount(struct super_block *sb, int=
 *flags, char *data)
 			if (!old_opts.s_qf_names[i]) {
 				for (j =3D 0; j < i; j++)
 					kfree(old_opts.s_qf_names[j]);
-				kfree(orig_data);
 				return -ENOMEM;
 			}
 		} else
@@ -5973,9 +5970,10 @@ static int ext4_remount(struct super_block *sb, in=
t *flags, char *data)
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 		journal_ioprio =3D sbi->s_journal->j_task->io_context->ioprio;
=20
-	err =3D parse_apply_options(data, sb, NULL, &journal_ioprio, 1);
-	if (err < 0)
-		goto restore_opts;
+	if (ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+		journal_ioprio =3D ctx->journal_ioprio;
+
+	ext4_apply_options(fc, sb);
=20
 	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) ^
 	    test_opt(sb, JOURNAL_CHECKSUM)) {
@@ -6172,8 +6170,7 @@ static int ext4_remount(struct super_block *sb, int=
 *flags, char *data)
 #endif
=20
 	*flags =3D (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
-	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
-	kfree(orig_data);
+	ext4_msg(sb, KERN_INFO, "re-mounted.");
 	return 0;
=20
 restore_opts:
@@ -6195,10 +6192,51 @@ static int ext4_remount(struct super_block *sb, i=
nt *flags, char *data)
 	for (i =3D 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(to_free[i]);
 #endif
-	kfree(orig_data);
 	return err;
 }
=20
+static int ext4_remount(struct super_block *sb, int *flags, char *data)
+{
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	struct ext4_fs_context ctx;
+	struct fs_context fc;
+	char *orig_data;
+	int ret;
+
+	orig_data =3D kstrdup(data, GFP_KERNEL);
+	if (data && !orig_data)
+		return -ENOMEM;
+
+	memset(&fc, 0, sizeof(fc));
+	memset(&ctx, 0, sizeof(ctx));
+
+	fc.fs_private =3D &ctx;
+	fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+	fc.s_fs_info =3D sbi;
+
+	ret =3D parse_options(&fc, (char *) data);
+	if (ret < 0)
+		goto err_out;
+
+	ret =3D ext4_check_opt_consistency(&fc, sb);
+	if (ret < 0)
+		goto err_out;
+
+	ret =3D __ext4_remount(&fc, sb, flags);
+	if (ret < 0)
+		goto err_out;
+
+	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
+	cleanup_ctx(&ctx);
+	kfree(orig_data);
+	return 0;
+
+err_out:
+	cleanup_ctx(&ctx);
+	kfree(orig_data);
+	return ret;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_statfs_project(struct super_block *sb,
 			       kprojid_t projid, struct kstatfs *buf)
--=20
2.21.1


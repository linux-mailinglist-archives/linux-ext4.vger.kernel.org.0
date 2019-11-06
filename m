Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37198F13A6
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfKFKPj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54970 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731222AbfKFKPj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tASMyTn3iDx6KanL4j5gvaTNnbhhGJNqEPX7SwlHmDM=;
        b=HWKxi4gEu/2+E5xXNHhezBT//3FauzcPQdKSExvcl/IdnqMtg5Jb+qGAshEPhlAsC6A7iq
        0aZn1vjAak01dGT3PRKvUoGMJ6eeUQOLK4W0fMJo0nLYS/8JLFjVq/YtCP9OfqQzZr3luD
        hEVmuHEAFtWqxQAeWhyIRrLUNl7RMYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-FRJK08NUNKKAV7dDpu8DHg-1; Wed, 06 Nov 2019 05:15:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A619107ACC4;
        Wed,  6 Nov 2019 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 440DE19481;
        Wed,  6 Nov 2019 10:15:35 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 12/17] ext4: refactor ext4_remount()
Date:   Wed,  6 Nov 2019 11:14:52 +0100
Message-Id: <20191106101457.11237-13-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FRJK08NUNKKAV7dDpu8DHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Refactor ext4_remount() so that we can parse mount options separately.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 62 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 76f7d742de8e..f863fddc3df3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5801,8 +5801,10 @@ struct ext4_mount_options {
 #endif
 };
=20
-static int ext4_remount(struct super_block *sb, int *flags, char *data)
+static int __ext4_remount(struct fs_context *fc, struct super_block *sb,
+=09=09=09  int *flags)
 {
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
 =09struct ext4_super_block *es;
 =09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 =09unsigned long old_sb_flags;
@@ -5815,10 +5817,6 @@ static int ext4_remount(struct super_block *sb, int =
*flags, char *data)
 =09int i, j;
 =09char *to_free[EXT4_MAXQUOTAS];
 #endif
-=09char *orig_data =3D kstrdup(data, GFP_KERNEL);
-
-=09if (data && !orig_data)
-=09=09return -ENOMEM;
=20
 =09/* Store the original options */
 =09old_sb_flags =3D sb->s_flags;
@@ -5839,7 +5837,6 @@ static int ext4_remount(struct super_block *sb, int *=
flags, char *data)
 =09=09=09if (!old_opts.s_qf_names[i]) {
 =09=09=09=09for (j =3D 0; j < i; j++)
 =09=09=09=09=09kfree(old_opts.s_qf_names[j]);
-=09=09=09=09kfree(orig_data);
 =09=09=09=09return -ENOMEM;
 =09=09=09}
 =09=09} else
@@ -5848,10 +5845,10 @@ static int ext4_remount(struct super_block *sb, int=
 *flags, char *data)
 =09if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 =09=09journal_ioprio =3D sbi->s_journal->j_task->io_context->ioprio;
=20
-=09if (!parse_apply_options(data, sb, NULL, &journal_ioprio, 1)) {
-=09=09err =3D -EINVAL;
-=09=09goto restore_opts;
-=09}
+=09if (ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO)
+=09=09journal_ioprio =3D ctx->journal_ioprio;
+
+=09ext4_apply_options(fc, sb);
=20
 =09ext4_clamp_want_extra_isize(sb);
=20
@@ -6050,8 +6047,6 @@ static int ext4_remount(struct super_block *sb, int *=
flags, char *data)
 #endif
=20
 =09*flags =3D (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
-=09ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
-=09kfree(orig_data);
 =09return 0;
=20
 restore_opts:
@@ -6073,10 +6068,51 @@ static int ext4_remount(struct super_block *sb, int=
 *flags, char *data)
 =09for (i =3D 0; i < EXT4_MAXQUOTAS; i++)
 =09=09kfree(to_free[i]);
 #endif
-=09kfree(orig_data);
 =09return err;
 }
=20
+static int ext4_remount(struct super_block *sb, int *flags, char *data)
+{
+=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+=09struct ext4_fs_context ctx;
+=09struct fs_context fc;
+=09char *orig_data;
+=09int ret;
+
+=09orig_data =3D kstrdup(data, GFP_KERNEL);
+=09if (data && !orig_data)
+=09=09return -ENOMEM;
+
+=09memset(&fc, 0, sizeof(fc));
+=09memset(&ctx, 0, sizeof(ctx));
+
+=09fc.fs_private =3D &ctx;
+=09fc.purpose =3D FS_CONTEXT_FOR_RECONFIGURE;
+=09fc.s_fs_info =3D sbi;
+
+=09ret =3D parse_options(&fc, (char *) data);
+=09if (ret < 0)
+=09=09goto err_out;
+
+=09ret =3D ext4_check_opt_consistency(&fc, sb);
+=09if (ret < 0)
+=09=09goto err_out;
+
+=09ret =3D __ext4_remount(&fc, sb, flags);
+=09if (ret < 0)
+=09=09goto err_out;
+
+=09ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
+=09cleanup_ctx(&ctx);
+=09kfree(orig_data);
+=09return 0;
+
+err_out:
+=09cleanup_ctx(&ctx);
+=09kfree(orig_data);
+=09return ret;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_statfs_project(struct super_block *sb,
 =09=09=09       kprojid_t projid, struct kstatfs *buf)
--=20
2.21.0


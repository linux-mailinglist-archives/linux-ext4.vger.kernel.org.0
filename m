Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213CA1BC5A6
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgD1QqP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728084AbgD1QqP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oepfKVLKddrn5otRdm+rrLaKjnTzrjQ8vifPYII61n4=;
        b=Q0NAICocMnhrNTx+X9WDmxV+uh3YN30sXBthEOTKLKTPzGbukuIC6/dwYuLWkzURIg54tW
        JyMEUa+RV0fcDJZ1sLCUzxA2Qdt4HFRyY7KAuXLhFg3lPdia/oG7+L/xbYOrA5H4/1uogq
        JvY3vW7L4G53vrADYnMWXUKZhGZZDWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-FNxCINiyMVOLbWTFcsizog-1; Tue, 28 Apr 2020 12:46:10 -0400
X-MC-Unique: FNxCINiyMVOLbWTFcsizog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F47E800D24;
        Tue, 28 Apr 2020 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81D721002388;
        Tue, 28 Apr 2020 16:46:08 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 16/17] ext4: switch to the new mount API
Date:   Tue, 28 Apr 2020 18:45:35 +0200
Message-Id: <20200428164536.462-17-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 41075fdd076a..d52abb87ff80 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -96,6 +96,8 @@ static int ext4_parse_param(struct fs_context *fc, stru=
ct fs_parameter *param);
 static int ext4_get_tree(struct fs_context *fc);
 static int ext4_reconfigure(struct fs_context *fc);
 static void ext4_fc_free(struct fs_context *fc);
+static int ext4_init_fs_context(struct fs_context *fc);
+static const struct fs_parameter_spec ext4_param_specs[];
=20
 /*
  * Lock ordering
@@ -134,11 +136,12 @@ static const struct fs_context_operations ext4_cont=
ext_ops =3D {
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defin=
ed(CONFIG_EXT4_USE_FOR_EXT2)
 static struct file_system_type ext2_fs_type =3D {
-	.owner		=3D THIS_MODULE,
-	.name		=3D "ext2",
-	.mount		=3D ext4_mount,
-	.kill_sb	=3D kill_block_super,
-	.fs_flags	=3D FS_REQUIRES_DEV,
+	.owner			=3D THIS_MODULE,
+	.name			=3D "ext2",
+	.init_fs_context	=3D ext4_init_fs_context,
+	.parameters		=3D ext4_param_specs,
+	.kill_sb		=3D kill_block_super,
+	.fs_flags		=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
@@ -149,11 +152,12 @@ MODULE_ALIAS("ext2");
=20
=20
 static struct file_system_type ext3_fs_type =3D {
-	.owner		=3D THIS_MODULE,
-	.name		=3D "ext3",
-	.mount		=3D ext4_mount,
-	.kill_sb	=3D kill_block_super,
-	.fs_flags	=3D FS_REQUIRES_DEV,
+	.owner			=3D THIS_MODULE,
+	.name			=3D "ext3",
+	.init_fs_context	=3D ext4_init_fs_context,
+	.parameters		=3D ext4_param_specs,
+	.kill_sb		=3D kill_block_super,
+	.fs_flags		=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
@@ -1501,7 +1505,6 @@ static const struct super_operations ext4_sops =3D =
{
 	.freeze_fs	=3D ext4_freeze,
 	.unfreeze_fs	=3D ext4_unfreeze,
 	.statfs		=3D ext4_statfs,
-	.remount_fs	=3D ext4_remount,
 	.show_options	=3D ext4_show_options,
 #ifdef CONFIG_QUOTA
 	.quota_read	=3D ext4_quota_read,
@@ -1973,6 +1976,20 @@ static void ext4_fc_free(struct fs_context *fc)
 	kfree(ctx);
 }
=20
+int ext4_init_fs_context(struct fs_context *fc)
+{
+	struct xfs_fs_context	*ctx;
+
+	ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private =3D ctx;
+	fc->ops =3D &ext4_context_ops;
+
+	return 0;
+}
+
 #ifdef CONFIG_QUOTA
 /*
  * Note the name of the specified quota file.
@@ -6826,11 +6843,12 @@ static inline int ext3_feature_set_ok(struct supe=
r_block *sb)
 }
=20
 static struct file_system_type ext4_fs_type =3D {
-	.owner		=3D THIS_MODULE,
-	.name		=3D "ext4",
-	.mount		=3D ext4_mount,
-	.kill_sb	=3D kill_block_super,
-	.fs_flags	=3D FS_REQUIRES_DEV,
+	.owner			=3D THIS_MODULE,
+	.name			=3D "ext4",
+	.init_fs_context	=3D ext4_init_fs_context,
+	.parameters		=3D ext4_param_specs,
+	.kill_sb		=3D kill_block_super,
+	.fs_flags		=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext4");
=20
--=20
2.21.1


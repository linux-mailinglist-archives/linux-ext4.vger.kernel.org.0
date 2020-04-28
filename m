Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A31BC5A0
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgD1QqD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59213 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgD1QqC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DUcBTWZBLhA4jb/shFPvP3lSnDnt9YzoZmavUdsLqw=;
        b=Jb4GZrLb1HoZInzdLBNhOK20rXiu9ViQT7eNJbwMMRYqSYJI3L7RlV+CgN0tvx/VZbeZfB
        qefbRUrg6OvtJGXe2cqS/DhgX8Gg7eOThwUxQrTSW0H9CD8E8eG25BD2BQtRDLrEfZdUOZ
        48YkTYHx6on8SsCZygSEwkNztHvPrs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-7Xfc0J2COzGyCdvNVaZ2tw-1; Tue, 28 Apr 2020 12:46:00 -0400
X-MC-Unique: 7Xfc0J2COzGyCdvNVaZ2tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2BCF107ACCD;
        Tue, 28 Apr 2020 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D1631002388;
        Tue, 28 Apr 2020 16:45:57 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 11/17] ext4: add ext4_get_tree for the new mount API
Date:   Tue, 28 Apr 2020 18:45:30 +0200
Message-Id: <20200428164536.462-12-lczerner@redhat.com>
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
 fs/ext4/super.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81238dddc3b7..729a07c298e2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -93,6 +93,7 @@ static int ext4_check_opt_consistency(struct fs_context=
 *fc,
 				      struct super_block *sb);
 static void ext4_apply_options(struct fs_context *fc, struct super_block=
 *sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *=
param);
+static int ext4_get_tree(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -124,6 +125,7 @@ static int ext4_parse_param(struct fs_context *fc, st=
ruct fs_parameter *param);
=20
 static const struct fs_context_operations ext4_context_ops =3D {
 	.parse_param	=3D ext4_parse_param,
+	.get_tree	=3D ext4_get_tree,
 };
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defin=
ed(CONFIG_EXT4_USE_FOR_EXT2)
@@ -5340,6 +5342,42 @@ static int ext4_fill_super(struct super_block *sb,=
 void *data, int silent)
 	return ret;
 }
=20
+static int ext4_fill_super_fc(struct super_block *sb, struct fs_context =
*fc)
+{
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+	struct ext4_sb_info *sbi;
+	int ret;
+
+	sbi =3D ext4_alloc_sbi(sb);
+	if (!sbi)
+		return -ENOMEM;
+
+	fc->s_fs_info =3D sbi;
+
+	/* Cleanup superblock name */
+	strreplace(sb->s_id, '/', '!');
+
+	sbi->s_sb_block =3D 1;	/* Default super block location */
+	if (ctx->spec & EXT4_SPEC_s_sb_block)
+		sbi->s_sb_block =3D ctx->s_sb_block;
+
+	ret =3D __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
+	if (ret < 0)
+		goto free_sbi;
+
+	return 0;
+
+free_sbi:
+	ext4_free_sbi(sbi);
+	fc->s_fs_info =3D NULL;
+	return ret;
+}
+
+static int ext4_get_tree(struct fs_context *fc)
+{
+	return get_tree_bdev(fc, ext4_fill_super_fc);
+}
+
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
--=20
2.21.1


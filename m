Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11D9F13A8
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfKFKPl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731222AbfKFKPl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8dEypndgxBpJ0vbE8cClx22QtXvHwp0hPHLbegwYnU=;
        b=SZBV6iTeZ9nPVEw/zDADWn+DjAkV/IwRxzjO8MEtK3MpbCXy4TclD2BshmrT7iTEu2wVZH
        up+MEKqVZ5sqZjg6MIbR0MJJxq2NKhjOKrifHs2VWRRBC6aP0bF8BuWq5587++jMAhOQ4g
        TMt6TouupSnNxHiW+Y+t6mvc8BziB+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-0N97BD7WOlC-12v5OdsFjQ-1; Wed, 06 Nov 2019 05:15:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B0B800C72;
        Wed,  6 Nov 2019 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCC7B2706E;
        Wed,  6 Nov 2019 10:15:33 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 11/17] ext4: add ext4_get_tree for the new mount API
Date:   Wed,  6 Nov 2019 11:14:51 +0100
Message-Id: <20191106101457.11237-12-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 0N97BD7WOlC-12v5OdsFjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
index dabb55bb999f..76f7d742de8e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -93,6 +93,7 @@ static int ext4_check_opt_consistency(struct fs_context *=
fc,
 =09=09=09=09      struct super_block *sb);
 static void ext4_apply_options(struct fs_context *fc, struct super_block *=
sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *pa=
ram);
+static int ext4_get_tree(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -124,6 +125,7 @@ static int ext4_parse_param(struct fs_context *fc, stru=
ct fs_parameter *param);
=20
 static const struct fs_context_operations ext4_context_ops =3D {
 =09.parse_param=09=3D ext4_parse_param,
+=09.get_tree=09=3D ext4_get_tree,
 };
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined=
(CONFIG_EXT4_USE_FOR_EXT2)
@@ -5215,6 +5217,42 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 =09return ret;
 }
=20
+static int ext4_fill_super_fc(struct super_block *sb, struct fs_context *f=
c)
+{
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09struct ext4_sb_info *sbi;
+=09int ret;
+
+=09sbi =3D ext4_alloc_sbi(sb);
+=09if (!sbi)
+=09=09return -ENOMEM;
+
+=09fc->s_fs_info =3D sbi;
+
+=09/* Cleanup superblock name */
+=09strreplace(sb->s_id, '/', '!');
+
+=09sbi->s_sb_block =3D 1;=09/* Default super block location */
+=09if (ctx->spec & EXT4_SPEC_s_sb_block)
+=09=09sbi->s_sb_block =3D ctx->s_sb_block;
+
+=09ret =3D __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
+=09if (ret < 0)
+=09=09goto free_sbi;
+
+=09return 0;
+
+free_sbi:
+=09ext4_free_sbi(sbi);
+=09fc->s_fs_info =3D NULL;
+=09return ret;
+}
+
+static int ext4_get_tree(struct fs_context *fc)
+{
+=09return get_tree_bdev(fc, ext4_fill_super_fc);
+}
+
 /*
  * Setup any per-fs journal parameters now.  We'll do this both on
  * initial mount, once the journal has been initialised but before we've
--=20
2.21.0


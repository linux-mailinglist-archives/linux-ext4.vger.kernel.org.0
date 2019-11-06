Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A7F13AA
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfKFKPp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731322AbfKFKPo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNoK5utgfrXbFUwG46SwmYI7lRkrGCQAE8BloN9BUhY=;
        b=Uvm5imEAXF97mYGb4TbxKSySbgUi5zKwHY2H2zixOX9Eb3KoUhUhLSWJQdIAHdlDyfCG9L
        Ccu3BXuTcgVfTGEBaNQrxKAf59lsoD1LieBwc7QZWUh0msu5vZ23mx8/LqOH5zR1tt4hTf
        8JBcjckBlTDL1umN/aAoukLw9sAdQFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-MZh5LyMhNHWuhur_VTpx0w-1; Wed, 06 Nov 2019 05:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 271BB107ACC3;
        Wed,  6 Nov 2019 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1860E19481;
        Wed,  6 Nov 2019 10:15:37 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 14/17] ext4: add ext4_fc_free for the new mount API
Date:   Wed,  6 Nov 2019 11:14:54 +0100
Message-Id: <20191106101457.11237-15-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: MZh5LyMhNHWuhur_VTpx0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 471fe7b6ad9e..815f86f1e047 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -95,6 +95,7 @@ static void ext4_apply_options(struct fs_context *fc, str=
uct super_block *sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *pa=
ram);
 static int ext4_get_tree(struct fs_context *fc);
 static int ext4_reconfigure(struct fs_context *fc);
+static void ext4_fc_free(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -128,6 +129,7 @@ static const struct fs_context_operations ext4_context_=
ops =3D {
 =09.parse_param=09=3D ext4_parse_param,
 =09.get_tree=09=3D ext4_get_tree,
 =09.reconfigure=09=3D ext4_reconfigure,
+=09.free=09=09=3D ext4_fc_free,
 };
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined=
(CONFIG_EXT4_USE_FOR_EXT2)
@@ -1872,6 +1874,19 @@ struct ext4_fs_context {
 =09ext4_fsblk_t=09s_sb_block;
 };
=20
+static void ext4_fc_free(struct fs_context *fc)
+{
+=09struct ext4_fs_context *ctx =3D fc->fs_private;
+=09int i;
+
+=09if (!ctx)
+=09=09return;
+
+=09for (i =3D 0; i < EXT4_MAXQUOTAS; i++)
+=09=09kfree(ctx->s_qf_names[i]);
+=09kfree(ctx);
+}
+
 #ifdef CONFIG_QUOTA
 /*
  * Note the name of the specified quota file.
--=20
2.21.0


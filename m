Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63597F13AB
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfKFKPp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731379AbfKFKPp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrlLK7Ngxg6zxIoc9JfndcdSxg7IksJlq5gPjAkQgv8=;
        b=L4vQSzdReTUS8g0kC0mtTLrY1Vn8t+VRBiVlMUY2WknJqDW1bKaxNwq+MPzIXvUrRwYWvf
        4vOdLBAQBwUo9ATL1hhfjcMc+A0jPMdnRySJNL2NBr5Ib5WGIG55acyWvrRTizMG1F+dKU
        xY7cEHSYzKpOmcHK6gtRHsbQS0YunL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-S1VRS_uOOLqxsnNv6D1CRQ-1; Wed, 06 Nov 2019 05:15:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A4242A3;
        Wed,  6 Nov 2019 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78A5D19481;
        Wed,  6 Nov 2019 10:15:39 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 15/17] ext4: switch to the new mount API
Date:   Wed,  6 Nov 2019 11:14:55 +0100
Message-Id: <20191106101457.11237-16-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: S1VRS_uOOLqxsnNv6D1CRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
index 815f86f1e047..f2f17c11b616 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -96,6 +96,8 @@ static int ext4_parse_param(struct fs_context *fc, struct=
 fs_parameter *param);
 static int ext4_get_tree(struct fs_context *fc);
 static int ext4_reconfigure(struct fs_context *fc);
 static void ext4_fc_free(struct fs_context *fc);
+static int ext4_init_fs_context(struct fs_context *fc);
+static const struct fs_parameter_description ext4_fs_parameters;
=20
 /*
  * Lock ordering
@@ -134,11 +136,12 @@ static const struct fs_context_operations ext4_contex=
t_ops =3D {
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined=
(CONFIG_EXT4_USE_FOR_EXT2)
 static struct file_system_type ext2_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "ext2",
-=09.mount=09=09=3D ext4_mount,
-=09.kill_sb=09=3D kill_block_super,
-=09.fs_flags=09=3D FS_REQUIRES_DEV,
+=09.owner=09=09=09=3D THIS_MODULE,
+=09.name=09=09=09=3D "ext2",
+=09.init_fs_context=09=3D ext4_init_fs_context,
+=09.parameters=09=09=3D &ext4_fs_parameters,
+=09.kill_sb=09=09=3D kill_block_super,
+=09.fs_flags=09=09=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
@@ -149,11 +152,12 @@ MODULE_ALIAS("ext2");
=20
=20
 static struct file_system_type ext3_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "ext3",
-=09.mount=09=09=3D ext4_mount,
-=09.kill_sb=09=3D kill_block_super,
-=09.fs_flags=09=3D FS_REQUIRES_DEV,
+=09.owner=09=09=09=3D THIS_MODULE,
+=09.name=09=09=09=3D "ext3",
+=09.init_fs_context=09=3D ext4_init_fs_context,
+=09.parameters=09=09=3D &ext4_fs_parameters,
+=09.kill_sb=09=09=3D kill_block_super,
+=09.fs_flags=09=09=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
@@ -1439,7 +1443,6 @@ static const struct super_operations ext4_sops =3D {
 =09.freeze_fs=09=3D ext4_freeze,
 =09.unfreeze_fs=09=3D ext4_unfreeze,
 =09.statfs=09=09=3D ext4_statfs,
-=09.remount_fs=09=3D ext4_remount,
 =09.show_options=09=3D ext4_show_options,
 #ifdef CONFIG_QUOTA
 =09.quota_read=09=3D ext4_quota_read,
@@ -1887,6 +1890,20 @@ static void ext4_fc_free(struct fs_context *fc)
 =09kfree(ctx);
 }
=20
+int ext4_init_fs_context(struct fs_context *fc)
+{
+=09struct xfs_fs_context=09*ctx;
+
+=09ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
+=09if (!ctx)
+=09=09return -ENOMEM;
+
+=09fc->fs_private =3D ctx;
+=09fc->ops =3D &ext4_context_ops;
+
+=09return 0;
+}
+
 #ifdef CONFIG_QUOTA
 /*
  * Note the name of the specified quota file.
@@ -6714,11 +6731,12 @@ static inline int ext3_feature_set_ok(struct super_=
block *sb)
 }
=20
 static struct file_system_type ext4_fs_type =3D {
-=09.owner=09=09=3D THIS_MODULE,
-=09.name=09=09=3D "ext4",
-=09.mount=09=09=3D ext4_mount,
-=09.kill_sb=09=3D kill_block_super,
-=09.fs_flags=09=3D FS_REQUIRES_DEV,
+=09.owner=09=09=09=3D THIS_MODULE,
+=09.name=09=09=09=3D "ext4",
+=09.init_fs_context=09=3D ext4_init_fs_context,
+=09.parameters=09=09=3D &ext4_fs_parameters,
+=09.kill_sb=09=09=3D kill_block_super,
+=09.fs_flags=09=09=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext4");
=20
--=20
2.21.0


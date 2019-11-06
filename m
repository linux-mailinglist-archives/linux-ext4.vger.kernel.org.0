Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB3F13A7
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbfKFKPl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58201 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731321AbfKFKPk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VabUfITa9SNdnOJaoKIgFS4+98jymX8GpT74VkSnVRE=;
        b=OHe91FNiwqvveoHNnXgLl/MkUsyGkudnzqOUd2zS7cHDoYgoN0MToKeRyGKLR8iJjSaape
        dFzy2bVt1XW8mLXFhAQipSikOo5ltjTCOjSntF1n7Tyyr+FWZCEjv/SQ3cErvD+TdWe37i
        D/dF+RV0r+lZt8KzkL8K8IlWuStUWsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-sB1J4SC_OGudPwe967JkWA-1; Wed, 06 Nov 2019 05:15:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF2AD800C72;
        Wed,  6 Nov 2019 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A98BB19756;
        Wed,  6 Nov 2019 10:15:36 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 13/17] ext4: add ext4_reconfigure for the new mount API
Date:   Wed,  6 Nov 2019 11:14:53 +0100
Message-Id: <20191106101457.11237-14-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sB1J4SC_OGudPwe967JkWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f863fddc3df3..471fe7b6ad9e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -94,6 +94,7 @@ static int ext4_check_opt_consistency(struct fs_context *=
fc,
 static void ext4_apply_options(struct fs_context *fc, struct super_block *=
sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *pa=
ram);
 static int ext4_get_tree(struct fs_context *fc);
+static int ext4_reconfigure(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -126,6 +127,7 @@ static int ext4_get_tree(struct fs_context *fc);
 static const struct fs_context_operations ext4_context_ops =3D {
 =09.parse_param=09=3D ext4_parse_param,
 =09.get_tree=09=3D ext4_get_tree,
+=09.reconfigure=09=3D ext4_reconfigure,
 };
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined=
(CONFIG_EXT4_USE_FOR_EXT2)
@@ -6113,6 +6115,25 @@ static int ext4_remount(struct super_block *sb, int =
*flags, char *data)
 =09return ret;
 }
=20
+static int ext4_reconfigure(struct fs_context *fc)
+{
+=09struct super_block *sb =3D fc->root->d_sb;
+=09int flags =3D fc->sb_flags;
+=09int ret;
+
+=09fc->s_fs_info =3D EXT4_SB(sb);
+
+=09ret =3D ext4_check_opt_consistency(fc, sb);
+=09if (ret < 0)
+=09=09return ret;
+
+=09ret =3D __ext4_remount(fc, sb, &flags);
+=09if (ret < 0)
+=09=09return ret;
+
+=09return 0;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_statfs_project(struct super_block *sb,
 =09=09=09       kprojid_t projid, struct kstatfs *buf)
--=20
2.21.0


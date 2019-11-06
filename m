Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8FF13A9
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfKFKPm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22107 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731322AbfKFKPl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mzRu7SztJ8mlrz851C8/b5ZET6CU7gI/vVeGSi7elA=;
        b=P3BG6P6Ree/WSUfUf9+jqHG+C21pIA/cLkPqL4r302STtlP6wdZKxcEiR+jKv5Q0UYneKN
        IZXojMjod5qD/r7hdnQls5zmireFqE81mIoRHAgWpv5QeDFB9S95GaEy3mNvY09nugsDpg
        2wu4/Eyszpy8lhbRao/zulptKBweGfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-L6eCn_-ONr2UfEdrRr63vg-1; Wed, 06 Nov 2019 05:15:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 620BE107ACC3;
        Wed,  6 Nov 2019 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03DC919481;
        Wed,  6 Nov 2019 10:15:30 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 10/17] ext4: clean up return values in handle_mount_opt()
Date:   Wed,  6 Nov 2019 11:14:50 +0100
Message-Id: <20191106101457.11237-11-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: L6eCn_-ONr2UfEdrRr63vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Clean up return values in handle_mount_opt() and renabe to function to
ext4_parse_param()

Now we can use is in fs_context_operations as .parse_param.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 417a929cb0ab..dabb55bb999f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -92,6 +92,7 @@ static int ext4_validate_options(struct fs_context *fc);
 static int ext4_check_opt_consistency(struct fs_context *fc,
 =09=09=09=09      struct super_block *sb);
 static void ext4_apply_options(struct fs_context *fc, struct super_block *=
sb);
+static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *pa=
ram);
=20
 /*
  * Lock ordering
@@ -121,6 +122,10 @@ static void ext4_apply_options(struct fs_context *fc, =
struct super_block *sb);
  * transaction start -> page lock(s) -> i_data_sem (rw)
  */
=20
+static const struct fs_context_operations ext4_context_ops =3D {
+=09.parse_param=09=3D ext4_parse_param,
+};
+
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defined=
(CONFIG_EXT4_USE_FOR_EXT2)
 static struct file_system_type ext2_fs_type =3D {
 =09.owner=09=09=3D THIS_MODULE,
@@ -1943,7 +1948,7 @@ EXT4_SET_CTX(mount_opt2);
 EXT4_SET_CTX(mount_flags);
=20
=20
-static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *pa=
ram)
+static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *pa=
ram)
 {
 =09struct ext4_fs_context *ctx =3D fc->fs_private;
 =09const struct mount_opts *m;
@@ -1977,19 +1982,19 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 =09case Opt_removed:
 =09=09ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 =09=09=09 param->key);
-=09=09return 1;
+=09=09return 0;
 =09case Opt_abort:
 =09=09set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
-=09=09return 1;
+=09=09return 0;
 =09case Opt_i_version:
 =09=09set_flags(ctx, SB_I_VERSION);
-=09=09return 1;
+=09=09return 0;
 =09case Opt_lazytime:
 =09=09set_flags(ctx, SB_LAZYTIME);
-=09=09return 1;
+=09=09return 0;
 =09case Opt_nolazytime:
 =09=09clear_flags(ctx, SB_LAZYTIME);
-=09=09return 1;
+=09=09return 0;
 =09case Opt_errors:
 =09case Opt_data:
 =09case Opt_data_err:
@@ -2185,7 +2190,7 @@ static int handle_mount_opt(struct fs_context *fc, st=
ruct fs_parameter *param)
 =09=09else
 =09=09=09clear_mount_opt(ctx, m->mount_opt);
 =09}
-=09return 1;
+=09return 0;
 }
=20
 static int parse_options(struct fs_context *fc, char *options)
@@ -2223,7 +2228,7 @@ static int parse_options(struct fs_context *fc, char =
*options)
 =09=09=09}
 =09=09}
=20
-=09=09ret =3D handle_mount_opt(fc, &param);
+=09=09ret =3D ext4_parse_param(fc, &param);
 =09=09kfree(param.string);
 =09=09if (ret < 0)
 =09=09=09return ret;
--=20
2.21.0


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97911BC5A1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgD1QqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22326 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728335AbgD1QqD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awIdlJPQ9LlyBzZxzGVt+TGNC0E18izI0m2rhnL0YqM=;
        b=Z2HH80y+o2YY6c5+kOPCDije+LCai5bxHjJXTXATf8mfv5MP3DBw17oIR6KDDoBF0w761G
        sZMNd5oIS58WMmKE4s0g6ZYr5p/OormQusjUy0hy7uNh17ha0KppIfCFUFlf72IE7D7y3w
        dAjND1a/y+hmd+eqdhNrZ+YFPUlhhKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-dz7VEMY1Nx-TR-hnkJq-XA-1; Tue, 28 Apr 2020 12:45:58 -0400
X-MC-Unique: dz7VEMY1Nx-TR-hnkJq-XA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD546835B46;
        Tue, 28 Apr 2020 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1E6B1002388;
        Tue, 28 Apr 2020 16:45:56 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 10/17] ext4: clean up return values in handle_mount_opt()
Date:   Tue, 28 Apr 2020 18:45:29 +0200
Message-Id: <20200428164536.462-11-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Clean up return values in handle_mount_opt() and rename the function to
ext4_parse_param()

Now we can use it in fs_context_operations as .parse_param.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea7c8f7d4c7c..81238dddc3b7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -92,6 +92,7 @@ static int ext4_validate_options(struct fs_context *fc)=
;
 static int ext4_check_opt_consistency(struct fs_context *fc,
 				      struct super_block *sb);
 static void ext4_apply_options(struct fs_context *fc, struct super_block=
 *sb);
+static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *=
param);
=20
 /*
  * Lock ordering
@@ -121,6 +122,10 @@ static void ext4_apply_options(struct fs_context *fc=
, struct super_block *sb);
  * transaction start -> page lock(s) -> i_data_sem (rw)
  */
=20
+static const struct fs_context_operations ext4_context_ops =3D {
+	.parse_param	=3D ext4_parse_param,
+};
+
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defin=
ed(CONFIG_EXT4_USE_FOR_EXT2)
 static struct file_system_type ext2_fs_type =3D {
 	.owner		=3D THIS_MODULE,
@@ -2028,7 +2033,7 @@ EXT4_SET_CTX(mount_opt2);
 EXT4_SET_CTX(mount_flags);
=20
=20
-static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *=
param)
+static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *=
param)
 {
 	struct ext4_fs_context *ctx =3D fc->fs_private;
 	const struct mount_opts *m;
@@ -2062,19 +2067,19 @@ static int handle_mount_opt(struct fs_context *fc=
, struct fs_parameter *param)
 	case Opt_removed:
 		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
 			 param->key);
-		return 1;
+		return 0;
 	case Opt_abort:
 		set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
-		return 1;
+		return 0;
 	case Opt_i_version:
 		set_flags(ctx, SB_I_VERSION);
-		return 1;
+		return 0;
 	case Opt_lazytime:
 		set_flags(ctx, SB_LAZYTIME);
-		return 1;
+		return 0;
 	case Opt_nolazytime:
 		clear_flags(ctx, SB_LAZYTIME);
-		return 1;
+		return 0;
 	case Opt_errors:
 	case Opt_data:
 	case Opt_data_err:
@@ -2275,7 +2280,7 @@ static int handle_mount_opt(struct fs_context *fc, =
struct fs_parameter *param)
 		else
 			clear_mount_opt(ctx, m->mount_opt);
 	}
-	return 1;
+	return 0;
 }
=20
 static int parse_options(struct fs_context *fc, char *options)
@@ -2311,7 +2316,7 @@ static int parse_options(struct fs_context *fc, cha=
r *options)
 			param.key =3D key;
 			param.size =3D v_len;
=20
-			ret =3D handle_mount_opt(fc, &param);
+			ret =3D ext4_parse_param(fc, &param);
 			if (param.string)
 				kfree(param.string);
 			if (ret < 0)
--=20
2.21.1


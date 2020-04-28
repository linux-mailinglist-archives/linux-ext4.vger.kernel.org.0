Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADE1BC5A4
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgD1QqJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728084AbgD1QqJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJwtOAK7FJLARXRqYirTbsfm8IhxryMi6A2ioZGaheU=;
        b=TPFJKVwBY0Cue2fWaWqVciMRHR9oqItTunuocDAktCFjKiL+EMRSk8+XWTv+fEgaB7+QVp
        C9Lymbnp9YqwFvNS3UobDRuJowrSsaSceMgvVqVFCDQDMyCD+VJOhrkwekOtKbI5IYrBMk
        FqC/ot9OHm+i0qW0dKd3Y0XVwMCz+do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-QaSMl1vKMDqIBoHjuzwJhQ-1; Tue, 28 Apr 2020 12:46:06 -0400
X-MC-Unique: QaSMl1vKMDqIBoHjuzwJhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD4A8018AD;
        Tue, 28 Apr 2020 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0A2C1002388;
        Tue, 28 Apr 2020 16:46:01 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 14/17] ext4: add ext4_fc_free for the new mount API
Date:   Tue, 28 Apr 2020 18:45:33 +0200
Message-Id: <20200428164536.462-15-lczerner@redhat.com>
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
 fs/ext4/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9e10c42c300c..df7d1a724f1b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -95,6 +95,7 @@ static void ext4_apply_options(struct fs_context *fc, s=
truct super_block *sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *=
param);
 static int ext4_get_tree(struct fs_context *fc);
 static int ext4_reconfigure(struct fs_context *fc);
+static void ext4_fc_free(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -128,6 +129,7 @@ static const struct fs_context_operations ext4_contex=
t_ops =3D {
 	.parse_param	=3D ext4_parse_param,
 	.get_tree	=3D ext4_get_tree,
 	.reconfigure	=3D ext4_reconfigure,
+	.free		=3D ext4_fc_free,
 };
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defin=
ed(CONFIG_EXT4_USE_FOR_EXT2)
@@ -1958,6 +1960,19 @@ struct ext4_fs_context {
 	ext4_fsblk_t	s_sb_block;
 };
=20
+static void ext4_fc_free(struct fs_context *fc)
+{
+	struct ext4_fs_context *ctx =3D fc->fs_private;
+	int i;
+
+	if (!ctx)
+		return;
+
+	for (i =3D 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(ctx->s_qf_names[i]);
+	kfree(ctx);
+}
+
 #ifdef CONFIG_QUOTA
 /*
  * Note the name of the specified quota file.
--=20
2.21.1


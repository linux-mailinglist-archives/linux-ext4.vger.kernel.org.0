Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D44C1BC5A3
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgD1QqI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728335AbgD1QqI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0swHMZCm+qlVQUv0E6piv2hXFo6GEN5oOl6mG+HqFMA=;
        b=QRTDNigFDMjBbqRFtQOGOCFNzk/mAft2UrqO7JK0dk1DqiSMQqf9SdaKdomPppBFZGaXUV
        SCudoukO9JcNS+GK5b9l/rC8RFm1KAFkRzqBLej26UiFAGhgN1M8S2B5lo+7rV1OBgZK5t
        H5PSjM+FTbKENrzazcBTB6x/vkdvmxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-exHmyeBYPjycD0WXmjkDDw-1; Tue, 28 Apr 2020 12:46:02 -0400
X-MC-Unique: exHmyeBYPjycD0WXmjkDDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FA70835B40;
        Tue, 28 Apr 2020 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B821002388;
        Tue, 28 Apr 2020 16:46:00 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 13/17] ext4: add ext4_reconfigure for the new mount API
Date:   Tue, 28 Apr 2020 18:45:32 +0200
Message-Id: <20200428164536.462-14-lczerner@redhat.com>
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
 fs/ext4/super.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a340b4943544..9e10c42c300c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -94,6 +94,7 @@ static int ext4_check_opt_consistency(struct fs_context=
 *fc,
 static void ext4_apply_options(struct fs_context *fc, struct super_block=
 *sb);
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *=
param);
 static int ext4_get_tree(struct fs_context *fc);
+static int ext4_reconfigure(struct fs_context *fc);
=20
 /*
  * Lock ordering
@@ -126,6 +127,7 @@ static int ext4_get_tree(struct fs_context *fc);
 static const struct fs_context_operations ext4_context_ops =3D {
 	.parse_param	=3D ext4_parse_param,
 	.get_tree	=3D ext4_get_tree,
+	.reconfigure	=3D ext4_reconfigure,
 };
=20
 #if !defined(CONFIG_EXT2_FS) && !defined(CONFIG_EXT2_FS_MODULE) && defin=
ed(CONFIG_EXT4_USE_FOR_EXT2)
@@ -6237,6 +6239,25 @@ static int ext4_remount(struct super_block *sb, in=
t *flags, char *data)
 	return ret;
 }
=20
+static int ext4_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb =3D fc->root->d_sb;
+	int flags =3D fc->sb_flags;
+	int ret;
+
+	fc->s_fs_info =3D EXT4_SB(sb);
+
+	ret =3D ext4_check_opt_consistency(fc, sb);
+	if (ret < 0)
+		return ret;
+
+	ret =3D __ext4_remount(fc, sb, &flags);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 #ifdef CONFIG_QUOTA
 static int ext4_statfs_project(struct super_block *sb,
 			       kprojid_t projid, struct kstatfs *buf)
--=20
2.21.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B34A5D52
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Feb 2022 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiBANSR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Feb 2022 08:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238172AbiBANSQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Feb 2022 08:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643721495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXC1yw6E8gzLJGmP7/8HrH4mG4ZVe0X6VUv9Tso2fsg=;
        b=fTGeNZxKCTWuCVrQ+a8MwFaKY+Cv3rFlR6iAs8QhSRJqD9Skc/Y/9azhJnKCrswDykcsnv
        Y8HCqcPqRQKKyF9Ab1nH4CHp12MpxlwmY4u7Wf2YUx/bjZW36y7fjdxJIGdl2duaESzOhq
        XC3UaMei4I1iMErl3I+A0ziVkXzrTgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-UngBEyHgNmW1ThFxSDzeVw-1; Tue, 01 Feb 2022 08:13:54 -0500
X-MC-Unique: UngBEyHgNmW1ThFxSDzeVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 574591091DA7;
        Tue,  1 Feb 2022 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7196E2634A;
        Tue,  1 Feb 2022 13:13:52 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: [PATCH] ext4: fix remount with 'abort' option
Date:   Tue,  1 Feb 2022 14:13:45 +0100
Message-Id: <20220201131345.77591-1-lczerner@redhat.com>
In-Reply-To: <YcSYvk5DdGjjB9q/@mit.edu>
References: <YcSYvk5DdGjjB9q/@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After commit 6e47a3cc68fc ("ext4: get rid of super block and sbi from
handle_mount_ops()") the 'abort' options stopped working. This is
because we're using ctx_set_mount_flags() helper that's expecting an
argument with the appropriate bit set, but instead got
EXT4_MF_FS_ABORTED which is a bit position. ext4_set_mount_flag() is
using set_bit() while ctx_set_mount_flags() was using bitwise OR.

Create a separate helper ctx_set_mount_flag() to handle setting the
mount_flags correctly.

While we're at it clean up the EXT4_SET_CTX macros so that we're only
creating helpers that we actually use to avoid warnings.

Fixes: 6e47a3cc68fc ("ext4: get rid of super block and sbi from handle_mount_ops()")
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Cc: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index eee0d9ebfa6c..6f74cd51df2e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2045,8 +2045,8 @@ struct ext4_fs_context {
 	unsigned int	mask_s_mount_opt;
 	unsigned int	vals_s_mount_opt2;
 	unsigned int	mask_s_mount_opt2;
-	unsigned int	vals_s_mount_flags;
-	unsigned int	mask_s_mount_flags;
+	unsigned long	vals_s_mount_flags;
+	unsigned long	mask_s_mount_flags;
 	unsigned int	opt_flags;	/* MOPT flags */
 	unsigned int	spec;
 	u32		s_max_batch_time;
@@ -2149,23 +2149,36 @@ static inline void ctx_set_##name(struct ext4_fs_context *ctx,		\
 {									\
 	ctx->mask_s_##name |= flag;					\
 	ctx->vals_s_##name |= flag;					\
-}									\
+}
+
+#define EXT4_CLEAR_CTX(name)						\
 static inline void ctx_clear_##name(struct ext4_fs_context *ctx,	\
 				    unsigned long flag)			\
 {									\
 	ctx->mask_s_##name |= flag;					\
 	ctx->vals_s_##name &= ~flag;					\
-}									\
+}
+
+#define EXT4_TEST_CTX(name)						\
 static inline unsigned long						\
 ctx_test_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
 {									\
 	return (ctx->vals_s_##name & flag);				\
-}									\
+}
 
-EXT4_SET_CTX(flags);
+EXT4_SET_CTX(flags); /* set only */
 EXT4_SET_CTX(mount_opt);
+EXT4_CLEAR_CTX(mount_opt);
+EXT4_TEST_CTX(mount_opt);
 EXT4_SET_CTX(mount_opt2);
-EXT4_SET_CTX(mount_flags);
+EXT4_CLEAR_CTX(mount_opt2);
+EXT4_TEST_CTX(mount_opt2);
+
+static inline void ctx_set_mount_flag(struct ext4_fs_context *ctx, int bit)
+{
+	set_bit(bit, &ctx->mask_s_mount_flags);
+	set_bit(bit, &ctx->vals_s_mount_flags);
+}
 
 static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
@@ -2235,7 +2248,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			 param->key);
 		return 0;
 	case Opt_abort:
-		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
+		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
 		return 0;
 	case Opt_i_version:
 		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "5.20");
-- 
2.31.1


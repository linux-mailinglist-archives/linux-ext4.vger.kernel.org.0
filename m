Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3279547B02F
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhLTP1p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Dec 2021 10:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238294AbhLTP1N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Dec 2021 10:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640014033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=csCz+RJCH7nh1MHlzAxMW8lRYT4flH4PiapZCy7VTPg=;
        b=fD93YCGjrvsdO/xIM/MVjBFD9F7T4Gt0nuJGOylWErFEHFXpJMO7JIzyES+bVG3QvzIyAg
        Lx/oXn3qd8kKiLLFmOAhD3PZ6qd5QfsAKOM3bn9V015hg0CCp5bBLgmw0QMHauWC7gIjJh
        qYSVz30qr9hd0eZygFIHRjn8PPaBTCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-eB4csh0NP7-zxMdQOdrVkw-1; Mon, 20 Dec 2021 10:27:09 -0500
X-MC-Unique: eB4csh0NP7-zxMdQOdrVkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CBEB100D684;
        Mon, 20 Dec 2021 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6814060BF4;
        Mon, 20 Dec 2021 15:27:07 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ext4: don't fail remount if journalling mode didn't change
Date:   Mon, 20 Dec 2021 16:26:57 +0100
Message-Id: <20211220152657.101599-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Switching to the new mount api introduced inconsistency in how the
journalling mode mount option (data=) is handled during a remount.

Ext4 always prevented changing the journalling mode during the remount,
however the new code always fails the remount when the journalling mode
is specified, even if it remains unchanged. Fix it.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Fixes: cebe85d570cf ("ext4: switch to the new mount api")
---
 fs/ext4/super.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b77fb..dd9de4bf414d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2148,19 +2148,22 @@ static int unnote_qf_name(struct fs_context *fc, int qtype)
 #endif
 
 #define EXT4_SET_CTX(name)						\
-static inline void ctx_set_##name(struct ext4_fs_context *ctx, int flag)\
+static inline void ctx_set_##name(struct ext4_fs_context *ctx,		\
+				  unsigned long flag)			\
 {									\
 	ctx->mask_s_##name |= flag;					\
 	ctx->vals_s_##name |= flag;					\
 }									\
-static inline void ctx_clear_##name(struct ext4_fs_context *ctx, int flag)\
+static inline void ctx_clear_##name(struct ext4_fs_context *ctx,	\
+				    unsigned long flag)			\
 {									\
 	ctx->mask_s_##name |= flag;					\
 	ctx->vals_s_##name &= ~flag;					\
 }									\
-static inline bool ctx_test_##name(struct ext4_fs_context *ctx, int flag)\
+static inline unsigned long						\
+ctx_test_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
 {									\
-	return ((ctx->vals_s_##name & flag) != 0);			\
+	return (ctx->vals_s_##name & flag);				\
 }									\
 
 EXT4_SET_CTX(flags);
@@ -2821,7 +2824,8 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 				 "Remounting file system with no journal "
 				 "so ignoring journalled data option");
 			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
-		} else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
+		} else if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS) !=
+			   test_opt(sb, DATA_FLAGS)) {
 			ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
 				 "on remount");
 			return -EINVAL;
-- 
2.31.1


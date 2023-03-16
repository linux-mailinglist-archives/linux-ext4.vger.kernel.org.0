Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0D6BCE24
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Mar 2023 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCPL3Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 07:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCPL3X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 07:29:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563DB53EC;
        Thu, 16 Mar 2023 04:29:22 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PclQS752szKn2s;
        Thu, 16 Mar 2023 19:29:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 16 Mar
 2023 19:29:20 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 2/3] ext4: add helper to check if flag is changed by ctx
Date:   Thu, 16 Mar 2023 19:28:31 +0800
Message-ID: <20230316112832.2711783-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230316112832.2711783-1-libaokun1@huawei.com>
References: <20230316112832.2711783-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add helper to check if flag will be changed, return 1 means it will be
set, -1 means it will be cleared, 0 means it will not be changed.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/super.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5b4a323c218b..fefcd42f34ea 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2042,13 +2042,26 @@ ctx_test_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
 	return (ctx->vals_s_##name & flag);				\
 }
 
+#define EXT4_CHANGED_CTX(name)						\
+static inline int							\
+ctx_changed_##name(struct ext4_fs_context *ctx, unsigned long flag)	\
+{									\
+	if (ctx->vals_s_##name & flag)                                  \
+		return 1;						\
+	if (ctx->mask_s_##name & flag)					\
+		return -1;						\
+	return 0;							\
+}
+
 EXT4_SET_CTX(flags); /* set only */
 EXT4_SET_CTX(mount_opt);
 EXT4_CLEAR_CTX(mount_opt);
 EXT4_TEST_CTX(mount_opt);
+EXT4_CHANGED_CTX(mount_opt);
 EXT4_SET_CTX(mount_opt2);
 EXT4_CLEAR_CTX(mount_opt2);
 EXT4_TEST_CTX(mount_opt2);
+EXT4_CHANGED_CTX(mount_opt2);
 
 static inline void ctx_set_mount_flag(struct ext4_fs_context *ctx, int bit)
 {
@@ -2537,9 +2550,7 @@ static int ext4_check_quota_consistency(struct fs_context *fc,
 
 	quota_flags = EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA |
 		      EXT4_MOUNT_GRPQUOTA | EXT4_MOUNT_PRJQUOTA;
-	if (quota_loaded &&
-	    ctx->mask_s_mount_opt & quota_flags &&
-	    !ctx_test_mount_opt(ctx, quota_flags))
+	if (quota_loaded && (ctx_changed_mount_opt(ctx, quota_flags) < 0))
 		goto err_quota_change;
 
 	if (ctx->spec & EXT4_SPEC_JQUOTA) {
-- 
2.31.1


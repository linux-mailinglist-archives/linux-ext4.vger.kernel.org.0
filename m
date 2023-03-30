Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009076CFC10
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjC3G5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 02:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjC3G5m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 02:57:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37C469A
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 23:57:37 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PnDfZ5Y17zSqZM;
        Thu, 30 Mar 2023 14:53:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 14:57:35 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <djwong@kernel.org>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v2 2/2] e2fsck: add sync error handle to e2fsck.
Date:   Thu, 30 Mar 2023 14:56:56 +0800
Message-ID: <20230330065656.3275785-3-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230330065656.3275785-1-zhanchengbin1@huawei.com>
References: <20230330065656.3275785-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If fsync fails during fsck, it is silent and users will not perceive it, so
a function to handle fsync failure should be added to fsck.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 e2fsck/ehandler.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/e2fsck/ehandler.c b/e2fsck/ehandler.c
index 71ca301c..1d95a89d 100644
--- a/e2fsck/ehandler.c
+++ b/e2fsck/ehandler.c
@@ -118,6 +118,27 @@ static errcode_t e2fsck_handle_write_error(io_channel channel,
 	return error;
 }
 
+static errcode_t e2fsck_handle_sync_error(io_channel channel,
+                                            errcode_t error)
+{
+	ext2_filsys fs = (ext2_filsys) channel->app_data;
+	e2fsck_t ctx;
+
+	ctx = (e2fsck_t) fs->priv_data;
+	if (ctx->flags & E2F_FLAG_EXITING)
+		return 0;
+
+	if (operation)
+		printf(_("Error during fsync of dirty metadata while %s: %s "),
+		       operation, error_message(error));
+	else
+		printf(_("Error during fsync of dirty metadata: %s "),
+		       error_message(error));
+	preenhalt(ctx);
+
+	return error;
+}
+
 const char *ehandler_operation(const char *op)
 {
 	const char *ret = operation;
@@ -130,4 +151,5 @@ void ehandler_init(io_channel channel)
 {
 	channel->read_error = e2fsck_handle_read_error;
 	channel->write_error = e2fsck_handle_write_error;
+	channel->sync_error = e2fsck_handle_sync_error;
 }
-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27926712E1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 05:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAREyT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 23:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAREyS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 23:54:18 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32F50840
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 20:54:16 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NxYKB5L1Dz16N2W;
        Wed, 18 Jan 2023 12:52:30 +0800 (CST)
Received: from huawei.com (10.113.189.238) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 12:54:13 +0800
From:   Wang Jianjian <wangjianjian3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <lczerner@redhat.com>
CC:     <wangjianjian3@huawei.com>, <zhangzhikang1@huawei.com>
Subject: [PATCH] ext4: Don't show commit interval if it is zero
Date:   Wed, 18 Jan 2023 12:54:13 +0800
Message-ID: <20230118045413.3537040-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.113.189.238]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If commit interval is 0, it means using default value.

Fixes: 6e47a3cc68fc ("ext4: get rid of super block and sbi from handle_mount_ops()")
Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2..3b9e30e1afd9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2146,7 +2146,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 	case Opt_commit:
 		if (result.uint_32 == 0)
-			ctx->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
+			result.uint_32 = JBD2_DEFAULT_MAX_COMMIT_AGE;
 		else if (result.uint_32 > INT_MAX / HZ) {
 			ext4_msg(NULL, KERN_ERR,
 				 "Invalid commit interval %d, "
-- 
2.32.0


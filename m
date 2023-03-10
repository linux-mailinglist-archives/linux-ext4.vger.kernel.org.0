Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFCC6B3FB5
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 13:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCJMxA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 07:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCJMw5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 07:52:57 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FFA10DE4B;
        Fri, 10 Mar 2023 04:52:53 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PY5Vc4sCMz16PB8;
        Fri, 10 Mar 2023 20:50:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 10 Mar
 2023 20:52:50 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 2/5] jbd2: remove unused feature macros
Date:   Fri, 10 Mar 2023 20:52:03 +0800
Message-ID: <20230310125206.2867822-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230310125206.2867822-1-chengzhihao1@huawei.com>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

JBD2_HAS_[IN|RO_]COMPAT_FEATURE macros are no longer used, just remove
them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 include/linux/jbd2.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5962072a4b19..ad7bb6861143 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -274,17 +274,6 @@ typedef struct journal_superblock_s
 /* 0x0400 */
 } journal_superblock_t;
 
-/* Use the jbd2_{has,set,clear}_feature_* helpers; these will be removed */
-#define JBD2_HAS_COMPAT_FEATURE(j,mask)					\
-	((j)->j_format_version >= 2 &&					\
-	 ((j)->j_superblock->s_feature_compat & cpu_to_be32((mask))))
-#define JBD2_HAS_RO_COMPAT_FEATURE(j,mask)				\
-	((j)->j_format_version >= 2 &&					\
-	 ((j)->j_superblock->s_feature_ro_compat & cpu_to_be32((mask))))
-#define JBD2_HAS_INCOMPAT_FEATURE(j,mask)				\
-	((j)->j_format_version >= 2 &&					\
-	 ((j)->j_superblock->s_feature_incompat & cpu_to_be32((mask))))
-
 #define JBD2_FEATURE_COMPAT_CHECKSUM		0x00000001
 
 #define JBD2_FEATURE_INCOMPAT_REVOKE		0x00000001
-- 
2.31.1


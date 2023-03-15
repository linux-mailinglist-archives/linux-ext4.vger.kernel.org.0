Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09326BA4B5
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 02:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCOBdA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 21:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCOBcv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 21:32:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8BB1F920;
        Tue, 14 Mar 2023 18:32:19 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pbt9p5srhzHwwT;
        Wed, 15 Mar 2023 09:30:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 09:32:17 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 3/6] jbd2: remove unused feature macros
Date:   Wed, 15 Mar 2023 09:31:25 +0800
Message-ID: <20230315013128.3911115-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230315013128.3911115-1-chengzhihao1@huawei.com>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/jbd2.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f619bae1dcc5..a91cf9c7a94b 100644
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


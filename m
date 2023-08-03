Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFC76DE53
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 04:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjHCCg6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 22:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjHCCgh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 22:36:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB534215
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 19:34:52 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGXsN42QWztRjG;
        Thu,  3 Aug 2023 10:31:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 10:34:42 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v2 2/2] ext4: ioctl add EXT4_IOC_SUPERBLOCK_KEY_S_ERRORS
Date:   Thu, 3 Aug 2023 10:31:28 +0800
Message-ID: <20230803023128.35170-3-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230803023128.35170-1-zhanchengbin1@huawei.com>
References: <20230803023128.35170-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Added modifications to s_errors in the modification framework of
superblock's attrs. There is no lock protection when the user mode
operates on the same block, so I modify the s_errors by the modification
framework of superblock's attrs.

The parameters passed in from the user mode will be checked by
sb_attr_errors_check first, if the check is passed, It will call
buffer_lock in ext4_update_superblocks_fn and use sb_attr_errors_set, so
it can ensure the atomicity of a modification.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308021801.ieUVR2xl-lkp@intel.com/
---
 fs/ext4/ioctl.c           | 22 ++++++++++++++++++++++
 include/uapi/linux/ext4.h |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 76653d855073..4053a038da0a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -30,10 +30,32 @@
 typedef void ext4_update_sb_callback(struct ext4_super_block *es,
 				       const void *arg);
 
+static int sb_attr_errors_check(struct ext4_sbattr *p_sbattr)
+{
+	__u16 error_behavior = *(__u16 *)(p_sbattr->sba_value);
+
+	if (p_sbattr->sba_len != EXT4_IOC_SUPERBLOCK_LEN_S_ERRORS)
+		return -EINVAL;
+
+	if (error_behavior < EXT4_ERRORS_CONTINUE ||
+	    error_behavior > EXT4_ERRORS_PANIC)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void sb_attr_errors_set(struct ext4_super_block *es, const void *arg)
+{
+	struct ext4_sbattr *p_sbattr = (struct ext4_sbattr *)arg;
+
+	es->s_errors = cpu_to_le16(*(__u16 *)p_sbattr->sba_value);
+}
+
 /*
  * Check and modify functions for each superblock variable
  */
 struct ext4_sbattr_operation ext4_sbattr_ops[] = {
+	{EXT4_IOC_SUPERBLOCK_KEY_S_ERRORS, sb_attr_errors_check, sb_attr_errors_set},
 	{EXT4_IOC_SUPERBLOCK_KEY_MAX, NULL, NULL},
 };
 
diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 79b5a751b83e..f5429630343e 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -90,8 +90,10 @@ struct ext4_sbattr {
 };
 
 enum ext4_ioc_superblock_key {
-	EXT4_IOC_SUPERBLOCK_KEY_MAX = 0,
+	EXT4_IOC_SUPERBLOCK_KEY_S_ERRORS = 0,
+	EXT4_IOC_SUPERBLOCK_KEY_MAX,
 };
+#define EXT4_IOC_SUPERBLOCK_LEN_S_ERRORS	2
 
 #define EXT4_SBATTR_MAX_COUNT	20
 
-- 
2.31.1


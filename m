Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215946C6A77
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCWOI3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCWOIZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 10:08:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2CF19F20
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 07:07:06 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pj6Zy6PC6zKnGq;
        Thu, 23 Mar 2023 22:06:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm100004.china.huawei.com
 (7.192.105.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 23 Mar
 2023 22:06:57 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 5/8] ext4: rename two functions with 'check'
Date:   Thu, 23 Mar 2023 22:05:14 +0800
Message-ID: <20230323140517.1070239-6-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323140517.1070239-1-yanaijie@huawei.com>
References: <20230323140517.1070239-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The naming styles are different for some functions with 'check' in their
names. Some of them are like:

ext4_check_quota_consistency
ext4_check_test_dummy_encryption
ext4_check_opt_consistency
ext4_check_descriptors
ext4_check_feature_compatibility

While the others looks like below:

ext4_geometry_check
ext4_journal_data_mode_check

This is not a big deal and boils down to personal preference. But I'd
like to make them consistent.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ed7bd3bb45f2..66f0da764d58 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4713,7 +4713,7 @@ static int ext4_check_feature_compatibility(struct super_block *sb,
 	return 0;
 }
 
-static int ext4_geometry_check(struct super_block *sb,
+static int ext4_check_geometry(struct super_block *sb,
 			       struct ext4_super_block *es)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -4922,7 +4922,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	return -EINVAL;
 }
 
-static int ext4_journal_data_mode_check(struct super_block *sb)
+static int ext4_check_journal_data_mode(struct super_block *sb)
 {
 	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
 		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with "
@@ -5162,7 +5162,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_encoding_init(sb, es))
 		goto failed_mount;
 
-	if (ext4_journal_data_mode_check(sb))
+	if (ext4_check_journal_data_mode(sb))
 		goto failed_mount;
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
@@ -5264,7 +5264,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount;
 	}
 
-	if (ext4_geometry_check(sb, es))
+	if (ext4_check_geometry(sb, es))
 		goto failed_mount;
 
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
-- 
2.31.1


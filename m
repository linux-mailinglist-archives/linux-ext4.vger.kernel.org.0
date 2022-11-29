Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611A363BA0D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 07:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiK2G6Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 01:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2G6Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 01:58:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF80123162
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 22:58:22 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLtSk3NQZzRpQQ;
        Tue, 29 Nov 2022 14:57:42 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 14:58:21 +0800
Received: from [10.174.178.112] (10.174.178.112) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 14:58:20 +0800
Message-ID: <fbe3716b-e8bb-58c0-6c55-a88b6979063c@huawei.com>
Date:   Tue, 29 Nov 2022 14:58:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Content-Language: en-US
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
From:   "lihaoxiang (F)" <lihaoxiang9@huawei.com>
Subject: [PATCH] tune2fs:check return value of ext2fs_mmp_update2 in
 rewrite_metadata_checksums
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.112]
X-ClientProxiedBy: dggpeml100017.china.huawei.com (7.185.36.161) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Tune2fs hasn't consider about the result of executing ext2fs_mmp_update2
when it try to rewrite_metadata_checksums. If the ext2fs_mmp_update2
failed, multi-mount protection couldn't guard there has the only node
(i.e. this program) accessing this device in the meantime.

We solve this problem to verify the return value of ext2fs_mmp_update2.
It terminate rewrite_metadata_checksums and exit immediately if the
wrong error code returned.

Signed-off-by: lihaoxiang <lihaoxiang9@huawei.com>
---
 misc/tune2fs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index bed3d95..aa51864 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -930,7 +930,7 @@ static void rewrite_inodes(ext2_filsys fs, unsigned int flags)
 	ext2fs_free_mem(&ctx.ea_buf);
 }

-static void rewrite_metadata_checksums(ext2_filsys fs, unsigned int flags)
+static errcode_t rewrite_metadata_checksums(ext2_filsys fs, unsigned int flags)
 {
 	errcode_t retval;
 	dgrp_t i;
@@ -945,7 +945,9 @@ static void rewrite_metadata_checksums(ext2_filsys fs, unsigned int flags)
 	rewrite_inodes(fs, flags);
 	ext2fs_mark_ib_dirty(fs);
 	ext2fs_mark_bb_dirty(fs);
-	ext2fs_mmp_update2(fs, 1);
+	retval = ext2fs_mmp_update2(fs, 1);
+	if (retval)
+		return retval;
 	fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
 	fs->flags &= ~EXT2_FLAG_IGNORE_CSUM_ERRORS;
 	if (ext2fs_has_feature_metadata_csum(fs->super))
@@ -953,6 +955,7 @@ static void rewrite_metadata_checksums(ext2_filsys fs, unsigned int flags)
 	else
 		fs->super->s_checksum_type = 0;
 	ext2fs_mark_super_dirty(fs);
+	return 0;
 }

 static void enable_uninit_bg(ext2_filsys fs)
@@ -3410,8 +3413,14 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		}
 	}

-	if (rewrite_checksums)
-		rewrite_metadata_checksums(fs, rewrite_checksums);
+	if (rewrite_checksums) {
+		retval = rewrite_metadata_checksums(fs, rewrite_checksums);
+		if (retval != 0) {
+			printf("Failed to rewrite metadata checksums\n");
+			rc = 1;
+			goto closefs;
+		}
+	}

 	if (l_flag)
 		list_super(sb);
-- 
1.8.3.1

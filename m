Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49E5BAEE5
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiIPOFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiIPOEw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 10:04:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8715828
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 07:04:50 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTbPH4wTTzBsJX;
        Fri, 16 Sep 2022 22:02:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 22:04:47 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 16/16] ext4: move DIOREAD_NOLOCK setting to ext4_set_def_opts()
Date:   Fri, 16 Sep 2022 22:15:27 +0800
Message-ID: <20220916141527.1012715-17-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916141527.1012715-1-yanaijie@huawei.com>
References: <20220916141527.1012715-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now since all preparations is done, we can move the DIOREAD_NOLOCK
setting to ext4_set_def_opts().

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 25813758a53c..8624cc30c18b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4364,6 +4364,9 @@ static void ext4_set_def_opts(struct super_block *sb,
 	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
 	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
 		set_opt(sb, DELALLOC);
+
+	if (sb->s_blocksize == PAGE_SIZE)
+		set_opt(sb, DIOREAD_NOLOCK);
 }
 
 static int ext4_handle_clustersize(struct super_block *sb)
@@ -5109,9 +5112,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 */
 	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
 
-	if (sb->s_blocksize == PAGE_SIZE)
-		set_opt(sb, DIOREAD_NOLOCK);
-
 	if (ext4_inode_info_init(sb, es))
 		goto failed_mount;
 
-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6995BCEBF
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiISO3i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiISO3f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 10:29:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8C2AD6;
        Mon, 19 Sep 2022 07:29:33 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWRm71WpZzlW0r;
        Mon, 19 Sep 2022 22:25:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 19 Sep
 2022 22:29:31 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 2/2] ext4: fix potential memory leak in ext4_fc_record_modified_inode()
Date:   Mon, 19 Sep 2022 22:40:21 +0800
Message-ID: <20220919144021.2162295-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220919144021.2162295-1-yebin10@huawei.com>
References: <20220919144021.2162295-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As krealloc may return NULL, in this case 'state->fc_modified_inodes'
may not be freed by krealloc, but 'state->fc_modified_inodes' already
set NULL. Then will lead to 'state->fc_modified_inodes' memory leak.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/fast_commit.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index cc8c8db075ba..5ab58cb4ce8d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1486,13 +1486,15 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
 		if (state->fc_modified_inodes[i] == ino)
 			return 0;
 	if (state->fc_modified_inodes_used == state->fc_modified_inodes_size) {
-		state->fc_modified_inodes = krealloc(
-				state->fc_modified_inodes,
+		int *fc_modified_inodes;
+
+		fc_modified_inodes = krealloc(state->fc_modified_inodes,
 				sizeof(int) * (state->fc_modified_inodes_size +
 				EXT4_FC_REPLAY_REALLOC_INCREMENT),
 				GFP_KERNEL);
-		if (!state->fc_modified_inodes)
+		if (!fc_modified_inodes)
 			return -ENOMEM;
+		state->fc_modified_inodes = fc_modified_inodes;
 		state->fc_modified_inodes_size +=
 			EXT4_FC_REPLAY_REALLOC_INCREMENT;
 	}
-- 
2.31.1


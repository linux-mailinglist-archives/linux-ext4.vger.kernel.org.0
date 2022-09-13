Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE75B6868
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Sep 2022 09:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIMHN4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 03:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMHN4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 03:13:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265F21266
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 00:13:55 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MRZNP2N6Hz14QSV;
        Tue, 13 Sep 2022 15:09:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 13 Sep
 2022 15:13:53 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <jack@suse.com>, <linux-ext4@vger.kernel.org>
CC:     <yuancan@huawei.com>
Subject: [PATCH] fs/ext2: remove unused variable es
Date:   Tue, 13 Sep 2022 07:11:41 +0000
Message-ID: <20220913071141.94082-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The variable es is never used, remove it.
No functional change.

Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 fs/ext2/ialloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 998dd2ac8008..951b80a7f7d2 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -620,11 +620,9 @@ unsigned long ext2_count_free_inodes (struct super_block * sb)
 	int i;	
 
 #ifdef EXT2FS_DEBUG
-	struct ext2_super_block *es;
 	unsigned long bitmap_count = 0;
 	struct buffer_head *bitmap_bh = NULL;
 
-	es = EXT2_SB(sb)->s_es;
 	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
 		unsigned x;
 
-- 
2.17.1


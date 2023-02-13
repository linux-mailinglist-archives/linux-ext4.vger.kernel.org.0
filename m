Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6B693D18
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 04:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBMDlx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Feb 2023 22:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBMDls (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Feb 2023 22:41:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B4DBE9
        for <linux-ext4@vger.kernel.org>; Sun, 12 Feb 2023 19:41:43 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PFVQ415zkzJr46;
        Mon, 13 Feb 2023 11:37:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 13 Feb
 2023 11:41:41 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v4 2/2] ext4: clear the verified flag of the modified leaf or idx if error
Date:   Mon, 13 Feb 2023 12:05:22 +0800
Message-ID: <20230213040522.3339406-3-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
References: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Clear the verified flag from the modified bh when failed in ext4_ext_rm_idx
or ext4_ext_correct_indexes.
In this way, the start value of the logical block itself and its
parents' will be checked in ext4_valid_extent_entries.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 fs/ext4/extents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0f95e857089e..9013a05f524b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1756,6 +1756,8 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 		if (err)
 			break;
 	}
+	while (!(k < 0) && k++ < depth)
+		clear_buffer_verified(path[k]->p_bh);
 
 	return err;
 }
@@ -2304,6 +2306,7 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 {
 	int err;
 	ext4_fsblk_t leaf;
+	int b_depth = depth;
 
 	/* free index block */
 	depth--;
@@ -2345,6 +2348,9 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 		if (err)
 			break;
 	}
+	while (!(depth < 0) && depth++ < b_depth - 1)
+		clear_buffer_verified(path[depth]->p_bh);
+
 	return err;
 }
 
-- 
2.31.1


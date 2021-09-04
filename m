Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875194009D0
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Sep 2021 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhIDEkr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Sep 2021 00:40:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15287 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhIDEko (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 Sep 2021 00:40:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H1hl802Ryz8snj;
        Sat,  4 Sep 2021 12:39:16 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 4 Sep 2021 12:39:41 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 4 Sep 2021 12:39:40 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 1/2] ext4: avoid recheck extent for EXT4_EX_FORCE_CACHE
Date:   Sat, 4 Sep 2021 12:49:45 +0800
Message-ID: <20210904044946.2102404-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904044946.2102404-1-yangerkun@huawei.com>
References: <20210904044946.2102404-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Buffer with verified means that it has been checked before. No need
verify and call set_buffer_verified again.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/extents.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index cbf37b2cf871..8559e288472f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -505,13 +505,16 @@ __read_extent_tree_block(const char *function, unsigned int line,
 		if (err < 0)
 			goto errout;
 	}
-	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
-		return bh;
-	err = __ext4_ext_check(function, line, inode,
-			       ext_block_hdr(bh), depth, pblk);
-	if (err)
-		goto errout;
-	set_buffer_verified(bh);
+	if (buffer_verified(bh)) {
+		if (!(flags & EXT4_EX_FORCE_CACHE))
+			return bh;
+	} else {
+		err = __ext4_ext_check(function, line, inode,
+				       ext_block_hdr(bh), depth, pblk);
+		if (err)
+			goto errout;
+		set_buffer_verified(bh);
+	}
 	/*
 	 * If this is a leaf block, cache all of its entries
 	 */
-- 
2.31.1


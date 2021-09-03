Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1053FFA4D
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 08:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbhICGSp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 02:18:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9002 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbhICGSo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 02:18:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H16yK4tkhzYqNd;
        Fri,  3 Sep 2021 14:16:57 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 14:17:42 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 3 Sep 2021 14:17:41 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 1/3] ext4: correct the left/middle/right debug message for binsearch
Date:   Fri, 3 Sep 2021 14:27:46 +0800
Message-ID: <20210903062748.4118886-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903062748.4118886-1-yangerkun@huawei.com>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
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

The debuginfo for binsearch want to show the left/middle/right extent
while the process search for the goal block. However we show this info
after we change right or left.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/extents.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c33e0a2cb6c3..7ae32078b48f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -713,13 +713,14 @@ ext4_ext_binsearch_idx(struct inode *inode,
 	r = EXT_LAST_INDEX(eh);
 	while (l <= r) {
 		m = l + (r - l) / 2;
+		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
+			  le32_to_cpu(l->ei_block), m, le32_to_cpu(m->ei_block),
+			  r, le32_to_cpu(r->ei_block));
+
 		if (block < le32_to_cpu(m->ei_block))
 			r = m - 1;
 		else
 			l = m + 1;
-		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
-			  le32_to_cpu(l->ei_block), m, le32_to_cpu(m->ei_block),
-			  r, le32_to_cpu(r->ei_block));
 	}
 
 	path->p_idx = l - 1;
@@ -781,13 +782,14 @@ ext4_ext_binsearch(struct inode *inode,
 
 	while (l <= r) {
 		m = l + (r - l) / 2;
+		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
+			  le32_to_cpu(l->ee_block), m, le32_to_cpu(m->ee_block),
+			  r, le32_to_cpu(r->ee_block));
+
 		if (block < le32_to_cpu(m->ee_block))
 			r = m - 1;
 		else
 			l = m + 1;
-		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
-			  le32_to_cpu(l->ee_block), m, le32_to_cpu(m->ee_block),
-			  r, le32_to_cpu(r->ee_block));
 	}
 
 	path->p_ext = l - 1;
-- 
2.31.1


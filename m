Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAAC3A0E02
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jun 2021 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhFIHsi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Jun 2021 03:48:38 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5304 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhFIHse (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Jun 2021 03:48:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0Jvt22XCz1BKQQ;
        Wed,  9 Jun 2021 15:41:46 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:46:37 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 15:46:37 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] ext4: no need to verify new add extent block
Date:   Wed, 9 Jun 2021 15:55:45 +0800
Message-ID: <20210609075545.1442160-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_ext_grow_indepth will add a new extent block which has init the
expected content. We can mark this buffer as verified so to stop a
useless check in __read_extent_tree_block.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/extents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index cbf37b2cf871..6ca5be8a8fc2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1306,6 +1306,7 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 	neh->eh_magic = EXT4_EXT_MAGIC;
 	ext4_extent_block_csum_set(inode, neh);
 	set_buffer_uptodate(bh);
+	set_buffer_verified(bh);
 	unlock_buffer(bh);
 
 	err = ext4_handle_dirty_metadata(handle, inode, bh);
-- 
2.31.1


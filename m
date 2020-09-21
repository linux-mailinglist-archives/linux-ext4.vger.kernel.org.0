Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94721272405
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Sep 2020 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIUMkt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Sep 2020 08:40:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgIUMkt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 21 Sep 2020 08:40:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BF6FD5432D9278035887;
        Mon, 21 Sep 2020 20:40:47 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 20:40:45 +0800
From:   Qilong Zhang <zhangqilong3@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>
Subject: [PATCH -next] ext4: add trace exit in exception path.
Date:   Mon, 21 Sep 2020 20:47:38 +0800
Message-ID: <20200921124738.23352-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

Missing trace exit in exception path of ext4_sync_file and
ext4_ind_map_blocks.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 fs/ext4/fsync.c    | 2 +-
 fs/ext4/indirect.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 1d668c8f131f..6476994d9861 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -150,7 +150,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	ret = file_write_and_wait_range(file, start, end);
 	if (ret)
-		return ret;
+		goto out;
 
 	/*
 	 * data=writeback,ordered:
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 80c9f33800be..1da12c44d6fe 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -593,7 +593,8 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	if (ext4_has_feature_bigalloc(inode->i_sb)) {
 		EXT4_ERROR_INODE(inode, "Can't allocate blocks for "
 				 "non-extent mapped inodes with bigalloc");
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto out;
 	}
 
 	/* Set up for the direct block allocation */
-- 
2.17.1


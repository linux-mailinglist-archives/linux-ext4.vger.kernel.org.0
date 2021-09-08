Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B223D40394A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 13:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351600AbhIHMAL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 08:00:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9016 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348327AbhIHMAJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Sep 2021 08:00:09 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4LHg6wB7zVqH2;
        Wed,  8 Sep 2021 19:58:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 8 Sep
 2021 19:58:59 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH 3/3] ext4: prevent partial update of the extent blocks
Date:   Wed, 8 Sep 2021 20:08:50 +0800
Message-ID: <20210908120850.4012324-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908120850.4012324-1-yi.zhang@huawei.com>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the most error path of current extents updating operations are not
roll back partial updates properly when some bad things happens(.e.g in
ext4_ext_insert_extent()). So we may get an inconsistent extents tree
if journal has been aborted due to IO error, which may probability lead
to BUGON later when we accessing these extent entries in errors=continue
mode. This patch drop extent buffer's verify flag before updatng the
contents in ext4_ext_get_access(), and reset it after updating in
__ext4_ext_dirty(). After this patch we could force to check the extent
buffer if extents tree updating was break off, make sure the extents are
consistent.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d2601194b462..9228de6950a2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -136,15 +136,25 @@ int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
 static int ext4_ext_get_access(handle_t *handle, struct inode *inode,
 				struct ext4_ext_path *path)
 {
+	int err = 0;
+
 	if (path->p_bh) {
 		/* path points to block */
 		BUFFER_TRACE(path->p_bh, "get_write_access");
-		return ext4_journal_get_write_access(handle, inode->i_sb,
-						     path->p_bh, EXT4_JTR_NONE);
+		err = ext4_journal_get_write_access(handle, inode->i_sb,
+						    path->p_bh, EXT4_JTR_NONE);
+		/*
+		 * The extent buffer's verified bit will be set again in
+		 * __ext4_ext_dirty(). We could leave an inconsistent
+		 * buffer if the extents updating procudure break off du
+		 * to some error happens, force to check it again.
+		 */
+		if (!err)
+			clear_buffer_verified(path->p_bh);
 	}
 	/* path points to leaf/index in inode body */
 	/* we use in-core data, no need to protect them */
-	return 0;
+	return err;
 }
 
 /*
@@ -165,6 +175,9 @@ static int __ext4_ext_dirty(const char *where, unsigned int line,
 		/* path points to block */
 		err = __ext4_handle_dirty_metadata(where, line, handle,
 						   inode, path->p_bh);
+		/* Extents updating done, re-set verified flag */
+		if (!err)
+			set_buffer_verified(path->p_bh);
 	} else {
 		/* path points to leaf/index in inode body */
 		err = ext4_mark_inode_dirty(handle, inode);
-- 
2.31.1


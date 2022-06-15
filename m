Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7392954C3E7
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiFOIrL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiFOIrK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 04:47:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06704B1FE;
        Wed, 15 Jun 2022 01:47:08 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LNJmn4xlvzjY6F;
        Wed, 15 Jun 2022 16:46:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 16:47:06 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext2: fix fs corruption when trying to remove a non-empty directory with IO error
Date:   Wed, 15 Jun 2022 17:00:10 +0800
Message-ID: <20220615090010.1544152-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got issue as follows:
[home]# mount  /dev/sdd  test
[home]# cd test
[test]# ls
dir1  lost+found
[test]# rmdir  dir1
ext2_empty_dir: inject fault
[test]# ls
lost+found
[test]# cd ..
[home]# umount test
[home]# fsck.ext2 -fn  /dev/sdd
e2fsck 1.42.9 (28-Dec-2013)
Pass 1: Checking inodes, blocks, and sizes
Inode 4065, i_size is 0, should be 1024.  Fix? no

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Unconnected directory inode 4065 (/???)
Connect to /lost+found? no

'..' in ... (4065) is / (2), should be <The NULL inode> (0).
Fix? no

Pass 4: Checking reference counts
Inode 2 ref count is 3, should be 4.  Fix? no

Inode 4065 ref count is 2, should be 3.  Fix? no

Pass 5: Checking group summary information

/dev/sdd: ********** WARNING: Filesystem still has errors **********

/dev/sdd: 14/128016 files (0.0% non-contiguous), 18477/512000 blocks

Reason is same with commit 7aab5c84a0f6. We can't assume directory
is empty when read directory entry failed.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext2/dir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 3bd5772b401b..8f597753ac12 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -672,17 +672,14 @@ int ext2_empty_dir (struct inode * inode)
 	void *page_addr = NULL;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
-	int dir_has_error = 0;
 
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		ext2_dirent * de;
-		page = ext2_get_page(inode, i, dir_has_error, &page_addr);
+		page = ext2_get_page(inode, i, 0, &page_addr);
 
-		if (IS_ERR(page)) {
-			dir_has_error = 1;
-			continue;
-		}
+		if (IS_ERR(page))
+			goto not_empty;
 
 		kaddr = page_addr;
 		de = (ext2_dirent *)kaddr;
-- 
2.31.1


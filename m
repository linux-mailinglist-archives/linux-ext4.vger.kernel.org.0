Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD374E251E
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbiCULUc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346400AbiCULUb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 07:20:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A7D2B246;
        Mon, 21 Mar 2022 04:19:07 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KMXCL034dzfYvD;
        Mon, 21 Mar 2022 19:17:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 19:19:05 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: Fix symlink file size not match to file content
Date:   Mon, 21 Mar 2022 19:34:08 +0800
Message-ID: <20220321113408.4112428-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got issue as follows:
[home]# fsck.ext4  -fn  ram0yb
e2fsck 1.45.6 (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
Clear? no
Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
Fix? no

As symlink file size not match to file content. If symlink data block writback
failed, will call ext4_finish_bio to end io. In this path don't mark buffer
error. When umount do checkpoint can't detect buffer error, then will cleanup
jounral. Actually, correct data maybe in journal area.
To solve this issue, mark buffer error when detect bio error in ext4_finish_bio.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/page-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 495ce59fb4ad..14695e2b5042 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -134,8 +134,10 @@ static void ext4_finish_bio(struct bio *bio)
 				continue;
 			}
 			clear_buffer_async_write(bh);
-			if (bio->bi_status)
+			if (bio->bi_status) {
+				set_buffer_write_io_error(bh);
 				buffer_io_error(bh);
+			}
 		} while ((bh = bh->b_this_page) != head);
 		spin_unlock_irqrestore(&head->b_uptodate_lock, flags);
 		if (!under_io) {
-- 
2.31.1


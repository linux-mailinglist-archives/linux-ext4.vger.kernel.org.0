Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1C35101E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhDAHcu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 03:32:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15064 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhDAHc2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 03:32:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9vvt4lHjzPnPf;
        Thu,  1 Apr 2021 15:29:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 15:32:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>,
        Liu Zhi Qiang <liuzhiqiang26@huawei.com>
Subject: [PATCH v2] ext4: Fix ext4_error_err save negative errno into superblock
Date:   Thu, 1 Apr 2021 15:40:17 +0800
Message-ID: <20210401074017.3382721-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As read_mmp_block return 1 when failed. read_mmp_block return -EIO when buffer
isn't uptodate.

Fixes: 54d3adbc29f0 ("ext4: save all error info in save_error_info() and
drop ext4_set_errno()")
Reported-by: Liu Zhi Qiang <liuzhiqiang26@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 795c3ff2907c..68fbeedd627b 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -56,7 +56,7 @@ static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
 	wait_on_buffer(bh);
 	sb_end_write(sb);
 	if (unlikely(!buffer_uptodate(bh)))
-		return 1;
+		return -EIO;
 
 	return 0;
 }
-- 
2.25.4


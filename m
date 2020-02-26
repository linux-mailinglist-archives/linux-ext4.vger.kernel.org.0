Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EC616F654
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 05:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgBZEDA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 23:03:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgBZEDA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Feb 2020 23:03:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ACD44E05E179D99C0981;
        Wed, 26 Feb 2020 12:02:57 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 26 Feb 2020 12:02:50 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>
Subject: [PATCH] ext4: using matching invalidatepage in ext4_writepage
Date:   Wed, 26 Feb 2020 12:10:02 +0800
Message-ID: <20200226041002.13914-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.23.0.rc2.8.gff66981f45
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Run generic/388 with journal data mode sometimes may trigger the warning
in ext4_invalidatepage. Actually, we should use the matching invalidatepage
in ext4_writepage.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..78e805d42ada 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1974,7 +1974,7 @@ static int ext4_writepage(struct page *page,
 	bool keep_towrite = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
-		ext4_invalidatepage(page, 0, PAGE_SIZE);
+		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
 		unlock_page(page);
 		return -EIO;
 	}
-- 
2.23.0.rc2.8.gff66981f45


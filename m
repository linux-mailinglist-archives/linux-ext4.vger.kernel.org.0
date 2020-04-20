Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863321B006A
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 06:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDTECp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 00:02:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2411 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbgDTECp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 00:02:45 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AAF9E83FB686C24A5816;
        Mon, 20 Apr 2020 12:02:42 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 12:02:36 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <enwlinux@gmail.com>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ext4: remove unnecessary comparisons to bool
Date:   Mon, 20 Apr 2020 12:29:18 +0800
Message-ID: <20200420042918.19459-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the following coccicheck warning:

fs/ext4/extents_status.c:1057:5-28: WARNING: Comparison to bool
fs/ext4/inode.c:2314:18-24: WARNING: Comparison to bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/extents_status.c | 2 +-
 fs/ext4/inode.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index d996b44d2265..e75171535375 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1054,7 +1054,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	end = (end > ext4_es_end(es)) ? ext4_es_end(es) : end;
 
 	/* record the first block of the first delonly extent seen */
-	if (rc->first_do_lblk_found == false) {
+	if (!rc->first_do_lblk_found) {
 		rc->first_do_lblk = i;
 		rc->first_do_lblk_found = true;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..acb8fedcba76 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2311,7 +2311,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			 * mapping, or maybe the page was submitted for IO.
 			 * So we return to call further extent mapping.
 			 */
-			if (err < 0 || map_bh == true)
+			if (err < 0 || map_bh)
 				goto out;
 			/* Page fully mapped - let IO run! */
 			err = mpage_submit_page(mpd, page);
-- 
2.21.1


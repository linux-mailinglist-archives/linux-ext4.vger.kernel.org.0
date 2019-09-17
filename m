Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF46AB4976
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 10:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfIQI1r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 04:27:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbfIQI1q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 04:27:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E7B616B0DCC609009FE5;
        Tue, 17 Sep 2019 16:27:44 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 17 Sep 2019 16:27:39 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] ext4: fix a bug in ext4_wait_for_tail_page_commit
Date:   Tue, 17 Sep 2019 16:48:14 +0800
Message-ID: <20190917084814.40370-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

No need to wait when offset equals to 0. And it will trigger a bug since
the latter __ext4_journalled_invalidatepage can free the buffers but leave
page still dirty.

[   26.057508] ------------[ cut here ]------------
[   26.058531] kernel BUG at fs/ext4/inode.c:2134!
...
[   26.088130] Call trace:
[   26.088695]  ext4_writepage+0x914/0xb28
[   26.089541]  writeout.isra.4+0x1b4/0x2b8
[   26.090409]  move_to_new_page+0x3b0/0x568
[   26.091338]  __unmap_and_move+0x648/0x988
[   26.092241]  unmap_and_move+0x48c/0xbb8
[   26.093096]  migrate_pages+0x220/0xb28
[   26.093945]  kernel_mbind+0x828/0xa18
[   26.094791]  __arm64_sys_mbind+0xc8/0x138
[   26.095716]  el0_svc_common+0x190/0x490
[   26.096571]  el0_svc_handler+0x60/0xd0
[   26.097423]  el0_svc+0x8/0xc

Run below parallel can reproduce it easily(ext3):
void main()
{
        int fd, fd1, fd2, fd3, ret;
        void *addr;
        size_t length = 4096;
        int flags;
        off_t offset = 0;
        char *str = "12345";

        fd = open("a", O_RDWR | O_CREAT);
        assert(fd >= 0);

        ret = ftruncate(fd, length);
        assert(ret == 0);

        fd1 = open("a", O_RDWR | O_CREAT, -1);
        assert(fd1 >= 0);

        flags = 0xc00f;/*Journal data mode*/
        ret = ioctl(fd1, _IOW('f', 2, long), &flags);
        assert(ret == 0);

        fd2 = open("a", O_RDWR | O_CREAT);
        assert(fd2 >= 0);

        fd3 = open("a", O_TRUNC | O_NOATIME);
        assert(fd3 >= 0);

        addr = mmap(NULL, length, 0xe, 0x28013, fd2, offset);
        assert(addr != (void *)-1);
        memcpy(addr, str, 5);
        mbind(addr, length, 0, 0, 0, 2);

        close(fd);
        munmap(addr, length);
}

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 006b7a2070bf..a9943ae4f74d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5479,7 +5479,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 	 * do. We do the check mainly to optimize the common PAGE_SIZE ==
 	 * blocksize case
 	 */
-	if (offset > PAGE_SIZE - i_blocksize(inode))
+	if (!offset || offset > PAGE_SIZE - i_blocksize(inode))
 		return;
 	while (1) {
 		page = find_lock_page(inode->i_mapping,
-- 
2.17.2


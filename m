Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBDB415DF3
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Sep 2021 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhIWMOF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Sep 2021 08:14:05 -0400
Received: from mx24.baidu.com ([111.206.215.185]:38184 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240619AbhIWMOE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Sep 2021 08:14:04 -0400
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id 310902381A84B4CE59AF;
        Thu, 23 Sep 2021 20:12:30 +0800 (CST)
Received: from BJHW-MAIL-EX28.internal.baidu.com (10.127.64.43) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 23 Sep 2021 20:12:30 +0800
Received: from localhost.localdomain (172.31.62.16) by
 BJHW-MAIL-EX28.internal.baidu.com (10.127.64.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 23 Sep 2021 20:12:29 +0800
From:   xueqingwen <xueqingwen@baidu.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        xueqingwen <xueqingwen@baidu.com>, zhaojie <zhaojie17@baidu.com>,
        jimyan <jimyan@baidu.com>
Subject: [PATCH] ext4: start the handle later in ext4_writepages() to avoid unnecessary wait
Date:   Thu, 23 Sep 2021 20:12:04 +0800
Message-ID: <20210923121204.5772-1-xueqingwen@baidu.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.16]
X-ClientProxiedBy: BC-MAIL-EX01.internal.baidu.com (172.31.51.41) To
 BJHW-MAIL-EX28.internal.baidu.com (10.127.64.43)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The mpage_prepare_extent_to_map() was called in ext4_writepages() to find
pages that need mapping. It probably waited for locking page in
mpage_prepare_extent_to_map() while the handle had been started, which
would block the commit of corresponding transaction and further likely to
cause the I/O request delays jitter in other cgroups.

This problem was touched in our pressure test environment as follow:
There were two equivalent database server processes, which meet key-value
request of data access by exposing different ports in a machine. They were
attached to cgroup A and cgroup B, separately. They shared the same NVME
SSD, and the io read/write bandwidth of the SSD was limited to 20Mbps by
using io.max in cgroup A and the bandwidth limit was not set in cgroup B.
Then the read/write requests with same pressure would be continuously sent
to the two server processes separately and simultaneously. Our expectation
is that the server process in cgroup B could meet the request latency
metrics.

According to the previous discussion in upstream community,
the dioread_nolock was mounted for ext4 and the io priority inversion
problem has indeed been alleviated to a great extent. However, in the
above test scenario, the write request of server process in cgroup B would
be hanged occasionally with servel sceconds, causing a sharp increase of
request latency. The stacktraces when hanging were captured as follows:

PID: 7602  COMMAND: "jbd2/nvme0n1-8":
 #0 __schedule
 #1 schedule
 #2 jbd2_journal_commit_transaction
 #3 kjournald2
 #4 kthread
 #5 ret_from_fork

PID: 55526 COMMAND: "kworker/u114:9":
 #0 __schedule
 #1 schedule
 #2 io_schedule
 #3 __lock_page
 #4 mpage_prepare_extent_to_map
 #5 ext4_writepages
 #6 do_writepages
 #7 __writeback_single_inode
 #8 writeback_sb_inodes
 #9 __writeback_inodes_wb

PID: 109830  COMMAND: "snnode":
 #0 __schedule
 #1 schedule
 #2 io_schedule
 #3 wait_on_page_bit
 #4 mpage_prepare_extent_to_map
 #5 ext4_writepages
 #6 do_writepages
 #7 __filemap_fdatawrite_range
 #8 file_write_and_wait_range
 #9 ext4_sync_file

By analyzing the above stack information, it indicated that the process
named "kworker/u114:9" was waitting for locking a page while holding a
handle. The page was locked by the process named "snnode", which belonged
to cgroup A, and its writeback to block device was throttled. Then the
Kjournald2 process had to wait the handle being stopped to commit current
transaction. Then it caused the I/O request delays jitter from the cgroup
B.

Therefore, the handle was delayed to start until finding the pages that
need mapping in ext4_writepages(). With this patch, the above problem did
not recur. We had looked this patch over pretty carefully, but another pair
of eyes would be appreciated. Please help to review whether there are
defects and whether it can be merged to upstream.

Thanks.

Co-developed-by: zhaojie <zhaojie17@baidu.com>
Signed-off-by: zhaojie <zhaojie17@baidu.com>
Signed-off-by: xueqingwen <xueqingwen@baidu.com>
Signed-off-by: jimyan <jimyan@baidu.com>
---
 fs/ext4/inode.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d18852d6029c..29bb7ab3e01f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2785,26 +2785,32 @@ static int ext4_writepages(struct address_space *mapping,
 		BUG_ON(ext4_should_journal_data(inode));
 		needed_blocks = ext4_da_writepages_trans_blocks(inode);
 
-		/* start a new transaction */
-		handle = ext4_journal_start_with_reserve(inode,
-				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
-		if (IS_ERR(handle)) {
-			ret = PTR_ERR(handle);
-			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
-			       "%ld pages, ino %lu; err %d", __func__,
-				wbc->nr_to_write, inode->i_ino, ret);
-			/* Release allocated io_end */
-			ext4_put_io_end(mpd.io_submit.io_end);
-			mpd.io_submit.io_end = NULL;
-			break;
-		}
 		mpd.do_map = 1;
 
 		trace_ext4_da_write_pages(inode, mpd.first_page, mpd.wbc);
 		ret = mpage_prepare_extent_to_map(&mpd);
-		if (!ret && mpd.map.m_len)
+		if (!ret && mpd.map.m_len) {
+			/* start a new transaction */
+			handle = ext4_journal_start_with_reserve(inode,
+					EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
+			if (IS_ERR(handle)) {
+				ret = PTR_ERR(handle);
+				ext4_msg(inode->i_sb, KERN_CRIT,
+					"%s: jbd2_start: %ld pages, ino %lu; err %d",
+					__func__, wbc->nr_to_write, inode->i_ino, ret);
+				/*submit prepared bio if has*/
+				ext4_io_submit(&mpd.io_submit);
+
+				/* Release allocated io_end */
+				ext4_put_io_end(mpd.io_submit.io_end);
+				mpd.io_submit.io_end = NULL;
+				/*unlock pages we don't use */
+				mpage_release_unused_pages(&mpd, false);
+				break;
+			}
 			ret = mpage_map_and_submit_extent(handle, &mpd,
 					&give_up_on_write);
+		}
 		/*
 		 * Caution: If the handle is synchronous,
 		 * ext4_journal_stop() can wait for transaction commit
@@ -2815,7 +2821,7 @@ static int ext4_writepages(struct address_space *mapping,
 		 * and dropped io_end reference (for extent conversion
 		 * to be able to complete) before stopping the handle.
 		 */
-		if (!ext4_handle_valid(handle) || handle->h_sync == 0) {
+		if (handle && (!ext4_handle_valid(handle) || handle->h_sync == 0)) {
 			ext4_journal_stop(handle);
 			handle = NULL;
 			mpd.do_map = 0;
-- 
2.17.1


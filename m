Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D52021DA
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Jun 2020 08:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFTGSv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Jun 2020 02:18:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFTGSv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 20 Jun 2020 02:18:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7BE37845AC0B27A23F2;
        Sat, 20 Jun 2020 14:18:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 14:18:40 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <jiufei.xue@linux.alibaba.com>
Subject: [PATCH] jbd2: add the missing unlock_buffer() in the error path of jbd2_write_superblock()
Date:   Sat, 20 Jun 2020 14:19:48 +0800
Message-ID: <20200620061948.2049579-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_write_superblock() is under the buffer lock of journal superblock
before ending that superblock write, so add a missing unlock_buffer() in
in the error path before submitting buffer.

Fixes: 742b06b5628f ("jbd2: check superblock mapped prior to committing")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: stable@kernel.org
---
 fs/jbd2/journal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a49d0e670ddf..55c4ec4edf96 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1366,8 +1366,10 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
 	int ret;
 
 	/* Buffer got discarded which means block device got invalidated */
-	if (!buffer_mapped(bh))
+	if (!buffer_mapped(bh)) {
+		unlock_buffer(bh);
 		return -EIO;
+	}
 
 	trace_jbd2_write_superblock(journal, write_flags);
 	if (!(journal->j_flags & JBD2_BARRIER))
-- 
2.25.4


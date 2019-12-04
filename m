Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C89112B70
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLDMZ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 07:25:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbfLDMZ1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Dec 2019 07:25:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3416EC20B49CA12C697D;
        Wed,  4 Dec 2019 20:25:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 20:25:18 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v3 3/4] jbd2: make sure ESHUTDOWN to be recorded in the journal superblock
Date:   Wed, 4 Dec 2019 20:46:13 +0800
Message-ID: <20191204124614.45424-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191204124614.45424-1-yi.zhang@huawei.com>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer") want
to allow jbd2 layer to distinguish shutdown journal abort from other
error cases. So the ESHUTDOWN should be taken precedence over any other
errno which has already been recoded after EXT4_FLAGS_SHUTDOWN is set,
but it only update errno in the journal suoerblock now if the old errno
is 0.

Fixes: fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b2d6e7666d0f..93be6e0311da 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2109,8 +2109,7 @@ static void __journal_abort_soft (journal_t *journal, int errno)
 
 	if (journal->j_flags & JBD2_ABORT) {
 		write_unlock(&journal->j_state_lock);
-		if (!old_errno && old_errno != -ESHUTDOWN &&
-		    errno == -ESHUTDOWN)
+		if (old_errno != -ESHUTDOWN && errno == -ESHUTDOWN)
 			jbd2_journal_update_sb_errno(journal);
 		return;
 	}
-- 
2.17.2


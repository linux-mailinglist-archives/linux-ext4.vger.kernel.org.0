Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8131144C57
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2020 08:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVHGp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jan 2020 02:06:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgAVHGp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Jan 2020 02:06:45 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E674C8FFB44EE909ACED;
        Wed, 22 Jan 2020 15:06:42 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 15:06:33 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <luoshijie1@huawei.com>
Subject: [PATCH] jbd2: modify assert condition in __journal_remove_journal_head
Date:   Wed, 22 Jan 2020 02:05:48 -0500
Message-ID: <20200122070548.64664-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Only when jh->b_jcount = 0 in jbd2_journal_put_journal_head, we are allowed
to call __journal_remove_journal_head.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 5e408ee24a1a..4f417a7f1ae0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2556,7 +2556,7 @@ static void __journal_remove_journal_head(struct buffer_head *bh)
 {
 	struct journal_head *jh = bh2jh(bh);
 
-	J_ASSERT_JH(jh, jh->b_jcount >= 0);
+	J_ASSERT_JH(jh, jh->b_jcount == 0);
 	J_ASSERT_JH(jh, jh->b_transaction == NULL);
 	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 	J_ASSERT_JH(jh, jh->b_cp_transaction == NULL);
-- 
2.19.1


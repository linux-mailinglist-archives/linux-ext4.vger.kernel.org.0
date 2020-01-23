Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD1146231
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 08:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAWHBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 02:01:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgAWHBo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 02:01:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 894CA83C3856B63D75FA;
        Thu, 23 Jan 2020 15:01:42 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 15:01:35 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <luoshijie1@huawei.com>
Subject: [PATCH v2] jbd2: remove pointless assertion in __journal_remove_journal_head
Date:   Thu, 23 Jan 2020 02:00:54 -0500
Message-ID: <20200123070054.50585-1-luoshijie1@huawei.com>
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
to call __journal_remove_journal_head. This assertion is meaningless,
just remove it.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 5e408ee24a1a..56510de63a3d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2556,7 +2556,6 @@ static void __journal_remove_journal_head(struct buffer_head *bh)
 {
 	struct journal_head *jh = bh2jh(bh);
 
-	J_ASSERT_JH(jh, jh->b_jcount >= 0);
 	J_ASSERT_JH(jh, jh->b_transaction == NULL);
 	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 	J_ASSERT_JH(jh, jh->b_cp_transaction == NULL);
-- 
2.19.1


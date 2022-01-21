Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0C495A5F
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jan 2022 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbiAUHMN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jan 2022 02:12:13 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55789 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378617AbiAUHMK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jan 2022 02:12:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V2QUdB3_1642749127;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V2QUdB3_1642749127)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 15:12:07 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     gautham.ananthakrishna@oracle.com, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
Date:   Fri, 21 Jan 2022 15:12:05 +0800
Message-Id: <20220121071205.100648-3-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
References: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

commit 6f1b228529ae introduces a regression which can deadlock as
follows:

Task1:                              Task2:
jbd2_journal_commit_transaction     ocfs2_test_bg_bit_allocatable
spin_lock(&jh->b_state_lock)        jbd_lock_bh_journal_head
__jbd2_journal_remove_checkpoint    spin_lock(&jh->b_state_lock)
jbd2_journal_put_journal_head
jbd_lock_bh_journal_head

Task1 and Task2 lock bh->b_state and jh->b_state_lock in different
order, which finally result in a deadlock.

So use jbd2_journal_[grab|put]_journal_head instead in
ocfs2_test_bg_bit_allocatable() to fix it.

Reported-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Fixes: 6f1b228529ae ("ocfs2: fix race between searching chunks and release journal_head from buffer_head")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/suballoc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 481017e1dac5..166c8918c825 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1251,26 +1251,23 @@ static int ocfs2_test_bg_bit_allocatable(struct buffer_head *bg_bh,
 {
 	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) bg_bh->b_data;
 	struct journal_head *jh;
-	int ret = 1;
+	int ret;
 
 	if (ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap))
 		return 0;
 
-	if (!buffer_jbd(bg_bh))
+	jh = jbd2_journal_grab_journal_head(bg_bh);
+	if (!jh)
 		return 1;
 
-	jbd_lock_bh_journal_head(bg_bh);
-	if (buffer_jbd(bg_bh)) {
-		jh = bh2jh(bg_bh);
-		spin_lock(&jh->b_state_lock);
-		bg = (struct ocfs2_group_desc *) jh->b_committed_data;
-		if (bg)
-			ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
-		else
-			ret = 1;
-		spin_unlock(&jh->b_state_lock);
-	}
-	jbd_unlock_bh_journal_head(bg_bh);
+	spin_lock(&jh->b_state_lock);
+	bg = (struct ocfs2_group_desc *) jh->b_committed_data;
+	if (bg)
+		ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
+	else
+		ret = 1;
+	spin_unlock(&jh->b_state_lock);
+	jbd2_journal_put_journal_head(jh);
 
 	return ret;
 }
-- 
2.19.1.6.gb485710b


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748EE495A60
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jan 2022 08:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378617AbiAUHMY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jan 2022 02:12:24 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:21734 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378860AbiAUHMU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jan 2022 02:12:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V2QTsQP_1642749126;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V2QTsQP_1642749126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 15:12:07 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     gautham.ananthakrishna@oracle.com, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] jbd2: export jbd2_journal_[grab|put]_journal_head
Date:   Fri, 21 Jan 2022 15:12:04 +0800
Message-Id: <20220121071205.100648-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
References: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This exports symbols jbd2_journal_[grab|put]_journal_head, which will be
used outside modules, e.g. ocfs2.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/jbd2/journal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0b86a4365b66..e9f0c72f6664 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2972,6 +2972,7 @@ struct journal_head *jbd2_journal_grab_journal_head(struct buffer_head *bh)
 	jbd_unlock_bh_journal_head(bh);
 	return jh;
 }
+EXPORT_SYMBOL(jbd2_journal_grab_journal_head);
 
 static void __journal_remove_journal_head(struct buffer_head *bh)
 {
@@ -3024,6 +3025,7 @@ void jbd2_journal_put_journal_head(struct journal_head *jh)
 		jbd_unlock_bh_journal_head(bh);
 	}
 }
+EXPORT_SYMBOL(jbd2_journal_put_journal_head);
 
 /*
  * Initialize jbd inode head
-- 
2.19.1.6.gb485710b


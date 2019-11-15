Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841A1FDB35
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfKOKWQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Nov 2019 05:22:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:58396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfKOKWQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 Nov 2019 05:22:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A412B266;
        Fri, 15 Nov 2019 10:22:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3FA1E1E3BEA; Fri, 15 Nov 2019 11:22:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] jbd2: Make jbd2_handle_buffer_credits() handle reserved handles
Date:   Fri, 15 Nov 2019 11:22:10 +0100
Message-Id: <20191115102210.29445-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The helper jbd2_handle_buffer_credits() doesn't correctly handle reserved
handles which can lead to crashes. Fix it getting of journal pointer to
work for reserved handles as well.

Fixes: a9a8344ee171 ("ext4, jbd2: Provide accessor function for handle credits")
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/jbd2.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 3115eeb44039..a23a3528e07a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1648,10 +1648,14 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 	return tid;
 }
 
-
 static inline int jbd2_handle_buffer_credits(handle_t *handle)
 {
-	journal_t *journal = handle->h_transaction->t_journal;
+	journal_t *journal;
+
+	if (!handle->h_reserved)
+		journal = handle->h_transaction->t_journal;
+	else
+		journal = handle->h_journal;
 
 	return handle->h_total_credits -
 		DIV_ROUND_UP(handle->h_revoke_credits_requested,
-- 
2.16.4


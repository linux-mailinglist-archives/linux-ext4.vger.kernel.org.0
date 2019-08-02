Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DBE7FD31
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfHBPOU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 11:14:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:35270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730703AbfHBPOR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 11:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1E54B00E;
        Fri,  2 Aug 2019 15:14:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D04C31E434C; Fri,  2 Aug 2019 17:14:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] jbd2: Remove jbd_trylock_bh_state()
Date:   Fri,  2 Aug 2019 17:13:51 +0200
Message-Id: <20190802151356.777-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190802151356.777-1-jack@suse.cz>
References: <20190802151356.777-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/jbd2.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index df03825ad1a1..f53b13b20e83 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -347,11 +347,6 @@ static inline void jbd_lock_bh_state(struct buffer_head *bh)
 	bit_spin_lock(BH_State, &bh->b_state);
 }
 
-static inline int jbd_trylock_bh_state(struct buffer_head *bh)
-{
-	return bit_spin_trylock(BH_State, &bh->b_state);
-}
-
 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
 	return bit_spin_is_locked(BH_State, &bh->b_state);
-- 
2.16.4


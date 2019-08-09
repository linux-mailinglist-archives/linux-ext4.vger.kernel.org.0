Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429D787A5B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406832AbfHIMmm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 08:42:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406761AbfHIMml (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Aug 2019 08:42:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61291AF80;
        Fri,  9 Aug 2019 12:42:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7A5211E47C9; Fri,  9 Aug 2019 14:42:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 7/7] jbd2: Free journal head outside of locked region
Date:   Fri,  9 Aug 2019 14:42:33 +0200
Message-Id: <20190809124233.13277-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190809124233.13277-1-jack@suse.cz>
References: <20190809124233.13277-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On PREEMPT_RT bit-spinlocks have the same semantics as on PREEMPT_RT=n,
i.e. they disable preemption. That means functions which are not safe to be
called in preempt disabled context on RT trigger a might_sleep() assert.

The journal head bit spinlock is mostly held for short code sequences with
trivial RT safe functionality, except for one place:

jbd2_journal_put_journal_head() invokes __journal_remove_journal_head()
with the journal head bit spinlock held. __journal_remove_journal_head()
invokes kmem_cache_free() which must not be called with preemption disabled
on RT.

Jan suggested to rework the removal function so the actual free happens
outside the bit-spinlocked region.

Split it into two parts:

  - Do the sanity checks and the buffer head detach under the lock

  - Do the actual free after dropping the lock

There is error case handling in the free part which needs to dereference
the b_size field of the now detached buffer head. Due to paranoia (caused
by ignorance) the size is retrieved in the detach function and handed into
the free function. Might be over-engineered, but better safe than sorry.

This makes the journal head bit-spinlock usage RT compliant and also avoids
nested locking which is not covered by lockdep.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index eee350fef339..c79e6de2fcfc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2533,17 +2533,23 @@ static void __journal_remove_journal_head(struct buffer_head *bh)
 	J_ASSERT_BH(bh, buffer_jbd(bh));
 	J_ASSERT_BH(bh, jh2bh(jh) == bh);
 	BUFFER_TRACE(bh, "remove journal_head");
+
+	/* Unlink before dropping the lock */
+	bh->b_private = NULL;
+	jh->b_bh = NULL;	/* debug, really */
+	clear_buffer_jbd(bh);
+}
+
+static void journal_release_journal_head(struct journal_head *jh, size_t b_size)
+{
 	if (jh->b_frozen_data) {
 		printk(KERN_WARNING "%s: freeing b_frozen_data\n", __func__);
-		jbd2_free(jh->b_frozen_data, bh->b_size);
+		jbd2_free(jh->b_frozen_data, b_size);
 	}
 	if (jh->b_committed_data) {
 		printk(KERN_WARNING "%s: freeing b_committed_data\n", __func__);
-		jbd2_free(jh->b_committed_data, bh->b_size);
+		jbd2_free(jh->b_committed_data, b_size);
 	}
-	bh->b_private = NULL;
-	jh->b_bh = NULL;	/* debug, really */
-	clear_buffer_jbd(bh);
 	journal_free_journal_head(jh);
 }
 
@@ -2561,9 +2567,11 @@ void jbd2_journal_put_journal_head(struct journal_head *jh)
 	if (!jh->b_jcount) {
 		__journal_remove_journal_head(bh);
 		jbd_unlock_bh_journal_head(bh);
+		journal_release_journal_head(jh, bh->b_size);
 		__brelse(bh);
-	} else
+	} else {
 		jbd_unlock_bh_journal_head(bh);
+	}
 }
 
 /*
-- 
2.16.4


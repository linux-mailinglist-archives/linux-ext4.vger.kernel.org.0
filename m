Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF45E75BA
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2019 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfJ1QC0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Oct 2019 12:02:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38961 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728864AbfJ1QC0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Oct 2019 12:02:26 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9SG1bvq028794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 12:01:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E59C2420456; Mon, 28 Oct 2019 12:01:36 -0400 (EDT)
Date:   Mon, 28 Oct 2019 12:01:36 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 5/7] jbd2: Don't call __bforget() unnecessarily
Message-ID: <20191028160136.GC4404@mit.edu>
References: <20190809124233.13277-1-jack@suse.cz>
 <20190809124233.13277-6-jack@suse.cz>
 <20191028152808.GB4404@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028152808.GB4404@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 28, 2019 at 11:28:08AM -0400, Theodore Y. Ts'o wrote:
> drop:
> 	jbd_unlock_bh_state(bh);
> 	__brelse(bh);
> 	if (drop_reserve) {
> 		/* no need to reserve log space for this block -bzzz */
> 		handle->h_buffer_credits++;
> 	}
> 	return err;
> 
> not_jbd:
> 	jbd_unlock_bh_state(bh);
> 	__bforget(bh);
> 	goto drop;
> ----
> 
> And we still have a case we jump to not_jbd, at which point hilarity
> will ensue.
> 
> This is cleaned up in the following patch in this sequence, but this
> leaves us in a not-great state if we are ever bisecting.

Proposed fixup: I'll apply the following on top of this commit, and
then fix the merge conflicts in 6/7 so that the end result looks the
same as before.

Jan, any objections?  I figure this way it'll save you from resending
the patch series, since the rest of it looks fine to me.

							- Ted


diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index f2af4afc690a..c7c9a42451c7 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1541,8 +1541,11 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 
 	jbd_lock_bh_state(bh);
 
-	if (!buffer_jbd(bh))
-		goto not_jbd;
+	if (!buffer_jbd(bh)) {
+		jbd_unlock_bh_state(bh);
+		__bforget(bh);
+		return 0;
+	}
 	jh = bh2jh(bh);
 
 	/* Critical error: attempting to delete a bitmap buffer, maybe?
@@ -1671,11 +1674,6 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 		handle->h_buffer_credits++;
 	}
 	return err;
-
-not_jbd:
-	jbd_unlock_bh_state(bh);
-	__bforget(bh);
-	goto drop;
 }
 
 /**

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277E9E7512
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2019 16:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJ1P3D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Oct 2019 11:29:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57600 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727381AbfJ1P3D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Oct 2019 11:29:03 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9SFS8nn015744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 11:28:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A377F420456; Mon, 28 Oct 2019 11:28:08 -0400 (EDT)
Date:   Mon, 28 Oct 2019 11:28:08 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 5/7] jbd2: Don't call __bforget() unnecessarily
Message-ID: <20191028152808.GB4404@mit.edu>
References: <20190809124233.13277-1-jack@suse.cz>
 <20190809124233.13277-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809124233.13277-6-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 09, 2019 at 02:42:31PM +0200, Jan Kara wrote:
> @@ -1660,10 +1660,9 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
>  		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
>  		spin_unlock(&journal->j_list_lock);
>  	}
> -
> +drop:
>  	jbd_unlock_bh_state(bh);
>  	__brelse(bh);
> -drop:
>  	if (drop_reserve) {
>  		/* no need to reserve log space for this block -bzzz */
>  		handle->h_buffer_credits++;

(Workflow observation: this is an example where Gerrit can be *so*
*much* *better* than e-mail review at times; sometimes, you *really*
want to see more context than what e-mail affords you.)

After this patch, the resulting code looks like this:

-----
drop:
	jbd_unlock_bh_state(bh);
	__brelse(bh);
	if (drop_reserve) {
		/* no need to reserve log space for this block -bzzz */
		handle->h_buffer_credits++;
	}
	return err;

not_jbd:
	jbd_unlock_bh_state(bh);
	__bforget(bh);
	goto drop;
----

And we still have a case we jump to not_jbd, at which point hilarity
will ensue.

This is cleaned up in the following patch in this sequence, but this
leaves us in a not-great state if we are ever bisecting.

					- Ted

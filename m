Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67363D9795
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405823AbfJPQit (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 12:38:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58007 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728849AbfJPQit (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 12:38:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GGcjVe018540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 12:38:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EC9A7420458; Wed, 16 Oct 2019 12:38:44 -0400 (EDT)
Date:   Wed, 16 Oct 2019 12:38:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 03/13] jbd2: fast-commit commit path changes
Message-ID: <20191016163844.GC11103@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-4-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-4-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:52AM -0700, Harshad Shirwadkar wrote:
> This patch adds core fast-commit commit path changes. This patch also
> modifies existing JBD2 APIs to allow usage of fast commits. If fast
> commits are enabled and journal->j_do_full_commit is not set,

This flag should really be a property of the transaction, not the
journal.  Otherwise it might not be clear what transaction is meant in
jbd2_log_start_commit():

> @@ -522,11 +539,23 @@ int jbd2_log_start_commit(journal_t *journal, tid_t tid)
>  	int ret;
>  
>  	write_lock(&journal->j_state_lock);
> +	journal->j_do_full_commit = true;
>  	ret = __jbd2_log_start_commit(journal, tid);
>  	write_unlock(&journal->j_state_lock);
>  	return ret;
>  }

Does tid refer to the transaction which is just starting to be
committed?  Or the next transaction?

If we make the flag be attached to the transaction, then it's very
clear which transaction must be a full commit, and I think it will
simplify things.

> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 132fb92098c7..7db3e2b6336d 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> + * fc is input / output parameter. If fc is non-null and is set to true, this
> + * function tries to perform fast commit. If the fast commit is successfully
> + * performed, *fc is set to true.
>   */
> -void jbd2_journal_commit_transaction(journal_t *journal)
> +void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)

I think it's going to make things much simpler if we pull out the code
which does fast commits, which was added to this function, into its
own function, jbd2_fast_commit_transaction().

Right now the logic regarding whether to do a fast commit or a full
commit is split between kjournald2() and
jbd2_journal_commit_transact() --- and once we implement asynchronous
fast commits, it doesn't make sense to even have some of this logic.

I think it will be easier if you modify the commits to add support for
asynchronous commits from the beginning.  In that world, we don't need
to have the fast commit logic inside jbd2_journal_commit_transaction(),
and that means we don't have to add the fc variable.

It also avoids a minor inconsistency in the current code, where in
order to have kjournald2() actually call
jbd2_journal_commit_transaction(), we have to bump the
j_commit_request indicating that we want to commit the current
transaction.  But then if we can do the fast commit, j_commit_request
is left indicating that there is an outstanding request that the
existing transaction be committed --- but we don't start committing
it.

That's going to be confusing for future debugging, and I could imagine
current or existing code thinking that there has already been a
request to start committing the current transaction, so it doesn't try
waking up the kjournald2 thread.

> @@ -160,7 +160,13 @@ static void commit_timeout(struct timer_list *t)
>   *
>   * 1) COMMIT:  Every so often we need to commit the current state of the
>   *    filesystem to disk.  The journal thread is responsible for writing
> - *    all of the metadata buffers to disk.
> + *    all of the metadata buffers to disk. If fast commits are allowed,
> + *    journal thread passes the control to the file system and file system
> + *    is then responsible for writing metadata buffers to disk (in whichever
> + *    format it wants). If fast commit succeds, journal thread won't perform
> + *    a normal commit. In case the fast commit fails, journal thread performs
> + *    full commit as normal.

Note: this commit needs to be updated once we are doing async fc
commits.

> @@ -702,12 +745,27 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
>  	}
>  #endif
>  	while (tid_gt(tid, journal->j_commit_sequence)) {
> -		jbd_debug(1, "JBD2: want %u, j_commit_sequence=%u\n",
> -				  tid, journal->j_commit_sequence);
> +		if ((!journal->j_do_full_commit) &&
> +		    !tid_gt(subtid, journal->j_fc_sequence))
> +			break;
> +		jbd_debug(1, "JBD2: want full commit %u %s %u, ",
> +			  tid, journal->j_do_full_commit ?
> +			  "and ignoring fast commit request for " :
> +			  "or want fast commit",
> +			  journal->j_fc_sequence);
> +		jbd_debug(1, "j_commit_sequence=%u, j_fc_sequence=%u\n",
> +			  journal->j_commit_sequence,
> +			  journal->j_fc_sequence);
>  		read_unlock(&journal->j_state_lock);
>  		wake_up(&journal->j_wait_commit);
> -		wait_event(journal->j_wait_done_commit,
> -				!tid_gt(tid, journal->j_commit_sequence));
> +		if (journal->j_do_full_commit)
> +			wait_event(journal->j_wait_done_commit,
> +				   !tid_gt(tid, journal->j_commit_sequence));
> +		else
> +			wait_event(journal->j_wait_done_commit,
> +				   !tid_gt(tid, journal->j_commit_sequence) ||
> +				   !tid_gt(subtid,
> +					    journal->j_fc_sequence));
>  		read_lock(&journal->j_state_lock);
>  	}
>  	read_unlock(&journal->j_state_lock);

This change is also not needed with async fast commits, right?

          	       	    	       - Ted

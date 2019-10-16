Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF97D986D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbfJPR0q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 13:26:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40184 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388525AbfJPR0p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 13:26:45 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GHKoE4001671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 13:20:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 84555420458; Wed, 16 Oct 2019 13:20:50 -0400 (EDT)
Date:   Wed, 16 Oct 2019 13:20:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 04/13] jbd2: fast-commit commit path new APIs
Message-ID: <20191016172050.GD11103@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-5-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-5-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:53AM -0700, Harshad Shirwadkar wrote:
> This patch adds new helper APIs that ext4 needs for fast
> commits. These new fast commit APIs are used by subsequent fast commit
> patches to implement fast commits. Following new APIs are added:
> 
> /*
>  * Returns when either a full commit or a fast commit
>  * completes
>  */
> int jbd2_fc_complete_commit(journal_tc *journal, tid_t tid,
> 			                tid_t subtid)
> 
> /* Send all the data buffers related to an inode */
> int journal_submit_inode_data(journal_t *journal,
> 			                  struct jbd2_inode *jinode)
> 
> /* Map one fast commit buffer for use by the file system */
> int jbd2_map_fc_buf(journal_t *journal, struct buffer_head **bh_out)
> 
> /* Wait on fast commit buffers to complete IO */
> jbd2_wait_on_fc_bufs(journal_t *journal, int num_bufs)
> 
> /*
>  * Returns 1 if transaction identified by tid:subtid is already
>  * committed.
>  */
> int jbd2_commit_check(journal_t *journal, tid_t tid, tid_t subtid)

Please move these commits into the code, before each function.  This
documentation is going to be useful long after the patch gets merged,
and people will be looking for them in the source code, and not
necessarily in the commit description.

> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 7db3e2b6336d..e85f51e1cc70 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -202,6 +202,38 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
>  	return ret;
>  }
>  
> +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)

This code was pulled out of journal_submit_data_buffers(), but given
how it was called, there were locking assumptions that were broken as
a result.

> +{
> +	struct address_space *mapping;
> +	loff_t dirty_start = jinode->i_dirty_start;
> +	loff_t dirty_end = jinode->i_dirty_end;
> +	int ret;
> +
> +	if (!jinode)
> +		return 0;
> +
> +	if (!(jinode->i_flags & JI_WRITE_DATA))
> +		return 0;

Originally in journal_submit_data_buffers() we were holding onto
j_list_lock, and that's needed to safely reference jinode->i_flags

> +
> +	dirty_start = jinode->i_dirty_start;
> +	dirty_end = jinode->i_dirty_end;
> +
> +	mapping = jinode->i_vfs_inode->i_mapping;
> +	jinode->i_flags |= JI_COMMIT_RUNNING;

Originally there was a spin_uinlock(&journal->j_list_lock) here.  And
that's important since there was a memory barrier there which we
needed in order to make sure other CPU's would see the
JI_COMMIT_RUNNING flag.

It's not clear we need to worry about this, if this is only going to
be used in the async fast commit context.  This is another example of
how trying to do the fast commit in the userspace (or nfs server's)
process context is much simpler, since the the JI_COMMIT_RUNNING flag
is needed to make sure there isn't a race with the inode getting
evicted and jbd2_journal_release_jbd_inode.

And if we're calling this function from ext4_jbd2.c, where the inode's
ref count is elevated and there is no risk of the inode getting
evicted from memory, then this particular race is not a problem, and
so messing with JI_COMMIT_RUNNING and the call to wake_up_bit is all
not necessary.

By the way, this function only submits the data to be written out.  It
does not wait for the writeout to be completed.  For that, you need
the equivalent of journal_finish_inode_data_buffers(), and I don't see
that equivalent functionality in the fast commit code path?

     			      	     - Ted

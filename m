Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A032D91E8
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393404AbfJPNDL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 09:03:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37930 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728878AbfJPNDL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 09:03:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GD35we032317
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 09:03:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0F206420458; Wed, 16 Oct 2019 09:03:05 -0400 (EDT)
Date:   Wed, 16 Oct 2019 09:03:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 02/13] jbd2: fast commit setup and enable
Message-ID: <20191016130305.GB31394@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-3-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-3-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:51AM -0700, Harshad Shirwadkar wrote:
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 953990eb70a9..7c13834873ad 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1159,12 +1159,15 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_blk_offset = start;
>  	journal->j_maxlen = len;
>  	n = journal->j_blocksize / sizeof(journal_block_tag_t);
> -	journal->j_wbufsize = n;
> +	journal->j_wbufsize = n - JBD2_FAST_COMMIT_BLOCKS;
>  	journal->j_wbuf = kmalloc_array(n, sizeof(struct buffer_head *),
>  					GFP_KERNEL);
>  	if (!journal->j_wbuf)
>  		goto err_cleanup;
>  
> +	journal->j_fc_wbuf = &journal->j_wbuf[journal->j_wbufsize];
> +	journal->j_fc_wbufsize = JBD2_FAST_COMMIT_BLOCKS;
> +
>  	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
>  	if (!bh) {
>  		pr_err("%s: Cannot get buffer for journal superblock\n",

This is being done unconditionally, regardless of whether or not fast
commit has been enabled.  As a result, for the non-fc case, j_wbufsize
is going to be unconditionally reduced in size, which would be
unfortunate.

I suggest what you do is create a new function, called
jbd2_init_fast_commit() which is called from ext4_init_fast_commit(),
added in later patch, and which takes as an argument the size of the
fast_commit region (e.g., what is currently the constant
JBD2_FAST_COMMIT_BLOCKS), since this should be under the control of
the file system.

We can then pull these changes out of journal_init_common(), and move
them into jbd2_init_fast_commit().

> -/**
> - * int jbd2_journal_load() - Read journal from disk.
> - * @journal: Journal to act on.
> - *
> - * Given a journal_t structure which tells us which disk blocks contain
> - * a journal, read the journal from disk to initialise the in-memory
> - * structures.
> - */
> -int jbd2_journal_load(journal_t *journal)
> +static int __jbd2_journal_load(journal_t *journal, bool enable_fc)
>  {
>  	int err;
>  	journal_superblock_t *sb;

Instead of adding __jbd2_journal_load() with its enable_fc flag, we
can just test based on journal->j_fc_wbufsize being non-zero.  That
will have been set by jbd2_init_fast_commit(), which is called before
jbd2_journal_load().

As a result, we won't need to add __jbd2_journal_load() and the
jbd2_load_with_fc() functions.

> @@ -1684,6 +1694,12 @@ int jbd2_journal_load(journal_t *journal)
>  		return -EFSCORRUPTED;
>  	}
>  
> +	if (enable_fc)
> +		jbd2_journal_set_features(journal, 0, 0,
> +					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> +	else
> +		jbd2_journal_clear_features(journal, 0, 0,
> +					    JBD2_FEATURE_INCOMPAT_FAST_COMMIT);

We don't actually need to clear the feature, since it gets cleared
after the journal is successfully replayed.

> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index b7eed49b8ecd..84d04e1f3d92 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -918,6 +919,30 @@ struct journal_s
>  	 */
>  	unsigned long		j_last;
>  
> +	/**
> +	 * @j_first_fc:
> +	 *
> +	 * The block number of the first fast commit block in the journal
> +	 * [j_state_lock].
> +	 */
> +	unsigned long		j_first_fc;

Is this really protected by j_state_lock?  It's setup at journal load
time, and then never changed.  As a result, it's safe to read
j_first_fc without first taking the j_state_lock.

> +
> +	/**
> +	 * @j_fc_off:
> +	 *
> +	 * Number of fast commit blocks currently allocated.
> +	 * [j_state_lock].
> +	 */
> +	unsigned long		j_fc_off;

I'll mention this later, but we're not *actually* taking j_state_lock
when accessing j_fc_off.  In particular, jbd2_map_fc_buf() and its
caller (ext4_journal_fc_commit_cb) isn't taking j_state_lock.

I haven't had a chance to trace the locking hierarchy to figure out
whether the documentation or the locking is wrong, but my first
initial read is that the locking might be wrong?

> +
> +	/**
> +	 * @j_last_fc:
> +	 *
> +	 * The block number one beyond the last fast commit block in the journal
> +	 * [j_state_lock].
> +	 */
> +	unsigned long		j_last_fc;
> +

Again, this should never change once the journal structure is set up,
so it doesn't need to be protected by j_state_lock.

						- Ted

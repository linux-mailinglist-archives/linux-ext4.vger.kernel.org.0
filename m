Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03F2A4B7F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 17:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKCQ3q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 11:29:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:44514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbgKCQ3q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 11:29:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49FE4AC3F;
        Tue,  3 Nov 2020 16:29:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02B4E1E12FB; Tue,  3 Nov 2020 17:29:43 +0100 (CET)
Date:   Tue, 3 Nov 2020 17:29:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 04/10] ext4: clean up the JBD2 API that initializes fast
 commits
Message-ID: <20201103162943.GH3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-5-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-5-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:12, Harshad Shirwadkar wrote:
> This patch cleans up the jbd2_fc_init() API and its related functions
> to simplify enabling fast commits and configuring the number of blocks
> that fast commits will use. With this change, the number of fast
> commit blocks to use is solely determined by the JBD2 layer. However,
> whether or not to use fast commits is determined by the file
> system. The file system just calls jbd2_fc_init() to tell the JBD2
> layer that it is interested in enabling fast commits. JBD2 layer
> determines how many blocks to use for fast commits (based on the value
> found in the JBD2 superblock).
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks for the cleanup. Some comments below...

> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index fa688e163a80..353534403769 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -801,7 +801,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		if (first_block < journal->j_tail)
>  			freed += journal->j_last - journal->j_first;
>  		/* Update tail only if we free significant amount of space */
> -		if (freed < journal->j_maxlen / 4)
> +		if (freed < (journal->j_maxlen - journal->j_fc_wbufsize) / 4)
>  			update_tail = 0;

This change seems unrelated to the API change in jbd2_fc_init(). Can you
please separate fix for journal length handling into a separate patch with
a proper changelog etc.?

Also can you perhaps rename j_maxlen to j_total_len to give better hint
that there may be multiple parts of the journal and provide wrapper
jbd2_transaction_space(journal) for the
(journal->j_maxlen - journal->j_fc_wbufsize) expression because that's kind
of implementation detail of the current fastcommit code.

> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 0c7c42bd530f..ea15f55aff5c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1357,14 +1357,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (!journal->j_wbuf)
>  		goto err_cleanup;
>  
> -	if (journal->j_fc_wbufsize > 0) {
> -		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> -					sizeof(struct buffer_head *),
> -					GFP_KERNEL);
> -		if (!journal->j_fc_wbuf)
> -			goto err_cleanup;
> -	}
> -
>  	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
>  	if (!bh) {
>  		pr_err("%s: Cannot get buffer for journal superblock\n",
> @@ -1378,19 +1370,21 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  err_cleanup:
>  	kfree(journal->j_wbuf);
> -	kfree(journal->j_fc_wbuf);
>  	jbd2_journal_destroy_revoke(journal);
>  	kfree(journal);
>  	return NULL;
>  }
>  
> -int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> +int jbd2_fc_init(journal_t *journal)
>  {
> -	journal->j_fc_wbufsize = num_fc_blks;
> -	journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> -				sizeof(struct buffer_head *), GFP_KERNEL);
> -	if (!journal->j_fc_wbuf)
> -		return -ENOMEM;
> +	/*
> +	 * Only set j_fc_wbufsize here to indicate that the client file
> +	 * system is interested in using fast commits. The actual number of
> +	 * fast commit blocks is found inside jbd2_superblock and is only
> +	 * valid if j_fc_wbufsize is non-zero. The real value of j_fc_wbufsize
> +	 * gets set in journal_reset().
> +	 */
> +	journal->j_fc_wbufsize = JBD2_MIN_FC_BLOCKS;
>  	return 0;
>  }

When looking at this, is there a reason why jbd2_fc_init() still exists?  I
mean why not just make the rule that the journal has FC block number set
iff FC gets enabled? Anything else seems a bit confusing to me and also
dangerous - imagine we have fs with FC running, we write some FCs and then
crash. Then on system recovery we mount with no_fc mount option. We have
just lost data on the filesystem AFAIU... So I'd just remove all the mount
options related to fastcommits and leave everything to the journal setup
(which can be modified with e2fsprogs if needed) to keep things simple.

>  EXPORT_SYMBOL(jbd2_fc_init);
> @@ -1500,7 +1494,7 @@ static void journal_fail_superblock(journal_t *journal)
>  static int journal_reset(journal_t *journal)
>  {
>  	journal_superblock_t *sb = journal->j_superblock;
> -	unsigned long long first, last;
> +	unsigned long long first, last, num_fc_blocks;
>  
>  	first = be32_to_cpu(sb->s_first);
>  	last = be32_to_cpu(sb->s_maxlen);
> @@ -1513,6 +1507,28 @@ static int journal_reset(journal_t *journal)
>  
>  	journal->j_first = first;
>  
> +	/*
> +	 * At this point, fast commit recovery has finished. Now, we solely
> +	 * rely on the file system to decide whether it wants fast commits
> +	 * or not. File system that wishes to use fast commits must have
> +	 * already called jbd2_fc_init() before we get here.
> +	 */
> +	if (journal->j_fc_wbufsize > 0)
> +		jbd2_journal_set_features(journal, 0, 0,
> +					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> +	else
> +		jbd2_journal_clear_features(journal, 0, 0,
> +					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> +
> +	/* If valid, prefer the value found in superblock over the default */
> +	num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
> +	if (num_fc_blocks > 0 && num_fc_blocks < last)
> +		journal->j_fc_wbufsize = num_fc_blocks;
> +
> +	if (jbd2_has_feature_fast_commit(journal))
> +		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> +					sizeof(struct buffer_head *), GFP_KERNEL);
> +
>  	if (jbd2_has_feature_fast_commit(journal) &&
>  	    journal->j_fc_wbufsize > 0) {
>  		journal->j_fc_last = last;
> @@ -1531,7 +1547,8 @@ static int journal_reset(journal_t *journal)
>  	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
>  	journal->j_commit_request = journal->j_commit_sequence;
>  
> -	journal->j_max_transaction_buffers = journal->j_maxlen / 4;
> +	journal->j_max_transaction_buffers =
> +		(journal->j_maxlen - journal->j_fc_wbufsize) / 4;
>  
>  	/*
>  	 * As a special case, if the on-disk copy is already marked as needing
> @@ -1872,6 +1889,7 @@ static int load_superblock(journal_t *journal)
>  {
>  	int err;
>  	journal_superblock_t *sb;
> +	int num_fc_blocks;
>  
>  	err = journal_get_superblock(journal);
>  	if (err)
> @@ -1884,10 +1902,12 @@ static int load_superblock(journal_t *journal)
>  	journal->j_first = be32_to_cpu(sb->s_first);
>  	journal->j_errno = be32_to_cpu(sb->s_errno);
>  
> -	if (jbd2_has_feature_fast_commit(journal) &&
> -	    journal->j_fc_wbufsize > 0) {
> +	if (jbd2_has_feature_fast_commit(journal)) {
>  		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> -		journal->j_last = journal->j_fc_last - journal->j_fc_wbufsize;
> +		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
> +		if (!num_fc_blocks || num_fc_blocks >= journal->j_fc_last)

I think this needs to be stricter - we need the check that the journal is
at least JBD2_MIN_JOURNAL_BLOCKS long (which happens at the beginning of
journal_reset()) to happen after we've subtracted fastcommit blocks...

> +			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
> +		journal->j_last = journal->j_fc_last - num_fc_blocks;
>  		journal->j_fc_first = journal->j_last + 1;
>  		journal->j_fc_off = 0;
>  	} else {
...
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index eb2606133cd8..822f16cbf9b3 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -134,7 +134,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
>  
>  	*bhp = NULL;
>  
> -	if (offset >= journal->j_maxlen) {
> +	if (offset >= journal->j_maxlen + journal->j_fc_wbufsize) {

This looks wrong since j_maxlen is currently including fastcommit blocks...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

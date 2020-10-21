Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944A295335
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410671AbgJUUAl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 16:00:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410567AbgJUUAl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Oct 2020 16:00:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1AAAB2E4;
        Wed, 21 Oct 2020 20:00:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A9911E10F5; Wed, 21 Oct 2020 22:00:39 +0200 (CEST)
Date:   Wed, 21 Oct 2020 22:00:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 3/9] ext4 / jbd2: add fast commit initialization
Message-ID: <20201021200039.GD25702@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-4-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015203802.3597742-4-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-10-20 13:37:55, Harshad Shirwadkar wrote:
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> new file mode 100644
> index 000000000000..8362bf5e6e00
> --- /dev/null
> +++ b/fs/ext4/fast_commit.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __FAST_COMMIT_H__
> +#define __FAST_COMMIT_H__
> +
> +/* Number of blocks in journal area to allocate for fast commits */
> +#define EXT4_NUM_FC_BLKS		256

Maybe this could be tunable (at least during mkfs but maybe also with
a mount option)? I can imagine some people will want to tune this for their
workloads similarly as they tune the journal size. And although current
minimal journal size is 1024, I'd be actually calmer if jbd2 properly
checked from the start that requested fastcommit area isn't too big for the
journal...

> +
> +#endif /* __FAST_COMMIT_H__ */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 70256a240442..23bf55057fc2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5170,6 +5170,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
>  	journal->j_commit_interval = sbi->s_commit_interval;
>  	journal->j_min_batch_time = sbi->s_min_batch_time;
>  	journal->j_max_batch_time = sbi->s_max_batch_time;
> +	ext4_fc_init(sb, journal);
>  
>  	write_lock(&journal->j_state_lock);
>  	if (test_opt(sb, BARRIER))
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index c0600405e7a2..4497bfbac527 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1181,6 +1181,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	if (!journal->j_wbuf)
>  		goto err_cleanup;
>  
> +	if (journal->j_fc_wbufsize > 0) {
> +		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> +					sizeof(struct buffer_head *),
> +					GFP_KERNEL);
> +		if (!journal->j_fc_wbuf)
> +			goto err_cleanup;
> +	}
> +

Hum, but journal_init_common() gets called e.g. through
jbd2_journal_init_inode() before ext4_init_journal_params() sets
j_fc_wbufsize? How is this supposed to work?

>  	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
>  	if (!bh) {
>  		pr_err("%s: Cannot get buffer for journal superblock\n",
> @@ -1194,11 +1202,23 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  
>  err_cleanup:
>  	kfree(journal->j_wbuf);
> +	kfree(journal->j_fc_wbuf);
>  	jbd2_journal_destroy_revoke(journal);
>  	kfree(journal);
>  	return NULL;
>  }
>  
> +int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> +{
> +	journal->j_fc_wbufsize = num_fc_blks;
> +	journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> +				sizeof(struct buffer_head *), GFP_KERNEL);
> +	if (!journal->j_fc_wbuf)
> +		return -ENOMEM;
> +	return 0;
> +}
> +EXPORT_SYMBOL(jbd2_fc_init);

Hum, probably I'd find it less error prone to have size of fastcommit area
as an argument to jbd2_journal_init_dev() and jbd2_journal_init_inode().
That way we are sure journal parameters are initialized correctly from the
start. OTOH number of fastcommit blocks in the journal as we load it from
the disk and need to replay could be different from the number of
fastcommit blocks requested now (once we allow tuning) and this can get
confusing pretty fast. So maybe we just set number of fastcommit blocks in
journal_init_common() and then perform setup of everything else in
journal_reset()?

> +
>  /* jbd2_journal_init_dev and jbd2_journal_init_inode:
>   *
>   * Create a journal structure assigned some fixed set of disk blocks to
> @@ -1316,11 +1336,20 @@ static int journal_reset(journal_t *journal)
>  	}
>  
>  	journal->j_first = first;
> -	journal->j_last = last;
>  
> -	journal->j_head = first;
> -	journal->j_tail = first;
> -	journal->j_free = last - first;
> +	if (jbd2_has_feature_fast_commit(journal) &&
> +	    journal->j_fc_wbufsize > 0) {
> +		journal->j_fc_last = last;
> +		journal->j_last = last - journal->j_fc_wbufsize;
> +		journal->j_fc_first = journal->j_last + 1;
> +		journal->j_fc_off = 0;
> +	} else {
> +		journal->j_last = last;
> +	}
> +
> +	journal->j_head = journal->j_first;
> +	journal->j_tail = journal->j_first;
> +	journal->j_free = journal->j_last - journal->j_first;

So the journal size is effectively shorter by j_fc_wbufsize. But this has
also impact on maximum transaction size we can allow for the journal and
related parameters (generally derived from j_maxlen you don't touch).
So this needs to get fixed. Maybe just setting j_maxlen lower is the
easiest but then please change the comment at its definition to mention in
memory value is without fastcommit blocks. Or just create new journal
parameter for the size of area usable for normal commits.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

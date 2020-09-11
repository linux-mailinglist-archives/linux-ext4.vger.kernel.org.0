Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028B265D5A
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKKGI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 06:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:52068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgIKKGG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 11 Sep 2020 06:06:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F982ACB8;
        Fri, 11 Sep 2020 10:06:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CEAC31E0BA1; Fri, 11 Sep 2020 12:06:03 +0200 (CEST)
Date:   Fri, 11 Sep 2020 12:06:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     changfengnan <changfengnan@qq.com>
Cc:     adilger@dilger.ca, darrick.wong@oracle.com, jack@suse.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Fengnan Chang <changfengnan@hikvision.com>
Subject: Re: [PATCH] jbd2: avoid transaction reuse after reformatting
Message-ID: <20200911100603.GA26589@quack2.suse.cz>
References: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-09-20 19:55:21, changfengnan wrote:
> From: Fengnan Chang <changfengnan@hikvision.com>
> 
> When format ext4 with lazy_journal_init=1, the previous transaction is
> still on disk, it is possible that the previous transaction will be
> used again during jbd2 recovery.Because the seed is changed, the CRC
> check will fail.
> 
> Signed-off-by: Fengnan Chang <changfengnan@hikvision.com>

Thanks for the patch! I have a few functional comments below, also on a
coding style side your patch contains lines a lot longer than 80
characters. Although that is not a strict requirement anymore it is still
prefered that lines are wrapped to fit 80 columns to make code more easily
readable...

> ---
>  fs/jbd2/recovery.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a4967b27ffb6..8a6bc322a06d 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -33,6 +33,8 @@ struct recovery_info
>  	int		nr_replays;
>  	int		nr_revokes;
>  	int		nr_revoke_hits;
> +	unsigned long  ri_commit_block;
> +	__be64  last_trans_commit_time;

Is there a need for these in recovery_info? They are needed only in
PASS_SCAN AFAICT so they can be as well just local variables in
do_one_pass()...

>  };
>  
>  enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
> @@ -412,7 +414,27 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
>  	else
>  		return tag->t_checksum == cpu_to_be16(csum32);
>  }
> +/*
> + * We check the commit time and compare it with the commit time of
> + * the previous transaction, if it's smaller than previous,
> + * We think it's not belong to same journal.
> + */
> +static bool is_same_journal(journal_t *journal, struct buffer_head *bh, unsigned long blocknr, __u64 last_commit_sec)
> +{
> +	unsigned long commit_block = blocknr + count_tags(journal, bh) + 1;
> +	struct buffer_head *nbh;
> +	struct commit_header *cbh;
> +	__u64	commit_sec;
> +	int err = jread(&nbh, journal, commit_block);

So there are two flaws in this logic. First, the computed commit_block may
be beyond end of the journal. You need to wrap the computed value using
wrap() macro. Second, you seem to assume that each transaction has only a
single descriptor block. That is definitely not true. There can be
arbitrary number (well, up to a maximum transaction size which depends on
the total size of the journal) of descriptor blocks in a transaction before
a commit block. So to locate commit block, you need to read the block,
check its type (it can be another descriptor block, revoke block, or commit
block) and then decide accordingly what to do. And you have to be rather
careful when going through the journal like this because you cannot check
checksums and blocks can be containing arbitrary garbage. Probably the
cleanest way how to implement this would be to use the scanning loop in
do_one_pass(), just indicate in some state variable that "we are now
searching for next commit block to determine whether a checksum failure is
due to lazy init or storage error". In this state we will continue
PASS_SCAN, just not checking checksums anymore until we find a commit block
or reach end of journal and then based on what we found decide whether to
report checksum error or just silently end PASS_SCAN pass...

>  
> +	if (err)
> +		return true;
> +
> +	cbh = (struct commit_header *)nbh->b_data;
> +	commit_sec = be64_to_cpu(cbh->h_commit_sec);
> +
> +	return commit_sec >= last_commit_sec;
> +}
>  static int do_one_pass(journal_t *journal,
>  			struct recovery_info *info, enum passtype pass)
>  {
> @@ -514,18 +536,29 @@ static int do_one_pass(journal_t *journal,
>  		switch(blocktype) {
>  		case JBD2_DESCRIPTOR_BLOCK:
>  			/* Verify checksum first */
> +			if (pass == PASS_SCAN)
> +				info->ri_commit_block = 0;
> +
>  			if (jbd2_journal_has_csum_v2or3(journal))
>  				descr_csum_size =
>  					sizeof(struct jbd2_journal_block_tail);
>  			if (descr_csum_size > 0 &&
>  			    !jbd2_descriptor_block_csum_verify(journal,
>  							       bh->b_data)) {
> -				printk(KERN_ERR "JBD2: Invalid checksum "
> -				       "recovering block %lu in log\n",
> +				if (is_same_journal(journal, bh, next_log_block-1, info->last_trans_commit_time)) {
> +					printk(KERN_ERR "JBD2: Invalid checksum recovering block %lu in log\n",
>  				       next_log_block);
> -				err = -EFSBADCRC;
> -				brelse(bh);
> -				goto failed;
> +					err = -EFSBADCRC;
> +					brelse(bh);
> +					goto failed;
> +				} else {
> +					/*it's not belong to same journal, just end this recovery with success*/
> +					jbd_debug(1, "JBD2: Invalid checksum found in block %lu in log, but not same journal %d\n",
> +				       next_log_block, next_commit_ID);
> +					err = 0;
> +					brelse(bh);
> +					goto done;
> +				}
>  			}
>  
>  			/* If it is a valid descriptor block, replay it
> @@ -688,6 +721,17 @@ static int do_one_pass(journal_t *journal,
>  			 * are present verify them in PASS_SCAN; else not
>  			 * much to do other than move on to the next sequence
>  			 * number. */
> +			if (pass == PASS_SCAN) {
> +				struct commit_header *cbh =
> +					(struct commit_header *)bh->b_data;
> +				if (info->ri_commit_block) {
> +					jbd_debug(1, "invalid commit block found in %lu, stop here.\n", next_log_block);
> +					brelse(bh);
> +					goto done;
> +				}
> +				info->ri_commit_block = next_log_block;
> +				info->last_trans_commit_time = be64_to_cpu(cbh->h_commit_sec);
> +			}

I don't think you need to update ri_commit_block and last_trans_commit_time
if we are not checking checksums (lazy journal init cannot happen without
journal checksumming being used). So I'd just move this into the

                        if (pass == PASS_SCAN &&
                            jbd2_has_feature_checksum(journal)) {

branch below. Also we could validate the commit block the same way (using
timestamp) as the descriptor block. Then you will not need the
'ri_commit_block' logic and things will be nicely uniform...

>  			if (pass == PASS_SCAN &&
>  			    jbd2_has_feature_checksum(journal)) {
>  				int chksum_err, chksum_seen;
> @@ -761,7 +805,11 @@ static int do_one_pass(journal_t *journal,
>  				brelse(bh);
>  				continue;
>  			}
> -
> +			if (pass != PASS_SCAN && info->ri_commit_block) {

I don't understand this. We get here only if "pass == PASS_REVOKE" so "pass
!= PASS_SCAN" is guaranteed to be true. But also info->ri_commit_block will
likely be != 0 from the previous PASS_SCAN pass. So this will always skip
revoke block handling?

> +				jbd_debug(1, "invalid revoke block found in %lu, stop here.\n", next_log_block);
> +				brelse(bh);
> +				goto done;
> +			}
>  			err = scan_revoke_records(journal, bh,
>  						  next_commit_ID, info);
>  			brelse(bh);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FDA249886
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 10:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHSItA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 04:49:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:49844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHSItA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 04:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 931E8B659;
        Wed, 19 Aug 2020 08:49:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 207521E1312; Wed, 19 Aug 2020 10:48:58 +0200 (CEST)
Date:   Wed, 19 Aug 2020 10:48:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Shijie Luo <luoshijie1@huawei.com>,
        linux-ext4@vger.kernel.org, linfeilong@huawei.com
Subject: Re: [PATCH] jbd2: remove useless variable chksum_seen in do_one_pass
Message-ID: <20200819084858.GF1902@quack2.suse.cz>
References: <20200811022128.32690-1-luoshijie1@huawei.com>
 <20200818104826.GA1902@quack2.suse.cz>
 <20200818191459.GC162457@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818191459.GC162457@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 18-08-20 15:14:59, Theodore Y. Ts'o wrote:
> I wonder if this is even cleaner?  What do folks think?
> 
>   	    	    	 - Ted

Yup, looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

once you add proper changelog and signed-off-by.

									Honza

> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 2ed278f0dced..4373abbfd19a 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -690,14 +690,11 @@ static int do_one_pass(journal_t *journal,
>  			 * number. */
>  			if (pass == PASS_SCAN &&
>  			    jbd2_has_feature_checksum(journal)) {
> -				int chksum_err, chksum_seen;
>  				struct commit_header *cbh =
>  					(struct commit_header *)bh->b_data;
>  				unsigned found_chksum =
>  					be32_to_cpu(cbh->h_chksum[0]);
>  
> -				chksum_err = chksum_seen = 0;
> -
>  				if (info->end_transaction) {
>  					journal->j_failed_commit =
>  						info->end_transaction;
> @@ -705,42 +702,23 @@ static int do_one_pass(journal_t *journal,
>  					break;
>  				}
>  
> -				if (crc32_sum == found_chksum &&
> -				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
> -				    cbh->h_chksum_size ==
> -						JBD2_CRC32_CHKSUM_SIZE)
> -				       chksum_seen = 1;
> -				else if (!(cbh->h_chksum_type == 0 &&
> -					     cbh->h_chksum_size == 0 &&
> -					     found_chksum == 0 &&
> -					     !chksum_seen))
> -				/*
> -				 * If fs is mounted using an old kernel and then
> -				 * kernel with journal_chksum is used then we
> -				 * get a situation where the journal flag has
> -				 * checksum flag set but checksums are not
> -				 * present i.e chksum = 0, in the individual
> -				 * commit blocks.
> -				 * Hence to avoid checksum failures, in this
> -				 * situation, this extra check is added.
> -				 */
> -						chksum_err = 1;
> -
> -				if (chksum_err) {
> -					info->end_transaction = next_commit_ID;
> -
> -					if (!jbd2_has_feature_async_commit(journal)) {
> -						journal->j_failed_commit =
> -							next_commit_ID;
> -						brelse(bh);
> -						break;
> -					}
> -				}
> +                                /* Neither checksum match nor unused? */
> +				if (!((crc32_sum == found_chksum &&
> +				       cbh->h_chksum_type ==
> +						JBD2_CRC32_CHKSUM &&
> +				       cbh->h_chksum_size ==
> +						JBD2_CRC32_CHKSUM_SIZE) ||
> +				      (cbh->h_chksum_type == 0 &&
> +				       cbh->h_chksum_size == 0 &&
> +				       found_chksum == 0)))
> +					goto chksum_error;
> +
>  				crc32_sum = ~0;
>  			}
>  			if (pass == PASS_SCAN &&
>  			    !jbd2_commit_block_csum_verify(journal,
>  							   bh->b_data)) {
> +			chksum_error:
>  				info->end_transaction = next_commit_ID;
>  
>  				if (!jbd2_has_feature_async_commit(journal)) {
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

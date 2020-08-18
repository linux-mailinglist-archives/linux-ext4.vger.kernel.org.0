Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5B2487DE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 16:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHROis (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 10:38:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgHROir (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Aug 2020 10:38:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F9F6B5A6;
        Tue, 18 Aug 2020 14:39:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E5BB01E09FC; Tue, 18 Aug 2020 16:38:44 +0200 (CEST)
Date:   Tue, 18 Aug 2020 16:38:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [RFC PATCH v2 1/5] jbd2: test case for ext4 data=journal/mmap()
 journal corruption
Message-ID: <20200818143844.GB1902@quack2.suse.cz>
References: <20200810010210.3305322-1-mfo@canonical.com>
 <20200810010210.3305322-2-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810010210.3305322-2-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 09-08-20 22:02:04, Mauricio Faria de Oliveira wrote:
> This checks during journal commit, right after calculating the
> checksum of a buffer head, whether its contents match the 'BUG'
> string (the cookie string in the test case userspace part.)
> 
> If so, it sleeps 5 seconds for such contents to change (i.e.,
> so that the actual checksum changes from what was calculated.)
> 
> And if it changed, set a flag to panic after committing to disk.
> 
> Then, on filesystem remount/journal recovery there is an invalid
> checksum error, and recovery fails:
> 
>   $ sudo mount -o data=journal,journal_checksum $DEV $MNT
>   [ 100.832223] EXT4-fs: Warning: mounting with data=journal disables
>   delayed allocation, dioread_nolock, and O_DIRECT support!
>   [ 100.837488] JBD2: Invalid checksum recovering data block 8706 in log
>   [ 100.842010] JBD2: recovery failed
>   [ 100.843045] EXT4-fs (loop0): error loading journal
>   mount: /ext4: can't read superblock on /dev/loop0.

Nice to have this for testing but when you'll do some "official"
submission, just send this patch separately so that it's clear shouldn't be
included in the kernel...

								Honza

> ---
>  fs/jbd2/commit.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 6d2da8ad0e6f..51f713089e35 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -26,6 +26,11 @@
>  #include <linux/bitops.h>
>  #include <trace/events/jbd2.h>
>  
> +#include <linux/printk.h>
> +#include <linux/delay.h>
> +
> +static journal_t *force_panic;
> +
>  /*
>   * IO end handler for temporary buffer_heads handling writes to the journal.
>   */
> @@ -331,14 +336,35 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
>  	__u32 csum32;
>  	__be32 seq;
>  
> +	// For the testcase
> +	__u32 csum32_later;
> +	__u8 *bh_data;
> +
>  	if (!jbd2_journal_has_csum_v2or3(j))
>  		return;
>  
>  	seq = cpu_to_be32(sequence);
>  	addr = kmap_atomic(page);
>  	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> +	csum32_later = csum32; // Copy csum32 to check again later
>  	csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
>  			     bh->b_size);
> +
> +	// Check for testcase cookie 'BUG' in the buffer_head data.
> +	bh_data = addr + offset_in_page(bh->b_data);
> +	if (bh_data[0] == 'B' &&
> +	    bh_data[1] == 'U' &&
> +	    bh_data[2] == 'G') {
> +		pr_info("TESTCASE: Cookie found. Waiting 5 seconds for changes.\n");
> +		msleep(5000);
> +		pr_info("TESTCASE: Cookie eaten. Resumed.\n");
> +	}
> +
> +	// Check the checksum again for changes/panic after commit.
> +	csum32_later = jbd2_chksum(j, csum32_later, addr + offset_in_page(bh->b_data), bh->b_size);
> +	if (csum32 != csum32_later)
> +		force_panic = j;
> +
>  	kunmap_atomic(addr);
>  
>  	if (jbd2_has_feature_csum3(j))
> @@ -885,6 +911,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  		blkdev_issue_flush(journal->j_dev, GFP_NOFS);
>  	}
>  
> +	if (force_panic == journal)
> +		panic("TESTCASE: checksum changed; commit record done; panic!\n");
> +
>  	if (err)
>  		jbd2_journal_abort(journal, err);
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

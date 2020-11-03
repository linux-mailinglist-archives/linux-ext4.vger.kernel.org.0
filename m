Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1BE2A4C29
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 18:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKCRCK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 12:02:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgKCRCK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 12:02:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B44EAD73;
        Tue,  3 Nov 2020 17:02:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9D1A81E12FB; Tue,  3 Nov 2020 18:02:08 +0100 (CET)
Date:   Tue, 3 Nov 2020 18:02:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 10/10] ext4: issue fsdev cache flush before starting fast
 commit
Message-ID: <20201103170208.GN3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-11-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-11-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:18, Harshad Shirwadkar wrote:
> If the journal dev is different from fsdev, issue a cache flush before
> committing fast commit blocks to disk.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 9ae8ba213961..facf2f59b895 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -996,6 +996,13 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * If file system device is different from journal device, issue a cache
> +	 * flush before we start writing fast commit blocks.
> +	 */
> +	if (journal->j_fs_dev != journal->j_dev)
> +		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS);
> +
>  	blk_start_plug(&plug);
>  	if (sbi->s_fc_bytes == 0) {
>  		/*
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

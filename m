Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2086A2A4BC4
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 17:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCQmF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 11:42:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:55172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCQmF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 11:42:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30D7FB240;
        Tue,  3 Nov 2020 16:42:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E6B51E12FB; Tue,  3 Nov 2020 17:42:03 +0100 (CET)
Date:   Tue, 3 Nov 2020 17:42:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 06/10] ext4: dedpulicate the code to wait on inode that's
 being committed
Message-ID: <20201103164203.GJ3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-7-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-7-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:14, Harshad Shirwadkar wrote:
> This patch removes the deduplicates the code that implements waiting
> on inode that's being committed. That code is moved into a new
> function.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good to me. Just one nit below:

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b1ca55c7d32a..0f2543220d1d 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -155,6 +155,28 @@ void ext4_fc_init_inode(struct inode *inode)
>  	ei->i_fc_committed_subtid = 0;
>  }
>  
> +static void ext4_fc_wait_committing_inode(struct inode *inode)
> +{
> +	wait_queue_head_t *wq;
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +

Maybe add lockdep_assert_held(&EXT4_SB(inode->i_sb)->s_fc_lock) here to
make sure the function is called properly? It's kind of unobvious
requirement (but hard to avoid)...

> +#if (BITS_PER_LONG < 64)
> +	DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> +			EXT4_STATE_FC_COMMITTING);
> +	wq = bit_waitqueue(&ei->i_state_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +#else
> +	DEFINE_WAIT_BIT(wait, &ei->i_flags,
> +			EXT4_STATE_FC_COMMITTING);
> +	wq = bit_waitqueue(&ei->i_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +#endif
> +	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +	schedule();
> +	finish_wait(wq, &wait.wq_entry);
> +}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

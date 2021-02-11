Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482F6318759
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 10:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBKJrd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 04:47:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:52136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBKJik (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 04:38:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88300ADA2;
        Thu, 11 Feb 2021 09:37:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DE0751E14B2; Thu, 11 Feb 2021 10:37:54 +0100 (CET)
Date:   Thu, 11 Feb 2021 10:37:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Updated locking documentation for journal_t
Message-ID: <20210211093754.GJ19070@quack2.suse.cz>
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 10-02-21 10:57:38, Alexander Lochmann wrote:
> Some members of transaction_t are allowed to be read without
> any lock being held if consistency doesn't matter.
> Based on LockDoc's findings, we extended the locking
> documentation of those members.
> Each one of them is marked with a short comment:
> "no lock for quick racy checks".
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>

This patch looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 18f77d9b1745..4dca33a063dd 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -768,7 +768,7 @@ enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
>  struct journal_s
>  {
>  	/**
> -	 * @j_flags: General journaling state flags [j_state_lock]
> +	 * @j_flags: General journaling state flags [j_state_lock, no lock for quick racy checks]
>  	 */
>  	unsigned long		j_flags;
>  
> @@ -808,7 +808,7 @@ struct journal_s
>  	/**
>  	 * @j_barrier_count:
>  	 *
> -	 * Number of processes waiting to create a barrier lock [j_state_lock]
> +	 * Number of processes waiting to create a barrier lock [j_state_lock, no lock for quick racy checks]
>  	 */
>  	int			j_barrier_count;
>  
> @@ -821,7 +821,7 @@ struct journal_s
>  	 * @j_running_transaction:
>  	 *
>  	 * Transactions: The current running transaction...
> -	 * [j_state_lock] [caller holding open handle]
> +	 * [j_state_lock, no lock for quick racy checks] [caller holding open handle]
>  	 */
>  	transaction_t		*j_running_transaction;
>  
> @@ -1033,7 +1033,7 @@ struct journal_s
>  	 * @j_commit_sequence:
>  	 *
>  	 * Sequence number of the most recently committed transaction
> -	 * [j_state_lock].
> +	 * [j_state_lock, no lock for quick racy checks].
>  	 */
>  	tid_t			j_commit_sequence;
>  
> @@ -1041,7 +1041,7 @@ struct journal_s
>  	 * @j_commit_request:
>  	 *
>  	 * Sequence number of the most recent transaction wanting commit
> -	 * [j_state_lock]
> +	 * [j_state_lock, no lock for quick racy checks]
>  	 */
>  	tid_t			j_commit_request;
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

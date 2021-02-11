Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC78731872F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhBKJez (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 04:34:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:44932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhBKJbf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 04:31:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CEDBAC6E;
        Thu, 11 Feb 2021 09:30:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 64D131E14B2; Thu, 11 Feb 2021 10:30:27 +0100 (CET)
Date:   Thu, 11 Feb 2021 10:30:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Updated locking documentation for transaction_t
Message-ID: <20210211093027.GI19070@quack2.suse.cz>
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 10-02-21 10:57:39, Alexander Lochmann wrote:
> Some members of transaction_t are allowed to be read without
> any lock being held if consistency doesn't matter.
> Based on LockDoc's findings, we extended the locking
> documentation of those members.
> Each one of them is marked with a short comment:
> "no lock for quick racy checks".
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>

Thanks for the patch! Some comments below...

> ---
>  include/linux/jbd2.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..18f77d9b1745 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -594,18 +594,18 @@ struct transaction_s
>  	 */
>  	unsigned long		t_log_start;
>  
> -	/* Number of buffers on the t_buffers list [j_list_lock] */
> +	/* Number of buffers on the t_buffers list [j_list_lock, no lock for quick racy checks] */
>  	int			t_nr_buffers;

So this case is actually somewhat different now that I audited the uses.
There are two types of users - commit code (fs/jbd2/commit.c) and others.
Other users properly use j_list_lock to access t_nr_buffers. Commit code
does not use any locks because committing transaction is fully in
ownership of the jbd2 thread and all other users need to check & wait for
commit to be finished before doing anything with the transaction's buffers.

>  	/*
>  	 * Doubly-linked circular list of all buffers reserved but not yet
> -	 * modified by this transaction [j_list_lock]
> +	 * modified by this transaction [j_list_lock, no lock for quick racy checks]
>  	 */
>  	struct journal_head	*t_reserved_list;
>
>  	/*
>  	 * Doubly-linked circular list of all metadata buffers owned by this
> -	 * transaction [j_list_lock]
> +	 * transaction [j_list_lock, no lock for quick racy checks]
>  	 */
>  	struct journal_head	*t_buffers;
> 
> @@ -631,7 +631,7 @@ struct transaction_s
>  	/*
>  	 * Doubly-linked circular list of metadata buffers being shadowed by log
>  	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
> -	 * list match each other one for one at all times. [j_list_lock]
> +	 * list match each other one for one at all times. [j_list_lock, no lock for quick racy checks]
>  	 */
>  	struct journal_head	*t_shadow_list;

The above three cases are the same as t_reserved_list.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

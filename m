Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8A318F35
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 16:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBKPyL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 10:54:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:36034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBKPv3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 10:51:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B6E3AC69;
        Thu, 11 Feb 2021 15:50:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D58911E14C6; Thu, 11 Feb 2021 16:50:47 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:50:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Updated locking documentation for transaction_t
Message-ID: <20210211155047.GS19070@quack2.suse.cz>
References: <20210211135424.42826-1-alexander.lochmann@tu-dortmund.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211135424.42826-1-alexander.lochmann@tu-dortmund.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 14:54:23, Alexander Lochmann wrote:
> Some members of transaction_t are allowed to be read without
> any lock being held if accessed from the correct context.
> We used LockDoc's findings to determine those members.
> Each member of them is marked with a short comment:
> "no lock needed for jbd2 thread".
> 
> Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
> Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>

Thanks. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..1f19d19f6435 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -594,18 +594,18 @@ struct transaction_s
>  	 */
>  	unsigned long		t_log_start;
>  
> -	/* Number of buffers on the t_buffers list [j_list_lock] */
> +	/* Number of buffers on the t_buffers list [j_list_lock, no locks needed for jbd2 thread] */
>  	int			t_nr_buffers;
>  
>  	/*
>  	 * Doubly-linked circular list of all buffers reserved but not yet
> -	 * modified by this transaction [j_list_lock]
> +	 * modified by this transaction [j_list_lock, no locks needed for jbd2 thread]
>  	 */
>  	struct journal_head	*t_reserved_list;
>  
>  	/*
>  	 * Doubly-linked circular list of all metadata buffers owned by this
> -	 * transaction [j_list_lock]
> +	 * transaction [j_list_lock, no locks needed for jbd2 thread]
>  	 */
>  	struct journal_head	*t_buffers;
>  
> @@ -631,7 +631,7 @@ struct transaction_s
>  	/*
>  	 * Doubly-linked circular list of metadata buffers being shadowed by log
>  	 * IO.  The IO buffers on the iobuf list and the shadow buffers on this
> -	 * list match each other one for one at all times. [j_list_lock]
> +	 * list match each other one for one at all times. [j_list_lock, no locks needed for jbd2 thread]
>  	 */
>  	struct journal_head	*t_shadow_list;
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

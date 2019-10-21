Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D6DF491
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfJURtk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 13:49:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33397 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727171AbfJURtj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 13:49:39 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LHnX2K012041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 13:49:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 31358420458; Mon, 21 Oct 2019 13:49:33 -0400 (EDT)
Date:   Mon, 21 Oct 2019 13:49:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 15/22] jbd2: Factor out common parts of stopping and
 restarting a handle
Message-ID: <20191021174933.GH27850@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-15-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-15-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:06:01AM +0200, Jan Kara wrote:
> jbd2__journal_restart() has quite some code that is common with
> jbd2_journal_stop(). Factor this functionality into stop_this_handle()
> helper and use it from both functions. Note that this also drops
> t_handle_lock protection from jbd2__journal_restart() as
> jbd2_journal_stop() does the same thing without it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/jbd2/transaction.c | 94 +++++++++++++++++++++++----------------------------
>  1 file changed, 42 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index d648cec3f90f..d4ee02e5161b 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -677,52 +704,30 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, gfp_t gfp_mask)

> -	read_lock(&journal->j_state_lock);
> -	spin_lock(&transaction->t_handle_lock);
> -	atomic_sub(handle->h_buffer_credits,
> -		   &transaction->t_outstanding_credits);
> -	if (handle->h_rsv_handle) {
> -		sub_reserved_credits(journal,
> -				     handle->h_rsv_handle->h_buffer_credits);
> -	}
> -	if (atomic_dec_and_test(&transaction->t_updates))
> -		wake_up(&journal->j_wait_updates);
> -	tid = transaction->t_tid;
> -	spin_unlock(&transaction->t_handle_lock);
> +	jbd_debug(2, "restarting handle %p\n", handle);
> +	stop_this_handle(handle);
>  	handle->h_transaction = NULL;
> -	current->journal_info = NULL;
>  
> -	jbd_debug(2, "restarting handle %p\n", handle);
> +	read_lock(&journal->j_state_lock);
>  	need_to_start = !tid_geq(journal->j_commit_request, tid);
>  	read_unlock(&journal->j_state_lock);

What is j_state_lock protecting at this point?  There's only a 32-bit
read of j_commit_request at this point.

						- Ted

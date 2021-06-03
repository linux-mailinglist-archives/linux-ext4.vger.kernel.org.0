Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC10439A5A7
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCQX1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Jun 2021 12:23:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFCQX1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Jun 2021 12:23:27 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8CAB01FD5F;
        Thu,  3 Jun 2021 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622737301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZhlrybUIyxNTfaaz49aImnMZrceQx6/J3OnDBZ8F3n0=;
        b=Tw4/+gO6UxzRo47fOGsf25vZbr6IgzwJ6kQ7YjGbRc/LK/tJJyJQF2QYb53q2xDRMY3UmT
        9vChZBe6CC+X6zlNez5Kl4dKNNAkv5h6a+B6dlw/E0T9U4T0qbCO2GfHV8bb6wOZNPNqeO
        aidMBRhGtnsPFg/y2mVCkEUqtyHQmGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622737301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZhlrybUIyxNTfaaz49aImnMZrceQx6/J3OnDBZ8F3n0=;
        b=ut4m9OG0WBHdB/MaGoIXQVZMimzf44Ywq1H28WowNEuDW3MQKPUu1uTKvioGQ4hiVgnG9Z
        IZ/KmfDQBWZdDkBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 11F79A3B88;
        Thu,  3 Jun 2021 16:21:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E188E1F2C96; Thu,  3 Jun 2021 18:21:40 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:21:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 2/8] jbd2: ensure abort the journal if detect IO
 error when writing original buffer back
Message-ID: <20210603162140.GM23647@quack2.suse.cz>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 27-05-21 21:56:35, Zhang Yi wrote:
> Although we merged c044f3d8360 ("jbd2: abort journal if free a async
> write error metadata buffer"), there is a race between
> jbd2_journal_try_to_free_buffers() and jbd2_journal_destroy(), so the
> jbd2_log_do_checkpoint() may still fail to detect the buffer write
> io error flag which may lead to filesystem inconsistency.
> 
> jbd2_journal_try_to_free_buffers()     ext4_put_super()
>                                         jbd2_journal_destroy()
>   __jbd2_journal_remove_checkpoint()
>   detect buffer write error              jbd2_log_do_checkpoint()
>                                          jbd2_cleanup_journal_tail()
>                                            <--- lead to inconsistency
>   jbd2_journal_abort()
> 
> Fix this issue by introducing a new atomic flag which only have one
> JBD2_CHECKPOINT_IO_ERROR bit now, and set it in
> __jbd2_journal_remove_checkpoint() when freeing a checkpoint buffer
> which has write_io_error flag. Then jbd2_journal_destroy() will detect
> this mark and abort the journal to prevent updating log tail.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Just one spelling fix below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> @@ -575,6 +576,17 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	journal = transaction->t_journal;
>  
>  	JBUFFER_TRACE(jh, "removing from transaction");
> +
> +	/*
> +	 * If we have failed to write the buffer out to disk, the filesystem
> +	 * may become inconsistent. We cannot abort the journal here since
> +	 * we hold j_list_lock and we have to careful about races with
					   ^^^ to be careful ...

> +	 * jbd2_journal_destroy(). So mark the writeback IO error in the
> +	 * journal here and we abort the journal later from a better context.
> +	 */
> +	if (buffer_write_io_error(bh))
> +		set_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags);
> +
>  	__buffer_unlink(jh);
>  	jh->b_cp_transaction = NULL;
>  	jbd2_journal_put_journal_head(jh);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

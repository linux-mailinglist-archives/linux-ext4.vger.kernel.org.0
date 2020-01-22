Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABB144DE4
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2020 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVIrK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jan 2020 03:47:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:38570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgAVIrK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Jan 2020 03:47:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E017AE2D;
        Wed, 22 Jan 2020 08:47:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DFA621E0A4F; Wed, 22 Jan 2020 09:47:02 +0100 (CET)
Date:   Wed, 22 Jan 2020 09:47:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH] ext4,jbd2: fix comment and code style
Message-ID: <20200122084702.GA12845@quack2.suse.cz>
References: <20200122072625.16487-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122072625.16487-1-luoshijie1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-01-20 02:26:25, Shijie Luo wrote:
> Fix comment and remove unnecessary blank.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c      | 2 +-
>  fs/jbd2/transaction.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2fec62d764fa..a6695e1d246c 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -849,7 +849,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
>  
>  /*
>   * Prepare the write for the inline data.
> - * If the the data can be written into the inode, we just read
> + * If the data can be written into the inode, we just read
>   * the page and make it uptodate, and start the journal.
>   * Otherwise read the page, makes it dirty so that it can be
>   * handle in writepages(the i_disksize update is left to the
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 27b9f9dee434..f7a9da75b160 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1595,7 +1595,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>   * Allow this call even if the handle has aborted --- it may be part of
>   * the caller's cleanup after an abort.
>   */
> -int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
> +int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>  {
>  	transaction_t *transaction = handle->h_transaction;
>  	journal_t *journal;
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

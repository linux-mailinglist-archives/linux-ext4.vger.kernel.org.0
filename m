Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FF27C981
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Sep 2020 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgI2MLP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Sep 2020 08:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732049AbgI2MK5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 29 Sep 2020 08:10:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24B5CAF6C;
        Tue, 29 Sep 2020 12:10:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C740D1E12E9; Tue, 29 Sep 2020 14:10:55 +0200 (CEST)
Date:   Tue, 29 Sep 2020 14:10:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Subject: Re: [RFC PATCH v4 4/4] ext4: data=journal: write-protect pages on
 j_submit_inode_data_buffers()
Message-ID: <20200929121055.GM10896@quack2.suse.cz>
References: <20200928194103.244692-1-mfo@canonical.com>
 <20200928194103.244692-5-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928194103.244692-5-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 28-09-20 16:41:03, Mauricio Faria de Oliveira wrote:
> This implements journal callbacks j_submit|finish_inode_data_buffers()
> with different behavior for data=journal: to write-protect pages under
> commit, preventing changes to buffers writeably mapped to userspace.
> 
> If a buffer's content changes between commit's checksum calculation
> and write-out to disk, it can cause journal recovery/mount failures
> upon a kernel crash or power loss.
> 
>     [   27.334874] EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!
>     [   27.339492] JBD2: Invalid checksum recovering data block 8705 in log
>     [   27.342716] JBD2: recovery failed
>     [   27.343316] EXT4-fs (loop0): error loading journal
>     mount: /ext4: can't read superblock on /dev/loop0.
> 
> In j_submit_inode_data_buffers() we write-protect the inode's pages
> with write_cache_pages() and redirty w/ writepage callback if needed.
> 
> In j_finish_inode_data_buffers() there is nothing do to.
> 
> And in order to use the callbacks, inodes are added to the inode list
> in transaction in __ext4_journalled_writepage() and ext4_page_mkwrite().
> 
> In ext4_page_mkwrite() we must make sure that the buffers are attached
> to the transaction as jbddirty with write_end_fn(), as already done in
> __ext4_journalled_writepage().
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Reported-by: Dann Frazier <dann.frazier@canonical.com>
> Reported-by: kernel test robot <lkp@intel.com> # wbc.nr_to_write
> Suggested-by: Jan Kara <jack@suse.cz>

The patch looks good to me. Just one nit below. After fixing that feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> + * However, we have to redirty a page in these cases:
> + * 1) some buffer is dirty (needs checkpointing)
> + * 2) some buffer is not part of the committing transaction
> + * 3) some buffer already has b_next_transaction set
> + */

Maybe I'd move this comment inside ext4_journalled_writepage_callback()
just before the if () to make it clear what it speaks about. I'd also
somewhat expand it like:

/*
 * However, we have to redirty a page in these cases:
 * 1) If buffer is dirty, it means the page was dirty because it contains a
 * buffer that needs checkpointing. So dirty bit needs to be preserved so
 * that checkpointing writes the buffer properly.
 * 2) If buffer is not part of the committing transaction (we may have just
 * accidentally come across this buffer because inode range tracking is not
 * exact) or if the currently running transaction already contains this
 * buffer as well, dirty bit needs to be preserved so that the buffer gets
 * properly writeprotected on running transaction's commit.
 */

> +
> +static int ext4_journalled_writepage_callback(struct page *page,
> +					      struct writeback_control *wbc,
> +					      void *data)
> +{
> +	transaction_t *transaction = (transaction_t *) data;
> +	struct buffer_head *bh, *head;
> +	struct journal_head *jh;
> +
> +	bh = head = page_buffers(page);
> +	do {
> +		jh = bh2jh(bh);
> +		if (buffer_dirty(bh) ||
> +			(jh && (jh->b_transaction != transaction ||
> +				jh->b_next_transaction))) {

Also we usually indent the condition like:
		if (buffer_dirty(bh) ||
		    (jh && (jh->b_transaction != transaction ||
			    jh->b_next_transaction))) {

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

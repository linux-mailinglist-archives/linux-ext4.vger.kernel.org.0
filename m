Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406A626CCC6
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 22:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgIPUs7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 16:48:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:47386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgIPRAV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 924EEAC1D;
        Wed, 16 Sep 2020 17:00:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F0F7B1E12E1; Wed, 16 Sep 2020 18:59:45 +0200 (CEST)
Date:   Wed, 16 Sep 2020 18:59:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: Re: [RFC PATCH v3 3/3] ext4: data=journal: write-protect pages on
 j_submit_inode_data_buffers()
Message-ID: <20200916165945.GO3607@quack2.suse.cz>
References: <20200910193127.276214-1-mfo@canonical.com>
 <20200910193127.276214-4-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910193127.276214-4-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-09-20 16:31:27, Mauricio Faria de Oliveira wrote:
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
> In ext4_page_mkwrite() we must make sure that:
> 
> 1) the inode is always added to the list;
>    thus we skip the 'all buffers mapped' optimization on data=journal;
> 
> 2) the buffers are attached to transaction as dirty;
>    as already done in __ext4_journalled_writepage().
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Reported-by: Dann Frazier <dann.frazier@canonical.com>
> ---
>  fs/ext4/inode.c | 29 ++++++++++++++------
>  fs/ext4/super.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 91 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf596467c234..fa4109da056c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1910,6 +1910,9 @@ static int __ext4_journalled_writepage(struct page *page,
>  		err = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
>  					     write_end_fn);
>  	}
> +	if (ret == 0)
> +		ret = err;
> +	err = ext4_jbd2_inode_add_write(handle, inode, 0, len);
>  	if (ret == 0)
>  		ret = err;
>  	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
> @@ -6004,9 +6007,12 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  		len = PAGE_SIZE;
>  	/*
>  	 * Return if we have all the buffers mapped. This avoids the need to do
> -	 * journal_start/journal_stop which can block and take a long time
> +	 * journal_start/journal_stop which can block and take a long time.
> +	 *
> +	 * This cannot be done for data journalling, as we have to add the
> +	 * inode to the transaction's list to writeprotect pages on commit.
>  	 */
> -	if (page_has_buffers(page)) {
> +	if (page_has_buffers(page) && !ext4_should_journal_data(inode)) {
>  		if (!ext4_walk_page_buffers(NULL, page_buffers(page),
>  					    0, len, NULL,
>  					    ext4_bh_unmapped)) {
> @@ -6032,12 +6038,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	err = block_page_mkwrite(vma, vmf, get_block);
>  	if (!err && ext4_should_journal_data(inode)) {
>  		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
> -			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
> -			unlock_page(page);
> -			ret = VM_FAULT_SIGBUS;
> -			ext4_journal_stop(handle);
> -			goto out;
> -		}
> +			PAGE_SIZE, NULL, do_journal_get_write_access))
> +			goto out_err;
> +		/* Make sure buffers are attached to the transaction as dirty */
> +		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
> +			PAGE_SIZE, NULL, write_end_fn))
> +			goto out_err;

I think here we need to be a bit more careful. As I wrote in my answer to
cover letter we cannot call block_page_mkwrite(). Instead we need to lock
the page, compute 'len' again from i_size, then call __block_write_begin()
to map (or allocate) and read blocks, and then ext4_walk_page_buffers()
which needs to walk from 0 to len. And then unlock the page.

> +		if (ext4_jbd2_inode_add_write(handle, inode, 0, PAGE_SIZE))
> +			goto out_err;
>  		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
>  	}
>  	ext4_journal_stop(handle);
> @@ -6049,6 +6057,11 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  	up_read(&EXT4_I(inode)->i_mmap_sem);
>  	sb_end_pagefault(inode->i_sb);
>  	return ret;
> +out_err:
> +	unlock_page(page);
> +	ret = VM_FAULT_SIGBUS;
> +	ext4_journal_stop(handle);
> +	goto out;
>  }

Otherwise the patch looks good to me!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

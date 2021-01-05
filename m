Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F892EB1D9
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbhAERya (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 12:54:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:52138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbhAERya (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Jan 2021 12:54:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A83EBAD4E;
        Tue,  5 Jan 2021 17:53:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 32DC31E07FD; Tue,  5 Jan 2021 18:53:48 +0100 (CET)
Date:   Tue, 5 Jan 2021 18:53:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: implement ->page_mkwrite
Message-ID: <20210105175348.GE15080@quack2.suse.cz>
References: <20201218132757.279685-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218132757.279685-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 18-12-20 21:27:57, Chengguang Xu wrote:
> Currently ext2 uses generic mmap operations for non DAX file and
> filemap_page_mkwrite() does not check the block allocation for
> shared writable mmapped area on pagefault. In some cases like
> disk space exhaustion or disk quota limitation, it will cause silent
> data loss. This patch tries to check and do block preallocation on
> pagefault if necessary and explicitly return error to user when
> allocation failure.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks for the patch and sorry for the delay in replying. I agree there's
the problem you describe but I'm not sure whether we should fix it.  ext2
has been like this since the beginning so well over 20 years.  Allocating
blocks on write fault has the unwelcome impact that the file layout is
likely going to be much worse (much more fragmented) - I remember getting
some reports about performance regressions from users back when I did a
similar change for ext3. And so I'm reluctant to change behavior of such
an old legacy filesystem as ext2...

								Honza

> ---
>  fs/ext2/file.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 96044f5dbc0e..a34119415ef1 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -25,10 +25,34 @@
>  #include <linux/quotaops.h>
>  #include <linux/iomap.h>
>  #include <linux/uio.h>
> +#include <linux/buffer_head.h>
>  #include "ext2.h"
>  #include "xattr.h"
>  #include "acl.h"
>  
> +vm_fault_t ext2_page_mkwrite(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct inode *inode = file_inode(vma->vm_file);
> +	int err;
> +
> +	if (unlikely(IS_IMMUTABLE(inode)))
> +		return VM_FAULT_SIGBUS;
> +
> +	sb_start_pagefault(inode->i_sb);
> +	file_update_time(vma->vm_file);
> +	err = block_page_mkwrite(vma, vmf, ext2_get_block);
> +	sb_end_pagefault(inode->i_sb);
> +
> +	return block_page_mkwrite_return(err);
> +}
> +
> +const struct vm_operations_struct ext2_vm_ops = {
> +	.fault		= filemap_fault,
> +	.map_pages	= filemap_map_pages,
> +	.page_mkwrite	= ext2_page_mkwrite,
> +};
> +
>  #ifdef CONFIG_FS_DAX
>  static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> @@ -123,15 +147,23 @@ static const struct vm_operations_struct ext2_dax_vm_ops = {
>  
>  static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> +	file_accessed(file);
>  	if (!IS_DAX(file_inode(file)))
> -		return generic_file_mmap(file, vma);
> +		vma->vm_ops = &ext2_vm_ops;
> +	else
> +		vma->vm_ops = &ext2_dax_vm_ops;
>  
> -	file_accessed(file);
> -	vma->vm_ops = &ext2_dax_vm_ops;
>  	return 0;
>  }
> +
>  #else
> -#define ext2_file_mmap	generic_file_mmap
> +static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	file_accessed(file);
> +	vma->vm_ops = &ext2_vm_ops;
> +	return 0;
> +}
> +
>  #endif
>  
>  /*
> -- 
> 2.18.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

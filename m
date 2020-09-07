Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABEC25F5E3
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Sep 2020 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgIGJAk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Sep 2020 05:00:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIGJAj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 7 Sep 2020 05:00:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC6C6AD56;
        Mon,  7 Sep 2020 09:00:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3FFA1E12D1; Mon,  7 Sep 2020 11:00:37 +0200 (CEST)
Date:   Mon, 7 Sep 2020 11:00:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2: don't update mtime on COW faults
Message-ID: <20200907090037.GB16559@quack2.suse.cz>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050811200.12419@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009050811200.12419@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 05-09-20 08:12:01, Mikulas Patocka wrote:
> When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> PROT_WRITE, the ext2 filesystem would incorrectly update ctime and mtime
> when the user hits a COW fault.
> 
> This breaks building of the Linux kernel.
> How to reproduce:
> 1. extract the Linux kernel tree on dax-mounted ext2 filesystem
> 2. run make clean
> 3. run make -j12
> 4. run make -j12
> - at step 4, make would incorrectly rebuild the whole kernel (although it
>   was already built in step 3).
> 
> The reason for the breakage is that almost all object files depend on
> objtool. When we run objtool, it takes COW page fault on its .data
> section, and these faults will incorrectly update the timestamp of the
> objtool binary. The updated timestamp causes make to rebuild the whole
> tree.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

Thanks. Good spotting! Linus has already merged this so nothing more to do
here.

								Honza

> 
> ---
>  fs/ext2/file.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/fs/ext2/file.c
> ===================================================================
> --- linux-2.6.orig/fs/ext2/file.c	2020-09-05 10:01:41.000000000 +0200
> +++ linux-2.6/fs/ext2/file.c	2020-09-05 13:09:50.000000000 +0200
> @@ -93,8 +93,10 @@ static vm_fault_t ext2_dax_fault(struct
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct ext2_inode_info *ei = EXT2_I(inode);
>  	vm_fault_t ret;
> +	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
> +		(vmf->vma->vm_flags & VM_SHARED);
>  
> -	if (vmf->flags & FAULT_FLAG_WRITE) {
> +	if (write) {
>  		sb_start_pagefault(inode->i_sb);
>  		file_update_time(vmf->vma->vm_file);
>  	}
> @@ -103,7 +105,7 @@ static vm_fault_t ext2_dax_fault(struct
>  	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
>  
>  	up_read(&ei->dax_sem);
> -	if (vmf->flags & FAULT_FLAG_WRITE)
> +	if (write)
>  		sb_end_pagefault(inode->i_sb);
>  	return ret;
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

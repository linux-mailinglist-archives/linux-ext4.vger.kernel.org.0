Return-Path: <linux-ext4+bounces-6432-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE0A33F80
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 13:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CA11887F13
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5F23A98F;
	Thu, 13 Feb 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/6pkzl4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52522170D
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450953; cv=none; b=sSJDKZPql4hREfzzH1itqEp5qe0ySTfTgvF2oH3zJ/jiAWLYanxMBfRUTsQgWJMeOT4gLV0Fh3mn+Sp/8Nya10gKmjE8uSag8ziAY+6KHbLh+vttxSXq2DDm/f1AcE0Vo5Rhh9wtbcM2h6t0nWQaoMy4KjS1rW5Yy7/ygKIVo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450953; c=relaxed/simple;
	bh=O8SPh+bndCb8RRfZPPh0hvV608yyo8x2VYnQVt6Kws0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpKI848fgTUBHfH+cND6K6E7B4lomUBy4A8cn5o2WzhuKmKScgxDEXzboB5bS7VjNg3lUB0NKOsG3H/bv8f31RpsjQSYN4trebLGEb0vIF06k0WIXGjR4Q62JXGCVZQI+qO50UULmtP4uQBUnVA3G8dJD29PWRjxvY7nVK+YjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/6pkzl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739450950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oGHBEhaSV/0FuKCxXcabrcQZRyi9d0okvwW5iagFBfg=;
	b=K/6pkzl46QyJrm+gW9djziDebwNjWH+jWLU/WNocOqG/6EOxpmJehD+YJrK9maipXz0qDD
	iZFClZY5wufFl0/bQJIZaNgzbIbblSN12MpYtP3iNt8M1fowY4+Qc2Q8dRGsTYAo68bNhM
	iua4lx0Qsm2zhk4qgcRIOkeGSMXi7AA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-D1pxYgtgOImg-i8E71vjSQ-1; Thu,
 13 Feb 2025 07:49:05 -0500
X-MC-Unique: D1pxYgtgOImg-i8E71vjSQ-1
X-Mimecast-MFC-AGG-ID: D1pxYgtgOImg-i8E71vjSQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEECE19039C6;
	Thu, 13 Feb 2025 12:49:02 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5824C1955DCE;
	Thu, 13 Feb 2025 12:48:59 +0000 (UTC)
Date: Thu, 13 Feb 2025 07:51:25 -0500
From: Brian Foster <bfoster@redhat.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
Message-ID: <Z63qzaDONxM9fRVl@bfoster>
References: <20250213112247.3168709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213112247.3168709-1-libaokun@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Feb 13, 2025 at 07:22:47PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
> happen because filemap_invalidate_unlock() isn't called to unlock
> mapping->invalidate_lock. Like this:
> 
> EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
> INFO: task fsstress:374 blocked for more than 122 seconds.
>       Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
>                                   task_flags:0x440140 flags:0x00000000
> Call Trace:
>  <TASK>
>  __schedule+0x2c9/0x7f0
>  schedule+0x27/0xa0
>  schedule_preempt_disabled+0x15/0x30
>  rwsem_down_read_slowpath+0x278/0x4c0
>  down_read+0x59/0xb0
>  page_cache_ra_unbounded+0x65/0x1b0
>  filemap_get_pages+0x124/0x3e0
>  filemap_read+0x114/0x3d0
>  vfs_read+0x297/0x360
>  ksys_read+0x6c/0xe0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

First off, thank you for catching this. :)

>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3cc8da6357aa..04ffd802dbde 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5452,7 +5452,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			    oldsize & (inode->i_sb->s_blocksize - 1)) {
>  				error = ext4_inode_attach_jinode(inode);
>  				if (error)
> -					goto err_out;
> +					goto out_mmap_sem;
>  			}

This looks reasonable to me, but I notice that the immediate previous
error check looks like this:

		...
                rc = ext4_break_layouts(inode);
                if (rc) {
                        filemap_invalidate_unlock(inode->i_mapping);
                        goto err_out;
                }
		...

... and then the following after the broken logic uses out_mmap_sem.
Could we be a little more consistent here one way or the other? The
change looks functionally correct to me either way:

Reviewed-by: Brian Foster <bfoster@redhat.com>

Brian

>  
>  			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
> -- 
> 2.39.2
> 
> 



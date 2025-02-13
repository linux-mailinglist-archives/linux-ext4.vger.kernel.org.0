Return-Path: <linux-ext4+bounces-6434-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65AA34085
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 14:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778B9188E56C
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C523A98C;
	Thu, 13 Feb 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrPVIm3M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E9227EB5
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453940; cv=none; b=HHwEEvtMOLe5jR9jF26A7TRHxmLavmK7gVHMpzxXpYL0g7hXMmuE9KT3rSIQdwKx7NVuQ4hyaJYW0/66ZoYtWMoKfcj2Sdh6ZDAOPatPr8xP7ANrKzKrVYXe9pXVa/LgLO5KsYiwGTyYqVa9AwegK9oP8OwXb6dWp8eClWEVd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453940; c=relaxed/simple;
	bh=0KCJgJ5af6wRATayYbyzVDKznzamxvQlSmE9bHZ7Ppk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYcVMbIABAiYdt9X3ZB2LLwLyc62/smIzLm68u3Sn3102eGNIrkuoLLNWaPdTzB9kJ+AjXdjwFSdYq1pRYVdZHKB/YsCZMWy7ck3MbZ/J1H0nZ0xQVxs21913zr5u4E0U8sybR+mxRYc20wpFm1GzkexDzN6oFEf3s6+EvVjC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrPVIm3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739453937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rkdOvVcCYhu0dJAQGSkowwgNwea/vBeQ6njpqnbJ55s=;
	b=PrPVIm3MImnSlCCzuIawNM5R4RJ27VBL9OIs/8iiddoDgyY9qbtQLhemrvvgQV04+q0/Nn
	fjEDayFHGX5I9BNjSIiVCoy/qCIRkYU4NkEYi9/fJqZPC7UqxlHOKbp7CE1z3PGvC4gXaj
	sBO+esYGWgOoif8VOaJHwB1yCBkZJcQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-ho6mKEDFPbm3Xwkk6ZeFUg-1; Thu,
 13 Feb 2025 08:38:54 -0500
X-MC-Unique: ho6mKEDFPbm3Xwkk6ZeFUg-1
X-Mimecast-MFC-AGG-ID: ho6mKEDFPbm3Xwkk6ZeFUg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 224DF190308C;
	Thu, 13 Feb 2025 13:38:52 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.88])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD0D91955F0F;
	Thu, 13 Feb 2025 13:38:49 +0000 (UTC)
Date: Thu, 13 Feb 2025 08:41:15 -0500
From: Brian Foster <bfoster@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
Message-ID: <Z632e360SySsBRSk@bfoster>
References: <20250213112247.3168709-1-libaokun@huaweicloud.com>
 <Z63qzaDONxM9fRVl@bfoster>
 <5e39cc34-99e8-451e-8f61-4f0187a8db6a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e39cc34-99e8-451e-8f61-4f0187a8db6a@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Feb 13, 2025 at 09:20:21PM +0800, Baokun Li wrote:
> Hi,
> 
> On 2025/2/13 20:51, Brian Foster wrote:
> > On Thu, Feb 13, 2025 at 07:22:47PM +0800, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
> > > happen because filemap_invalidate_unlock() isn't called to unlock
> > > mapping->invalidate_lock. Like this:
> > > 
> > > EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
> > > INFO: task fsstress:374 blocked for more than 122 seconds.
> > >        Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
> > >                                    task_flags:0x440140 flags:0x00000000
> > > Call Trace:
> > >   <TASK>
> > >   __schedule+0x2c9/0x7f0
> > >   schedule+0x27/0xa0
> > >   schedule_preempt_disabled+0x15/0x30
> > >   rwsem_down_read_slowpath+0x278/0x4c0
> > >   down_read+0x59/0xb0
> > >   page_cache_ra_unbounded+0x65/0x1b0
> > >   filemap_get_pages+0x124/0x3e0
> > >   filemap_read+0x114/0x3d0
> > >   vfs_read+0x297/0x360
> > >   ksys_read+0x6c/0xe0
> > >   do_syscall_64+0x4b/0x110
> > >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > 
> > > Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > First off, thank you for catching this. :)
> Thanks for your review!
> > 
> > >   fs/ext4/inode.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 3cc8da6357aa..04ffd802dbde 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5452,7 +5452,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> > >   			    oldsize & (inode->i_sb->s_blocksize - 1)) {
> > >   				error = ext4_inode_attach_jinode(inode);
> > >   				if (error)
> > > -					goto err_out;
> > > +					goto out_mmap_sem;
> > >   			}
> > This looks reasonable to me, but I notice that the immediate previous
> > error check looks like this:
> > 
> > 		...
> >                  rc = ext4_break_layouts(inode);
> >                  if (rc) {
> >                          filemap_invalidate_unlock(inode->i_mapping);
> >                          goto err_out;
> >                  }
> > 		...
> > 
> > ... and then the following after the broken logic uses out_mmap_sem.
> > Could we be a little more consistent here one way or the other? The
> > change looks functionally correct to me either way:
> > 
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > 
> > Brian
> Indeed, this is confusing.
> 
> The reason is that we don't want to call ext4_std_error() when
> ext4_break_layouts() fails. So we first store the error in 'rc', and then
> pass the error to 'error' at the end. (See b9c1c26739ec
> ("ext4: gracefully handle ext4_break_layouts() failure during truncate"))
> 
> However, because 'error' is not assigned, the goto out_mmap_sem label will
> execute some code that shouldn't be executed. Therefore, in the error
> handling of ext4_break_layouts(), we unlock and then goto err_out label.
> 
> While under normal error conditions, 'error' is assigned, and it should
> enter the out_mmap_sem label. Therefore, in the error handling of
> ext4_inode_attach_jinode(), we directly goto out_mmap_sem label.
> 
> The handling of 'rc' in this function is indeed very subtle.
> 

Ah, indeed.. I glossed over the use of rc in there on my quick read.
Thanks for the clarification!

Brian

> 
> Cheers,
> Baokun
> > >   			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
> > > -- 
> > > 2.39.2
> > > 
> > > 
> 



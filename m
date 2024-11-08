Return-Path: <linux-ext4+bounces-5003-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B309C1455
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 03:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47DC1C21EFA
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 02:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2886F3BBEA;
	Fri,  8 Nov 2024 02:55:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E91BD9D1
	for <linux-ext4@vger.kernel.org>; Fri,  8 Nov 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034540; cv=none; b=qjGd7Ke0WIAGTPKA8WTEuL6dizWMWsckHwffnK4UmHDu0NzKzYMZ1IZNdTjYuwXrCSeqB3tq7aEOCKeMSToFPBYs7PXkBzGbAmZ9qLUig8pnStLW/FoqGOMqy4BUpdFpWZd9kbGquriA30tE6QSBuel55LiBptYJ2up+0v5/KHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034540; c=relaxed/simple;
	bh=dDdjjhaktTUyrqHXDk5EsVIanCu8Dc1qMBB1Jn9bjHE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXELr0uxVkJycddqZdB47h6T10qv++3UUxO+6ZANrS/jO0EYtJ5W/XRwn7QLWakQ+7PCnY1R8n/gLsAQUi6maksvyJdXsys7zAOk3h7BiJgARVcABFGP91yQEi+foPQ0t2Wq/wnwBC0VI1am1UUjrFj85qWLE20iCKWu7XeLgKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xl3Rg4hqsz2FbCF;
	Fri,  8 Nov 2024 10:53:51 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id DC1C91402CD;
	Fri,  8 Nov 2024 10:55:34 +0800 (CST)
Received: from localhost (10.175.127.227) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 Nov
 2024 10:55:34 +0800
Date: Fri, 8 Nov 2024 11:09:35 +0800
From: Long Li <leo.lilong@huawei.com>
To: Jan Kara <jack@suse.cz>, <leo.lilong@huaweicloud.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [RESEND PATCH] ext4: Fix race in buffer_head read fault injection
Message-ID: <20241108030935.GA3232538@ceph-admin>
References: <20241024021909.4032340-1-leo.lilong@huaweicloud.com>
 <20241107155342.sonicmzg7leo63nq@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241107155342.sonicmzg7leo63nq@quack3>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Thu, Nov 07, 2024 at 04:53:42PM +0100, Jan Kara wrote:
> On Thu 24-10-24 10:19:09, leo.lilong@huaweicloud.com wrote:
> > From: Long Li <leo.lilong@huawei.com>
> > 
> > When I enabled ext4 debug for fault injection testing, I encountered the
> > following warning:
> > 
> >   EXT4-fs error (device sda): ext4_read_inode_bitmap:201: comm fsstress:
> >          Cannot read inode bitmap - block_group = 8, inode_bitmap = 1051
> >   WARNING: CPU: 0 PID: 511 at fs/buffer.c:1181 mark_buffer_dirty+0x1b3/0x1d0
> > 
> > The root cause of the issue lies in the improper implementation of ext4's
> > buffer_head read fault injection. The actual completion of buffer_head
> > read and the buffer_head fault injection are not atomic, which can lead
> > to the uptodate flag being cleared on normally used buffer_heads in race
> > conditions.
> > 
> > [CPU0]           [CPU1]         [CPU2]
> > ext4_read_inode_bitmap
> >   ext4_read_bh()
> >   <bh read complete>
> >                  ext4_read_inode_bitmap
> >                    if (buffer_uptodate(bh))
> >                      return bh
> >                                jbd2_journal_commit_transaction
> >                                  __jbd2_journal_refile_buffer
> >                                    __jbd2_journal_unfile_buffer
> >                                      __jbd2_journal_temp_unlink_buffer
> >   ext4_simulate_fail_bh()
> >     clear_buffer_uptodate
> >                                       mark_buffer_dirty
> >                                         <report warning>
> >                                         WARN_ON_ONCE(!buffer_uptodate(bh))
> > 
> > The best approach would be to perform fault injection in the IO completion
> > callback function, rather than after IO completion. However, the IO
> > completion callback function cannot get the fault injection code in sb.
> > 
> > Fix it by passing the result of fault injection into the bh read function,
> > we simulate faults within the bh read function itself. This requires adding
> > an extra parameter to the bh read functions that need fault injection.
> > 
> > Fixes: 46f870d690fe ("ext4: simulate various I/O and checksum errors when reading metadata")
> > Signed-off-by: Long Li <leo.lilong@huawei.com>
> 
> Thanks for the fix! One suggestion below:
> 
> > @@ -3100,9 +3092,9 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
> >  extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
> >  						   sector_t block);
> >  extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
> > -				bh_end_io_t *end_io);
> > +				bh_end_io_t *end_io, bool simu_fail);
> >  extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> > -			bh_end_io_t *end_io);
> > +			bh_end_io_t *end_io, bool simu_fail);
> 
> Instead of adding a bool argument whether we should simulate a failure, I'd
> pass the 'code' into ext4_read_bh_nowait() and handle the check in there.
> That reduces the boilerplate code a bit and looks somewhat cleaner.
> 
> 								Honza

Hi Honza,

Thanks for your reply, your solution does appear more cleaner, but it seems
we cannot directly get sbi->s_simulate_fail in ext4_read_bh_nowait(), nor
can we get it in the IO completion callback function.

Thanks,
Long Li


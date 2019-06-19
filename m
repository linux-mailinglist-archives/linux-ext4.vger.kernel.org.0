Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2934B825
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfFSMZA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 08:25:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727134AbfFSMZA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Jun 2019 08:25:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F7F4AEC5;
        Wed, 19 Jun 2019 12:24:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 47FC01E434D; Wed, 19 Jun 2019 14:24:57 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:24:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhangjs Jinshui <leozhangjs@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangjs <zachary@baishancloud.com>
Subject: Re: [PATCH] ext4: make __ext4_get_inode_loc plug
Message-ID: <20190619122457.GF27954@quack2.suse.cz>
References: <20190617155712.51339-1-leozhangjs@gmail.com>
 <20190619110836.GC32409@quack2.suse.cz>
 <8BF438AD-0EA2-4F15-B565-A171E3AB13FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8BF438AD-0EA2-4F15-B565-A171E3AB13FA@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 19-06-19 19:34:00, Zhangjs Jinshui wrote:
> You can blktrace
> 
>   8,80  31       11     0.296373038 2885275  Q  RA 8279571464 + 8 [xxxx]
>   8,80  31       12     0.296374017 2885275  G  RA 8279571464 + 8 [xxxx]
>   8,80  31       13     0.296375468 2885275  I  RA 8279571464 + 8 [xxxx]
>   8,80  31       14     0.296382099  3886  D  RA 8279571464 + 8 [kworker/31:1H]
>   8,80  31       15     0.296391907 2885275  Q  RA 8279571472 + 8 [xxxx]
>   8,80  31       16     0.296392275 2885275  G  RA 8279571472 + 8 [xxxx]
>   8,80  31       17     0.296393305 2885275  I  RA 8279571472 + 8 [xxxx]
>   8,80  31       18     0.296395844  3886  D  RA 8279571472 + 8 [kworker/31:1H]
>   8,80  31       19     0.296399685 2885275  Q  RA 8279571480 + 8 [xxxx]
>   8,80  31       20     0.296400025 2885275  G  RA 8279571480 + 8 [xxxx]
>   8,80  31       21     0.296401232 2885275  I  RA 8279571480 + 8 [xxxx]
>   8,80  31       22     0.296403422  3886  D  RA 8279571480 + 8 [kworker/31:1H]
>   8,80  31       23     0.296407375 2885275  Q  RA 8279571488 + 8 [xxxx]
>   8,80  31       24     0.296407721 2885275  G  RA 8279571488 + 8 [xxxx]
>   8,80  31       25     0.296408904 2885275  I  RA 8279571488 + 8 [xxxx]
>   8,80  31       26     0.296411127  3886  D  RA 8279571488 + 8 [kworker/31:1H]
>   8,80  31       27     0.296414779 2885275  Q  RA 8279571496 + 8 [xxxx]
>   8,80  31       28     0.296415119 2885275  G  RA 8279571496 + 8 [xxxx]
>   8,80  31       29     0.296415744 2885275  I  RA 8279571496 + 8 [xxxx]
>   8,80  31       30     0.296417779  3886  D  RA 8279571496 + 8 [kworker/31:1H]
> 
> these RA io were caused by ext4_inode_readahead_blks, there are all not merged becourse of the unplugged state.
> the backtrace shows below, was traced by systemtap ioblock.request filtered by "opf & 1 << 19"
> 
>  0xffffffff8136fb20 : generic_make_request+0x0/0x2f0 [kernel]
>  0xffffffff8136fe7e : submit_bio+0x6e/0x130 [kernel]
>  0xffffffff812971e6 : submit_bh_wbc+0x156/0x190 [kernel]
>  0xffffffff81297bca : ll_rw_block+0x6a/0xb0 [kernel]
>  0xffffffff81297cc0 : __breadahead+0x40/0x70 [kernel]
>  0xffffffffa0392c9a : __ext4_get_inode_loc+0x37a/0x3d0 [ext4]
>  0xffffffffa0396a6c : ext4_iget+0x8c/0xc00 [ext4]
>  0xffffffffa03ad98a : ext4_lookup+0xca/0x1d0 [ext4]
>  0xffffffff8126b814 : path_openat+0xcb4/0x1250 [kernel]
>  0xffffffff8126dc41 : do_filp_open+0x91/0x100 [kernel]
>  0xffffffff8125ad86 : do_sys_open+0x126/0x210 [kernel]
>  0xffffffff81003864 : do_syscall_64+0x74/0x1a0 [kernel]
>  0xffffffff81800081 : entry_SYSCALL_64_after_hwframe+0x3d/0xa2 [kernel]
> 
> I have patched it on online servers, It can improved the performance.

Ah, OK, directory lookup code... Makes sense. Thanks for sharing!

								Honza

> 
> > 在 2019年6月19日，19:08，Jan Kara <jack@suse.cz> 写道：
> > 
> > On Mon 17-06-19 23:57:12, jinshui zhang wrote:
> >> From: zhangjs <zachary@baishancloud.com <mailto:zachary@baishancloud.com>>
> >> 
> >> If the task is unplugged when called, the inode_readahead_blks may not be merged, 
> >> these will cause small pieces of io, It should be plugged.
> >> 
> >> Signed-off-by: zhangjs <zachary@baishancloud.com <mailto:zachary@baishancloud.com>>
> > 
> > Out of curiosity, on which path do you see __ext4_get_inode_loc() being
> > called without IO already plugged?
> > 
> > Otherwise the patch looks good to me. You can add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz <mailto:jack@suse.cz>>
> > 
> > 								Honza
> > 
> >> ---
> >> fs/ext4/inode.c | 6 ++++++
> >> 1 file changed, 6 insertions(+)
> >> 
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index c7f77c6..8fe046b 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -4570,6 +4570,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
> >> 	struct buffer_head	*bh;
> >> 	struct super_block	*sb = inode->i_sb;
> >> 	ext4_fsblk_t		block;
> >> +	struct blk_plug		plug;
> >> 	int			inodes_per_block, inode_offset;
> >> 
> >> 	iloc->bh = NULL;
> >> @@ -4654,6 +4655,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
> >> 		}
> >> 
> >> make_io:
> >> +		blk_start_plug(&plug);
> >> +
> >> 		/*
> >> 		 * If we need to do any I/O, try to pre-readahead extra
> >> 		 * blocks from the inode table.
> >> @@ -4688,6 +4691,9 @@ static int __ext4_get_inode_loc(struct inode *inode,
> >> 		get_bh(bh);
> >> 		bh->b_end_io = end_buffer_read_sync;
> >> 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
> >> +
> >> +		blk_finish_plug(&plug);
> >> +
> >> 		wait_on_buffer(bh);
> >> 		if (!buffer_uptodate(bh)) {
> >> 			EXT4_ERROR_INODE_BLOCK(inode, block,
> >> -- 
> >> 1.8.3.1
> >> 
> > -- 
> > Jan Kara <jack@suse.com <mailto:jack@suse.com>>
> > SUSE Labs, CR
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

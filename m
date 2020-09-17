Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A226DAC0
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgIQLvV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 07:51:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:59946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgIQLvK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Sep 2020 07:51:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95DA1ADBD;
        Thu, 17 Sep 2020 11:51:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 680351E12E1; Thu, 17 Sep 2020 13:51:03 +0200 (CEST)
Date:   Thu, 17 Sep 2020 13:51:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.com
Subject: Re: [PATCH] ext4: clear buffer verified flag if read meta block from
 disk
Message-ID: <20200917115103.GD16097@quack2.suse.cz>
References: <20200914112420.1906407-1-yi.zhang@huawei.com>
 <20200915130711.GP4863@quack2.suse.cz>
 <2b43d24e-f220-a9f8-d1a6-e85363020a3b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b43d24e-f220-a9f8-d1a6-e85363020a3b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 15-09-20 22:57:35, zhangyi (F) wrote:
> Hi, Jan
> 
> On 2020/9/15 21:07, Jan Kara wrote:
> > On Mon 14-09-20 19:24:20, zhangyi (F) wrote:
> >> The metadata buffer is no longer trusted after we read it from disk
> >> again because it is not uptodate for some reasons (e.g. failed to write
> >> back). Otherwise we may get below memory corruption problem in
> >> ext4_ext_split()->memset() if we read stale data from the newly
> >> allocated extent block on disk which has been failed to async write
> >> out but miss verify again since the verified bit has already been set
> >> on the buffer.
> >>
> >> [   29.774674] BUG: unable to handle kernel paging request at ffff88841949d000
> >> ...
> >> [   29.783317] Oops: 0002 [#2] SMP
> >> [   29.784219] R10: 00000000000f4240 R11: 0000000000002e28 R12: ffff88842fa1c800
> >> [   29.784627] CPU: 1 PID: 126 Comm: kworker/u4:3 Tainted: G      D W
> >> [   29.785546] R13: ffffffff9cddcc20 R14: ffffffff9cddd420 R15: ffff88842fa1c2f8
> >> [   29.786679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS ?-20190727_0738364
> >> [   29.787588] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
> >> [   29.789288] Workqueue: writeback wb_workfn
> >> [   29.790319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   29.790321]  (flush-8:0)
> >> [   29.790844] CR2: 0000000000000008 CR3: 00000004234f2000 CR4: 00000000000006f0
> >> [   29.791924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> [   29.792839] RIP: 0010:__memset+0x24/0x30
> >> [   29.793739] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> [   29.794256] Code: 90 90 90 90 90 90 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 033
> >> [   29.795161] Kernel panic - not syncing: Fatal exception in interrupt
> >> ...
> >> [   29.808149] Call Trace:
> >> [   29.808475]  ext4_ext_insert_extent+0x102e/0x1be0
> >> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
> >> [   29.809652]  ext4_map_blocks+0x290/0x8a0
> >> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
> >> [   29.809652]  ext4_map_blocks+0x290/0x8a0
> >> [   29.810161]  ext4_writepages+0xc85/0x17c0
> >> ...
> >>
> >> Fix this by clear buffer's verified bit if we read it from disk again.
> >>
> >> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> > 
> > Good spotting! When looking at the patch I was just wondering that it's
> > rather easy to miss clearing of buffer_verified() bit in some place where
> > we read metadata block from disk. So I was wondering that maybe it would be
> 
> Indeed, I clear the buffer_verified() bit in some common helpers of ext4,
> such as ext4_bread() and ext4_sb_bread(), so we may not miss clear it
> where we invoke these helpers, but it is rather easy to miss in the
> others places where submit read bio directly. How about add some common
> helpers for them too ?

I was thinking about this for some time and yes, I agree this is probably
the best way forward. I've looked at places where we submit reads and
probably some helper like below should work:

void ext4_read_bh(struct buffer_head *bh, int op_flags,
		  void (*end_io)(struct buffer_head *bh, int uptodate))

which would do the final ext4_buffer_uptodate() check, set end_io (fill in
end_buffer_read_sync if NULL), clear verified bit, get bh ref, and do
submit_bh(). And use this in all the places reading metadata buffers
instead of various different helpers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

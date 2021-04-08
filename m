Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62735878B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhDHOxx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 10:53:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhDHOxv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 8 Apr 2021 10:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E01CB124;
        Thu,  8 Apr 2021 14:53:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF3D31F2B77; Thu,  8 Apr 2021 16:53:38 +0200 (CEST)
Date:   Thu, 8 Apr 2021 16:53:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH 3/3] ext4: add rcu to prevent use after free when umount
 filesystem
Message-ID: <20210408145338.GF3271@quack2.suse.cz>
References: <20210408113618.1033785-1-yi.zhang@huawei.com>
 <20210408113618.1033785-4-yi.zhang@huawei.com>
 <20210408135603.GD3271@quack2.suse.cz>
 <d75b2ebd-33fc-8f1e-a3b4-d4715ef85314@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75b2ebd-33fc-8f1e-a3b4-d4715ef85314@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-04-21 22:38:08, Zhang Yi wrote:
> On 2021/4/8 21:56, Jan Kara wrote:
> > On Thu 08-04-21 19:36:18, Zhang Yi wrote:
> >> There is a race between bdev_try_to_free_page() and
> >> jbd2_journal_destroy() that could end up triggering a use after free
> >> issue about journal.
> >>
> >> drop cache                           umount filesystem
> >> bdev_try_to_free_page()
> >>  get journal
> >>  jbd2_journal_try_to_free_buffers()  ext4_put_super()
> >>                                       kfree(journal)
> >>    access journal <-- lead to UAF
> >>
> >> The above race also could happens between the bdev_try_to_free_page()
> >> and the error path of ext4_fill_super(). This patch avoid this race by
> >> add rcu protection around accessing sbi->s_journal in
> >> bdev_try_to_free_page() and destroy the journal after an rcu grace
> >> period.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > OK, I see the problem. But cannot the use-after-free happen even for the
> > superblock itself (e.g., EXT4_SB(sb)->s_journal dereference)? I don't see
> > anything preventing that as blkdev_releasepage() just shamelessly does:
> > 
> > super = BDEV_I(page->mapping->host)->bdev.bd_super
> > 
> Hi, Jan.
> 
> I checked the superblock. In theory, the bdev_try_to_free_page() is invoked
> with page locked, the umount process will wait the page unlock on
> kill_block_super()->..->kill_bdev()->truncate_inode_pages_range() before free
> superblock, so I guess the use-after-free problem couldn't happen in general.
> But I think it's fragile and may invalidate if the bdev has more than one
> operners(__blkdev_put() call kill_bdev only if bd_openers becomes zero)?

Yes, kill_bdev() is only called when bd_openers drops to 0 but there can be
other processes having the bdev open (non-exclusively).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

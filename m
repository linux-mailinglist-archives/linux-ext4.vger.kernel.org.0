Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0585334EB71
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3PCo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 11:02:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231874AbhC3PCb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Mar 2021 11:02:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7591EB30E;
        Tue, 30 Mar 2021 15:02:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D3EF21E4353; Tue, 30 Mar 2021 17:02:29 +0200 (CEST)
Date:   Tue, 30 Mar 2021 17:02:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        yangerkun <yangerkun@huawei.com>, linfeilong@huawei.com
Subject: Re: [BUG && Question] question of SB_ACTIVE flag in
 ext4_orphan_cleanup()
Message-ID: <20210330150229.GC30749@quack2.suse.cz>
References: <8a6864dd-7e6c-5268-2b5b-1010f99d2a1b@huawei.com>
 <20210322172551.GJ31783@quack2.suse.cz>
 <b1a05885-1d7b-b9d1-80da-785633cbfc6a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a05885-1d7b-b9d1-80da-785633cbfc6a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 29-03-21 17:20:35, Zhang Yi wrote:
> On 2021/3/23 1:25, Jan Kara wrote:
> > Hi!
> > 
> > On Mon 22-03-21 23:24:23, Zhang Yi wrote:
> >> We find a use after free problem when CONFIG_QUOTA is enabled, the detail of
> >> this problem is below.
> >>
> >> mount_bdev()
> >> 	ext4_fill_super()
> >> 		sb->s_root = d_make_root(root);
> >> 		ext4_orphan_cleanup()
> >> 			sb->s_flags |= SB_ACTIVE; <--- 1. mark sb active
> >> 			ext4_orphan_get()
> >> 			ext4_truncate()
> >> 				ext4_block_truncate_page()
> >> 					mark_buffer_dirty <--- 2. dirty inode
> >> 			iput()
> >> 				iput_final  <--- 3. put into lru list
> >> 		ext4_mark_recovery_complete  <--- 4. failed and return error
> >> 		sb->s_root = NULL;
> >> 	deactivate_locked_super()
> >> 		kill_block_super()
> >> 			generic_shutdown_super()
> >> 				<--- 5. did not evict_inodes
> >> 		put_super()
> >> 			__put_super()
> >> 				<--- 6. put super block
> >>
> >> Because of the truncated inodes was dirty and will write them back later, it
> >> will trigger use after free problem. Now the question is why we need to set
> >> SB_ACTIVE bit when enable CONFIG_QUOTA below?
> >>
> >>   #ifdef CONFIG_QUOTA
> >>           /* Needed for iput() to work correctly and not trash data */
> >>           sb->s_flags |= SB_ACTIVE;
> >>
> >> This code was merged long long ago in v2.6.6, IIUC, it may not affect
> >> the quota statistics it we evict inode directly in the last iput.
> >> In order to slove this UAF problem, I'm not sure is there any side effect
> >> if we just remove this code, or remove SB_ACTIVE and call evict_inodes()
> >> in the error path of ext4_fill_super().
> >>
> >> Could you give some suggestions?
> > 
> > That's a very good question. I do remember that I've added this code back
> > then because otherwise orphan cleanup was loosing updates to quota files.
> > But you're right that now I don't see how that could be happening and it
> > would be nice if we could get rid of this hack (and even better if it also
> > fixes the problem you've found). I guess I'll just try and test this change
> > with various quota configurations to see whether something still breaks or
> > not. Thanks report!
> > 
> 
> Thanks for taking time to look at this, is this change OK under your various
> quota test cases?

Yes, I did tests both with journalled quotas and with ext4 quota feature
and the quota accounting was correct after orphan recovery. So just
removing the SB_ACTIVE setting is fine AFAICT. Will you send a patch or
should I do it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

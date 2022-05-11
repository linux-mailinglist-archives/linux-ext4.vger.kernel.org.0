Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD65230E3
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiEKKno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241974AbiEKKnF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 06:43:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131713917D;
        Wed, 11 May 2022 03:40:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 718E621BBF;
        Wed, 11 May 2022 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652265658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofid47dt60Dm91ho9M8uL9kLkVt/rULkt4KXybdMckE=;
        b=Lol+a+kcWA56sN586Oba1fpxW7uV0D//ORTN8nwpZWGK4WaMdEYCwZvI/+KD9gdHSS0cgR
        kc+Qlacc7Yc9A3WSeYaPLisNHrRfxg5KWt7Trxs1K9d8oiV/OpspkeuI0ldlrh8hGZTMMo
        dijeZqRGWZpoJgdXKCVRTgMf3UWaH/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652265658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofid47dt60Dm91ho9M8uL9kLkVt/rULkt4KXybdMckE=;
        b=LaFoPCa6ZUXw8ce8hqFxk1K5ccJckkQnr5kOA0e2ohAY019lRpD8kUr7VsW/PLdIb2qWyj
        7ayWpeDq6h8ofLBw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 562472C141;
        Wed, 11 May 2022 10:40:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ECF99A062A; Wed, 11 May 2022 12:40:57 +0200 (CEST)
Date:   Wed, 11 May 2022 12:40:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_writepages
Message-ID: <20220511104057.dzy3vz2zitqxwi2u@quack3.lan>
References: <20220505135708.2629657-1-yebin10@huawei.com>
 <20220509130101.7myd6mhwd54fhvq7@quack3.lan>
 <627A34FE.6000605@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627A34FE.6000605@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-05-22 17:48:46, yebin wrote:
> On 2022/5/9 21:01, Jan Kara wrote:
> > On Thu 05-05-22 21:57:08, Ye Bin wrote:
> > > we got issue as follows:
> > > EXT4-fs error (device loop0): ext4_mb_generate_buddy:1141: group 0, block bitmap and bg descriptor inconsistent: 25 vs 31513 free cls
> > > ------------[ cut here ]------------
> > > kernel BUG at fs/ext4/inode.c:2708!
> > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > > CPU: 2 PID: 2147 Comm: rep Not tainted 5.18.0-rc2-next-20220413+ #155
> > > RIP: 0010:ext4_writepages+0x1977/0x1c10
> > > RSP: 0018:ffff88811d3e7880 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88811c098000
> > > RDX: 0000000000000000 RSI: ffff88811c098000 RDI: 0000000000000002
> > > RBP: ffff888128140f50 R08: ffffffffb1ff6387 R09: 0000000000000000
> > > R10: 0000000000000007 R11: ffffed10250281ea R12: 0000000000000001
> > > R13: 00000000000000a4 R14: ffff88811d3e7bb8 R15: ffff888128141028
> > > FS:  00007f443aed9740(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000020007200 CR3: 000000011c2a4000 CR4: 00000000000006e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   <TASK>
> > >   do_writepages+0x130/0x3a0
> > >   filemap_fdatawrite_wbc+0x83/0xa0
> > >   filemap_flush+0xab/0xe0
> > >   ext4_alloc_da_blocks+0x51/0x120
> > >   __ext4_ioctl+0x1534/0x3210
> > >   __x64_sys_ioctl+0x12c/0x170
> > >   do_syscall_64+0x3b/0x90
> > > 
> > > It may happen as follows:
> > > 1. write inline_data inode
> > > vfs_write
> > >    new_sync_write
> > >      ext4_file_write_iter
> > >        ext4_buffered_write_iter
> > >          generic_perform_write
> > > 	  ext4_da_write_begin
> > > 	    ext4_da_write_inline_data_begin -> If inline data size too
> > > 	    small will allocate block to write, then mapping will has
> > > 	    dirty page
> > > 	    	ext4_da_convert_inline_data_to_extent ->clear EXT4_STATE_MAY_INLINE_DATA
> > > 2. fallocate
> > > do_vfs_ioctl
> > >    ioctl_preallocate
> > >      vfs_fallocate
> > >        ext4_fallocate
> > >          ext4_convert_inline_data
> > > 	  ext4_convert_inline_data_nolock
> > > 	    ext4_map_blocks -> fail will goto restore data
> > > 	    ext4_restore_inline_data
> > > 	      ext4_create_inline_data
> > > 	      ext4_write_inline_data
> > > 	      ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
> > > 3. writepages
> > > __ext4_ioctl
> > >    ext4_alloc_da_blocks
> > >      filemap_flush
> > >        filemap_fdatawrite_wbc
> > >          do_writepages
> > > 	  ext4_writepages
> > > 	    if (ext4_has_inline_data(inode))
> > > 	      BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> > > 
> > > To solved this issue, record origin 'EXT4_STATE_MAY_INLINE_DATA' flag, then pass
> > > value to 'ext4_restore_inline_data', 'ext4_restore_inline_data' will
> > > decide to if recovery 'EXT4_STATE_MAY_INLINE_DATA' flag according to parameter.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > Thanks for the patch. I agree it will fix the crash you have spotted but
> > I'm somewhat wondering whether it would not be simpler to just move the
> > call to ext4_destroy_inline_data_nolock() in
> > ext4_convert_inline_data_nolock() later, after we have done writing
> > data_bh. That way we can completely remove ext4_restore_inline_data() and
> > as a consequence avoid problems. What do you think?
> > 
> > 								Honza
> 
> It may be a good idea, but i didn't know how to handle when call
> ext4_destroy_inline_data_nolock() failed. As it may lead to
> 'ei <../cgi-bin/global.cgi?pattern=ei&type=symbol>->i_reserved_data_blocks
> <../cgi-bin/global.cgi?pattern=i_reserved_data_blocks&type=symbol>'
> incorrect, and also lead to data lost.
> I have another idea which will inlcude in v2 patch.

Well, that call failing means something is seriously wrong with the
filesystem (IO errors, metadata corruption) so we don't care much what
happens. Also currently you have the problem that restoration of inline data
can fail so I don't think there's really tangible difference.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

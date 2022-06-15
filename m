Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FAA54CFB8
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbiFOR0P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349161AbiFOR0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 13:26:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3803AA5E;
        Wed, 15 Jun 2022 10:26:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5C2361F974;
        Wed, 15 Jun 2022 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655313970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=diXZtSs4ge+y3SfxBTClRHiG4CCNfLznzrb0IpVDTr0=;
        b=OycMHuhNdnbHeX0XjNvCpxdM6uwB4B8LqJJ0xGrYKl5ISiONTapDk7Ai/1dEOLuObucXey
        OoZ+RXJyG1PTqL6W6De/mMRiICtUFcXR2/p/CAiRDNq4yVTxF9aWkkPXLKf5P9HgKyMz5A
        J9du69THgknmCtEoPat/7u/Mm1NeFbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655313970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=diXZtSs4ge+y3SfxBTClRHiG4CCNfLznzrb0IpVDTr0=;
        b=LYBze45qd2tGzASyNp/EpE/+mZIhGR6oJYryXP/aV/CDLYNonTPdii5eDy2g5anTDmD2ZA
        q+dBJn3E6kDeIwCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 427282C141;
        Wed, 15 Jun 2022 17:26:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CB64CA062E; Wed, 15 Jun 2022 19:26:09 +0200 (CEST)
Date:   Wed, 15 Jun 2022 19:26:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Ye Bin <yebin10@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_iomap_begin as race
 between bmap and write
Message-ID: <20220615172609.oydxhjw7exas23hd@quack3.lan>
References: <20220615135850.1961759-1-yebin10@huawei.com>
 <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
 <20220615153123.ab32zt75q7yn7jc5@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615153123.ab32zt75q7yn7jc5@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-06-22 21:01:23, Ritesh Harjani wrote:
> On 22/06/15 08:51PM, Ritesh Harjani wrote:
> > On 22/06/15 09:58PM, Ye Bin wrote:
> > > We got issue as follows:
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
> > > RIP: 0010:ext4_iomap_begin+0x182/0x5d0
> > > RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
> > > RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> > > RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
> > > R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
> > > R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
> > > FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  iomap_apply+0x119/0x570
> > >  iomap_bmap+0x124/0x150
> > >  ext4_bmap+0x14f/0x250
> > >  bmap+0x55/0x80
> > >  do_vfs_ioctl+0x952/0xbd0
> > >  __x64_sys_ioctl+0xc6/0x170
> > >  do_syscall_64+0x33/0x40
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Above issue may happen as follows:
> > >           bmap                    write
> > > bmap
> > >   ext4_bmap
> > >     iomap_bmap
> > >       ext4_iomap_begin
> > >                             ext4_file_write_iter
> > > 			      ext4_buffered_write_iter
> > > 			        generic_perform_write
> > > 				  ext4_da_write_begin
> > > 				    ext4_da_write_inline_data_begin
> > > 				      ext4_prepare_inline_data
> > > 				        ext4_create_inline_data
> > > 					  ext4_set_inode_flag(inode,
> > > 						EXT4_INODE_INLINE_DATA);
> > >       if (WARN_ON_ONCE(ext4_has_inline_data(inode))) ->trigger bug_on
> > >
> > > To solved above issue hold inode lock in ext4_bamp.
> > 											^^^ ext4_bmap()
> >
> > I checked the paths where bmap() kernel api can be called i.e. from jbd2/fc and
> > generic_swapfile_activate() (apart from ioctl())
> > For jbd2, it will be called with j_inode within bmap(), hence taking a inode lock
> > of the inode passed within ext4_bmap() (j_inode in this case) should be safe here.
> > Same goes with swapfile path as well.
> >
> > However I feel maybe we should hold inode_lock_shared() since there is no
> > block/extent map layout changes that can happen via ext4_bmap().
> > Hence read lock is what IMO should be used here.
> 
> On second thoughts, shoudn't we use ext4_iomap_report_ops here?  Can't
> recollect why we didn't use ext4_iomap_report_ops for iomap_bmap() in the
> first place. Should be good to verify it once.

Hum, but I guess there's a deeper problem than ext4_bmap(). Generally we
have places doing block mapping (such as ext4_writepages(), readahead, or
page fault) where we don't hold i_rwsem and racing
ext4_create_inline_data() could confuse them? I guess we need to come up
with a sound scheme how inline data creation is serialized with these
operations (or just decide to remove the inline data feature altogether as
we already discussed once because the complexity likely is not worth the
gain).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

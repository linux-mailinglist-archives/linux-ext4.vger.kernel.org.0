Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577265E9E1
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjAEL2g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 06:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjAEL2J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 06:28:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85791AA1E
        for <linux-ext4@vger.kernel.org>; Thu,  5 Jan 2023 03:27:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9444E23442;
        Thu,  5 Jan 2023 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672918075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctbeyAoub1q0v4yv/y+5AIJJZIw6X82k9X+G+CS4yhI=;
        b=x38Pa30pnodpzH3MeqKInTfGgC8ky4olfbkPn/Vf2ddE5kdMKMEQYFTbNcAkOJVHC0Mbsa
        CrS1QjYGdNwl8F8fWF+VztrQOIq1XyA7ZcRglEU+7dnyuB6a+LfphDWa8CfzK4sU51HivC
        lzH48koso29jfBPjrC+uxNEKmspxatc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672918075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctbeyAoub1q0v4yv/y+5AIJJZIw6X82k9X+G+CS4yhI=;
        b=m1gK5J/jqV6F4sk0dPduv+ekt839e4JiLgJRIvWz11NrK/gVLOsffRYB0ROJWLi2E+ccd7
        GnrgygKan3hCoUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FAB913338;
        Thu,  5 Jan 2023 11:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TAcmHzu0tmPyLwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 05 Jan 2023 11:27:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 18C28A0742; Thu,  5 Jan 2023 12:27:55 +0100 (CET)
Date:   Thu, 5 Jan 2023 12:27:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        andrew.perepechko@hpe.com,
        Artem Blagodarenko <ablagodarenko@ddn.com>
Subject: Re: [PATCH v4] ext4: truncate during setxattr leads to kernel panic
Message-ID: <20230105112755.tmdozw2b73stelsj@quack3>
References: <20220711145735.53676-1-artem.blagodarenko@gmail.com>
 <20230104160308.baj4u5xzfz3jy2z2@quack3>
 <Y7WwuwlmVOU9WTKD@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WwuwlmVOU9WTKD@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-01-23 09:00:43, Darrick J. Wong wrote:
> On Wed, Jan 04, 2023 at 05:03:08PM +0100, Jan Kara wrote:
> > On Mon 11-07-22 10:57:34, Artem Blagodarenko wrote:
> > > When changing a large xattr value to a different large xattr
> > > value, the old xattr inode is freed. Truncate during the final iput causes
> > > current transaction restart. Eventually, parent inode bh is marked dirty and
> > > kernel panic happens when jbd2 figures out that this bh belongs to the
> > > committed transaction.
> > > 
> > > Here is a reporoducer:
> > > 
> > > dd if=/dev/zero of=/tmp/ldiskfs bs=1M count=100
> > > mkfs.ext4 -O ea_inode /tmp/ldiskfs -J size=16 -I 512
> > > mkdir -p /tmp/ldiskfs_m
> > > mount -t ext4 /tmp/ldiskfs /tmp/ldiskfs_m -o loop,commit=600,no_mbcache
> > > touch /tmp/ldiskfs_m/file{1..1024}
> > > V=$(for i in `seq 60000`; do echo -n x ; done)
> > > V1="1$V"
> > > V2="2$V"
> > > for k in 1 2 3 4 5 6 7 8 9; do
> > >         setfattr -n user.xattr -v $V /tmp/ldiskfs_m/file{1..1024}
> > >         setfattr -n user.xattr -v $V1 /tmp/ldiskfs_m/file{1..1024} &
> > >         setfattr -n user.xattr -v $V2 /tmp/ldiskfs_m/file{1024..1} &
> > >         wait
> > > done
> > > umount /tmp/ldiskfs_m
> > > 
> > > The above reproducer triggers the following oops (using a build from a
> > > recent linux.git commit):
> > > 
> > > [  181.269541] ------------[ cut here ]------------
> > > [  181.269733] kernel BUG at fs/jbd2/transaction.c:1511!
> > > [  181.269951] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > [  181.270169] CPU: 0 PID: 940 Comm: setfattr Not tainted
> > > 5.17.0-13430-g787af64d05cd #9
> > > [  181.270243] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> > > VirtualBox 12/01/2006
> > > [  181.270243] RIP: 0010:jbd2_journal_dirty_metadata+0x400/0x420
> > > [  181.270243] Code: 24 4c 4c 8b 0c 24 41 83 f8 01 0f 84 3c ff ff ff e9
> > > 24 94 0b 01 48 8b 7c 24 08 e8 cb f6 df ff 4d 39 6c 24 70 0f 84 e6 fc ff
> > > ff <0f> 0b 0f 0b c7 4
> > > 4 24 18 e4 ff ff ff e9 9f fe ff ff 0f 0b c7 44 24
> > > [  181.270243] RSP: 0018:ffff88802632f698 EFLAGS: 00010207
> > > [  181.270243] RAX: 0000000000000000 RBX: ffff88800044fcc8 RCX:
> > > ffffffffa73a03b5
> > > [  181.270243] RDX: dffffc0000000000 RSI: 0000000000000004 RDI:
> > > ffff888032ff6f58
> > > [  181.270243] RBP: ffff88802eb04418 R08: ffffffffa6f502bf R09:
> > > ffffed1004c65ec6
> > > [  181.270243] R10: 0000000000000003 R11: ffffed1004c65ec5 R12:
> > > ffff888032ff6ee8
> > > [  181.270243] R13: ffff888024af8300 R14: ffff88800044fcec R15:
> > > ffff888032ff6f50
> > > [  181.270243] FS:  00007ffb5f6e3740(0000) GS:ffff888034800000(0000)
> > > knlGS:0000000000000000
> > > [  181.270243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  181.270243] CR2: 00007f9ca09dc024 CR3: 0000000032244000 CR4:
> > > 00000000000506f0
> > > [  181.270243] Call Trace:
> > > [  181.270243]  <TASK>
> > > [  181.270243]  __ext4_handle_dirty_metadata+0xb1/0x330
> > > [  181.270243]  ext4_mark_iloc_dirty+0x2b7/0xcd0
> > > [  181.270243]  ext4_xattr_set_handle+0x694/0xaf0
> > > [  181.270243]  ext4_xattr_set+0x164/0x260
> > > [  181.270243]  __vfs_setxattr+0xcb/0x110
> > > [  181.270243]  __vfs_setxattr_noperm+0x8c/0x300
> > > [  181.270243]  vfs_setxattr+0xff/0x250
> > > [  181.270243]  setxattr+0x14a/0x260
> > > [  181.270243]  path_setxattr+0x132/0x150
> > > [  181.270243]  __x64_sys_setxattr+0x63/0x70
> > > [  181.270243]  do_syscall_64+0x3b/0x90
> > > [  181.270243]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  181.270243] RIP: 0033:0x7ffb5efebbee
> > > 
> > > A possible fix is to call this final iput in a separate thread.
> > > This way, setxattr transactions will never be split into two.
> > > Since the setxattr code adds xattr inodes with nlink=0 into the
> > > orphan list, old xattr inodes will be properly cleaned up in
> > > any case.
> > > 
> > > Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>
> > > Signed-off-by: Artem Blagodarenko <ablagodarenko@ddn.com>
> > > 
> > > Changes since v3:
> > > - execute delayed_iput() only then recount is 0
> > >   and iput() in all another cases
> > > Changes since v1:
> > > - fixed a bug added during the porting
> > > - fixed a workqueue related deadlock reported by Tetsuo Handa
> > 
> > Thanks for this fix! Did this patch get merged in some other form? As far
> > as I'm looking into the code this still seems to be a problem?
> > 
> > Looking into ext4_xattr_block_set() I can see more places that are dropping
> > ea_inode link count and that can theoretically result in the same problem?
> > In theory any iput() of ea_inode can result in ea_inode being deleted
> > unless current inode's xattr references this ea_inode (because another
> > process could have dropped the last xattr reference to the ea_inode) so we
> > need to be careful. For example even such a simple thing as
> > ext4_xattr_inode_cache_find() is prone to cause inode being deleted within
> > the currently running transaction... So we need some generic way how to
> > deal with these ea_inode iput() calls.
> > 
> > Honestly, I'm not yet sure how to do that in an elegant way.
> 
> XFS has a similar problem; we put all unreferenced inodes requiring
> cleanup work on a percpu list and run background workers ("inodegc") to
> deal with the mess.  That looks pretty similar to what you're doing
> here.
> 
> (That said, xfs inode lifetimes don't match the vfs...)

Thanks for the idea. Yes, I was also considering a list of ea_inodes to
drop (I wouldn't probably go as far as per-cpu list for this particular
usecase) and then a worker would perform iput() on listed inodes. We just
have to be careful because with VFS inode lifetime rules and locking we
cannot be sure whether the reference we're dropping is the last one or not.
OTOH we cannot list inode more than once for obvious reason so we have to
be somewhat careful with the list handling instead and create an atomic
sequence of "enlist an inode if not on list or iput() it before the inode
can get out of the list". And this is where I'm getting somewhat stuck
because I see two solutions and I don't like either of the two much :).
Either we have a superblock-wide lock synchronizing iputs on ea inodes
(that can get really slow) or we provide iput_unless_last() primitive and
have a retry loop like:

retry:
	spin_lock(list_lock);
	if (inode not listed) {
		add to list
		spin_unlock(list_lock);
	} else {
		spin_unlock(list_lock);
		if (!iput_unless_last(inode))
			goto retry;
	}


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

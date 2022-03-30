Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B314EC5AA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbiC3NcD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Mar 2022 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbiC3NcC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Mar 2022 09:32:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D391517E9;
        Wed, 30 Mar 2022 06:30:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 286DD21116;
        Wed, 30 Mar 2022 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648647016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSaiFh/IADoAovOegWYbx7T/lKLMxBJuJmwbVK1rCps=;
        b=llSqGEk0nHPvzIgPth2ycz5W2b6boih6ywbxmtx0vFMBt3n8BkFZQDp8ufrS/RFAT90cz2
        /IdksuEkj03WEH2CuNqhUDX4TfyGOv9w9NVsn7qRrSRP3WNoKPjFcQrmAO/Z7Pkk+Gp0mG
        uZ7bKv1a9V+gNR2dJKIgiTOr/BeBt1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648647016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSaiFh/IADoAovOegWYbx7T/lKLMxBJuJmwbVK1rCps=;
        b=7bMt2CHRYAHPgbnIbv63l3QSlEr3TW1h+V+sfSf2tZ82DffkPlONVM61svu0ze8GHAZrsl
        fU7F7HkUxjX5faBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD666A3B82;
        Wed, 30 Mar 2022 13:30:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 62E8AA0610; Wed, 30 Mar 2022 15:30:15 +0200 (CEST)
Date:   Wed, 30 Mar 2022 15:30:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix warning in ext4_handle_inode_extension
Message-ID: <20220330133015.yxfnnw564wgehjc3@quack3.lan>
References: <20220326065351.761952-1-yebin10@huawei.com>
 <20220329092810.j5ngxckygut6mxo2@quack3.lan>
 <6244482D.4090603@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6244482D.4090603@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 30-03-22 20:08:13, yebin wrote:
> On 2022/3/29 17:28, Jan Kara wrote:
> > On Sat 26-03-22 14:53:51, Ye Bin wrote:
> > > We got issue as follows:
> > > EXT4-fs error (device loop0) in ext4_reserve_inode_write:5741: Out of memory
> > > EXT4-fs error (device loop0): ext4_setattr:5462: inode #13: comm syz-executor.0: mark_inode_dirty error
> > > EXT4-fs error (device loop0) in ext4_setattr:5519: Out of memory
> > > EXT4-fs error (device loop0): ext4_ind_map_blocks:595: inode #13: comm syz-executor.0: Can't allocate blocks for non-extent mapped inodes with bigalloc
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 4361 at fs/ext4/file.c:301 ext4_file_write_iter+0x11c9/0x1220
> > > Modules linked in:
> > > CPU: 1 PID: 4361 Comm: syz-executor.0 Not tainted 5.10.0+ #1
> > > RIP: 0010:ext4_file_write_iter+0x11c9/0x1220
> > > RSP: 0018:ffff924d80b27c00 EFLAGS: 00010282
> > > RAX: ffffffff815a3379 RBX: 0000000000000000 RCX: 000000003b000000
> > > RDX: ffff924d81601000 RSI: 00000000000009cc RDI: 00000000000009cd
> > > RBP: 000000000000000d R08: ffffffffbc5a2c6b R09: 0000902e0e52a96f
> > > R10: ffff902e2b7c1b40 R11: ffff902e2b7c1b40 R12: 000000000000000a
> > > R13: 0000000000000001 R14: ffff902e0e52aa10 R15: ffffffffffffff8b
> > > FS:  00007f81a7f65700(0000) GS:ffff902e3bc80000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: ffffffffff600400 CR3: 000000012db88001 CR4: 00000000003706e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   do_iter_readv_writev+0x2e5/0x360
> > >   do_iter_write+0x112/0x4c0
> > >   do_pwritev+0x1e5/0x390
> > >   __x64_sys_pwritev2+0x7e/0xa0
> > >   do_syscall_64+0x37/0x50
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > 
> > > Above issue may happen as follows:
> > > Assume
> > > inode.i_size=4096
> > > EXT4_I(inode)->i_disksize=4096
> > > 
> > > step 1: set inode->i_isize = 8192
> > > ext4_setattr
> > >    if (attr->ia_size != inode->i_size)
> > >      EXT4_I(inode)->i_disksize = attr->ia_size;
> > >      rc = ext4_mark_inode_dirty
> > >         ext4_reserve_inode_write
> > >            ext4_get_inode_loc
> > >              __ext4_get_inode_loc
> > >                sb_getblk --> return -ENOMEM
> > >     ...
> > >     if (!error)  ->will not update i_size
> > >       i_size_write(inode, attr->ia_size);
> > > Now:
> > > inode.i_size=4096
> > > EXT4_I(inode)->i_disksize=8192
> > > 
> > > step 2: Direct write 4096 bytes
> > > ext4_file_write_iter
> > >   ext4_dio_write_iter
> > >     iomap_dio_rw ->return error
> > >   if (extend)
> > >     ext4_handle_inode_extension
> > >       WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> > > ->Then trigger warning.
> > > 
> > > To solve above issue, if mark inode dirty failed in ext4_setattr just
> > > set 'EXT4_I(inode)->i_disksize' with old value.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > Thanks for the fix! So I think this deserves a further debate. I have two
> > points here:
> > 
> > 1) If ext4_mark_inode_dirty() fails (or basically any metadata writeback)
> > we must abort the journal because metadata is not guaranteed to be
> > consistent anymore. In this particular callsite of ext4_mark_inode_dirty()
> > you were able to undo the changes but there are many more where it is not
> > sanely possible AFAICT. Hence I think that ext4_reserve_inode_write() needs
> > to call ext4_journal_abort_handle() (as already happens inside
> > __ext4_journal_get_write_access()) and not just ext4_std_error().
> > 
> > 2) The assertion in ext4_handle_inode_extension() should be conditioned on
> > !is_journal_aborted() to avoid useless warnings for filesystems we know are
> > inconsistent anyway.
> > 
> > Thoughts?
> > 
> > 								Honza
> Do you mean call jbd2_abort in ext4_reserve_inode_write() ?

Yes.

> If we abort journal when metadata is not guaranteed to be consistent. The
> mode of ‘errors=continue’ is unnecessary.

Well, firstly, errors=continue was always the best effort. There are no
guarantees which failures we are able to withstand and which not.
Generally, I think we try to withstand on-disk filesystem inconsistency but
not inconsistency coming from programming errors or other external factors
like out-of-memory conditions. Secondly, we already do abort the journal
when e.g. jbd2_journal_get_write_access() fails (although that generally
means some internal inconsistency) or when say revoke handling fails to
allocate memory for a revoke record. So it won't be a new thing. Thirdly,
and perhaps most importantly, you have found and fixed just one fairly
innocent problem happening due to in memory inode state getting
inconsistent after we fail to record the inode in the journal. There are
almost 80 callsites of ext4_mark_inode_dirty() and honestly I suspect that
e.g. inconsistent states resulting from extent tree manipulations being
aborted in the middle due to ext4_ext_dirty() failing due to ENOMEM will
also trigger all sorts of "interesting" behavior. So that's why I'd rather
abort the journal than try to continue when we almost certainly now we
cannot.

One other possibility I could see dealing with this class of problems is
using __GFP_NOFAIL for inode buffer head allocation (through
sb_getblk_gfp()) in __ext4_get_inode_loc(). BTW, how did you trigger NULL
sb_getblk() return in the first place? AFAICS grow_buffers() already uses
__GFP_NOFAIL for all the allocations?

								Honza

> > > ---
> > >   fs/ext4/inode.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 90fd6f7b6209..8adf1f802f6c 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -5384,6 +5384,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >   	if (attr->ia_valid & ATTR_SIZE) {
> > >   		handle_t *handle;
> > >   		loff_t oldsize = inode->i_size;
> > > +		loff_t old_disksize;
> > >   		int shrink = (attr->ia_size < inode->i_size);
> > >   		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> > > @@ -5455,6 +5456,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >   					inode->i_sb->s_blocksize_bits);
> > >   			down_write(&EXT4_I(inode)->i_data_sem);
> > > +			old_disksize = EXT4_I(inode)->i_disksize;
> > >   			EXT4_I(inode)->i_disksize = attr->ia_size;
> > >   			rc = ext4_mark_inode_dirty(handle, inode);
> > >   			if (!error)
> > > @@ -5466,6 +5468,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >   			 */
> > >   			if (!error)
> > >   				i_size_write(inode, attr->ia_size);
> > > +			else
> > > +				EXT4_I(inode)->i_disksize = old_disksize;
> > >   			up_write(&EXT4_I(inode)->i_data_sem);
> > >   			ext4_journal_stop(handle);
> > >   			if (error)
> > > -- 
> > > 2.31.1
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

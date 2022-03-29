Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57B4EAA8D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 11:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiC2JaA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiC2J37 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 05:29:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE2DC;
        Tue, 29 Mar 2022 02:28:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02A422160D;
        Tue, 29 Mar 2022 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648546091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gcAXLMphzl1CPYqehPOROiukraRE9gLdD48BV30bXSI=;
        b=qXtcfPPJc147YlQJgqs2bH30nF8MIis7yW7d67R9b8cqh+wXLW2LukNhFwtL0S1so77dY/
        NQ5ygzIbUEfB3ISFZfqpmAlztaJw1D050FS9RekDihoy3m9Xx8yV4FuGB3iYQ/eOZWGNhv
        /dkEdpSLucV+szUTy2tLy6Zrv93aFCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648546091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gcAXLMphzl1CPYqehPOROiukraRE9gLdD48BV30bXSI=;
        b=MmnIb/BQOGV9UJ2BptXFXe39byyr4K7E0ut2KCf5aeRpM7UXAZSmVNJYeI6YLQDvbUT3cj
        tjw6QL0FF9BogLDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D4D89A3B93;
        Tue, 29 Mar 2022 09:28:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 743A8A0610; Tue, 29 Mar 2022 11:28:10 +0200 (CEST)
Date:   Tue, 29 Mar 2022 11:28:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix warning in ext4_handle_inode_extension
Message-ID: <20220329092810.j5ngxckygut6mxo2@quack3.lan>
References: <20220326065351.761952-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326065351.761952-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 26-03-22 14:53:51, Ye Bin wrote:
> We got issue as follows:
> EXT4-fs error (device loop0) in ext4_reserve_inode_write:5741: Out of memory
> EXT4-fs error (device loop0): ext4_setattr:5462: inode #13: comm syz-executor.0: mark_inode_dirty error
> EXT4-fs error (device loop0) in ext4_setattr:5519: Out of memory
> EXT4-fs error (device loop0): ext4_ind_map_blocks:595: inode #13: comm syz-executor.0: Can't allocate blocks for non-extent mapped inodes with bigalloc
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 4361 at fs/ext4/file.c:301 ext4_file_write_iter+0x11c9/0x1220
> Modules linked in:
> CPU: 1 PID: 4361 Comm: syz-executor.0 Not tainted 5.10.0+ #1
> RIP: 0010:ext4_file_write_iter+0x11c9/0x1220
> RSP: 0018:ffff924d80b27c00 EFLAGS: 00010282
> RAX: ffffffff815a3379 RBX: 0000000000000000 RCX: 000000003b000000
> RDX: ffff924d81601000 RSI: 00000000000009cc RDI: 00000000000009cd
> RBP: 000000000000000d R08: ffffffffbc5a2c6b R09: 0000902e0e52a96f
> R10: ffff902e2b7c1b40 R11: ffff902e2b7c1b40 R12: 000000000000000a
> R13: 0000000000000001 R14: ffff902e0e52aa10 R15: ffffffffffffff8b
> FS:  00007f81a7f65700(0000) GS:ffff902e3bc80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 000000012db88001 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  do_iter_readv_writev+0x2e5/0x360
>  do_iter_write+0x112/0x4c0
>  do_pwritev+0x1e5/0x390
>  __x64_sys_pwritev2+0x7e/0xa0
>  do_syscall_64+0x37/0x50
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Above issue may happen as follows:
> Assume
> inode.i_size=4096
> EXT4_I(inode)->i_disksize=4096
> 
> step 1: set inode->i_isize = 8192
> ext4_setattr
>   if (attr->ia_size != inode->i_size)
>     EXT4_I(inode)->i_disksize = attr->ia_size;
>     rc = ext4_mark_inode_dirty
>        ext4_reserve_inode_write
>           ext4_get_inode_loc
>             __ext4_get_inode_loc
>               sb_getblk --> return -ENOMEM
>    ...
>    if (!error)  ->will not update i_size
>      i_size_write(inode, attr->ia_size);
> Now:
> inode.i_size=4096
> EXT4_I(inode)->i_disksize=8192
> 
> step 2: Direct write 4096 bytes
> ext4_file_write_iter
>  ext4_dio_write_iter
>    iomap_dio_rw ->return error
>  if (extend)
>    ext4_handle_inode_extension
>      WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> ->Then trigger warning.
> 
> To solve above issue, if mark inode dirty failed in ext4_setattr just
> set 'EXT4_I(inode)->i_disksize' with old value.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the fix! So I think this deserves a further debate. I have two
points here:

1) If ext4_mark_inode_dirty() fails (or basically any metadata writeback)
we must abort the journal because metadata is not guaranteed to be
consistent anymore. In this particular callsite of ext4_mark_inode_dirty()
you were able to undo the changes but there are many more where it is not
sanely possible AFAICT. Hence I think that ext4_reserve_inode_write() needs
to call ext4_journal_abort_handle() (as already happens inside
__ext4_journal_get_write_access()) and not just ext4_std_error().

2) The assertion in ext4_handle_inode_extension() should be conditioned on
!is_journal_aborted() to avoid useless warnings for filesystems we know are
inconsistent anyway.

Thoughts?

								Honza

> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 90fd6f7b6209..8adf1f802f6c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5384,6 +5384,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	if (attr->ia_valid & ATTR_SIZE) {
>  		handle_t *handle;
>  		loff_t oldsize = inode->i_size;
> +		loff_t old_disksize;
>  		int shrink = (attr->ia_size < inode->i_size);
>  
>  		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> @@ -5455,6 +5456,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  					inode->i_sb->s_blocksize_bits);
>  
>  			down_write(&EXT4_I(inode)->i_data_sem);
> +			old_disksize = EXT4_I(inode)->i_disksize;
>  			EXT4_I(inode)->i_disksize = attr->ia_size;
>  			rc = ext4_mark_inode_dirty(handle, inode);
>  			if (!error)
> @@ -5466,6 +5468,8 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  			 */
>  			if (!error)
>  				i_size_write(inode, attr->ia_size);
> +			else
> +				EXT4_I(inode)->i_disksize = old_disksize;
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			ext4_journal_stop(handle);
>  			if (error)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

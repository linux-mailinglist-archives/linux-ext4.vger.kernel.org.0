Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1034E9BBC
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbiC1P73 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiC1P73 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 11:59:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A254D252;
        Mon, 28 Mar 2022 08:57:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6D6601F439B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648483066;
        bh=0zTlHalK8WQ4nkNCoPhf3HnjHpLJno7/Ik/0DQfe1kc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GVVbaLDCRtZ+wwTrVYkEGVcJdhV7w3qg4LrWZqWWEiKoayCu0VptSV5RUm2IKYayZ
         YW/9wz6eUwkN8sVeRqVZKCv6j0ekqzqDdeLrDNe6AvBRsuZI+uqXliB8q/NBtVVpN6
         OIulsVX1FkXwCvaEObrN6BtSYASjVYH1959RhTuBFfDp/7hcVTENC4iZHaO9o5bDd0
         VZVJ5c5PlJeqF6a44u2ohltqb8YECfPEa118q+QgLjanH/QR+FGbTLwEuJMqjanHYg
         bs8Zy5NmoFP9+ov9lK1DDS3Uvqw9mn9GA39MXmOY2T394XGgRF72TEAaJAUDwkNBfy
         NhU3mCvaMfsmw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jack@suse.cz>, <lczerner@redhat.com>
Subject: Re: [PATCH -next] ext4: fix warning in ext4_handle_inode_extension
Organization: Collabora
References: <20220326065351.761952-1-yebin10@huawei.com>
Date:   Mon, 28 Mar 2022 11:57:43 -0400
In-Reply-To: <20220326065351.761952-1-yebin10@huawei.com> (Ye Bin's message of
        "Sat, 26 Mar 2022 14:53:51 +0800")
Message-ID: <87sfr2qdc8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ye Bin <yebin10@huawei.com> writes:

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

Shouldn't this always be done if ext4_mark_inode_dirty fails?

if (rc)
    EXT4_I(inode)->i_disksize = old_disksize;

Otherwise you hit the same issue if (!error && rc), no?

-- 
Gabriel Krisman Bertazi

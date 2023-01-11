Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2739665832
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAKJyb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 04:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjAKJxt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 04:53:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B51DF5F;
        Wed, 11 Jan 2023 01:51:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58EA217251;
        Wed, 11 Jan 2023 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673430693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxKrOZKg5AWkpvnvIun7uEPCdM62iKUrBCz5azUCQhE=;
        b=uqaSBCAPrsIbWcJWHc2Yw/zIQBfD7iJ/wSEC35+hZngb/EEMx9OjLv08A3qhTs8OSwafVa
        BPNIp3d1RahO/KQYkQ/6Ej8tn/J1NwwoZt4bv3dMB8gdVJbsj/j6LeZNgzfwfnPGp41Cnz
        V9/9LGzIVV6tM61jJPwp7apWrIB+Q5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673430693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxKrOZKg5AWkpvnvIun7uEPCdM62iKUrBCz5azUCQhE=;
        b=HsAuS8TAX+Zj+8Xvi5pLYgh44wnUDfakuQJRbiRlH0Nwnb2lall5bJXl32gs630H16ko3W
        H7fyfMZQbnubRlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45F6A1358A;
        Wed, 11 Jan 2023 09:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U1cGEaWGvmNLcQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 09:51:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 93E9EA0744; Wed, 11 Jan 2023 10:51:32 +0100 (CET)
Date:   Wed, 11 Jan 2023 10:51:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com,
        syzbot+77d6fcc37bbb92f26048@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix task hung in ext4_xattr_delete_inode
Message-ID: <20230111095132.5r4cb3k4lnzjdiyz@quack3>
References: <20230110133436.996350-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110133436.996350-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-01-23 21:34:36, Baokun Li wrote:
> Syzbot reported a hung task problem:
> ==================================================================
> INFO: task syz-executor232:5073 blocked for more than 143 seconds.
>       Not tainted 6.2.0-rc2-syzkaller-00024-g512dee0c00ad #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-exec232 state:D stack:21024 pid:5073 ppid:5072 flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5244 [inline]
>  __schedule+0x995/0xe20 kernel/sched/core.c:6555
>  schedule+0xcb/0x190 kernel/sched/core.c:6631
>  __wait_on_freeing_inode fs/inode.c:2196 [inline]
>  find_inode_fast+0x35a/0x4c0 fs/inode.c:950
>  iget_locked+0xb1/0x830 fs/inode.c:1273
>  __ext4_iget+0x22e/0x3ed0 fs/ext4/inode.c:4861
>  ext4_xattr_inode_iget+0x68/0x4e0 fs/ext4/xattr.c:389
>  ext4_xattr_inode_dec_ref_all+0x1a7/0xe50 fs/ext4/xattr.c:1148
>  ext4_xattr_delete_inode+0xb04/0xcd0 fs/ext4/xattr.c:2880
>  ext4_evict_inode+0xd7c/0x10b0 fs/ext4/inode.c:296
>  evict+0x2a4/0x620 fs/inode.c:664
>  ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5516 [inline]
>  ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
>  get_tree_bdev+0x400/0x620 fs/super.c:1282
>  vfs_get_tree+0x88/0x270 fs/super.c:1489
>  do_new_mount+0x289/0xad0 fs/namespace.c:3145
>  do_mount fs/namespace.c:3488 [inline]
>  __do_sys_mount fs/namespace.c:3697 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fa5406fd5ea
> RSP: 002b:00007ffc7232f968 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa5406fd5ea
> RDX: 0000000020000440 RSI: 0000000020000000 RDI: 00007ffc7232f970
> RBP: 00007ffc7232f970 R08: 00007ffc7232f9b0 R09: 0000000000000432
> R10: 0000000000804a03 R11: 0000000000000202 R12: 0000000000000004
> R13: 0000555556a7a2c0 R14: 00007ffc7232f9b0 R15: 0000000000000000
>  </TASK>
> ==================================================================
> 
> The problem is that the inode contains an xattr entry with ea_inum of 15
> when cleaning up an orphan inode <15>. When evict inode <15>, the reference
> counting of the corresponding EA inode is decreased. When EA inode <15> is
> found by find_inode_fast() in __ext4_iget(), it is found that the EA inode
> holds the I_FREEING flag and waits for the EA inode to complete deletion.
> As a result, when inode <15> is being deleted, we wait for inode <15> to
> complete the deletion, resulting in an infinite loop and triggering Hung
> Task. To solve this problem, we only need to check whether the ino of EA
> inode and parent is the same before getting EA inode.
> 
> Link: https://syzkaller.appspot.com/bug?extid=77d6fcc37bbb92f26048
> Reported-by: syzbot+77d6fcc37bbb92f26048@syzkaller.appspotmail.com
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	Avoid using uninitialized variable and add comment.
> 
>  fs/ext4/xattr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7decaaf27e82..9e6a5c50276e 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -386,6 +386,17 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
>  	struct inode *inode;
>  	int err;
>  
> +	/*
> +	 * We have to check for this corruption early as otherwise
> +	 * iget_locked() could wait indefinitely for the state of our
> +	 * parent inode.
> +	 */
> +	if (parent->i_ino == ea_ino) {
> +		ext4_error(parent->i_sb,
> +			   "Parent and EA inode have the same ino %lu", ea_ino);
> +		return -EFSCORRUPTED;
> +	}
> +
>  	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_NORMAL);
>  	if (IS_ERR(inode)) {
>  		err = PTR_ERR(inode);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

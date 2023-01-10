Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3BC663F47
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 12:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjAJLeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Jan 2023 06:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjAJLeL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Jan 2023 06:34:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785BE50149;
        Tue, 10 Jan 2023 03:34:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1092835199;
        Tue, 10 Jan 2023 11:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673350448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/8j2Bqm4fHcffCv+PGYLKgIkmNVWQOJFGIRigh4oLY=;
        b=iJQYKQ3yOF2N2N10aYdaGJwMr1jdlxBidYivCmWSoeF+zPbwG8YXb3bXUa8iN7jtL18Nyf
        MneHu4wZ2nqINtSz2mR+BIxJAFEG4xY5mfOD7CVBgTwoGYi7lOpPj9yAaE9U+EGz8Kp9/G
        Exz5ycnHvVbBGB3VLAafSJrQMKR022w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673350448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P/8j2Bqm4fHcffCv+PGYLKgIkmNVWQOJFGIRigh4oLY=;
        b=rJvqff2cF4KwU1tutmX11Tdy+nEZbHj7dRTAaBTjrOJLhVmgzHdui07zwQXFGydzde419q
        pQXkNIIs+8Ri9aAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 036F413338;
        Tue, 10 Jan 2023 11:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oiLOADBNvWO+ewAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 10 Jan 2023 11:34:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 90DCCA0744; Tue, 10 Jan 2023 12:34:07 +0100 (CET)
Date:   Tue, 10 Jan 2023 12:34:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com,
        syzbot+77d6fcc37bbb92f26048@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix task hung in ext4_xattr_delete_inode
Message-ID: <20230110113407.ymamyqmg2rw6zfzu@quack3>
References: <20230110042709.2136336-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110042709.2136336-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-01-23 12:27:09, Baokun Li wrote:
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
> ---
>  fs/ext4/xattr.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7decaaf27e82..9ff8fcf78bb8 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -386,6 +386,13 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
>  	struct inode *inode;
>  	int err;
>  

Perhaps add a comment here like:

	/*
	 * We have to check for this corruption early as otherwise
	 * iget_locked() could wait indefinitely for the state of our
	 * parent inode.
	 */

> +	if (parent->i_ino == ea_ino) {
> +		ext4_error(parent->i_sb,
> +			   "Parent and EA inode have the same ino %lu", ea_ino);
> +		err = -EUCLEAN;
			^^ I prefer -EFSCORRUPTED here. It is the same
value but more descriptive name :).

> +		goto error;
		^^ Just "return err" here. This will try to iput()
uninitialized pointer.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

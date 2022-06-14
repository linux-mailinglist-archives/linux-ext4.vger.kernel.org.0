Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44A54ADCB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jun 2022 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiFNJye (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiFNJyd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 05:54:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E772E0B3;
        Tue, 14 Jun 2022 02:54:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9AAC41F8F1;
        Tue, 14 Jun 2022 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655200470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXJlNicdTHDqjkWrqjs9aazyAwSjEHqlsCBY8HfQXs0=;
        b=eponUetfvdxojoyT66HJb3cQ+/0hmhmHtjqcCLeHskds3HZNRGiyRckJ1K+FFILaQajV7I
        Q4LMdjsBvcKefcWSStVhneJZ8FgudvsG5BAoeXi+wsJOranyv5GNh9c9u9ix639OjHrKLg
        LbmwqCxn51cFyRsef5G3dIOYYFipslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655200470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXJlNicdTHDqjkWrqjs9aazyAwSjEHqlsCBY8HfQXs0=;
        b=zdHhQVl0mYmgTwR+K4W1hm5YmtsWhY50ytNASXmCfLiVhMxuzuoZ0s2bmZjyknnmYnOOLq
        pLVObE7ziWgSQcCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 805CC2C141;
        Tue, 14 Jun 2022 09:54:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB7FDA062E; Tue, 14 Jun 2022 11:54:24 +0200 (CEST)
Date:   Tue, 14 Jun 2022 11:54:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ext4: fix use-after-free in ext4_xattr_set_entry
Message-ID: <20220614095424.djuxzoy5zcoc64y2@quack3.lan>
References: <20220602114651.3244889-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602114651.3244889-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 02-06-22 19:46:51, Baokun Li wrote:
> Hulk Robot reported a issue:
> ==================================================================
> BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x18ab/0x3500
> Write of size 4105 at addr ffff8881675ef5f4 by task syz-executor.0/7092
> 
> CPU: 1 PID: 7092 Comm: syz-executor.0 Not tainted 4.19.90-dirty #17
> Call Trace:
> [...]
>  memcpy+0x34/0x50 mm/kasan/kasan.c:303
>  ext4_xattr_set_entry+0x18ab/0x3500 fs/ext4/xattr.c:1747
>  ext4_xattr_ibody_inline_set+0x86/0x2a0 fs/ext4/xattr.c:2205
>  ext4_xattr_set_handle+0x940/0x1300 fs/ext4/xattr.c:2386
>  ext4_xattr_set+0x1da/0x300 fs/ext4/xattr.c:2498
>  __vfs_setxattr+0x112/0x170 fs/xattr.c:149
>  __vfs_setxattr_noperm+0x11b/0x2a0 fs/xattr.c:180
>  __vfs_setxattr_locked+0x17b/0x250 fs/xattr.c:238
>  vfs_setxattr+0xed/0x270 fs/xattr.c:255
>  setxattr+0x235/0x330 fs/xattr.c:520
>  path_setxattr+0x176/0x190 fs/xattr.c:539
>  __do_sys_lsetxattr fs/xattr.c:561 [inline]
>  __se_sys_lsetxattr fs/xattr.c:557 [inline]
>  __x64_sys_lsetxattr+0xc2/0x160 fs/xattr.c:557
>  do_syscall_64+0xdf/0x530 arch/x86/entry/common.c:298
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x459fe9
> RSP: 002b:00007fa5e54b4c08 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
> RAX: ffffffffffffffda RBX: 000000000051bf60 RCX: 0000000000459fe9
> RDX: 00000000200003c0 RSI: 0000000020000180 RDI: 0000000020000140
> RBP: 000000000051bf60 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000001009 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc73c93fc0 R14: 000000000051bf60 R15: 00007fa5e54b4d80
> [...]
> ==================================================================
> 
> Above issue may happen as follows:
> -------------------------------------
> ext4_xattr_set
>   ext4_xattr_set_handle
>     ext4_xattr_ibody_find
>       >> s->end < s->base
>       >> no EXT4_STATE_XATTR
>       >> xattr_check_inode is not executed
>     ext4_xattr_ibody_set
>       ext4_xattr_set_entry
>        >> size_t min_offs = s->end - s->base
>        >> UAF in memcpy
> 
> we can easily reproduce this problem with the following commands:
>     mkfs.ext4 -F /dev/sda
>     mount -o debug_want_extra_isize=128 /dev/sda /mnt
>     touch /mnt/file
>     setfattr -n user.cat -v `seq -s z 4096|tr -d '[:digit:]'` /mnt/file
> 
> In ext4_xattr_ibody_find, we have the following assignment logic:
>   header = IHDR(inode, raw_inode)
>          = raw_inode + EXT4_GOOD_OLD_INODE_SIZE + i_extra_isize
>   is->s.base = IFIRST(header)
>              = header + sizeof(struct ext4_xattr_ibody_header)
>   is->s.end = raw_inode + s_inode_size
> 
> Obviously, when the inode does not have EXT4_status_XATTR and its
> i_extra_isize is large, is->s.end may be larger than is->s.base.
> In this case, the above issue may be triggered.
> 
>    EXT4_GOOD_OLD_INODE_SIZE  extra_isize  header   entry   pad   data
> |---------------------------|------------|------|---------|---|--------|
> 
> As shown above, when adding an xattr to an inode, we must ensure that the
> inode_size is not less than EXT4_GOOD_OLD_INODE_SIZE + extra_isize + pad.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for the fix! It looks good to me. Just one small nit:

> +#define INODE_HAVE_XATTR_SPACE(inode)					\
> +	((EXT4_I(inode)->i_extra_isize != 0) &&				\
> +	 (EXT4_GOOD_OLD_INODE_SIZE + EXT4_I(inode)->i_extra_isize +	\
> +	  sizeof(struct ext4_xattr_ibody_header) + EXT4_XATTR_PAD <=	\
> +	  EXT4_INODE_SIZE((inode)->i_sb)))
> +

We should have ext4 in the name of the above macro so something like:

EXT4_INODE_HAS_XATTR_SPACE()

With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E358861F478
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKGNhJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 08:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKGNgy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 08:36:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DD1B7A9;
        Mon,  7 Nov 2022 05:36:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 879792242A;
        Mon,  7 Nov 2022 13:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667828211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=raGJW7jQAEFZWQL2P9hVCzPvkr9DVzerde0b9hfQjIw=;
        b=RC9lkDnijSfPpwGQUIoG5tQKNx5Gp/WlUzZRNjsSeJI58wRVtj4aXaCusHxlLNGQNfPB40
        JjIJL/s6FQOrqLKZaGtqVpoQ/OlmJVTr6NwCtpTMaW6734hhTkF8Nx+MbArFPFfLSnu22g
        iGpU/aineidYBs4GKTmpGZMPsBD+ggA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667828211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=raGJW7jQAEFZWQL2P9hVCzPvkr9DVzerde0b9hfQjIw=;
        b=2firwJlk06VWiXu7xU1GJGxOrJWwi3ju8w6e+Squ9MDKZEHbcDusl1yRkO14xKf/0LH9K2
        U9IzFanBIQAlzFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7800E13494;
        Mon,  7 Nov 2022 13:36:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oh5CHfMJaWO6XwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 13:36:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0CD25A0704; Mon,  7 Nov 2022 14:36:51 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:36:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+98346927678ac3059c77@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: init quota for 'old.inode' in 'ext4_rename'
Message-ID: <20221107133651.qmitthhev3lq4h5q@quack3>
References: <20221107015335.2524319-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107015335.2524319-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 07-11-22 09:53:35, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> ext4_parse_param: s_want_extra_isize=128
> ext4_inode_info_init: s_want_extra_isize=32
> ext4_rename: old.inode=ffff88823869a2c8 old.dir=ffff888238699828 new.inode=ffff88823869d7e8 new.dir=ffff888238699828
> __ext4_mark_inode_dirty: inode=ffff888238699828 ea_isize=32 want_ea_size=128
> __ext4_mark_inode_dirty: inode=ffff88823869a2c8 ea_isize=32 want_ea_size=128
> ext4_xattr_block_set: inode=ffff88823869a2c8
> ------------[ cut here ]------------
> WARNING: CPU: 13 PID: 2234 at fs/ext4/xattr.c:2070 ext4_xattr_block_set.cold+0x22/0x980
> Modules linked in:
> RIP: 0010:ext4_xattr_block_set.cold+0x22/0x980
> RSP: 0018:ffff888227d3f3b0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff88823007a000 RCX: 0000000000000000
> RDX: 0000000000000a03 RSI: 0000000000000040 RDI: ffff888230078178
> RBP: 0000000000000000 R08: 000000000000002c R09: ffffed1075c7df8e
> R10: ffff8883ae3efc6b R11: ffffed1075c7df8d R12: 0000000000000000
> R13: ffff88823869a2c8 R14: ffff8881012e0460 R15: dffffc0000000000
> FS:  00007f350ac1f740(0000) GS:ffff8883ae200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f350a6ed6a0 CR3: 0000000237456000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? ext4_xattr_set_entry+0x3b7/0x2320
>  ? ext4_xattr_block_set+0x0/0x2020
>  ? ext4_xattr_set_entry+0x0/0x2320
>  ? ext4_xattr_check_entries+0x77/0x310
>  ? ext4_xattr_ibody_set+0x23b/0x340
>  ext4_xattr_move_to_block+0x594/0x720
>  ext4_expand_extra_isize_ea+0x59a/0x10f0
>  __ext4_expand_extra_isize+0x278/0x3f0
>  __ext4_mark_inode_dirty.cold+0x347/0x410
>  ext4_rename+0xed3/0x174f
>  vfs_rename+0x13a7/0x2510
>  do_renameat2+0x55d/0x920
>  __x64_sys_rename+0x7d/0xb0
>  do_syscall_64+0x3b/0xa0
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> As 'ext4_rename' will modify 'old.inode' ctime and mark inode dirty, which may
> trigger expand 'extra_isize' and allocate block. If inode didn't init quota
> will lead to warning.
> To solve above issue, init 'old.inode' firstly in 'ext4_rename'.
> 
> Reported-by: syzbot+98346927678ac3059c77@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>

OK, nice catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index b8a91d74fdd1..6e40dfc8bd30 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3784,6 +3784,9 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		return -EXDEV;
>  
>  	retval = dquot_initialize(old.dir);
> +	if (retval)
> +		return retval;
> +	retval = dquot_initialize(old.inode);
>  	if (retval)
>  		return retval;
>  	retval = dquot_initialize(new.dir);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

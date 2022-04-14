Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A0050099F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Apr 2022 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiDNJYg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 05:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbiDNJYg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 05:24:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B06D969;
        Thu, 14 Apr 2022 02:22:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2791C21618;
        Thu, 14 Apr 2022 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649928130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1D0VEhOpVvUmapzR3MOMggwweTNTJqKNVFz59K58euw=;
        b=Fc5126Ix3T8l7GhJ495UyQ46krwecnUqZ2gqPLTw6f7uk+933AEdhUBvTRN5DrSORyhl6d
        NNW2+NeTOHDio6DwIXpZSUdZq+/po8m2umLkwn5Ow/aYg0E0D14NDfjYVhvrQ4x/TfCpbD
        4sVfOUOONiurkdlZQ7g9x9dYAIRBG6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649928130;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1D0VEhOpVvUmapzR3MOMggwweTNTJqKNVFz59K58euw=;
        b=cHV902LwJcurrTx8Awd5+FcD/np+OCj1UNRnG54ofTi5Kqii3XZblc/tjMSKzZTi9wCk0E
        i9yMNiAzOppJ4UDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA67BA3B88;
        Thu, 14 Apr 2022 09:22:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4B353A061E; Thu, 14 Apr 2022 11:22:09 +0200 (CEST)
Date:   Thu, 14 Apr 2022 11:22:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix use-after-free in ext4_rename_dir_prepare
Message-ID: <20220414092209.adqzw4grph3fkjdr@quack3>
References: <20220414025223.4113128-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414025223.4113128-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 14-04-22 10:52:23, Ye Bin wrote:
> We got issue as follows:
> EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
> ext4_get_first_dir_block: bh->b_data=0xffff88810bee6000 len=34478
> ext4_get_first_dir_block: *parent_de=0xffff88810beee6ae bh->b_data=0xffff88810bee6000
> ext4_rename_dir_prepare: [1] parent_de=0xffff88810beee6ae
> ==================================================================
> BUG: KASAN: use-after-free in ext4_rename_dir_prepare+0x152/0x220
> Read of size 4 at addr ffff88810beee6ae by task rep/1895
> 
> CPU: 13 PID: 1895 Comm: rep Not tainted 5.10.0+ #241
> Call Trace:
>  dump_stack+0xbe/0xf9
>  print_address_description.constprop.0+0x1e/0x220
>  kasan_report.cold+0x37/0x7f
>  ext4_rename_dir_prepare+0x152/0x220
>  ext4_rename+0xf44/0x1ad0
>  ext4_rename2+0x11c/0x170
>  vfs_rename+0xa84/0x1440
>  do_renameat2+0x683/0x8f0
>  __x64_sys_renameat+0x53/0x60
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f45a6fc41c9
> RSP: 002b:00007ffc5a470218 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f45a6fc41c9
> RDX: 0000000000000005 RSI: 0000000020000180 RDI: 0000000000000005
> RBP: 00007ffc5a470240 R08: 00007ffc5a470160 R09: 0000000020000080
> R10: 00000000200001c0 R11: 0000000000000246 R12: 0000000000400bb0
> R13: 00007ffc5a470320 R14: 0000000000000000 R15: 0000000000000000
> 
> The buggy address belongs to the page:
> page:00000000440015ce refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x10beee
> flags: 0x200000000000000()
> raw: 0200000000000000 ffffea00043ff4c8 ffffea0004325608 0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88810beee580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88810beee600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff88810beee680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                   ^
>  ffff88810beee700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88810beee780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> Disabling lock debugging due to kernel taint
> ext4_rename_dir_prepare: [2] parent_de->inode=3537895424
> ext4_rename_dir_prepare: [3] dir=0xffff888124170140
> ext4_rename_dir_prepare: [4] ino=2
> ext4_rename_dir_prepare: ent->dir->i_ino=2 parent=-757071872
> 
> Reason is first directory entry which 'rec_len' is 34478, then will get illegal
> parent entry. Now, we do not check directory entry after read directory block
> in 'ext4_get_first_dir_block'.
> To solve this issue, check directory entry in 'ext4_get_first_dir_block'.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index e37da8d5cd0c..2f78544b1d47 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3455,6 +3455,9 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
>  	struct buffer_head *bh;
>  
>  	if (!ext4_has_inline_data(inode)) {
> +		struct ext4_dir_entry_2 *de;
> +		unsigned int offset;
> +
>  		/* The first directory block must not be a hole, so
>  		 * treat it as DIRENT_HTREE
>  		 */
> @@ -3463,9 +3466,28 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
>  			*retval = PTR_ERR(bh);
>  			return NULL;
>  		}
> -		*parent_de = ext4_next_entry(
> -					(struct ext4_dir_entry_2 *)bh->b_data,
> -					inode->i_sb->s_blocksize);
> +
> +		de = (struct ext4_dir_entry_2 *) bh->b_data;
> +		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
> +					 bh->b_size, 0) ||
> +		    le32_to_cpu(de->inode) != inode->i_ino ||
> +		    strcmp(".", de->name)) {
> +			ext4_warning_inode(inode, "directory missing '.'");
> +			brelse(bh);
> +			return NULL;
> +		}
> +		offset = ext4_rec_len_from_disk(de->rec_len,
> +						inode->i_sb->s_blocksize);
> +		de = ext4_next_entry(de, inode->i_sb->s_blocksize);
> +		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
> +					 bh->b_size, offset) ||
> +		    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
> +			ext4_warning_inode(inode, "directory missing '..'");
> +			brelse(bh);
> +			return NULL;
> +		}
> +		*parent_de = de;
> +
>  		return bh;
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8EA77B8EC
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Aug 2023 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjHNMqr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHNMqR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 08:46:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73DCE4A;
        Mon, 14 Aug 2023 05:46:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EAE61F383;
        Mon, 14 Aug 2023 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692017171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRY7FiTpY9Cue4skb3l34/FQK1oykqmUfalP+nz3Sgg=;
        b=d6PQ1N92IRdI5EFCjc/i3CyccT8DRcbzvl7fww3kV9k1ZHX8qY3ejBF7Zqsgg/OpUCC38D
        VnGntMREzzCjlN3FTi+xuaF7lp5WFy8vyI6dsswX+xprJfg2gn4IpFp5Oo/9WOpfonO9F9
        lw7xvlpamxVDHAMTGFmIn112it4KAu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692017171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRY7FiTpY9Cue4skb3l34/FQK1oykqmUfalP+nz3Sgg=;
        b=RmINAFQBHWNNxojK0dBad3MvF5EviuSGGsZtwPmi7cxRNIKDoHOQTCKOa4uI7E4ejlu8hj
        VfbNbVu/2z3RJiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 523B9138EE;
        Mon, 14 Aug 2023 12:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jBUOFBMi2mSmSAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 12:46:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DA278A0769; Mon, 14 Aug 2023 14:46:10 +0200 (CEST)
Date:   Mon, 14 Aug 2023 14:46:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2: fix race between setxattr and write back
Message-ID: <20230814124610.uyzbvktfwzjwypee@quack3>
References: <20230811033857.1800578-1-yebin10@huawei.com>
 <20230811033857.1800578-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811033857.1800578-2-yebin10@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 11-08-23 11:38:56, Ye Bin wrote:
> There's a issue as follows:
> Block Allocation Reservation Windows Map (ext2_try_to_allocate_with_rsv):
> reservation window 0x000000006f105382 start: 0, end: 0
> reservation window 0x000000008fd1a555 start: 1044, end: 1059
> Window map complete.
> kernel BUG at fs/ext2/balloc.c:1158!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> RIP: 0010:ext2_try_to_allocate_with_rsv.isra.0+0x15c4/0x1800
> Call Trace:
>  <TASK>
>  ext2_new_blocks+0x935/0x1690
>  ext2_new_block+0x73/0xa0
>  ext2_xattr_set2+0x74f/0x1730
>  ext2_xattr_set+0x12b6/0x2260
>  ext2_xattr_user_set+0x9c/0x110
>  __vfs_setxattr+0x139/0x1d0
>  __vfs_setxattr_noperm+0xfc/0x370
>  __vfs_setxattr_locked+0x205/0x2c0
>  vfs_setxattr+0x19d/0x3b0
>  do_setxattr+0xff/0x220
>  setxattr+0x123/0x150
>  path_setxattr+0x193/0x1e0
>  __x64_sys_setxattr+0xc8/0x170
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Above issue may happens as follows:
>         setxattr                             write back
> ext2_xattr_set
>   ext2_xattr_set2
>     ext2_new_block
>       ext2_new_blocks
>         ext2_try_to_allocate_with_rsv
> 	  alloc_new_reservation
> 	  --> group=0 [0, 1023] rsv [1016, 1023]
> 	                                do_writepages
> 					  mpage_writepages
> 					    write_cache_pages
> 					      __mpage_writepage
> 					        ext2_get_block
> 						  ext2_get_blocks
> 						   ext2_alloc_branch
> 						    ext2_new_blocks
> 						     ext2_try_to_allocate_with_rsv
> 						       alloc_new_reservation
> 		                     -->group=1 [1024, 2047] rsv [1044, 1059]
> 	  if ((my_rsv->rsv_start > group_last_block) ||
> 	      (my_rsv->rsv_end < group_first_block)
> 	      rsv_window_dump
> 	      BUG();
> Now ext2 mkwrite delay allocate new blocks. So there maybe allocate blocks when
> do write back. However, there is no concurrent protection between
> ext2_xattr_set() and do_writepages().
> To solve about issue hold '&ei->truncate_mutex' lock when new block for xattr.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch! I agree the handling of reservation window and its
use for block allocation needs to be protected by ei->i_truncate_mutex.
However in this particular case of xattr allocation where we want to
allocate just one block which is completely independent of file data, I'd
rather choose to make ext2_new_blocks() ignore the reservation window (set
my_rsv to NULL). There's already a logic at the beginning of
ext2_new_blocks() deciding whether to use the reservation window or not and
we could extend it - probably by adding flags argument to it a introducing
a NORESERVE flag.

Also as a preparatory patch, I'd just remove ext2_new_block() and opencode
it in the xattr code since it has only that one user anyway.

								Honza



> ---
>  fs/ext2/balloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index c8049c90323d..039f655febfd 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1432,8 +1432,14 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
>  ext2_fsblk_t ext2_new_block(struct inode *inode, unsigned long goal, int *errp)
>  {
>  	unsigned long count = 1;
> +	struct ext2_inode_info *ei = EXT2_I(inode);
> +	ext2_fsblk_t ret;
> +
> +	mutex_lock(&ei->truncate_mutex);
> +	ret = ext2_new_blocks(inode, goal, &count, errp);
> +	mutex_unlock(&ei->truncate_mutex);
>  
> -	return ext2_new_blocks(inode, goal, &count, errp);
> +	return ret;
>  }
>  
>  #ifdef EXT2FS_DEBUG
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

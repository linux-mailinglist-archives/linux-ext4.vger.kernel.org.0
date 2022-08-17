Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1EC59715A
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiHQOb6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbiHQObt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 10:31:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8B99278;
        Wed, 17 Aug 2022 07:31:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 45AB71F388;
        Wed, 17 Aug 2022 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660746703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dI8au4TC4OwrAtVxY+/Q1utvcrjiqiLbLdD/iRthRn0=;
        b=hP4imqwJv2J/r4IeF81X6wXnVZVP61TEVNe4PFQHL2Diz4alE83ebVCiUn21bKw3KgHGDG
        50wvI9If46JH0VXgsa6BNhCXsgYsLmYLXYcJErVwoXh4pdkVdx8h8aj0l0N3sQX+STVssl
        LbjofBL/g1trwFe7PAHvtz9c49/4tTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660746703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dI8au4TC4OwrAtVxY+/Q1utvcrjiqiLbLdD/iRthRn0=;
        b=3NwqDGCjy5QY8cTxNV/SD2uLCNsKLuZUNd1z1V/nEVYN+xiIIDBDSd2mZP3UilVgKF8ZFu
        MMUoh7EW/JwORSBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AEF332C172;
        Wed, 17 Aug 2022 14:31:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39CACA066B; Wed, 17 Aug 2022 16:31:38 +0200 (CEST)
Date:   Wed, 17 Aug 2022 16:31:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Message-ID: <20220817143138.7krkxzoa3skruiyx@quack3>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817132701.3015912-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 17-08-22 21:27:01, Baokun Li wrote:
> In do_writepages, if the value returned by ext4_writepages is "-ENOMEM"
> and "wbc->sync_mode == WB_SYNC_ALL", retry until the condition is not met.
> 
> In __ext4_get_inode_loc, if the bh returned by sb_getblk is NULL,
> the function returns -ENOMEM.
> 
> In __getblk_slow, if the return value of grow_buffers is less than 0,
> the function returns NULL.
> 
> When the three processes are connected in series like the following stack,
> an infinite loop may occur:
> 
> do_writepages					<--- keep retrying
>  ext4_writepages
>   mpage_map_and_submit_extent
>    mpage_map_one_extent
>     ext4_map_blocks
>      ext4_ext_map_blocks
>       ext4_ext_handle_unwritten_extents
>        ext4_ext_convert_to_initialized
>         ext4_split_extent
>          ext4_split_extent_at
>           __ext4_ext_dirty
>            __ext4_mark_inode_dirty
>             ext4_reserve_inode_write
>              ext4_get_inode_loc
>               __ext4_get_inode_loc		<--- return -ENOMEM
>                sb_getblk
>                 __getblk_gfp
>                  __getblk_slow			<--- return NULL
>                   grow_buffers
>                    grow_dev_page		<--- return -ENXIO
>                     ret = (block < end_block) ? 1 : -ENXIO;
> 
> In this issue, bg_inode_table_hi is overwritten as an incorrect value.
> As a result, `block < end_block` cannot be met in grow_dev_page.
> Therefore, __ext4_get_inode_loc always returns '-ENOMEM' and do_writepages
> keeps retrying. As a result, the writeback process is in the D state due
> to an infinite loop.
> 
> Add a check on inode table block in the __ext4_get_inode_loc function by
> referring to ext4_read_inode_bitmap to avoid this infinite loop.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for the fixes. Normally, we check that inode table is fine in
ext4_check_descriptors() (and those checks are much stricter) so it seems
unnecessary to check it again here. I understand that in your case it was
resize that corrupted the group descriptor after the filesystem was mounted
which is nasty but there's much more metadata that can be corrupted like
this and it's infeasible to check each metadata block before we use it.

IMHO a proper fix to this class of issues would be for sb_getblk() to
return proper error so that we can distinguish ENOMEM from other errors.
But that will be a larger undertaking...

								Honza

> ---
>  fs/ext4/inode.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 601214453c3a..5e171879fa23 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4466,9 +4466,17 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
>  	inode_offset = ((ino - 1) %
>  			EXT4_INODES_PER_GROUP(sb));
> -	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
>  	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
>  
> +	block = ext4_inode_table(sb, gdp);
> +	if ((block <= le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) ||
> +	    (block >= ext4_blocks_count(EXT4_SB(sb)->s_es))) {
> +		ext4_error(sb, "Invalid inode table block %llu in "
> +			   "block_group %u", block, iloc->block_group);
> +		return -EFSCORRUPTED;
> +	}
> +	block += (inode_offset / inodes_per_block);
> +
>  	bh = sb_getblk(sb, block);
>  	if (unlikely(!bh))
>  		return -ENOMEM;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFBD22F3F
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2019 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfETIth (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 May 2019 04:49:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfETIth (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 May 2019 04:49:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26645AF7F;
        Mon, 20 May 2019 08:49:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DADD01E3ED6; Mon, 20 May 2019 10:49:35 +0200 (CEST)
Date:   Mon, 20 May 2019 10:49:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: code cleanup by using test_opt() and clear_opt()
Message-ID: <20190520084935.GB2172@quack2.suse.cz>
References: <20190520054503.26411-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520054503.26411-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 20-05-19 13:45:03, Chengguang Xu wrote:
> Using test_opt() and clear_opt() instead of directly
> comparing flag bit of mount option.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks! Applied.

								Honza

> ---
>  fs/ext2/super.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 3988633789cb..ca7229c38fce 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -302,16 +302,16 @@ static int ext2_show_options(struct seq_file *seq, struct dentry *root)
>  	if (test_opt(sb, NOBH))
>  		seq_puts(seq, ",nobh");
>  
> -	if (sbi->s_mount_opt & EXT2_MOUNT_USRQUOTA)
> +	if (test_opt(sb, USRQUOTA))
>  		seq_puts(seq, ",usrquota");
>  
> -	if (sbi->s_mount_opt & EXT2_MOUNT_GRPQUOTA)
> +	if (test_opt(sb, GRPQUOTA))
>  		seq_puts(seq, ",grpquota");
>  
> -	if (sbi->s_mount_opt & EXT2_MOUNT_XIP)
> +	if (test_opt(sb, XIP))
>  		seq_puts(seq, ",xip");
>  
> -	if (sbi->s_mount_opt & EXT2_MOUNT_DAX)
> +	if (test_opt(sb, DAX))
>  		seq_puts(seq, ",dax");
>  
>  	if (!test_opt(sb, RESERVATION))
> @@ -934,8 +934,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_resgid = opts.s_resgid;
>  
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
> -		((EXT2_SB(sb)->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ?
> -		 SB_POSIXACL : 0);
> +		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  	sb->s_iflags |= SB_I_CGROUPWB;
>  
>  	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
> @@ -966,11 +965,11 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
>  
> -	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
> +	if (test_opt(sb, DAX)) {
>  		if (!bdev_dax_supported(sb->s_bdev, blocksize)) {
>  			ext2_msg(sb, KERN_ERR,
>  				"DAX unsupported by block device. Turning off DAX.");
> -			sbi->s_mount_opt &= ~EXT2_MOUNT_DAX;
> +			clear_opt(sbi->s_mount_opt, DAX);
>  		}
>  	}
>  
> @@ -1403,7 +1402,7 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
>  	sbi->s_resuid = new_opts.s_resuid;
>  	sbi->s_resgid = new_opts.s_resgid;
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
> -		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? SB_POSIXACL : 0);
> +		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  	spin_unlock(&sbi->s_lock);
>  
>  	return 0;
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

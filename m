Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD14227D3A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGUKjf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 06:39:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgGUKje (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Jul 2020 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595327973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHU/8dr8CBcm32devIefLcqBHrNfS4DApSBeVinqUM0=;
        b=amG84eQNosVWyxLc8xLPMufwoU20c1YnPucgcK3CJZiC5jhduCqS1rAmVLFewKPZAPIE5l
        WrSVCxMhuqeWjtg0aRzrcx9vWlPvlF109aScLqR2pJ86ODASDsCzVpkhvQCrUz3O2YPdi5
        w68ZULnS0e9347+ZHHYt2EGzpRjgUuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-mkIko67pPMaD_-1ltN-N4g-1; Tue, 21 Jul 2020 06:39:29 -0400
X-MC-Unique: mkIko67pPMaD_-1ltN-N4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72527E918;
        Tue, 21 Jul 2020 10:39:28 +0000 (UTC)
Received: from work (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C9DD8FA45;
        Tue, 21 Jul 2020 10:39:25 +0000 (UTC)
Date:   Tue, 21 Jul 2020 12:39:22 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 4/4] ext4: Fold ext4_data_block_valid_rcu() into the
 caller
Message-ID: <20200721103922.kpcloexbd2e6nhpm@work>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715131812.7243-5-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 15, 2020 at 03:18:12PM +0200, Jan Kara wrote:
> After the previous patch, ext4_data_block_valid_rcu() has a single
> caller. Fold it into it.

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/block_validity.c | 67 ++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 3602356cbf09..9c40214f31f9 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -144,40 +144,6 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
>  	printk(KERN_CONT "\n");
>  }
>  
> -/*
> - * Returns 1 if the passed-in block region (start_blk,
> - * start_blk+count) is valid; 0 if some part of the block region
> - * overlaps with filesystem metadata blocks.
> - */
> -static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
> -				     struct ext4_system_blocks *system_blks,
> -				     ext4_fsblk_t start_blk,
> -				     unsigned int count, ino_t ino)
> -{
> -	struct ext4_system_zone *entry;
> -	struct rb_node *n;
> -
> -	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> -	    (start_blk + count < start_blk) ||
> -	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
> -		return 0;
> -
> -	if (system_blks == NULL)
> -		return 1;
> -
> -	n = system_blks->root.rb_node;
> -	while (n) {
> -		entry = rb_entry(n, struct ext4_system_zone, node);
> -		if (start_blk + count - 1 < entry->start_blk)
> -			n = n->rb_left;
> -		else if (start_blk >= (entry->start_blk + entry->count))
> -			n = n->rb_right;
> -		else
> -			return entry->ino == ino;
> -	}
> -	return 1;
> -}
> -
>  static int ext4_protect_reserved_inode(struct super_block *sb,
>  				       struct ext4_system_blocks *system_blks,
>  				       u32 ino)
> @@ -333,11 +299,24 @@ void ext4_release_system_zone(struct super_block *sb)
>  		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
>  }
>  
> +/*
> + * Returns 1 if the passed-in block region (start_blk,
> + * start_blk+count) is valid; 0 if some part of the block region
> + * overlaps with some other filesystem metadata blocks.
> + */
>  int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
>  			  unsigned int count)
>  {
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct ext4_system_blocks *system_blks;
> -	int ret;
> +	struct ext4_system_zone *entry;
> +	struct rb_node *n;
> +	int ret = 1;
> +
> +	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> +	    (start_blk + count < start_blk) ||
> +	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
> +		return 0;
>  
>  	/*
>  	 * Lock the system zone to prevent it being released concurrently
> @@ -346,8 +325,22 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
>  	 */
>  	rcu_read_lock();
>  	system_blks = rcu_dereference(sbi->system_blks);
> -	ret = ext4_data_block_valid_rcu(EXT4_SB(inode->i_sb), system_blks,
> -					start_blk, count, inode->i_ino);
> +	if (system_blks == NULL)
> +		goto out_rcu;
> +
> +	n = system_blks->root.rb_node;
> +	while (n) {
> +		entry = rb_entry(n, struct ext4_system_zone, node);
> +		if (start_blk + count - 1 < entry->start_blk)
> +			n = n->rb_left;
> +		else if (start_blk >= (entry->start_blk + entry->count))
> +			n = n->rb_right;
> +		else {
> +			ret = (entry->ino == inode->i_ino);
> +			break;
> +		}
> +	}
> +out_rcu:
>  	rcu_read_unlock();
>  	return ret;
>  }
> -- 
> 2.16.4
> 


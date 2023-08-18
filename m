Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E21780A92
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376464AbjHRK5L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376477AbjHRK4o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 06:56:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE430C5;
        Fri, 18 Aug 2023 03:56:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 65E4C1F74B;
        Fri, 18 Aug 2023 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692356200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IexQAHHwPg7BS8BG5o/PF8w5W2wWtYxUcyhYNR9qRWA=;
        b=FEbMqAMzLGnkIIUsdHPSUpcc+D0sOVCaAT+2/jqiN+m1UbpWRmKkMO8Xh0C/v07PiqAqsF
        ZR2IBRC+d2GA/HmvKa99NuRQEtdqZuZ8Oq1slCUnLfS2MHs9OsccLd3UdCDN+tI/OsXAGS
        H6dmYf4nL7edlt86LDXPkozS+GvsVfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692356200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IexQAHHwPg7BS8BG5o/PF8w5W2wWtYxUcyhYNR9qRWA=;
        b=NBYiqKIqFP43bbK6+WA7OnSJd1X3B4Vm6hBXZlLY/7e4ms8egVInCibTIMmA+v9Rk21jT1
        iPicyc8IpBRS2AAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57CD3138F0;
        Fri, 18 Aug 2023 10:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wS1sFWhO32QGVQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 18 Aug 2023 10:56:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3251A076B; Fri, 18 Aug 2023 12:56:39 +0200 (CEST)
Date:   Fri, 18 Aug 2023 12:56:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Georg Ottinger <g.ottinger@gmx.at>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ext2: improve consistency of ext2_fsblk_t datatype
 usage
Message-ID: <20230818105639.fdq4v3ukgvy7coxc@quack3>
References: <20230817195925.10268-1-g.ottinger@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817195925.10268-1-g.ottinger@gmx.at>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 17-08-23 21:59:25, Georg Ottinger wrote:
> The ext2 block allocation/deallocation functions and their respective
> calls use a mixture of unsigned long and ext2_fsblk_t datatypes to
> index the desired ext2 block. This commit replaces occurrences of
> unsigned long with ext2_fsblk_t, covering the functions
> ext2_new_block(), ext2_new_blocks(), ext2_free_blocks(),
> ext2_free_data() and ext2_free_branches(). This commit is rather
> conservative, and only replaces unsigned long with ext2_fsblk_t if
> the variable is used to index a specific ext2 block.
> 
> Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/balloc.c | 4 ++--
>  fs/ext2/ext2.h   | 6 +++---
>  fs/ext2/inode.c  | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index eca60b747..9db13852c 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -474,7 +474,7 @@ void ext2_discard_reservation(struct inode *inode)
>   * @block:		start physical block to free
>   * @count:		number of blocks to free
>   */
> -void ext2_free_blocks (struct inode * inode, unsigned long block,
> +void ext2_free_blocks (struct inode * inode, ext2_fsblk_t block,
>  		       unsigned long count)
>  {
>  	struct buffer_head *bitmap_bh = NULL;
> @@ -1431,7 +1431,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
>  	return 0;
>  }
> 
> -ext2_fsblk_t ext2_new_block(struct inode *inode, unsigned long goal, int *errp)
> +ext2_fsblk_t ext2_new_block(struct inode *inode, ext2_fsblk_t goal, int *errp)
>  {
>  	unsigned long count = 1;
> 
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 35a041c47..83fd85bb1 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -695,12 +695,12 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
>  /* balloc.c */
>  extern int ext2_bg_has_super(struct super_block *sb, int group);
>  extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
> -extern ext2_fsblk_t ext2_new_block(struct inode *, unsigned long, int *);
> -extern ext2_fsblk_t ext2_new_blocks(struct inode *, unsigned long,
> +extern ext2_fsblk_t ext2_new_block(struct inode *, ext2_fsblk_t, int *);
> +extern ext2_fsblk_t ext2_new_blocks(struct inode *, ext2_fsblk_t,
>  				unsigned long *, int *);
>  extern int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
>  				 unsigned int count);
> -extern void ext2_free_blocks (struct inode *, unsigned long,
> +extern void ext2_free_blocks (struct inode *, ext2_fsblk_t,
>  			      unsigned long);
>  extern unsigned long ext2_count_free_blocks (struct super_block *);
>  extern unsigned long ext2_count_dirs (struct super_block *);
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 75983215c..72916c929 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1082,8 +1082,8 @@ static Indirect *ext2_find_shared(struct inode *inode,
>   */
>  static inline void ext2_free_data(struct inode *inode, __le32 *p, __le32 *q)
>  {
> -	unsigned long block_to_free = 0, count = 0;
> -	unsigned long nr;
> +	ext2_fsblk_t block_to_free = 0, count = 0;
> +	ext2_fsblk_t nr;
> 
>  	for ( ; p < q ; p++) {
>  		nr = le32_to_cpu(*p);
> @@ -1123,7 +1123,7 @@ static inline void ext2_free_data(struct inode *inode, __le32 *p, __le32 *q)
>  static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int depth)
>  {
>  	struct buffer_head * bh;
> -	unsigned long nr;
> +	ext2_fsblk_t nr;
> 
>  	if (depth--) {
>  		int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
> --
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

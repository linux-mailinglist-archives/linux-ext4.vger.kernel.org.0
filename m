Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2360D5A7B62
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 12:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHaKgR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 06:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiHaKgP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 06:36:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D53CA98EA
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 03:36:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6785922278;
        Wed, 31 Aug 2022 10:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661942171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9a0XRLI3pHJPAV1Dyp7l1aWwOveshnTtNyRtnpeBbOI=;
        b=e+er0KXHOZWmcrAnNv0hJIXZJuElfDpSTqZ02nbpdeOWyH8KvdrN74EarKTUV6gkaLfn4l
        KhmHJvpkLl2/7pnDuLBO0G9MrXuCbbcIuJeVg99SrhDRBrgygiyhkBTa4n1fk0SLKBgH3T
        qxKaoT6J3eHK8mbJR20ZQuhnQgwQUkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661942171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9a0XRLI3pHJPAV1Dyp7l1aWwOveshnTtNyRtnpeBbOI=;
        b=hWcr44w+zyqbedOLAmWb4pnBnt93x45bW2A0wHO7VAiX2EyKiBDeGq2y8+ukeO9UbbmcLw
        RXf2WtjKxTv88aBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 562E813A7C;
        Wed, 31 Aug 2022 10:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BVEAFZs5D2P8ZgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 10:36:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB756A067B; Wed, 31 Aug 2022 12:36:10 +0200 (CEST)
Date:   Wed, 31 Aug 2022 12:36:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, openglfreak@googlemail.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: ext4_read_bh_lock() should submit IO if the buffer
 isn't uptodate
Message-ID: <20220831103610.mlucilhxbho4ry25@quack3>
References: <20220831074629.3755110-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831074629.3755110-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 31-08-22 15:46:29, Zhang Yi wrote:
> Recently we notice that ext4 filesystem occasionally fail to read
> metadata from disk and report error message, but the disk and block
> layer looks fine. After analyse, we lockon commit 88dbcbb3a484
> ("blkdev: avoid migration stalls for blkdev pages"). It provide a
> migration method for the bdev, we could move page that has buffers
> without extra users now, but it lock the buffers on the page, which
> breaks the fragile metadata read operation on ext4 filesystem,
> ext4_read_bh_lock() was copied from ll_rw_block(), it depends on the
> assumption of that locked buffer means it is under IO. So it just
> trylock the buffer and skip submit IO if it lock failed, after
> wait_on_buffer() we conclude IO error because the buffer is not
> uptodate.
> 
> This issue could be easily reproduced by add some delay just after
> buffer_migrate_lock_buffers() in __buffer_migrate_folio() and do
> fsstress on ext4 filesystem.
> 
>   EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
>   comm fsstress: reading directory lblock 0
>   EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
>   comm fsstress: reading directory lblock 0
> 
> Fix it by removing the trylock logic in ext4_read_bh_lock(), just lock
> the buffer and submit IO if it's not uptodate, and also leave over
> readahead helper.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the fix. It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..629bba3fa99a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -205,19 +205,12 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
>  
>  int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
>  {
> -	if (trylock_buffer(bh)) {
> -		if (wait)
> -			return ext4_read_bh(bh, op_flags, NULL);
> +	lock_buffer(bh);
> +	if (!wait) {
>  		ext4_read_bh_nowait(bh, op_flags, NULL);
>  		return 0;
>  	}
> -	if (wait) {
> -		wait_on_buffer(bh);
> -		if (buffer_uptodate(bh))
> -			return 0;
> -		return -EIO;
> -	}
> -	return 0;
> +	return ext4_read_bh(bh, op_flags, NULL);
>  }
>  
>  /*
> @@ -264,7 +257,8 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
>  	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
>  
>  	if (likely(bh)) {
> -		ext4_read_bh_lock(bh, REQ_RAHEAD, false);
> +		if (trylock_buffer(bh))
> +			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL);
>  		brelse(bh);
>  	}
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

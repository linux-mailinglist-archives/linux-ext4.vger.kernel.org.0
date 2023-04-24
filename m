Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE16ED259
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDXQYS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 12:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDXQYR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 12:24:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B91E69;
        Mon, 24 Apr 2023 09:24:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6BE01FD93;
        Mon, 24 Apr 2023 16:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682353455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIFqtj5gWVCy/HqqFdgfpfyyCQW7DaFAKwITl1QkuR4=;
        b=VOYamucX0CJArl2ahuhvzM9fXrWNkaKLzeVVSnDDCqFBvlcmJKanheYyk8g8FyFA4dACtZ
        HpCx7hdwoznSwbPjdbaxYRDfu4QPnnsargqUCwvp1O1GMA1MHKE0VD250HxvPXkoBput8M
        xhcG7FG2R2uhbagAKFEGZomgfbIGRGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682353455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XIFqtj5gWVCy/HqqFdgfpfyyCQW7DaFAKwITl1QkuR4=;
        b=SKMV1crk5umBOeseM6cGEBBzSTkerVgIRJcoRySIKZudmJauOBmC6FFuIX9AOyfEO8J2QH
        iMp0FfxDZ8nYrhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC94413780;
        Mon, 24 Apr 2023 16:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mj0ELi+tRmRCCAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Apr 2023 16:24:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EFD9DA0729; Mon, 24 Apr 2023 18:24:13 +0200 (CEST)
Date:   Mon, 24 Apr 2023 18:24:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ext4: move `ext4_count_free` to ext4.h so it can be
 easily inlined
Message-ID: <20230424162413.hiimozuw44fhht4a@quack3>
References: <20230421014750.2315938-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421014750.2315938-1-goldstein.w.n@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 20-04-23 20:47:49, Noah Goldstein wrote:
> `ext4_count_free` is a one-line helper that is clearly better off
> being inlined. This saves a handful instructions in `vmlinux` on x86.
> 
> Instruction estimates use `wc -l` on `objdump`
> Before: 8539271
> After : 8539248
> 
> So saves roughly 20 instructions
> 
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>

Looks fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/bitmap.c | 5 -----
>  fs/ext4/ext4.h   | 6 +++++-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index f63e028c638c..c3cd2b878bbd 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -11,11 +11,6 @@
>  #include <linux/buffer_head.h>
>  #include "ext4.h"
>  
> -unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
> -{
> -	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
> -}
> -
>  int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
>  				  struct ext4_group_desc *gdp,
>  				  struct buffer_head *bh, int sz)
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 08b29c289da4..6e1d3c175a70 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2675,7 +2675,11 @@ struct mmpd_data {
>  # define NORET_AND	noreturn,
>  
>  /* bitmap.c */
> -extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
> +static inline unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
> +{
> +	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
> +}
> +
>  void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh, int sz);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

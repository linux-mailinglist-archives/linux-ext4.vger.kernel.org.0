Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E887D6F405B
	for <lists+linux-ext4@lfdr.de>; Tue,  2 May 2023 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEBJmD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 May 2023 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjEBJmC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 May 2023 05:42:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A34C13
        for <linux-ext4@vger.kernel.org>; Tue,  2 May 2023 02:41:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD57222B6;
        Tue,  2 May 2023 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683020518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPJsTsTfQD1ZjjRLY0XcTgnSmLSK725uLda/BrX2dXs=;
        b=hHX7zgs3+sKugilaBiASo4pbFr9Ght7r1fCLQP9GJy7ZNqUEztTe5rK9wRrGdunJgPnA+E
        tGCTmC/6Wq6I98qWV58fTX49kgMFvULyqHluh5QzODeOY+VPRTYPyby3NoPy9qWZzXrIEl
        kcV8h/7xqykg9a8pr7dcm+uPTeIdgfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683020518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPJsTsTfQD1ZjjRLY0XcTgnSmLSK725uLda/BrX2dXs=;
        b=xNIFxbR4E8PwCtrbSu7ihigCqlz2Yic0xWLpzsW7YlDDCQpZiSRKsKVvJzyCc2K4TyAph2
        D55oitAZzVAbvRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DB28139C3;
        Tue,  2 May 2023 09:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dhmMIubaUGREXQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 02 May 2023 09:41:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27C44A0735; Tue,  2 May 2023 11:41:58 +0200 (CEST)
Date:   Tue, 2 May 2023 11:41:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH] ext4: Optimize memory usage in xattr
Message-ID: <20230502094158.tubal42rp2khprah@quack3>
References: <20230428185517.1201-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428185517.1201-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 28-04-23 11:55:17, JunChao Sun wrote:
> Currently struct ext4_attr_info->in_inode use int, but the
> value is only 0 or 1, so replace int with bool.
> 
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>

Looks fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 8 ++++----
>  fs/ext4/xattr.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 767454d..d57408c 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1639,7 +1639,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
>  	struct ext4_xattr_entry *last, *next;
>  	struct ext4_xattr_entry *here = s->here;
>  	size_t min_offs = s->end - s->base, name_len = strlen(i->name);
> -	int in_inode = i->in_inode;
> +	bool in_inode = i->in_inode;
>  	struct inode *old_ea_inode = NULL;
>  	struct inode *new_ea_inode = NULL;
>  	size_t old_size, new_size;
> @@ -2354,7 +2354,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
>  		.name = name,
>  		.value = value,
>  		.value_len = value_len,
> -		.in_inode = 0,
> +		.in_inode = false,
>  	};
>  	struct ext4_xattr_ibody_find is = {
>  		.s = { .not_found = -ENODATA, },
> @@ -2441,7 +2441,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
>  		if (ext4_has_feature_ea_inode(inode->i_sb) &&
>  		    (EXT4_XATTR_SIZE(i.value_len) >
>  			EXT4_XATTR_MIN_LARGE_EA_SIZE(inode->i_sb->s_blocksize)))
> -			i.in_inode = 1;
> +			i.in_inode = true;
>  retry_inode:
>  		error = ext4_xattr_ibody_set(handle, inode, &i, &is);
>  		if (!error && !bs.s.not_found) {
> @@ -2467,7 +2467,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
>  				 */
>  				if (ext4_has_feature_ea_inode(inode->i_sb) &&
>  				    i.value_len && !i.in_inode) {
> -					i.in_inode = 1;
> +					i.in_inode = true;
>  					goto retry_inode;
>  				}
>  			}
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 824faf0..355d373 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -113,7 +113,7 @@ struct ext4_xattr_info {
>  	const void *value;
>  	size_t value_len;
>  	int name_index;
> -	int in_inode;
> +	bool in_inode;
>  };
>  
>  struct ext4_xattr_search {
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

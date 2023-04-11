Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB486DD674
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Apr 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDKJUC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Apr 2023 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDKJUB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 Apr 2023 05:20:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDFE1BD5;
        Tue, 11 Apr 2023 02:19:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BE601FDE9;
        Tue, 11 Apr 2023 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681204798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9x2PP7g3qikWCl7Lm0S7Kg1LeW9kRdgJ7wxd8BEP+WA=;
        b=ZkSyf6HWrFO7u2blhYjirwDKgUAzYkmGNXlK6Z3USIR2DZM5irMiI46wHDR1rKtcU7QX6y
        CRW0glLXNXzEQ0+1iKvYTnI70Wiz7zNRxK9MzLDZjU7EqV2zwz11MHvAyTV8o+R6b3+7Gh
        1kO/W3zR5kcAmbeSCXjre/Q3QAkqtU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681204798;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9x2PP7g3qikWCl7Lm0S7Kg1LeW9kRdgJ7wxd8BEP+WA=;
        b=4sSOGhLuEEzXG3CXu1wcYUV2XNdnB9SOHDdWBEo2nkpVHTj3ViuGiL0MUTHl2yF9M9Kw9S
        j1C6lKqSmpWazwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D1EE13519;
        Tue, 11 Apr 2023 09:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id amB/Hj4mNWTbJAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 09:19:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 03F76A0732; Tue, 11 Apr 2023 11:19:57 +0200 (CEST)
Date:   Tue, 11 Apr 2023 11:19:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 2/2] ext4: use __GFP_NOFAIL if allocating
 extents_status cannot fail
Message-ID: <20230411091957.wuwa7wii7pj35ua7@quack3>
References: <20230406132834.1669710-1-libaokun1@huawei.com>
 <20230406132834.1669710-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406132834.1669710-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-04-23 21:28:34, Baokun Li wrote:
> If extent status tree update fails, we have inconsistency between what is
> stored in the extent status tree and what is stored on disk. And that can
> cause even data corruption issues in some cases.
> 
> In the extent status tree, we have extents which we can just drop without
> issues and extents we must not drop - this depends on the extent's status
> - currently ext4_es_is_delayed() extents must stay, others may be dropped.
> 
> For extents that cannot be dropped we use __GFP_NOFAIL to allocate memory.
> A helper function is also added to help determine if the current extent can
> be dropped, although only ext4_es_is_delayed() extents cannot be dropped
> currently. In addition, with the above logic, the undo operation in
> __es_remove_extent that may cause inconsistency if the split extent fails
> is unnecessary, so we remove it as well.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Add the patch 2 as suggested by Jan Kara.
> 
>  fs/ext4/extents_status.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 7bc221038c6c..8eed17f35b11 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -448,12 +448,29 @@ static void ext4_es_list_del(struct inode *inode)
>  	spin_unlock(&sbi->s_es_lock);
>  }
>  
> +/*
> + * Helper function to help determine if memory allocation for this
> + * extent_status is allowed to fail.
> + */
> +static inline bool ext4_es_alloc_should_nofail(struct extent_status *es)

I'd call this function ext4_es_must_keep() and also use it in
es_do_reclaim_extents() instead of ext4_es_is_delayed(). Do this as a
preparatory patch please.

> @@ -792,9 +809,16 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
>  	}
>  
>  	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
> -				  newes->es_pblk);
> -	if (!es)
> -		return -ENOMEM;
> +				  newes->es_pblk, 0);

I would just call this like:

	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
				newes->es_pblk, ext4_es_must_keep(newes));

to save the ifs below.

> +	if (!es) {
> +		/* Use GFP_NOFAIL if the allocation cannot fail. */
> +		if (ext4_es_alloc_should_nofail(newes))
> +			es = ext4_es_alloc_extent(inode, newes->es_lblk,
> +					newes->es_len, newes->es_pblk, 1);
> +		else
> +			return -ENOMEM;
> +	}
> +
>  	rb_link_node(&es->rb_node, parent, p);
>  	rb_insert_color(&es->rb_node, &tree->root);
>  
> @@ -1349,8 +1373,6 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  						    ext4_es_status(&orig_es));
>  			err = __es_insert_extent(inode, &newes);
>  			if (err) {
> -				es->es_lblk = orig_es.es_lblk;
> -				es->es_len = orig_es.es_len;
>  				if ((err == -ENOMEM) &&
>  				    __es_shrink(EXT4_SB(inode->i_sb),
>  							128, EXT4_I(inode)))

Also now __es_remove_extent() cannot fail (it will always remove what it
should, maybe more) so please just make it void function (as a separate
cleanup patch afterwards). Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

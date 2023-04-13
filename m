Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1216A6E0B69
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDMKaI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Apr 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMKaH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Apr 2023 06:30:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111BB2729;
        Thu, 13 Apr 2023 03:30:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B743E218B1;
        Thu, 13 Apr 2023 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681381805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7eB7KigwZiA+fH3A/5KghsP33/tCKMtEs+CajSqpnE=;
        b=hzToN3Lj0u81vm8Ra98HP3NMJ0MbNnAfminwAJ34lXFb1Z9T18MPrDY8uzLcmhz7TqrqX2
        1pToJ1ijT2HsnE3sWWhgQVvrcecVq4nbieHLPStdZ51eMNA3IXSk7s4X1KHIM7XaolG894
        20xHvS2NSRqbGulkSGnFL/DYKU16nE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681381805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7eB7KigwZiA+fH3A/5KghsP33/tCKMtEs+CajSqpnE=;
        b=S90bbPSs2ZSlJikspMNu7kaks5cTX5awuepNPPUN+lwqgxdwS48cBHZaH9KGndLXBLqJ0y
        yQ9hQMC+oChRl/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A58091390E;
        Thu, 13 Apr 2023 10:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1xxeKK3ZN2RaTAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 13 Apr 2023 10:30:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E494FA0732; Thu, 13 Apr 2023 12:30:04 +0200 (CEST)
Date:   Thu, 13 Apr 2023 12:30:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/8] ext4: use __GFP_NOFAIL if allocating
 extents_status cannot fail
Message-ID: <20230413103004.a4hjlxgpfqnhcgtg@quack3>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412124126.2286716-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 12-04-23 20:41:21, Baokun Li wrote:
> If extent status tree update fails, we have inconsistency between what is
> stored in the extent status tree and what is stored on disk. And that can
> cause even data corruption issues in some cases.
> 
> For extents that cannot be dropped we use __GFP_NOFAIL to allocate memory.
> And with the above logic, the undo operation in __es_remove_extent that
> may cause inconsistency if the split extent fails is unnecessary, so we
> remove it as well.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

When I was looking through this patch, I've realized there's a problem with
my plan :-|. See below...

>  static struct extent_status *
>  ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
> -		     ext4_fsblk_t pblk)
> +		     ext4_fsblk_t pblk, int nofail)
>  {
>  	struct extent_status *es;
> -	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
> +	gfp_t gfp_flags = GFP_ATOMIC;
> +
> +	if (nofail)
> +		gfp_flags |= __GFP_NOFAIL;
> +
> +	es = kmem_cache_alloc(ext4_es_cachep, gfp_flags);
>  	if (es == NULL)
>  		return NULL;

I have remembered that the combination of GFP_ATOMIC and GFP_NOFAIL is
discouraged because the kernel has no sane way of refilling reserves for
atomic allocations when in atomic context. So this combination can result
in lockups.

So what I think we'll have to do is that we'll just have to return error
from __es_insert_extent() and __es_remove_extent() and in the callers we
drop the i_es_lock, allocate needed status entries (one or two depending on
the desired operation) with GFP_KERNEL | GFP_NOFAIL, get the lock again and
pass the preallocated entries into __es_insert_extent /
__es_remove_extent(). It's a bit ugly but we can at least remove those
__es_shrink() calls which are not pretty either.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

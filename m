Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E36D70CD
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDDXki (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDDXkh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 19:40:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C043C3F
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 16:40:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w4so32815146plg.9
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680651635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/r2yyBxa2UjizT7DIESb3jdVn4T1vcr3JZCxz3Un80=;
        b=l2RsFYI9/RVRWt/aDmW615qjr94XgOxAaXQ+UAkJU4YMTNxdL1SWonsdJUToBlbJ33
         DPIu1jzsGIMef5CH+m4C2GOQV87eocIVgfGQ2KXn6+YS9XADLuJnuOSAx6h9+j9fnpY5
         JTHYmubv4qSZWAR14+cgEjLy3uLmmEqMpfJ+lATcV1zLzTamDk02U3M8jBH7uG496lcD
         puuraASOSvX9+ur5puWLnEC9/61i1l5u5Gr181q9JcQG0znhvmDJq5XOdzeaXNEnNW05
         1UU5+ld2OPAAE5dtXF9Jdb1D6TH+pXeDq+mDu/DmDkU3DEmpC9mQq6W3PJ67HVENlW/F
         mRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680651635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/r2yyBxa2UjizT7DIESb3jdVn4T1vcr3JZCxz3Un80=;
        b=7R7ie1s4MEHGQ7HWVS0uFWXA21wZ2g7wh9LvXmQrrj9ZyOnBtQxs/B4XtpMRLD471f
         WrfEtyxEnRmmwnyG9icyvwTnvZuN3kkRADg0DzAW5BVxcm2qYdVfbRBYzXoAzELHX2Ac
         fsVxQsIKNUG4/bYsGrfEgfaU3agfsxriOtZ7+Pztb7nVu8z59KNKOTT4abzi9yaQaf74
         3CaA3NJsbJVmXGLkYKtdNa0JPAq8n4h4bXXF/AOCW4bzflLyUQFAwbRDT8UPZl3tJnvJ
         U8cbvwhdjQFyrfiVwSImlgdhx1J+kAT94Z3wSxMFDy1P7Tpnu2UC9X7Iy7lTo3Awl228
         bZkQ==
X-Gm-Message-State: AAQBX9f8WQLd9alv1EAsz2N59XCpTxR2Xlh8isvX02pjwbnx9lwFNw6W
        CKnAOuvZT7+ZeM8z/8buJ0M0eg==
X-Google-Smtp-Source: AKy350aGtUyDc7dXm54tao9SO1Z52DtK7YHUJoaBCaBA1TXOYmz5/48+4yE+r2PZyPM8LNhcT3l0sw==
X-Received: by 2002:a17:902:fb8c:b0:1a1:c945:4b23 with SMTP id lg12-20020a170902fb8c00b001a1c9454b23mr3916070plb.65.1680651635730;
        Tue, 04 Apr 2023 16:40:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902b11200b001a216d44440sm8856651plr.200.2023.04.04.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 16:40:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pjqGB-00H7Og-Tt; Wed, 05 Apr 2023 09:40:19 +1000
Date:   Wed, 5 Apr 2023 09:40:19 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 06/23] fsverity: add drop_page() callout
Message-ID: <20230404234019.GM3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-7-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-7-aalbersh@redhat.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 04, 2023 at 04:53:02PM +0200, Andrey Albershteyn wrote:
> Allow filesystem to make additional processing on verified pages
> instead of just dropping a reference. This will be used by XFS for
> internal buffer cache manipulation in further patches. The btrfs,
> ext4, and f2fs just drop the reference.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/btrfs/verity.c         | 12 ++++++++++++
>  fs/ext4/verity.c          |  6 ++++++
>  fs/f2fs/verity.c          |  6 ++++++
>  fs/verity/read_metadata.c |  4 ++--
>  fs/verity/verify.c        |  6 +++---
>  include/linux/fsverity.h  | 10 ++++++++++
>  6 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index c5ff16f9e9fa..4c2c09204bb4 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -804,10 +804,22 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
>  			       pos, buf, size);
>  }
>  
> +/*
> + * fsverity op that releases the reference obtained by ->read_merkle_tree_page()
> + *
> + * @page:  reference to the page which can be released
> + *
> + */
> +static void btrfs_drop_page(struct page *page)
> +{
> +	put_page(page);
> +}
> +
>  const struct fsverity_operations btrfs_verityops = {
>  	.begin_enable_verity     = btrfs_begin_enable_verity,
>  	.end_enable_verity       = btrfs_end_enable_verity,
>  	.get_verity_descriptor   = btrfs_get_verity_descriptor,
>  	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
>  	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
> +	.drop_page		 = &btrfs_drop_page,
>  };

Ok, that's a generic put_page() call.

....
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index f50e3b5b52c9..c2fc4c86af34 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -210,7 +210,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
>  			memcpy_from_page(_want_hash, hpage, hoffset, hsize);
>  			want_hash = _want_hash;
> -			put_page(hpage);
> +			inode->i_sb->s_vop->drop_page(hpage);
>  			goto descend;

			fsverity_drop_page(hpage);

static inline void
fsverity_drop_page(struct inode *inode, struct page *page)
{
	if (inode->i_sb->s_vop->drop_page)
		inode->i_sb->s_vop->drop_page(page);
	else
		put_page(page);
}

And then you don't need to add the functions to each of the
filesystems nor make an indirect call just to run put_page().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

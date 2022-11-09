Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41E6231F6
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiKISCY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiKISCQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 13:02:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E31F63C
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 10:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4092461C30
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B4AC433C1;
        Wed,  9 Nov 2022 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668016821;
        bh=3fjs/UduqOFWRU0spzpkLAbFTrtn0rgPj88m+pW8IXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAvyHDuOKANzRis57DCHN2VHpVQGQ+GNGpclN9l07LcUNT9wiXlSbBvTh+ehArVhK
         LjsxfpxcYJzJHW+i89APBb+k2irJxMmPIvE2CqajYZC7T8RjqoSRdOeZ2JGk6zPqWY
         TUKO+Pz1ZG+R662rMcqheiymmWjnmedPOLekE2FU8xva/rRYHpW0FIilywJYE4AeMv
         pJiSvPaXa4hXw6gsWl0QXhGy2xPmCGR45ghTxIjQs+gpXByIl2Pm9DVRJolbUPxCzw
         se6mmG9HUqHqR+eNM51Fu+bZRjP9nrwyCF3cklwlO3/luVZ5LiIbkDS+qxOhFETCFB
         I98GOqcWRaN/A==
Date:   Wed, 9 Nov 2022 10:00:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: replace kmem_cache_create with KMEM_CACHE
Message-ID: <Y2vqs7/Djy22B6XE@sol.localdomain>
References: <20221109153822.80250-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109153822.80250-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 09, 2022 at 07:38:22AM -0800, JunChao Sun wrote:
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 3d21eae267fc..773176e7f9f5 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -410,9 +410,8 @@ int ext4_mpage_readpages(struct inode *inode,
>  
>  int __init ext4_init_post_read_processing(void)
>  {
> -	bio_post_read_ctx_cache =
> -		kmem_cache_create("ext4_bio_post_read_ctx",
> -				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
> +	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, SLAB_RECLAIM_ACCOUNT);
> +

Why use SLAB_RECLAIM_ACCOUNT here?

- Eric

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAF5887D0
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiHCHTR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiHCHTR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 03:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30EDF186E0
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659511153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FyM6qsYORmjhyO073Hc8R+EG5HGOEnKHb40DOBWxAFQ=;
        b=asIKb6AdzANx/KCeQ7J9Fg5cH7fEUNuBfz4aizM9XEgPIGtV4TiYnezL7ppulD7kTU9QvM
        7WLqM3rV/jsXYglYs5Eajtlek6LKfo6ZapFCpl5Bt2a/RY2YIQ3PhBZTcARGiib2jmh6QP
        3imMATyOsyH/0Qc2mY3E1JtdzjPFjhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-CB-BiDc2ORybVdic3VtL2g-1; Wed, 03 Aug 2022 03:19:05 -0400
X-MC-Unique: CB-BiDc2ORybVdic3VtL2g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13846802E5C;
        Wed,  3 Aug 2022 07:19:03 +0000 (UTC)
Received: from fedora (unknown [10.40.192.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09858492C3B;
        Wed,  3 Aug 2022 07:19:01 +0000 (UTC)
Date:   Wed, 3 Aug 2022 09:18:59 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: Re: [PATCH] ext4: fix error when itable blocks is greater than
 s_itb_per_group
Message-ID: <20220803071859.elywnni2yfol4bea@fedora>
References: <20220802021029.16046-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802021029.16046-1-michael@allwinnertech.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 02, 2022 at 10:10:29AM +0800, Michael Wu wrote:
> The following error occurs when mounting the ext4 image made by image
> making tool:
> "ext4_init_inode_table:1301:comm ext4lazyinit:Something is wrong with group
> 0: used itable blocks: 491; itable unused count: 0."
> 
> Currently all the inodes in block group0 and ext4 image is divided by
> s_inodes_per_group. That leads to a hazard: we can't ensure all
> s_inodes_per_group are divisible by s_inodes_per_block. For example, when
> the s_inodes_per_group (equals to 7851) is divided by s_inodes_per_block
> (which is 16), because 7851 is undivisible by 16, we get the wrong result
> 490, while 491 is expected.
> 
> So, we suggest that s_itb_per_group should equal to
> DIV_ROUND_UP(s_inodes_per_group, s_inodes_per_block) instead of directly
> getting the result from s_inodes_per_group/s_inodes_per_block.

Hi Michael,

mke2fs is making sure that we completely fill the inote table blocks.
This is a corrupted image and so AFAICT ext4 is doing the right thing
here. There does not seem to be a problem to fix, unless you can somehow
trick mke2fs to make a file system like this.

-Lukas

> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  fs/ext4/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 845f2f8aee5f..76cbd638ea10 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4796,8 +4796,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  			 sbi->s_inodes_per_group);
>  		goto failed_mount;
>  	}
> -	sbi->s_itb_per_group = sbi->s_inodes_per_group /
> -					sbi->s_inodes_per_block;
> +	sbi->s_itb_per_group = DIV_ROUND_UP(sbi->s_inodes_per_group,
> +					    sbi->s_inodes_per_block);
>  	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
>  	sbi->s_sbh = bh;
>  	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
> -- 
> 2.29.0
> 


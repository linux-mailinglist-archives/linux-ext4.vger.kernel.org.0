Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970D765D0D7
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 11:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjADKoc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 05:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjADKoa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 05:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694C1EC4C
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672829029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OuIRNY881fV0hFAFw21ErBybqGHIKJk812m+N/4OfLE=;
        b=bxIa7P2F464y0otkkhunpu3T8vZ0yD2wi7aJEsKKE5McFgedILoABEzZJ+p5jnpLjWcVrS
        a0ZHXdNNgXATY3fGYn7VLu7aNRI+ggKExTHV4+8szjjHmP2fgYAK7Wm/zBuBSUf0pZYHfM
        BaCxzeTOgRQu9PTPVnNucvsfST21rUo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-WqjxwdlxN4aGsbQFyAQNOw-1; Wed, 04 Jan 2023 05:43:47 -0500
X-MC-Unique: WqjxwdlxN4aGsbQFyAQNOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E35133813F2C;
        Wed,  4 Jan 2023 10:43:46 +0000 (UTC)
Received: from fedora (ovpn-192-227.brq.redhat.com [10.40.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65B801121314;
        Wed,  4 Jan 2023 10:43:46 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:43:44 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] libext2fs: consistently use #ifdefs in
 ext2fs_print_bmap_statistics()
Message-ID: <20230104104344.4r4huq7qt63o5e7a@fedora>
References: <20230104090116.275764-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104090116.275764-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:01:16AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since the 'now' variable is only used to calculate 'inuse', and 'inuse'
> is only used when defined(ENABLE_BMAP_STATS_OPS), it makes sense to
> guard the declaration and initialization of 'now' and 'inuse' by the
> same condition, just like the '*_perc' variables in the same function.
> 
> This addresses the following compiler warning with clang -Wall:
> 
> gen_bitmap64.c:187:9: warning: variable 'inuse' set but not used [-Wunused-but-set-variable]
>         double inuse;
>                ^

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/ext2fs/gen_bitmap64.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index c860c10e..1a1eeefe 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -183,11 +183,9 @@ static void ext2fs_print_bmap_statistics(ext2fs_generic_bitmap_64 bitmap)
>  #ifdef ENABLE_BMAP_STATS_OPS
>  	float mark_seq_perc = 0.0, test_seq_perc = 0.0;
>  	float mark_back_perc = 0.0, test_back_perc = 0.0;
> -#endif
> -	double inuse;
>  	struct timeval now;
> +	double inuse;
>  
> -#ifdef ENABLE_BMAP_STATS_OPS
>  	if (stats->test_count) {
>  		test_seq_perc = ((float)stats->test_seq /
>  				 stats->test_count) * 100;
> @@ -201,7 +199,6 @@ static void ext2fs_print_bmap_statistics(ext2fs_generic_bitmap_64 bitmap)
>  		mark_back_perc = ((float)stats->mark_back /
>  				  stats->mark_count) * 100;
>  	}
> -#endif
>  
>  	if (gettimeofday(&now, (struct timezone *) NULL) == -1) {
>  		perror("gettimeofday");
> @@ -212,6 +209,7 @@ static void ext2fs_print_bmap_statistics(ext2fs_generic_bitmap_64 bitmap)
>  		(((double) now.tv_usec) * 0.000001);
>  	inuse -= (double) stats->created.tv_sec + \
>  		(((double) stats->created.tv_usec) * 0.000001);
> +#endif /* ENABLE_BMAP_STATS_OPS */
>  
>  	fprintf(stderr, "\n[+] %s bitmap (type %d)\n", bitmap->description,
>  		stats->type);
> -- 
> 2.39.0
> 


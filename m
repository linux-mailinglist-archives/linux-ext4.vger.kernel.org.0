Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C654C3AD
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 10:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiFOIkb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jun 2022 04:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbiFOIk1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jun 2022 04:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 096484A926
        for <linux-ext4@vger.kernel.org>; Wed, 15 Jun 2022 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655282425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MqlUuq6oOctC8KD1R2eZd0GMgzvzvS5A75XzekWYOhU=;
        b=A9vPFz5ZZBLHc92JvJLqdU1xj723av7+o6q1QpoSEcuVjBXFQ7DKAu8+hrDeBYieE+BF9R
        WOZGC0YBiERtJRSRUM3Q0sY26378I7oDt6o/+vsyw9lfqDAPuQc4SmOHKfd5oXPw4FWBTM
        l1A4kG/kz0pf3Sr7TSFfbl6KVwU/LOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-DLiF25J4OEmEVqLmiL1YFw-1; Wed, 15 Jun 2022 04:40:20 -0400
X-MC-Unique: DLiF25J4OEmEVqLmiL1YFw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5305F185A7BA;
        Wed, 15 Jun 2022 08:40:20 +0000 (UTC)
Received: from fedora (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5308A492CA6;
        Wed, 15 Jun 2022 08:40:19 +0000 (UTC)
Date:   Wed, 15 Jun 2022 10:40:17 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix trim range leak
Message-ID: <20220615084017.xwexup5ckrrpevhe@fedora>
References: <20220614044647.21846-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614044647.21846-1-hanjinke.666@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 14, 2022 at 12:46:47PM +0800, Jinke Han wrote:
> From: hanjinke <hanjinke.666@bytedance.com>
> 
> When release group lock, a large number of blocks may be alloc from
> the group(e.g. not from the rest of target trim range). This may
> lead end of the loop and leave the rest of trim range unprocessed.

Hi,

you're correct. Indeed it's possible to miss some of the blocks this
way.

But I wonder how much of a problem this actually is? I'd think that the
optimization you just took out is very usefull, especially with larger
minlen and more fragmented free space it'll save us a lot of cycles.
Do you have any performance numbers for this change?

Perhaps we don't have to remove it completely, rather zero the
free_count every time bb_free changes? Would that be worth it?

-Lukas

> 
> Signed-off-by: hanjinke <hanjinke.666@bytedance.com>
> ---
>  fs/ext4/mballoc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9f12f29bc346..45eb9ee20947 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6345,14 +6345,13 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  {
> -	ext4_grpblk_t next, count, free_count;
> +	ext4_grpblk_t next, count;
>  	void *bitmap;
>  
>  	bitmap = e4b->bd_bitmap;
>  	start = (e4b->bd_info->bb_first_free > start) ?
>  		e4b->bd_info->bb_first_free : start;
>  	count = 0;
> -	free_count = 0;
>  
>  	while (start <= max) {
>  		start = mb_find_next_zero_bit(bitmap, max + 1, start);
> @@ -6367,7 +6366,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  				break;
>  			count += next - start;
>  		}
> -		free_count += next - start;
>  		start = next + 1;
>  
>  		if (fatal_signal_pending(current)) {
> @@ -6381,8 +6379,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  			ext4_lock_group(sb, e4b->bd_group);
>  		}
>  
> -		if ((e4b->bd_info->bb_free - free_count) < minblocks)
> -			break;
>  	}
>  
>  	return count;
> -- 
> 2.20.1
> 


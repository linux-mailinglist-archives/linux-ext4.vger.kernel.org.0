Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E693B2BEA
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhFXJ5j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 05:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232179AbhFXJ5b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624528512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iTSSAgK7aaghb7ToUQUO/0vYqBsE2JOeFkxWgsEco9g=;
        b=gNTs9CmJO+TRe1dyQCDAsPsghzAwC7W6d29LJ1l29HMqCu4lB/3MvTpdkx8qO26iivj2zZ
        HrMpp3KvGyxcl4zg6tzxo3CZSnQzzlv7NpBr+vh2kSccxZZ5dVSDhKlR/xaCdJKpJwSaWf
        brnqcyTB7QbRM+88M5cy/tnFJbmLeKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-5SSWgA9GPSCnSLccV1-bUg-1; Thu, 24 Jun 2021 05:55:08 -0400
X-MC-Unique: 5SSWgA9GPSCnSLccV1-bUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D218C5EC2;
        Thu, 24 Jun 2021 09:55:07 +0000 (UTC)
Received: from work (unknown [10.40.193.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 549CF5C1BB;
        Thu, 24 Jun 2021 09:55:05 +0000 (UTC)
Date:   Thu, 24 Jun 2021 11:55:01 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [PATCH] ext4: use ext4_grp_locked_error in mb_find_extent
Message-ID: <20210624095501.jkd7iwu5bljw7xao@work>
References: <20210623232114.34457-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623232114.34457-1-stephen.s.brennan@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 23, 2021 at 04:21:14PM -0700, Stephen Brennan wrote:
> Commit 5d1b1b3f492f ("ext4: fix BUG when calling ext4_error with locked
> block group") introduces ext4_grp_locked_error to handle unlocking a
> group in error cases. Otherwise, there is a possibility of a sleep while
> atomic. However, since 43c73221b3b1 ("ext4: replace BUG_ON with WARN_ON
> in mb_find_extent()"), mb_find_extent() has contained a ext4_error()
> call while a group spinlock is held. Replace this with
> ext4_grp_locked_error.
> 
> Fixes: 43c73221b3b1 ("ext4: replace BUG_ON with WARN_ON in mb_find_extent()")
> Cc: <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>

Good catch, looks good to me.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

> ---
>  fs/ext4/mballoc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c2c22c2baac0..089c958aa2c3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1909,10 +1909,11 @@ static int mb_find_extent(struct ext4_buddy *e4b, int block,
>  	if (ex->fe_start + ex->fe_len > EXT4_CLUSTERS_PER_GROUP(e4b->bd_sb)) {
>  		/* Should never happen! (but apparently sometimes does?!?) */
>  		WARN_ON(1);
> -		ext4_error(e4b->bd_sb, "corruption or bug in mb_find_extent "
> -			   "block=%d, order=%d needed=%d ex=%u/%d/%d@%u",
> -			   block, order, needed, ex->fe_group, ex->fe_start,
> -			   ex->fe_len, ex->fe_logical);
> +		ext4_grp_locked_error(e4b->bd_sb, e4b->bd_group, 0, 0,
> +			"corruption or bug in mb_find_extent "
> +			"block=%d, order=%d needed=%d ex=%u/%d/%d@%u",
> +			block, order, needed, ex->fe_group, ex->fe_start,
> +			ex->fe_len, ex->fe_logical);
>  		ex->fe_len = 0;
>  		ex->fe_start = 0;
>  		ex->fe_group = 0;
> -- 
> 2.30.2
> 


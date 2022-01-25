Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBE949B534
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jan 2022 14:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbiAYNjB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jan 2022 08:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354498AbiAYNgT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Jan 2022 08:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643117776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYJzBr/Gnzr1F/U/C/od8YhWfQek25WEk/n1vGgEdv8=;
        b=Jc5BuNRoFVvfiOUlbs67c3cnUG0Tggf0PN17oL20ekDAif1r7+Tmuxc4GLgRPp6B+HhajA
        aMb/ji9VNoy4x0mVac1g9v55FGAg0oVjzR8xIpurukedXnKhdEMgx4y6sMnYn1yID7qjbm
        QtZCZ7OE2jwrf7SO1Q8B4GP3lcnadvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-PHbuR-4wMraAXPpE8XR5Ow-1; Tue, 25 Jan 2022 08:36:13 -0500
X-MC-Unique: PHbuR-4wMraAXPpE8XR5Ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E68926409A;
        Tue, 25 Jan 2022 13:36:11 +0000 (UTC)
Received: from work (unknown [10.40.194.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91EDA7BB5E;
        Tue, 25 Jan 2022 13:36:10 +0000 (UTC)
Date:   Tue, 25 Jan 2022 14:36:07 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: handle unsuccessful sbi allocation
Message-ID: <20220125133607.hioap2ggmiodmgr5@work>
References: <20220125130604.26473-1-amhamza.mgc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125130604.26473-1-amhamza.mgc@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We already have a patch to fix the problem on this list

https://lore.kernel.org/linux-ext4/20220119130209.40112-1-lczerner@redhat.com/T/#u

-Lukas

On Tue, Jan 25, 2022 at 06:06:04PM +0500, Ameer Hamza wrote:
> Move to common fail path in case of unsuccessful sbi allocation
> 
> Addresses-Coverity: 1497833 ("Unused value")
> 
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  fs/ext4/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 57914acc5402..0dccf1ed931b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5540,8 +5540,10 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
>  	int ret;
>  
>  	sbi = ext4_alloc_sbi(sb);
> -	if (!sbi)
> +	if (!sbi) {
>  		ret = -ENOMEM;
> +		goto free_sbi;
> +	}
>  
>  	fc->s_fs_info = sbi;
>  
> -- 
> 2.25.1
> 


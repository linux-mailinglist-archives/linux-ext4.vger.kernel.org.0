Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FA475872
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 13:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhLOMKv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 07:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242316AbhLOMKu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Dec 2021 07:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639570250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCstWBntwdLH8X6Z5denuskbx5Cw56Mw/cfPzBjOs48=;
        b=i0yaYJ7swpVEeoQTT/UL/9faObbnz99DcGZbdoTeftvhWKBtxYZA5/9iR5Yd0y4RXSkEv8
        nU6+iaQfk6N8bhpYlVja/Oxw7AK8CqbAhyTwrS46WM6yFccc/tc6uiFRjPWX+DCAbv76eF
        1GmyQ/rcHShOYShLRfO3AAXGuVsAM28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-CbljgMheOk-ZX6qOUdjv_A-1; Wed, 15 Dec 2021 07:10:44 -0500
X-MC-Unique: CbljgMheOk-ZX6qOUdjv_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A7F21052BAC;
        Wed, 15 Dec 2021 12:10:39 +0000 (UTC)
Received: from work (unknown [10.40.195.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8501B4299D;
        Wed, 15 Dec 2021 12:10:37 +0000 (UTC)
Date:   Wed, 15 Dec 2021 13:10:33 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: fix a copy and paste typo
Message-ID: <20211215121033.nclqc5b7qnterwek@work>
References: <20211215114309.GB14552@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215114309.GB14552@kili>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 02:43:09PM +0300, Dan Carpenter wrote:
> This was obviously supposed to be an ext4 struct, not xfs.  GCC
> doesn't care either way so it doesn't affect the build or runtime.

Wow, what a mistake. Nice catch, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Fixes: cebe85d570cf ("ext4: switch to the new mount api")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5ec5a1c3b364..da40fb468d7f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2077,7 +2077,7 @@ static void ext4_fc_free(struct fs_context *fc)
>  
>  int ext4_init_fs_context(struct fs_context *fc)
>  {
> -	struct xfs_fs_context	*ctx;
> +	struct ext4_fs_context *ctx;
>  
>  	ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
>  	if (!ctx)
> -- 
> 2.20.1
> 


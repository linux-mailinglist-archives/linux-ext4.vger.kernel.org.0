Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A353B795
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jun 2022 13:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiFBLE2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jun 2022 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiFBLE1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jun 2022 07:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D1B32985B5
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jun 2022 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654167865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/BxYhdats9FX/y5s+LZONrICs84U+s8H4jHtZ+BVTw=;
        b=QQahIoKF6ubaCK12rrc6Lduik1vJHMYJmSawm413Z7qmbbEtYn+9ApwhkvQEF68R60VXxV
        rAgks0rypg2Y9ZrgYAMm83PnQ4pB6vZKxPqZ5MO/z0DRomC6TYG4ESu2KxJtmx6Tf1z8na
        GxHaOxrPcFfIsSEdAayS2jtP5nHg2wo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-WF-kV4rlOD2jtpdWq-wftg-1; Thu, 02 Jun 2022 07:04:24 -0400
X-MC-Unique: WF-kV4rlOD2jtpdWq-wftg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51EAD80159B;
        Thu,  2 Jun 2022 11:04:24 +0000 (UTC)
Received: from fedora (unknown [10.40.193.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0EC0414A7E7;
        Thu,  2 Jun 2022 11:04:23 +0000 (UTC)
Date:   Thu, 2 Jun 2022 13:04:21 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Remove deprecated flag for noacl and noxattr_user
 mount options
Message-ID: <20220602110421.ymoug3rwfspmryqg@fedora>
References: <1654164099-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654164099-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 02, 2022 at 06:01:39PM +0800, Yang Xu wrote:
> Since kernel commit f70486055ee3 ("ext4: try to deprecate noacl and
> noxattr_user mount options"), we deprecated these two mount options
> because no other filesystem used the
> 
> But now, acl has been used by ext4 ext2 btrfs f2fs ocfs2 and noxattr_user
> has been used by ext4 ext2 f2fs ocfs2.

And many other fs don't have it. Is that your only reason for dropping
the deprecation? I can easily imagine that those fs got it because ext4
had it at the time.

Moreover the deprecation message has been there for 10 years, have we
seen anyone actually complaining that they want to keep it?

Why not to just remove the option. I don't have a strong opinion either
way, but it would be nice to remove stuff we don't need. Do you have a
use case for it? If not, can we make it Opt_removed?

-Lukas

> 
> I think it is time to remove deprecated flag for them.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/ext4/super.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 450c918d68fc..8a0cc8815ee7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2116,10 +2116,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		else
>  			return note_qf_name(fc, GRPQUOTA, param);
>  #endif
> -	case Opt_noacl:
> -	case Opt_nouser_xattr:
> -		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
> -		break;
>  	case Opt_sb:
>  		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
>  			ext4_msg(NULL, KERN_WARNING,
> -- 
> 2.23.0
> 


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29865D0CC
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 11:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjADKiZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 05:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjADKhw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 05:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714EA1EEDF
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 02:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672828618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CwhqqigE5nvXo1myo+FTZ+gb23VtgCqx7x+jZmp4wAM=;
        b=Cq1aREj72HC4KB6f/u0EEahOsFuikdtEOayfht/llcJE2H5y9byMQ0SyBirntwsiAMx2lw
        GaWshKqTr/JC7awV+HMMj64FgI8WhWixGtorAVCYDH6+KV7JXbiZT8HrXGsU7rj/U8Amhb
        ano/lLnEcq6UY94jTfahIGh6BuUkTM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-sHOaDi0dNPy2vLS93juNYw-1; Wed, 04 Jan 2023 05:36:55 -0500
X-MC-Unique: sHOaDi0dNPy2vLS93juNYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6F21101A52E;
        Wed,  4 Jan 2023 10:36:54 +0000 (UTC)
Received: from fedora (ovpn-192-227.brq.redhat.com [10.40.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A5C1C15BA0;
        Wed,  4 Jan 2023 10:36:53 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:36:51 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, Jeremy Bongio <bongiojp@gmail.com>
Subject: Re: [e2fsprogs PATCH] tune2fs: fix setting fsuuid::fsu_len
Message-ID: <20230104103651.eaxele7amb5t7tpu@fedora>
References: <20230104090401.276188-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104090401.276188-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:04:01AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Minus does not mean equals.
> 
> Besides fixing an obvious bug, this avoids the following compiler
> warning with clang -Wall:
> 
> tune2fs.c:3625:20: warning: expression result unused [-Wunused-value]
>                         fsuuid->fsu_len - UUID_SIZE;
>                         ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Fixes: a83e199da0ca ("tune2fs: Add support for get/set UUID ioctls.")
> Cc: Jeremy Bongio <bongiojp@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  misc/tune2fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 088f87e5..7937b8b5 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -3622,7 +3622,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
>  		ret = -1;
>  #ifdef __linux__
>  		if (fsuuid) {
> -			fsuuid->fsu_len - UUID_SIZE;
> +			fsuuid->fsu_len = UUID_SIZE;
>  			fsuuid->fsu_flags = 0;
>  			memcpy(&fsuuid->fsu_uuid, new_uuid, UUID_SIZE);
>  			ret = ioctl(fd, EXT4_IOC_SETFSUUID, fsuuid);
> -- 
> 2.39.0
> 


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB0465D09A
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 11:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjADK0t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 05:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjADK0k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 05:26:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94A1EC69
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 02:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672827943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwAjCOHPSBqaqr/AiZuMi4VBeUfK45lY0heglu3BM+A=;
        b=ac0hLvS3PuoOr/JmcVjF24LnO6Rfb9e2QsdIIr/WRVIB8Llm8KtiFjI51j1FzbW93k0btS
        vX91jIlagOs2wvfKWSMy2TIpOazPkamegUAju+GHI9+5kiCp6+PyfWLxuX+XFQYm0C/crG
        KE74SOLOm+0l4hiLql1vuwacaynrZqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-Yw8Jff53NbaC60E8IX3zzA-1; Wed, 04 Jan 2023 05:25:41 -0500
X-MC-Unique: Yw8Jff53NbaC60E8IX3zzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A29B1801779;
        Wed,  4 Jan 2023 10:25:41 +0000 (UTC)
Received: from fedora (ovpn-192-227.brq.redhat.com [10.40.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2554C51E5;
        Wed,  4 Jan 2023 10:25:41 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:25:38 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] libsupport: remove unused label in
 get_devname()
Message-ID: <20230104102538.bbttn6is7w6gdsbo@fedora>
References: <20230104090341.276131-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104090341.276131-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:03:41AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Address the following compiler warning with gcc -Wall:
> 
> devname.c: In function ‘get_devname’:
> devname.c:61:1: warning: label ‘out_strdup’ defined but not used [-Wunused-label]
>    61 | out_strdup:
>       | ^~~~~~~~~~

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> 
> Cc: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/support/devname.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/support/devname.c b/lib/support/devname.c
> index 8c2349a3..e0306ddf 100644
> --- a/lib/support/devname.c
> +++ b/lib/support/devname.c
> @@ -58,7 +58,6 @@ char *get_devname(blkid_cache cache, const char *token, const char *value)
>  		goto out;
>  	}
>  
> -out_strdup:
>  	if (is_file)
>  		ret = strdup(token);
>  out:
> -- 
> 2.39.0
> 


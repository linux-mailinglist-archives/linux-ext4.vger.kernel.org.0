Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01047A7B5
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhLTKYb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Dec 2021 05:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231187AbhLTKYb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Dec 2021 05:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639995870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jcl4IHN1NmVN0r+cqE4qVTHayHJNhn5iGPNjM0W4Lb4=;
        b=hmqOskZxatKaGIq9Tq4YGBNMC3mdp+znW9pwtu0wjYZgcnEBrNiL/IHG/cjkisNQcHooBp
        Ju9VuDMFUBHRLwfSJibZBN9iIy/25zy6My4YVf6XHHVSiCJ1xM7BJ0tjXniM37N9bGyaGC
        sqxr1ysmQ30JvIgnquqH4p+hVwEVQzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61--MZIwZZbN6yt99o6PChGpQ-1; Mon, 20 Dec 2021 05:24:28 -0500
X-MC-Unique: -MZIwZZbN6yt99o6PChGpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF42E64083;
        Mon, 20 Dec 2021 10:24:26 +0000 (UTC)
Received: from work (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FC4E78DE5;
        Mon, 20 Dec 2021 10:24:23 +0000 (UTC)
Date:   Mon, 20 Dec 2021 11:24:21 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     cgel.zte@gmail.com
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] fs/ext4: use BUG_ON instead of if condition
 followed by BUG
Message-ID: <20211220102421.sggplg54ncsafcpi@work>
References: <20211219130643.462943-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219130643.462943-1-xu.xin16@zte.com.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 19, 2021 at 01:06:43PM +0000, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> BUG_ON would be better.

Indeed. Thanks for the patch.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal robot <zealci@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  fs/ext4/ext4.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9cc55bcda6ba..00bc3f67d37f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2400,8 +2400,7 @@ ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
>  
>  static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
>  {
> -	if ((len > blocksize) || (blocksize > (1 << 18)) || (len & 3))
> -		BUG();
> +	BUG_ON((len > blocksize) || (blocksize > (1 << 18)) || (len & 3));
>  #if (PAGE_SIZE >= 65536)
>  	if (len < 65536)
>  		return cpu_to_le16(len);
> -- 
> 2.25.1
> 


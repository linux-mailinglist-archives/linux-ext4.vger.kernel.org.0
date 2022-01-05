Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB3484F7F
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jan 2022 09:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiAEIpT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 03:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232888AbiAEIpT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 03:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641372318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Nmk0+RJqmy7E2he01SlTfxHa3sjr20AuFEXxs1SRto=;
        b=bkbiuGNuQRhDlmigEdLHkvdTA8NS6/eMMdAMzDvNwrV4Hj84RB0nONu2Hv3EVpD2Z81sxr
        hJ66aUwBO/DqYbIM6YdO/jU3qA5+u21JeUmtw53wg2xdMd8rnGxzZjY8Vvbmg2yk1nWd6W
        OrYWgV5K4COR/7BrBLBvbXhPjqjW2Fc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-0b2nmbGlNFCvExCNF4zHqg-1; Wed, 05 Jan 2022 03:45:15 -0500
X-MC-Unique: 0b2nmbGlNFCvExCNF4zHqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E45A1006AA8;
        Wed,  5 Jan 2022 08:45:14 +0000 (UTC)
Received: from work (unknown [10.40.194.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E6435E48C;
        Wed,  5 Jan 2022 08:45:13 +0000 (UTC)
Date:   Wed, 5 Jan 2022 09:45:09 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH] ext4: Simplify !page_bufs logic with simple BUG_ON()
Message-ID: <20220105084509.d7gptudqulyjvhiq@work>
References: <20211228073252.580296-1-xu.xin16@zte.com.cn>
 <4088b190f4367763c447f22e39ecb35de324f19e.1641371169.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4088b190f4367763c447f22e39ecb35de324f19e.1641371169.git.riteshh@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 05, 2022 at 02:06:56PM +0530, Ritesh Harjani wrote:
> Simplify !page_bufs logic with simple BUG_ON().

Looks good, thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> Noticed a bug_on() related patch while reviewing, hence felt, this
> below trivial change could be included along with it.
> 
>  fs/ext4/inode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bfd3545f1e5d..5656b4a9007b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1879,10 +1879,7 @@ static int __ext4_journalled_writepage(struct page *page,
>  			goto out;
>  	} else {
>  		page_bufs = page_buffers(page);
> -		if (!page_bufs) {
> -			BUG();
> -			goto out;
> -		}
> +		BUG_ON(!page_bufs);
>  		ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
>  				       NULL, bget_one);
>  	}
> --
> 2.31.1
> 


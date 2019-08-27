Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB989F492
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfH0Uys (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 16:54:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35985 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0Uys (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Aug 2019 16:54:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so496871qtc.3;
        Tue, 27 Aug 2019 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KWbFURB61/lWAVFSnEsUC28SV9DvkqEr5tllt6yvTiY=;
        b=OZ6xFV/SEt92Ly6JN/1OKdHAGx7HvxRDHWW+T5X83Kxk6NiMQ4SWxgdae0ZPhc8zgi
         4pCJO5rrmixT5YUdplTZifYcQgohc2JijaA3xkN01ZJYbg6GZqFWtLbbWNT7FN3xJXSK
         V22MtiA0yg4epbWt6GQIWRxPl+zeYxmO6Wf6ODZf9rMomZAxY24aO1Zd16jYU5AUZrJp
         A8Y7SYYX5W01uN4DeLiWnAVnkNxpx6y37O2iVxkrZyKLPJ9Nuh7iGaFIyGgG7eLYnAMf
         EQa0MRj19D1PPtTkWLiG4fgcx+y5Swm4MdVTyW2gRVgBNeEj13/5Mq8UWQUrVJI1tl9X
         uBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KWbFURB61/lWAVFSnEsUC28SV9DvkqEr5tllt6yvTiY=;
        b=QxxzQVWfsmvF0Tf5TkDbEoTm2FfqkJYSSLt4B1eIw7GYzVfbIwJ8H624bKXxX4R8AD
         ET2h+B30+W7q9okEjyCHnkpKvupP2ODQ3bFmgQpF8WOwlkcWs7rO+/xJBEwh88t4yQRd
         Y8xPtUxUSwY9GJTTe26QtBn8pGdy18vDiDuemv6TK69tFeiXKfl30+En3rk3TEyUkNmk
         nG0RxxRKwtja3MSFkpm50uN/yD6xThckbL+W9UQHVA8RZdzfdNbkiI7DjJfEfeFeRo9q
         PT4ZSkqzxDHAWJAT7XyF8qVjFjdWSqsTmmk/WmpETKKVXhZs9Lh7OLqZHdD847+M9RhY
         aVzA==
X-Gm-Message-State: APjAAAU0biaJCHkjCsfarg/Fmzcg/UyMxeO83gOq4wdUoY7JS0uH1ZJJ
        Bi1EGOw/TRfbTaI8VmgGWno=
X-Google-Smtp-Source: APXvYqzysEHZCwbe6uzTwLs8CI6Fhv6YgJbv6827n6K7nE9WtDfokwg3gau0xYJ+chkpDyXbvVNOPw==
X-Received: by 2002:ac8:6146:: with SMTP id d6mr937546qtm.36.1566939287696;
        Tue, 27 Aug 2019 13:54:47 -0700 (PDT)
Received: from rocky (63-235-172-154.dia.static.qwest.net. [63.235.172.154])
        by smtp.gmail.com with ESMTPSA id i8sm278952qkm.46.2019.08.27.13.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 13:54:47 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
X-Google-Original-From: Eric Whitney <enw.linux@gmail.com>
Date:   Tue, 27 Aug 2019 16:54:45 -0400
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Eric Whitney <enwlinux@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: tidy up white space in count_rsvd()
Message-ID: <20190827205445.3gtjyktwitgnbzx4@rocky>
References: <20190827084725.GA22301@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827084725.GA22301@mwanda>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Dan Carpenter <dan.carpenter@oracle.com>:
> This line was indented one tab too far.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch, thanks.  You can add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>

> ---
>  fs/ext4/extents_status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index dc28a9642452..f17e3f521a17 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1089,7 +1089,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	 */
>  	if ((i + sbi->s_cluster_ratio - 1) <= end) {
>  		nclu = (end - i + 1) >> sbi->s_cluster_bits;
> -			rc->ndelonly += nclu;
> +		rc->ndelonly += nclu;
>  		i += nclu << sbi->s_cluster_bits;
>  	}
>  
> -- 
> 2.20.1
> 

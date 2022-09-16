Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF195BACD1
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Sep 2022 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiIPL4s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Sep 2022 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiIPL4r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Sep 2022 07:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A61AF483
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663329404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chTOa9nfsN85Mo0aKyNtpBSHWBBmRSbzW50vElTD5ws=;
        b=UKun8Ewy1oTFH7z+6pR3ovwkjbeMs+vsG3TZfRUu6q6jVKRI8mpY+lgKtZWaoTLYTgYzEZ
        6/1OdYRI+dSCDLCY+9pioPBvtyeO0vEOodJbFZudgGd8qhcJ2HK+MffhzHWP0Y/EmRTYFb
        EeXDqrzfYjvaDbkR7xtyYP16LqEnKN4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-5u09khYCMP2OxKJ63xuN3w-1; Fri, 16 Sep 2022 07:56:43 -0400
X-MC-Unique: 5u09khYCMP2OxKJ63xuN3w-1
Received: by mail-qt1-f198.google.com with SMTP id d20-20020a05622a05d400b00344997f0537so17015696qtb.0
        for <linux-ext4@vger.kernel.org>; Fri, 16 Sep 2022 04:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=chTOa9nfsN85Mo0aKyNtpBSHWBBmRSbzW50vElTD5ws=;
        b=qXB9AIMfHoaKdSSyPGoj/qCw6Mg3SZREXdfFaZkTIXWZ2mptLOH7JTlBdutEipCQFz
         gvzJcvbAYpjpO3zvtbbE+S7Aupki5C63gspqYtbVy36NNRkEcsAEEu2DrpANMo+N7l1J
         HwbV0QZLBqmwa+64polh/xNh9s9lWF+mNeMslJJg2QWl4M77ZAsLzsY1a9mU5VdxkqQT
         9kxArj77BCF/Afipx+CWqBp8eiAFMI88Jgv+nMnkR8kboDmsapeDLWcTLEa2BOcYH9ZT
         Gk2On4MzwqJ6r0NVr5/WumaFyldrKeIXffI3/EKDtNk6NHxAiQIxSQq8JbBeHri8Vzti
         /WEg==
X-Gm-Message-State: ACrzQf2slVDsAVypcMD1aWfPgq4FBdtfPVuWTbZp7RfcS7FXovF0gA0A
        AL4kq9PCOVk3SSJm1z1BKV4NZuud9B5iZCCvfu9M1xcsyEqiiMgIeKj9fi1KakrIqQx4XezCUTr
        hHSMAf0SogvARypQfucanqA==
X-Received: by 2002:a05:622a:1a96:b0:35b:b868:fb1 with SMTP id s22-20020a05622a1a9600b0035bb8680fb1mr3907090qtc.116.1663329403274;
        Fri, 16 Sep 2022 04:56:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61rQguxip3VopENuW5BChfGUPbrsDyfGFwkeqvgW8D2mtv8HxW9f+7RmfWCZydcsFZ19h22g==
X-Received: by 2002:a05:622a:1a96:b0:35b:b868:fb1 with SMTP id s22-20020a05622a1a9600b0035bb8680fb1mr3907066qtc.116.1663329403013;
        Fri, 16 Sep 2022 04:56:43 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a20d000b006b95b0a714esm5498036qka.17.2022.09.16.04.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 04:56:42 -0700 (PDT)
Date:   Fri, 16 Sep 2022 07:56:39 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyRkd8YAH1lal8/N@bfoster>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-5-sarthakkukreti@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> sends a hint to (supported) thinly provisioned block devices to
> allocate space for the given range of sectors via REQ_OP_PROVISION.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/fops.c                | 7 ++++++-
>  include/linux/falloc.h      | 3 ++-
>  include/uapi/linux/falloc.h | 8 ++++++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index b90742595317..a436a7596508 100644
> --- a/block/fops.c
> +++ b/block/fops.c
...
> @@ -661,6 +662,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
>  					     len >> SECTOR_SHIFT, GFP_KERNEL);
>  		break;
> +	case FALLOC_FL_PROVISION:
> +		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> +					       len >> SECTOR_SHIFT, GFP_KERNEL);
> +		break;
>  	default:
>  		error = -EOPNOTSUPP;
>  	}

Hi Sarthak,

Neat mechanism.. I played with something very similar in the past (that
was much more crudely hacked up to target dm-thin) to allow filesystems
to request a thinly provisioned device to allocate blocks and try to do
a better job of avoiding inactivation when overprovisioned.

One thing I'm a little curious about here.. what's the need for a new
fallocate mode? On a cursory glance, the provision mode looks fairly
analogous to normal (mode == 0) allocation mode with the exception of
sending the request down to the bdev. blkdev_fallocate() already maps
some of the logical falloc modes (i.e. punch hole, zero range) to
sending write sames or discards, etc., and it doesn't currently look
like it supports allocation mode, so could it not map such requests to
the underlying REQ_OP_PROVISION op?

I guess the difference would be at the filesystem level where we'd
probably need to rely on a mount option or some such to control whether
traditional fallocate issues provision ops (like you've implemented for
ext4) vs. the specific falloc command, but that seems fairly consistent
with historical punch hole/discard behavior too. Hm? You might want to
cc linux-fsdevel in future posts in any event to get some more feedback
on how other filesystems might want to interact with such a thing.

BTW another thing that might be useful wrt to dm-thin is to support
FALLOC_FL_UNSHARE. I.e., it looks like the previous dm-thin patch only
checks that blocks are allocated, but not whether those blocks are
shared (re: lookup_result.shared). It might be useful to do the COW in
such cases if the caller passes down a REQ_UNSHARE or some such flag.

Brian

> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b1675..a0e506255b20 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -30,7 +30,8 @@ struct space_resv {
>  					 FALLOC_FL_COLLAPSE_RANGE |	\
>  					 FALLOC_FL_ZERO_RANGE |		\
>  					 FALLOC_FL_INSERT_RANGE |	\
> -					 FALLOC_FL_UNSHARE_RANGE)
> +					 FALLOC_FL_UNSHARE_RANGE |                          \
> +					 FALLOC_FL_PROVISION)
>  
>  /* on ia32 l_start is on a 32-bit boundary */
>  #if defined(CONFIG_X86_64)
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6c..2d323d113eed 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,12 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> + * blocks for the range/EOF.
> + *
> + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> + */
> +#define FALLOC_FL_PROVISION		0x80
> +
>  #endif /* _UAPI_FALLOC_H_ */
> -- 
> 2.31.0
> 


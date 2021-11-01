Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2246441E26
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Nov 2021 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhKAQbQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Nov 2021 12:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232559AbhKAQbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Nov 2021 12:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635784122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSSeiEsgy4ZRAwPPYMh123Zf4LHs8XHr2NNVii6Qq7o=;
        b=AvCPbg1FTPfLMjWc7ypl3iG98diUCbhNwGIK33qkzkphpEsehtLzuq/IYpiYpQgrCy2L7+
        c3v1KDixloqG3Ng3ccyy3cjQGIe8vA5LCddSAnMrItTSCPBgIsoibsijzZcddq7PkRalMS
        2V2TvGAHoAUFgWvumnraXAfhel7N1zI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-0-JmEKcUPt6DOiSscePwyA-1; Mon, 01 Nov 2021 12:28:41 -0400
X-MC-Unique: 0-JmEKcUPt6DOiSscePwyA-1
Received: by mail-qt1-f198.google.com with SMTP id x28-20020ac8701c000000b0029f4b940566so12395337qtm.19
        for <linux-ext4@vger.kernel.org>; Mon, 01 Nov 2021 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vSSeiEsgy4ZRAwPPYMh123Zf4LHs8XHr2NNVii6Qq7o=;
        b=lArBK+U3kK2epwvHzkJ7HjOMSpJSzrwCo4pghw3m9SqzLkSklvOo4s857+BXrPd9/K
         KW91tnmH90MBp3F5LATV08ERDAhSm5teVKoneZH2GUCqDBtBDfS07mmVGVT4u0lDhFyX
         V8AuTi7EvafKhuT8dMxviCNri3kSjaxXrAllyVAT7wdf1js7ggaIq1LAeZ9pW+w+aNr0
         hPE3b19QjFc0sgyv5wMkJ4tPjz3RI9UEBDcTxQfxtfDb8AbxpFTXXlMamHrczDSSEuy+
         o/c4zlHug4cbaL/R9NCPVMOvV/PpiPEJVLcr8Dgviimkyv3zUqqjeqn7HGhuo33z+gSH
         L7+w==
X-Gm-Message-State: AOAM533ZxJ076D7U4ENERiFFwMxRa05zACPUC7lSmIw9+AS0wOdD1L18
        1AMfoRhLUgACq4mzZoZCYnGTWfSPTXzVxjaiuHRCp2w8pxTPNKLMm1A59ssffkd1Z4T5bQ/UL+7
        h4PaTHEsQdsVD45LbyGtT
X-Received: by 2002:a05:6214:e4a:: with SMTP id o10mr29863862qvc.58.1635784120281;
        Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnnToYfIdlwewHO/8stJwOwIrIwZDJizj1Vl7BOinzg8bNzbcfCyJ9R9K4APUV9a9jX59VOw==
X-Received: by 2002:a05:6214:e4a:: with SMTP id o10mr29863844qvc.58.1635784120140;
        Mon, 01 Nov 2021 09:28:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u185sm10250817qkd.48.2021.11.01.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:28:39 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:28:38 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 03/11] dax: simplify the dax_device <-> gendisk
 association
Message-ID: <YYAVtv6kiqVHDjQH@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018044054.1779424-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 18 2021 at 12:40P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Replace the dax_host_hash with an xarray indexed by the pointer value
> of the gendisk, and require explicitl calls from the block drivers that
> want to associate their gendisk with a dax_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 79737aee516b1..a0a4703620650 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1683,6 +1683,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  	bioset_exit(&md->io_bs);
>  
>  	if (md->dax_dev) {
> +		dax_remove_host(md->disk);
>  		kill_dax(md->dax_dev);
>  		put_dax(md->dax_dev);
>  		md->dax_dev = NULL;
> @@ -1784,10 +1785,11 @@ static struct mapped_device *alloc_dev(int minor)
>  	sprintf(md->disk->disk_name, "dm-%d", minor);
>  
>  	if (IS_ENABLED(CONFIG_FS_DAX)) {
> -		md->dax_dev = alloc_dax(md, md->disk->disk_name,
> -					&dm_dax_ops, 0);
> +		md->dax_dev = alloc_dax(md, &dm_dax_ops, 0);
>  		if (IS_ERR(md->dax_dev))
>  			goto bad;
> +		if (dax_add_host(md->dax_dev, md->disk))
> +			goto bad;
>  	}
>  
>  	format_dev_t(md->name, MKDEV(_major, minor));

Acked-by: Mike Snitzer <snitzer@redhat.com>


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C8F441DC7
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Nov 2021 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhKAQPb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Nov 2021 12:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232473AbhKAQPa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Nov 2021 12:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
        b=OSGCzH7a9iwXipiTHXUGo0ViW4DQj+HOpxAD9jdj6SQT3OMsIMINUJqLIoxrv37CEdPivy
        BBYalGl+Hf/j1rPWI5ToSbwXQmb4zIXtemJC726Rt+HykiFddlTIctqsfIt08KH+Wtk5NW
        nmF8FM6EQKMZHFJ7vPOmuIz1BuWLhjk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-0GLPwWQTMna7XjhO0hxNlw-1; Mon, 01 Nov 2021 12:12:55 -0400
X-MC-Unique: 0GLPwWQTMna7XjhO0hxNlw-1
Received: by mail-qk1-f199.google.com with SMTP id bq14-20020a05620a468e00b0046335b327e9so1089519qkb.23
        for <linux-ext4@vger.kernel.org>; Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
        b=3WGREOHrxQqfRiUMWa/xGCi0FjoKuJhljotepDBEy0kaFoRlm3hva49kiwEnmRr3Hd
         iETVyKCOeXhDCdhX7OBAbIXNFuF2q9c08vjIn/O9tBJF3HxahdSj+3pdQH7my0md3IMF
         PQgA22YXWJZ0NKfNRpjYGnZvOQj5L8fWLV1z/WmjaB1Uct66ZLcE1LImSjM8+CHD1Otf
         G+Uj0yYm2PYZJA51t75xdi5/rIF2Ov8PomFZdc8irIBPk2avEbGQVmsKZLRGljg/NvSK
         nNo9UMlToLBAIKvg8KQXs/LXVEAc+LAdYq3CCarq2LKctrKXR56p6jRwMypKntMlE3ow
         HgCg==
X-Gm-Message-State: AOAM530BHQ8wh4j65OuvmBhkMOccZEBl7/4HAYP7PXOtte6S3E+yHEsP
        QqZdRjHf28OOlYxOc1YTITTlnBWPaxjQ4SzYbPMj1OTjjulK60OmpJEuebdRJEO8gGzMe98VBLe
        RCZ2CE5iQDGjWMCY0QMfS
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264790qvn.62.1635783175416;
        Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/H7B1fdn7PP13//AwKmpta1av9FRTtOajPRoBskVHgoJcCnXd+0D44u/s4udzcALoTqA+Rw==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264758qvn.62.1635783175189;
        Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v16sm167031qtw.90.2021.11.01.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:12:54 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:12:53 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
Message-ID: <YYASBVuorCedsnRL@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-2-hch@lst.de>
 <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 27 2021 at  4:53P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The device mapper DAX support is all hanging off a block device and thus
> > can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> > of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> > be built under CONFIG_FS_DAX now.
> 
> Looks good.
> 
> Mike, can I get an ack to take this through nvdimm.git? (you'll likely
> see me repeat this question on subsequent patches in this series).

Sorry for late reply, but I see you punted on pushing for 5.16 merge
anyway (I'm sure my lack of response didn't help, sorry about that).

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks!


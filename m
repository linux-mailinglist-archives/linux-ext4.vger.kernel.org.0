Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD5A25125
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfEUNvk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 09:51:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39233 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfEUNvj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 May 2019 09:51:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so20540753qtk.6
        for <linux-ext4@vger.kernel.org>; Tue, 21 May 2019 06:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TK1+q9ordzXuZZneT1jdBLnWaxfhFR3So8YN5DgmZPE=;
        b=snkZOpTOTQ+hPcANbq2MSbB5Y8/Je8xB4Xk07wH2bEtdjUbCMinHmodfrGRC6qPrcf
         G/ckBFkmxK5cgbQGhMOwCRupn2u/MZVNgLR045OnpGr/glAplVJPXGutx6UvSGaAVaVS
         2S3mVspVl3f+21C26KMwljuy9K38v3QJSkeWVoHik4cua1r6AS8tuxPPG8GUMxcJk36D
         ZXU1jwsVCdd0fipXE1707LwqoSUMqgESkEsYxIlfiYpKPRc0s48jUZL7GxUcS0uIrjfE
         BqWSK7qicTTVv3oGn0IgxDoLQb+scBONb99OOswHaNif1Gknuxb6+892D2FnuGzu8j0P
         25xQ==
X-Gm-Message-State: APjAAAU5eIiLWYblDd1opxIrkqDCPuWds6+OACdKycITDGaTzViq0iiq
        79GwdrIZSS/515hWBIxjD+Vl6wKPR14=
X-Google-Smtp-Source: APXvYqyh4Hn5uFOLIUZJ6Or+HOPTIpSiSFn1uSWJgwWbt4T3Cy3pGgBfYiLTVuICBM9UJLxQWjWXvw==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr28772252qtn.177.1558446698964;
        Tue, 21 May 2019 06:51:38 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id q27sm13106373qtf.27.2019.05.21.06.51.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 06:51:37 -0700 (PDT)
Date:   Tue, 21 May 2019 09:51:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com,
        dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pbonzini@redhat.com,
        yuval.shaia@oracle.com, kilobyte@angband.pl, jstaron@google.com,
        rdunlap@infradead.org, snitzer@redhat.com
Subject: Re: [PATCH v10 2/7] virtio-pmem: Add virtio pmem driver
Message-ID: <20190521094543-mutt-send-email-mst@kernel.org>
References: <20190521133713.31653-1-pagupta@redhat.com>
 <20190521133713.31653-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521133713.31653-3-pagupta@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 21, 2019 at 07:07:08PM +0530, Pankaj Gupta wrote:
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..7a3e2fe52415
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Definitions for virtio-pmem devices.
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * Author(s): Pankaj Gupta <pagupta@redhat.com>
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/types.h>
> +#include <linux/virtio_types.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +
> +struct virtio_pmem_config {
> +	__le64 start;
> +	__le64 size;
> +};
> +

config generally should be __u64.
Are you sure sparse does not complain?


> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +
> +struct virtio_pmem_resp {
> +	/* Host return status corresponding to flush request */
> +	__virtio32 ret;
> +};
> +
> +struct virtio_pmem_req {
> +	/* command type */
> +	__virtio32 type;
> +};
> +
> +#endif
> -- 
> 2.20.1

Sorry why are these __virtio32 not __le32?

-- 
MST

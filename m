Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699853F8BAE
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhHZQUn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 12:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233548AbhHZQUn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 26 Aug 2021 12:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629994795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/3gAXjsOYCjvInZsh1tv7Gv6tJXcvyBWH3X0vwJBWc=;
        b=cFJHnME0l/IGCqezr+KzoIHpIBORymVeRE+sccZn0+fKjOHfP4HREMKbRyjwTn4DZgmsCX
        lbl9w0TioeT9QhIQRunT4fKTmrmBXY3Nz89xn+H4hTw9UIjX2Fn4yzbAlVmhqbTJHKjdZG
        8sY0+NH+2oHhKyjF00sRIQrnSpwPkI0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-nNit-7EAPBqqw77pfvIqYQ-1; Thu, 26 Aug 2021 12:19:52 -0400
X-MC-Unique: nNit-7EAPBqqw77pfvIqYQ-1
Received: by mail-qk1-f199.google.com with SMTP id 21-20020a370815000000b003d5a81a4d12so177626qki.3
        for <linux-ext4@vger.kernel.org>; Thu, 26 Aug 2021 09:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7/3gAXjsOYCjvInZsh1tv7Gv6tJXcvyBWH3X0vwJBWc=;
        b=l86V9KrOISmX0I0RPhuNRe8XxupxmvGPLVwLmK86SLDRmoW1Pa25HRkr425En/w8gv
         CytzRdbHwkGMUhVc/e/2304HHdjpMYsVAkD4JwlZ7CevIC6bUJUhjjeLhcV6FJTjtJeV
         XbRndlytAOVSPQH8TiqpmcfDKgKeNZXtbvFNSCVr/jvpEqnFwxzxzCWKtsRtMX+eDfWL
         L4AfDIfSZ6vV/3HKlKB/+jbrxjrUMCC7FGoX+8mmY5GuNa/fvTVeSvpu2d9kS4mOVvyt
         ZtT11hgZ8L+ZMF3V3VmjA+p0VozLr0W89NvV8Lg5jq4pJVsUfArqhHso2jKL46E33FIo
         syJg==
X-Gm-Message-State: AOAM532vOnxW1JlX930c4RaNQTX9HZtM7o+icmq4PHB+jhUGEB0s3hy5
        JcDBWlILpj+O/UWTPSgr61/6TqW8g/gyc8MLvWWMBTRxoQcdbjr5JzMhpqTyCO2MLVmD3fLmp09
        LIuZ4hr7Ny0UijyOQmobR
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4123802qtp.34.1629994791990;
        Thu, 26 Aug 2021 09:19:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJjb+DXO5M4rPM3LGWmmf30ajsbDc366at2OsGm2R0vZu/YOovqERPcrnuHp7PIFCzTyaymQ==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4123780qtp.34.1629994791782;
        Thu, 26 Aug 2021 09:19:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m8sm2619535qkk.130.2021.08.26.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 09:19:51 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:19:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/9] dm: use fs_dax_get_by_bdev instead of dax_get_by_host
Message-ID: <YSe/JtXqoiHsRGqX@redhat.com>
References: <20210826135510.6293-1-hch@lst.de>
 <20210826135510.6293-4-hch@lst.de>
 <CAPcyv4ieXdjgxE+PkcUjuL7vdcnQfXhb_1aG2YeLtX9BZWVQfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ieXdjgxE+PkcUjuL7vdcnQfXhb_1aG2YeLtX9BZWVQfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 26 2021 at 10:42P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Aug 26, 2021 at 6:59 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > There is no point in trying to finding the dax device if the DAX flag is
> > not set on the queue as none of the users of the device mapper exported
> > block devices could make use of the DAX capability.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/md/dm.c | 2 +-
> 
> Mike, any objections to me taking this through a dax branch?

No.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

Thanks.


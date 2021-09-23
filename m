Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A759D41557F
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Sep 2021 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhIWCsv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Sep 2021 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbhIWCsu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Sep 2021 22:48:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0A1C061756
        for <linux-ext4@vger.kernel.org>; Wed, 22 Sep 2021 19:47:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso3866577pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 22 Sep 2021 19:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agoq3Fxpf+zW/Ee2I2bgAzZKmWuzEcBcM6Muz18xBqA=;
        b=nArOwzsUXZXiLe4TziLWZHrpKd/FHn28RSC5txzbzzV63fl08WSYEZJk5Co82LRG5B
         Od3/IPPQ6Z/J1EOCZDk+ArlrvAQS4I0GbZkqIxZtvILtaZl1vD/+qdjZ+4huB5tDIWJc
         jDzYkhYFe5ongcQ3TG/5wWuUfcEmG4VtpHRBJp/BvRKamoZUnqauDwpgPq3t7xjETL+t
         Tn6gclF7CmkQc2CvjxCveFNbleM1amUDpI16LpYb0LiUdE5HvhsNI+ohqhldjBapX8+2
         nRT4eUFUoQMb3Vrq17ICqZv6+9EnZ+zfqDpWQJxewiTkEL8jHvchW0BA/5oklVfiST1w
         A2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agoq3Fxpf+zW/Ee2I2bgAzZKmWuzEcBcM6Muz18xBqA=;
        b=kSuMDCD/+r6+5VhN4RsOWDi8P8Yz71n6oiKcKn9Cgh9xgJHYH8yLfgGE5LfNMM3HQD
         4Bknz/M1T5CDgkwmFGueskKbLkCHHRz9sxBXtaLAP3zNbMtODDCgzMoIBxvwW9QRZOvC
         JqFv6vuo6rO11CZ6SSbfn221V99pGDweSkTTaTAz+BjMsGzExn5yjh+GQZXWmzeEgX7C
         OAidRASg37k36FV6InmFqKuFrYBvX80M3gZ5llnSQpw2mVCF0J+7F5Nt0EcNxAtPafT+
         z1Qm6tX4m5ZB2HWTrxp+5SQpfAr/6bS1CptPcTdtIn3cbsxyjdYLW/k2C59YB2J4Bw0B
         2+Lw==
X-Gm-Message-State: AOAM5313k3dfkvKmjZiZdPKKHIg9Za22zZ3EcltFetrLF7FJ9bAovcZS
        Z6q/WIG0uRBoInbAeMOXQHk/g8dr6Okx3xRHIkiB9A==
X-Google-Smtp-Source: ABdhPJxHihhVA4u7nhquDosGs4ysGyAjAjUQ2tJKKYjWJpFwQBjiy7jfO5CRdxC27m6u5DJu3irBHSwc4NJg+F940dk=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr2084104pls.89.1632365239539; Wed, 22
 Sep 2021 19:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210923010915.GQ570615@magnolia>
In-Reply-To: <20210923010915.GQ570615@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Sep 2021 19:47:08 -0700
Message-ID: <CAPcyv4i5xYHFkW55eGi8L6mfoPwuMhcH3eFhDTAqzrTNvwTt4A@mail.gmail.com>
Subject: Re: [PATCH] dax: remove silly single-page limitation in dax_zero_page_range
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 22, 2021 at 6:09 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> It's totally silly that the dax zero_page_range implementations are
> required to accept a page count, but one of the four implementations
> silently ignores the page count and the wrapper itself errors out if you
> try to do more than one page.
>
> Fix the nvdimm implementation to loop over the page count and remove the
> artificial limitation.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  drivers/dax/super.c   |    7 -------
>  drivers/nvdimm/pmem.c |   14 +++++++++++---
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index fc89e91beea7..ca61a01f9ccd 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -353,13 +353,6 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  {
>         if (!dax_alive(dax_dev))
>                 return -ENXIO;
> -       /*
> -        * There are no callers that want to zero more than one page as of now.
> -        * Once users are there, this check can be removed after the
> -        * device mapper code has been updated to split ranges across targets.
> -        */

It's device-mapper that's the issue, you need to make sure that every
device-mapper zero_page_range implementation knows how to route a
multi-page operation. This is part of the motivation to drop that
support and move simple concatenation and striping into the PMEM
driver directly.

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5159543D631
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 00:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhJ0WF4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhJ0WFz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 18:05:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184AC061767
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 15:03:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3168027pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4Hx7HuIToogFrpWvEndnhmu5FP0FfguH4MlN11vPPE=;
        b=r4O7O+D6bqWhbnfNK8GAK+O+V51sL8gQ71rKDmnAA3fZ320ss8g64pT5I4bw0Ty2W9
         TGiVpZlytWCPvqsnO2KP5mgjcvtWG32bPlTJSiDywz2eUzvbv14zKkXGrmqra8bYuVcX
         6eTzntuayCoe6FMfUlwppg7wtXGYJnRCccwyOD6BMW/cCSj5855vgtn7jPyqngLiNh96
         igHjZ8TKVN2e2xQDd7pHeELmJKOPqBo/gYXXJPRXVsdlZBFwujavWR+bA+YkVqvY/M8E
         xiafLQkvUuEAFIkRuAHaQc3YSU7PAJiw0NjeujUUWeonnrpA4patIFL2eOziiAOc+jWH
         kG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4Hx7HuIToogFrpWvEndnhmu5FP0FfguH4MlN11vPPE=;
        b=nCID9rdf1aKalYgEuIUsn84vwIlIrn0IMWOVtJKQRkyI/2N66Udxegv4gTHmlKEBVl
         uUGti1X4wgFLfd+iLt8RzLp/8a0nmtvjNPqoy0QUEFO+896VUqRlrNyWX268brWE6BF7
         5zy0oQ5IleESxcZJXweSUloDklpZ3sv4WBoz8z6Iqfu7NIE7tyDWmwulrafgtT6QgrWf
         gRVJqjbRTKUoFEKlxYHxgnahlSMNRh5Z/1n850kcHb9Uv7k8/Cuo+dJQlxdxJa0cLnl/
         K8yEKygFys4C92Vtdst9beC6hX5w4sEJpvbvNWLSMZqQctP28UH1LsYk6WnwBrRum3j8
         thnA==
X-Gm-Message-State: AOAM530s+PTXsmQBns+Ylx8BDDOf0kWIXYViXjKMRCh4t/Ingr+3sS/j
        c/ikYF4LQloV/t4jT/V4d4LFOyPj2d8i2Ve484/azA==
X-Google-Smtp-Source: ABdhPJxS3XiFOqFhrRKU/byzauaRUixVOrqI145+D91dRw4A1+NV2JaZOBZF6ul8S7Q+44ceN6tvuQAEuN2PR4AM+3Q=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr317033pjb.93.1635372208848;
 Wed, 27 Oct 2021 15:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-4-hch@lst.de>
In-Reply-To: <20211018044054.1779424-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 15:03:17 -0700
Message-ID: <CAPcyv4iM4RjrQj4Q4i+tXmq1QMC=_dy0TTCzvxqRc_miv40NGg@mail.gmail.com>
Subject: Re: [PATCH 03/11] dax: simplify the dax_device <-> gendisk association
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Replace the dax_host_hash with an xarray indexed by the pointer value
> of the gendisk, and require explicitl calls from the block drivers that

s/explicitl/explicitl/

I've fixed that up locally.

> want to associate their gendisk with a dax_device.

This looks good. 0day-robot is now chewing on it via the test merge
with linux-next (libnvdimm-pending).

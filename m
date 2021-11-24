Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611DC45B2C4
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 04:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhKXDvM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 22:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbhKXDvM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 22:51:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E433C06173E
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 19:48:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3901866pja.1
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 19:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQpMJpPq/OIJ1A+jReESOD3pvkOjXmQh8KJADyXTrz8=;
        b=jKMXPC6R380cNIQ/lk6QhOIiLqsp4XKj1eRLbWdIfXDMXjf2sFtM/A4DNKzZle92lO
         3U1GnSeEGBEEzHeeSOTcj6e6Hlhrl2Cgom3C+oy6m84LroLIm83mhibtNhOC9a7kpuLa
         ouXLOQwDClItscEUt0Jtcfsiacpxarhj3trqquFBkBV1VRiZIUVoCcdmCugOwJ+8mJs6
         RFqDPmjgXZyOm3EQaprR9sZoOXJ0YQXXHWkXXD+DsFaSM6qnnUL3vYnF49/xzscWLZfD
         M7pqOQ9uH/J1/XHGYxb48lxo0PQegLqWhqBsHyRYBVi7oUWjdYWmqFepS80LAFQdqtcA
         s5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQpMJpPq/OIJ1A+jReESOD3pvkOjXmQh8KJADyXTrz8=;
        b=n9ldJAzvOtCodStHJVruVkBj4FdRIeYkHabT92UL7n+kmeIFdR/sI1vLE9K4ui05lC
         a5/RwlPQagUseuYkN/yH6Ue0bIAy7FPDRiVPGD2q4FNz/5GnCtyLhzDm3vYy89le+Mze
         LIw54HtmT363nmaeZz1Uw1q5kuEkpMAyL2crUGbdR2wRbhleZRBraczuAVSZZ2EPpteL
         H+Rt5izACc+CbOUDm/9/lv5vXR81MwM6td3a2G7hHL+4U9VFY+U7U6vSKw646GHubqwk
         2NuCgo/HsL+Rn+p3djZgbZK4d3Loxj6vP9VGK9kz/lHqif9usy7GIpqpcS4cDSFFbPtB
         XLlA==
X-Gm-Message-State: AOAM531jUvT+07chovH6/VdqI8Rn/6xuNtogacp+OEk+KD5P26uoNYT1
        usQ8/S5JhrEXOmDhq5nzBm+6c1AzWgvLbKjYx+Im8w==
X-Google-Smtp-Source: ABdhPJwXdBqxRTwwq0bi38HdemI3/UrUSQvkef2geUCQrgUs13GwLl6CkzHERiNWivJH+HCOX6YcKKMcXBwB2wDg59I=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr13991510plt.89.1637725682824; Tue, 23
 Nov 2021 19:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-28-hch@lst.de>
In-Reply-To: <20211109083309.584081-28-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 19:47:52 -0800
Message-ID: <CAPcyv4jrUAJ28J6Q75jmfQRz2nj4a3v6bZVjFpROd98efuafsQ@mail.gmail.com>
Subject: Re: [PATCH 27/29] dax: fix up some of the block device related ifdefs
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

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The DAX device <-> block device association is only enabled if
> CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
> the right conditions for the fs_put_dax stub as well.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DBD3F50AD
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 20:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhHWSs0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHWSsY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 14:48:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B8C06175F
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 11:47:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q2so17461906pgt.6
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r54pHmxmjGri522v1PTJT3wgqKLwaTSuYN7KqNeOshc=;
        b=ON0Ulal5HgyBW6cTYVJVpFVeEknnHV2b+ct6UfJ6exaBr/kDhaiOpzwwr8mE1X+ftG
         yPgh8gE6jDzcJ1g7pOYTIqOpKhhBy6qoKCVzKNWbCsH7nerKcTiz/0qRdPflFtj7rpOn
         TOutZH8U7o3//PAf3veh4KzsMBh+k7AtIBWx7p+96JYNtLQ4WL5AvSqPt+4VLJq0Mwhu
         IK8GuHp767hRzY4t5tJUgyDxieGLHIocbNliT5hx4QE5MzhfhbvhOkfbhc2w1sYCCdpk
         IZH5DRWYU6KH7vcc4s642VXtiosILos3qzTun3RQGz0Wijao65Kdp4C/SA0InLbTkXnt
         9baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r54pHmxmjGri522v1PTJT3wgqKLwaTSuYN7KqNeOshc=;
        b=fyB9/UoIwmYK4IUvrf2rwpn0j6ZLiR5xjyYVjA3mIn5XiDyCVzPxfqF5JVtmZ34CRJ
         HC02YLtCvbijfnuqddVMyaoO1cSZN0iPA9hhIJk5PPYTXFi+RpP3RM96IGcNstdrTBNw
         9j25QbzJu5lAHYSJG3FCqjvY9UN+M7Y7TfA9MaBmoDfXkR93fk58ocXC3OP8X0pq3bYL
         wqPWmrVC4cVILwzXvm6rfOqVYz1U4KHmx3mlzyDBUpXKDfwS6SxHlf+zW4F7O3Mq55xB
         S/Hr81s5wyxoS4tq5WhFBBbgNE2GzNm8dgzg+8CkyrVJ3nvpl6Nz3d2cLi9oeQuBPtsw
         F7nA==
X-Gm-Message-State: AOAM5301dTdXceeWkEwMMVSi1K8ey2ZsURtVT2pW9EkaXp1eCtM7uJmI
        wBjqheNJobY8KIzyt4c88VdJmkVtXyxtroI0C5CmKQ==
X-Google-Smtp-Source: ABdhPJzDVavO1D0cuxFMJfc7vAR6mGcyWNFXeb0k5SW+uv+Pt4QHySWz8XFkNATSzrUwGSt4zomLq2aChoPEcZrN8qg=
X-Received: by 2002:a63:dd0e:: with SMTP id t14mr32045829pgg.279.1629744460943;
 Mon, 23 Aug 2021 11:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-3-hch@lst.de>
In-Reply-To: <20210823123516.969486-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 11:47:30 -0700
Message-ID: <CAPcyv4jGqOh3bq=5bgkAaOjp5SUOVGKQyXYsPsurtGtDiY2a9A@mail.gmail.com>
Subject: Re: [PATCH 2/9] dax: stop using bdevname
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
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

On Mon, Aug 23, 2021 at 5:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just use the %pg format specifier instead.
>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

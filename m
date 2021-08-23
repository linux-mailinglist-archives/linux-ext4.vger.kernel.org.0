Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381813F52BF
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhHWVVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhHWVVE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 17:21:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65552C06175F
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 14:20:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso868338pjq.4
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Tta22g6TzCbS8+A5F3hRnTInZTNETaE2nytspmuyiI=;
        b=WmkNeRi7tFECQpCdiAmGDL4hHYzV9+5I3fYvoUDlepLk2e1dCoJMI6zB/qrgiW/KA8
         tjlG4bLQMDL/lTTTfR20oVNEgEEZ9SZi71LCMKYLmB9l7o0IKWQV3x99rHH9jrOdt/aQ
         KvCTbbVrru40KnJ4Ss45A2n6Y2tle0h2j1Fyp9R/qhfGrgpEmPMaySRW6/mu3K7iVXr5
         PxzRBeLG0yaFZc9b/9i/1w066LgdKUZn7jriSCoN6lLiH0EHg9NWUBuRKhMrDkvqUavH
         1ra/FqSzDumL4aMl8uZzZVoN/2mdgv0SPsnRwIrftWCnmVtCvSYcmYp/HvEhrMhW4u3g
         nk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Tta22g6TzCbS8+A5F3hRnTInZTNETaE2nytspmuyiI=;
        b=fSAIgb7uA59CqGCruTdg2SLWCtcYuKoVsZVTjKmUPaB7rqCPQTdKb4pzPBMf082O+O
         RIJQByO16ZQO+H6Gc1lEv7NwfmMz9CeLWeG+7yLrrMtkSZ6aSm7fl4j9OFFumExRA3AW
         WBMUwXYKWQo5QF6JblvVObW7+UB49LWZRjKUYRUVtrmxT5d5A4x3wlqaqgW6uZkaW1d3
         VmDB7jSIIKYrT1ZNVaHONEke+uenr+Dtf6e6moFJ89p0KBC2zQ9NBajgrERI824XcPvx
         4Kg09mDwV/HVstIVaBD5jmDpxlZm7d7OVdG+FuDoau8SayTsu5TvWGCbbhUJcxfqzQ6W
         Tlww==
X-Gm-Message-State: AOAM533dBZ7WrUHNfckgUViEoFLrV9hvCrpE2QEL/Zrb66nQewPsoL5A
        ILIXOawoBsN3pWKBnB6lcJ82w60YxXUPc3levXoKxQ==
X-Google-Smtp-Source: ABdhPJzdZDOlIEIUdEe/koFlzTPnIhrvJ+LvlXLPoKCXM8QxzZFIYVnDFkM1MxM7I34jVCC/VnQMg8JkpWiv08lsQpo=
X-Received: by 2002:a17:90b:23d6:: with SMTP id md22mr532829pjb.149.1629753620957;
 Mon, 23 Aug 2021 14:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-9-hch@lst.de>
In-Reply-To: <20210823123516.969486-9-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 14:20:10 -0700
Message-ID: <CAPcyv4jR7U2N0-fFE8FUL+fNdY+6f=FNs7ex56F5tsLztA_GJA@mail.gmail.com>
Subject: Re: [PATCH 8/9] xfs: factor out a xfs_buftarg_is_dax helper
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

On Mon, Aug 23, 2021 at 5:44 AM Christoph Hellwig <hch@lst.de> wrote:
>

I wouldn't mind adding:

"In support of a future change to kill bdev_dax_supported() first move
its usage to a helper."

...but either way:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

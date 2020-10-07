Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27692856B3
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Oct 2020 04:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJGCkS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Oct 2020 22:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgJGCkS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Oct 2020 22:40:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE031C0613D2
        for <linux-ext4@vger.kernel.org>; Tue,  6 Oct 2020 19:40:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so760347ejc.5
        for <linux-ext4@vger.kernel.org>; Tue, 06 Oct 2020 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afZ2ku0615X/vbgIsq8uZABQa+HrZmef3/cMOPPeXPE=;
        b=EPjdVqDeTinUn3xle7QkZRs1c1I777r6WwVNCzmQvuelLMEIhN7D3byY1DbMWiHRAd
         QgHw7nunbi78JiFNVYPaj+vzDaQToh84mycymDqg79odab44O2bFpy0hTFRZMk6Gq88h
         gdm22jg2FmT9PYcFKiksCpHH97YYjHNLfkRJqB+XyuOtAK7X6n9Ol7Qc3aWxyX/ubcf1
         1Dj3nT3ueZ1gSrXVBd01SuIcMxMF+W8KjeuouHZbfkVWg3QUD53z+H8ypZQCYHGiMbYk
         lCoLazlQUecuVDEtHUfRDwSsCvcaF59aNbsh9HWw6NNgsgGSQloXWj+DnfN5l7npN3En
         PmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afZ2ku0615X/vbgIsq8uZABQa+HrZmef3/cMOPPeXPE=;
        b=PTEYsRk4LDRRCs6aQyVTm7+bVrQZ+ENciEQX1RJaIFPbfvWtpRZ4+UR6El8iS3tiA4
         YQTg7vd7any0OYeUNsltpqlMD5C+O3S2Rt+saiB6OsG9skOxPx4v9MAFA1iZM2LuCXEI
         +kYDa4Zu0ksCj7F8p1xEmyRdT6CBAYFhy4QJ8qTjoafPjli1nIEe2ACzYofLSQnN/MKY
         2WKO+POMDSvPnoH8B45tY4+Vf8e7IFYW4WVqG40REctLP6nrFdrFYz2aix23nddcQ3sw
         b5qhlOozWxXgTUEh7u5Hdo9fkJvTwWs9oMZr3jD97uljR2lq7vlAPtjacvt1E+c/DYFx
         wgcQ==
X-Gm-Message-State: AOAM533rB+u5TFcj3JcgYQ/xPKUmKQz5Zx2pH6OVZx8N5MbiMyp/GFDF
        rb052swdMJzCcrJayllgXxhtFz1ERLkdFojENVNZkiUBVhs=
X-Google-Smtp-Source: ABdhPJyzhK0w2iAz2iCMzOOn/0AFV3bEvaxuBmF2mBxx+C4IpyFlFHdfkT/qw+BQgpUSKwf1wNdFiTZy1ImFQ33Wm94=
X-Received: by 2002:a17:906:1a0b:: with SMTP id i11mr1116582ejf.472.1602038416463;
 Tue, 06 Oct 2020 19:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201006230930.3908-1-rcampbell@nvidia.com>
In-Reply-To: <20201006230930.3908-1-rcampbell@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 6 Oct 2020 19:40:05 -0700
Message-ID: <CAPcyv4gYtCmzPOWErYOkCCfD0ZvLcrgfR8n2kG3QPMww9B0gyg@mail.gmail.com>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 6, 2020 at 4:09 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add a helper function to hide this detail.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>
> I'm resending this as a separate patch since I think it is ready to
> merge. Originally, this was part of an RFC and is unchanged from v3:
> https://lore.kernel.org/linux-mm/20201001181715.17416-1-rcampbell@nvidia.com
>
> It applies cleanly to linux-5.9.0-rc7-mm1 but doesn't really
> depend on anything, just simple merge conflicts when applied to
> other trees.
> I'll let the various maintainers decide which tree and when to merge.
> It isn't urgent since it is a clean up patch.

Thanks Ralph, it looks good to me. Jan, or Ted care to ack? I don't
have much else pending for dax at the moment as Andrew is carrying my
dax updates for this cycle. Andrew please take this into -mm if you
get a chance. Otherwise I'll cycle back to it when some other dax
updates arrive in my queue.

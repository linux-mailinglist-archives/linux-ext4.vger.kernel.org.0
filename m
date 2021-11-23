Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DC45AE23
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 22:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKWVTM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbhKWVTM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Nov 2021 16:19:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E70C061746
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 13:16:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h24so554414pjq.2
        for <linux-ext4@vger.kernel.org>; Tue, 23 Nov 2021 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+zpQrvL4Qxe/qyBBz6nO1x+ZudVJHE22cDmvcF/TOE=;
        b=3UTjzt/B58bzUMuj7IqqMnaCu5WYQAV5rK+fs5kaCfP78gUwTgy5Zlf3Be+wmIjr56
         TnFB+KlAOrzucg0BEhVOP/JXfiAUD2ftEQJXj4AikeXTgWe03Spusb/0TUld0hhFX8v6
         hoRoYhcMIe1fJGrizIl0u8fu7pfvZl0yQ6G/HZ/XblMR0kOZLIsIbaNzfqww2OtwK0QY
         M2kpeuFwFxk8ZGruQVPxMGdqTXvMTUs/jjMoa2NVuNjPrbZJxiRI6LrTQ3lIM/koJIif
         rP8I79qIKGLZ1fswpluH9sZNHRVBAzv8KTrCcmchw/ruDBCNrZVPKtgfRhQ9/KytnoiJ
         mPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+zpQrvL4Qxe/qyBBz6nO1x+ZudVJHE22cDmvcF/TOE=;
        b=sP1HO2HQaSsoDZWZRWpGl7Mog5u2ouhTQTm/7wLbe4oF+4dgtdegAlX5658i400lHW
         MKQDFzhGCSuSAeePej8jkLM6znqLRoWEXBzgGoVpLDbVPFYn7oDKEq0ie1jAZO9Cumzw
         ZwSB+pj/KcXkkc5ajyfoCY63G8mCkzsBYxVn0s65y9VSkz26c8G+y39VgH9aPa3xyr66
         +UVBAK7ZhbGo0juzfDpREnAC39/nvt7nRZsQbzl18N9WStB0jEQtJJuZrJEtUVrgVs+x
         WaYT59GwqyDrDzUGpsGotxSAOYQnaVBF8eZs/i1ae++iXXwc7+VeVySlMgRmnBLmph7e
         cngQ==
X-Gm-Message-State: AOAM533YhmP+EDZPMTxfvGO+CMcOzcHQ3V+3TK1AYt4XOk6Oueq0+Bd0
        asO+4fmYg+qxGjCDhCu4Ur4t5YEkGE6aeIr5MiORnw==
X-Google-Smtp-Source: ABdhPJxRRlv0NZQorv0M5t2wTRvBAaxVZY2wmbRu89506wlORAkd8KhXvCTyC5EAm4rzXSOWToX/mEdJ14fdPpKfw3k=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr494044pjb.93.1637702163126;
 Tue, 23 Nov 2021 13:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-16-hch@lst.de>
In-Reply-To: <20211109083309.584081-16-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 13:15:52 -0800
Message-ID: <CAPcyv4jDqfNj4iAYoewj53QEZjXR41UuE0LN49CtC_2qjrbazg@mail.gmail.com>
Subject: Re: [PATCH 15/29] xfs: add xfs_zero_range and xfs_truncate_page helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>
> Add helpers to prepare for using different DAX operations.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> [hch: split from a larger patch + slight cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368349F682
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jan 2022 10:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347676AbiA1JiO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 04:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347682AbiA1JiM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jan 2022 04:38:12 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E088C06174E
        for <linux-ext4@vger.kernel.org>; Fri, 28 Jan 2022 01:38:08 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id a19so2281542vsi.2
        for <linux-ext4@vger.kernel.org>; Fri, 28 Jan 2022 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/VIyc5JpK2Sy5loT9a2HcHWg2TrorJJxRaogeKP25w=;
        b=EibPllimp8WZIwxJdUGUIFAlIuZdyznPvrXJ7caP5EDkiBNUVM4ihiUoIfNxC6TVSx
         YE207qfvpl7N/VHWz1SefuMcAFD5mqGieRSegzXNyYGWfyIdkPkwWByrIvqWimbKQ8Un
         /lbUGxvPlDX06Jf/32nPUu5Q90vZSrQ0/ovfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/VIyc5JpK2Sy5loT9a2HcHWg2TrorJJxRaogeKP25w=;
        b=PV4JfA86nZ3OkzCiETMkMaFbN7ES7Ng9rqOQYK0QkXln5v90KvHAto+AUTzqtIgnuR
         9a//+R6aM4o+CAhZ6YGOUwgCfsvSC0pu/NfmF6/BV12s6rpokUAvGwyn9jf4Zy5vsQw6
         QJngRpyJOvarrvl83xAdGwSWRomaftXscLSO+Ovbl7tDCRGOUTOg/CsfOwEXYom6XCVv
         cfw4Ar9ERMyqogILqmXer33T0e3K2unL5N9AYiYjjAMveICRqBjr4FWiDsi3KeQwmPqz
         E6Hw1pp2NKg9rv6iI5N4rhCYWT3qv0PycOuXSbyxkOvwNrWgQVqy1yyb77G9skeNMkZb
         bNJQ==
X-Gm-Message-State: AOAM530DmqAv/TBqZfZNfTGjLgCEWplXM3ZCzCXNfzYxqg3Z/xR0q9CH
        slOWApuM6403LhLXmz7j0CRdj2rqvc4VZE6wloRuOA==
X-Google-Smtp-Source: ABdhPJwGf3F8vVWMx/hAPOM/tzuC6mlnTkkNvV3zFtYKADK7sTRpnxjvKNE9DMzHauL+NEVwnl4j38I6/K9jRDhQk7E=
X-Received: by 2002:a67:c390:: with SMTP id s16mr3769368vsj.61.1643362687362;
 Fri, 28 Jan 2022 01:38:07 -0800 (PST)
MIME-Version: 1.0
References: <164325106958.29787.4865219843242892726.stgit@noble.brown> <164325158954.29787.7856652136298668100.stgit@noble.brown>
In-Reply-To: <164325158954.29787.7856652136298668100.stgit@noble.brown>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Jan 2022 10:37:56 +0100
Message-ID: <CAJfpegt-igF8HqsDUcMzfU0jYv8WpofLy0Uv0YnXLzsfx=tkGg@mail.gmail.com>
Subject: Re: [PATCH 1/9] Remove inode_congested()
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm <linux-mm@kvack.org>,
        linux-nilfs@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Ext4 <linux-ext4@vger.kernel.org>, ceph-devel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 27 Jan 2022 at 03:47, NeilBrown <neilb@suse.de> wrote:
>
> inode_congested() reports if the backing-device for the inode is
> congested.  Few bdi report congestion any more, only ceph, fuse, and
> nfs.  Having support just for those is unlikely to be useful.
>
> The places which test inode_congested() or it variants like
> inode_write_congested(), avoid initiating IO if congestion is present.
> We now have to rely on other places in the stack to back off, or abort
> requests - we already do for everything except these 3 filesystems.
>
> So remove inode_congested() and related functions, and remove the call
> sites, assuming that inode_congested() always returns 'false'.

Looks to me this is going to "break" fuse; e.g. readahead path will go
ahead and try to submit more requests, even if the queue is getting
congested.   In this case the readahead submission will eventually
block, which is counterproductive.

I think we should *first* make sure all call sites are substituted
with appropriate mechanisms in the affected filesystems and as a last
step remove the superfluous bdi congestion mechanism.

You are saying that all fs except these three already have such
mechanisms in place, right?  Can you elaborate on that?

Thanks,
Miklos

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBB225CCA3
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Sep 2020 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgICVsF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Sep 2020 17:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgICVsB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Sep 2020 17:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599169678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBrynNccaVwKMAHtYaWvrpJ0iV4f205Vo+3SkjyLb1M=;
        b=F7wIbma2FRq6t6wqeI1ji/maXQaDBPUn46nBs9buesEq8kWzo8kYeeaqXE1bUBIH/lEYuQ
        oG+Cz30kcirEFTw7yb3TPth5zjrJvrcJymi2aBjGJ0nO9fL3fEpKz68p/dkE6vpfnFWlly
        2NAOl+j6gnF/pEXngDif3xWaJ/5dRJQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-t_RkFw2PNoq0jHN7E8Hs8Q-1; Thu, 03 Sep 2020 17:47:57 -0400
X-MC-Unique: t_RkFw2PNoq0jHN7E8Hs8Q-1
Received: by mail-wr1-f71.google.com with SMTP id r16so1536115wrm.18
        for <linux-ext4@vger.kernel.org>; Thu, 03 Sep 2020 14:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBrynNccaVwKMAHtYaWvrpJ0iV4f205Vo+3SkjyLb1M=;
        b=XGpELr94rjpXQpk2t08OKdJGa85Un1R2kyCndnCmT7eiUNc85NGmpZYYTzZLEZ5ACm
         tXIkxG/s0QiV4KZTc3gHZ5Nq13sfFs96J8ccesmYYJIaAw7BExEW1d7/6toa+wSgAmRo
         GdzKMtJCB/dzQUjrO5iwnReBdfDH2n5e3cUoEg8/88ZYYHmwRq3UXFUzjncQKEDC/DxQ
         VGBGlEecVtqBjLKpOfUNC4x5nGFZX5WNSi3x4QJ5iZixL89wfohaQBLW+25df8wU9xD9
         81HFWtkJwpnOj0A+Kfujf9mkMxc92Gs9zX0yxxZXRF2nBvr1CgLOMlNysX55B6q1JMSq
         m3HA==
X-Gm-Message-State: AOAM531FptRvfHh9hsSL3xhMuSToMnPyeTQTgCw6c3G6kLx7zabOTFnw
        Io4N4ymsXJo9xhYxpqMHeYSATtC7cnIFveFyrH8OtmIE3dvMU5SCNmArwROiYHw00Mj55IPY+iH
        KEWR+zyL3vNlqf6UI0WbvCk516fcTwRUJr3sw7Q==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr4395617wmh.152.1599169676210;
        Thu, 03 Sep 2020 14:47:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfurQNCgokDtRoLPRuHgAybZLnKZ8B+2PgntmWzIP1k1DncX3kyUDbDZW6vrGvGz+eL5DynJVwhOUzgUE9+X8=
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr4395604wmh.152.1599169676019;
 Thu, 03 Sep 2020 14:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200903165632.1338996-1-agruenba@redhat.com> <695a418c-ba6d-d3e9-f521-7dfa059764db@sandeen.net>
In-Reply-To: <695a418c-ba6d-d3e9-f521-7dfa059764db@sandeen.net>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 3 Sep 2020 23:47:44 +0200
Message-ID: <CAHc6FU5zwQTBaGVban6tCH7kNwr+NiW-_oKC1j0vmqbWAWx50g@mail.gmail.com>
Subject: Re: [PATCH] iomap: Fix direct I/O write consistency check
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 3, 2020 at 11:12 PM Eric Sandeen <sandeen@sandeen.net> wrote:
> On 9/3/20 11:56 AM, Andreas Gruenbacher wrote:
> > When a direct I/O write falls back to buffered I/O entirely, dio->size
> > will be 0 in iomap_dio_complete.  Function invalidate_inode_pages2_range
> > will try to invalidate the rest of the address space.
>
> (Because if ->size == 0 and offset == 0, then invalidating up to (0+0-1) will
> invalidate the entire range.)
>
>
>                 err = invalidate_inode_pages2_range(inode->i_mapping,
>                                 offset >> PAGE_SHIFT,
>                                 (offset + dio->size - 1) >> PAGE_SHIFT);
>
> so I guess this behavior is unique to writing to a hole at offset 0?
>
> FWIW, this same test yields the same results on ext3 when it falls back to
> buffered.

That's interesting. An ext3 formatted filesystem will invoke
dio_warn_stale_pagecache and thus log the error message, but the error
isn't immediately reported by the "pwrite 0 4k". It takes adding '-c
"fsync"' to the xfs_io command or similar to make it fail.

An ext4 formatted filesystem doesn't show any of these problems.

Thanks,
Andreas

> -Eric
>
> > If there are any
> > dirty pages in that range, the write will fail and a "Page cache
> > invalidation failure on direct I/O" error will be logged.
> >
> > On gfs2, this can be reproduced as follows:
> >
> >   xfs_io \
> >     -c "open -ft foo" -c "pwrite 4k 4k" -c "close" \
> >     -c "open -d foo" -c "pwrite 0 4k"
> >
> > Fix this by recognizing 0-length writes.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/iomap/direct-io.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index c1aafb2ab990..c9d6b4eecdb7 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -108,7 +108,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> >        * ->end_io() when necessary, otherwise a racing buffer read would cache
> >        * zeros from unwritten extents.
> >        */
> > -     if (!dio->error &&
> > +     if (!dio->error && dio->size &&
> >           (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
> >               int err;
> >               err = invalidate_inode_pages2_range(inode->i_mapping,
> >
>


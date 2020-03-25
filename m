Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A52192D81
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 16:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCYPy4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 11:54:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36870 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgCYPy4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 11:54:56 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so2747974iod.4
        for <linux-ext4@vger.kernel.org>; Wed, 25 Mar 2020 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUvTsX9+jdPoLTOSHShSbaoohqGvLnmJWJx3goFYuLM=;
        b=PotvV1Ev6OzVSaF6m2X5tC6JwxVWHxAGf6FLW8AjKTGJyK/QJ8dyn6xJiqfkSFaAqz
         OCdtBX9daql7+1gX8+5dT3S5uMqemNZ36FP4ZPoQpwuOHn42a4uh+PVPR7d5d59NuA3a
         t2/cRclIFAps/zNhsd7jyIV2vHIEY2rkQ4dM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUvTsX9+jdPoLTOSHShSbaoohqGvLnmJWJx3goFYuLM=;
        b=m75ASTeGrdKZE5sD0ygH0DJqeX76jWEjX3rpeZ0sUu1QwdEWSNff9iK19wTjABM8OA
         EUX2VSUW7PqFK4soLPbmBeyh0OgeUGxMYjnnW+BmKQI2ITV4Xn4uB1g20x/ncT7hcQ9S
         zDarLMg035fEVkZKclAjHuRCEKb085W4RCrsCoyvhSg3LZQpLdQmoB4VZnOZNXroom2O
         wBIZd/PTFDje4cAL0KSGtjDYoPCVCX/tYIzxIryZihTmKkFmVHSWORKfHKmt5rwLZeC1
         V05IzcTZlIWmSkmXlm1LFf8hTl81SjHMERXHjYuzcf9Xm+Vulg8/XDbPa8pxl1rNKgzS
         Ezdw==
X-Gm-Message-State: ANhLgQ3OmTs+Qk2ukFigZ1jYXLLsdb0QAtBOyxBVKj5cU5fJJQiQnQYZ
        WIugPHlmJbNVDTDqLNauvZga4CSGkegNyKdJxqYrzA==
X-Google-Smtp-Source: ADFU+vtWPrSX9gO9pLLxpavehCkl/CaKr8w3OI8WID1sZHiGcDBmq2nlMdLwxJGUo5kQXivDvVBrGhSFup9s33zQy+o=
X-Received: by 2002:a5d:9142:: with SMTP id y2mr3418704ioq.185.1585151694868;
 Wed, 25 Mar 2020 08:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200323202259.13363-1-willy@infradead.org> <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
 <20200325120254.GA22483@bombadil.infradead.org> <CAJfpegshssCJiA8PBcq2XvBj3mR8dufHb0zWRFvvKKv82VQYsw@mail.gmail.com>
 <20200325153228.GB22483@bombadil.infradead.org>
In-Reply-To: <20200325153228.GB22483@bombadil.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Mar 2020 16:54:43 +0100
Message-ID: <CAJfpegtrhGamoSqD-3Svfj3-iTdAbfD8TP44H_o+HE+g+CAnCA@mail.gmail.com>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 25, 2020 at 4:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 25, 2020 at 03:43:02PM +0100, Miklos Szeredi wrote:
> > >
> > > -       while ((page = readahead_page(rac))) {
> > > -               if (fuse_readpages_fill(&data, page) != 0)
> > > +               nr_pages = min(readahead_count(rac), fc->max_pages);
> >
> > Missing fc->max_read clamp.
>
> Yeah, I realised that.  I ended up doing ...
>
> +       unsigned int i, max_pages, nr_pages = 0;
> ...
> +       max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE);
>
> > > +               ia = fuse_io_alloc(NULL, nr_pages);
> > > +               if (!ia)
> > >                         return;
> > > +               ap = &ia->ap;
> > > +               __readahead_batch(rac, ap->pages, nr_pages);
> >
> > nr_pages = __readahead_batch(...)?
>
> That's the other bug ... this was designed for btrfs which has a fixed-size
> buffer.  But you want to dynamically allocate fuse_io_args(), so we need to
> figure out the number of pages beforehand, which is a little awkward.  I've
> settled on this for the moment:
>
>         for (;;) {
>                struct fuse_io_args *ia;
>                 struct fuse_args_pages *ap;
>
>                 nr_pages = readahead_count(rac) - nr_pages;
>                 if (nr_pages > max_pages)
>                         nr_pages = max_pages;
>                 if (nr_pages == 0)
>                         break;
>                 ia = fuse_io_alloc(NULL, nr_pages);
>                 if (!ia)
>                         return;
>                 ap = &ia->ap;
>                 __readahead_batch(rac, ap->pages, nr_pages);
>                 for (i = 0; i < nr_pages; i++) {
>                         fuse_wait_on_page_writeback(inode,
>                                                     readahead_index(rac) + i);
>                         ap->descs[i].length = PAGE_SIZE;
>                 }
>                 ap->num_pages = nr_pages;
>                 fuse_send_readpages(ia, rac->file);
>         }
>
> but I'm not entirely happy with that either.  Pondering better options.

I think that's fine.   Note how the original code possibly
over-allocates the the page array, because it doesn't know the batch
size beforehand.  So this is already better.

>
> > This will give consecutive pages, right?
>
> readpages() was already being called with consecutive pages.  Several
> filesystems had code to cope with the pages being non-consecutive, but
> that wasn't how the core code worked; if there was a discontiguity it
> would send off the pages that were consecutive and start a new batch.
>
> __readahead_batch() can't return fewer than nr_pages, so you don't need
> to check for that.

That's far from obvious.

I'd put a WARN_ON at least to make document the fact.

Thanks,
Miklos

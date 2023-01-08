Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057C6618B1
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Jan 2023 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjAHTmU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Jan 2023 14:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjAHTmS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Jan 2023 14:42:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52476DF10
        for <linux-ext4@vger.kernel.org>; Sun,  8 Jan 2023 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33qTT0r6wAZ1WTwwlWCp7SkxG6n6RS0yiwUpFiSj+fQ=;
        b=B3vDuFqzYFB518eYF3YTNmkgBdBUc5A5wg0WMtaQ7c3zqkHLRCjfCx4C538P5NgGXVvI+v
        lCNgHWbY4f178R+5/4N2dbFr6JKvpvVIWI5aYJNHjCkSovCY7asMdXxI1ZhrMc/ugnl9di
        t8VK8hLOl+7pUD62Wwx/yblY3PX3L2s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-RWauYJqCMD2D0F6QAlnwRg-1; Sun, 08 Jan 2023 14:40:43 -0500
X-MC-Unique: RWauYJqCMD2D0F6QAlnwRg-1
Received: by mail-pl1-f200.google.com with SMTP id a12-20020a170902eccc00b001927f1d6316so5072409plh.10
        for <linux-ext4@vger.kernel.org>; Sun, 08 Jan 2023 11:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33qTT0r6wAZ1WTwwlWCp7SkxG6n6RS0yiwUpFiSj+fQ=;
        b=17bnlUFrZk+iRkU4EtArEotjAfn7T8uWJ9ER2wfuoLgBKZewTATFcfhCWozounU3ab
         AH9dalzsVTexgyVqWxUm0kyQ1RHesvqZ1h8JPL/yu/Nd7tUMa4FIv8QBJU6TJmo5IcSk
         1ol3raDZRdMAxz9UNupP0yQ3hVwsSyASYOZOUF3iOlK4YBn+HDQTvwg0nqJ4YjIFTo4c
         7geQUjMnmZC/tMX8bgAVJhCrN6heq1qtI+v4wN8TLI3vVG6VTQTRc5rcVneqcGfUFxfd
         ITmzPExioG/WBf5TEJBxt41Nnzm0qizXa+ymuk/EToIFGLrA/0EXX6uxD/H0vphErO5W
         VGlw==
X-Gm-Message-State: AFqh2kqv+6i1XwqRQFaP8WjsTYhNu8n5aaFx8+k50NyBeN1Jw5QEOvWJ
        EHySdd3vOyXPOJb2FQeF2v7dw8ii/yUMsHTa3L4/lctrEiA6lPDhVFPqkrjEacbA/BTKaU4A31W
        2Q47tprJs0ErRv6JGYkd7b86cgked1U0o5ZENSw==
X-Received: by 2002:a63:5d1b:0:b0:495:fb5f:439d with SMTP id r27-20020a635d1b000000b00495fb5f439dmr3366897pgb.68.1673206841643;
        Sun, 08 Jan 2023 11:40:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu1lJQZfWW6xV/PSksmTNaQzyZoMTAsvtqnDEI+7F2q3BfsEW4wdkPdTNM+CpyXNcR3EqzkjBqi270j/f370sU=
X-Received: by 2002:a63:5d1b:0:b0:495:fb5f:439d with SMTP id
 r27-20020a635d1b000000b00495fb5f439dmr3366894pgb.68.1673206841425; Sun, 08
 Jan 2023 11:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20221231150919.659533-1-agruenba@redhat.com> <20221231150919.659533-6-agruenba@redhat.com>
 <Y7r9gnn2q3PnQ030@infradead.org>
In-Reply-To: <Y7r9gnn2q3PnQ030@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 8 Jan 2023 20:40:29 +0100
Message-ID: <CAHc6FU6UF3CZWqdDoDieFgKZk6_PiJfmBi5jWFTRoNgk9D8-5Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iomap/gfs2: Get page in page_prepare handler
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jan 8, 2023 at 6:29 PM Christoph Hellwig <hch@infradead.org> wrote:
> > +     if (page_ops && page_ops->page_prepare)
> > +             folio = page_ops->page_prepare(iter, pos, len);
> > +     else
> > +             folio = iomap_get_folio(iter, pos);
> > +     if (IS_ERR(folio))
> >               return PTR_ERR(folio);
>
> I'd love to have a iomap_get_folio helper for this sequence so that
> we match iomap_put_folio.  That would require renaming the current
> iomap_get_folio to __iomap_get_folio.

That's the wrong way around though. iomap_get_folio() is exported to
filesystems, so if at all, we should rename iomap_put_folio() which is
a static function only used in the iomap code.

I'll post an update.

Thanks,
Andreas


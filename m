Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8217E73E5
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Nov 2023 22:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjKIVvM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Nov 2023 16:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjKIVvL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Nov 2023 16:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF864206
        for <linux-ext4@vger.kernel.org>; Thu,  9 Nov 2023 13:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699566622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RfLDwoRp1AgagZ4sj107hwERh+DKKg2aeHYKEBXwEg=;
        b=WCx70lMKh/ce3sv3oMzW426y2SeKUJxYjGLhleFsl6xKlRXSVFsoXlY+1P/8eP5kHvRNoI
        PB3udM579qBk+eQLBduHzKpy7F5Nqv/CeCwGFTeIb4EkHdrgNkUNhwqk5OUUB1Qx0uwQwT
        CyczWG+SXiUB65HBjjl3oIWLRKarbDQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-BvHXNvV0MISGvfPkQHdKqQ-1; Thu, 09 Nov 2023 16:50:21 -0500
X-MC-Unique: BvHXNvV0MISGvfPkQHdKqQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5788445ac04so1190926a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Nov 2023 13:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566620; x=1700171420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RfLDwoRp1AgagZ4sj107hwERh+DKKg2aeHYKEBXwEg=;
        b=FUevdUR9N3G5w4Aeyccz4fo+Lyja1cvXus9Vggr1JAEjH54II6jP3btYXpUFeDOhlZ
         Au3lOukqAhDrDcgXAMlv8AkyigbjlmbQfvVGu0MQUR2FOyk2NtidoVtkKt0akNqRRJPp
         csDWEZ6JS8TKRz9M76UrSyQyvOgRNR8rrP4vng9giSb2+gYfcr0ZP2fUzxJ9k2DmuAKb
         mP10I+mj3wsQVVMrdEcYXTQ8NX9r9fpbrmCBAS1BDIB/R5QE7vxbbtdOx1L1wsytxbbA
         BNjDeWdO9to2TapfTa7GW/fswbeqhY3NERX9NoVauO6ATe0jAqWGHNPTtpmH+F8Pyqxt
         Dyqg==
X-Gm-Message-State: AOJu0YyVbWODi4QTry/N+Fm+cpQAbPxdsZ2owBeVWs3jOLmyySJR5nhQ
        ke2utA3w2PZpsuVmb4MJgkUe7QOmd5y/WHlCss/3c9AuTaPjShepfy8Er7ZNJEF3NfWrBJt/ucr
        3nhhOL5nwSpRKNzp5MdH1rD0qvAYBynfcXSiPMA==
X-Received: by 2002:a17:903:41ce:b0:1cc:5dd4:7ce5 with SMTP id u14-20020a17090341ce00b001cc5dd47ce5mr7796782ple.19.1699566620556;
        Thu, 09 Nov 2023 13:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXBc2hXk+C70TRLFN9EyxRa5fj9jL7XbLvgzaeG0AtHwvCIMfkAS4K9wOLN8chphWgrxWpDONaVxp+KNblyCM=
X-Received: by 2002:a17:903:41ce:b0:1cc:5dd4:7ce5 with SMTP id
 u14-20020a17090341ce00b001cc5dd47ce5mr7796770ple.19.1699566620259; Thu, 09
 Nov 2023 13:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-2-willy@infradead.org>
In-Reply-To: <20231107212643.3490372-2-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 9 Nov 2023 22:50:08 +0100
Message-ID: <CAHc6FU54SzUm-0eF-GYX2B7w0xTWQ+N6nLx+0xAFshsWUdq2qA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Willy,

On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Instead of unmapping the folio after copying the data to it, then mapping
> it again to zero the tail, provide folio_zero_tail() to zero the tail
> of an already-mapped folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/inline.c        |  3 +--
>  include/linux/highmem.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 9a84a5f9fef4..d5bd1e3a5d36 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -502,9 +502,8 @@ static int ext4_read_inline_folio(struct inode *inode=
, struct folio *folio)
>         BUG_ON(len > PAGE_SIZE);
>         kaddr =3D kmap_local_folio(folio, 0);
>         ret =3D ext4_read_inline_data(inode, kaddr, len, &iloc);
> -       flush_dcache_folio(folio);
> +       kaddr =3D folio_zero_tail(folio, len, kaddr + len);
>         kunmap_local(kaddr);
> -       folio_zero_segment(folio, len, folio_size(folio));
>         folio_mark_uptodate(folio);
>         brelse(iloc.bh);
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 4cacc0e43b51..1b81416196dd 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -483,6 +483,44 @@ static inline void memcpy_to_folio(struct folio *fol=
io, size_t offset,
>         flush_dcache_folio(folio);
>  }
>
> +/**
> + * folio_zero_tail - Zero the tail of a folio.
> + * @folio: The folio to zero.
> + * @kaddr: The address the folio is currently mapped to.
> + * @offset: The byte offset in the folio to start zeroing at.
> + *

As Andrew has pointed out, the order of the arguments in the
description doesn't match the order in the function definition. Other
than that, this patch looks good, so

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> + * If you have already used kmap_local_folio() to map a folio, written
> + * some data to it and now need to zero the end of the folio (and flush
> + * the dcache), you can use this function.  If you do not have the
> + * folio kmapped (eg the folio has been partially populated by DMA),
> + * use folio_zero_range() or folio_zero_segment() instead.
> + *
> + * Return: An address which can be passed to kunmap_local().
> + */
> +static inline __must_check void *folio_zero_tail(struct folio *folio,
> +               size_t offset, void *kaddr)
> +{
> +       size_t len =3D folio_size(folio) - offset;
> +
> +       if (folio_test_highmem(folio)) {
> +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> +
> +               while (len > max) {
> +                       memset(kaddr, 0, max);
> +                       kunmap_local(kaddr);
> +                       len -=3D max;
> +                       offset +=3D max;
> +                       max =3D PAGE_SIZE;
> +                       kaddr =3D kmap_local_folio(folio, offset);
> +               }
> +       }
> +
> +       memset(kaddr, 0, len);
> +       flush_dcache_folio(folio);
> +
> +       return kaddr;
> +}
> +
>  /**
>   * memcpy_from_file_folio - Copy some bytes from a file folio.
>   * @to: The destination buffer.
> --
> 2.42.0
>

Thanks,
Andreas


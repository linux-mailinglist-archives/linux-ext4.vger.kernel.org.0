Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894287E73F5
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Nov 2023 22:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjKIVvu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Nov 2023 16:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjKIVvo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Nov 2023 16:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304503AA8
        for <linux-ext4@vger.kernel.org>; Thu,  9 Nov 2023 13:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699566659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEe5Lm1QSY9l0OHsCk0EbXQqbDGAdhAs53cCOGquA04=;
        b=X8QQJnCKtYJ/lmHZo204XsGeL7BQVhCtwfKESshqTCZT1t/paA0Aw+IP8L/UjYsblySvxO
        BDg0/Ck1wxit9Z7N7PjUlLRLgB4ol1eaeA1LOOkxACOZJ4N+VoFft+ZSIagDhN21SOBfG2
        CST8GPndm+gc1bRu3RWq/bL7JuXuGcg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-IdG6SxLJPL2V_pcdXCUmiA-1; Thu, 09 Nov 2023 16:50:58 -0500
X-MC-Unique: IdG6SxLJPL2V_pcdXCUmiA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc23f2226fso14510935ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 Nov 2023 13:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566657; x=1700171457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEe5Lm1QSY9l0OHsCk0EbXQqbDGAdhAs53cCOGquA04=;
        b=PlUH3KbvCzDixTNI94TBepHogQ+4WENarGujv/cs6DZEpWP5btROHugXF9NDenq4Zj
         e10zTos4gH3Bs8smhJ1CvcOiTP8ieIsLYRCSP7JaWgZubrhNQtIRLc2Qvd9WX+LFJHT+
         zAVET0JWSV6jw8av7TC3ERKYtVTmy9jHEkEAhNNX+nu94Z4M15KQcz0T6Z80JFLCIhQz
         3RlzwOvlOcDrA2Vpt/xF2tOrf52jL8uMd1IzoafvewAW+FfYzesFZliGHykkwlmHk2px
         XsOqPtyw78KOYI965UtRDhjF/xnZg46GV0xrAq7zRL6iu6LijDykFQTal3w3sM12Gpuf
         IOdA==
X-Gm-Message-State: AOJu0Yx3TJp1rUykZMbXY0+EjryB01bMH/v26TGqISwWY2e6/8S3VHNo
        LtfCpF3d//nlW3htRPRcXKQ9yeiXfWEttqWLSz/wNaVQnLsgUrQIhrr/QRVmCYA5to8e7PgYhhB
        aNakOq5U5wHJFvEjWtTqKdKz0mFzTAFjIl+yFNQ==
X-Received: by 2002:a17:903:32c8:b0:1cc:4985:fc04 with SMTP id i8-20020a17090332c800b001cc4985fc04mr7490406plr.66.1699566657071;
        Thu, 09 Nov 2023 13:50:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyG4JtpfIMVQSiIgVG/wUB85vTa7ZYZB8EAxgeOBn9j0yJtEeYqTI6/TevKMgPEnNnnhq8hyhOkkpCwkjzLqg=
X-Received: by 2002:a17:903:32c8:b0:1cc:4985:fc04 with SMTP id
 i8-20020a17090332c800b001cc4985fc04mr7490395plr.66.1699566656820; Thu, 09 Nov
 2023 13:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-3-willy@infradead.org>
In-Reply-To: <20231107212643.3490372-3-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 9 Nov 2023 22:50:45 +0100
Message-ID: <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
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

On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> The iomap code was limited to PAGE_SIZE bytes; generalise it to cover
> an arbitrary-sized folio, and move it to be a common helper.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c  | 14 ++------------
>  include/linux/highmem.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f72df2babe56..093c4515b22a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -305,28 +305,18 @@ static int iomap_read_inline_data(const struct ioma=
p_iter *iter,
>  {
>         const struct iomap *iomap =3D iomap_iter_srcmap(iter);
>         size_t size =3D i_size_read(iter->inode) - iomap->offset;
> -       size_t poff =3D offset_in_page(iomap->offset);
>         size_t offset =3D offset_in_folio(folio, iomap->offset);
> -       void *addr;
>
>         if (folio_test_uptodate(folio))
>                 return 0;
>
> -       if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
> -               return -EIO;
> -       if (WARN_ON_ONCE(size > PAGE_SIZE -
> -                        offset_in_page(iomap->inline_data)))
> -               return -EIO;
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
>         if (offset > 0)
>                 ifs_alloc(iter->inode, folio, iter->flags);
>
> -       addr =3D kmap_local_folio(folio, offset);
> -       memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - poff - size);
> -       kunmap_local(addr);
> -       iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
> +       folio_fill_tail(folio, offset, iomap->inline_data, size);
> +       iomap_set_range_uptodate(folio, offset, folio_size(folio) - offse=
t);
>         return 0;
>  }
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 1b81416196dd..0fbb60ffefc9 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -521,6 +521,44 @@ static inline __must_check void *folio_zero_tail(str=
uct folio *folio,
>         return kaddr;
>  }
>
> +/**
> + * folio_fill_tail - Copy some data to a folio and pad with zeroes.
> + * @folio: The destination folio.
> + * @offset: The offset into @folio at which to start copying.
> + * @from: The data to copy.
> + * @len: How many bytes of data to copy.
> + *
> + * This function is most useful for filesystems which support inline dat=
a.
> + * When they want to copy data from the inode into the page cache, this
> + * function does everything for them.  It supports large folios even on
> + * HIGHMEM configurations.
> + */
> +static inline void folio_fill_tail(struct folio *folio, size_t offset,
> +               const char *from, size_t len)
> +{
> +       char *to =3D kmap_local_folio(folio, offset);
> +
> +       VM_BUG_ON(offset + len > folio_size(folio));
> +
> +       if (folio_test_highmem(folio)) {
> +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> +
> +               while (len > max) {
> +                       memcpy(to, from, max);
> +                       kunmap_local(to);
> +                       len -=3D max;
> +                       from +=3D max;
> +                       offset +=3D max;
> +                       max =3D PAGE_SIZE;
> +                       to =3D kmap_local_folio(folio, offset);
> +               }
> +       }
> +
> +       memcpy(to, from, len);
> +       to =3D folio_zero_tail(folio, offset, to);

This needs to be:

to =3D folio_zero_tail(folio, offset  + len, to + len);

> +       kunmap_local(to);
> +}
> +
>  /**
>   * memcpy_from_file_folio - Copy some bytes from a file folio.
>   * @to: The destination buffer.
> --
> 2.42.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas


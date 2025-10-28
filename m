Return-Path: <linux-ext4+bounces-11116-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D66C1642A
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB624188E4F2
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85417345751;
	Tue, 28 Oct 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0hGLHRNV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3826B2D5
	for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673411; cv=none; b=DVTkMNCe7/1CDukCnBRnJNXZAf499z2mWcn/VzM/zvrrccBFuw7du+YFVf8AJDOfAwQhsdN6maQLbGrazzv6Xf9+ZOb2kJLU0L3Ls0iOQk50/qdqCkY8uXpTA0zN2MUkyUhDuC5moH+CnK/dIm5044VauDMZhV0uVxe6SJO0MWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673411; c=relaxed/simple;
	bh=OJsTYMzbe/UDLrK6Bw+bsAXFWG7YtvhKytf26d44Q68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtDHFHd+cnmtmqNuGZk/WBVD2Mo+EmDcfSJDCWwRvhu51C9vq72QGVIpuM8Os2l/X415IXc2HCYhZLrxLlAVyztLwU2C8cgBXtmb1d6wn9ltPmM/WbCV9Sh4vlPli9rHDXCCC6OHBNj5UI/gXWaV5UfR8tFTooYP+K6Ly50mVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0hGLHRNV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ecfafb92bcso26071cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761673408; x=1762278208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm84HDvajvdUeYx0RetHD/996j4kdkLd2nXgDOVyMuw=;
        b=0hGLHRNV7cCeSwAeH+GuHFgtA8k5j+LWuR2nhN0elJcozyqqKbfxnwsAeZ/SVMwyxO
         ElWekUQEzyrULtBVoQJvDMDFGFpF9fTlitKzfzVz/jj8hTGjpId2P0UZDWWcZZJlR6OI
         gCiB2/TS9wOIUN+Rf3JUH4zdk7l7H1xAN2nLbukIHwQYkpmylq104gUamdkON6s/vs+F
         kF0pPtvk3H/NclTvnd705OgakJYf63UyiH7as2vOzQX12vUztOKk5O1GwRouxUPtl9NU
         Ge1i8wEN4/XmevbzxUQLu1u/fSOir0KpJzUQgDbhTK22fWJ5wqHKxHtad0YVsle2YHda
         HVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673408; x=1762278208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm84HDvajvdUeYx0RetHD/996j4kdkLd2nXgDOVyMuw=;
        b=OlXWuGwAWr+1EsNGgq2/4qSG3d1UhAxWFEuX+CDCvODn0gNuOHQW6Z4lVRPJgmYUWR
         eqM/7NmpztkO2ld+CkEehXfJNoaAHbFmNRljvGgZ3q5YB09DLJr+w60flv9gzdOwkht5
         t5mIj5qGtFLlAPSb+AOW2IE5v5qrWgyFeloWEUQnI/V5YW05IZCJKFd+WlnndMb96cbC
         8BxOtl4cbnLLko3UkdSm8gM+YBQiOClwclgNdeR1HAd2lMMkSG33FRdKFLvF7TrwbUQm
         w00z5wI4LWBjmcCYtkxbQu0v3YNZc0HvUijOrLG1RJg2/EdBo2C0qJi2sEIaUTftQZt5
         SF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXmX60YNs6AJl4V66G1ApYXXROPpVuK7fP8FqJYIU5288KFE2eSefO2U4X6EVSr63kDoCPXJEiC1Am@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XVA0uk83zwIfVDPrWDLLkAI/P0sEtLrs//YF97Tod7qefUqF
	3B7mPkbAzUXOYrG14q23GFyZFJ+YxBjedhgUIbZ+T4xikNi1SlWIPMbYj0YK/tkCgA6AVAQlZBi
	RMWLptgBFcEkrWe4BFkqoyrOl+Pn/trToobeoXCon
X-Gm-Gg: ASbGnct5GpiuCjGBV/jwoXSuaen04HMU5kvvIo7nV+fvyPL0uB/wKJJGubrtkdXkgi2
	2rtEbipu30ZbBD9TNhMYglDG4psuaZpjRb5+NEcBobPpWUYdqornJjI/EOO38Gco7aY1oLIdFOb
	lRDgHn3b2yuNCPe7X4db35QIJuQE5splnanuIJ3ldtth/1aOwrzxK0W9Ed3EV4/nbRjtxebYuBp
	nH+kuLf8QwK4VgaCcPl9X4B0qCI2XNgkbyEDKQOKOgWmxMhuZQahS9Ed9IqjJGjgdD84mgislyz
	OgAZweMhtDYEriwX9fzOGnv2LA==
X-Google-Smtp-Source: AGHT+IHqOw0wVAMZdI9HPTfn0JRAVi2UYS5cUsNnlCDAZHhG876N53Uqz0wugy8aVXJs9k9838Yo4Ajkv/Cn41vL3UM=
X-Received: by 2002:ac8:57c4:0:b0:4b7:a72f:55d9 with SMTP id
 d75a77b69052e-4ed1593d02dmr323231cf.13.1761673407812; Tue, 28 Oct 2025
 10:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-2-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-2-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 10:43:16 -0700
X-Gm-Features: AWmQ_bkEq6fU-X83NBs-FScowfdztSWFRPMtVvCpjCocisVvI5BwLCPHsCScVHY
Message-ID: <CAJuCfpF5gG63njY436vctG-Tzbco8X9a1w3YA=u1AGrRqxVshg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 1/7] mm/slab: allow specifying freepointer offset
 when using constructor
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@linux.com, dvyukov@google.com, glider@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, 
	shakeel.butt@linux.dev, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> When a slab cache has a constructor, the free pointer is placed after the
> object because certain fields must not be overwritten even after the
> object is freed.
>
> However, some fields that the constructor does not care can safely be
> overwritten. Allow specifying the free pointer offset within the object,
> reducing the overall object size when some fields can be reused for the
> free pointer.

Documentation explicitly says that ctor currently isn't supported with
custom free pointers:
https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/slab.h#L318
It obviously needs to be updated but I suspect there was a reason for
this limitation. Have you investigated why it's not supported? I
remember looking into it when I was converting vm_area_struct cache to
use SLAB_TYPESAFE_BY_RCU but I can't recall the details now...

>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slab_common.c | 2 +-
>  mm/slub.c        | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 932d13ada36c..2c2ed2452271 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -231,7 +231,7 @@ static struct kmem_cache *create_cache(const char *na=
me,
>         err =3D -EINVAL;
>         if (args->use_freeptr_offset &&
>             (args->freeptr_offset >=3D object_size ||
> -            !(flags & SLAB_TYPESAFE_BY_RCU) ||
> +            (!(flags & SLAB_TYPESAFE_BY_RCU) && !args->ctor) ||
>              !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
>                 goto out;
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 462a39d57b3a..64705cb3734f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7781,7 +7781,8 @@ static int calculate_sizes(struct kmem_cache_args *=
args, struct kmem_cache *s)
>         s->inuse =3D size;
>
>         if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset)=
 ||
> -           (flags & SLAB_POISON) || s->ctor ||
> +           (flags & SLAB_POISON) ||
> +           (s->ctor && !args->use_freeptr_offset) ||
>             ((flags & SLAB_RED_ZONE) &&
>              (s->object_size < sizeof(void *) || slub_debug_orig_size(s))=
)) {
>                 /*
> @@ -7802,7 +7803,8 @@ static int calculate_sizes(struct kmem_cache_args *=
args, struct kmem_cache *s)
>                  */
>                 s->offset =3D size;
>                 size +=3D sizeof(void *);
> -       } else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_of=
fset) {
> +       } else if (((flags & SLAB_TYPESAFE_BY_RCU) || s->ctor) &&
> +                       args->use_freeptr_offset) {
>                 s->offset =3D args->freeptr_offset;
>         } else {
>                 /*
> --
> 2.43.0
>


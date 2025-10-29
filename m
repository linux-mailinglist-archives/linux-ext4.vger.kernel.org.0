Return-Path: <linux-ext4+bounces-11343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2A5C1CCD6
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A623BAD55
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2F23563E5;
	Wed, 29 Oct 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJV5p6RE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860D34C992
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763062; cv=none; b=tRPWqAeQBFte0lYYclfgnhyu9scu73CVYYAznnWrDY9oCikeZUeUp+geSzHWAF66SVtb3TLPeQdpzUJYr0gUYQtEFrGazSaGaXsOTbj1zOaHif+EGPorjql92FFFfeXwRVdwD+NonN5mai9Z2CNEEFtGEyaaAn2FjRqi7RdWdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763062; c=relaxed/simple;
	bh=JxdckZEdQVjJ+khKcTG+6goKRNqw2mO+welbJB63stY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+kgb9u63gV5QGQiwqszovhP1311m3NDj0x8jtU7N/S4iLBh31HRPq8CYInTaMVmd8ggL50uzy7FkKsMPRy94aDngvZXWAQftam8qI1zV9xco4ygHWgxGLwxIknqqzm0mTGHVQjxJY7bCpgKp5/+H2YhX6QUUemiCxVsitLvo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJV5p6RE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ea12242d2eso41841cf.1
        for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 11:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761763059; x=1762367859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Ey8iYhsNV4DmLuQuvf3CrjlZXkohripqbrbq2UPM8=;
        b=NJV5p6REtxHXbS1mXVdIjSac42pc0P+ixo/enyw6MRaDqdyfQl0gVNvkld1HZ19DeE
         RdyB4hfPd7p61yr9YQ/DUtnPnPTqPm4/dDn+v4lnFoX82WR5yerXvMrbQ07QBOR/QMO+
         AN/kJZhgA6zOAQRy4PEk8F4vSmS/y3kwpVa39oG3rIhwdsvuG+KxH3pX6l0nsZaU0FAb
         nS8Wmw0hf3CGlDBkuTqB2P5ncrZGdTkXncTPPIKjD3E+s1uc7IPDRGfRD9w+yXh9UNQN
         txGpEl+r48yIoepswBhnQ+sFRQ6rNNwucGDKmZDcG+4L5w96Yx+pGo5H0qMYolzAjI6R
         AHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761763059; x=1762367859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9Ey8iYhsNV4DmLuQuvf3CrjlZXkohripqbrbq2UPM8=;
        b=Cx/7/VdZjvFFphUAgQZUZafhr6WSgdNa9rGbLFZu7DV7y4VwPECFK0sVW9LhBuHKJf
         W3dRRIWTVZwqLKoTDcCau7lw+esjexi+EX+bcZ21I8XiZUL0KUiHYLynvrP6R1mYOejE
         OCpcuXBDwdQNEKodGRkk5vKV2p1/m6cpN4Mp1lFsMxLyLa0a4NiE4x3xV64rvLSe4wum
         B19e21nwEs10dFIZdoRpVj0frt/dRYqWZUyyZE1U5SKg5Dcea6lovjpj6gps/fOw5LgG
         0+Laa/9q0ZV+bJoNKYXHPRc7pT77/apefNicPhHNHEOII73ctY2PwIp0E7aJcaSs3FnC
         tozw==
X-Forwarded-Encrypted: i=1; AJvYcCWGXABPPUFZYN5+OxVkYHINeTQwYbcILdcDqaJS866RFy2r6mstE3ISXxpK4SQbuXmxaFiMtdumxGii@vger.kernel.org
X-Gm-Message-State: AOJu0YzyS47g2OuefxUVxoqu3+acSKc3flRXrSmwFmjwklYE6bc/ZzYK
	B/oqheaRyIgTYib2POqr3SU2wAPSrQu+5StuQsPIVznXz7pgaSZLGLn2/OmjkPLAD5/9hDd6gJw
	AfVCvLrEjAiOQbVT+sV0Z8a5ivy7RCN/10D0TPKq9
X-Gm-Gg: ASbGncvPvFlDtSNaIMme2mr40B/20/MSNgZwABFBLMgebIKxq5J+wPRFdbBQ1C2VtfK
	tx1jHCOkLjw/Gw8gfaMTnmypZaO5P4tEXDRJPcoXYXbxo1izlMqFuq+OtKe5oxo/XzUnIoH3cE1
	UustqaSgJq1gm71opsxecRJP21tyDUBNCirfB1jowemV54eHbCs7nIP1jUN4U20liU13Njdhm17
	HB7OUcpX8LfnOA6NPXsXUaSzHQLAlomV7KWCSdD+xwIs/Wn4jIi4+PFmmb7VbTaK8MVvaQ8l/8n
	RdYmBs9ApGfxLJ4=
X-Google-Smtp-Source: AGHT+IH8IJb4mdzugiyUJiKdhE834SZN43FZI5L8PRxmHgVcBPjtH4b1oNSC1LgJcs2h4W7p2Gjsrm8SLTOCSL+1dcU=
X-Received: by 2002:a05:622a:1a10:b0:4e6:e07f:dc98 with SMTP id
 d75a77b69052e-4ed225a220fmr699031cf.9.1761763058976; Wed, 29 Oct 2025
 11:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-7-harry.yoo@oracle.com>
 <CAJuCfpGY0h2d6VEAEa4kjH2yUMGDdke_QTFt6d+gb+kH=rnXyQ@mail.gmail.com> <aQHJfyoUN-tbnVFr@hyeyoo>
In-Reply-To: <aQHJfyoUN-tbnVFr@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 11:37:27 -0700
X-Gm-Features: AWmQ_bnE1BJ3ZIc4019sKWySDFgx82v_dnppIEExUnniJ2zZNGhyRwNQFzNWTEQ
Message-ID: <CAJuCfpFhaPTqtKbjrigptPJ-9kKJB--mPnicBzN1=rfJxhN3PQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 6/7] mm/slab: save memory by allocating slabobj_ext
 array from leftover
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

On Wed, Oct 29, 2025 at 1:00=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Oct 28, 2025 at 08:07:42PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > The leftover space in a slab is always smaller than s->size, and
> > > kmem caches for large objects that are not power-of-two sizes tend to=
 have
> > > a greater amount of leftover space per slab. In some cases, the lefto=
ver
> > > space is larger than the size of the slabobj_ext array for the slab.
> > >
> > > An excellent example of such a cache is ext4_inode_cache. On my syste=
m,
> > > the object size is 1144, with a preferred order of 3, 28 objects per =
slab,
> > > and 736 bytes of leftover space per slab.
> > >
> > > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > > fits within the leftover space.
> > >
> > > Allocate the slabobj_exts array from this unused space instead of usi=
ng
> > > kcalloc(), when it is large enough. The array is always allocated whe=
n
> > > creating new slabs, because implementing lazy allocation correctly is
> > > difficult without expensive synchronization.
> > >
> > > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > > MEM_ALLOC_PROFILING are not used for the cache, only allocate the
> > > slabobj_ext array only when either of them are enabled when slabs are
> > > created.
> > >
> > > [ MEMCG=3Dy, MEM_ALLOC_PROFILING=3Dn ]
> > >
> > > Before patch (creating 2M directories on ext4):
> > >   Slab:            3575348 kB
> > >   SReclaimable:    3137804 kB
> > >   SUnreclaim:       437544 kB
> > >
> > > After patch (creating 2M directories on ext4):
> > >   Slab:            3558236 kB
> > >   SReclaimable:    3139268 kB
> > >   SUnreclaim:       418968 kB (-18.14 MiB)
> > >
> > > Enjoy the memory savings!
> > >
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  mm/slub.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 142 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 13acc9437ef5..8101df5fdccf 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct sla=
b *slab)
> > > +{
> > > +       unsigned long obj_exts;
> > > +
> > > +       if (!obj_exts_fit_within_slab_leftover(s, slab))
> > > +               return false;
> > > +
> > > +       obj_exts =3D (unsigned long)slab_address(slab);
> > > +       obj_exts +=3D obj_exts_offset_in_slab(s, slab);
> > > +       return obj_exts =3D=3D slab_obj_exts(slab);
> >
> > You can check that slab_obj_exts(slab) is not NULL before making the
> > above calculations.
>
> Did you mean this?
>
>   if (!slab_obj_exts(slab))
>       return false;

Yes but you can store the returned value to reuse later in the last
"return obj_exts =3D=3D slab_obj_exts(slab);" expression.


>
> If so, yes that makes sense.
>
> > > @@ -2185,6 +2311,11 @@ static inline void free_slab_obj_exts(struct s=
lab *slab)
> > >  {
> > >  }
> > >
> > > +static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
> > > +                                                      struct slab *s=
lab)
> > > +{
> > > +}
> > > +
> > >  #endif /* CONFIG_SLAB_OBJ_EXT */
> > >
> > >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > > @@ -3155,7 +3286,9 @@ static inline bool shuffle_freelist(struct kmem=
_cache *s, struct slab *slab)
> > >  static __always_inline void account_slab(struct slab *slab, int orde=
r,
> > >                                          struct kmem_cache *s, gfp_t =
gfp)
> > >  {
> > > -       if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > > +       if (memcg_kmem_online() &&
> > > +                       (s->flags & SLAB_ACCOUNT) &&
> > > +                       !slab_obj_exts(slab))
> > >                 alloc_slab_obj_exts(slab, s, gfp, true);
> >
> > Don't you need to add a check for !obj_exts_in_slab() inside
> > alloc_slab_obj_exts() to avoid allocating slab->obj_exts?
>
> slab_obj_exts() should have returned a nonzero value
> and then we don't call alloc_slab_obj_exts()?

Sorry, I mean that you would need to check
obj_exts_fit_within_slab_leftover() inside alloc_slab_obj_exts() to
avoid allocating the vector when obj_exts can fit inside the slab
itself. This is because alloc_slab_obj_exts() can be called from other
places as well. However, from your next comment, I realize that your
intention might have been to keep those other callers intact and
allocate the vector separately even if the obj_exts could have been
squeezed inside the slab. Is that correct?

>
> > >         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> > > @@ -3219,9 +3352,6 @@ static struct slab *allocate_slab(struct kmem_c=
ache *s, gfp_t flags, int node)
> > >         slab->objects =3D oo_objects(oo);slab_obj_exts
> > >         slab->inuse =3D 0;
> > >         slab->frozen =3D 0;
> > > -       init_slab_obj_exts(slab);
> > > -
> > > -       account_slab(slab, oo_order(oo), s, flags);
> > >
> > >         slab->slab_cache =3D s;
> > >
> > > @@ -3230,6 +3360,13 @@ static struct slab *allocate_slab(struct kmem_=
cache *s, gfp_t flags, int node)
> > >         start =3D slab_address(slab);
> > >
> > >         setup_slab_debug(s, slab, start);
> > > +       init_slab_obj_exts(slab);
> > > +       /*
> > > +        * Poison the slab before initializing the slabobj_ext array
> > > +        * to prevent the array from being overwritten.
> > > +        */
> > > +       alloc_slab_obj_exts_early(s, slab);
> > > +       account_slab(slab, oo_order(oo), s, flags);
> >
> >  alloc_slab_obj_exts() is called in 2 other places:
> > 1. __memcg_slab_post_alloc_hook()
> > 2. prepare_slab_obj_exts_hook()
> >
> > Don't you need alloc_slab_obj_exts_early() there as well?
>
> That's good point, and I thought it's difficult to address
> concurrency problem without using a per-slab lock.
>
> Thread A                    Thread B
> - sees slab->obj_exts =3D=3D 0
>                             - sees slab->obj_exts =3D=3D 0
>                             - allocates the vector from unused space
>                               and initializes it.
>                             - try cmpxchg()
> - allocates the vector
>   from unused space and
>   initializes it.
>   (the vector is already
>    in use and it's overwritten!)
>
> - try cmpxchg()
>
> But since this is slowpath, using slab_{lock,unlock}() here is probably
> fine. What do you think?

Ok, was your original intent to leave these callers as is and allocate
the vector like we do today even if obj_exts fit inside the slab?

>
> --
> Cheers,
> Harry / Hyeonggon


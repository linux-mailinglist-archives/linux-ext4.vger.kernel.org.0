Return-Path: <linux-ext4+bounces-11321-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8CC181F2
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 04:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9D63B81FC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 03:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E002EC08D;
	Wed, 29 Oct 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RV50ncpf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35F2DC78D
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 03:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707278; cv=none; b=uKwF4CCHNXvC1cxpJpn9FQb23dDk8YatXeYXiCBS90jIghHJL95/vwfhAFvdg/WHiOmjLk5rG9PVe3NWhaSqB9ZgPbJSUp0L8OoePZCzdBktrO8NM8/pc1miBOvhTdbdzzBbeuoR3rtcyGeZG+WbssJHIW9SD7oJQn65hr/4j3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707278; c=relaxed/simple;
	bh=abfGEIbFNr2KW+rb9Afc7xPHj4W5l1xLUmZusC66tvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Idl51FrezHAxxN4XwrZCZnBLCjHqCD7YdJZoEk+nrrh/oqTbP7b40cki0nwmTfoTRLborZ94TCL1/9XKL1F+aWEPjrVd8ij2sZJ28zqvYwhj+FEhDFDsI80WaRE2+C6eS4lCByUEssgO/ak3FoyMdQfY9s18TSwc1iRv0MCzTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RV50ncpf; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ecfafb92bcso134441cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 20:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761707275; x=1762312075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaWOKKkkRsdmyBWJZ4jc5bh/UT1GoLzP1sDM1wf19po=;
        b=RV50ncpftCr4DM1xG2aWmZnsfPB/4BQQOUYjyRUIWId9YJRZfHeINSKLW/dY+nw5B5
         qxO8SXxeRg2yjh5zIHMXiXbGStj1G9AcGdK8pkjnWKfBDvi3JDC8VwCAp5xlsITLrFka
         XKGtu6SwUNzVAM2L2H1R165P2jaYMm5J0/yAe8+o0makoSljTCbV74vS6QD9k2QtndXC
         PQ7DERN2oC/YDfPTVKwgvs+wvEQcu5ZvyEs/Unexc0Yn2mc2sugo3SlFXfexesohym0Q
         4848KapdPm4CFDBUA7Q8xhnYssfahB0fA0K6JEQ5WIMsUIqPlKZfyPPNGzJF78QRXkoU
         Wtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761707275; x=1762312075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaWOKKkkRsdmyBWJZ4jc5bh/UT1GoLzP1sDM1wf19po=;
        b=k8U34Z7GzBiaZgr2aFk1xDx/w8tpddb9W0tddfVVco/e9Mxl5gRtWfmqp86S6n9FQ/
         /Nc7/75PXvV5BNujeWLpe0k2Npd1fGXfrfMBBdgUsTxInr8xLu+PQuJ7QCqHCOXp71Z8
         hYAe3yKxddQwJPvwltvKVQe5nW9hn1GNFrgZtDFFTsqCvgKCpZFNF83RTmJTnp42nzol
         qscniRYZfqAq8o7suQxJ5Z42xqMsABUHiwWk7aTLtHFKvFGBbXbJHbQ+qqLYpehqWEAW
         9eeTe2DQ7SZ3kcmPc0Ho4M4xRCNlCNMM8OBZVQfBbeuhgAK8+qVpFbKdpz0CoVHGaWiV
         S8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk20WflaajkkfPF5LohZwcTEQjIaD42kSv1QM5DuXYC3aSYHRAn1ds4k4VKvzEgxL/oSBiNWwv/Id6@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+KjiOfJ+PTha/RMtEqIl+hNoSue+V3VCSp0tmTbXXZLtLfco
	3G6XJrw4beAbNUabHQojgLuuPZUPUcZ+ULFNeYMW1NIqwSb7qzoDlWSX185zCXlVJBGICc2fmFN
	pGL9DnjU5KKBfs1W8o5rTucOyj+mde1JhY2oHvP3G
X-Gm-Gg: ASbGnctX7JFdQmDoYGJfhEsdYNh3eX8Ds3SmFITqmntEfJkf3YvuAvdupQ4Ej+1Mj8Y
	+oLvfs7Gk/Z0cVSKBERt9nrUUUfL5OolKTELclthwglmPTky96I9uPx1znYKeWZrqe+vgmEQBoa
	ZKNjG8FZikMG8+pt1NA7OJDhuA99MgMO6Vz7/59Whfc48C8J5W1uaGMFuT2bOfWy1oBfrNrhnfq
	rOgKMQkpHoJ1XyYSI7hMr6Jk/B+CGvcLz/fyoy/AdSvbevbjfWUc15qOD8s6SpbsbDUbQ==
X-Google-Smtp-Source: AGHT+IGR25PwQaLqmJ5rY9EBaAEdLAPQJDuXw/9ST8rJRTTwp62lE6PuWrSM+BQMx0U7Z2OGGytFG0CIxBKZdsAq028=
X-Received: by 2002:a05:622a:53c4:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ed16580052mr2242901cf.5.1761707274919; Tue, 28 Oct 2025
 20:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-7-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-7-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 20:07:42 -0700
X-Gm-Features: AWmQ_blIZCXemcxp_kCAoc_ArhIEAXqf9CHgTRdQdgcyRfAQOBZ2sKmzOJ1YHEU
Message-ID: <CAJuCfpGY0h2d6VEAEa4kjH2yUMGDdke_QTFt6d+gb+kH=rnXyQ@mail.gmail.com>
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

On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> The leftover space in a slab is always smaller than s->size, and
> kmem caches for large objects that are not power-of-two sizes tend to hav=
e
> a greater amount of leftover space per slab. In some cases, the leftover
> space is larger than the size of the slabobj_ext array for the slab.
>
> An excellent example of such a cache is ext4_inode_cache. On my system,
> the object size is 1144, with a preferred order of 3, 28 objects per slab=
,
> and 736 bytes of leftover space per slab.
>
> Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> fits within the leftover space.
>
> Allocate the slabobj_exts array from this unused space instead of using
> kcalloc(), when it is large enough. The array is always allocated when
> creating new slabs, because implementing lazy allocation correctly is
> difficult without expensive synchronization.
>
> To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> MEM_ALLOC_PROFILING are not used for the cache, only allocate the
> slabobj_ext array only when either of them are enabled when slabs are
> created.
>
> [ MEMCG=3Dy, MEM_ALLOC_PROFILING=3Dn ]
>
> Before patch (creating 2M directories on ext4):
>   Slab:            3575348 kB
>   SReclaimable:    3137804 kB
>   SUnreclaim:       437544 kB
>
> After patch (creating 2M directories on ext4):
>   Slab:            3558236 kB
>   SReclaimable:    3139268 kB
>   SUnreclaim:       418968 kB (-18.14 MiB)
>
> Enjoy the memory savings!
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slub.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 142 insertions(+), 5 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 13acc9437ef5..8101df5fdccf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -884,6 +884,94 @@ static inline unsigned int get_orig_size(struct kmem=
_cache *s, void *object)
>         return *(unsigned int *)p;
>  }
>
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +
> +/*
> + * Check if memory cgroup or memory allocation profiling is enabled.
> + * If enabled, SLUB tries to reduce memory overhead of accounting
> + * slab objects. If neither is enabled when this function is called,
> + * the optimization is simply skipped to avoid affecting caches that do =
not
> + * need slabobj_ext metadata.
> + *
> + * However, this may disable optimization when memory cgroup or memory
> + * allocation profiling is used, but slabs are created too early
> + * even before those subsystems are initialized.
> + */
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +       if (!mem_cgroup_disabled() && (s->flags & SLAB_ACCOUNT))
> +               return true;
> +
> +       if (mem_alloc_profiling_enabled())
> +               return true;
> +
> +       return false;
> +}
> +
> +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> +{
> +       return sizeof(struct slabobj_ext) * slab->objects;
> +}
> +
> +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s=
,
> +                                                   struct slab *slab)
> +{
> +       unsigned long objext_offset;
> +
> +       objext_offset =3D s->red_left_pad + s->size * slab->objects;
> +       objext_offset =3D ALIGN(objext_offset, sizeof(struct slabobj_ext)=
);
> +       return objext_offset;
> +}
> +
> +static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *=
s,
> +                                                    struct slab *slab)
> +{
> +       unsigned long objext_offset =3D obj_exts_offset_in_slab(s, slab);
> +       unsigned long objext_size =3D obj_exts_size_in_slab(slab);
> +
> +       return objext_offset + objext_size <=3D slab_size(slab);
> +}
> +
> +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *s=
lab)
> +{
> +       unsigned long obj_exts;
> +
> +       if (!obj_exts_fit_within_slab_leftover(s, slab))
> +               return false;
> +
> +       obj_exts =3D (unsigned long)slab_address(slab);
> +       obj_exts +=3D obj_exts_offset_in_slab(s, slab);
> +       return obj_exts =3D=3D slab_obj_exts(slab);

You can check that slab_obj_exts(slab) is not NULL before making the
above calculations.

> +}
> +#else
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +       return false;
> +}
> +
> +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> +{
> +       return 0;
> +}
> +
> +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s=
,
> +                                                   struct slab *slab)
> +{
> +       return 0;
> +}
> +
> +static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *=
s,
> +                                                    struct slab *slab)
> +{
> +       return false;
> +}
> +
> +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *s=
lab)
> +{
> +       return false;
> +}
> +#endif
> +
>  #ifdef CONFIG_SLUB_DEBUG
>
>  /*
> @@ -1404,7 +1492,15 @@ slab_pad_check(struct kmem_cache *s, struct slab *=
slab)
>         start =3D slab_address(slab);
>         length =3D slab_size(slab);
>         end =3D start + length;
> -       remainder =3D length % s->size;
> +
> +       if (obj_exts_in_slab(s, slab)) {
> +               remainder =3D length;
> +               remainder -=3D obj_exts_offset_in_slab(s, slab);
> +               remainder -=3D obj_exts_size_in_slab(slab);
> +       } else {
> +               remainder =3D length % s->size;
> +       }
> +
>         if (!remainder)
>                 return;
>
> @@ -2154,6 +2250,11 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>         if (!obj_exts)
>                 return;
>
> +       if (obj_exts_in_slab(slab->slab_cache, slab)) {
> +               slab->obj_exts =3D 0;
> +               return;
> +       }
> +
>         /*
>          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
>          * corresponding extension will be NULL. alloc_tag_sub() will thr=
ow a
> @@ -2169,6 +2270,31 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>         slab->obj_exts =3D 0;
>  }
>
> +/*
> + * Try to allocate slabobj_ext array from unused space.
> + * This function must be called on a freshly allocated slab to prevent
> + * concurrency problems.
> + */
> +static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab =
*slab)
> +{
> +       void *addr;
> +
> +       if (!need_slab_obj_exts(s))
> +               return;
> +
> +       metadata_access_enable();
> +       if (obj_exts_fit_within_slab_leftover(s, slab)) {
> +               addr =3D slab_address(slab) + obj_exts_offset_in_slab(s, =
slab);
> +               addr =3D kasan_reset_tag(addr);
> +               memset(addr, 0, obj_exts_size_in_slab(slab));
> +               slab->obj_exts =3D (unsigned long)addr;
> +               if (IS_ENABLED(CONFIG_MEMCG))
> +                       slab->obj_exts |=3D MEMCG_DATA_OBJEXTS;
> +               slab_set_stride(slab, sizeof(struct slabobj_ext));
> +       }
> +       metadata_access_disable();
> +}
> +
>  #else /* CONFIG_SLAB_OBJ_EXT */
>
>  static inline void init_slab_obj_exts(struct slab *slab)
> @@ -2185,6 +2311,11 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>  {
>  }
>
> +static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
> +                                                      struct slab *slab)
> +{
> +}
> +
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
> @@ -3155,7 +3286,9 @@ static inline bool shuffle_freelist(struct kmem_cac=
he *s, struct slab *slab)
>  static __always_inline void account_slab(struct slab *slab, int order,
>                                          struct kmem_cache *s, gfp_t gfp)
>  {
> -       if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> +       if (memcg_kmem_online() &&
> +                       (s->flags & SLAB_ACCOUNT) &&
> +                       !slab_obj_exts(slab))
>                 alloc_slab_obj_exts(slab, s, gfp, true);

Don't you need to add a check for !obj_exts_in_slab() inside
alloc_slab_obj_exts() to avoid allocating slab->obj_exts?

>
>         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> @@ -3219,9 +3352,6 @@ static struct slab *allocate_slab(struct kmem_cache=
 *s, gfp_t flags, int node)
>         slab->objects =3D oo_objects(oo);slab_obj_exts
>         slab->inuse =3D 0;
>         slab->frozen =3D 0;
> -       init_slab_obj_exts(slab);
> -
> -       account_slab(slab, oo_order(oo), s, flags);
>
>         slab->slab_cache =3D s;
>
> @@ -3230,6 +3360,13 @@ static struct slab *allocate_slab(struct kmem_cach=
e *s, gfp_t flags, int node)
>         start =3D slab_address(slab);
>
>         setup_slab_debug(s, slab, start);
> +       init_slab_obj_exts(slab);
> +       /*
> +        * Poison the slab before initializing the slabobj_ext array
> +        * to prevent the array from being overwritten.
> +        */
> +       alloc_slab_obj_exts_early(s, slab);
> +       account_slab(slab, oo_order(oo), s, flags);

 alloc_slab_obj_exts() is called in 2 other places:
1. __memcg_slab_post_alloc_hook()
2. prepare_slab_obj_exts_hook()

Don't you need alloc_slab_obj_exts_early() there as well?

>
>         shuffle =3D shuffle_freelist(s, slab);
>
> --
> 2.43.0
>


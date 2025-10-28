Return-Path: <linux-ext4+bounces-11117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E96E4C165A1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 19:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A15150910A
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C434C9AF;
	Tue, 28 Oct 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5pqJX0Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540B34C9A1
	for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674154; cv=none; b=GCNaZvrRgooG9S2pLdEKp8a4p6ZTdryUnOjuKiXq4BxYBiA1Avl7dtuqJbB11xJ0b0sOVCHiGh6eazwjz80V0qrwOfs+nn9xDqUema9d8lVKNOVyYLVT1yjqU2rYkbq7k32kEmYCTQ/5BYeyGrJLRGXK9ST4R9OmudnKNkO0BjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674154; c=relaxed/simple;
	bh=vq5e8fIjrWj9RhPW/Zc8fFi8d2F6f4O2//w8hDNaqoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgWsGmUnkoKLLTpgG+ivFghaicK9/YTXeH0uyY/JS/kn/8UN+kbVIKd/WWx7F0wxsZ42kkX7HokCJqKoCwaNZQXuftTFKtzodEw/4OF9iVWsT1WAw0bjPI+rguFSUgUtYtib2MqmlHIHuY8LUloojK1y7f/zbtp0NJpINMlo7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5pqJX0Q; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ecfafb92bcso31381cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761674151; x=1762278951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEQPDQeMOb+zP03ZLfbq8HiFiymDeHxHs9qyniKVrJQ=;
        b=t5pqJX0Qe/lJO3GH9UFPOx8JGGJ3/tfzn3uwkBN+XWOSEBM7v8NeYfcKW7gyHhXUCU
         n1MZkefLR7XnnftwyhV9z1NFT1umn3swzZyoTuMQBW+u7/y6EQaMGnrph0RW+o8+E2bU
         sQZXyrPCmdnpqAjX77VohrJrgpGU2OFHJ7EGrU7GVUnz+wEEVZZzD/ZUDGMJE4FrvXct
         WOnBzwRlmbB/O3lcJv5F6foEbQgsJu1wXY+T862/APLg5RQELQ9Jcndl96YBl8qQcOp0
         yuGxy3n8KtWtFMlX31Vc4kqGXWt1HeJgj9zhTXKPY8DIPqeaE4ODZZpX8oaT1yIHRqYw
         mkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674151; x=1762278951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEQPDQeMOb+zP03ZLfbq8HiFiymDeHxHs9qyniKVrJQ=;
        b=m+LOkrQYtCqZe6CzGlfKyqoHUvDs5TB2DThbULQ0j18gnCp2+fS/FrMJwUTYs7HJ9P
         8Y+AYi0u4Q7f/Z+O+ymCUwrTf7GgdjPOnMmLMTD1dZixr5Ah8z+uXoj+hhxrTwQBcewz
         5dML1pthleBmT++wZ6EhbVIHQIzv9/GmWwyPFbXc0GXGV7WZVsqfcyx8zjjC6vVBUf/j
         FbWSoqpa5jqkH601ZkEkJHnCh3mDuUJMJweNPvqSUbsaPa9SgEux30AxYDrzfCoxS2zU
         fBU+D7M1hw4/3D+K3wNPRKKnJA0SdGGdf97Vj4/liUfxfaAnSGgDacgHbA57/j0AKdHh
         BqUw==
X-Forwarded-Encrypted: i=1; AJvYcCXZOaFVsS0E0I2t0nfrz5KVSFN3guzYeGgtogP3tVWyGQStnZi4vQ2pIqPnB5U/QE8xrASzSWvjIOz7@vger.kernel.org
X-Gm-Message-State: AOJu0YxMLcNGvgH+/5ftnny6XVpT3fXbrXeMfwzOyAXSquBV7lAGpzk0
	rBxjb4r0I3qzhp4I3SiFdMVbayVlLoeAYriU6SXK5AIugDjXhD4INSDMT/XlxwqEv85Ko4tY6Y2
	+AQ6TiyUDPivwFuQldLDHsHND7W23qQRC6E6CG28h
X-Gm-Gg: ASbGncuYhyBnciBXqspVtkmY1zMgpuWp5/T72eG/QVCpOJntSGPWPHL6a9A6KVsBvHc
	QNiNASn7SKemd9q1WbsWd2yN5mDeTk7GJebV5KtIbPpF7HdtUtwpj0+Xd99ZlRj2mQooHJDGSH7
	afMDGaLSxydgGoSN6K1oZPNDHqHYt41yEsgfphCf3UKfhQzYlcKh5n4GrkGYcne/p3vSlhA3isM
	QxsrJqWTjIrLNeNrnFFHNwFB7z8qy9JbW4bCVFf9jRLxGNWkhfvafccZNtnhuI8aZQ2VUWiW01/
	CK/9yYiEx719eKRS3AB6RrGTAw==
X-Google-Smtp-Source: AGHT+IE4E344p3HvFpIsLYI5M9X4WV2Y7oB0kX580su6zBAwlKd1hdG3cfoOpCRO56waorA3KTYtH/DLpgCm8hLFEkg=
X-Received: by 2002:a05:622a:1307:b0:4e8:b04a:82e3 with SMTP id
 d75a77b69052e-4ed1588e627mr400851cf.10.1761674150355; Tue, 28 Oct 2025
 10:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-4-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-4-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 10:55:39 -0700
X-Gm-Features: AWmQ_bndOQ1c1b7afJ0YZYVN9VO4Il9GK8ViNlP50-zWVw6oU176SbWk_uCfUOQ
Message-ID: <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com>
Subject: Re: [RFC PATCH V3 3/7] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
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
> Currently, the slab allocator assumes that slab->obj_exts is a pointer
> to an array of struct slabobj_ext objects. However, to support storage
> methods where struct slabobj_ext is embedded within objects, the slab
> allocator should not make this assumption. Instead of directly
> dereferencing the slabobj_exts array, abstract access to
> struct slabobj_ext via helper functions.
>
> Introduce a new API slabobj_ext metadata access:
>
>   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
>   struct slabobj_ext element at the given index.
>
> Directly dereferencing the return value of slab_obj_exts() is no longer
> allowed. Instead, slab_obj_ext() must always be used to access
> individual struct slabobj_ext objects.

If direct access to the vector is not allowed, it would be better to
eliminate slab_obj_exts() function completely and use the new
slab_obj_ext() instead. I think that's possible. We might need an
additional `bool is_slab_obj_exts()` helper for an early check before
we calculate the object index but that's quite easy.

>
> Convert all users to use these APIs.
> No functional changes intended.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 23 ++++++++++++++++-------
>  mm/slab.h       | 43 ++++++++++++++++++++++++++++++++++++------
>  mm/slub.c       | 50 ++++++++++++++++++++++++++++---------------------
>  3 files changed, 82 insertions(+), 34 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8dd7fbed5a94..2a9dc246e802 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2566,7 +2566,8 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct=
 folio *folio, void *p)
>          * slab->obj_exts.
>          */
>         if (folio_test_slab(folio)) {
> -               struct slabobj_ext *obj_exts;
> +               unsigned long obj_exts;
> +               struct slabobj_ext *obj_ext;
>                 struct slab *slab;
>                 unsigned int off;
>
> @@ -2576,8 +2577,9 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct=
 folio *folio, void *p)
>                         return NULL;
>
>                 off =3D obj_to_index(slab->slab_cache, slab, p);
> -               if (obj_exts[off].objcg)
> -                       return obj_cgroup_memcg(obj_exts[off].objcg);
> +               obj_ext =3D slab_obj_ext(slab, obj_exts, off);
> +               if (obj_ext->objcg)
> +                       return obj_cgroup_memcg(obj_ext->objcg);
>
>                 return NULL;
>         }
> @@ -3168,6 +3170,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache=
 *s, struct list_lru *lru,
>         }
>
>         for (i =3D 0; i < size; i++) {
> +               unsigned long obj_exts;
> +               struct slabobj_ext *obj_ext;
> +
>                 slab =3D virt_to_slab(p[i]);
>
>                 if (!slab_obj_exts(slab) &&
> @@ -3190,29 +3195,33 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cac=
he *s, struct list_lru *lru,
>                                         slab_pgdat(slab), cache_vmstat_id=
x(s)))
>                         return false;
>
> +               obj_exts =3D slab_obj_exts(slab);
>                 off =3D obj_to_index(s, slab, p[i]);
> +               obj_ext =3D slab_obj_ext(slab, obj_exts, off);
>                 obj_cgroup_get(objcg);
> -               slab_obj_exts(slab)[off].objcg =3D objcg;
> +               obj_ext->objcg =3D objcg;
>         }
>
>         return true;
>  }
>
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -                           void **p, int objects, struct slabobj_ext *ob=
j_exts)
> +                           void **p, int objects, unsigned long obj_exts=
)
>  {
>         size_t obj_size =3D obj_full_size(s);
>
>         for (int i =3D 0; i < objects; i++) {
>                 struct obj_cgroup *objcg;
> +               struct slabobj_ext *obj_ext;
>                 unsigned int off;
>
>                 off =3D obj_to_index(s, slab, p[i]);
> -               objcg =3D obj_exts[off].objcg;
> +               obj_ext =3D slab_obj_ext(slab, obj_exts, off);
> +               objcg =3D obj_ext->objcg;
>                 if (!objcg)
>                         continue;
>
> -               obj_exts[off].objcg =3D NULL;
> +               obj_ext->objcg =3D NULL;
>                 refill_obj_stock(objcg, obj_size, true, -obj_size,
>                                  slab_pgdat(slab), cache_vmstat_idx(s));
>                 obj_cgroup_put(objcg);
> diff --git a/mm/slab.h b/mm/slab.h
> index d63cc9b5e313..df2c987d950d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -528,10 +528,12 @@ static inline bool slab_in_kunit_test(void) { retur=
n false; }
>   * associated with a slab.
>   * @slab: a pointer to the slab struct
>   *
> - * Returns a pointer to the object extension vector associated with the =
slab,
> - * or NULL if no such vector has been associated yet.
> + * Returns the address of the object extension vector associated with th=
e slab,
> + * or zero if no such vector has been associated yet.
> + * Do not dereference the return value directly; use slab_obj_ext() to a=
ccess
> + * its elements.
>   */
> -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> +static inline unsigned long slab_obj_exts(struct slab *slab)
>  {
>         unsigned long obj_exts =3D READ_ONCE(slab->obj_exts);
>
> @@ -544,7 +546,30 @@ static inline struct slabobj_ext *slab_obj_exts(stru=
ct slab *slab)
>                        obj_exts !=3D OBJEXTS_ALLOC_FAIL, slab_page(slab))=
;
>         VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
>  #endif
> -       return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
> +
> +       return obj_exts & ~OBJEXTS_FLAGS_MASK;
> +}
> +
> +/*
> + * slab_obj_ext - get the pointer to the slab object extension metadata
> + * associated with an object in a slab.
> + * @slab: a pointer to the slab struct
> + * @obj_exts: a pointer to the object extension vector
> + * @index: an index of the object
> + *
> + * Returns a pointer to the object extension associated with the object.
> + */
> +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> +                                              unsigned long obj_exts,
> +                                              unsigned int index)
> +{
> +       struct slabobj_ext *obj_ext;
> +
> +       VM_WARN_ON_ONCE(!slab_obj_exts(slab));
> +       VM_WARN_ON_ONCE(obj_exts !=3D slab_obj_exts(slab));
> +
> +       obj_ext =3D (struct slabobj_ext *)obj_exts;
> +       return &obj_ext[index];
>  }
>
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -552,7 +577,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct km=
em_cache *s,
>
>  #else /* CONFIG_SLAB_OBJ_EXT */
>
> -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> +static inline unsigned long slab_obj_exts(struct slab *slab)
> +{
> +       return false;
> +}
> +
> +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> +                                              unsigned int index)
>  {
>         return NULL;
>  }
> @@ -569,7 +600,7 @@ static inline enum node_stat_item cache_vmstat_idx(st=
ruct kmem_cache *s)
>  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru =
*lru,
>                                   gfp_t flags, size_t size, void **p);
>  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -                           void **p, int objects, struct slabobj_ext *ob=
j_exts);
> +                           void **p, int objects, unsigned long obj_exts=
);
>  #endif
>
>  void kvfree_rcu_cb(struct rcu_head *head);
> diff --git a/mm/slub.c b/mm/slub.c
> index 64705cb3734f..ae73403f8c29 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2031,7 +2031,7 @@ static bool freelist_corrupted(struct kmem_cache *s=
, struct slab *slab,
>
>  static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>  {
> -       struct slabobj_ext *slab_exts;
> +       unsigned long slab_exts;
>         struct slab *obj_exts_slab;
>
>         obj_exts_slab =3D virt_to_slab(obj_exts);
> @@ -2039,9 +2039,12 @@ static inline void mark_objexts_empty(struct slabo=
bj_ext *obj_exts)
>         if (slab_exts) {
>                 unsigned int offs =3D obj_to_index(obj_exts_slab->slab_ca=
che,
>                                                  obj_exts_slab, obj_exts)=
;
> +               struct slabobj_ext *ext =3D slab_obj_ext(obj_exts_slab,
> +                                                      slab_exts, offs);
> +
>                 /* codetag should be NULL */
> -               WARN_ON(slab_exts[offs].ref.ct);
> -               set_codetag_empty(&slab_exts[offs].ref);
> +               WARN_ON(ext->ref.ct);
> +               set_codetag_empty(&ext->ref);
>         }
>  }
>
> @@ -2159,7 +2162,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>
>  static inline void free_slab_obj_exts(struct slab *slab)
>  {
> -       struct slabobj_ext *obj_exts;
> +       unsigned long obj_exts;
>
>         obj_exts =3D slab_obj_exts(slab);
>         if (!obj_exts)
> @@ -2172,11 +2175,11 @@ static inline void free_slab_obj_exts(struct slab=
 *slab)
>          * NULL, therefore replace NULL with CODETAG_EMPTY to indicate th=
at
>          * the extension for obj_exts is expected to be NULL.
>          */
> -       mark_objexts_empty(obj_exts);
> +       mark_objexts_empty((struct slabobj_ext *)obj_exts);
>         if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
> -               kfree_nolock(obj_exts);
> +               kfree_nolock((void *)obj_exts);
>         else
> -               kfree(obj_exts);
> +               kfree((void *)obj_exts);
>         slab->obj_exts =3D 0;
>  }
>
> @@ -2201,9 +2204,10 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>  #ifdef CONFIG_MEM_ALLOC_PROFILING
>
>  static inline struct slabobj_ext *
> -prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
> +prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  {
>         struct slab *slab;
> +       unsigned long obj_exts;
>
>         if (!p)
>                 return NULL;
> @@ -2215,30 +2219,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, =
gfp_t flags, void *p)
>                 return NULL;
>
>         slab =3D virt_to_slab(p);
> -       if (!slab_obj_exts(slab) &&
> +       obj_exts =3D slab_obj_exts(slab);
> +       if (!obj_exts &&
>             alloc_slab_obj_exts(slab, s, flags, false)) {
>                 pr_warn_once("%s, %s: Failed to create slab extension vec=
tor!\n",
>                              __func__, s->name);
>                 return NULL;
>         }
>
> -       return slab_obj_exts(slab) + obj_to_index(s, slab, p);
> +       obj_exts =3D slab_obj_exts(slab);
> +       return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
>  }
>
>  /* Should be called only if mem_alloc_profiling_enabled() */
>  static noinline void
>  __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_=
t flags)
>  {
> -       struct slabobj_ext *obj_exts;
> +       struct slabobj_ext *obj_ext;
>
> -       obj_exts =3D prepare_slab_obj_exts_hook(s, flags, object);
> +       obj_ext =3D prepare_slab_obj_ext_hook(s, flags, object);
>         /*
>          * Currently obj_exts is used only for allocation profiling.
>          * If other users appear then mem_alloc_profiling_enabled()
>          * check should be added before alloc_tag_add().
>          */
> -       if (likely(obj_exts))
> -               alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size=
);
> +       if (likely(obj_ext))
> +               alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size)=
;
>  }
>
>  static inline void
> @@ -2253,8 +2259,8 @@ static noinline void
>  __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, =
void **p,
>                                int objects)
>  {
> -       struct slabobj_ext *obj_exts;
>         int i;
> +       unsigned long obj_exts;
>
>         /* slab->obj_exts might not be NULL if it was created for MEMCG a=
ccounting. */
>         if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
> @@ -2267,7 +2273,7 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s=
, struct slab *slab, void **p
>         for (i =3D 0; i < objects; i++) {
>                 unsigned int off =3D obj_to_index(s, slab, p[i]);
>
> -               alloc_tag_sub(&obj_exts[off].ref, s->size);
> +               alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s-=
>size);
>         }
>  }
>
> @@ -2326,7 +2332,7 @@ static __fastpath_inline
>  void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void =
**p,
>                           int objects)
>  {
> -       struct slabobj_ext *obj_exts;
> +       unsigned long obj_exts;
>
>         if (!memcg_kmem_online())
>                 return;
> @@ -2341,7 +2347,8 @@ void memcg_slab_free_hook(struct kmem_cache *s, str=
uct slab *slab, void **p,
>  static __fastpath_inline
>  bool memcg_slab_post_charge(void *p, gfp_t flags)
>  {
> -       struct slabobj_ext *slab_exts;
> +       unsigned long obj_exts;
> +       struct slabobj_ext *obj_ext;
>         struct kmem_cache *s;
>         struct folio *folio;
>         struct slab *slab;
> @@ -2381,10 +2388,11 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
>                 return true;
>
>         /* Ignore already charged objects. */
> -       slab_exts =3D slab_obj_exts(slab);
> -       if (slab_exts) {
> +       obj_exts =3D slab_obj_exts(slab);
> +       if (obj_exts) {
>                 off =3D obj_to_index(s, slab, p);
> -               if (unlikely(slab_exts[off].objcg))
> +               obj_ext =3D slab_obj_ext(slab, obj_exts, off);
> +               if (unlikely(obj_ext->objcg))
>                         return true;
>         }
>
> --
> 2.43.0
>


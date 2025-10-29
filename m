Return-Path: <linux-ext4+bounces-11322-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A7CC18292
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 04:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD4F3BE75B
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DF028466F;
	Wed, 29 Oct 2025 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5FOM64f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22228469F
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708013; cv=none; b=TrUipTL5aGjEnKQ3uJBHY6YA/yf8RGtP1/36QurQn+zVnWOewGEVI/psgi/aQQcKqloNZOUsO6tHvCHnqNfJuUF/OswV55ehFOr/HoJk3snd4zPK2ItpIvxvcdaFszVByLqvVqynvlHxoUdZnwY33FwOab6k5YL5ltS5f7hEFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708013; c=relaxed/simple;
	bh=SIP++6o+k6IcipYfeugLKrXlgVr2Mx3kGzLxkrySjFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3vAnXM7Yykb6PnJATI+4qwfLwGTBeMw+nHmfk7GNUuMBAgbyLYPQ5NtmlEuLSHs5EdtLNdIJFRA3wn1SdHKrt9e+Cs+gFpNIxG694NSWW27tQKL0z+8egGfDT4Y6eEj7UbBkqWEv/gbUFk+0BfmQQ62PvibA4wLGMVxGB3AOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5FOM64f; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ea12242d2eso130541cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761708010; x=1762312810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sWCgjKKhp7TKcKNU9g7Njs3zaKm3E/eeC+3FUQGpNQ=;
        b=w5FOM64fgukX+r7h07DpMYI7lUOz5Hr/kgQ2syyKIYt9SDRWbyeFt0Bd09nNwqm9Wk
         X7UeR6s+KD/VlJq+wt9j3cYiC4st47t4lKQR1bknICZ9mbCpFvP0zWyTWFxHfAHcbBkM
         C86q7A5m+A8k9AG1Fue704S0Qsd5ZcByYhPuc3tDaagJFwIi6SmJjY17UM76YhP9WSR6
         LGB7x3UsZyA24lMaPcPx15HoiXGCjumm7yYGRYNW2CpguRdZPexqnoTwOwrjl9q4ZLDe
         9+fky52j0gi9aKJzrvOIaTLqJ9DAsGv5BjewEmqrXMhfKzHllByjswovEaOh3/6phsd6
         OdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708010; x=1762312810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWCgjKKhp7TKcKNU9g7Njs3zaKm3E/eeC+3FUQGpNQ=;
        b=CX+orctlKxDDXL4nqVnMK06Fh6F1WvvEhrhFUbuQoPOWopF7mrgH8z+6dm7TaLL/SW
         mnNYhPJurFwTg2H6PyX3oQ00ewY407qxRGrXwCmIG9GOJYlSXgwizLU41p+JerClvTG6
         zDF2C94aEmrHh5+14ElQc+RwPM9oeoBJuWWEVTRjLgteghmd415QDDmZcK/s17yWeN9s
         oK17ubf/kK+kLyypngEBPbyNsU7X1fG97vQDXQYbV72TQOT9Jgdw1iVDIs9w7goINaDB
         5XKzLe17qyE28cqNqnHwvGihd2G/ZTwRCpgjQ7bj5FM7sPsN9ftWhisu02W+Tbt8KwaX
         jrXg==
X-Forwarded-Encrypted: i=1; AJvYcCUfWm6/iFFYSOIUaGeEBt7M8VVxOogybYF6NRA4CyGpbIYsgmH2CD+m2r29Th0f5xLmmFqAZrseUhDg@vger.kernel.org
X-Gm-Message-State: AOJu0YxPV8TAnMoRCLlsgzgARc7XiB4FwcrG6cMRpEMxmC13qPRqlGJk
	DyngDSm01Owx0+c4LapJToPymnczgA4e/levPiobQE0Ri84ywkzWlCmONnj6j2JC66U3mjW2PFX
	sUEM/DvjyHwfcAwfpfSwMn2b9M5VsbjQpnkdRRj9o
X-Gm-Gg: ASbGncvGIGWLjLJ8sNGYgDKBNXL7QYb6l5o/I2KFg134Rq3glxKoZKxFob6xBJ5Tdhv
	UmduFeS5HET3kvRGqUyEtGPiSsdsg7kUstYJIh/uSWDJMzec+qJyXHWLPvKwBVefDj0u6JiZe2a
	RmiKKYh6xGFNw0di50JQEVXTw/lLWlkdaEzjQFlGACso9DkTnTy/gwjNVvV0qtgVRQHXFHCV/LY
	IjLceSYI2XcOLldvEpKkIzv5H7C61JNxViR0GUS+vYJqUN4nefSj7lvPzRUUR1mNFmQBw==
X-Google-Smtp-Source: AGHT+IEgHBrwGW14wfvE+tNAHLr5vJEtehAhSwoEdeqMmNNr0R+yG/j5eehRFy4Sh6qRX8n2G2p+LqQGRABiqViVmh0=
X-Received: by 2002:a05:622a:244d:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ed157de56amr3957211cf.2.1761708010022; Tue, 28 Oct 2025
 20:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-8-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-8-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 20:19:59 -0700
X-Gm-Features: AWmQ_blp-ZEBcawtFO459XLUyJcG47lh4LXAakbZFQWgL79B818mKpJ-2TDZ1ko
Message-ID: <CAJuCfpHNhes_csqvm9-Z2f-C6XWuyRuXpchNtXwTSXxTpARZSg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 7/7] mm/slab: place slabobj_ext metadata in unused
 space within s->size
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
> When a cache has high s->align value and s->object_size is not aligned
> to it, each object ends up with some unused space because of alignment.
> If this wasted space is big enough, we can use it to store the
> slabobj_ext metadata instead of wasting it.
>
> On my system, this happens with caches like kmem_cache, mm_struct, pid,
> task_struct, sighand_cache, xfs_inode, and others.
>
> To place the slabobj_ext metadata within each object, the existing
> slab_obj_ext() logic can still be used by setting:
>
>   - slab->obj_exts =3D slab_address(slab) + s->red_left_zone +
>                      (slabobj_ext offset)
>   - stride =3D s->size
>
> slab_obj_ext() doesn't need know where the metadata is stored,
> so this method works without adding extra overhead to slab_obj_ext().
>
> A good example benefiting from this optimization is xfs_inode
> (object_size: 992, align: 64). To measure memory savings, 2 millions of
> files were created on XFS.
>
> [ MEMCG=3Dy, MEM_ALLOC_PROFILING=3Dn ]
>
> Before patch (creating 2M directories on xfs):
>   Slab:            6693844 kB
>   SReclaimable:    6016332 kB
>   SUnreclaim:       677512 kB
>
> After patch (creating 2M directories on xfs):
>   Slab:            6697572 kB
>   SReclaimable:    6034744 kB
>   SUnreclaim:       662828 kB (-14.3 MiB)
>
> Enjoy the memory savings!
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/slab.h |  9 ++++++
>  mm/slab_common.c     |  6 ++--
>  mm/slub.c            | 72 ++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 82 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 561597dd2164..fd09674cc117 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -59,6 +59,9 @@ enum _slab_flag_bits {
>         _SLAB_CMPXCHG_DOUBLE,
>  #ifdef CONFIG_SLAB_OBJ_EXT
>         _SLAB_NO_OBJ_EXT,
> +#endif
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +       _SLAB_OBJ_EXT_IN_OBJ,
>  #endif
>         _SLAB_FLAGS_LAST_BIT
>  };
> @@ -244,6 +247,12 @@ enum _slab_flag_bits {
>  #define SLAB_NO_OBJ_EXT                __SLAB_FLAG_UNUSED
>  #endif
>
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +#define SLAB_OBJ_EXT_IN_OBJ    __SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
> +#else
> +#define SLAB_OBJ_EXT_IN_OBJ    __SLAB_FLAG_UNUSED
> +#endif
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 2c2ed2452271..bfe2f498e622 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
>  struct kmem_cache *kmem_cache;
>
>  /*
> - * Set of flags that will prevent slab merging
> + * Set of flags that will prevent slab merging.
> + * Any flag that adds per-object metadata should be included,
> + * since slab merging can update s->inuse that affects the metadata layo=
ut.
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
>                 SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_NO_MERGE)
> +               SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
>
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> diff --git a/mm/slub.c b/mm/slub.c
> index 8101df5fdccf..7de6e8f8f8c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -970,6 +970,40 @@ static inline bool obj_exts_in_slab(struct kmem_cach=
e *s, struct slab *slab)
>  {
>         return false;
>  }
> +
> +#endif
> +
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +static bool obj_exts_in_object(struct kmem_cache *s)
> +{
> +       return s->flags & SLAB_OBJ_EXT_IN_OBJ;
> +}
> +
> +static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> +{
> +       unsigned int offset =3D get_info_end(s);
> +
> +       if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> +               offset +=3D sizeof(struct track) * 2;
> +
> +       if (slub_debug_orig_size(s))
> +               offset +=3D ALIGN(sizeof(unsigned int),
> +                               __alignof__(unsigned long));
> +
> +       offset +=3D kasan_metadata_size(s, false);
> +
> +       return offset;
> +}
> +#else
> +static inline bool obj_exts_in_object(struct kmem_cache *s)
> +{
> +       return false;
> +}
> +
> +static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *=
s)
> +{
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_SLUB_DEBUG
> @@ -1270,6 +1304,9 @@ static void print_trailer(struct kmem_cache *s, str=
uct slab *slab, u8 *p)
>
>         off +=3D kasan_metadata_size(s, false);
>
> +       if (obj_exts_in_object(s))
> +               off +=3D sizeof(struct slabobj_ext);
> +
>         if (off !=3D size_from_object(s))
>                 /* Beginning of the filler is the free pointer */
>                 print_section(KERN_ERR, "Padding  ", p + off,
> @@ -1439,7 +1476,10 @@ check_bytes_and_report(struct kmem_cache *s, struc=
t slab *slab,
>   *     A. Free pointer (if we cannot overwrite object on free)
>   *     B. Tracking data for SLAB_STORE_USER
>   *     C. Original request size for kmalloc object (SLAB_STORE_USER enab=
led)
> - *     D. Padding to reach required alignment boundary or at minimum
> + *     D. KASAN alloc metadata (KASAN enabled)
> + *     E. struct slabobj_ext to store accounting metadata
> + *        (SLAB_OBJ_EXT_IN_OBJ enabled)
> + *     F. Padding to reach required alignment boundary or at minimum
>   *             one word if debugging is on to be able to detect writes
>   *             before the word boundary.
>   *
> @@ -1468,6 +1508,9 @@ static int check_pad_bytes(struct kmem_cache *s, st=
ruct slab *slab, u8 *p)
>
>         off +=3D kasan_metadata_size(s, false);
>
> +       if (obj_exts_in_object(s))
> +               off +=3D sizeof(struct slabobj_ext);
> +
>         if (size_from_object(s) =3D=3D off)
>                 return 1;
>
> @@ -2250,7 +2293,8 @@ static inline void free_slab_obj_exts(struct slab *=
slab)
>         if (!obj_exts)
>                 return;
>
> -       if (obj_exts_in_slab(slab->slab_cache, slab)) {
> +       if (obj_exts_in_slab(slab->slab_cache, slab) ||
> +                       obj_exts_in_object(slab->slab_cache)) {


I think you need a check for obj_exts_in_object() inside
alloc_slab_obj_exts() to avoid allocating the vector.

>                 slab->obj_exts =3D 0;
>                 return;
>         }
> @@ -2291,6 +2335,21 @@ static void alloc_slab_obj_exts_early(struct kmem_=
cache *s, struct slab *slab)
>                 if (IS_ENABLED(CONFIG_MEMCG))
>                         slab->obj_exts |=3D MEMCG_DATA_OBJEXTS;
>                 slab_set_stride(slab, sizeof(struct slabobj_ext));
> +       } else if (obj_exts_in_object(s)) {
> +               unsigned int offset =3D obj_exts_offset_in_object(s);
> +
> +               slab->obj_exts =3D (unsigned long)slab_address(slab);
> +               slab->obj_exts +=3D s->red_left_pad;
> +               slab->obj_exts +=3D obj_exts_offset_in_object(s);
> +               if (IS_ENABLED(CONFIG_MEMCG))
> +                       slab->obj_exts |=3D MEMCG_DATA_OBJEXTS;
> +               slab_set_stride(slab, s->size);
> +
> +               for_each_object(addr, s, slab_address(slab), slab->object=
s) {
> +                       kasan_unpoison_range(addr + offset,
> +                                            sizeof(struct slabobj_ext));
> +                       memset(addr + offset, 0, sizeof(struct slabobj_ex=
t));
> +               }
>         }
>         metadata_access_disable();
>  }
> @@ -7883,6 +7942,7 @@ static int calculate_sizes(struct kmem_cache_args *=
args, struct kmem_cache *s)
>  {
>         slab_flags_t flags =3D s->flags;
>         unsigned int size =3D s->object_size;
> +       unsigned int aligned_size;
>         unsigned int order;
>
>         /*
> @@ -7997,7 +8057,13 @@ static int calculate_sizes(struct kmem_cache_args =
*args, struct kmem_cache *s)
>          * offset 0. In order to align the objects we have to simply size
>          * each object to conform to the alignment.
>          */
> -       size =3D ALIGN(size, s->align);
> +       aligned_size =3D ALIGN(size, s->align);
> +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> +       if (aligned_size - size >=3D sizeof(struct slabobj_ext))
> +               s->flags |=3D SLAB_OBJ_EXT_IN_OBJ;
> +#endif
> +       size =3D aligned_size;
> +
>         s->size =3D size;
>         s->reciprocal_size =3D reciprocal_value(size);
>         order =3D calculate_order(size);
> --
> 2.43.0
>


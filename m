Return-Path: <linux-ext4+bounces-11118-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBFC16BCC
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 21:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB20D354B2C
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDF350A14;
	Tue, 28 Oct 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlvWkAOt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1113502A7
	for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682272; cv=none; b=KY5JZ2Vj9rWLNFoffDNs7dojM+CVmydtIY+KAF4CxSBvonHVFT2qKtHJVF4NkUMsfCyqgMsZlSNX3Y1RkIfrjbPjbJFJ99jOcEiSogm1lOqt3UjJm0Ke6ImVSEA7D5nUA3qVawEcp95JQ6bj/R8S72FyjDN3Yvi0uobSD0XmNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682272; c=relaxed/simple;
	bh=WIEkkOtTRi4Tg7Vn4nXnOi0itFtJNK1QxhxwSLvXlAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4tJZTF+ekApeacakfVcf8af6x5pF//bM3q4ahb9Bn5DF34TYEl3TpfH0mxq5HO4zYMxRIp8aDVcw7HCiqecgpEsC2EdXpAiFE7CpL4z8bFpHnq+Zz9684F68jZP5tPGzRSNUA3DLBIFuOcyZ0Gq/ewdmLdO+6o0sCVEbdD1TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlvWkAOt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso95031cf.0
        for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761682269; x=1762287069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=272mfK03DhLZ+PWwFMbt/hjHyzJqiJdlddFvMA6SlA0=;
        b=IlvWkAOtPlv02gwgeErA0sc9AqWJLiGQx8j6V62nAOV3FFPJ6it5ckQ+jJ7v7fKyGx
         6eRjppfilOi0P9AN1pKN21LMWwDmnWb/FjWsJD4pl9L9qeuoGOc8oiip2Xyk4RbamUzp
         EfcVUnHgg2ePt6F1sXm1lSG4tDa601bAAXdleRYRBwflbVm3GBv3Ire/+vPlqIFz5yJs
         WJya5zbl7X9nMf8kWKrLNQ0bSo/qAE5yNEVo1N56r1Nbu86rka3+jkfXVqpl7j65VHnQ
         owIcHnaW9Z3IGAS7An0miWR6y+YPjAFe01HWOJmvFoUmb3fMGTzABJdQhfd+eSPexCQt
         +fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682269; x=1762287069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=272mfK03DhLZ+PWwFMbt/hjHyzJqiJdlddFvMA6SlA0=;
        b=S5G8jOyJ2Hab85Xx/p+WK+k5Hwom2kR2fjFvoDFmkErFImEoMdDhB5m8YnMc1/ZD/S
         dOCe6nXWgbvqhLt0AUXLv9CZyJz1znkyex+aHeRbuelm3SMQghFLQKLGYRNk5j7p2nXs
         Ynb0bpWidzhsCAPJZelRuitHRue0VFfjDDa7AHxB1g9YhUmiuRo7MaNx1vifptef6LHe
         2cF6FApiPPchnDiBDh3h/Nc4N6Wf44Hd4SQ+Fs0dlepDWGGpMkRlaSFIxg9i7x3RnUiL
         VQodHSqPwlSzpubBfSnKZkEzNemo16jR+NqVNDrZd6Z+XwWD9BOfgDHOVZ0geYT03RZx
         dpKg==
X-Forwarded-Encrypted: i=1; AJvYcCVjpH4F+cw75bjyhvZ9xeGdu3KPqBe1tU8TxSKzJQH9tQFtkec9C5YzPmAG2tNsTBt3rETYDcBDOmYR@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNQbtW2mh++Do6/Zq56VbNscCoQp7AX6WV2kUgMGACgt0Czdw
	6oHs8/LFNkskDCY2vyIU68kFrYq7cqYKpHbRl+4EcI4uPzY35lTXAimc9ADhaRELZhy8YMRnfHW
	3fI1m98EHnvlBJ/Pwh/tAvsTwywJHSXWHCqQ4dy76
X-Gm-Gg: ASbGncsa36Ncfy9/g/onVhH6g4p9mkQRqf7RLsRC7fTvdYRiZm8/D6isk6/YwSK1Xg+
	mTPVwzQlarHuf/0NPsdSGs3slKjwV6GcVBQfi9n3jtzhbGAi+RU2xFptCNKK9mZss+WFuM4jf0E
	Jf4v9BJp465vPn9aP1qxgViU4SknW2YkHaHMZ5igxUMBHXl0DIwvJXfvTqQZGvBKX1C3lrNzBEk
	En/E+JueeB6YFQ96j0+m0ZaH0Hip/q25Nk+G2+PE6I1TeBymOa+wfiTFIoSf9uk/w7ByfecP12c
	o8QxmyUyc0w0wUgkONOIGGdSiQ==
X-Google-Smtp-Source: AGHT+IHZ8asVKG/p+GFrVFe2FQcRmFBWn+JUKCAiirVC9RvAmQHOreZsnq5pWKHohmAMzCiCmCmV6Iy74RqHQl/cez4=
X-Received: by 2002:ac8:7c44:0:b0:4e7:1e07:959c with SMTP id
 d75a77b69052e-4ed1589cf0emr1560601cf.10.1761682269006; Tue, 28 Oct 2025
 13:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-5-harry.yoo@oracle.com>
In-Reply-To: <20251027122847.320924-5-harry.yoo@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 28 Oct 2025 13:10:56 -0700
X-Gm-Features: AWmQ_bmhs1hdkHxO3mmC1NyEAmbGlRZHViudswGppVrbFdffFaapHoJsuste_o8
Message-ID: <CAJuCfpEesdC-yoUb3X+er0Rsm59SiYqXu=i4cHzJDcrO2=QmiQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 4/7] mm/slab: use stride to access slabobj_ext
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
> Use a configurable stride value when accessing slab object extension
> metadata instead of assuming a fixed sizeof(struct slabobj_ext).
>
> Store stride value in free bits of slab->counters field. This allows
> for flexibility in cases where the extension is embedded within
> slab objects.
>
> Since these free bits exist only on 64-bit, any future optimizations
> that need to change stride value cannot be enabled on 32-bit architecture=
s.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

I hope slab_obj_exts() can be removed in the next revision, but otherwise L=
GTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slab.h | 37 +++++++++++++++++++++++++++++++++----
>  mm/slub.c |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index df2c987d950d..22ee28cb55e1 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -83,6 +83,14 @@ struct slab {
>                                                          * that the slab =
was corrupted
>                                                          */
>                                                         unsigned frozen:1=
;
> +#ifdef CONFIG_64BIT
> +                                                       /*
> +                                                        * Some optimizat=
ions use free bits in 'counters' field
> +                                                        * to save memory=
. In case ->stride field is not available,
> +                                                        * such optimizat=
ions are disabled.
> +                                                        */
> +                                                       unsigned short st=
ride;
> +#endif
>                                                 };
>                                         };
>                                 };
> @@ -550,6 +558,26 @@ static inline unsigned long slab_obj_exts(struct sla=
b *slab)
>         return obj_exts & ~OBJEXTS_FLAGS_MASK;
>  }
>
> +#ifdef CONFIG_64BIT
> +static inline void slab_set_stride(struct slab *slab, unsigned short str=
ide)
> +{
> +       slab->stride =3D stride;
> +}
> +static inline unsigned short slab_get_stride(struct slab *slab)
> +{
> +       return slab->stride;
> +}
> +#else
> +static inline void slab_set_stride(struct slab *slab, unsigned short str=
ide)
> +{
> +       VM_WARN_ON_ONCE(stride !=3D sizeof(struct slabobj_ext));
> +}
> +static inline unsigned short slab_get_stride(struct slab *slab)
> +{
> +       return sizeof(struct slabobj_ext);
> +}
> +#endif
> +
>  /*
>   * slab_obj_ext - get the pointer to the slab object extension metadata
>   * associated with an object in a slab.
> @@ -563,13 +591,10 @@ static inline struct slabobj_ext *slab_obj_ext(stru=
ct slab *slab,
>                                                unsigned long obj_exts,
>                                                unsigned int index)
>  {
> -       struct slabobj_ext *obj_ext;
> -
>         VM_WARN_ON_ONCE(!slab_obj_exts(slab));
>         VM_WARN_ON_ONCE(obj_exts !=3D slab_obj_exts(slab));
>
> -       obj_ext =3D (struct slabobj_ext *)obj_exts;
> -       return &obj_ext[index];
> +       return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * =
index);
>  }
>
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> @@ -588,6 +613,10 @@ static inline struct slabobj_ext *slab_obj_ext(struc=
t slab *slab,
>         return NULL;
>  }
>
> +static inline void slab_set_stride(struct slab *slab, unsigned int strid=
e) { }
> +static inline unsigned int slab_get_stride(struct slab *slab) { return 0=
; }
> +
> +
>  #endif /* CONFIG_SLAB_OBJ_EXT */
>
>  static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> diff --git a/mm/slub.c b/mm/slub.c
> index ae73403f8c29..4383740a4d34 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2134,6 +2134,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>  #endif
>         old_exts =3D READ_ONCE(slab->obj_exts);
>         handle_failed_objexts_alloc(old_exts, vec, objects);
> +       slab_set_stride(slab, sizeof(struct slabobj_ext));
> +
>         if (new_slab) {
>                 /*
>                  * If the slab is brand new and nobody can yet access its
> --
> 2.43.0
>


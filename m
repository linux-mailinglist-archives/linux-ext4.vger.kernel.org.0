Return-Path: <linux-ext4+bounces-11353-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3FC1E63A
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 621F534AAB0
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 05:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1428C854;
	Thu, 30 Oct 2025 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQJNNXr5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D021FECBA
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761800649; cv=none; b=BqRT3fgsBw3agqgCR06JLN6Lzq53tSxhFx6BWQ/FMVvM/HbA69J0XSRtOCD+zISSYZCUJbXIILcSSXBSPDGhqZBq63cLv5jqYdn9CsL8uRms61iOaCvk06jftLwnnFBTWa6b04QE297dgmfs+hqmmlgnKFnkdQYxrnlVa44OTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761800649; c=relaxed/simple;
	bh=hW+kS+9mzorf2jrcrOtFPVTPybuO8bZezLBdGIwS2xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdxaoSPvStQVcDH465wyuuDfh0rcfuTYIaXCJRKhPORcgGU41sjz5uKs53urWaWRu3cJPeTXS1mYOVMW6KvxRH0wC199/3o/qp7S4U5HZKni0G6T3919V2v3b/D68lrm6kEbk4hRrQsnyiY3eE2y0NtiS9r8PPy/S5fFOtWZNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQJNNXr5; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso143431cf.0
        for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761800647; x=1762405447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imCnF/sFJhKXZqCTXzziLsifvuU1OPsnWOgGGE2EO8o=;
        b=xQJNNXr5BAjE6a5oP18PCgoXt21YHW86YQaZpyMHK0a3UzX3g+2mjFwdUZXTpTvD5H
         BxuLZ7dDQW7wIiUkoaHSjZjU3moY8XRR/YYnWTVLBXVJILqSUZwnmmCSnTIVSvDU5eCY
         lLcoiS3tn6HL9sS+E3Ses/UBgsV9L4KvhoQ6JQ7ciZyxKYIp+EE3Jg/0B9seVmGYFEQp
         nuRjNJSkiTlljwgFFWeUWNLxru5P7TqirNLybXcVBGtHvc4P9Qt56tMBGMRpg8xz0YbI
         8WJ9YIT24ePIAVOaZX/yfia0jEj1RI3MLvK9KHTxgTi6DYFIMQXtvtv6jDDtw6qGTa/v
         kQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761800647; x=1762405447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imCnF/sFJhKXZqCTXzziLsifvuU1OPsnWOgGGE2EO8o=;
        b=CQv6mfRLDIC7zjMkHRNbtdQmD57quS4mC8rABSeWC8h19mjeYIEhInoof5eAAjkPSR
         yOo7fdfxWHG4PLA0oFwEm4CHOUtslWYrAXoYHy6qAiblsFOdXahvs+tRMkzL9DLgOwNt
         NrpDl5JzuE6Y2K8GzsWe/IW9Wg9nmepNGEBQED+HY4ryiFn98U6ooQ2YWmD6mGQbRfuu
         w+WVnzILNyxNvtXWTDpL6rsnNiBT1cQy28FQVsSiiWDjowmejc1K4z0+iv+WxxLmMz5o
         mJPEn4EscTusB9lVHzKEtGzIxWkjqsSjLQtfQQEJlxmnSCoVlGRVJJSUfvzg09pAjwnj
         Ir+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVThGv1JoLjbFdldLRYvLyuIgor76rGa0waMrsNgonozMirK4J1JEHafFLyG2+RvscAOSdaOwClcEcF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fS82knHF4jyFGqLn9QJVDg1KeYhfjMQIs03cc9+n66B9cQ/o
	DNQOPOEdqR4DPx3G3Du9vgWElC4/nKW4LFAOGu0rHFZGSywRz095f//e8qyncfwyGNuuO7NpcXK
	WZJAIU4GbIXvXXK3wsATWpBh+g09p/PlqSVPB+N3T
X-Gm-Gg: ASbGncsr66xAKlcsnsxen+EcRqD+edQUKuZeiXWgVPPv70yfOQ3TiMbVZ2/PDc9Lxk+
	AtrkO0etOuLbcWgYCVE9nAVAER3lriE5dxEtELJVzeMwkp/oWK4VQ+LqcTvsKCtwcA/p8modApy
	an//Il5BKO3dmbdxUW4mb74aAuAjDZdwCJ0f/yhvTiXUBtvSRRJDlhfilGGmSzfJGy6VIZ2HALr
	2LRuEFR4No7BZzkFLnRvcNE2SbS7tbRzH4QoCNDQj+a65+60D2+r8/y+IhmNU9a426RRA==
X-Google-Smtp-Source: AGHT+IEB/ILAA9xYUQfW2KWQNzMMCyTN5Fgh1c/JAVWGUaLoeQoqs8yLNH5vm5UUyHsuDvyZMDkjSMrqPQd6JjIiXNg=
X-Received: by 2002:a05:622a:1992:b0:4e8:b245:fba0 with SMTP id
 d75a77b69052e-4ed24201737mr2800941cf.14.1761800646803; Wed, 29 Oct 2025
 22:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-4-harry.yoo@oracle.com>
 <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com>
 <aQHVB_8NVMZ2cuvh@hyeyoo> <CAJuCfpGFPuoUceB7SvAJPtVvzOOCzqS50yCcjbuMxV2a0e0KWA@mail.gmail.com>
 <aQK-wyE-h1bvaNOq@hyeyoo>
In-Reply-To: <aQK-wyE-h1bvaNOq@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 22:03:55 -0700
X-Gm-Features: AWmQ_bn3R48jrJn5u8sZk4g75yU9gtIgBe7otWH9hfRDS1mVIDIvKkjdnB9DenY
Message-ID: <CAJuCfpFNsmS-wk8OQJwAsT6kRBz9TOmA2wuCJ=AL4588qhYtJQ@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 6:26=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Oct 29, 2025 at 08:24:35AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Oct 29, 2025 at 1:49=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > On Tue, Oct 28, 2025 at 10:55:39AM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle=
.com> wrote:
> > > > >
> > > > > Currently, the slab allocator assumes that slab->obj_exts is a po=
inter
> > > > > to an array of struct slabobj_ext objects. However, to support st=
orage
> > > > > methods where struct slabobj_ext is embedded within objects, the =
slab
> > > > > allocator should not make this assumption. Instead of directly
> > > > > dereferencing the slabobj_exts array, abstract access to
> > > > > struct slabobj_ext via helper functions.
> > > > >
> > > > > Introduce a new API slabobj_ext metadata access:
> > > > >
> > > > >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> > > > >   struct slabobj_ext element at the given index.
> > > > >
> > > > > Directly dereferencing the return value of slab_obj_exts() is no =
longer
> > > > > allowed. Instead, slab_obj_ext() must always be used to access
> > > > > individual struct slabobj_ext objects.
> > > >
> > > > If direct access to the vector is not allowed, it would be better t=
o
> > > > eliminate slab_obj_exts() function completely and use the new
> > > > slab_obj_ext() instead. I think that's possible. We might need an
> > > > additional `bool is_slab_obj_exts()` helper for an early check befo=
re
> > > > we calculate the object index but that's quite easy.
> > >
> > > Good point, but that way we cannot avoid reading slab->obj_exts
> > > multiple times when we access slabobj_ext of multiple objects
> > > as it's accessed via READ_ONCE().
> >
> > True. I think we use slab->obj_exts to loop over its elements only in
> > two places: __memcg_slab_post_alloc_hook() and
> > __memcg_slab_free_hook(). I guess we could implement some kind of
> > slab_objext_foreach() construct to loop over all elements of
> > slab->obj_exts?
>
> Not sure if that would help here. In __memcg_slab_free_hook() we want to
> iterate only some of (not all of) elements from the same slab
> (we know they're from the same slab as we build detached freelist and
> sort the array) and so we read slab->obj_exts only once.
>
> In __memcg_slab_post_alloc_hook() we don't know if the objects are from
> the same slab, so we read slab->obj_exts multiple times and charge them.
>
> I think we need to either 1) remove slab_obj_exts() and
> then introduce is_slab_obj_exts() and see if it has impact on
> performance, or 2) keep it as-is.

Ok, it sounds like too much effort for avoiding a direct accessor.
Let's go with (2) for now.

>
> Thanks!
>
> --
> Cheers,
> Harry / Hyeonggon


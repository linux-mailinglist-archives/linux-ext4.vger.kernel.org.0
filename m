Return-Path: <linux-ext4+bounces-10821-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A208BD17B9
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 07:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D9A4E9708
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F32DC794;
	Mon, 13 Oct 2025 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWCG7q2p"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A041A5B9D
	for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334182; cv=none; b=TYpGDhKL1UFfc+OBlPNCWU4JV7rhsmbxIEhqVjLtiw0cXsJ+Q9vpA/YTl3/hIpsHNTCVzmqbxJw3LrAhOrgmY4phDlmzAM5igi1RQvMXhNg5SramtZ2VAnGQ8bvQDomvmTG4ypJjv+2r1WM+1bKGlvRIj2GOxmBE/qTtbhwIs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334182; c=relaxed/simple;
	bh=LkiHDxUpll20Mzzyjyp6GAradkAWV81/VhYmzsLwOLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khUBIo1aE/m78RcCUoYIP8I4KdcguL4yhWNSlkPTZlArh+FWbU411BwPL9TfnYLX5fqG65vNkozu1VpFlHq9Qa8U7jTR0KpAVLd9omLdaG2QHGqOrd11yxc/z6/H9qKEuVgfAx6rEtmD+5TiG3GsFAGuhQq8/38m3plKSFJcvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWCG7q2p; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54bbe260539so1420258e0c.0
        for <linux-ext4@vger.kernel.org>; Sun, 12 Oct 2025 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334179; x=1760938979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFw8GX7he7wIYguaN9JzvQNXMrk3Z90u5aRFTT7c2yU=;
        b=IWCG7q2p7ncp3CeE2O5Slzpe2mNztlvZhmi9ntpDYMpxLGBvuzLRHSH+ncBuJYaKD+
         jzc6ucI6ohY6D/Iica3jWOpZd+lh0UGTNdAzv30lo68Fos9U3jAC+xcC2jHVIp/qaQH4
         EKmTWoWaxx1XGMIAKWpSuyQBq+FQggTp+T2YRLmhhPAC1WDFsCEaklEKKoc3gnGZXfyM
         VxHlzrORf8boipLV1lThncDGuIYq55L9vVWVlvLFid8Y81xCaMzjT7xFu169zTPqSlYy
         ot8bM/NL0/yxTgbiqrefFX17lVANYxojBoKcYczeWjOU2o26WB8fcrBiEP6ApN2kkmmZ
         L4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334179; x=1760938979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFw8GX7he7wIYguaN9JzvQNXMrk3Z90u5aRFTT7c2yU=;
        b=cZABsVfM+tXxTk8odycNLaik2aAxMq873363Dlvzr/eHLzgKBzN1E+Jngf6bGhYJx4
         0ReY2rmbo6QdT9/3Kf1UIa3rOnhPd1DH/IVNRkgNvuHMdYKadz7Fby7oSvneCSIZ6mfd
         O+nrpcBe9rAwaLHjRkA8vHZ3el+UU2xtN2k+k1jqrA92m+/ArExwmOLwJ+bEaZYZ2FFF
         1N13VJag0/L5AtvHQwh0GXrmEXL7NdIrHKTCfwyb2cqNKH8jte9TmiyH458af/OHbAeH
         fJfezg2lxOhgfbtXtPJaHaL5p+RXmtN5+dNDH8e2KVksAjxdVxpW5pRN5bGUB/AZ7QPk
         F3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM0JrDpxslGpkxF4Bl5e4e5N0PTIDlcUBqw0BnCzmOPKI4gQtR1wiNa6J9CJkRuq9CZlwibitnsfC7@vger.kernel.org
X-Gm-Message-State: AOJu0YyJU5p5v01kFmrnOaMJfMKIKgMdLm9gaL+InBnrd3dW8aR1xW8a
	QMyXzhioMIeGfDCRQ4kPzlsivpV93UE8GBngyWbEZg/hgzQ3CzwjmnsRAzgypjjPpzP3EWfjTJA
	Ogb+7rs8m0Aqvd7zovWfbJ1RVHvrvqzA=
X-Gm-Gg: ASbGncuIqVTn3fDTLeN6t5rx0HBpiBCGIPhy5ib9fbFVfQPG5QP7g7vDYqwFAXC8tak
	OQ3UuAMXP/bsPwrDCDOo7/YZZ04B7h4RwHvgO15a99727+AsvI8PWVgRU6G/K5YGcXEakjqsUY5
	hxyd/Qw27gywJDZqDl2vCZyzj8pV38BXGWhRgAj9tvf9gc7YcD6J5aLJpUo68cxv5jlC5utnZZI
	QX6MyOhGxVzSReWDDjTGyRj3Mh9am7t2T7D8g==
X-Google-Smtp-Source: AGHT+IE2pzpIXFUlQnxpSAUJmDsWbuHYPNEdEfC1GOsG6qkn6Ggw30mR6TSMqPTmSaIF0L9e6DD5b5ldfGpQurArkk4=
X-Received: by 2002:a05:6122:91b:b0:545:ef3e:2f94 with SMTP id
 71dfb90a1353d-554b8aa8d4fmr6241006e0c.1.1760334178612; Sun, 12 Oct 2025
 22:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011013312.20698-1-changfengnan@bytedance.com> <aOxxBS8075_gMXgy@infradead.org>
In-Reply-To: <aOxxBS8075_gMXgy@infradead.org>
From: fengnan chang <fengnanchang@gmail.com>
Date: Mon, 13 Oct 2025 13:42:47 +0800
X-Gm-Features: AS18NWBq65kKS67xgSwyGWf422mFA-TjXvUExYQYDBZ5JznD-_4en1JwPHXcFWo
Message-ID: <CALWNXx8pDOvDdNvw+v0rEyi33W8TL+OZW1YiFbF6Gns3PeWOLA@mail.gmail.com>
Subject: Re: [PATCH] block: enable per-cpu bio cache by default
To: Christoph Hellwig <hch@infradead.org>
Cc: Fengnan Chang <changfengnan@bytedance.com>, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, asml.silence@gmail.com, willy@infradead.org, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:25=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Sat, Oct 11, 2025 at 09:33:12AM +0800, Fengnan Chang wrote:
> > +     opf |=3D REQ_ALLOC_CACHE;
> > +     if (bs->cache && nr_vecs <=3D BIO_INLINE_VECS) {
> > +             bio =3D bio_alloc_percpu_cache(bdev, nr_vecs, opf,
> > +                                          gfp_mask, bs);
> > +             if (bio)
> > +                     return bio;
> > +             /*
> > +              * No cached bio available, bio returned below marked wit=
h
> > +              * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
> > +              */
> > +     } else
>
> > +             opf &=3D ~REQ_ALLOC_CACHE;
>
> Just set the req flag in the branch instead of unconditionally setting
> it and then clearing it.

clearing this flag is necessary, because bio_alloc_clone will call this in
boot stage, maybe the bs->cache of the new bio is not initialized yet.

>
> > +     /*
> > +      * Even REQ_ALLOC_CACHE is enabled by default, we still need this=
 to
> > +      * mark bio is allocated by bio_alloc_bioset.
> > +      */
> >       if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <=3D BIO_INLINE_V=
ECS)) {
>
> I can't really parse the comment, can you explain what you mean?

This is to tell others that REQ_ALLOC_CACHE can't be deleted here, and
that this flag
serves other purposes here.

>
>


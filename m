Return-Path: <linux-ext4+bounces-10851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC99BD31EE
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 14:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FD214F18A8
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA02EAB72;
	Mon, 13 Oct 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="B9UyH05f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52B2C21EB
	for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360349; cv=none; b=mNRrWFLTlK11GtN8n6a1OFKZ2BajpRJdTXMIR9oTJzVR8cT2xBHd5hQRhWA+aK4Dg6eXt3aSOG8QQdmQZjs+IOKvsVOEuv89JZsnTimYvlYxm3kLHcO/pXSy8nJLYv1hlofgq6JGYDLvlfhKVJz9j7Z0URJrQqk9CTs1Vu89Z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360349; c=relaxed/simple;
	bh=D6V3XPkrc+t2idQmAkRSOk7iDPs7p8w0xsyna0/EAms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edl5M/ZveY0bNR6czCsLtXDTShk5U4QhWoRwmUoLEWC0NqG9d/s8qcBZp0gKv9ntcYbG+9MhZaq3x6Hgq+XXWcI42frlGY8mUnS0dytfOba6f1DQ64b95Nq7E0gcqn6p/J3tmxe1CuzJFvUmT2p8kcH8Q1teldnRJzZf7+k/DII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=B9UyH05f; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-36ce5686d75so2849047fac.3
        for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760360345; x=1760965145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wmypoq4JusPQtINuz1Vuv55d8t7TPWrzMFDko8wjps=;
        b=B9UyH05foBQyFo3GAqVmomH33i32hZfsbauxq2TxSOZXmKGJfh08jxhtDuYctqirTi
         +znbj5YMDykLDsosYTPWEgW+T2R4d6Kpu26CrxcrpHuyKc5hlq7p7XABUmzfVxyE3HYo
         YjQqvWGD9A3KL6wQKE9NuFhi9ZCiLWGbmax+NtRk0Tm7h66+iNefKK/1pCYfUljJl+yQ
         nzCT1p1+4OVJLh+B1DSyY9lOk948JiO4EpJ5btrqqtrgc+zcetIN0DjA5BT0I8BaF99r
         atybbxItM8SPjnbn8hiNTQVdD39QA2GOdN/PCu/Bt0M9eOZ7f0xTDW16UaqhNBGmwEdC
         z/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360345; x=1760965145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wmypoq4JusPQtINuz1Vuv55d8t7TPWrzMFDko8wjps=;
        b=oYdbgm4A6wHnxw9+lTHZJ9McjJ4tTDSOfpp8kneWuVt4wYwH9REff6ghsBiBYYV3rr
         KD0F4TfkiDARKd1dO4ZzR0K4V/Hchylqq56vCQq5HBxfLhlIGxrZPo3s4cw6vUVpnI0C
         DHGIdlALLNx4/ifnFZjf8XEhRTMgWSr3RrBssBBWvHZ/ps73Bx733A65BxCGspR4EQhU
         jrhPkecQeu7fGQgNzlSlhwU/n4q9gr8HA+5ZLkKTynNWPGMffKnVJAvFyRNX8d73V3hY
         Wod2gs1zuEe67657TpF53sgrZ4L3Ko41BADE/w5CgP+7T7Q9bM09IjvdlcmoVeWuSHF9
         qBzA==
X-Forwarded-Encrypted: i=1; AJvYcCXaQVcddfowngBFaNb0wSzYZMyHi7V0fwoT9929LVi7sQCK3z6+kNtV/FOPPwG7BDuHKtZWTZYMyR72@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxC2VIFUPlQ8EQV3wzANmsc37M8+JQEnCFi5PkrwfZ1vaI774
	WcBjQtc+8ip66Jsm0OnwLKP5Ne73EVfouIHWD/hIRSYxS5T/bUxWCXjYlmNlLqYpp0Ff6y6E2Yh
	D9ATyEExw2KavJNwo6rao0CoCsh46JuNS6Om61rpccg==
X-Gm-Gg: ASbGnctoseMlvR1ZyYstrG+kPac7HvI+3qevEOU0JCnRyxSyxL4UWL/y7LovtUJIm79
	rq7vTPeu/SS7L0HicLJCcE3P0feL+L/RV473wcnMaMbLmwdbLlFTTBH2eAM7GXXqSvCMwKfE2Hv
	ee8CA32We+CTApaFimBs4z/ZD/w8oBTrMUXXHspvKjaye7dnsiEh7XC/Bl1qMDyPC2GPm7G78j/
	hCG5r9v/xBSKrXdnVbt3kk37NNpqWd4EuWENM3ifHBGbg==
X-Google-Smtp-Source: AGHT+IFcgfB7Wf1FZ1oK1mDKCUiDJpUURtVox8EHig27s8X9dUwwKIMVBBoJvN74OlkrVqbewuUEWyvLA9j7WIpDFWo=
X-Received: by 2002:a05:6870:5490:b0:395:11a1:2a5 with SMTP id
 586e51a60fabf-3c0f68f3ed7mr8576313fac.19.1760360344992; Mon, 13 Oct 2025
 05:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011013312.20698-1-changfengnan@bytedance.com>
 <aOxxBS8075_gMXgy@infradead.org> <CALWNXx8pDOvDdNvw+v0rEyi33W8TL+OZW1YiFbF6Gns3PeWOLA@mail.gmail.com>
 <aOyb-NyCopUKridK@infradead.org>
In-Reply-To: <aOyb-NyCopUKridK@infradead.org>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Mon, 13 Oct 2025 20:58:54 +0800
X-Gm-Features: AS18NWDyQf8Y1FBCeSc2-tQU2iORMO74jotl63VadojDvfzhepmbn3llIRtG9jI
Message-ID: <CAPFOzZumoCERUj+VuegQNoAwFCoGxiaASD6R_4bE+p1TVbspUA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] block: enable per-cpu bio cache by default
To: Christoph Hellwig <hch@infradead.org>
Cc: fengnan chang <fengnanchang@gmail.com>, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, asml.silence@gmail.com, willy@infradead.org, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B410=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=B8=80 14:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Oct 13, 2025 at 01:42:47PM +0800, fengnan chang wrote:
> > > Just set the req flag in the branch instead of unconditionally settin=
g
> > > it and then clearing it.
> >
> > clearing this flag is necessary, because bio_alloc_clone will call this=
 in
> > boot stage, maybe the bs->cache of the new bio is not initialized yet.
>
> Given that we're using the flag by default and setting it here,
> bio_alloc_clone should not inherit it.  In fact we should probably
> figure out a way to remove it entirely, but if that is not possible
> it should only be set when the cache was actually used.

For now bio_alloc_clone will inherit all flag of source bio, IMO if only no=
t
inherit REQ_ALLOC_CACHE, it's a little strange.
The REQ_ALLOC_CACHE flag can not remove entirely.  maybe we can
modify like this:

if (bs->cache && nr_vecs <=3D BIO_INLINE_VECS) {
    opf |=3D REQ_ALLOC_CACHE;
    bio =3D bio_alloc_percpu_cache(bdev, nr_vecs, opf,
    gfp_mask, bs);
    if (bio)
        return bio;
    /*
     * No cached bio available, bio returned below marked with
     * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
    */
} else
        opf &=3D ~REQ_ALLOC_CACHE;

>
> > > > +     /*
> > > > +      * Even REQ_ALLOC_CACHE is enabled by default, we still need =
this to
> > > > +      * mark bio is allocated by bio_alloc_bioset.
> > > > +      */
> > > >       if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <=3D BIO_INLI=
NE_VECS)) {
> > >
> > > I can't really parse the comment, can you explain what you mean?
> >
> > This is to tell others that REQ_ALLOC_CACHE can't be deleted here, and
> > that this flag
> > serves other purposes here.
>
> So what can't it be deleted?

blk_rq_map_bio_alloc use REQ_ALLOC_CACHE to tell whether to use
bio_alloc_bioset or bio_kmalloc, I considered removing the flag in
blk_rq_map_bio_alloc, but then there would have to be the introduction
of a new flag like  REQ_xx. So I keep this and comment.

>


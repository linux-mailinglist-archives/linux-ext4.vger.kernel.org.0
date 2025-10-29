Return-Path: <linux-ext4+bounces-11341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF4C1BC5E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87D04586B47
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDBD2FFFA9;
	Wed, 29 Oct 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgjFDuIi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D152D3EDF
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751753; cv=none; b=KZtVC+94LTR4eUadnvOxFGiIBl1hPuKqcQ1qXK2zL54lT1lcgPF3eLB95mDr3qFabBtrB0+dWWosTpcqqtt75VUWAK/MEU7Yh69GAvqvk+w5aRDY3kZerP0FbnCLhoem7OQxWSlPbLcvZBB0n4K4TYiSGR7GAYGsra4GpOQMbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751753; c=relaxed/simple;
	bh=WtXohkJCbWS4jbO4cmof6PHddRZcBco3Bznw9PsDWdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TberTX9wHul9GQmQVBWpqhJKUQWO9Bzq2LZSlOijKF4wvGd+Z6iz+JUXfWurNLgNY99pXT7RAMYVFi5h/1vhzQ1y3Mwrm8GQXNZUc5bGwpJX9itnGHpmDewLbg9JuYUW0gFgl3SpUwbZGnxDCuiw2fUi7LMJkRoD+folZo+LgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgjFDuIi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so12929a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761751749; x=1762356549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f625dWb+wusHB9zK0OBpFfEoYrOJJpBna/xRpvKUY48=;
        b=QgjFDuIinkogf9UkGuZSA0+qfhSDPx19+sh/JFBQrzCWijQQEkenLcC8xfSnNWzqni
         O08RYSZ7CQSzYayVtRETABaC2DUgxycjk13UbBTR6m80yFosjVi831+2Nfj28jBxYXxY
         WzHIdll/P9WP2cSmnff+AAs1ygDpKPEn7i2OvRyZqWSGyy571cam7rjR7jya28xfplpc
         /V7Whimxrba1gqUW2HjjnBHupHL10nHOFd6k9C/Mbv3BC/BEE/f3ejNbPBkrUNOSg39n
         f07f6/BtmO5Li9tyfpY/aGGNU0u77Lag2wkJR4jr0GHFhCiYLovOlzKcWICpG+rUlGBP
         KB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751749; x=1762356549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f625dWb+wusHB9zK0OBpFfEoYrOJJpBna/xRpvKUY48=;
        b=i68hrfAur5oD0aOgYLLLVF0fNTbQc5+MuATI2KT4SI1qkvkO6nyO1xaDEmL9HjEccD
         ldicPI1wx8QcTvHPPS7duGR5OxHRIZF/91AIcAzNMoUiLYvYsU5kpreWIHxe3ZlwgKAe
         uaxPLz9xB2KvIHlknCBjabho0ki4R5mSo1SvpxkqbrMq82dl8c4bI8CaJOkJr8vDKBMD
         N4mDLHdjAAsuAGw9IlD8xTYVpvLs3YvbiKe5kMQWVZ7KjHvrS8SAcwViDvzEi+o7Xt7n
         g8Zfe/hR/hHbbVo83z/rvlwNt3V/bazXs0osIiCj+oxYFPnuknqkwITkHMNu91PbjU+E
         8UwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTLWIJKp8+TId9goyC7GleQQhG/5TvXsQ7HqbKy5cGYGPdijP2cHQs7HwpcC9RqFHZ0g0S5Gc4/Lx/@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIQR+vjOsLfJ4UZeyGokqoEIsPd4MjKT4m9pkGLEd649J+kmi
	lhhvDw0/AdNACH+2KTqukUdR6CJmbx0uCWPvgrfuHQYC06GZm/7d4wu957KUiBV31unEoHbCLJu
	tSV9NzbbMV3jh7bCMGNnKKSBzC9cvsVSsPWCOMnCw
X-Gm-Gg: ASbGncvANS6wsMGXU8yd197ARy4zIC/PWh0BsEnAhRu16up5Y9qbGo3G0RxoAGsG+j5
	EIPDIw5Z27MoQJq5QBG3i6Q+B0KkzaMXi9kckOL4N7zDlj9/QHNMSCmOYex4jNPvPJWDRMzioog
	miHs4QsHJnUcEPo1pBuJnIVDTPHTJ2bv8/a3WYNcwM4lqP9tribxewwqGAzMfe5XsbUiWq8+O7T
	7Kv/qAxCz7nlDGy16AAmFy39QKVr+Or8fv9oHsz3jwVXeiv85nGU1/GXOBppdQES9JMWAXLTcr3
	9q5ZsaK2b0BeNpc=
X-Google-Smtp-Source: AGHT+IGJr15cLDbC+fbHSXbTnzvTz28tTliyWmFftwEcXMbXCQuxnWdN03oQ6RERl24adkiisnp+L7hn3wCKpUANYfE=
X-Received: by 2002:a05:6402:713:b0:63e:11ae:ff2e with SMTP id
 4fb4d7f45d1cf-6404519b54emr90964a12.3.1761751749371; Wed, 29 Oct 2025
 08:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027122847.320924-1-harry.yoo@oracle.com> <20251027122847.320924-6-harry.yoo@oracle.com>
 <CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com> <aQHLDTwwEuswvNWv@hyeyoo>
In-Reply-To: <aQHLDTwwEuswvNWv@hyeyoo>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 08:28:56 -0700
X-Gm-Features: AWmQ_bmezBnR6pc25_StLvVfGCVbr2qQzQa79QlxZjsxwYQHjSt8eI_UKHmKW6w
Message-ID: <CAJuCfpERqLpAkbK-+X32s9o2udOfLtqeoU5=9BykbucFePv7Ww@mail.gmail.com>
Subject: Re: [RFC PATCH V3 5/7] mm/memcontrol,alloc_tag: handle slabobj_ext
 access under KASAN poison
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

On Wed, Oct 29, 2025 at 1:06=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Oct 28, 2025 at 04:03:22PM -0700, Suren Baghdasaryan wrote:
> > On Mon, Oct 27, 2025 at 5:29=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com=
> wrote:
> > >
> > > In the near future, slabobj_ext may reside outside the allocated slab
> > > object range within a slab, which could be reported as an out-of-boun=
ds
> > > access by KASAN. To prevent false positives, explicitly disable KASAN
> > > and KMSAN checks when accessing slabobj_ext.
> >
> > Hmm. This is fragile IMO. Every time someone accesses slabobj_ext they
> > should remember to call
> > metadata_access_enable/metadata_access_disable.
>
> Good point!
>
> > Have you considered replacing slab_obj_ext() function with
> > get_slab_obj_ext()/put_slab_obj_ext()? get_slab_obj_ext() can call
> > metadata_access_enable() and return slabobj_ext as it does today.
> > put_slab_obj_ext() will simple call metadata_access_disable(). WDYT?
>
> I did think about it, and I thought introducing get and put helpers
> may be misunderstood as doing some kind of reference counting...

Maybe there are better names but get/put I think are appropriate here.
get_cpu_ptr()/put_cpu_ptr() example is very similar to this.

>
> but yeah probably I'm being too paranoid and
> I'll try this and document that
>
> 1) the user needs to use get and put pair to access slabobj_ext
>    metadata, and
>
> 2) calling get and put pair multiple times has no effect.

Yes, I think this would be less error-prone.

>
> > > While an alternative approach could be to unpoison slabobj_ext,
> > > out-of-bounds accesses outside the slab allocator are generally more
> > > common.
> > >
> > > Move metadata_access_enable()/disable() helpers to mm/slab.h so that
> > > it can be used outside mm/slub.c. Wrap accesses to slabobj_ext metada=
ta
> > > in memcg and alloc_tag code with these helpers.
> > >
> > > Call kasan_reset_tag() in slab_obj_ext() before returning the address=
 to
> > > prevent SW or HW tag-based KASAN from reporting false positives.
> > >
> > > Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
>
> --
> Cheers,
> Harry / Hyeonggon


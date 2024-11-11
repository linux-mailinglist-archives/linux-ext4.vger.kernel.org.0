Return-Path: <linux-ext4+bounces-5017-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72C9C41C4
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EDAB230B9
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7546280034;
	Mon, 11 Nov 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kvB7jrdh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072749625
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338598; cv=none; b=eUwjf5Dm/Z44QuuqZZdmXtj6B18LA4gGQ1aIWgEAAkyDl+GklYO6Pgg1ISmKbF4hwMGzx9bfR9TkM0dgJEy4KknFVWBCOh4UGXUPYMwKgiD98juuHFjILko6rnuvGjwfsgljCvxfm8rSiFkVOfcpPMjAWGKpyEINAHgt139Pbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338598; c=relaxed/simple;
	bh=VmivZvdWo5vK0AEQoKT7CGGAfs/DlxatoWf68eA/sHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN4Pzw4Om00XEckEJWnlL8ij4s98+HIJTInU7EjO295TZklGy0P13kJS/1mUw5uGU5fs0qQVveXKy3yeg6MF6kKswp7vSBEPngUjqp6aB6sL4a6urjSVIMwWqmv/Bq7Zcpy1iogSfYVnah1FkQ8gCu48YzwOj9scAs8INtrjYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kvB7jrdh; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C4D283FA67
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731338586;
	bh=Omjsq5eJGa5U/n+iV9tiE7ASNFekvkkDtDvd6eham/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kvB7jrdhc3DePtYyLxk2lkvAmNb7fNGrw0u7J+e9ZMw88nnA9TfjLinkjgTwByPUe
	 qxze5ItAcyEzqmlTrEFKorqZsuPjPtmd/gKCei5S2YGGtT08gkTZQgGMYyqDiTH9Yr
	 EMdSlCjJK0/0NcKZ+bWi5Se21oPuxOn5HdM8lbvQxt2MjNoEy/eZTBZSpiOAC86Ebk
	 dV0+pNG2vSKBuEsiT/WNcwgsCImCLfDM6cSB8lC3FiPCWChRAwU4hXkhLjD3LLEydh
	 RMnx9O/ccAGlcAy8FARaqA0M9+L69YzUARHJe3aCcTiDBJjwxz3xaaoCQuo+Jld0wR
	 qCAFxJRFzPBqQ==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5eb7e223383so2351969eaf.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 07:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338584; x=1731943384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Omjsq5eJGa5U/n+iV9tiE7ASNFekvkkDtDvd6eham/E=;
        b=aAyMIbX8HKGkzJDYEvDhLFUHBjKFXF172tXyjdd1e/HkJNPrYKCoGj01Towq7O8Uoz
         /N8/EUWJel8V3532sIjnR7/7dUEcwu2uMpjmgQzm2rOwYjM5vmz2OJjNKxdRzc3Q68uL
         pkSjIBAqtQp2klsgsUIt75DFr6OyiILTBpJc5xidA3XoBYd+bplPccfprqBijr0CvCEI
         pOzwZ6+EkaGaz1ncu0HG6STwakobh9u5IIOqrJAEEUQXD80ZOlmCxkob4MtGdb/papcW
         al9GHNlr4cUcdi5pkfpmEF40EmtB0ZzqVGu/5jH+jnpJO7/BV9dbVpQmocrTi8kQk8vl
         +Nbw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZQfRdNXbrOSH6qNKjoSt6Z7USOoOfmDYJasjG2WTUKB3MhJZ8GBFWJCl3J0HanS+tMlI8kB4F+uI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9DQjkvct2lYyUoN1ZAPCBJxPcQrRKWHBYb6Q33j158MatIRV
	J9IFOvMoD4rKWR/ZkftBHmyGiCO+/5pbtfUSgqVLB83z/hQFDti59equlzs18z6jWLmLV7jrF6Z
	yxMrDx4QVR2mK8hjwFlgusQzZP+CD1kZw8w/E6bMyJfSJsRlcc2LdYU+o6vrK+rnQmGecgWAHGR
	MdRIyAjHPIcSc+CUeMygtCOhR4hAY+7cDD0S+aiM3Aiv4zdyoAmA==
X-Received: by 2002:a05:6218:280a:b0:1c3:89d4:e888 with SMTP id e5c5f4694b2df-1c641f40665mr502903955d.20.1731338584410;
        Mon, 11 Nov 2024 07:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMkRBV5laH6F6F0zmH4P6+rP5S9yHqymVKsBl9DIaOzkZ3owfdUraaM4bxTBR8r5n6WezVG9MP8/x4XKLdGss=
X-Received: by 2002:a05:6218:280a:b0:1c3:89d4:e888 with SMTP id
 e5c5f4694b2df-1c641f40665mr502901155d.20.1731338584114; Mon, 11 Nov 2024
 07:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com> <20241109120156.lipr33ykp73lzsxb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20241109120156.lipr33ykp73lzsxb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 11 Nov 2024 16:22:53 +0100
Message-ID: <CAEivzxe6f=g8SLNeMayjL8o_bhbmJb5spZPP7LVcbro4Em2VjA@mail.gmail.com>
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:02=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Nov 08, 2024 at 02:48:17PM +0100, Alexander Mikhalitsyn wrote:
> > Add a new testcase for [1] commit in ext4 online resize testsuite.
> >
> > Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libao=
kun@huaweicloud.com [1]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  tests/ext4/032 | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/ext4/032 b/tests/ext4/032
> > index 6bc3b61b..77d592f4 100755
> > --- a/tests/ext4/032
> > +++ b/tests/ext4/032
> > @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback m=
ount point"
> >  # Check if online resizing with bigalloc is supported by the kernel
> >  ext4_online_resize 4096 8192 1
> >
> > +_fixed_by_kernel_commit 6121258c2b33 \
> > +     "ext4: fix off by one issue in alloc_flex_gd()"
>
> We generally mark this at the beginning of the test, not in the middle of=
 test
> running. Refer to ext4/058.

Hi Zorro,

have fixed it. Thanks!

Kind regards,
Alex

>
> Thanks,
> Zorro
>
> > +ext4_online_resize $(c2b 6400) $(c2b 786432)
> > +
> >  ## We perform resizing to various multiples of block group sizes to
> >  ## ensure that we cover maximum edge cases in the kernel code.
> >  for CLUSTER_SIZ in 4096 16384 65536; do
> > --
> > 2.43.0
> >
> >
>


Return-Path: <linux-ext4+bounces-5018-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5D9C41CA
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 16:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A9A1F231E0
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544991A0730;
	Mon, 11 Nov 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tnfy6+zI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D419E99C
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338731; cv=none; b=bRVYIDoCTwQdNDsIIYLQT0wnCOB5GCyU6F9reklm2xQ3sJa2YF7QxO68oWzLdYOfyoJE7lSl+e8Vu11GZydyedIUDFjzoIzse6SkhiIOklXltwJUHWpm+9qfydLblF+f+/gwZye2gWCmcfBF7nh2WSACUgyqGeFPt6p118hePDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338731; c=relaxed/simple;
	bh=w1gsGMSTeFmgKZVtoNHA/56CEZWWQergphRwkdjTmAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5c9SeggIRh08M2ntskWCrYxrCr1035YjbivrNp58Wbv29cwA6v70e2ApRxVHnugpaUDZF2I8znFCvBpUvf0bvh5Yx7ggcexXFKK9HJ5Yv2XqY/rn3YilxiAbc360auYB8reWxUid3nNmW9BzxKuCNORD0VkPOjjgPjZai4HpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tnfy6+zI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1AC9B40593
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731338727;
	bh=QL3XjmSt0fXf6QyOofF2w0EPPa+BYfn/ilLlbtnEEYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tnfy6+zIPEiu3ZVYsN8y3SjSNyQwOvC/qh4ru0xiZmozxWZY6zrBXatuSc6dyTssC
	 qp3ewDy+HRjuTlbO4dWmGo8/6okTtdWtONmr18OseJZtmquG8HDbVYEe+xIkImOJv8
	 1WEvow5FUi6SATdDxreN2JH0DdUSEW0ushT7EWmpgk0gZ1b6RGveN0o4nTSkrzR6hd
	 qWKEXBK6q7kqtAG0BIVbklPXSMMqLqCrotnxsBuretVkJ8wkhqMgZ8qO1QrdKKXC5M
	 Fm+hgEi73Ed4YsDAHFPhAxjILvZwoJdskq3TtsBzC3y0BGTelUXVmxukU8vWIpQyPj
	 lwAgDFDdZF6kQ==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5eb6154407eso3843068eaf.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 07:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338725; x=1731943525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL3XjmSt0fXf6QyOofF2w0EPPa+BYfn/ilLlbtnEEYs=;
        b=p6l+ObuN/P6S7xCvFx/SOA7uhKcbLLkhYInnp4WTm49q0VMAWMlGqfA03T+seoUHFm
         Ik7XEvmkSyQlErlSRD6GgflPfkHuidoj/HS0zoiY9RFMo5JRock2GhMac03YCTBRAUdb
         m5usX3aMGfPeg3OTlZdigNjy0lH0JNPzx23vpg+GNu6DKsd9eS1oHZ8s8Mvgld54qE7h
         ZqCHmeWgPLdfjxNaCgktw+V9jNrVjPwBFWI7pqLLRxpIg7boDYybgJG+D4eoVdhgwR30
         McD5KTY6zR9MqEfmC3NXYUDeBb5E3Toz++diJWY6oZM/1EA8uzr3TgjBUqDFrjIDoImk
         rqgg==
X-Forwarded-Encrypted: i=1; AJvYcCVJxgrpRuLzD50gH4f8ObaPG7GSuZ5jQXr90HarX3keuFOuv5RwQNQ1+TduD9k7vZwVq2N6yc2AWUz+@vger.kernel.org
X-Gm-Message-State: AOJu0YzqKsepp0rdFvjAxbu9qGoWji6LTgz6GZk8Xno8sBej7CB+Rh5Z
	faSYDzuqryy6mv97u7rUGntWFNeEnx37Gh/Tq65eafxhhFKfLXZmcod8Sqq0e1jt80G5S9mi4o7
	u+SnpHdC85d+6wR9QY9uY37ab+aLx9Ki3818ZIqWGgRV3xy5MIFkb4oNFtWOGtQfeg0yhdfNckr
	IdvMCDhNqwjih6Jh1mJU7ZUHxERb3cUZh9ArcbTEPHrzz2Da97BA==
X-Received: by 2002:a05:6359:4282:b0:1c3:8d57:ea8b with SMTP id e5c5f4694b2df-1c641f37808mr458433655d.16.1731338725235;
        Mon, 11 Nov 2024 07:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcKQb7kbezzQqfsOGb2kZkBq0m0eTyj0NcM1dGKGpDevi56LPNvZMRrPtoU4GQWpUhNpPvPAwsKfVB4oqrHz8=
X-Received: by 2002:a05:6359:4282:b0:1c3:8d57:ea8b with SMTP id
 e5c5f4694b2df-1c641f37808mr458431255d.16.1731338724944; Mon, 11 Nov 2024
 07:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com> <d137f247-97c0-4a42-b4ed-ae84ad8e727a@huawei.com>
In-Reply-To: <d137f247-97c0-4a42-b4ed-ae84ad8e727a@huawei.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Mon, 11 Nov 2024 16:25:13 +0100
Message-ID: <CAEivzxc-=zsDk_dy7LnTUNzHqVTqm5vW9_3TBaCRrnmZJTxu5g@mail.gmail.com>
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, jack@suse.cz, 
	tytso@mit.edu, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 4:32=E2=80=AFAM Baokun Li <libaokun1@huawei.com> wro=
te:
>
> Hi Alexander,
>
> Thanks for the patch.
>
> On 2024/11/8 21:48, Alexander Mikhalitsyn wrote:
> > Add a new testcase for [1] commit in ext4 online resize testsuite.
> >
> > Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libao=
kun@huaweicloud.com [1]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   tests/ext4/032 | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/ext4/032 b/tests/ext4/032
> > index 6bc3b61b..77d592f4 100755
> > --- a/tests/ext4/032
> > +++ b/tests/ext4/032
> > @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback m=
ount point"
> >   # Check if online resizing with bigalloc is supported by the kernel
> >   ext4_online_resize 4096 8192 1
> >
> > +_fixed_by_kernel_commit 6121258c2b33 \
> > +     "ext4: fix off by one issue in alloc_flex_gd()"
> > +ext4_online_resize $(c2b 6400) $(c2b 786432)
> > +

Hi Baokun,

> I think this test would be better placed in the loop below. Then add some
> comments describing the scenario being tested.

Have done. Thanks!

>
> There are two current scenarios for off by one:
>   * The above test is to expand from the first block group of a flex_bg t=
o
>     the next flex_bg;
>   * Another scenario is to expand from the first block group of a flex_bg
>     to the last block group of this flex_bg. For example,
>       `ext4_online_resize $(c2b 6400) $(c2b 524288)`

This test does not fail for me when I test without "ext4: fix off by
one issue in alloc_flex_gd()" fix, so I decided not to take it.

>
> In addition, we need to modify the tests/ext4/032.out or the use cases
> will fail due to inconsistent output.

Of course, my bad, I forgot to add this file to the commit... stupid mistak=
e.

I have fixed it in v2:
https://lore.kernel.org/fstests/20241111152100.152924-1-aleksandr.mikhalits=
yn@canonical.com/T/#u

Kind regards,
Alex

>
>
> Regards,
> Baokun
> >   ## We perform resizing to various multiples of block group sizes to
> >   ## ensure that we cover maximum edge cases in the kernel code.
> >   for CLUSTER_SIZ in 4096 16384 65536; do
>
>


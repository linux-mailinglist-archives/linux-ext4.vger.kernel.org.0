Return-Path: <linux-ext4+bounces-6631-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966E5A4AC47
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Mar 2025 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0F57AAF97
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Mar 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAE1E22FA;
	Sat,  1 Mar 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOcNyhLD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B563A9
	for <linux-ext4@vger.kernel.org>; Sat,  1 Mar 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839587; cv=none; b=FvYKHBjiKd/Mj1akZuF9UEb/nF6su8e6mdVvCkOtYfB/7aWQresO1n1M+FEtw1k+VfCckJfRZR56qacDzEyHYzw4UDh7OMTX6k0GCDV32Ituu7eI9ZGoRLefea9WUVG2DZO0oT1X2Ei1EGoUXle/gu6BTX0oBjoALLmglNfupUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839587; c=relaxed/simple;
	bh=ZFjurXOY8coQ80MnLvAERJnxwvnQOkEmwEcLvE8uRzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcfT2uPq5Cg0YdCEnk56SVQhVh7c5b+7ykfSNiTnpOiEGuG1mTFS7hbblSEZ+l+dIxP6OIgKdmS5/Z7Mv2zB+B2kFTYKfu2GHevmEs8ZiKV4PzYNhAgjkzq16YgsBkTLLBoORWij1YdhTJ/18bwtZciBNubGkaVs+XkXw1dzRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOcNyhLD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5452c29bacfso3162821e87.3
        for <linux-ext4@vger.kernel.org>; Sat, 01 Mar 2025 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740839584; x=1741444384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7sg5sbSHkvB2UVLdBnklTMidRDcPt9A84p7EYq8C+g=;
        b=XOcNyhLD5XyTJoNOconYRn5FWPalrUHQUL6fA2TA2ABE2XYITm7iEyZsuyAxlX/Tc7
         Z6mCKIy++L9fZiMrcsfYK8ME238OfRjCKGvT3vgO3Q21N2LOgwgMSTgYDg5Mo1EMxqBc
         lG+jILv1TSrAN46jgct0cm+JUwrxR7ZnmnoFMV2c/4Q6p89p+ogwaxbOeMbqVHBzGy9J
         ZIxbdk4K/vU6fMIutIqEnREgLUN6Pv9ns1Dd8j+0EiuG9Iw4gV1mq2EApGXi/PVRCasc
         gmearj+rKcebvHfxZZPRRNLaRHVMs4uaa6yp7kbse6yiftrtFzATfuuqZbRUuPQKylrP
         +11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839584; x=1741444384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7sg5sbSHkvB2UVLdBnklTMidRDcPt9A84p7EYq8C+g=;
        b=o3oK9sEdAqJYqD9foZ1oDnDS/o8rGuz02smhCq8sGrc5aJsCNJ7pIcykYi+xySPT9f
         TkEwxnuKfAMaqa3MLdOJBMdZ+ziDmgkEsApctWLvKvGzK9wU+aG6Q9fB7KW+4R/Nw+7s
         RXT6Aavt7S80nlWCw3/kimDmJrUdqoYwNrnj23Cbo0ZKFFX34viQMK6YQAGqfcpm4alC
         EvzkUdkgvGVSg3XnFJhJPxZISqE7Nao0yJrlJZQUx6RVrnInw3aJiSM2sSSAJ6ysrY2m
         KAd0G3Ns6n09jMbau3eGes5nqTUg8Oq69u+QseT09bVJBSYT01gszVyXcDuQKZyNG5xm
         ICOA==
X-Forwarded-Encrypted: i=1; AJvYcCXOT8G/h5chvMChwA0IR3NsfoeE9N+h1mwLT7mCs9a3V1ijLokXiB0oHuMlbM0K7IFEA0yQHfla/Nse@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiLyM3b+EozEi/unYw4Ff3UwtLD+417+Ulq7MQXBiHUX6b9h4
	lBc/3dlejZhdl4u3R+HcdynIXM0sCEquJG4dFDmaK2mDPY8UwYfRKu+yhBe9OZnVgnBvPMepSYj
	Pl9iNrkNN1CptcC1eN1u5mCDdfnM=
X-Gm-Gg: ASbGncvE9IBE/otGrOx3vECOjlzp1agXHjv+daYO+Apz0cdXgeSA0ibaz4q8kza5yAY
	HU3A67RxZg8mvsGFMiDXjyUx1tvjNw/PjKPiQxhVtaJYwDo8KZwvjRaNzAvWpqY1QwMPIh02jso
	4jIvcWMKnvIULgFNOpjjjkDOvVaCw=
X-Google-Smtp-Source: AGHT+IGE0QZwRUyw+58HC+/z/f6p1un7fluWz18+7fZbsW2xFz804CiuPSYDG467pfJv5e00J7UFnm63jEuvjfb0K6U=
X-Received: by 2002:a05:6512:1596:b0:549:58db:6e9c with SMTP id
 2adb3069b0e04-54958db745amr1120835e87.39.1740839583389; Sat, 01 Mar 2025
 06:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
 <9be439b3-fd43-4a4b-96e5-0d0ec5fb1509@huawei.com> <CAHB1NaigQx0HW3Oxd2P9uujGk221WjxeKOgaNj-p2WqMJaQZiA@mail.gmail.com>
 <20250228133440.GB15240@mit.edu>
In-Reply-To: <20250228133440.GB15240@mit.edu>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Sat, 1 Mar 2025 22:32:50 +0800
X-Gm-Features: AQ5f1JpCRWK3clBRbnNPTxQjdS9dB1KBA5FRJzX7k_BH6ARXPWh2udX3GSX_WZ4
Message-ID: <CAHB1NaigAoV3kUowQFnj3CBmPLcQMpHWMuL_pFOtKQd_An4A+A@mail.gmail.com>
Subject: Re: [PATCH] ext4: remove unnecessary checks for __GFP_NOFAIL allocation.
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org, 
	adilger.kernel@dilger.ca, jack@suse.cz, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ted.

On Fri, Feb 28, 2025 at 9:34=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Fri, Feb 28, 2025 at 05:30:06PM +0800, Julian Sun wrote:
> > > Actually, even with __GFP_NOFAIL set, kcalloc() can still return NULL=
,
> > > such as when the input parameters overflow.
> > >
> > Yeah, agreed. But IMO an overflow shouldn=E2=80=99t happen in this situ=
ation.
> >
> > If there's something I'm missing, please let me know.
>
> It's not a matter of missing something; or even Right vs Wrong.
> Different maintainers have different tastes about this sort of thing.
>
> The mm folks have changed the meaning of __GFP_NOFAIL in the past
> (TL;DR: they *hate* that concept, and I wouldn't be surprised if they
> try to change its behavior in the future) and especially in large code
> bases such as the Linux Kernel, I'm a big believer in defensive
> programming.
>
> As Linus has said in a different thread, when a compiler adds warnings
> because of what it thinks are "unnecessary" range checks, that's a bad
> warning.  Adding extra range checks is never a bad thing, and compiler
> behaviour that whine about that sort of thing are.... unfortunate.
> Similarly, I'd much rather keep the extra check.
>
> (Also, there exist static program checkers, such as Coverity, that
> don't know about the semantics of the GFP_* flags, and so removing the
> check would actually cause those tools to complain.)
>
Got it. Thanks for your detailed explanation, it makes sense to me.
By the way, I know you're busy, and I=E2=80=99m not trying to rush you, but
when you have some time, could you please take a look at these
patches? Thank you!

https://lore.kernel.org/linux-ext4/20250107044702.1836852-1-sunjunchao2870@=
gmail.com/

> Cheers,
>
>                                         - Ted


Best Regards,
--=20
Julian Sun <sunjunchao2870@gmail.com>


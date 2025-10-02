Return-Path: <linux-ext4+bounces-10562-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CFBB3F3E
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABCF1899BD4
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 12:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA9311589;
	Thu,  2 Oct 2025 12:56:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E162F7ABE
	for <linux-ext4@vger.kernel.org>; Thu,  2 Oct 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409784; cv=none; b=IbnBmd9E/1Frf2LdXJyaR9AZtXlNPZvdllyKRw3NlyDk+h3kB6B3zGMPoggRNcRmGqQ32anZM55ZvBke2G3m5u1PWjUpZKKCcnynFblwTP1mE92EutiRX2lppWpaOTqEHjE/1TsddF7/D+wM+URHnI2mqDqmlwCCRNXaBE13H8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409784; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXYoWLLI1OreCsLXSabsLXq2WToNM8ZQj2LwPsBbOxLralGbD686u3uVA7Qdmsp9CTeQQW0lEcXoEP0TF7+KMoWKPiBh13DB2KWllsNfyE3lipqvK4aRQOX321TpJeEk8N6MAgl6zqCqiSpxcgcwPmwO6wh8epo7Y+qZH4zazAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8e401b11bfaso322387241.3
        for <linux-ext4@vger.kernel.org>; Thu, 02 Oct 2025 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409781; x=1760014581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=LQPSuPCgCuIcCDNZpafn4rxfiNvQa3vr+8c7o18BIAFAJiLet3JWYEFueuDeHh8bDf
         UqmPhnJKsXVW2zsUUeq9Vji4zWnAk9wF6OO3k4YkzPCk161z1s6+Y8nStw8Olwcr7iEm
         aBMsQWeFrXnAe1zvRchsgUuv7zaWYexq/yncMVl5EkViB6A/NnPQIlzWn+9tcWrv5Q+q
         Ab2cHK5YFYFBMct0XGbWUCUNsCroaJUKFPdY5QnFkSrE2v4Tbmu9W5dJNc4ikC16QqJz
         dbbiguEY8rwv+JZ93U76p85tsS9mqXQrzof7jXq4Giiywfo8KR239fga4D++cPy38Udp
         9wdA==
X-Forwarded-Encrypted: i=1; AJvYcCV4F5sgRNhdEHXKUFc+/NBSy3RkGS4TQIliodHgOXdaWL9ib2X5mUjLolSKMOXvb6ecDbrAwBYZJ1xR@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQTxKnCg/wU2KLsqh76nik9qaJY5lIqI5+jvB9ROIAKLw2NvX
	P19g4lU9i1lOhXmNM2PYRLbUcoSbasItN2WXzJ4NR23YfRN3QlSaZ267FjzOf0i74OPkwQ==
X-Gm-Gg: ASbGncsJLVc1XguOVeXlBQ6CvU3y9Uq5WyzDIJvLmKPxRroJFQwEIevX90JGCHtVQj6
	rqxJTNr9obl1FGmdGiCkKh9asdmw3+P4Aesx3MWDuc/YWB0XldPk01MbhGJchmQw/0SDNkT4H+2
	6B5ekyHqSQiv8ihcH7k1cYHK6fie4uzZb6Qu+ow/DyYI4sFnYkVVrzYtypAQMTktOvqsAyxLWqJ
	uOSmv93HC9qnLt/zY9AqikWuoIplqaz908neFWzCfqNC76zG+PgD9AZ9UauRPfgwtr3d0gvagQd
	KtsN83oQ30qrx0L4oEA+3L1yvuO9DRnMi68hvLaEkxstaG+hi/mdpN0JhdvqzxlRTuWajp8e2Bf
	kHesEKkUDOyUXRccFPOqW7a+O0Psjp7y/RAJVvuxW9RneIkam5S1DsL34NbZsmHgf8kKG79/10m
	cn/o3w+FvF
X-Google-Smtp-Source: AGHT+IGJH4R7qP858ao3aRwF1Te6HZQsRLvnszECZN4TjGOxge4ZGb64TtKHnVrxSofoumXbMXNeUQ==
X-Received: by 2002:a05:6102:5111:b0:529:1815:ae8f with SMTP id ada2fe7eead31-5d3fe37d7femr3066315137.0.1759409780959;
        Thu, 02 Oct 2025 05:56:20 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c50d3b0sm575020137.8.2025.10.02.05.56.20
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:56:20 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso566168137.1
        for <linux-ext4@vger.kernel.org>; Thu, 02 Oct 2025 05:56:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuYnP2lvpzipzULeyXPzpviZFjD6ABQ9+p7DikvuUWy1nEDVAISIzG2XlxCViUfRPngf2rDfTenpc4@vger.kernel.org
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


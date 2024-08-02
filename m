Return-Path: <linux-ext4+bounces-3614-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933894642B
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE09283B56
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A144F615;
	Fri,  2 Aug 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZcFBVh7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162B22626
	for <linux-ext4@vger.kernel.org>; Fri,  2 Aug 2024 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628738; cv=none; b=JMLfodlzVXEYiF2ILjxPuMmmJo3LX65hZJotRta9E6wLhK/yseY1i03rPh7s6jH/ryI8c28V1VB/IRv5S5eDh1wbly7z93Q4qN/p7GeFuZhdVuUzjAGNly0JWY5y4d/JrAidkuMF7C/zbZnTaeKIBRnKDtD/AUlfpybDjO4iOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628738; c=relaxed/simple;
	bh=8RflBWc9HdsepNBgAIhHnnyyaSdbfrI4sAe/ie+rY1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpbTVMCFvjKcwwCjcejYAgYVmiROIcIXntIQFF19xkvj5S9Rh3sBUVQH00j6fIBAGcJ8usivvn7a5hx1kfGkLx51em7zeGS0S+U720mzA07b4p3KYlBvLOEYQSyPF7cauIS2VLh+I4y8OK/7VDHh8HaYuHJJWL0VNcqt2oqFme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZcFBVh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722628735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVHWlGsfaV3JAt83FTQK6nu3pxL1il4gTxx8tNRrfvQ=;
	b=iZcFBVh7gq71fGR+4B8/p/a6FlK/ss3dI623lHgHg4jubWumm4+rxL09cGsxsajw2/atMN
	flW070tt4zLfSSY4iKbXi1akSl2EtzlpokJI9J1JO25P/8WCOjuCZkaxR17+qDYZXNKh7t
	JUzj6k0VzFVkMNOwHOQoUTKP3etso9g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-YUXrWovAMXOzoPhIbBs8cg-1; Fri, 02 Aug 2024 15:58:54 -0400
X-MC-Unique: YUXrWovAMXOzoPhIbBs8cg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3683f34d8d9so3654118f8f.3
        for <linux-ext4@vger.kernel.org>; Fri, 02 Aug 2024 12:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628733; x=1723233533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVHWlGsfaV3JAt83FTQK6nu3pxL1il4gTxx8tNRrfvQ=;
        b=rZbUKXc8CCn4OVGR5ek965uYL0oLqALBM9398lXC5j5xo0u+8uMbIJ5etSBlWq9bch
         og+oQEqpx8aQVFyMWLM3jicyb/pgM4hGvh1xHdxTum8lIopICgVm1EoU3tlMGSL8kuzw
         LvCcnEEwt1hbUgtkVQcVYImJBI/WUwYtJBggul7pTRZmzfuE1MS7VRXPXdg9RqW9dNCf
         K8wA4Kl9EUMYamle7BengObFMAbMSR3ORTgIIsbi9iwZ+vbtleF5K6Y59wTUJDHYmucp
         CU8Fv73dK/4Qgg3FHADkcX9mQNsEQxGSYGAzG5M0bOggR9dax912pis2m384hjndjAyb
         HySw==
X-Forwarded-Encrypted: i=1; AJvYcCXnzp7djpq4iu9+qaklBUHOPrpWVGZz8Til/Q1dz723ZTXU0Ude30EY/QhXicD76yaggEcCnzcBmYNlNinh98figwimbMmv5FA7BA==
X-Gm-Message-State: AOJu0YwXbBV4d1IfMofbTyntAgDbog7seBCMEU/MWbON1tu6c7VsImub
	2JSukXKy5tiUGeXIVFhIpDKozFO+Ak4NCjb8nESwKIJ8raaynUhRSL7Y0v/RCA80ReZr8kbHeWg
	EMmvyFtAGrHokGifbxT+2qpjJft5kkGhlijxmInPci+XduGtjAAmHOhRf9s0y6li0ZnPXfsCcfW
	pw5U1W9w7skgQ3/Sceda1g4spsKbQK7QqBrA==
X-Received: by 2002:a5d:5248:0:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-36bbc0fff6cmr3060524f8f.29.1722628733317;
        Fri, 02 Aug 2024 12:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS5SPkZfAr0vXFFRZu1Yab/IPcHMXY8x40w225u7qHkyq5S7m0WufO2JL7b85IhyzCj5VjGL2TBHM7lGDiaXA=
X-Received: by 2002:a5d:5248:0:b0:368:319c:9a77 with SMTP id
 ffacd0b85a97d-36bbc0fff6cmr3060506f8f.29.1722628732248; Fri, 02 Aug 2024
 12:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a26aff-78b4-4e87-9c83-8239d238b381@online.de> <Zq01Nx8SyhoY0/R7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
In-Reply-To: <Zq01Nx8SyhoY0/R7@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Bryan Gurney <bgurney@redhat.com>
Date: Fri, 2 Aug 2024 15:58:40 -0400
Message-ID: <CAHhmqcQf+kYnYmQqEyC8033bSDT5F6x6WKt-TEcZ06e1j=gAjQ@mail.gmail.com>
Subject: Re: Understanding blktrace; measuring extra writes on ext4 with
 open(...,O_DSNYC | O_TRUNC)
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Max Schulze <max.schulze@online.de>, linux-btrace@vger.kernel.org, axboe@kernel.dk, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 3:36=E2=80=AFPM Ojaswin Mujoo <ojaswin@linux.ibm.com=
> wrote:
>
> On Fri, Aug 02, 2024 at 10:28:47AM +0200, Max Schulze wrote:
> > Hello,
> >
> > so I have an embedded application with limited flash write cycles. I am=
 writing 2 blocks to disk 5 times a second (ext4, block size 1024).
> > The data written is binary and fixed size and to date I open the files =
with (O_CREAT | O_WRONLY | O_DSYNC | O_TRUNC).
> >
> > I set out to measure whether this O_TRUNC leads to an extra write (beca=
use I might be able to do without - data is fixed size) and understand the =
linux tooling around for inspection.
> >
> > I wrote a test script, that creates a 2MB ext4 file system on a separat=
e block device, so I can trace with blktrace -d /dev/sdc
> >
> > If somebody please could have a look if the interpretation of the trace=
s is correct and what the missing identifiers are.
> >
> >
> > Below is the output from blkparse for the moments where I write with op=
en (DSYNC | TRUNC)
> >
> > >
> > >   8,32   2      152     8.831293895 22900  C RAM 2060 + 2 [0]        =
     <-- previous _C_omplete
> > >   8,32  10        2     9.245982628 14449  D   N 0 [kworker/u40:2]   =
     <-- D =3Dissued
> > >   8,32   2      153     9.246369033 22900  C   N [0]                 =
     <-- C_omplete
> > >   8,32   0      200     9.268019255 15706  A  RM 2062 + 2 <- (8,33) 1=
4    <-- A =3D remap
> > >   8,32   0      201     9.268020922 15706  Q  RM 2062 + 2 [writerdt] =
     <-- Queued
> > >   8,32   0      202     9.268034745 15706  G  RM 2062 + 2 [writerdt] =
     <-- Get =3D allocate Req.
> > >   8,32   0      203     9.268051167 15706  I  RM 2062 + 2 [writerdt] =
     <-- I_nserted in Queue
> > >   8,32   0      204     9.268107127   161  D  RM 2062 + 2 [kworker/0:=
1H]  <-- D issued "R"ead
> > >   8,32   2      154     9.268704050 22900  C  RM 2062 + 2 [0]
> > >   8,32   0      205     9.268881750 15706  A  WS 2160 + 2 <- (8,33) 1=
12
> > >   8,32   0      206     9.268882510 15706  Q  WS 2160 + 2 [writerdt]
> > >   8,32   0      207     9.268890935 15706  G  WS 2160 + 2 [writerdt]
> > >   8,32   0      208     9.268891685 15706  P   N [writerdt]
> > >   8,32   0      209     9.268892510 15706  U   N [writerdt] 1
> > >   8,32   0      210     9.268895672 15706  I  WS 2160 + 2 [writerdt]
> > >   8,32   0      211     9.268913234 15706  D  WS 2160 + 2 [writerdt] =
     <-- D issued "W"rite "S"ynchronous
> > >   8,32   2      155     9.271009859 22900  C  WS 2160 + 2 [0]
> > >   8,32   0      212     9.271041534 15706  A WSM 2126 + 2 <- (8,33) 7=
8
> > >   8,32   0      213     9.271041910 15706  Q WSM 2126 + 2 [writerdt]
> > >   8,32   0      214     9.271051615 15706  G WSM 2126 + 2 [writerdt]
> > >   8,32   0      215     9.271053774 15706  I WSM 2126 + 2 [writerdt]
> > >   8,32   0      216     9.271075678   161  D WSM 2126 + 2 [kworker/0:=
1H]  <-- D issued "W"rite "S"ynchronous
> > >   8,32   2      156     9.273122709 22900  C WSM 2126 + 2 [0]
> > >   8,32   4       67    10.277429577 13420  A  WM 2050 + 2 <- (8,33) 2
> >
> >
> > -> What are M and N in the "rwbs" field? I could not find this in the m=
anpage.
>
> Hey Max,
>
> I had the same confusion sometime back and had to dig in the kernel
> code. All the rwbs values the latest kernel supports can be found
> in this function [1].
>
> So 'M' is added for metadata requests eg when FS is reading some
> metadata blocks. 'N' is added when the request is neither
> read/write/discard etc. I'm not sure what kind of IO results in N though
> so maybe someone else might be able to add to this.
>
> [1]
> https://github.com/torvalds/linux/blob/master/kernel/trace/blktrace.c#L18=
75
>
> (I'll try to go through the trace you provided when i find some time and
> update here)
>
> Regards,
> ojaswin
>

I did a presentation on blktrace / blkparse at DevConf.US 2019, so
that presentation PDF might be useful [1].

The "N" is shown mainly for "queue plug" or "queue unplug" events:

P  N (queue was plugged)
U  N (queue was unplugged)
UT  N (queue was unplugged by timer)

[1] https://devconfus2019.sched.com/event/RknY/block-storage-tracing-in-the=
-linux-kernel


Thanks,

Bryan



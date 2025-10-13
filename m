Return-Path: <linux-ext4+bounces-10822-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1209BD17C8
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 07:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECAD3BDC3E
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E592DC764;
	Mon, 13 Oct 2025 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+I7ZrtE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF02DC772
	for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334273; cv=none; b=k8ZniBWq3YkJo6DapUUXkTzZvQ5Bwp/lIYPtb4Xk7r+gmeGRzYYEZz02+N4JgqPD30zk3W50ZtJBEcEzQIhtaw4kCkyKo6k9XG+z337vHVelI2yeDmx1Atx54bmj+Z/SYTNuiJdAqxqjRh2qrajXyDGjmkZ4Rs0sOHwbAbauFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334273; c=relaxed/simple;
	bh=Vluz9ytPQeMtlO7P9ORKtagTdZgZUvCkj7WhJdLaLOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLO6djvW1043L2FklLLhXFqUm+OPk0BfuLTFf1OL/NLmwqMItYCIReaKt6+Lj33/biOqEnHTbmA4Snc6H7Yv8APhdtyAX2/HoF8CMBSV4NCgv+HZtWiCbzoJLAeypAORVSRNuDvAkxe+6IL7M/jeDlUPe9+tNqoKDns5OBhY0Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+I7ZrtE; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5b59694136bso2273488137.0
        for <linux-ext4@vger.kernel.org>; Sun, 12 Oct 2025 22:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334270; x=1760939070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfZ0cjDYVK5lhFzxXW1zOC477aQ4q/mTU1VD2TvA1nQ=;
        b=Y+I7ZrtEUyrbBVyxb/pwVHSPm/NUjdcUN7p2QIOR2Gc76JioaCNAHT0DpUo4aQJBuh
         6U3XRCAD4pT22cE0CZIrWjFoF94AIvPb3sECA4AIwObH5az4F4oBgbgRjAHJ04DUSgIN
         cgJWnI10SIM9wQD8DIf6C2A8ZivTesUbfjQGHDwE2Xta85NwyTJaH02gd6HZZnUc2Iqh
         /b9tlDquyWgeVVEOknwdr29PWPcBZODGzVtZOZKagmwsoSyx+ITO/MQ4LKrvzqej7/Nv
         t+me5XWphNc1k+F81d5qH4Z8A1bOgpxWdzw1oKqHAm1sQO0Uy4SnSje7hng2iB1YlAnS
         JpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334270; x=1760939070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfZ0cjDYVK5lhFzxXW1zOC477aQ4q/mTU1VD2TvA1nQ=;
        b=Th1xOF/ZvbLFIf+FmDpCoW5RchvmQtqeJOMEhWZm66vwt/PFRE/h6K45ySyxFHdI0H
         si5gtiubsFdHr5t76fy+djqcuokWxxjc5HQ4TxWz2mnyhn62YxuCPyMxdBTe54moy6yS
         fIgTJPBOSrNzW+UxmKRRx/XTlRlvV3yBvjd/nn+5CbLi2dxQs64SB89ETtQmnnW+IxoH
         H6A5YId3xUVzacgGEWDv2QR9V33KygEPKJPr+S0nzHe35/ZOlQrAxJJUhNe4syxj+fFi
         Ck8dDo8QlsAI8ZfLKmb9yDQj0nkNhnI/VaphcmAfQWhoWeTfNR1YTOxMvy6B/WOQ03Ic
         ccZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMXlUgAL3L9X2jQBx3QQecNqvpfkdjHkQgL1n8i747u7nokNLLdjsTqDgxjLTFl5CD9d6Siplyk5V1@vger.kernel.org
X-Gm-Message-State: AOJu0YyuipVxyNpmYN7xS7bTK3aBD/1aaM3fZtC0BqpJvmb9yaARdhnu
	ykTDcbtEopngZF69H5r3tG7tSKgBswnJc4PwNTFoyF5LilW8KYhWIfJBCcyqfuZhqvLQJkQxI3B
	RjM+gYjMFMh7FuyPfoFPsicU+VGjxiU0=
X-Gm-Gg: ASbGncvOQZx6x3Awxh5PxKbn2mVFEsotlnczCJB32HkzxMJTfLamKGW8uSmGmd66d3Q
	te3Qn0JoRxaENi70xJk58iS4iXz2mcpVt/udzb5t/VUrFEoD3zRhmHGQQkfai6Myorwl8SVu0sS
	DKNYmxeFPaTQxrgg7dQYDFwTK1FJBfC1mnYGNLiyNuTGR6pdvIYKQNgJQQWy6ufYCTpVYM43NQJ
	xJIyOryk9wBLPnLWSujrlxxMHA=
X-Google-Smtp-Source: AGHT+IHpSmXJAORlFvfBjiO5EpZknUsClCESfr6miv9ORXUHlNjIb1jckJtzwj7e3Gce86ucBxKeE0hLKTbq4g4SBL8=
X-Received: by 2002:a67:e009:0:10b0:5d5:f437:92d5 with SMTP id
 ada2fe7eead31-5d5f43792efmr3865770137.3.1760334270191; Sun, 12 Oct 2025
 22:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011013312.20698-1-changfengnan@bytedance.com> <aOyLlFUNEKi2_vXT@fedora>
In-Reply-To: <aOyLlFUNEKi2_vXT@fedora>
From: fengnan chang <fengnanchang@gmail.com>
Date: Mon, 13 Oct 2025 13:44:19 +0800
X-Gm-Features: AS18NWD8kq6UQsDDGG0qKmrz3bfZhv6wKElSNkMZ019t6wf6DXrrEBmZE82HmfY
Message-ID: <CALWNXx_J5L1fjTrVA5ChXsPdGk5E5HSuNHUO183mVat6GZdo=g@mail.gmail.com>
Subject: Re: [PATCH] block: enable per-cpu bio cache by default
To: Ming Lei <ming.lei@redhat.com>
Cc: Fengnan Chang <changfengnan@bytedance.com>, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, asml.silence@gmail.com, willy@infradead.org, 
	djwong@kernel.org, hch@infradead.org, ritesh.list@gmail.com, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:19=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Oct 11, 2025 at 09:33:12AM +0800, Fengnan Chang wrote:
> > Per cpu bio cache was only used in the io_uring + raw block device,
> > after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for IRQ
> > rw"),  bio_put is safe for task and irq context, bio_alloc_bioset is
> > safe for task context and no one calls in irq context, so we can enable
> > per cpu bio cache by default.
> >
> > Benchmarked with t/io_uring and ext4+nvme:
> > taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
> > -X1 -n1 -P1  /mnt/testfile
> > base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_biose=
t
> > decrease from 1.42% to 1.22%.
> >
> > The worst case is allocate bio in CPU A but free in CPU B, still use
> > t/io_uring and ext4+nvme:
> > base IOPS is 648K, patch IOPS is 647K.
>
> Just be curious, how do you run the remote bio free test? If the nvme is =
1:1
> mapping, you may not trigger it.

I modified the nvme driver, reduce the number of queues.

>
> BTW, ublk has this kind of remote bio free trouble, but not see IOPS drop
> with this patch.
>
> The patch itself looks fine for me.
>
>
> Thanks,
> Ming
>
>


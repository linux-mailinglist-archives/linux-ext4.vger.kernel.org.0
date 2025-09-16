Return-Path: <linux-ext4+bounces-10194-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2392B58B7E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B034E1576
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A25A222578;
	Tue, 16 Sep 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGzWjT6J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC745221FB6
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987337; cv=none; b=jP8Ea9+1jpuvoeCvlY5cnd36H9zUW5JYP52vopYTHf7tR5VQlLV343ElwEL/iF0a0bAFJSKKbhsJCZ3Ka0zIfzU8FdibDBZH8FMzf8Qfhb3mZHteE0kD4Kg1tk+urTSmuhFJRr2B7Maosdl7Up8r7v8komb6e/E1n5kCZgPpFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987337; c=relaxed/simple;
	bh=ixp1vRoqVO/aQuZyYy6zFP7jfZFHYTqyHd5Z6tSU/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdWDJiuy4aNUf7QGzrOxRcSOhvftyVTMvnbc1MSaJ24FXE6ir+9n34TwgMO95xJbAtK8gVSoldVtSQFpZIpDTr7N7glpFSlw+qvDQFLz8ZsWRmeFd1JTnLGQf9HXmYGGzZ84Psx0aDJH9fIgJeaG+zLyJWQWTmqi3BfXkr16lJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGzWjT6J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757987333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=;
	b=JGzWjT6JFY44F9HuG73zfC+XVXSpyEZnpQCAqiavnVJaex4OmR07wPNEUXLEBK3aPPNASb
	DTaTB1gZFE+DJer/o51vsb0HNic3DYvivGyJhMpU+pMvEA5BzK1/RIXnL5VmsY2pUK7A4X
	JJbm37DGkbr6iy5wEYEwqu+Km41BUrY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-oHsJnLMkM6KYptX7tdOC2w-1; Mon, 15 Sep 2025 21:48:51 -0400
X-MC-Unique: oHsJnLMkM6KYptX7tdOC2w-1
X-Mimecast-MFC-AGG-ID: oHsJnLMkM6KYptX7tdOC2w_1757987330
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-571c4a20e8aso1867403e87.3
        for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 18:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987330; x=1758592130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM/63QbNRNL2CWSzKhJPtVEvJogEqqs3VcsifJT7nZg=;
        b=FOi3haReNeeC6SzUuBiJomJBLKXFVFLKf5en0cz5TKpXZ2oZGTvi3fvBBzJUqWySqU
         k7InmfpdohnF0iJXmZwi8aS8J3CSsar/GNatSIRLli8Jaqb7dlrs06JBV/cr/uyVm6kN
         +AyUGoea8lKgDhtv36PTfmXgeYykhupAYBoEn78JQYnn+hWhIT/ygKxOB+Rz38jIkJDA
         jmZmuEWzqfPFQy6dbQ7joHuQ1Ldo/fQ9g7Lfsm1/muzlBu8flZ0obkFRLa9avXqnIBqx
         Druiv/BSp3EnkFd/OJakgYPBbZStOm4rLQ7/dt5YER+ABTIY4IlADfGWiE46RQEyC2th
         u9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVen6TqByqvecZUcCjv1JYb49zauuseBh+15oo0HZflIcsxYe3WfeTNDFn2BTbzkWPNj1VZdv9FHIju@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0mUIPiOkTBd3YBVtei4W/LZh67QDZrSVwTWyETHO9abpH9rT
	ikmr17g5P94QcK3vo1EbfH+Lara9W5aNxWE+EIi8CzlWtArvcAYxoK6iuKdSmO1/oUQuMX3fmRV
	VTTiD1QvIWqf2H4vTZMX7YXpoTZFzSSLyzGfq+RvnZyqYcutHYZLQn5D4UGtPZXYvkeVFScwbaR
	rb3t7FKx9MEBao7tTFKKoQs9JNlyicWveSh74nlg==
X-Gm-Gg: ASbGncuIh+T9CjQM8Aeq1DcQZizTx70SwBdPyaUgdSPkg8QkHY37vueSmcn/5F3dHXh
	z1HBQtNlCN08gfRn6YrO9UzM+sFNkQ3pww5gLxX8Uv4uYRPZQE3fBMTd964Mtk7hdhQdiktKk3O
	Z3UqF0GFY1Hen0lcxdfApolQ==
X-Received: by 2002:a05:6512:3f21:b0:563:d896:2d14 with SMTP id 2adb3069b0e04-5704f7a3535mr4252959e87.36.1757987330052;
        Mon, 15 Sep 2025 18:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi0qyrJSXhatUAjAN5GaSbgChEfkulnz/zBRoEI09ayrVbCpTRhDlFRFU2ScIQdlOHU/dANXpgiKsiuT/Fm5k=
X-Received: by 2002:a05:6512:3f21:b0:563:d896:2d14 with SMTP id
 2adb3069b0e04-5704f7a3535mr4252904e87.36.1757987329545; Mon, 15 Sep 2025
 18:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912223937.3735076-1-safinaskar@zohomail.com>
In-Reply-To: <20250912223937.3735076-1-safinaskar@zohomail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 16 Sep 2025 09:48:40 +0800
X-Gm-Features: AS18NWBkCHbtMZDfiuZiXnfW8KzozFHrUJlGejiASEzNumvZVB8NmHoE7UrrQwg
Message-ID: <CALu+AoRt5wEgx-=S263CReDf8FmLWwjs8dF9cX4_jFcMUkuujQ@mail.gmail.com>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@zohomail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, 13 Sept 2025 at 06:42, Askar Safin <safinaskar@zohomail.com> wrote:
>
> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.
> Initramfs still stays, and RAM disk itself (brd) still stays, too.

There is one initrd use case in my mind, it can be extended to co-work
with overlayfs as a kernel built-in solution for initrd(compressed fs
image)+overlayfs.   Currently we can use compressed fs images
(squashfs or erofs) within initramfs,  and kernel loop mount together
with overlayfs, this works fine but extra pre-mount phase is needed.

Thanks
Dave



Return-Path: <linux-ext4+bounces-6281-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE9A24620
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 02:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766633A7C5B
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6B1805A;
	Sat,  1 Feb 2025 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmutSA6C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF3AD21
	for <linux-ext4@vger.kernel.org>; Sat,  1 Feb 2025 01:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738372769; cv=none; b=BubGLFnF3LKYaV3xucp5VA29w4V8dp8ENny8Fc6BGn0vLTZjn5pdKI/RlUlvMhhiDwQQyVZpoGr40mVKoa11Q3vepwuwnOhsnInx8Dbk70I5qHtcWn9ddJYnj/Iv8wRHiwz0Zds7m/0tVKqHGQ8K99OezAq0JjuazrcEshOqx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738372769; c=relaxed/simple;
	bh=oWCwRVX3HiltEmJ0NJfrEKkEaikudV+HxZPQ1780JTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5e9rk3R/ZL2uLUeuOaZxjJqJqc5h9xE3HdKHmkAEj4nx3ywdJsKBxtjbswZmkbxCljE1IuR4NNVEsa0qrduob92JhAc4mQHAVsnojwE/nmRXWBFzrfeUgHEjGVpcbdDg6kN5d5WojP4FVOhIXpMxY2jDmCmK0OIRugloGqARDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmutSA6C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738372766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iutb+f8svSiQJQKyELECXpPORtK9MA8lQS48vaY5V1E=;
	b=JmutSA6CLjrBl31tyaO9Ktcv5YLtrU2iwxn35C4pFCstjgFXx6Z1vLAsaUd1TTTm4JxepR
	6yZpRM4Dh91JS4M9FUW8cZjshFLsUVToIubEvlneCiIR3ZJlL4M3H+euYJRPL/Ag+aQev9
	iAClemAchAkMiOMxqfXerSHrxMah52E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-niohUYvvODawop9oGG25Iw-1; Fri, 31 Jan 2025 20:19:25 -0500
X-MC-Unique: niohUYvvODawop9oGG25Iw-1
X-Mimecast-MFC-AGG-ID: niohUYvvODawop9oGG25Iw
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f2515eb3so253919185a.0
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 17:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738372765; x=1738977565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iutb+f8svSiQJQKyELECXpPORtK9MA8lQS48vaY5V1E=;
        b=dg33757Bi0THLPhFgCTKtosa4uU0wrvf48bakkiVdDFZqA/QYU8EoipTEo4166j1fx
         Wnh5JN8NU7uHNDAKr/OyviipzoYy/GdF8Fhl0otpiDiPWXnEe4EvTKCFxTBj2CMk5JeL
         uoZK6ODIY3WWJNCweBws+VIIOC13QkmHdmg2s0De94yQVovPjxmUfWHKmQG2PEFR3rM7
         IS3vrXtPeNK+n2vtVYdC1W+Y2Q8bJGOtOpNtScOadPRmjNWh/O1v9RtAoIqwhoxjPh8d
         /6rLjbUQ6qH5uHcn4G9HzxNnSU5e7XpQM/jxKzkAhBwe0KiWzPXcEayGW4QAgiUefgFK
         fSdA==
X-Forwarded-Encrypted: i=1; AJvYcCXHv6ArcM175OuIw976gJ4zfpOgUBsGXvwxwSYHmAZZWCN1nnnKNp1QR9ZzWGm2SN7FQGRCjLkk4Cqy@vger.kernel.org
X-Gm-Message-State: AOJu0YyREsZeX3j5qL1CHOWBmhaYysbc3fOTDqNfMH3LW7HyApTvVXwV
	BZqNco5U2MX8aUA6s1YxJCWb2vtrUsrU9IhmRAPgncv/ZL6zyR0wQ2tzsecE28s/JI8YjLgQjL9
	Kk0mPuVCBE6CoflafhHqRea/0fAeJ5NOnPduqGG5cFawkHK9nXupxyvPEr3w=
X-Gm-Gg: ASbGncsfkWC97DwcbEoQ1wfLU2n9nT7e+0Hb5b0RXk7wbRzcTpYsYKHmfMlveMWadbR
	xX6y9ohNCqYn2QGLvMzTxpEiejR5Gy6OWfkEt+j2SSYC8iLalEJYpA2bkxpj3sQf14JRJtbvTbT
	rNBHWWQ9WqIxOiqG49NQSN6XA+oZJAKhWWyf3X5oMbIp9FF2z/JK8yIAnN0SRkr2yL3hcYb7JQg
	BLLzYXcC/Sb0ffvyvsxI1xwyeiybwwwavZjIezcFaQtPTjW2E5pTGEhlFI+CxHv74HT9TGD+LRg
	SL33FeA0trWZeTSEI7ZzTVTHb6a8jI+2cCWRfQjP8HY1F8aN
X-Received: by 2002:a05:620a:4304:b0:7b6:6bff:d13f with SMTP id af79cd13be357-7bffcd901abmr1890779685a.42.1738372764912;
        Fri, 31 Jan 2025 17:19:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1bH00mv1WK4WNu1gZToSc4hfDszMAYhLI2X7IUvKosEz+tCfK4Su+RxkyQl3oxUQfYV1vGw==
X-Received: by 2002:a05:620a:4304:b0:7b6:6bff:d13f with SMTP id af79cd13be357-7bffcd901abmr1890776885a.42.1738372764552;
        Fri, 31 Jan 2025 17:19:24 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9047c0sm248232585a.86.2025.01.31.17.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 17:19:23 -0800 (PST)
Date: Fri, 31 Jan 2025 20:19:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults
 for files with pre content watches
Message-ID: <Z512mt1hmX5Jg7iH@x1.local>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
 <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>

On Fri, Jan 31, 2025 at 11:59:56AM -0800, Linus Torvalds wrote:
> On Fri, 31 Jan 2025 at 11:17, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
> >
> > This breaks huge_fault support for PFNMAPs that was recently added in
> > v6.12 and is used by vfio-pci to fault device memory using PMD and PUD
> > order mappings.
> 
> Surely only for content watches?
> 
> Which shouldn't be a valid situation *anyway*.
> 
> IOW, there must be some unrelated bug somewhere: either somebody is
> allowed to set a pre-content match on a special device.
> 
> That should be disabled by the whole
> 
>         /*
>          * If there are permission event watchers but no pre-content event
>          * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
>          */
> 
> thing in file_set_fsnotify_mode() which only allows regular files and
> directories to be notified on.
> 
> Or, alternatively, that check for huge-fault disabling is just
> checking the wrong bits.
> 
> Or - quite possibly - I am missing something obvious?

Is it possible that we have some paths got overlooked in setting up the
fsnotify bits in f_mode? Meanwhile since the default is "no bit set" on
those bits, I think it means FMODE_FSNOTIFY_HSM() can always return true on
those if overlooked..

One thing to mention is, /dev/vfio/* are chardevs, however the PCI bars are
not mmap()ed from these fds - whatever under /dev/vfio/* represents IOMMU
groups rather than the device fd itself.

The app normally needs to first open the IOMMU group fd under /dev/vfio/*,
then using VFIO ioctl(VFIO_GROUP_GET_DEVICE_FD) to get the device fd, which
will be the mmap() target, instead of the ones under /dev.

I checked, those device fds were allocated from vfio_device_open_file()
within the ioctl, which internally uses anon_inode_getfile().  I don't see
anywhere in that path that will set the fanotify bits..

Further, I'm not sure whether some callers of alloc_file() can also suffer
from similar issue, because at least memfd_create() syscall also uses the
API, which (hopefully?) would used to allow THPs for shmem backed memfds on
aligned mmap()s, but not sure whether it'll also wrongly trigger the
FALLBACK path similarly in create_huge_pmd() just like vfio's VMAs.  I
didn't verify it though, nor did I yet check more users.

So I wonder whether we should setup the fanotify bits in at least
alloc_file() too (to FMODE_NONOTIFY?).

I'm totally not familiar with fanotify, and it's a bit late to try verify
anything (I cannot quickly find my previous huge pfnmap setup, so setup
those will also take time..). but maybe above can provide some clues for
others..

Thanks,

-- 
Peter Xu



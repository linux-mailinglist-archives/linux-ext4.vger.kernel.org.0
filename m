Return-Path: <linux-ext4+bounces-6289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193C8A24C59
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 01:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EE73A5BCC
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Feb 2025 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2412E4A;
	Sun,  2 Feb 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QBZy3e/1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0ADDBC
	for <linux-ext4@vger.kernel.org>; Sun,  2 Feb 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738457930; cv=none; b=kzWmdqPUhva2na5iDxgKTl4EjZKtnGKkoJ25BHT41PpAXknz/eZeXJ5sQIGZf0xxytKUAyAOzN1qyEr4JclWCOlA96GpIFkIGVuZyl/a0Xnsi0kHY2Adu+6VDpn+lboqPGN1phL8Vd8O4wMOsU5pq+4DhU8kljIsZW2ipMbZeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738457930; c=relaxed/simple;
	bh=wTdxQSHNowLLmMobvaMcMprIsVZ+/hyqVnL+ii8pks8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV8+tvcADnLduyi7LVpMbpavh+2oxQHnl2dJ6IQ3tcQjDLZwcPYJbA81hWlpu49vZiUps/9vtuK/Emx7T0xBq/ssPRp1c3tSSMApwUFh2gWUGycloxHRjHVTbAZuVFOnSlHP/W+wzgdQ3FaqYa09rlWWdwRRaFr/3h3UjFS8OJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QBZy3e/1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec61d0f65so479592066b.1
        for <linux-ext4@vger.kernel.org>; Sat, 01 Feb 2025 16:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738457926; x=1739062726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0i2RBA9AG5RGJ2Y4fhUq4YhT8DGp5O3OFexnsh+308w=;
        b=QBZy3e/1EQGv5gUEtm/pZbPIW/2mikZ8l+LLIY0ItIoA7a0KjshBh2MARq+JNeKymu
         /TJHSywKjXlvfb9OJFn+ozVatQ8cWDcFqUGQBfi90TEkHw8ZxEi1oDew+CVTok60rXef
         vDtQXPRsKRjfXY2CEs2K3wDTofostoLfkdbcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738457926; x=1739062726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i2RBA9AG5RGJ2Y4fhUq4YhT8DGp5O3OFexnsh+308w=;
        b=QkruCXvjMNRRajXJzhYmLTwN6Lqe8jFoUREcw5OmhPCaWeCe0xP3htidSlpkRaXkdu
         y4kjLR+hdUcn4CXIhjPq+cqHTYbsmPOcDgAWqk+4vX9YmTHhle5la+4irAhGeg/zSh7x
         /DpJohD+4n94sVm4aOwspVjhaIBtJ4E/x6xarWSxM3scVSBBf17eGvkbHvniSg5iG2Bk
         7OhoQwPWwvOvS/ZG09MOZ7CxMso+A4fONk+Aj0vCZN8RgcrE7uFUs9XwAL/ZNl97ZHqg
         HLb97JTa9XIJNCCv+FS8LMF7OM+2l7GdDezvi8DWM2d3zIo+NyuVZU3POnntnsHYh66p
         ByAw==
X-Forwarded-Encrypted: i=1; AJvYcCWilzVwlGklQ2kbulA8Iuz87GIewar7cVen+8xpsMIGeH2CC1O30tWexIdZJMfZxfQjK8d3OQFp7ygs@vger.kernel.org
X-Gm-Message-State: AOJu0YxGY/9SgPbMaBzz9eW3SIuZMs856PEoYnrYmMvLls8puLJzHVAy
	fgAbI7IontkHVydX6hUQcjxc9U/pflxyXklh24w/vnD4yyJSCkqBWPHtT2oxfZW6g5B6L+ukkt5
	kmYq3Ug==
X-Gm-Gg: ASbGncv9zmxzCyVb/U+7x4i8j33OorNQMxToe/HmGeU3ZqJ1LE2cFfGQAPQXRnBWqh3
	/yqWpB7Fa+IiI649PMHlTK1fUMIzoVoxAzgK1HoJ1u2GmLga9kQWOPm76XpqLJgwjd0AaTBnqLZ
	eFLmFC5AzorbjZJt2b0whL771G2uzAB5x1BYp1jhWePcqgaZwCiXw0gKqGEXpVM4s8A4IcF5ovG
	0H/Gf2N/edEu7gcCm+88eQ9Y50OlvbHqKL7xdu57vqeZS9QlQBHMykRqKWYYVuGoa3IyV3Abtno
	YA1aLK/vBzG9VRxPzd0mLo7+so5eXO2n1+3m3K4vKOWF83TrbyEa7kvQE0zmysgHSQ==
X-Google-Smtp-Source: AGHT+IHt2cWj1lbOdS5aNYVtYfgIROwAUVqdXVsS8uG9CTwcOf7cgGmGetJrgf+Xb3ckwsAzUGbxlQ==
X-Received: by 2002:a17:907:7d91:b0:aaf:f32:cce8 with SMTP id a640c23a62f3a-ab6cfd104ecmr1646429366b.30.1738457926132;
        Sat, 01 Feb 2025 16:58:46 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf29fsm502226266b.38.2025.02.01.16.58.43
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 16:58:44 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so6631834a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 01 Feb 2025 16:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnqJ6a8Ad8rPrBMmtrLA25Fg6dSuTbPfoLGQ+9FGgBwkPyqF1BdzHYLQaYSdpDnUChn1Vhq3cpbAiZ@vger.kernel.org
X-Received: by 2002:a05:6402:50ca:b0:5d9:a55:42ef with SMTP id
 4fb4d7f45d1cf-5dc5efc4586mr20023222a12.17.1738457922880; Sat, 01 Feb 2025
 16:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com> <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local> <20250201-legehennen-klopfen-2ab140dc0422@brauner>
In-Reply-To: <20250201-legehennen-klopfen-2ab140dc0422@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 16:58:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
X-Gm-Features: AWEUYZkrc1rbpsukghJrnBMXjfiiupnnm33djYsyEN114ENNjNC4tG_tthCj53k
Message-ID: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Christian Brauner <brauner@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org> wrote:
>
> Ok, but those "device fds" aren't really device fds in the sense that
> they are character fds. They are regular files afaict from:
>
> vfio_device_open_file(struct vfio_device *device)
>
> (Well, it's actually worse as anon_inode_getfile() files don't have any
> mode at all but that's beside the point.)?
>
> In any case, I think you're right that such files would (accidently?)
> qualify for content watches afaict. So at least that should probably get
> FMODE_NONOTIFY.

Hmm. Can we just make all anon_inodes do that? I don't think you can
sanely have pre-content watches on anon-inodes, since you can't really
have access to them to _set_ the content watch from outside anyway..

In fact, maybe do it in alloc_file_pseudo()?

Amir / Josef?

              Linus


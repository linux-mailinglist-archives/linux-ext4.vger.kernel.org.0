Return-Path: <linux-ext4+bounces-2645-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F58CEDC9
	for <lists+linux-ext4@lfdr.de>; Sat, 25 May 2024 06:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A5A2820D2
	for <lists+linux-ext4@lfdr.de>; Sat, 25 May 2024 04:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED5522E;
	Sat, 25 May 2024 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="B1R3j0Pt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF210F1
	for <linux-ext4@vger.kernel.org>; Sat, 25 May 2024 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716610300; cv=none; b=s1Ugya8V/BrKKrg6NH0xL1ahusLtscQBuzprLEX3YUb5o8SONacyaeFL9bZrKWaOcB2CbeQmo0Ve7Zp7b1Zj7M+xxjt0dRXwct4szacNS/i0LhGTeAWd0bv59y7H7NzBnbU11ldE9hPxZpzRYlLE27RflAAgGH2hxnbd/JfXkEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716610300; c=relaxed/simple;
	bh=i/8bPKTHQepSw/PtXN54/xFyaQLHX5/Ic1/k3GfFdm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2B0GKRjU5ma26RWmQDodMHNubgeExlQUQJJddRaBeo8/VWw3I86h9tGZ6qPv/rEkv0k+gOo2jzk3tI7BaDu48WjkV/Qbg7n5iOqJy/Wd/DS6nUMSUcUUUyWrdrWeCdVC0WFspgRZOXLVbMKJVi39GbQZKrnqPVgIyWsjERSZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=B1R3j0Pt; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-128-134.bstnma.fios.verizon.net [173.48.128.134])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44P4BJ0v016606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 00:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716610282; bh=3oV+IctIQAXy0pIwXkAp3Hfhz/d4vXvllmxaqFVFWew=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=B1R3j0PtzOdAxET9gbHYXeU9ZKKvZRFgyQ+kKi0uFXe+hYdqh8t9mrTQxHGrwV9Yn
	 +/ajaGSJ6RHA2njb+Tsj1AEWEQOq9rdiaIKh+fBm80yw5bSyo1GJ9Mn9S8Lu/5aYkD
	 PUiFOFWSYLvdZagZ13sYsE1YPnjSsdX5m5AE+1pdC5xdzYbXAFOSGAxZwnWbRRiwLI
	 u3vzEKuVYqClO0WXTBsWMv0iYhk+18WVdFo50ZSB9CmghkWuzJ+LBZxspV5fY/KLvg
	 K1f5JUK6+aL5FE9fBFbTUQHZQzP+EVqaewUYqrCg850xZqgcXM3OadYBUAO5j0bVV8
	 bkLi622X0YNXw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3E21B15C0225; Sat, 25 May 2024 00:11:19 -0400 (EDT)
Date: Sat, 25 May 2024 00:11:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kees Cook <keescook@chromium.org>
Cc: syzbot <syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in __fortify_report
Message-ID: <20240525041119.GA981794@mit.edu>
References: <00000000000019f4c00619192c05@google.com>
 <20240523130456.GH65648@mit.edu>
 <202405231540.84B3DBE841@keescook>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405231540.84B3DBE841@keescook>

On Thu, May 23, 2024 at 03:48:01PM -0700, Kees Cook wrote:
> It looks like this is another case of a non-terminated string being made
> terminated by strncpy into a string with 1 extra byte at the end:
> 
>         char label[EXT4_LABEL_MAX + 1];
> 	...
> -       memset(label, 0, sizeof(label));
>         lock_buffer(sbi->s_sbh);
> -       strncpy(label, sbi->s_es->s_volume_name, EXT4_LABEL_MAX);
> +       strscpy_pad(label, sbi->s_es->s_volume_name);
>         unlock_buffer(sbi->s_sbh);
> 
> This should be using memtostr_pad() as:
> 
> 	memtostr_pad(label, sbi->s_es->s_volume_name);
> 

Ah... I see what is going on.  The two argument variants of
memtostr_pad() and strscpy_pad() are confusing and dangerous.  These
don't exist in the original OpenBSD strscpy() function, because the
size in the third argument is explicit, while with strscpy_pad(), the
automagic size is intuited from the first argument (the destination),
while with memtostr_pad(), the size is automagically intuited from the
second argument (the source).

This confused me, and I couldn't figure out the bug even when I was
given the stack trace from syzkaller.  So it's an accident waiting to
happen, I clearly I was not smart enough not to fall into the trap,

So perhaps it might be nice if the descriptions of strscpy() is moved
out of process/deprecated.rst (and BTW, memstrtopad isn't mentioned at
all), and moved inta separate doumentation which safe string handling
in C --- so instead of talking about what functions *shouldn't* used,
such as strncpy(), it talks about how the various functions *should*
be used instead.  

I'll also note that figuring out what was going on from looking at
include/linu/string.h was confusing, because there is so much #define
magic to provide the magic multiple argument handling.  Personally, I
was never a fan of C++'s function overloading where different function
signatures could result in different implementations being called, and
doing with C preprocessor magic makes it even worse.  To be fair,
there is the kernel-doc inline documentation, but my eyes were drawn
to the C++ implementation, and the kernel-doc documentation is more of
a reference and not a tutorial style "this is how you should do
things".

Anyway, thanks for sending the patch.  I spent a good 30 minutes
trying to figure out the bug, and was half-tempted to just revert the
patch and go back to strncpy(), which at least I could obviously see
was correct, unlike the strscpy_pad() transmogrification.

> It looks like __nonstring markings from commit 072ebb3bffe6 ("ext4:
> add nonstring annotations to ext4.h") were incomplete.

Yes, I'll patch ext4.h to add a __nonstring annotation to
s_volume_name.  As I recall, the reason why we had added the
__nonstring markings was to shut up gcc's -Wstringpop-truncation
warnings, and apparently it was needed for s_volume_name, which is why
it was never annotated.

Out of curiosity, though, would this have caused some analysis tool to
trigger a warning when the strscpy_pad() commit was added?  I've
tried, and it doesn't seem to have triggered any kind of warning with
either gcc, clang, or sparse.

Anyway, since I'm an old fart, it was pretty obvious to *me* that the
how strcnpy() was used was obviouly correct, whereas I actually have
to do more careful thinking and analysis with strscpy() and
memtostr().  So it would be nice if there were some automated tools
that warn if those new functions aren't used correctly, because this
bug shows that these functions are definitely not fool proof --- both
by the original patch submitter, and the fool who reviewed the patch
and missed the problem.  :-)

     	     	       		 	     - Ted


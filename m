Return-Path: <linux-ext4+bounces-6042-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3650A0A0C2
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jan 2025 05:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E129B16AA02
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jan 2025 04:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8C1531E8;
	Sat, 11 Jan 2025 04:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwZxQLlT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745EB22EE5;
	Sat, 11 Jan 2025 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736569002; cv=none; b=l8bOyLl4kc2t6ykTl6+ef9AxiiSvZHaOhcL4nXS4GbG27bDgju+JojRxG2Q7VVDFOUkQHNy+wRfBMXnZdg4oZnH4ImLNrIRse+2GfUdf3wUrA5gesi5LvDXnjhHzV9+2DVJZmyJ98txcWTQ2jYiIBpB00Cgbvy44CH+4/XZjw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736569002; c=relaxed/simple;
	bh=BHNNIZQ5L4Vv1+vrDng5egYwSwYCsCpZ2+3xiN6g4BA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fO8AVlVDPY1w8ET+plrUTai0N92M6ZLVYSEBHvuFkOpET09zs2ngZzQCj2XqgEtS6ThkQDCrMI61IaeXk40i6o/ks+uhAOiVP3c/nkPnrxX99E3a1rtR4CjqgO3+JFnfzoFUcsVBfLHZDCuzIn0U7jnfuADpoFc32Tfl8Bvj5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwZxQLlT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so4755147a91.0;
        Fri, 10 Jan 2025 20:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736569001; x=1737173801; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A4q1wvB8u8SwD6Xo7EmCP7JRXocAy50q2Vrxi7iOM+0=;
        b=GwZxQLlTB3lRKg+CtUWdOkwPQRuunNhlJJh9iXpiHah75xCJJE5glszQyvA6BOfDvF
         2aRlsZADXLktGTmKxaBbM7alPzy4Fu+V2myD0KIkJsQ1i2cTQU1YuVcfx90UKlvCh2UQ
         D1PRVc9SuP5Oygq9schTOG7Gpc4RafrCkskt5LZKwnjggM3dAYh7qs4Z45cB1juV9T1c
         zn2f4x+98ckuqriPNCrBm21kHiXd3iTrEZltkCw4IRYj/Gn048sgL2STsVyZwpb8qQnP
         Vj4FS6a5imKaqEvGv94LH35Sg0GtEvYSnZ7xhrUyPvVQETALVlgSiSm9Q8fsE9NJ9+bj
         BztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736569001; x=1737173801;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4q1wvB8u8SwD6Xo7EmCP7JRXocAy50q2Vrxi7iOM+0=;
        b=VNuFyRF8kZrFbOUl2QWanHRUqS6Apk4s6SEmgj6qWs9SBofy+vjWmzxCvBzqcu/lab
         CsBJdh/w8XQkbD5B9NwsfTHAbkYCAwoLsFwk4A7PF/dEzoZZp28ZqyjHUoNSTgs/QBaX
         WTjC+VGOVp/kom3ZXuWykyNWs8fCZUWHfnzxewFF5CiWBCFdcYidD0C0vhArVznhzMad
         maMTjSOQRaxIsIjkx86uYmzdTt/z+qAdDyhkoRj3MmUfAYnttggc8ya0Y8lzVrAIyQCs
         cAX7QZODXaHGs2nk1+bAo/zc4NvHPNDXh/6tXUk/8comM4BbKde/cLSRqdxw64Me7Kx8
         oJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvxXRDiR0wmL5LjBWQayQyTvtYhvbtXDXPr/GPKkjkcOEge77wmu6KjvCeyGXxgni1RrmjlZcvFjy1@vger.kernel.org, AJvYcCW6CznmojwIsVaJ9acmW/VJwF9Uyl6qFCrnKFjAL/E5bO86oXEgejio8/HfyZ575+/Bbt4NMOr/cFPg@vger.kernel.org
X-Gm-Message-State: AOJu0YwY38nidHot7LXHtwavKEBkFn0v1ojk1Q/ve1FDJJspn9lI7vg2
	00NTFRW7QyA7yyZHxnSn8f67z473IBe8Rw7ccPh6wc60Fk9VhKKx
X-Gm-Gg: ASbGnctqTl7aUrvd3w86MtcFq8ntZg5khKZuaiwCUOoso7cZlvK+pVbdKGStWnOhAY/
	L4lmddxtLKsUBJDoIXznrZo8iJxV4wyXlcMgpUVtKNDG6C82NN9A0rZhzfduQgTuEhXRM9ZDdkP
	Ugluls3d/ayWe2LFLolykEOLPevHgtlDaJnjnH+zey9+t6JTIbKLUCs+b9JMj0eW5/EZsoiLDdQ
	F+5gAKfsO4Sg1ND4zsWl6Uekph+AwMwe88aRrykU0cWtsI0Ag==
X-Google-Smtp-Source: AGHT+IHM3eajYqslCfMgFvvOXBJldfn+edOVj6ttt/CMyruxpOLAAgJ+6w3oiOLTIquoYDGZ6XSIfQ==
X-Received: by 2002:a17:90b:38ca:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-2f548f2cf26mr20086801a91.10.1736569000744;
        Fri, 10 Jan 2025 20:16:40 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad36asm6269494a91.30.2025.01.10.20.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 20:16:39 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [RFC 2/5] check: Add -q <n> option to support unconditional looping.
In-Reply-To: <20250110160845.GA1514771@mit.edu>
Date: Sat, 11 Jan 2025 09:05:46 +0530
Message-ID: <87sepquinh.fsf@gmail.com>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com> <1826e6084fd71e3e9755b1d2750876eb5f0e1161.1736496620.git.nirjhar.roy.lists@gmail.com> <20250110160845.GA1514771@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, Jan 10, 2025 at 09:10:26AM +0000, Nirjhar Roy (IBM) wrote:
>> This patch adds -q <n> option through which one can run a given test <n>
>> times unconditionally. It also prints pass/fail metrics at the end.
>> 
>> The advantage of this over -L <n> and -i/-I <n> is that:
>>     a. -L <n> will not re-run a flakey test if the test passes for the first time.
>>     b. -I/-i <n> sets up devices during each iteration and hence slower.
>> Note -q <n> will override -L <n>.
>
> This is great!  It's something that I've wanted for a while, since at
> the moment I implement {gce,kvm}-xfstests -C 10 is to run check ten
> times, and doing something which does the looping inside check instead
> of outside will be much more efficient.

Yup "-q 10" could be used which can give pass/fail metrics of how many
times the test passed v/s failed by doing unconditional looping within
xfstest's check script itself. 

>
> One other thing that has been on my todo list to update, but which
> perhaps you might be willing to do while you are doing work in this
> area (nudge, nudge :-), is an optional mode which interates but which
> stops once a test fails.  This is essentially the reverse of -L, and
> the reason why it's useful is when trying to bisect a flakey test,
> which sometimes might only be failing 2-5% of the time, require
> running a test 30-50 times.  But the moment the test fails, we don't
> need to run the test any more, so this would speed up bisection tests
> which today I do via:
>
>    gce-xfstests ltm --repo linux.git --bisect-good v6.12 --bisect-bad \
> 	v6.13-rc1 -C 50 -c ext4/inline_data generic/273

There is -I which stops iterating on encountering a failure.
Does that work for this usecase?

>
> Because of this, I wonder if we should have one option to specify the
> number of interations, and then a different option which specifies the
> iteration mode, which might be "unconditional", "until first failure",
> "only if the test initially fails", etc, instead of separate options
> for -q, -L, etc.

I like the idea of iteration mode here. I will let others determine on
how easy it is to kill any option in xfstests today and replace it with
other. However here is a summary of different iteration and looping
options.

We have 3 options in xfstests today:
1. -i <n>              iterate the test list <n> times
2. -I <n>              iterate the test list <n> times, but stops iterating further in case of any test failure
3. -L <n>              loop tests <n> times following a failure, measuring aggregate pass/fail metrics

So we have -i/-I which are iterations and -q/-L which are loops. 
Looping happens when we can just loop over a particular test <n> times
and give pass/fail metrics.
Whereas in case of iterations it goes over from the beginning which will
also source different rc/config files and prepares the device etc. (hence
it's a bit slow too)

Using -q will be faster over using -i or -I similar to how -L is faster. However -L
will only re-run when there is a failure the 1st time.

-q v/s -l: Can we kill current -l option if it is not in use by anyone?
I would prefer -l since it looks a short form for looping. I don't see
we using -l anymore. But I will let others comment. 
    -l                  line mode diff


-ritesh


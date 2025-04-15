Return-Path: <linux-ext4+bounces-7256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4DA8952D
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4606C17E3D5
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Apr 2025 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD451DC185;
	Tue, 15 Apr 2025 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhFtvdQk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F22417C8;
	Tue, 15 Apr 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702380; cv=none; b=qI+JmfFE3adXw3lh/v35ZSdZs1kYUyXqul5M6kuWFf251CQ/ZNF36Yn91XmZpaO504x2ydJ0Y1ymAQvXnJXKYoubtkata/cr1HPWOEojIKu3hanyUIbnqi8z0gRj5RL3luy1ju8UwAZ8L7q3DH56FPh8rRv7hznyyv6zsQeeamc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702380; c=relaxed/simple;
	bh=dRa7U50k7zlGiFNhGjsL8BiwV/iToruZ/EK4vr7CDcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nle7206zEk49H9fK7ebp/J4s97Vf1meKQsJjLF8am7Hm+Mi7PwAcGk3hsbzbu5QjLIhJy40qSCdAnS8YJRvH2pAH+n8Jh8uvvfRZmBy6mFAt1SNK1a4WRfOxDm6GG8diCQUi3VPvqxpaFacuV0DrO4vaV+MoyHqVeB1GXThdyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhFtvdQk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301302a328bso5095860a91.2;
        Tue, 15 Apr 2025 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744702379; x=1745307179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI6WVR10Hp7er7JtN8anSpyRNsNLQ+CYvMTaV0pTxcY=;
        b=NhFtvdQksSzcq04PpPqID9clBSLUnXs1v9vSdCaruH9Sm5o1mTiZOFgOsuuAXjnJMb
         qEew1mbulpQ53uBSyek+QIfgsUgYofUFSFbtzm/IMHMI7i9zretEzP/TROcMqOJpt15c
         DHkUhq9w0ovcJMdRK9zTacOxxoHYJ6eFPiWuWHNtfComTWoCStIvIHVreO1E7qHIToSi
         fHRo8OBRBDlZyDSM8lphImLBu4Y4WJV0kYrpaxDqzqYg2IyHgvorgZTfqMS6JkjcYbBb
         G9iBwIObF1GvR/5NeHGkYs2kdLKio5S61zKGRaepy4kpjRPsLFNSIHnu/V8AyaNlvz0X
         RNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702379; x=1745307179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WI6WVR10Hp7er7JtN8anSpyRNsNLQ+CYvMTaV0pTxcY=;
        b=bFVawmIx9jaheyRTUm8t4b0wo/JvShb4h2eQXEZoJdv3VYdE74rjn/U+tedD3jp/E1
         WvprOzCJXnOkIqUlk6XqFaZwNnIBfk+o3egXpdH1PeqrxsmuMDiGZwXKuh+7mb/ctNqw
         vA5FYO61dmEQjORHYWcNgjm4nmFxEDtFazmJcdFOCXPu3a2JXkVBuWVzaYHKgDRA3s/4
         A90qXXFapfOgnhDPPhhqC9UGjmYJjuGUR6eX2jqSHbuzTWoEgZVE50cys625BCvny0i+
         Kp29QscClKLwmo17atFxTkPmPfkgS6/m5dP5qVjCPf2jmBKg0EaZu9vRqJonS1i9bT7e
         l4Og==
X-Forwarded-Encrypted: i=1; AJvYcCUruJt8zcQKx4MJM6U5JOyjDfKdEYzYe6wk3zcxiGWbhZy8Jq9QKNRB8e0W3NDqYQzVcgH9jcnW5nb6@vger.kernel.org, AJvYcCXmPglsj0Ma+ykCvaitTCHLLmv+8sLKZIOySsVH+lq4+3cmidvqu2e80l0wzn/gZXnVUjAxqLt4KXhU@vger.kernel.org
X-Gm-Message-State: AOJu0YxIP1Q/dT6JcFfhEYJQ6OfDN6jTZ7o+/aFYuXJOvFnT9gET1Bvp
	SpVki/B3YaOIvONu3V3Mv8OkCp+rEea7vyozVUOoKNtmbN9LRcnTwnGULA==
X-Gm-Gg: ASbGncuBhH0OpWTnnpNPKntI6ug+5M5aR27FmvO9bN5zkd+3Ce4TioKm+9kYO6q6gfP
	ZCGSeG/hTyksD7k0nPFEd9MVti69pqYiSJNBUL8uOjmSWNeGv7NUJ2FwIObLAUBfaJv4DRNcSfJ
	8EOS+AJIj84ZhEmto2RZ02Za2vAaM/493t7Wvx7yEOAcL0WCp0mpBHH+ssKN6wp6e6wuHIknvgz
	mtGoVIO14X81oWWUqdGB1hbAmQGYbTnululWS8HTk1jFcOXB/FnGvDOcZaUFBQaqYFkhAMquww6
	WbYgu2ZebRKlLfuIZjdvSKRzCgoEvoVbwG4rWweTM0CLQaZZ
X-Google-Smtp-Source: AGHT+IGITOXsdb6/to2gllPINuVI05qRfT0qiJ3rKWP2gX2cZW92Y05w/SZ/NdIA2iIb6eqK6T+7UQ==
X-Received: by 2002:a17:90b:254d:b0:2fa:137f:5c61 with SMTP id 98e67ed59e1d1-30823639ca2mr28839546a91.12.1744702378682;
        Tue, 15 Apr 2025 00:32:58 -0700 (PDT)
Received: from [192.168.1.13] ([60.243.3.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ce503dsm110402365ad.259.2025.04.15.00.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 00:32:58 -0700 (PDT)
Message-ID: <9619fb07-1d2c-4f23-8a62-3c73ca37bec3@gmail.com>
Date: Tue, 15 Apr 2025 13:02:49 +0530
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] check: Add -q <n> option to support unconditional
 looping.
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
 <762d80d522724f975df087c1e92cdd202fd18cae.1743670253.git.nirjhar.roy.lists@gmail.com>
 <20250413214858.GA3219283@mit.edu>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20250413214858.GA3219283@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/14/25 03:18, Theodore Ts'o wrote:
> On Thu, Apr 03, 2025 at 08:58:19AM +0000, Nirjhar Roy (IBM) wrote:
>> This patch adds -q <n> option through which one can run a given test <n>
>> times unconditionally. It also prints pass/fail metrics at the end.
>>
>> The advantage of this over -L <n> and -i/-I <n> is that:
>>      a. -L <n> will not re-run a flakey test if the test passes for the first time.
>>      b. -I/-i <n> sets up devices during each iteration and hence slower.
>> Note -q <n> will override -L <n>.
> I'm wondering if we need to keep the current behavior of -I/-i.  The
> primary difference between them and how your proposed -q works is that
> instead of iterating over the section, your proposed option iterates
> over each test.  So for example, if a section contains generic/001 and
> generic/002, iterating using -i 3 will do this:

Yes, the motivation to introduce -q was to:

1. Make the re-run faster and not re-format the device. -i re-formats 
the device and hence is slightly slower.

2. To unconditionally loop a test - useful for scenarios when a flaky 
test doesn't fail for the first time (something that -L) does.

So, are saying that re-formatting a disk on every run, something that -i 
does, doesn't have much value and can be removed?

>
> generic/001
> generic/002
> generic/001
> generic/002
> generic/001
> generic/002
>
> While generic -q 3 would do this instead:
>
> generic/001
> generic/001
> generic/001
> generic/002
> generic/002
> generic/002
>
>
> At least for all of the use cases that I can think of where I might
> use -i 3, -q 3 is strictly better.  So instead of adding more options
> which change how we might do iterations, could we perhaps just replace
> -i with your new -q?  And change -I so that it also works like -q,
> except if any test fails, that we stop?

So -I won't re-format the devices during the loop? is that what your 
suggestion is?

--NR

>
> 					- Ted

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore



Return-Path: <linux-ext4+bounces-7091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CEBA7EC44
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842597A281E
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01527221556;
	Mon,  7 Apr 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9SLRVsm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21821C9E0;
	Mon,  7 Apr 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052017; cv=none; b=iuglwpt4Ws3Hdmlfy8XnNXr4YTJVmWn7tVM1d79Ae/G6PYAb85U5obLW+lWZglW9kmyTQd4fWTGniZ/YvpChu+vS69kJcuMkMmEL42/HkzeZZkDtfJigAyGMi26hnzAqHwFqYr24qYVfamXk+eiPb7QhcL8j8RiFk3GUuWoUoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052017; c=relaxed/simple;
	bh=umagi24FKCMK/a/Okp120yrmkDjKN0OfMdyvW1Ehz4E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=tT0T1u2/9xaVIVNbt6lsvMhenT4T8HQepuX++0xW5tH16AaAgDdDB3qE49rA0eHJXVVLOw9htv0pGApgjdgsrTQuoC+3pIUalY+Q4663UgexCSzIH5eZlAShIPUUVfXbsVeR2vTj1bx3hLdh4cxf/j1EzWWZ7Whw/XF8vQSqQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9SLRVsm; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af93cd64ef3so3107565a12.2;
        Mon, 07 Apr 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744052015; x=1744656815; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNiKg1wKghdxIu47AfoQkBi8eiWjGsZuYc0UwrG48IE=;
        b=I9SLRVsmApqBSAamFiMezUEbCmSXCvd4Pr3ajLOUu1RTCZyrIXbPlLdlda8CCJ590M
         3FutwXwJUt+oquN0285sCqzrQ1U6MFyeHn1ZFro2z1p8XB2t7RRonBSUH7fGJdKBvivD
         zWFIszM1+R52ni9rCDqiLMHe1NlR5cqWesrod2q0BM4gA23kJUZNxHhSB1vDOHmpFxxG
         g6VeyR/nHpPYjKJoKcBqaLuiFaqCaqE4cVFDF2vg5dGIE0wzhXrZeqWVSafawpDA2W5X
         Jr5P4gfcRbn9u6nZRz0+X56ykRSfQ9WOw0+Jg2RHqbwVM4k+cmgGAhsQHRj6yJY5NzQv
         RvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052015; x=1744656815;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNiKg1wKghdxIu47AfoQkBi8eiWjGsZuYc0UwrG48IE=;
        b=dgEZAQyY6IRutu7/x8lvLL9zU1Xb+b3wJogK3WMLifW3cfzBMhtrFaQjE31jfjLCRv
         ENQg/2iYm+FkVTotQZsIAKDjxSLdduQR0W1ehMRStc56VIBA/Qgj8mYDashJvYD+5anY
         41L0g0soyFIp/ICDxBIY+zcUu1ow/KmP+xM0IxYSu0SeQVr/HqmtPHcTYrMRzJhUj4c4
         n4M8md0nmQeTeNGNNhW7bExA3Bj0+WSjJpkvth5+PrffhVAx+sIaZWYMmLrw6EuHhGZS
         KltzP8D9cGHh3u8AfCcUSKjxyXI1pH5hNqALd9/pBWN8uBkkb5OKOvdPW3DZIC+i/GU2
         8dHg==
X-Forwarded-Encrypted: i=1; AJvYcCVDGjZmDZNM9qo69E4sbA/gBFY0Ru8MySNwzuKs2aFQLkuzLPwro5Sx8h765BnUUp3+tN8bfB90@vger.kernel.org, AJvYcCVTx03qKMHSs/iYdhatBMiu0GZuZgtpKtQWd195T2PQi6GZMmMwqwbX3nc96hoh4XXiLxpKrbKKY65Q@vger.kernel.org, AJvYcCXJMO0dhQ3CRFb7lc8xYpB7tA5wiJ7Oh3a7cg7CUaorG8C0VK6BKJCO5xe/NcGHe/RraVQAQfFNipc9Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD5wHjiAxSC4gYzE3rIsclpGN6gBxzen3xtpX614Ve9w9zeP9r
	lGbcA23OnJs0ddOPh2TMe7z6W0eo2LoQHW5dJ4K0UZ8l73yXmUcq
X-Gm-Gg: ASbGnctIVvIS0uDRc4QRoVJgmCZKx0tXrpLKx9BQwS8vWxH2Suag5wZT+xf1L/9Syd1
	/GiiWXdzx9IF0ED6rs3TJPXHS5n/cPR3AZCwy4VrBBAnmWgmsk5av4Lfeuti4PN6PWU4h0MN0vI
	CLhg6nKEKfSgccivq/FsnniF36Bem3kGyE1zhGgj1SZ6DME2oe2rRyYgiEThPLBzYKxrtXmkZir
	M/ockFJSANQvoA+iSzQ06unZGquAuULn3qLZG2fq8PvTdB7ugnF384xiGD07v04iZ71j6FQpoln
	sQsAWbUykTHG17MEqcO7k13RyHB5lzXXFx4=
X-Google-Smtp-Source: AGHT+IEGUA3F//yfOUyAv7X2bByM5R5xYZQ8l94roj2vbVoQUabKxuuUQKsbacshguK8Di3CGtkmoQ==
X-Received: by 2002:a17:90b:274b:b0:2fa:15ab:4df5 with SMTP id 98e67ed59e1d1-306a4b86e6emr17666167a91.34.1744052015299;
        Mon, 07 Apr 2025 11:53:35 -0700 (PDT)
Received: from dw-tp ([171.76.81.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a2f626sm9250636a91.21.2025.04.07.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:53:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 5/5] common: exit --> _exit
In-Reply-To: <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Tue, 08 Apr 2025 00:16:42 +0530
Message-ID: <877c3vzu5p.fsf@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com> <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com> <87mscwv7o0.fsf@gmail.com> <20250407161914.mfnqef2vqghgy3c2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Zorro Lang <zlang@redhat.com> writes:

> On Fri, Apr 04, 2025 at 10:34:47AM +0530, Ritesh Harjani wrote:
>> "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
>> 
>> > Replace exit <return-val> with _exit <return-val> which
>> > is introduced in the previous patch.
>> >
>> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
<...>
>> > ---
>> > @@ -225,7 +225,7 @@ _filter_bmap()
>> >  die_now()
>> >  {
>> >  	status=1
>> > -	exit
>> > +	_exit
>> 
>> Why not remove status=1 too and just do _exit 1 here too?
>> Like how we have done at other places?
>
> Yeah, nice catch! As the defination of _exit:
>
>   _exit()
>   {
>        status="$1"
>        exit "$status"
>   }
>
> The
>   "
>   status=1
>   exit
>   "
> should be equal to:
>   "
>   _exit 1
>   "
>
> And "_exit" looks not make sense, due to it gives null to status.
>
> Same problem likes below:
>
>
> @@ -3776,7 +3773,7 @@ _get_os_name()
>                 echo 'linux'
>         else
>                 echo Unknown operating system: `uname`
> -               exit
> +               _exit
>
>
> The "_exit" without argument looks not make sense.
>

That's right. _exit called with no argument could make status as null.
To prevent such misuse in future, should we add a warning/echo message
if the no. of arguments passed to _exit() is not 1? 

-ritesh


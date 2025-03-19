Return-Path: <linux-ext4+bounces-6922-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4DEA694FC
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767373B7740
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Mar 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438361DEFD7;
	Wed, 19 Mar 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKefHaP+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF8F9DA
	for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401758; cv=none; b=M2oSPWOjVSN3nrYu8uldOtfDz9F4yQNI5VMyPOxWBGZmHjKjlCdJhomx0xxQOanKtn0q0MTHNYGWbauRMffuuyo0RYoMCupje1DBGRSr8XFvG0eVXXXwgRobsHtyW8WGHo7P24RbFlG40Xwnal1HIi01nzg8H6M7QQkvEH18ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401758; c=relaxed/simple;
	bh=hwUDnf/Z/3f61N2tG09n8L0bGp7x2JELk0wlJT1OAtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB61MM/ORJM8fFNw1GL3+VKnRVMpwQVgSpISSKt4XNC0BLC7nDHyPhrRWC2FksyuAnGPI3ubjHQ1ZzAjrHZfO1jAuiJs5qzI7NOx95zKUWBgTwFcEvSitEfpqfqQhgVmnOyZZmNBIud97bk0Pqz0xWPuzQaoUihRnrMx+Dcf6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKefHaP+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so10064881a12.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742401754; x=1743006554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCb3qM2QC7Y5TFlfRSzGurVBp3rhLPVzNLTamog5b44=;
        b=VKefHaP+2fmM+QesfjajmSmJ+QOVp+GWPPjyiy9Ju7z6+WqcJyG1pKQBHNmA8VKMGP
         H2guCTblyOpAHgWqhowvvRk4BFgQvfvVOKtNK0KbIsdcytPazCcY1TllWMdfnmdNMDUJ
         cdxp1sLV7KV+s8zX8odJR6NiG/T86ZeYug5EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401754; x=1743006554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCb3qM2QC7Y5TFlfRSzGurVBp3rhLPVzNLTamog5b44=;
        b=vcEiP8WaKaZDASEvrLX/yUEqyentRaKL4D92PUES/eCTbbuVGfcL+lEd4Z1LgKiwN7
         q0GC7USARamFkymRE3Iwb7fG3XAspv+2NsmG9qE8peMpwv/dGtH+3vKDdEzIEYe39dPY
         qxzrwn18hElIcuOeCNoXE2Z+P/XTJO+t0SJc5jrF+tINZDpFKKbQVg0sDqZYs/ofNSv4
         g+t/fc8FWwm2oHyUquU5RbTSSpwhi8uNzZPRAe/XjL+OInLR1ivejJBRz8W7wTxcFdtO
         jtm/NZprG0wuNwcTGJfXS92EJ9UnO29akIGkgvrUNbb0C21TZY8Q3evC5thu7v13hwIr
         UJZA==
X-Forwarded-Encrypted: i=1; AJvYcCXzP1wEns5cJ6Yft6N7zl45KBrIvndu9Lorw8Q9NJ7NM2OeLSgL8364zHrNXtnTIcwvATjkAvgRHGDr@vger.kernel.org
X-Gm-Message-State: AOJu0YwmG/zFlZ0db4Y6r89f4PHDH1bOfQi7VsPW8gZDVo9Nxj6S4/DT
	sJueKL7teex104OKlPz5rmLrivfp2nfMhtWF4vXEcIVY2JAfDg3OFXUNhAKyazydqgc51RPR7wV
	+Xag=
X-Gm-Gg: ASbGncvznQ9yJN7gf7l4/sNfs62/k/pr5aFfQmt2uTS59t+zmMQrmQXz9Q9NHRn2bZB
	WkamG/XKrV0xt1jzhsfJu1PmRTTWVd96Notvw0KPUuVThwfiOkQtLJyfcg0GGAoPdytvSTcgFPk
	W4qCga6vZnhoIXrKNmVkb4zrEg1CP591ZNMkIXdeuy3oyAZAb8RqlAsjnrG85LcXC5Fkz1B3TOM
	3O9X8XBG/vYJw3WD1hcGFMIVIHNfVhbG+zuBvbkWdmVyKqcKm+vG7l7ZmxVCpVPFu5nZA+zF0I+
	bvE1initkLer5Te/bSS2lHZm5RJyidR7OqMPTpKls4j90kgCBEUzJ/AatLxAmtUV3WfbSM8r6Zi
	+fS5Ku1sPM35iEYW4Qg==
X-Google-Smtp-Source: AGHT+IFTGZXCWZk2yomXLrgmCIonaa8jk05hWo312Cf1ZBf3r2pzVYFkG+LjyEK2iF7bG6U7xW/4rQ==
X-Received: by 2002:a05:6402:51d3:b0:5e7:b081:8b2f with SMTP id 4fb4d7f45d1cf-5eb80cf9f99mr2582492a12.8.1742401753986;
        Wed, 19 Mar 2025 09:29:13 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816977a5fsm9202513a12.32.2025.03.19.09.29.12
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:29:12 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so11280145a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 19 Mar 2025 09:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgQ/nC9KZ2VoF4sdB+dg/cAQbfueYhCCH8KqUjzmOxTEx68ivbLQqBYkviG7se9XdTl4Rt/oyAkeA2@vger.kernel.org
X-Received: by 2002:a17:907:c24:b0:ac2:cf0b:b806 with SMTP id
 a640c23a62f3a-ac3b7fb18e5mr330787066b.56.1742401752310; Wed, 19 Mar 2025
 09:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319110134.10071-1-acsjakub@amazon.com> <20250319130543.GA1061595@mit.edu>
In-Reply-To: <20250319130543.GA1061595@mit.edu>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 19 Mar 2025 09:28:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
X-Gm-Features: AQ5f1JqX8KCi7u4eca5D9cFcz1zkfHc1WSecvRjtvtJbH05h1e_J7ig4pUcqtGo
Message-ID: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix OOB read when checking dotdot dir
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jakub Acs <acsjakub@amazon.com>, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 06:06, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I'd change the check to:
>
>         else if (unlikely(next_offset == size && de->name_len == 1 &&
>                           strcmp(".", de->name) == 0))
>
> which is a bit more optimized.

Why would you use 'strcmp()' when you just checked that the length is one?

IOW, if you are talking about "a bit more optimized", please just check

        de->name[0] == '.'

after you've checked that the length is 1.

No?

             Linus


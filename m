Return-Path: <linux-ext4+bounces-1863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031A898BBB
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB911F22191
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF912AAE1;
	Thu,  4 Apr 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZFddwlR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428E17BA8;
	Thu,  4 Apr 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246608; cv=none; b=fYS1hA607QS6bTYSuZn1q+/pDd4MB/R0sgarKwWi1whz5Vf+/OOBpFxPIK9EMCWro+jU8+07OLWZwXZavfeh8RDZNCZSjhnoJTqMx+NvbTBKenkh4BK0q2wYnxe3S2t2NKmlzmNB8tYwu+IVZovzSfWaMXMeJIInLidaN4bpc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246608; c=relaxed/simple;
	bh=3laSCnY9+DHBNm5Yb0RHMgrrQMU1Q8kYq9NMeNSgcUY=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=a2eR1njn4b2xQL5PvxNLGqfr4pgfCgGIQcRvq8XYEcCukZvgEKQHSNwtkXzT0HdGo1NyO+cere4e4/xtGSKHH0Idh4/hU7UFCbP/3s70+/v+nuvqjyjI5FSCBLGf5rwHiFbNpgiJgWmqk1K60uEL6GShthbXSr/VkXpZVYSnuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZFddwlR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2b137d666so6246915ad.2;
        Thu, 04 Apr 2024 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712246606; x=1712851406; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cy0MHR54JGNOFy9o8DAySgEG/x1fzuUUOcz6G/+T/+s=;
        b=VZFddwlRdAgzetcEnHreInivpE+VTNV068HzOcDUjm72PAAA2tgtjsTXLQH1QZkQj6
         7HAps1aqM69WBn9fYNyyBQWE4z55750gMhI5/XoIv1KS0dYLF2L4kjElYV+0euejks4g
         YOLeLVSOTzDAPk+FlE3etbV7A/3UAP23VcWoiXVyudS/2K8/E4fLWOS7LF5Vloy+ks1a
         3GMVOklyivNp4nt9PymcZtsnfHcZGtViOx5zrQCzboW/MaIOWF7Zd6jvPu6Dj7MoFgzb
         kUhDr+O2POSZOi8PIfMj1Cer8+l5my5NpVF1bzjQM9dNgVHLFMTzfJ9e2/1pH5PI+4tn
         PDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246606; x=1712851406;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cy0MHR54JGNOFy9o8DAySgEG/x1fzuUUOcz6G/+T/+s=;
        b=semuGKcjLj7FV2L6X8c6CJhPWWay2jOv+xD4KhrwmKO2+b4ZsevKuAtfDjKXXRhLJe
         YqtzBDvQ0SVdB3ywXAP3abLBlAQ8GUdu2vPzZXPCBUGEejGx1q1Pu2l87qdrphy2Xl+D
         TXyqNqfnSiU8x1jsewQdSxvJy2U+Pb3N8jLNiSKtyAA8Clhtbpj4MtDBdWa9XMduSy/p
         jSDmQox320G3Yd6u5JnpferwFBesKKf0TK55b7olWpCvyb04lbZIxgj/IIU80q/Ie6VN
         1zfigzSmAkL9/a3CZ9wOmHbaYs9xgZPRAH+GyHqdJ4xa2r8n36OLzbSL7ogyo3jfafkC
         lRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHokn3snaM2iqzLU4CoWp1+fbt9wXyvjE7kdi2opXBh3y6QM/sO9+mNreBXm2oHs6+KTxRFsEwMv7ftpB99AO0zGtkOskEM/r2N7slidUY4B58qR8UTCxaQvinGfBoQ7ZL//pYaGPDSg==
X-Gm-Message-State: AOJu0YwiPSXe3mfxkmScp8WZWSDP0HxJhbYE6kA3gDWuoAtkrpqdpUfn
	eCw4mkTBetU4a6nd82LqkiLEXmkntm5qlGfwmhNuKkgS32JJRPUK
X-Google-Smtp-Source: AGHT+IGIZ1s4JW6qQAd8bIgbDQXjzd/SPVE488bXUbgRRSo7V604i20O0zxUSAUa2hDe9jiAtGUAsA==
X-Received: by 2002:a17:902:c947:b0:1e0:a784:f965 with SMTP id i7-20020a170902c94700b001e0a784f965mr2658122pla.65.1712246605769;
        Thu, 04 Apr 2024 09:03:25 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b001dd95b5dd0fsm15614103pld.69.2024.04.04.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 09:03:14 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:32:55 +0530
Message-Id: <87frw1azf4.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Theodore Ts'o <tytso@mit.edu>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>, Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, Michail Ivanov <iwanov-23@bk.ru>, Pavel Koshutin <koshutin.pavel@yandex.ru>, Artem Sadovnikov <ancowi69@gmail.com>
Subject: Re: [PATCH] ext4: fix semaphore unlocking order
In-Reply-To: <87h6goqx9u.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Mikhail Ukhin <mish.uxin2012@yandex.ru> writes:
>
>> Fuzzing reports a possible deadlock in jbd2_log_wait_commit.

I think I agree with what Jan hinted to me in the call, that
how can an unlock order mismatch be a deadlock.

But yes, a wrong unlock order can increase the locking times of
thread-2 waiting on lock B; for e.g. if a premption happens between
unlock of lock A & B by thread-1.

So it is always good to fix the unlock order too.

>>
>> The problem occurs in ext4_ind_migrate due to an incorrect order of
>> unlocking of the journal and write semaphores - the order of unlocking
>> must be the reverse of the order of locking.
>>
>
> Maybe we should update the subject msg to:
>       "ext4: "fix i_data_sem unlock order in ext4_ind_migrate()"
>
> and also should add:
>     CC: stable@vger.kernel.org

In that case, I am not really sure, if this requires a cc'd stable.
So, I will leave this upto Ted.

>
>
> I think this should have been fixed in patch [1], but looks like it
> forgot to fix the unlock order.
>
> [1]: https://lore.kernel.org/all/1364801462-13120-1-git-send-email-dmonakhov@openvz.org/
>
>
>> Found by Linux Verification Center (linuxtesting.org) with syzkaller.

It will be good to know what was the test which identified this though?

-ritesh


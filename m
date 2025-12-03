Return-Path: <linux-ext4+bounces-12144-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA0CA0E94
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872EF33E2651
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA113148D8;
	Wed,  3 Dec 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWDV3i9a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE74241696
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781466; cv=none; b=urHaYWCPvOaUf9GKYkJGHsDP1U4mxr26peGut3GPkgh/9wvHeR6Ad4UpUGa6uVDHR7Vl96Xmh1SXuOMwkcKECzyWJPyR8OK8EPUnGfaikpPCO83T17stMfwE+tb7MdRnQVuaK/VRvYK9CQ5ncyXnlBG5kbZkYCFJ7C5pRLfT2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781466; c=relaxed/simple;
	bh=BU2ezFNwbfqu+Df86HJ+cluDhwGzAGwq44UpTK6M+oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYwwCYGJD2ZQ4m3d7fZsjax9rxEumWEFA1mtp5eY1mDLaQFEEhgyJF/vMzXx0XAOOOpJRCoi7RxBAuLjIR/Ro9RL6Kmcs2POHOMmbtrmrQhzwvOaOgvlRupKHmLrUqZ3UZ7BGRoWdb2kansr40sQx+sn9H8mpXuZQNUzskQz1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWDV3i9a; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f996d4e1aso7540446d50.0
        for <linux-ext4@vger.kernel.org>; Wed, 03 Dec 2025 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764781464; x=1765386264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RapwvFp73r9FIxKF5Q6+NnflLxxHgF02Iv0NbfM2w9Q=;
        b=IWDV3i9an30SmeyReKPzu6Udn04HpUh4eCUuJzb5Iw76h6LTZD7XVEZhTgtwI5JsIQ
         EeMZq+VNpUZCyftLOjIBUe/3/+XHhL0FZHa3qi6Xwhhr6L5Bj81P7SjI77qrWJ1a7+pP
         hSbRqD3E5IywddObkK4rHKtoGZRKFc5/WQgSa47waA0ecXIIRoZq8z/8+EQ8Ti1wo5hC
         vYlC71gJIxIOuEzXwGhuSq30dvz4CRDPqbd62YmPYRNPLPzYPG7hcm1gzHmRPqKalQPW
         1takyuRd+dJ5CaK1I/0+Vm02367LJfoTqrkAOrQxPOc0dvBjNt+oA+rlCtrBRpbH647p
         0Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764781464; x=1765386264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RapwvFp73r9FIxKF5Q6+NnflLxxHgF02Iv0NbfM2w9Q=;
        b=a3scKjCZmDgnfZSsnPWaJpJM1nQj6dcXJ0Qw3HkJ4OhA0VW8PzWw/6G055wN/uQmfR
         Ah/VQ3PVfvAwJ8Q7strxDvWND9E4fhqYncy/6R6lnR/UESMWcflAA6r4cqa3E3SAIPRc
         Xl8JqLft5IzQkrkKnf3O7UolVzfjsQKYHgj8qn5lAm5hw/tnQjkrG3TJ7HMyl+3uV9j5
         /pyOpOUPSC6RdWZEZGpHwHRG0KLJfRe9adFjN8np2KXMWFYVnP2fiInjUbV4ELuu3W4L
         Ul8XwoXHoQwQkELe+eWRvepdzrCbDwM7Xp3EcvxStNS7zEKdP/c5KiRJ9gDIb7/QzQTt
         qYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ahPLizMrjNPmorjBHqnfr6nHLKtE9E2rExqgAmIvZE+J/+PtRfZo9uQEalinseTfs+prY82csHu3@vger.kernel.org
X-Gm-Message-State: AOJu0YxGU5EyRg9+k8A0hRPR3o3jasUUu9nXXo0CuD0NA4NVDFt9kZMi
	ov19NCPpO1rLCzWEHClN7NlDfc++Gp6gGv4U581nWrNKdP106CnGYSLEoLRKKPa3FbaZatlFMeN
	j+POjwvyXbgRzq/4jeSlX8HQFAZJB7os=
X-Gm-Gg: ASbGncsuOEzc9ma0Zl50xi0OnOHT8CZr6QYqOY/teyQUxvuPfURermpPZ93t+wXN9Hc
	RbLtug2dlicIFk+gA+DLUSV9BqCXl90vxZ06z8HAFPnuidT/2YUEwFE10CPCRIT6B0q9dEachOO
	2gFtn4hnED67x3UXI26JrYPq7INZ0FAqgmC+JTq49jhFWulvUsmNyHm4XKvTa30Ch2KpcySwDTH
	dTOL8f5mWMT03SyJe8mPybohP3roj2WVp6Rpern9kRmG31EanZdTXlpFhYyoBr68sR02faj7Zxn
	3rQEJTUQcvdX+0+w4VkQAIDyzQ4SK+EdWSoY567U0/sAUdrWPDLR8wfDMOv5
X-Google-Smtp-Source: AGHT+IGqADAqlqgSqwhMBd/MaJL11lF5vFRpJc8CNKcwj0b5YPlrpcfqOyHi2tpJmN/ycTywlR2VPusVUY34ZS98Gz8=
X-Received: by 2002:a05:690e:12c1:b0:63f:b922:ed79 with SMTP id
 956f58d0204a3-64436f96e1fmr2250170d50.14.1764781463629; Wed, 03 Dec 2025
 09:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com> <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com> <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
In-Reply-To: <20251203154657.GC93777@macsyma.lan>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 3 Dec 2025 22:34:10 +0530
X-Gm-Features: AWmQ_bmQlPSYgiYEwXsRmlBYIJXIhOI-2mVi6rRJ9OmLGCmG5Ev6APZwHUbduKU
Message-ID: <CADhLXY7pSghxkjw5g2pzbuB3KM7Ms7HByrn-wRRbjxrUxHwV_g@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Theodore Tso <tytso@mit.edu>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, djwong@kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 9:18=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote:
>
> My main concern with your patch is folio_lock() is *incredibly*
> heavyweight and is going to be a real scalability concern if we need
> to take it every single time we need to make a page writeable.
>
> So could we perhaps do something like this?  So the first question is
> do we need to take the lock at all?  I'm not sure we need to worry
> about the case where the page is not uptodate because we're racing
> with the page being brought into memory; if we that could happen under
> normal circumstances we would be triggering the warning even without
> these situations such as a delayed allocaiton write failing due to a
> corrupted file system image.   So can we just do this?
>
>         if (!folio_test_uptodate(folio)) {
>                 ret =3D VM_FAULT_SIGBUS;
>                 goto out;
>         }
>
> If it is legitmate that ext4_page_mkwrite() could be called while the
> page is still being read in (and again, I don't think it is), then we
> could do something like this:
>
>         if (!folio_test_uptodate(folio)) {
>                 folio_lock(folio);
>                 if (!folio_test_uptodate(folio)) {
>                         folio_unlock(folio);
>                         ret =3D VM_FAULT_SIGBUS;
>                         goto out;
>                 }
>                 folio_unlock(folio);
>         }
>
> Matthew, as the page cache maintainer, do we actually need this extra
> rigamarole.  Or can we just skip taking the lock before checking to
> see if the folio is uptodate in ext4_page_mkwrite()?
>
>                                                         - Ted


Hi Ted,

Thank you for the feedback and the performance concern!

You're absolutely right that folio_lock() is heavyweight. I included
it because I was being overly cautious about potential races, but I
agree with your analysis that under normal circumstances,
ext4_page_mkwrite() should never be called with a non-uptodate folio.

The non-uptodate state only occurs in this specific error case where:
1. Delayed allocation fails due to corruption
2. mpage_release_unused_pages() invalidates the folio
3. A subsequent operation triggers the fault

In this error path, the folio is already in an inconsistent state, so
checking folio_test_uptodate() without the lock should be sufficient
to catch it.

I'll wait for Matthew's input on the locking question, and then send
v3 with the appropriate changes.

Thank you for the guidance!

Best regards,
Deepanshu


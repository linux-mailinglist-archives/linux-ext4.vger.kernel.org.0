Return-Path: <linux-ext4+bounces-12524-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D36CE4F72
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Dec 2025 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9752F3002A62
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Dec 2025 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F712D8387;
	Sun, 28 Dec 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHRWAHQb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B052673B0
	for <linux-ext4@vger.kernel.org>; Sun, 28 Dec 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766926862; cv=none; b=gi+sj6xFvGC+OkMu4aViee7k/AP7Jq1lgp3W/k8lQGZcEa8R8JHCM1xG3jmyjR9w02wb2xuM2upvyf8rd7LtppddPkWxjLs+YZN3UFt+CmSVcFkKMYMYP2S1Pm+ggP0Q9QhDEK1UHjFK2mryFWNLSFqjrCqRmHxiPQNKrWBjpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766926862; c=relaxed/simple;
	bh=fz4fB8c3LX5ADF1KLg3YDwRVnUBMr+BnH2+yhoxJ2YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsonQjS9ydMbqBIjMuZDNuCxpktn4vcMtwPWbLuWPbdnrFUcnjKLWZQ/Vix9mtLUyWbQEisJVVTqfhZjtvOmUz+Kblhd6DScNNcQAtqRSdgVgWvntSrcItqSIXno/YbzX40EN4SiqNrTebslEQl/ruibXJGFJ1FC+ApKRUJIXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHRWAHQb; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93f6bd3a8f4so1872366241.3
        for <linux-ext4@vger.kernel.org>; Sun, 28 Dec 2025 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766926859; x=1767531659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMlB4HkqDtdsbd8UCvJsDayybz1XaRYAS8E3HvSH/6Y=;
        b=GHRWAHQb8sh+lOQuEJ+owsyjBHU+N8d7XoknufO6n2SmWj7+fmlL33Ek3NfwKOXiuE
         mNUF9RJRJ8yt2RSrCEIBnPQ31aQArUi4ndfR4KxwIGhthGaqhO2FQxgBGUDa67zvi8b8
         Dk0Wfb0rac0PBgPYPjTu8tOwbdLv8v+cMEtADAdEs+WHdKxoE+UvI9LKovuNNiTUJ8tU
         DW3aIQ+uAb299VM5nR8BY7AscTKV/W0oVEY7t+XxTRcv/Pb0EHYnQLH2Uoq3P20VTund
         JLnDn1vM5RlEWIWgSQ9obfF9pQiRGePpmwhsm/tSh5FRWEib43UFtZ1L7xyAJFMNuCzQ
         o9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766926859; x=1767531659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MMlB4HkqDtdsbd8UCvJsDayybz1XaRYAS8E3HvSH/6Y=;
        b=cuFbcsneXz86kDwRUVp5aohl7f12McL30YoTKfkzvfYZL6/60NnK1PY0P1X+pzAjZW
         gfcBY9oxcBQCaAjhFtStBovm1MBPXR1AtUnPK1OKZrFaUtbZ1kFuQSepDqhLUG44cwi2
         WVPRXYxqAdDDUNJI42wt3BZbsjfigmWJv4C4vBuYQdjhqvFs00/PrE7Si/T8Rff4OK2m
         XOzQxFukk0hcrNnhMNsC0hrWfMEQ1m8sW/eVz9q5dZQgvLRxSnnkbHhwcXdvpGuNru8e
         adRx5DkoKL+lxTFQ+tSjXvFpzHVxMgnkd9bfR+N8Zdva6OBltwPWil7NdoD9s5JeXpii
         PE1A==
X-Forwarded-Encrypted: i=1; AJvYcCVn1vSTKuBLD439xp3gmLnaRZeJNfYYSMV6JnZyKiac6LZDoHPQyo8DxHNYUt25dzvjnLJXmY29AUwA@vger.kernel.org
X-Gm-Message-State: AOJu0YwfViNSF+ZKjegcYfLWrDWDkZfLtxdg+ygtYMKh9tTLWeCpoGSy
	t8Yju8mErdc+VBSH44NdM4lAX2hXyS6XMRffXcjxJWKMOaBiO3BlgVqS820WNXwcD41Ba3KdZKR
	x7XtU1aIwBAK2XO52k2YkEOG7RXin3aY=
X-Gm-Gg: AY/fxX4fhuRAQtEF5a466EG8eueoQW6UVWCM4iXlhwqJSAO4JLASwrxKcTZCEizejMp
	axEmkFPUT6tINuQ1Gom9R4lyf6rp5AFmQQNdjZIZSzQic3Dl07HA/eNwEobqAb72zaXaslJlBBm
	3VNdQogYjRKzi4W2ASdnMMr41y7jmUWBSKxnW6c9ydZOGrqhI5mHR553SuYqcRKRpCAVLdPFb/n
	0ESTanrfyxlV5SkXre+Daa1S0OURZGGHnehjCbU5Cz2QbztVT/cwJCXihGaVA0/KxKLmbvU/ZTY
	wqlfp60OJTBltGuTnAXm70DuWguYL7afaKMu67LBrq6AG6JZL5WczDF2sQ==
X-Google-Smtp-Source: AGHT+IFFTtcullLfa96LNQCWSwjtHzlb6Hh8bwjn7V4IIxPK5Fciwjwn9p54oxZzw8YYGJOtaKYbtanBaGeF85pw0eQ=
X-Received: by 2002:a05:6102:d8c:b0:5db:fb4c:3a8f with SMTP id
 ada2fe7eead31-5eb1a8429c0mr6504010137.39.1766926858777; Sun, 28 Dec 2025
 05:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223215855.2486271-1-kubik.bartlomiej@gmail.com> <b09e6934-6924-4f9a-a866-82599fe64879@huawei.com>
In-Reply-To: <b09e6934-6924-4f9a-a866-82599fe64879@huawei.com>
From: =?UTF-8?Q?Bart=C5=82omiej_Kubik?= <kubik.bartlomiej@gmail.com>
Date: Sun, 28 Dec 2025 14:00:46 +0100
X-Gm-Features: AQt7F2prZvEoT0Nv_gEYMYL1GopFvS8Mdzq_tYpG4TelRR8HdL9Nkix5oYqVZAU
Message-ID: <CAPqLRf224VcJJM1rmiJTnFXg+5tNeF4HC+AEBWpBpWZO6VxbiQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ext4: Initialize new folios before use
To: Baokun Li <libaokun1@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for your suggestions.

On Wed, 24 Dec 2025 at 02:39, Baokun Li <libaokun1@huawei.com> wrote:
>
> Hi Bartlomiej,
>
> On 2025-12-24 05:58, Bartlomiej Kubik wrote:
> > KMSAN reports an uninitialized value in adiantum_crypt, created at
> > write_begin_get_folio(). New folios are allocated with the FGP_CREAT
> > flag and may be returned uninitialized. These uninitialized folios are
> > then used without proper initialization.
> >
> > Fixes: b799474b9aeb ("mm/pagemap: add write_begin_get_folio() helper fu=
nction")
> > Tested-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
> > Reported-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D703d8a2cd20971854b06
> >
> > Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
> > ---
> >  include/linux/pagemap.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 31a848485ad9..31bbc8299e08 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -787,7 +787,8 @@ static inline struct folio *write_begin_get_folio(c=
onst struct kiocb *iocb,
> >                  fgp_flags |=3D FGP_DONTCACHE;
> >
> >          return __filemap_get_folio(mapping, index, fgp_flags,
> > -                                   mapping_gfp_mask(mapping));
> > +                             mapping_gfp_mask(mapping)|
> > +                             __GFP_ZERO);
> We do need to perform some initialization, but doing it in this common
> path is clearly unreasonable. It would introduce unnecessary zeroing
> overhead even for non-crypto scenarios.

Yes. That could introduce unnecessary zeroing in other paths.

> Therefore, I suspect something was missed in certain crypto-related
> initialization paths where the zeroing should have been handled instead.

I will try to fix this in the crypto-path only and send [PATCH v2].

>
> Cheers,
> Baokun
>

Best regards
Bart=C5=82omiej Kubik


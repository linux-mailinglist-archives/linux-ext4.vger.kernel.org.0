Return-Path: <linux-ext4+bounces-12446-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31424CCF032
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 09:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5AFC303A089
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D512E7F00;
	Fri, 19 Dec 2025 08:43:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78523F429
	for <linux-ext4@vger.kernel.org>; Fri, 19 Dec 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766133836; cv=none; b=SMaq/WXXHYXAkNBXcloqk4v7e2xXAKBkEj5l0GgNS05Br9zSfCESXWjXrgC6+4ojA6OsEMKjS2HcrH+5JvPHGfVU+mNSnGocyVYVOhUsGOMIzjx09xFu/MHbnGzfONJMYd+0jNyHM67EexDnSO4qhOHYpItMcMuBrBSi7cWogJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766133836; c=relaxed/simple;
	bh=xm/A6dEImribOoXnxnTykFSuGzhUvM8wBDtOgVzYF7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9/Y2uJT2MrfkRKBvMRP+g+A7H8Ld24gHdl/plnkRv9nyjrlqlgdz5aprSp+8Wv0ugen67Ag0Ul0fqRVJn9WmsNa75dH5xb/l7r1D5bS/YhQX77HYgQcy0qzMLfEVvnT9Bh0Fjc4ue4XwysAXSH0W6zdonjXF49KKrf+RBcStS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55982d04792so1125119e0c.1
        for <linux-ext4@vger.kernel.org>; Fri, 19 Dec 2025 00:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766133833; x=1766738633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MdtOJ4ZlHucq5UjsXvtK2NYve+XmgNe+f9uend0E6DU=;
        b=DwMklZVdhovuzDXJIzE89CyMefs0fGmYUrL5aXUGLjB5tZrdFdE2uwcRAOCYRbR4Sg
         xb97LOlNoAdYh0Kqa06nOAB9vbJjnx8qcFm2FjfMLdZUHrMFFYbkPw/kpZhdzxUxx4iD
         ZpcC2jlgj6fyeTDb5ply+BkQvlBx5RHPTPxTynJ+MkAnS0unXUGMopLIQn6mpnRqapw/
         jBjH+Cxo+0EOgoft+2Yhk9noYkHA+Ao9rPbmAzbVUt4tPKcNrpp+s96LfxDJhQJDkCsU
         BNopcFy5irAUeaZwyn75KQ8n2rSYYkdO5Y8BK6wxTff6+Ev/KsKULhemjTXCt8DWabdF
         hLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdaYKv7bq0QQgDzVGsbzt6EOFTBskmESjB5ymcD6gpULxzTC8yGyC8P2x/hp3csGAU0/RV5Ff0E+p7@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMKSxzoM4CNUntoFVsErL5wjNdYMUXvI700/WrrgD7/oojc8Z
	1m00fJrawPX2ZgFcV6iMMSNGlUjBqLzItImBNfXQDp8QT/2+rb621b3/HBry8J+G
X-Gm-Gg: AY/fxX6M2Vc/msC1DnRYGoPWy+nTQvNyuAoD0p2H9KSoJnq/DYxTMuDY0U1Ony4y14y
	m778FutKSPsxpOUI7FV6Ki8oeM7nc44592qCFrUhyE4sZgJaQ/sQL2jOXk/3PkkOiEMiJYqQY1S
	ig5A8od2ZlFl/aTKLeNNW5+Y+UFSHQMLmbklMNF+BLwBk3pV5Sl8/e52wJoQuAyUPCpX+2EI8Zp
	SmGvCxAqANYlaNd6XHbkWbrF5NHVK7Tb2vI5Ykp25k52SBItGDF+sOShk+W3jDdE81Wi05WZqdV
	q/Q4Od1L3b3bqo6iktlbUj3BLdE4ka8nOAiRnpIFuKD59OJV70lEMSfRFT+lC+e8jkhoAMH2NJZ
	8w7gZ/B26NoPUzc3biXl1S9zi6UuxSlXs9uQmDbawq+xXYBEN79+sORnIOEWxKsNBsQhd+Ze21h
	GRoO8rseQMe9nurS7tqeR0vPd+tH2lswjy6bPM91mRzYBFDCZC7HfC
X-Google-Smtp-Source: AGHT+IFKvSatZImXqpCv6ARrtgIC/hCzN74J6gkhP2V9+ICZGRlLHrgT/3HGrZO1u4VJAQOE36K2VQ==
X-Received: by 2002:a05:6122:883:b0:55b:305b:4e34 with SMTP id 71dfb90a1353d-5615be902ccmr783733e0c.20.1766133833094;
        Fri, 19 Dec 2025 00:43:53 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d1518d5sm604458e0c.16.2025.12.19.00.43.51
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:43:52 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b24eedd37so1033723e0c.0
        for <linux-ext4@vger.kernel.org>; Fri, 19 Dec 2025 00:43:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDDgmvP0xH8u/PWXGW9Kb59nTvxjnNtrpO+1hJpS2Iz5eAaPL6WBfqcA33FhSQ2m6RbFGDcLtbyDcu@vger.kernel.org
X-Received: by 2002:a05:6102:5798:b0:5dd:c568:d30d with SMTP id
 ada2fe7eead31-5eb1a817628mr700445137.30.1766133831486; Fri, 19 Dec 2025
 00:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204101914.1037148-1-arnd@kernel.org> <3ueamfhbmtwmclmtm77msvsuylgxabt3zqkrtvxqtajqhupfdd@vy7bw3e3wiwn>
 <B2AC14DC-0B9D-433A-A1B0-78D0778D0A39@dilger.ca> <a1807d6f-1b47-4a30-86d8-eea56d990ed9@app.fastmail.com>
In-Reply-To: <a1807d6f-1b47-4a30-86d8-eea56d990ed9@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Dec 2025 09:43:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKMoaEoA=aiMUYYd22fqKv2UdVtGMG1JCE-3gtTPvz_A@mail.gmail.com>
X-Gm-Features: AQt7F2oeTPbqWvc36txP7fMnHo3QpCBW_4W_018ea1KKcmCy1um6vrZ-270Sn3Q
Message-ID: <CAMuHMdUKMoaEoA=aiMUYYd22fqKv2UdVtGMG1JCE-3gtTPvz_A@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Dec 2025 at 19:07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Dec 5, 2025, at 11:17, Andreas Dilger wrote:
> >> On Dec 4, 2025, at 3:31=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
> >> On Thu 04-12-25 11:19:10, Arnd Bergmann wrote:
> > While this change isn't _wrong_ per-se, it does seem very strange to ha=
ve
> > a 68-byte padding at the end of the struct.  You have to check the numb=
er
> > of __u32 fields closely to see this,
>
> I had the same thought but decided against that because it would be
> an ABI break on all architectures. The version I posted only changes
> the structure size on x86-32, csky, m68k and microblaze, as far
> as I can tell.

Indeed very unfortunate...

> > and I wonder if this will perpetuate
> > errors in the future (e.g. adding a __u64 field after mount_opts[64]).
>
> Indeed, I can see how that could become worse.
>
> > IMHO, it would be more clear to either add an explicit "__u32 pad_3;"
> > field after mount_opts[64], or alternately declare mount_opts[68] so it

FTR, I would have added "__u32 pad_3;" _before_ mount_opts[64].

> > will consume those bytes and leave the remaining fields properly aligne=
d.
> > It isn't critical if the user tools use the last 4 bytes of mount_opts[=
]
> > or not, so they could be changed independently at some later time.
> >
> > Either will ensure that new fields added in place of pad[64] will be
> > properly aligned in the future.
>
> Changing mount_opts[] to 68 bytes sounds fine to me, I'll send an
> updated patch for that. I've kept the Ack from Jan, please shout
> if I should drop that instead.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


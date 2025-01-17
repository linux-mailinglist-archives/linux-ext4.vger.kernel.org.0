Return-Path: <linux-ext4+bounces-6142-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2710A1487C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 04:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E68A188C06C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2025 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552851F5618;
	Fri, 17 Jan 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH0JhW+n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B125A645
	for <linux-ext4@vger.kernel.org>; Fri, 17 Jan 2025 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084440; cv=none; b=sOZxBmMjzH5XZbLWktiVMagLNxwDMO17LQ5NVHJTpAbOEXYrn57CIeGCOSBFhSzQw3RNrNIJZpwvQ0e6CrAV6d6ld9sENxaEnkbd8/ujxwpIHch7siGlQ0kI+Pat+s/kX57dROd4qZ/t9jwPIbjFLMjL6/aDut9JzL09o+bmi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084440; c=relaxed/simple;
	bh=MLoCpSLdOIl1Yoxtlc9GwRJDTqNUHblGgKFiDBWMBz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZT15u10uKp0dO6n2Q6iR5XlvIC+R0mFdtsjWu5Bu4z47OTmI5bGGleypuhC3Q6aaOFK3TnJiAr6lvvq8ACDKLmW6rlwBG/GhRKQrMRPHwFYZj5k6jd5m9JOiw8KRiTEL0iplzdWoFEE+9pkQyFtvQ3rlhfnWqkaYgNMQ18tbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH0JhW+n; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54298ec925bso1898549e87.3
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 19:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737084434; x=1737689234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBG7FdGccddl84IDWfBOIzXBrKQwAOYTJhUp4XiYU98=;
        b=jH0JhW+n35cAZkjizOBaZSSGO1E1yh5a8xx7df/RtxdpD8XPnQWYAycxAWc2QOpBW2
         pQ+aVFt18OqcxdkpMQfyevCB6apwzthT8Zeh8J9CbwmMdpdobJ6eH5dljz5t733UgkPi
         ZYQm23pk3bPT3lWkEHEGlKK9gVQSLaUn00QewawAuk4+D4Xd9ZlqWmMcTVMnqW9Ggg5c
         U9IxnyCRMtSM7xWCYoo/XU8xzheg0BJJCLzuJ4A9Wxz3yhUobqRcwjLH0KDpwwJ6hoGS
         P596YY1QzkMeL72R5hO2hmAw+yLJZq2rAbwm6aI24+0Wckp98z3xEMYNxAlM2sQjToGb
         s3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737084434; x=1737689234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBG7FdGccddl84IDWfBOIzXBrKQwAOYTJhUp4XiYU98=;
        b=vCeQhOH1ZFymi5qw6nT63PRQ8bDxPautZUBViXuSflzfdGcpte0JBTifV1gWQEMBLb
         Tzt9prxJgsWO2DOIWnuRaF4T3aMB0lblVLoS5I8ebxb6nkqdgFFTiZyFQhKEEbeD/Cb3
         ljueuC8D16xstFUBfIbu91cf0xjF6kwyLg5tR1TilFfrJSPbCxtEvimi+yIbvTUWeuWU
         VbpvqdC+Qd86tMNnP6MDqZyiSlJ8TI6SX/Vs6auHMFKF88dj6ad+CifXrMg08OByn9ac
         07Ra17eTzLNVbJ1Zi1IGm+KLhdLSWDjt85ZBK46boRr+DMiUgy9Q1yGOdYQFqiqU7pp8
         L0gg==
X-Forwarded-Encrypted: i=1; AJvYcCXTgT87jwnCLmXgVfuKKXMmmYZE5/Ebp4RcgfvHixyU4dtgCBzd45o0EsE0sWhm/dTN7nTb5sYiCneI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7c2pC7qZgu0mqbSU4LSy3/F0NhotKJKENJ0BCf1Wlz9dvF3hd
	AVr9Y9qlwbSRumLk1pPyD/6aLBwWRzjy9YJ34hL+e/L02n/GnR/Ht2FALq7uNfW1jpNiauBb+9U
	iUcqXlyf/kP9b+2aQx4irDKdc0PI=
X-Gm-Gg: ASbGncscnnDbNrSW5qEDXphFnpXUjCzFrKPn7ei4RBTTVcE0tXqvsHB1PkX2lODh+9M
	oKO+QG4mFdl/b7+Yi5Y5lB+v2whi1fHeJqZiuKURaLQAWDQI2TwC+4ln7/5jXoWR9tMVZRx53
X-Google-Smtp-Source: AGHT+IFiAsHTPIP59/3N94KBFMggWGJuGLL/1XULI6eZ/Awi47PJBRVEPWciplZ7mTA+CSomKqPxgNh0DU6k/fxuxvM=
X-Received: by 2002:a05:6512:b94:b0:53e:368c:ac4f with SMTP id
 2adb3069b0e04-5439c22a810mr181862e87.9.1737084433988; Thu, 16 Jan 2025
 19:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2LqHL6uY=Sq2+aVtW-Lkbu9mvjFkaNqLaDA8Bkpmvx9AjHBg@mail.gmail.com>
 <20250113163345.GO1284777@mit.edu> <20250113183517.GC6152@frogsfrogsfrogs> <20250113192603.GA1950906@mit.edu>
In-Reply-To: <20250113192603.GA1950906@mit.edu>
From: Catalin Patulea <cronos586@gmail.com>
Date: Thu, 16 Jan 2025 22:26:36 -0500
X-Gm-Features: AbW1kvYOFMF5eXzOrjdB11xUfR-Dt-c9mykxnxjjqoe61_8y1Q-R0V2h18-RBiQ
Message-ID: <CAE2LqHJ0y1OBDKv84PuVVi2JULvuVA8EWJpXbN9vdK9o7LEOhw@mail.gmail.com>
Subject: Re: e2fsck max blocks for huge non-extent file
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org, 
	Kazuya Mio <k-mio@sx.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 11:33=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
> The fix might be as simple as this, but I haven't had a chance to test
> it and do appropriate regression tests....
>
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index eb73922d3..e460a75f4 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -3842,7 +3842,7 @@ static int process_block(ext2_filsys fs,
>                 problem =3D PR_1_TOOBIG_DIR;
>         if (p->is_dir && p->num_blocks + 1 >=3D p->max_blocks)
>                 problem =3D PR_1_TOOBIG_DIR;
> -       if (p->is_reg && p->num_blocks + 1 >=3D p->max_blocks)
> +       if (p->is_reg && p->num_blocks + 1 >=3D 1U << 31)
>                 problem =3D PR_1_TOOBIG_REG;
>         if (!p->is_dir && !p->is_reg && blockcnt > 0)
>                 problem =3D PR_1_TOOBIG_SYMLINK;
I can confirm that with this patch, e2fsck passes on the test image
created as shown in my original email (dd if=3D/dev/zero ...). I also
confirm 'make check' passes (390 tests succeeded).

Do you have any thoughts on what a practical regression test would
look like? My repro instructions require 2.1 TB of physical disk space
and root access, which I am guessing is out of the question. For my
local tests I have been using 'qemu-nbd' and QCOW2 images to reduce
the disk space requirements, but it still requires root and ~30 minute
runtime, which still seems impractical.

> ind/dind/tind blocks, etc.  We do care about num_blocks being too big
> for the !huge_file case since for !huge_file file systems i_blocks is
> denominated in 512 byte units, and is only 32-bits wide.  So in that
> case, we *do* care about the size of the file including metadata
> blocks being no more than 2TiB.
In the proposed patch, "p->num_blocks + 1 >=3D 1U << 31", that's 2^31
512-byte blocks, would that limit file size to 1 TB?



> You're right though that we shouldn't be using num_blocks at all for
> testing for regular files or directory files that are too big, since
> num_blocks include blocks for extended attribute blocks, the
> ind/dind/tind blocks, etc.  We do care about num_blocks being too big
> for the !huge_file case since for !huge_file file systems i_blocks is
> denominated in 512 byte units, and is only 32-bits wide.  So in that
> case, we *do* care about the size of the file including metadata
> blocks being no more than 2TiB.
>
>                                                 - Ted
>


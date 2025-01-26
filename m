Return-Path: <linux-ext4+bounces-6241-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4FA1CD82
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521D33A66AC
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F4514D717;
	Sun, 26 Jan 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dh5uMh9r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89CC335BA
	for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737917349; cv=none; b=MhfbqHSYrQwVs3I/2U4heQDSSURlSvtfilUgKLGt3HB1kCDqno5oz1JaiLKTo+heAKfkgAuDE1p2b3tAyXlMSUButefEXHCLqTOuqBvkH5O6XOihsgJizj0Q6Imsf3PQ8U2E1Iryg+liu9eczEo/93ENH/ezX89Vu++nWqgpIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737917349; c=relaxed/simple;
	bh=9+4bl650qRTAagQCd8/i53cIPSqoTxWQoFGUbxeEMWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jy6H3mNXeHt9cCiTjvWWBA+IsVn9XDiqmGlR1dLN+ZUo2QYEPo9+6eP9c10uLJUYmgdphnaBkFWDvWI385/0Cew6Lfdoi7acK9eUyOAvXdpDJLlKp2CS4Gjm0/T52vrrg+Mynu8bIus1RsgWM8pSQIfWRHsJCbRsq8wP4XmcptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dh5uMh9r; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so6262088a12.1
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 10:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737917345; x=1738522145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FrZ0sALiETvcJmlfvZPLZePY0CmkWSknJ94I5nMkpj4=;
        b=Dh5uMh9rmuQVC2EfSLewALeKiRCmficb92+nqiqc432hojSGwig2KWR3YXVCpCe8Lj
         sNKtLM9nRApzwvuQxNXsO400AWhRfsaLmgBzYOLUOwSpOlyLBJ9erzT64JVAgBfP/KkI
         DuW0W8bawKY+XnpvaioCRJ1IBh6GeA4jGRjyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737917345; x=1738522145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrZ0sALiETvcJmlfvZPLZePY0CmkWSknJ94I5nMkpj4=;
        b=qgu1s9EF5PDjO7p+NBxxhydramZwvXmjCvGPg/UDSwZY/6DDRNWYYXWg9mFSKmk0g6
         ehjO8EP+XOTx0pz2JnmmhMptmYEQVdwSpcwF4n92PWvBxB0rKo1NoD5blb8ja6mklcFG
         asVrl9oguVnoNxUT0q9phcSTfXHXF4CP/rzkw6RaGCIlKNhYrsPFwlUsuc8WRIXJjAW0
         N2MXI49nqvERVTsmTuKBcP/RFotxpXq41F2Uj0734iPy6XUkaQZjf2inQ57xX9V1xKb9
         v8FSaVMHUxzN2olD214X+x1dssYaUJ0ntMDOu4iUsybZR7R2Ddw/Z4hWQX+UqDCHFgH3
         qEGA==
X-Forwarded-Encrypted: i=1; AJvYcCWwq7ajOs1jOv4claavbP5NgLCT5eNc+Nn9SUYlU84gHX5A4Ay5ky9DSS5L/VoF09pOiJkw1DbIlJVp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QeNmE8PKXXoXObL2d9MEwPF+qmufCKKDSQdmOGekCo2lbaNV
	P0aF+xlqZ4PXQuQ+4YWT2T4f20Urxd7ad+OyEwqsIX1I1+QuUm5/L0TInHqUgPgPwgxeAIMEmyz
	OQy0=
X-Gm-Gg: ASbGncuRvAVEC7CIAX0XP1pCdMWk36FiMc+gw23nIdUhRc8XRJqejZ0+3jaZFUCBDFH
	cEC4kJaSO+/y8IW5tiXKCHil67Vc4F+XVrNZislLPVaJPk5qgGj6rYKsIqTd0Uftk85wkykPppa
	OUb8wGNU+PLBkauzSjdBCjRkZZT73VIqCq1PbkI1lU7As4Rrzkmyh1gAx479UqGs49168UDrGL5
	lk3zg5OxSZXkBmyadNAPZFSQtXDrT6JfAgoizmZy08JW7hJvriSnAdpl3G9yN7+QmmRUEE0o4OC
	TorfYSj8MnYtryYw7lKK1erjevJjy4jE9PV6a3Is26XTbMUyeShQ+jU=
X-Google-Smtp-Source: AGHT+IGw0XQQK1NM8cmXTl27ayvbzWjShPcJD4Hm/tNnfSdsSVGc5lx5TnvpaxD6vionjxY/ClNIzg==
X-Received: by 2002:a17:907:1b15:b0:aae:b259:ef5e with SMTP id a640c23a62f3a-ab38aedb10amr4039240066b.0.1737917344874;
        Sun, 26 Jan 2025 10:49:04 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e67814sm458047966b.74.2025.01.26.10.49.03
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 10:49:04 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so6262070a12.1
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 10:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaSQynAPG+CakRXAOVrzD4iUeHkCgLV9bRHHK1TRU6ERjM50FRaqFgWJbYWlx9aeGh+QOO+LMz0V61@vger.kernel.org
X-Received: by 2002:a05:6402:1e96:b0:5dc:1239:1e40 with SMTP id
 4fb4d7f45d1cf-5dc12391edamr10964500a12.31.1737917343237; Sun, 26 Jan 2025
 10:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20151007154303.GC24678@thunk.org> <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
In-Reply-To: <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Jan 2025 10:48:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
X-Gm-Features: AWEUYZkmZjjZx_3oHvn1XNkCUxAkyGOnB497YCfolsRGd70E-DAjp1uUQmxmOwE
Message-ID: <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jan 2025 at 09:02, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Hello there, a blast from the past.
>
> I see this has landed in b90197b655185a11640cce3a0a0bc5d8291b8ad2

Whee. What archeology are you doing to notice this decade-old issue?

> I came here from looking at a pwrite vs will-it-scale and noticing that
> pre-faulting eats CPU (over 5% on my Sapphire Rapids) due to SMAP trips.

Ugh. Yeah, turning SMAP on/off is expensive on most cores (apparently
fixed in AMD Zen 5).

> It used to be that pre-faulting was avoided specifically for that
> reason, but it got temporarily reverted due to bugs in ext4, to quote
> Linus (see 00a3d660cbac05af34cca149cb80fb611e916935):

Yeah, I think we should revert the revert (except we've done other
changes in the last decade - surprise surprise - so it would be a
completely manual revert).

If you send me a tested revert of the revert (aka re-do) of the "don't
pre-fault" patch, I'll apply it.

Note that the ext4 problem could exist in other filesystems, so we
might have to revert (again).  It's not necessarily that ext4 was
_particularly_ buggy, it's quite possible that the problem was
originally found on ext4 just because it was more widely used than
others.

               Linus


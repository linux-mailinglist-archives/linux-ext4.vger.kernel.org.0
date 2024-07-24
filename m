Return-Path: <linux-ext4+bounces-3409-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B980793ACC3
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 08:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57652B2363D
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583750284;
	Wed, 24 Jul 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5bNTarp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1554CE05;
	Wed, 24 Jul 2024 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803392; cv=none; b=PI5Qpc17p8BPs3cjj5EjOEDYWzFbGc2aIfOBDYTtwPM7NmLnDgjtA/ojbqBM1/fTAxgiWoi23nN9mSBeQBmaSfZ45d1g9KzsXHjWTGm6MDvwAYMYe5B/KdhPBgmn55Eggq7mGrUzV75IuVWFAsthArlPNABvZ12bMa6pRKNjJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803392; c=relaxed/simple;
	bh=BvzaEa7+Inuxhazq34ZT0aKl1U9tc8B8v6hfHoXQy7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHiZfI8jwwHCFOsI1zfyUU1Q/RU02AW74VNG0lw7+kquqFxwSMjst3MrdSvWegcbx9kynzZHHCiVCU6RoyXp8jaPPwkzeawy85DHmLgs747+j3ZrqKLyUstTIe+V97imdJXQM9EYyknHjo9bVGxRi8uen4L+7ywhYbjE1Yr37rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5bNTarp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a05b7c8e38so345909485a.0;
        Tue, 23 Jul 2024 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721803389; x=1722408189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPFAXHpcpNHosyuWGUHU07Blzo9gAD1mlcK+fpP4HNc=;
        b=m5bNTarpeowY/CAJnJnsrWkOQzlp++WPARTUOu2MjeFx3ZHGCykpaQcQ9LAVieZPXQ
         R4UMUflXB6haaqTtmdKKvVhz0DV1SlZPUVk7FFkcbqZQJ08oZ3zlK4trmnZBBqVWzVQl
         O+ksMu/O7xDnoY87Q5wEaD1qoeOFKwn6/DYzMjI/jqQkmnn9xYGmxF22XNfmhDmsYchp
         ujh8pkAusyR+0g1lcvRkNFe7PzBf9prqRAzXIEqXUglK/rnf4UPvPMp5b9YL+H2Dl5n3
         ybWwpsrmePqaIjMBHhofozNBEsN28wamir6ud0ucQD78M9vEYZwVbc3jBxXTgX+2a8/1
         x/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721803389; x=1722408189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPFAXHpcpNHosyuWGUHU07Blzo9gAD1mlcK+fpP4HNc=;
        b=l/L2+aZRVuIJoKoXMwPAvOP/I91tX1NBdSXuklUmIanQ/FQYzsBZ/Qixl05d0/omOl
         vxdkeALw5DRBxQIVriixrmGwFLv/C2NDasbTagJY2nVUJzQ9/GxrktMTs8kr9g4P+AK3
         cZuKkYA5ohWsnXazfXtItUeZZwFRkNd+9yj8LH89W35J6ZxSavtq0h0ZLMnX5XQSRT5N
         V6RR5fu14ZHX5fFpIfsZrk95X5mzgq6dU85OCu6lET3z8FsXPulXcrLh7kibmtJoKtvJ
         tFB+0l6/tk6TUTCLP9kWz6wju8hfAbRYaArwVdh4M0HVncjc5ae8U+Psf+3BGoPLcbwZ
         LiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUscHKJl7QNJFoiW5WJp8Di6gmAT6dMxTObrmXgayWGcUFnrz1Jnk3RQfhw0md67saGhLeiy80wVBdQ1Xm1mr95SBkSD0gvziDLb7l5vsz/Nmff6WvWsypejSjQLiHfuAk5yg==
X-Gm-Message-State: AOJu0Yxctwv3pgDZj7gq57RbsQ+CfAMpZgPLLDOq9wVOlHo/YtZedZPW
	YfEarJUdjPP2Qe5ZgRa86LNtWlY5bN6d6tq2rTaB1GUUobc8rzRJhyaorS1j4EJ85VBDTCLoT1+
	AU8n8FOIIL9XH8QtCdQ2wT01x4FU=
X-Google-Smtp-Source: AGHT+IEMBaGnSfDJ+jEEftZgDyBW5iYKL7A7JIFxgVqqv7Bb4un3LnmVYMP0aw97+OgVNLOg+E1P8hqc78x1IQXaz7U=
X-Received: by 2002:a05:620a:2681:b0:79d:8d21:4571 with SMTP id
 af79cd13be357-7a1cbcda79dmr149727185a.22.1721803388911; Tue, 23 Jul 2024
 23:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xswtbxb.fsf@mailhost.krisman.be> <20240723214246.4010-1-cel@kernel.org>
 <87jzhbsncw.fsf@mailhost.krisman.be>
In-Reply-To: <87jzhbsncw.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jul 2024 09:42:57 +0300
Message-ID: <CAOQ4uxjDM00vuQfw4m3+eph4iSxqrvFu7-WNfuZ4BApv58gQ-g@mail.gmail.com>
Subject: Re: [PATCH v5.15.y] Revert "fanotify: Allow users to request
 FAN_FS_ERROR events"
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: cel@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	sashal@kernel.org, stable@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, tytso@mit.edu, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 2:24=E2=80=AFAM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> cel@kernel.org writes:
>
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > Gabriel says:
> >> 9709bd548f11 just enabled a new feature -
> >> which seems against stable rules.  Considering that "anything is
> >> a CVE", we really need to be cautious about this kind of stuff in
> >> stable kernels.
> >>
> >> Is it possible to drop 9709bd548f11 from stable instead?
> >
> > The revert wasn't clean, but adjusting it to fit was straightforward.
> > This passes NFSD CI, and adds no new failures to the fanotify ltp
> > tests.
> >
> > Reported-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 4 ----
> >  include/linux/fanotify.h           | 6 +-----
> >  2 files changed, 1 insertion(+), 9 deletions(-)
> >
> > Gabriel, is this what you were thinking?
>
> Thanks Chuck.
>
> This looks good to me as a way to disable it in stable and prevent
> userspace from trying to use it. Up to fanotify maintainers to decide
> whether to bring the rest of the series or merge this,

First of all, the "rest of the series" is already queued for 5.10.y.

I too was a bit surprised from willingness of stable tree maintainers
to allow backports of entire features along with Chuck's nfsd backports.
I understand the logic, I was just not aware when this shift in stable ideo=
logy
had happened.

But having backported the entire fanotify 6.1 code as is to 5.15 and 5.10
I see no reason to make an exception for FAN_FS_ERROR.
Certainly not because two patches were left out of 5.10.y (and are now queu=
ed).

I think that the benefits of fanotify code parity across 6.1 5.15 5.10
outweigh the risk of regressions introduced by this specific feature.

So please do not revert.

Thanks,
Amir.


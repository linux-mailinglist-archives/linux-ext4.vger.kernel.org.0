Return-Path: <linux-ext4+bounces-8506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0BADDDC9
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 23:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA0B17D804
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 21:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CF28C036;
	Tue, 17 Jun 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+3Lc6yL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2E1DDA24;
	Tue, 17 Jun 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194993; cv=none; b=tKivzsPxc5n4W9KE22YcYw9GWhM0v4gcfkMiFbIGuxbQ5JXjkxA/D8uQ8OBlDAVTO1nELJjrVvPaAdpNRPM1lOzpd3h2WGaDHhZyZDKY585iXRseI4R8hHQfBIL+eZiSdK5/OFnEk7V8fkYhNvyMMnx+MhvPyp7zohosZL9vsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194993; c=relaxed/simple;
	bh=YvEgBzaIYheGIG3ifIRScFWNHH3WBzhStM9Dk5AO8k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRoB0i0GWxU6A/+4TlP7T2SzjsRdOVR+cVHuYp6wLVrP5/wqmca4Ue2Cz21HE3CBvoVmzeo9cXY6fAmJZljnlGn7oa6pYKydEUUksUPMY5TchH3CQXJmGPNmhr5cekXDdTzyqcTvaQ51beCxz0OA3lltI5634VRYvWpiunw5N/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+3Lc6yL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad1b94382b8so1175488366b.0;
        Tue, 17 Jun 2025 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750194990; x=1750799790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT4f3XR3LrP+wA7bs+kmEcSWH7p6CrluZN0uYVztHcQ=;
        b=e+3Lc6yLG6IctKhU/UBv3M7lkD89OlonWEoRII8700GxYXkmM9eLu4pYeGWdYJbTrN
         bu/Re9+DE35GD2hjxUXpNhr6niYjHl8XX8nJw19IyHMaGBTkn+kPPkYSQZyPXO0D9bcM
         hj2Ao57j6WcCH6r4GAVh3Eh5xTlFbDeSgGUZP1WTgi7z1Qa8682VBOdYBp177ttS8kAH
         gq0GK2Gq0sJJosFXqsDVs598rCG4Sd9/pdo6/wIrnAqyi3fyTlcCnFbz1B5rIRU2YXhF
         wixOWQV8f7yu5NvZya85OQnmpxiXW2lS+GM8kLD/KTTwcq/A+nzkQ99jzEpY0x/4wStS
         GMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194990; x=1750799790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT4f3XR3LrP+wA7bs+kmEcSWH7p6CrluZN0uYVztHcQ=;
        b=SqzEeADQyWepdp7a1vbzQRwa5ngM7+QxkyfVhPz2LpOXfQ+4sWtHPhXR/ftMO3/AWG
         yNyfPwB9niUwC90qFzZTWjbP5tAY1bBG9iRBoCWBhzv21x4fSuO3R/Hh4oLarp6p8lnn
         BZNaAbocRA0QYlOX8+j2G7dl9zccA6tRdL9NNHpvFZmUduoG+VJ99plZ9Y1jye0CSJSH
         HfAYR2s9AxDBdgyKd8NrHzsBLqFJL92fnSAd75SZIkvS/VXVIq4tjoI3q/8l+f1Ve5Ou
         g65GteY6tjdbEcbEucFaOaip2Eji7Us3n67CxqpZbK6hv7ByvtuVPC5IC5Yp3Q3KHpg8
         dGEA==
X-Forwarded-Encrypted: i=1; AJvYcCU7VVePa4o+3vHimp1O0h4KexwcLijwEtYLDR0mG8UuzRsPryKsZiLtG7mb6gopYPzBbTMVOGZ6ammv@vger.kernel.org, AJvYcCWEDtGiUwVu0Paastm3dEC80Zlq0zuy+CGcJFr8UVAhtvrPZ3lPGOln0Of4sdw9MVfYPBT8mjSt@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWxk6qRCf+X9dE3S46So+dCuunMtHasC2UdsgYVlSSPFcUNYW
	8q+miFMN0IrTuw72GIZ6SUI8GM+ux/wNkoAOsnVOxsDpnH/g0D/J6wxpI6pEq91coR3GiGYOniC
	r+Sfk2qdMdrw8kVJ6RtzihL+x7mCsd7o=
X-Gm-Gg: ASbGnctH9VWO4HhqqQro9HhPJ8IOwkkotbkxN2scxZ7vUmAps34cMVhIX1vlnrH+54A
	RCq6JztDFmqQRL49r0CBocuA2LPklrhU717gMfnLp3vSNRMJ8Wax3xINNAG6EBbfCkds6MCmnWV
	n1GsoOyTIMT101Gtx+AGOi/nTvFzyY+4itf7nrZUe9tEw=
X-Google-Smtp-Source: AGHT+IE6nHoOPQysaeedYDtdOYoK0g+pdHWISMOFMs8a/exYPbMIeRKWCttyWYY3OnXjASp2w63cxraZxmiD7fEK15s=
X-Received: by 2002:a17:907:1c10:b0:aca:c507:a4e8 with SMTP id
 a640c23a62f3a-adfad3c54d2mr1431945966b.21.1750194990255; Tue, 17 Jun 2025
 14:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617210956.146158-1-amir73il@gmail.com>
In-Reply-To: <20250617210956.146158-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Jun 2025 23:16:18 +0200
X-Gm-Features: Ac12FXyTJ_3DeOo24fQH6gjKoW0ZlMtGZTjz-3VkC1fGO0jzKybqXX4QlLqLw4Y
Message-ID: <CAOQ4uxh3BaH_R-29uox_qASshtauYAO1135Jqp7EmJQSLTfJ4w@mail.gmail.com>
Subject: Re: [PATCH 5.15 0/2] fix LTP regression in fanotify22
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ext4@vger.kernel.org, 
	stable@vger.kernel.org, LTP List <ltp@lists.linux.it>, 
	Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC to the correct LTP list address]

On Tue, Jun 17, 2025 at 11:10=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Jan,
>
> I noticed that fanotify22, the FAN_FS_ERROR test has regressed in the
> 5.15.y stable tree.
>
> This is because commit d3476f3dad4a ("ext4: don't set SB_RDONLY after
> filesystem errors") was backported to 5.15.y and the later Fixes
> commit could not be cleanly applied to 5.15.y over the new mount api
> re-factoring.
>
> I am not sure it is critical to fix this regression, because it is
> mostly a regression in a test feature, but I think the backport is
> pretty simple, although I could be missing something.
>
> Please ACK if you agree that this backport should be applied to 5.15.y.
>
> Thanks,
> Amir.
>
> Amir Goldstein (2):
>   ext4: make 'abort' mount option handling standard
>   ext4: avoid remount errors with 'abort' mount option
>
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/super.c | 15 +++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> --
> 2.47.1
>


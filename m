Return-Path: <linux-ext4+bounces-8613-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFCAE5E4E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jun 2025 09:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B71B640B3
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jun 2025 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E061239072;
	Tue, 24 Jun 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ASC9TwPD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED22253EE
	for <linux-ext4@vger.kernel.org>; Tue, 24 Jun 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751176; cv=none; b=nVU0+BshUTuumS2mdcz7pqlLlodesqLT5CtGAPCnqswZCU2WG85waSaOqO0kXaTaBnIvIuplhzuOxzue7mEK1FUAumIhNfvr8+nE2yEs2geqeqcNn0e+xoEyS7/QUJav/yDsdr/bOSCK0NAUXLiAIYN4dar5dKTONThCWTxTXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751176; c=relaxed/simple;
	bh=6NK3tnnqwOsefuOmMDNLuw610W8Lqq0WNNuq6KVcXpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFYaAMUDa1KP702Z/RKamewPwj82IzRS7PxacM7LRPhBnFnKov8Rj0tMMFzPznkMAcKgO3xKt+H+K3GyusEcVIn8L1Jq5xZocqlD0dDc2Fatp4SWyntfgYjzuoj6ZvBwSvlgKz2lWBU5VsQnpXWJsZtNglkWIhkSF3K7hcEMed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ASC9TwPD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55220699ba8so5496056e87.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jun 2025 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750751173; x=1751355973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+oEhOHHx7fY+nLT2qN0EKVfCmE4uQzy+o05i8qDvec=;
        b=ASC9TwPD3bTcc8mgJLEIeH8p7PIodYWUYnnYUbYxrLlmaqbH5DH3yEXCH030vTUMxN
         JHIXhs08YbHPvnESb17/i4/MY0umqbZX9+Ce8lNkE7s9iC/ZlZB5EQlQm+qaSQQOLKoU
         L6okSLNxxvcjitYT7Km3sGpbOkGYdiSqH86TzXbmZJ3gjLYYUyKA41Ii5uiNuc6ZQg3g
         5IDo5tdivXSsLLdiYzaCTG8tfdqa5fQ+tpalIZei+0OtjIVe1VqRRpGgblCP/Ee1YpDK
         nwiLShOgqErCMwdKI3yQuJp2X1R73N2oa7kRf52UA/fUjUu/xc/oe1lMH4qG5UmnL82d
         +m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750751173; x=1751355973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+oEhOHHx7fY+nLT2qN0EKVfCmE4uQzy+o05i8qDvec=;
        b=rqZdWznMHRn33h2LuhRgBxOz5MEBqENlzIgSLqxuRWaurJX+rFPBwvDereFvq167+8
         p6+nGB1EYeAZM01q43HQF3qLpi7z+KHx0xw/+dFPQyF/Lp/x+sqMILwQSys9aJvfi0yk
         nbkuZNneIKVGrB+teKlAQ8r3CTKH6N2BXcd0a1cMdByPkeZGyk+m/Vz0GBEspcN4rebj
         4WLvmu1xMUgY2MnZhDRS0VplxtKXe8nLuePqqLGYcEpo9mJt64LbePvbZR8UykO7KRQC
         kLRA662uw9+VMvPwr/cBmNdErAJQs00T61lIpojvDonAfaLJddJPLXKEIH7y2qoKfeVA
         6Yhw==
X-Forwarded-Encrypted: i=1; AJvYcCX2DtvMmKNnHWWg9edu9j5KrdPRaDpeUjfQjJdRdLSYfpSH5Qu6ShJheDeXiH3TFgqEa+sgydAy6lA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SNArAZV5SB5LueniORPgAdZP7koRWevJjGg3eTh2H2AYlVCE
	U/L3HulOAzIDAR8+Stu3sVHchU6Wi6L2d82a0iC01O0PH3qZK386YIJJaTbsZQdeNMzQ8+7JVC8
	alpuv11yVYbCrrwz+N8cIqkDMeOycJWICDOTf7J8UEw==
X-Gm-Gg: ASbGncu3Aar5rZEyZcLfMk1tIz8pvChC6WpwEhfUJsOUWrK5MBfpfDQlo/cMEf+5eyt
	/dgw44yHyKkG3Sa9zBdQfc2mdeaQdzYwn8KVhVgeL2ZGWM4oDcbsCXGaH+q8kb608MF+j1uJeEr
	H2yZqzp1qb1j8zc/W+rf/RcPTUsocba0VdrOP93Swaprytkdm/lfNOpEQ9
X-Google-Smtp-Source: AGHT+IFeYUZar2HVowmkLYZSd2STiizR8hFaF4uq0hhzYEvud8WPf+pSSuVw8h7oTS5swY4X/pPSyhdh3F2k1DRwzJc=
X-Received: by 2002:a05:6512:3e04:b0:553:296b:a62 with SMTP id
 2adb3069b0e04-553e3b99018mr5116928e87.12.1750751173353; Tue, 24 Jun 2025
 00:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
 <a57jjrtddjc4wjbrrjpyhfdx475zwpuetmkibeorboo7csc7aw@foqsmf5ipr73> <bkql5n7vg7zoxxf3rwfceioenwkifw7iw4tev4jkljzkvpbrci@6uofefhkdzrx>
In-Reply-To: <bkql5n7vg7zoxxf3rwfceioenwkifw7iw4tev4jkljzkvpbrci@6uofefhkdzrx>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 24 Jun 2025 15:45:37 +0800
X-Gm-Features: Ac12FXz-Z4gUKGi6BIbRPkGEyqVXiKtjI_FOE1Vnun9s2B37mLTDpYjLgI0Qdmw
Message-ID: <CACSyD1PJ8tGbWpqyCx=dXSgZbhfCuXcKKX6_kmN17F6g+E9m2w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/2] Postpone memcg reclaim to
 return-to-user path
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, akpm@linux-foundation.org, tytso@mit.edu, 
	jack@suse.com, hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 4:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-06-25 15:37:20, Shakeel Butt wrote:
> > > This is
> > > beneficial for users who perform over-max reclaim while holding multi=
ple
> > > locks or other resources (especially resources related to file system
> > > writeback). If a task needs any of these resources, it would otherwis=
e
> > > have to wait until the other task completes reclaim and releases the
> > > resources. Postponing reclaim to the return-to-user path helps avoid =
this issue.
> > >
> > > # Background
> > >
> > > We have been encountering an hungtask issue for a long time. Specific=
ally,
> > > when a task holds the jbd2 handler
> >
> > Can you explain a bit more about jbd2 handler? Is it some global shared
> > lock or a workqueue which can only run single thread at a time.
> > Basically is there a way to get the current holder/owner of jbd2 handle=
r
> > programmatically?
>
> There's a typo in the original email :). It should be "jbd2 handle". And
> that is just a reference to the currently running transaction in ext4
> filesystem. There can be always at most one running transaction in ext4
> filesystem and until the last reference is dropped it cannot commit. This
> eventually (once the transaction reaches its maximum size) blocks all the
> other modifications to the filesystem. So it is shared global resource
> that's held by the process doing reclaim.
>
> Since there can be many holders of references to the currently running
> transaction there's no easy way to iterate processes that are holding the
> references... That being said ext4 sets current->journal_info when
> acquiring a journal handle but other filesystems use this field for other
> purposes so current->journal_info being non-NULL does not mean jbd2 handl=
e
> is held.

Hi Jan,
Thanks for your feedback and explanations.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


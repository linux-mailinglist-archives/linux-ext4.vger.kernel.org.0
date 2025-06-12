Return-Path: <linux-ext4+bounces-8380-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E390FAD6786
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE6917D7BA
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73921DF75A;
	Thu, 12 Jun 2025 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ENkWACqB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9D2AE6D
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707666; cv=none; b=ml6Y47oBrDdMSr2FIjk6daflNYmevWJOis8Yf2NpRdV4LoqqJMW57nibdEKUV+Du3wsIlo2QCqDOoQpXJaYnNUJGoGEoOSqyEix2Ay4eNnd5SNQqGT6pe6l4pPj+LQ4bX4EsuYsEdJFyZs4FXMeR4xgKdP0fmpksf2Db7Z4kO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707666; c=relaxed/simple;
	bh=rCqJBITI17wUEy8pxvAWbyIY2HOccVtAGy9V9bSN/sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHyOGNs/4VwCTVJAp4+3Dvi5s6HPTM2xImndQl9OHyvHepACWmreAXHJIcGS/gnEdJF3zMSvIndImUVx9MmanvDSs3wPOHek1fkS2gREyT34O9vBA7kgjtZ2FY9akgEkG3HTh10im/8c1WjzFiITtcgwxUl+gO9LUhSQ6JwpSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ENkWACqB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a58ba6c945so11495621cf.2
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jun 2025 22:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749707663; x=1750312463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3kezLdvyOflb1iXxwzQLR/J1sisi4H2qKqn/TJwD2Y=;
        b=ENkWACqBLRuM1EfA4LygxI44RoWYlyyK14kZF6lrWluG4rsb4T8UZ0jAYwBWmLnd6y
         DLxWI0GsAgTnU5GBYUptg46vbtOwtDNKyjQv9JQhoJbwihLpEcn4xwbPUk7C9JUKNBJq
         wjHu5JwsaKyF0CCBEiqrGFLoze93DJi3qubeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749707663; x=1750312463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3kezLdvyOflb1iXxwzQLR/J1sisi4H2qKqn/TJwD2Y=;
        b=I4zFJuLFrx5rqxTJVoeX/igT/+eL3nODwjP4mEAdf5FXYzLp+H8gOQK860QCjINhBU
         3gEsUDXP56u8zgCDRMFnjouCk3R953LbckdZFooc2Kw7nSf75yYVMck+r/fvWk2X5cY2
         FLMjfS3qqWcP1Oj27wEB32LQzx4ceSQKwsqZSSiqxdQiCn7K7Yv/qivyqhoJssEFDRHC
         Bgkm14gFXmDg/4DdyMRL3l908G8kRwOOI0UJfizqESwfkVVA34ekyPboMwrhfd5L2Rfw
         1bIauQd8nWdna2FMcSEgmfiouA2f5h9RodYeKqGHFxwQk+Bm8ngD9TziWy8sFZyTb4Rn
         +53w==
X-Forwarded-Encrypted: i=1; AJvYcCVeoQ3+WZe4ZFjUxb0NpIYItDkzVaJXqiplm0zag//whZK9jltv0pPq41YVOXn+J78SF9hw3CJi+FeA@vger.kernel.org
X-Gm-Message-State: AOJu0YzWNY2raJGudVx/vqSq3qZTT5u0IiwH+/+MNgvxOpxCOuFfinXi
	bzWZ9UNAx3CUVj9g2wQxmeJI5Aw+DQfUhCOLv+J/etpUbe9EIJOY2FFmgofkDkMrIQOqVOmROkV
	etPYMKS9H7EEL0HMf6By2NAjJIwytEpQp4iy5Nq9PZw==
X-Gm-Gg: ASbGncuPyyKWP3xkrYpT8gRfHiJPdXekNhdYafp/cKepmofM2QTZq5By0QJalA7A6s+
	L069+OQDxvpXNrTRIZjApQpMxiLBtitshmiyqPgOiUXICBzAtZDZ11VqNjMvOClkFtQhThxZ/Ib
	uX++Q6v2+WZfG56s1DjBkXvsY2RC/oooSfZYjPvIJ9++nlQ7JhbJpZtRk=
X-Google-Smtp-Source: AGHT+IGuCZBZeDcZUWDRQPVv74TNbhbiDXKa0VPONpmsuiq38OVOt1vmKqAgiGlD0aS+y6wrRfuqxM2a2ZAip/BRkCE=
X-Received: by 2002:a05:622a:1e10:b0:494:5805:c2b9 with SMTP id
 d75a77b69052e-4a72298b30fmr45465221cf.31.1749707662898; Wed, 11 Jun 2025
 22:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs> <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs> <CAOQ4uxj4G_7E-Yba0hP2kpdeX17Fma0H-dB6Z8=BkbOWsF9NUg@mail.gmail.com>
 <20250611060040.GC6138@frogsfrogsfrogs> <CAOQ4uxg-HT9ZA4UdQsD40z4THp9wBJw=MPHBSnWUCbOA+Mc0hA@mail.gmail.com>
In-Reply-To: <CAOQ4uxg-HT9ZA4UdQsD40z4THp9wBJw=MPHBSnWUCbOA+Mc0hA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Jun 2025 07:54:12 +0200
X-Gm-Features: AX0GCFsw2KR9hAx3DAJbh7kMqAeaJeXoEwObZo7EXusxHxaagbFzTyYqtlm2UXM
Message-ID: <CAJfpegs_An=3Ghgz5fyo=A_e--gbG5sS1-cDoOJwhfWBx0DBLg@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 10:54, Amir Goldstein <amir73il@gmail.com> wrote:

> There is already a mount option 'rootmode' for st_mode of root inode
> so I suppose we could add the rootino mount option.
>
> Note that currently fuse_fill_super_common() instantiates the root inode
> before negotiating FUSE_INIT with the server.

I'd prefer not to add more mount options like this.

It would be nice to move away from async FUSE_INIT.  It's one of those
things I wish I'd done differently.

Unfortunately I don't think adding FUSE_INIT_SYNC would be sufficient,
as servers might expect the first request to be always FUSE_INIT and
break if it isn't.   Libfuse seems to be okay, but...

One idea is to add an ioctl that the server would call before
mounting, that explicitly allows FUSE_INIT_SYNC.  It's somewhat ugly,
but I can't think of a better solution.

Thanks,
Miklos


Return-Path: <linux-ext4+bounces-5138-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E01689C79FE
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 18:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07B9B2DC57
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E170829;
	Wed, 13 Nov 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FmTQtQ2d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE761E1A28
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517076; cv=none; b=ON9isQWZB2iHyo1NjNQBuRmgveW4goLcJwFKM1y9F/or4RAMLm0N7p3kG+V71H0lssymxO+LEEz4cAPDc4hVxKfTpa3BURnUYcm4QQY1veqHIt62aaw5il0tKPMhkfW+r0BWj1Hc6425GVVqkfHjadjIQyV7luDtJt71bojYlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517076; c=relaxed/simple;
	bh=csPBoYSDByNBHf+k5gUPUX7+wR76Q1hEBFh0oJb/HtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebNFEV95MMXc0c3cPPAzc5beJLGG1+h5R0dgQ+SIhzpvDpTxjkmb3VuEi2vkO+Ua1HSYkuHqcuj+cRnHrqsCe+XLb3BgkFt6LstJOuxmaEcgsRPylFrL4unmrrbmkwbaT9L4W/LeGRHkI7jcvCKFCfBc//kOvtqRedofKM7Byzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FmTQtQ2d; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539eb97f26aso7041682e87.2
        for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731517073; x=1732121873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r6dKI9I0XiNa6P0LadyJEAqhNHGcRQ6Z3i6i70GfR1Y=;
        b=FmTQtQ2dgrnqzr9HVw/sR/cB/YOW0jiIYjRjf6sLqy9OJYQeVtk7OrEfwyd2TSL4hp
         KMs5C7PZM27N0xVMmT2JD8Gke+tK9qBvV7gWnZ8HlYJxrJz4lLARIThXUlZHQvqFvXDB
         yGC2tfSOndzs5YCk2QtypBei9c+IxgF+aYHrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517073; x=1732121873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6dKI9I0XiNa6P0LadyJEAqhNHGcRQ6Z3i6i70GfR1Y=;
        b=sii9GJzI3tzt+XjrRMijrPUfEvkoTbL+mS3cUKNAh6gqrByVJ86PSpZfnV97arB3J4
         uiK7S10p3B6Prk2eHKeGlnpMU1TZquyhEdwD/O6iPcba8xVJuoDkd9ladMKTgv679Yzh
         8iWwcbB8g8L76eHbbbj7uM3+KZHqV5WXJAz6Lj8zRXJJley4KFPLC5WQSugiRUmbX9sC
         g8hFc8OyKyk8ti0uobs78hfC4tUp5ks3PU+BRFOI8cKnHK41CgHzwyeoGNdch+9EVVx3
         trpTWiTZR1T2n++TrEZSxsTqe1npFq/l4TXtqFioPpi1o1d1W2/BrpqYEUoYwx9LSf2W
         ZRhA==
X-Forwarded-Encrypted: i=1; AJvYcCXDx2ImOLO4q1rfUFdtLss1wh7wGUN4sjTWCJuTVyT29KUwYnLLD+d2m2S2cJIAs3ioAdHa3uYdceiF@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPi4KkjV3EnOAm00y6qoICiIzAJ2l8w4LgeFwlBPOqvFs5lAI
	ZZEVa+FRT2dDb/KJlZkEJbZLnZjrASLDNbeTWZIAWZS3dBWbnbPdluW89vdUASnPkT1ZUtB1U7J
	CMTJ9xA==
X-Google-Smtp-Source: AGHT+IH0RRSVYSHdzqRsS3jC+mFgUIcbG09ZSbg7g2kf77f2a/rn4tX+1pU6Yr2GY9rW+zyHE7U5TQ==
X-Received: by 2002:a05:6512:3f10:b0:53d:a291:d785 with SMTP id 2adb3069b0e04-53da291d7dcmr1521475e87.41.1731517072645;
        Wed, 13 Nov 2024 08:57:52 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ecc6sm7351089a12.69.2024.11.13.08.57.51
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:57:52 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f646ff1bso1052095366b.2
        for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 08:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjjza6OzPn+AEau3C/HYzIUejyylui0Bnwi8yTAFv+AYUjiZYN5x5J5NlqWlGH7rgx845nltRbgQVm@vger.kernel.org
X-Received: by 2002:a17:906:7308:b0:a9a:3718:6d6 with SMTP id
 a640c23a62f3a-aa1c57ffee4mr725890666b.58.1731517070805; Wed, 13 Nov 2024
 08:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com> <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 08:57:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
Message-ID: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Maybe I could use just this one bit, but together with the existing
> FMODE_NONOTIFY bit, I get 4 modes, which correspond to the
> highest watching priority:

So you'd use two bits, but one of those would re-use the existing
FMODE_NONOTIFY? That sounds perfectly fine to me.

             Linus


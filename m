Return-Path: <linux-ext4+bounces-1553-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901568733F1
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 11:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FD31C20C04
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9D85F869;
	Wed,  6 Mar 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="im4VRYw1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71C5F85C
	for <linux-ext4@vger.kernel.org>; Wed,  6 Mar 2024 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720511; cv=none; b=EbFn5/KVYISyNkwMHHrW+uSwebjC4VffExAU0p+Y+GyAf/8YYh9rDcHPldXIk6LX9UP5jksCeBQmvMM9oD7g9VasD/QsHc6b3drJUe7Ok12KwB9uBnfuzx2B2LVEhdNJzTSLBUZWMUvSbrgO3comPZZcDUJEkdquL2DRfG0l+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720511; c=relaxed/simple;
	bh=islZpyKykR9dbsXwEOJijkuEqDtFWjDv6ZULlFXB7QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+riqjA4k6lexVausa2Ukb8gnwFZ2KwGYDyCFrMVo5P/JuYbLGl4OqGlwL7UYZkwHi1wsqYXvSfcRdvkzHBlhIvFPE4HGr+EFPlUz/Abr6QVww2bzNsFY1tj7p93q/hAsIFPApdXZ7U3VkBFmccDgatnLkucD6P2P7tMDFH1FmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=im4VRYw1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso120377466b.1
        for <linux-ext4@vger.kernel.org>; Wed, 06 Mar 2024 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709720508; x=1710325308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=islZpyKykR9dbsXwEOJijkuEqDtFWjDv6ZULlFXB7QI=;
        b=im4VRYw1MPoISNm0Ckq24et4DqwCzZbCy8miBxT8XvvjMlTL9filJZMf6yEiG63aM0
         8uL21LRRe0I6TDfZkFs7BjVZZepVfSOHHTmWRhY9fI8a/FFYrF5r+7Qw5MLw0t0CVPgx
         sgHUkJ+2RRRxc/Ho556q0yMV23QSIkn6qm1J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720508; x=1710325308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=islZpyKykR9dbsXwEOJijkuEqDtFWjDv6ZULlFXB7QI=;
        b=wF2kjxRbSNqWf1lJvY3nlxu/1S1VMzUOWLz7OebF8LV1ICJ7MJyeIl9Wq+FhAd9mzv
         krAEOb/OJSqaBhc65+Atnp1m6lVsps1mFjhWVWWsuiSTHRYPo1xRq+Pw+Pgx0MB8Ar5T
         d8eQQQ9UT7IJXZ0sey5HTeSNY7uUtdIj1Zbwk/Hm42cMPhzyB/gPyAm5/a2t978WX73P
         pQZj+1QehWxVcOWgPz07FfjqQE8B14QGm0diDlZRqMzFudlJiRrAtzgr1z/EFoWwpHHb
         3jZp4yjiq3gUvMSCjrdDS/wgZRAmfNh8NkR2APwk2XmXv/F6eCMnspcemr//rjW/wRQY
         8+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnL+g9+M2JQoaVahwVfHmtraXK/9nVdFzQJoOdGuBInXz3HCoNzVLPKaGOOj8rPOQ99tzqD7Ck4fBqTSgKOTMkqTqlOdHUm7O8eQ==
X-Gm-Message-State: AOJu0Yx+iXT85GE0/UbTDTP9kvInv3rGerUzrtbbvk3XsNHGXO55KseS
	WNrDdvimck3GNb0de0609pQUzf6/d1zYGbBj6PX1a3wcbt1xJHxjrSAfQcDO7G2WGhy8xy0OXbr
	EJ79ewGvXJg9tluKHmDr/ll2T9q2esaQ09tPrjcc6Qe1lBhYV
X-Google-Smtp-Source: AGHT+IFMx3l0hAdHQXbl39ioAGrKSQLW1v5lUEssZi0FdL3yGMLYZSjp6aM2eVuXdZXGTZOl1O5Fgiy0ny7XY06f99Q=
X-Received: by 2002:a17:906:35ca:b0:a45:29f3:6cc8 with SMTP id
 p10-20020a17090635ca00b00a4529f36cc8mr5960498ejb.8.1709720508210; Wed, 06 Mar
 2024 02:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
 <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com>
 <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
 <CAJfpegtQ5+3Fn8gk_4o3uW6SEotZqy6pPxG3kRh8z-pfiF48ow@mail.gmail.com> <CAOQ4uxgi8sL3Dxznrq2tM76yMz_wTxh2PLzMd_Y-8ahWAhz=JQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgi8sL3Dxznrq2tM76yMz_wTxh2PLzMd_Y-8ahWAhz=JQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 11:21:37 +0100
Message-ID: <CAJfpegvdt_FDpsgJ5hb8r48r-NoxUn38p=-EoFoV5un7Hm4hpg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:18, Amir Goldstein <amir73il@gmail.com> wrote:

> If you move fuse_backing_files_free() to the start of the function,
> I think merge conflict will be avoided:

Yeah, but I don't think it's worth messing with this just to avoid a conflict.

Thanks,
Miklos


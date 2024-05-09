Return-Path: <linux-ext4+bounces-2417-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDA8C10FA
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653902830D7
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB915E5C3;
	Thu,  9 May 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cFE+pOE9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C415CD7D
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263816; cv=none; b=KdWCPeBbAJosksNiHTPPsxQ/QiqIRXeSmf10hSj8HkkNnGAtD68AHc5hUl5pAiQnwEYGgmyoqmW8w4enOZhEzuwwBHC/TkCouEJY4YdU/yQVBOtjLmsQt8JdT84WpQvuKhgozL1zGFMF7hVD7Fd4Sv+QipFtRqfOIjAVFEOvEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263816; c=relaxed/simple;
	bh=y+IeX9NStckPkhxJt4hLlrr6lHDP4HAslq6+x7ejDjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx6ASinVFrceXmE6AV5uj9UNAwnrBjeMfr6lbutIEIW4/n9wIyWJoQMk+b40uiwKscKI/xoTuDZzNVOTr3mBaUOvhQvknhKAVw1ztqgcE0T6OHn7lX6wr9P9r6HKONxcQRDI8qv03DrtgPYNWmTZSJ4sQ8mnqpyMlZMo6zTcBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cFE+pOE9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59ce1e8609so356771366b.0
        for <linux-ext4@vger.kernel.org>; Thu, 09 May 2024 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715263813; x=1715868613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+IeX9NStckPkhxJt4hLlrr6lHDP4HAslq6+x7ejDjU=;
        b=cFE+pOE9L2Ei7YAn71/VuH8KXU7FP/Z6bGd6Xnp2m00NdiEZzyBen7BnukGvRvxESP
         pkzik6p9/Gtn0Da51jzaYDUR9Y1vY+SdH+MZeocsKT/xjlTYiDaq9XYOtrjWgyaFwxcz
         HHh6IYVuB2xU7CeycpjLSqQ974DtcYNhK1PUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263813; x=1715868613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+IeX9NStckPkhxJt4hLlrr6lHDP4HAslq6+x7ejDjU=;
        b=elCgZHBIa5KOIPQaZdXF8fm+lx0b93q0+UrKeiq4KZmcVSoBZkHJSF7rt3XvRjm69g
         MIBJb1rjvzsPP6RxC8xpE4JwYOsZUf+h43NqitNV9F0Ad6pwr3AWWJg47PAmwx/Gci37
         0iIWybBzpcBz28HG+ZAc4vXn680ESNcfr2IBBs6lzebQSEC3tk2LcO0/7P2DJxLeckiV
         ZXd6rVL8IfuE7nLlXOH5yCwB3mvCmNe6bH5AZAegyguLFfmTlxuMGmMZJLrw6kM+sghC
         SbVa6xzenGpkUV64WMvdMqvcbiA11H3Of/QREljbQDAPcrNk1K7PqcsYj43Hvdwt5q9M
         U2NA==
X-Forwarded-Encrypted: i=1; AJvYcCU5BLGfdNoJ27Tn3ZVTHshTc/JB+wPsTX7dTi9a9HpDO00Yp5oxLN5qt+vWF6KenGLH50z9lnQ9tWEvapOyE4YPQuhu2J5PE1bUXQ==
X-Gm-Message-State: AOJu0YxXlx0zv5BqxZO+MGfqSO11gHbXve/429Qc57YwO2qaoOmO8gCT
	E30lX3pP1S7KmHz+h/UXaT9NSTyleZdPy0UumpexdCM5gpZ1UomT6SvJFCvRICHM0+l5b/RoJQU
	D0LPgk9MBeHIZMugjPKX0K31wugDNhV7ity9hwQ==
X-Google-Smtp-Source: AGHT+IFHGBKuV/1bvWy2Bm+fh2O34AZD8OxihJRS/BuyC/yZLmKQNTC7aP+veqoyaewftuyi1/G/oY1zcT9XdKrL3mE=
X-Received: by 2002:a17:906:7c4f:b0:a59:c3a7:59d3 with SMTP id
 a640c23a62f3a-a5a1165d1d6mr247358366b.13.1715263813135; Thu, 09 May 2024
 07:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1553599.1715262072@warthog.procyon.org.uk> <CAJfpegtJbDc=uqpP-KKKpP0da=vkxcCExpNDBHwOdGj-+MsowQ@mail.gmail.com>
 <1554509.1715263637@warthog.procyon.org.uk>
In-Reply-To: <1554509.1715263637@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 May 2024 16:10:01 +0200
Message-ID: <CAJfpegvc=RsmozZCcp+cqMFxo0qR4vv7xT9owc1Epe9BR+zA3g@mail.gmail.com>
Subject: Re: [PATCH] ext4: Don't reduce symlink i_mode by umask if no ACL support
To: David Howells <dhowells@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>, 
	Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 16:08, David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > I think this should just be removed unconditionally, since the VFS now
> > takes care of mode masking in vfs_prepare_mode().
>
> That works for symlinks because the symlink path doesn't call it?

Yep.

Thanks,
Miklos


Return-Path: <linux-ext4+bounces-1591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03828877E68
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79234B209B3
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000438394;
	Mon, 11 Mar 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nb3iegMu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418EF210FE
	for <linux-ext4@vger.kernel.org>; Mon, 11 Mar 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154398; cv=none; b=tVdbW9MBYIvkIb8KRMQiOXkw3dN+ifiLcIL+zomQ77r+8JGmpmcJ8yyxBn3Gc790Q39pKp7c/XDa39isst08YtLlNk1yAioz4Eoye4yVuK7VLj7dLRbewYCmmHxJqrRNRxGu4JU97VTFN5eJaqatLMNO5gNqdWMZGfYHej+flAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154398; c=relaxed/simple;
	bh=eipSaXQDNaHiMVilLLD9++N49oSdVIn+KRPI2kRYNhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTTiTup53i3xlFKkpTMi4oGXpQtCC+iEgk2hvt2sznxRb7+ayi527xvXGz+jM00xxgXmjAzPnemqCkFHGkA5sTZyqREAFdaSUcvpzZifXw3dyEWyAGJElPrOTFSi7P4O/Eq/rUqCSdrrcIhfc/BiSgy36wMa3VkOOAsOi/5YlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nb3iegMu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3122b70439so528970366b.3
        for <linux-ext4@vger.kernel.org>; Mon, 11 Mar 2024 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710154395; x=1710759195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i2dfslh5QDNZ/Ge1JZNCE0iFX9bHyhSCqEH3cMk4dhA=;
        b=nb3iegMuKAyOwVme6oxxWajgKvOOX7Dy4rdx8xeqY9DWXjDr1J+h6b2Qnb2mqyvCOo
         NuiEOjPF7+BvpihJYalva3/mW8NLyYoKSRjIukhz9KUVjU6r6aBGTJVZT9T31LVEw+Np
         AjuSdRl6kdsDdOIWG3RtL0lMMUbi597WFtYnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154395; x=1710759195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2dfslh5QDNZ/Ge1JZNCE0iFX9bHyhSCqEH3cMk4dhA=;
        b=uw4p7j6m/37p6VNJ+hQANNqqGlHLiQASr8BGRDA8bLfjKfuh+osYZaozrXYiqgMsXF
         2lXiL1aftL6sipjNbsKNgV9q6Yg8VCOdrwiK4RIlvhrK23wVbcKT6zEUReH7sCf7XI5y
         M7MQwoK+ERtkgwEo7YoF4H8TukhLQGAj+PWmMY/gpGk9W7iSFKJZWRmfxVER9R7yw59I
         HrKFNrOQvkh2gIkqkYLx0uN7AkYZhRJGQXIjUdBt6MMBMmcePgYYtIESXLLFTbr9VXVW
         +kn6ewn6OEAfjS+KyZVYjaq2cxlV/LwekZ8pTHcIwPydVkGVfvuX1Wj0nqjp8Pq22ElG
         FcMg==
X-Forwarded-Encrypted: i=1; AJvYcCV8qrFjcAts662yHKJozJvK3C1Uvu3NCDjx+ep1XJDqG4ftuSfxH8TrNzr6rA4WTOkQ/EIiR4M0J+Y/KwsKmWYFsvxqZzpwGeiOkA==
X-Gm-Message-State: AOJu0YwR1Cibp+C/vDkzqaIgDS1KC1916Te6iUm3su+50R/tiX3dLXbZ
	9iBnsr0JaMRP1qMY6UOJJN4hfCiJn22yHNYKZf5cSsqtbEKMnp24kp2mT9JGjbpMYO4/Af0w8Bt
	9G8KkfWzUYASJRp++7oT9J7MXKTVzGMu5iH/Cyg==
X-Google-Smtp-Source: AGHT+IGrhueAiqHAAsjZ28RgNBvcuE2K3dRDxlPYHttuy9/oDJvWikA5V55Q0CYuFb4STx3zWkEYO199sE/YQ7Tm9lA=
X-Received: by 2002:a17:906:f209:b0:a42:615:1395 with SMTP id
 gt9-20020a170906f20900b00a4206151395mr3478723ejb.11.1710154394689; Mon, 11
 Mar 2024 03:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307160225.23841-1-lhenriques@suse.de> <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com> <87le6p6oqe.fsf@suse.de>
In-Reply-To: <87le6p6oqe.fsf@suse.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 11:53:03 +0100
Message-ID: <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
To: Luis Henriques <lhenriques@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 11:34, Luis Henriques <lhenriques@suse.de> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
> >>
> >> This patch fixes the usage of mount parameters that are defined as strings
> >> but which can be empty.  Currently, only 'lowerdir' parameter is in this
> >> situation for overlayfs.  But since userspace can pass it in as 'flag'
> >> type (when it doesn't have a value), the parsing will fail because a
> >> 'string' type is assumed.
> >
> > I don't really get why allowing a flag value instead of an empty
> > string value is fixing anything.
> >
> > It just makes the API more liberal, but for what gain?
>
> The point is that userspace may be passing this parameter as a flag and
> not as a string.  I came across this issue with ext4, by doing something
> as simple as:
>
>     mount -t ext4 -o usrjquota= /dev/sda1 /mnt/
>
> (actually, the trigger was fstest ext4/053)
>
> The above mount should succeed.  But it fails because 'usrjquota' is set
> to a 'flag' type, not 'string'.

The above looks like a misparsing, since the equals sign clearly
indicates that this is not a flag.

> Note that I couldn't find a way to reproduce the same issue in overlayfs
> with this 'lowerdir' parameter.  But looking at the code the issue is
> similar.

In overlayfs the empty lowerdir parameter has a special meaning when
lowerdirs are appended instead of parsed in one go.   As such it won't
be used from /etc/fstab for example, as that would just result in a
failed mount.

I don't see a reason to allow it as a flag for overlayfs, since that
just add ambiguity to the API.

Thanks,
Miklos


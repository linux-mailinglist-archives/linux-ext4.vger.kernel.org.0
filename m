Return-Path: <linux-ext4+bounces-7874-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E2AB6238
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 07:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136B84668C4
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 05:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061001E5B79;
	Wed, 14 May 2025 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAVHhVrr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D673EA98
	for <linux-ext4@vger.kernel.org>; Wed, 14 May 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200054; cv=none; b=fulEUpdK1HN9I4vGxnon5zxljUoltIZj2EGITGFfcj1wWtfB+KGi3OR31aGJ9F9b/wU9UKgujdBNQLVIZN7UMb80NG0oq9qkXXtsQu0UuYf/PmDYGF4IeVnrHpriXAQHSHt9iieTAmYen+v635NNenGaJW8XW2/ExXV1x+c1cB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200054; c=relaxed/simple;
	bh=iaSoaw7bB3NhqQPx7C2KU/lCarj17ymW18hvtWU4L/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdwD/0AU7sk5+3IKslXzAWzxcsHzjw6uUjrFTcBmPnRrmuvHVpcl2gfInzvQe/Ma+AqmpvxODNAyEBwI+yGqwYd90AAr7eb9a+b3uUZxyr5lCDbXLDi32S9pfaQ53mMQaeUN25gr8IpVzEsKsxERKgkDhq1j27VB8wzad9wjjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAVHhVrr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747200052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXtBDIE77Q4RcA96cyQfjtM+WgYsnihPBjFJnUlXQZY=;
	b=YAVHhVrr5Z1Fb1VZ+mQzvSNUhG0Zfdu1v5kfG2yUp51A0oxF3aqH5BBJqmgc3zAE5MtMcc
	aGLgBAWaE1z52vXzy1O9tGkZW3ebFiEALCEkfHwCEK1P8+M302UZ8jO/f9Ag0yd/j2fenl
	/mf80J/Kwia+bNb7ppsaQQ15COtPjq0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-aPzOU2g3PlWWSMqtgubEPA-1; Wed, 14 May 2025 01:20:50 -0400
X-MC-Unique: aPzOU2g3PlWWSMqtgubEPA-1
X-Mimecast-MFC-AGG-ID: aPzOU2g3PlWWSMqtgubEPA_1747200049
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22aa75e6653so47537115ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 22:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747200049; x=1747804849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXtBDIE77Q4RcA96cyQfjtM+WgYsnihPBjFJnUlXQZY=;
        b=Z8LXahniRUBhpNkxVnMsVAxXlMTeHcJLxKJHjA2fR1gx13xDhxI0spQPS4Fs4rQAkq
         WNtJVVpy91cbQoHxROCdmhUAo3u8XSsacUkCWukwEaKTSI8lqQwO7ZPBzNogZP4Iz/Fh
         z2+6eyBb0htC8HWqLGNb1aLIymOenTwGEeEo8dA4a4bsX/yuevH7oQBL9Nh9KL/4qMKY
         OwhauBc5o2L5nvB7Ss+f/7xzRxNgwAHd15iq4ijfh0R/PwoyssVncutOJKUpwgdLM1+9
         LhBaGoZpjvdC/wjHt/LBxlf5S3H61Oufus/0ISHiKhDSjUTeAQx+F+fXLpZhYil+RMLU
         G+7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+JzgzvTu4ZJ1Ha3DWK38eYSMj7KV1JQn25Ad3PH5w916I1det5fYpMl4AfU85dQYvmUBrTIl2/2tK@vger.kernel.org
X-Gm-Message-State: AOJu0YzdJNUBWU0EUpIa4I3OtJmjVGXIYNmvhBNPcG+yjIbhxUM9wqcQ
	CrYhxxx6aWxPQz2sz/lX5xwZd5iNuZiYSfFTi7n4Y437K0P/ksJABe6LUdEbtB/UDkGoQibiTPb
	ytlfx/jAAvE3XcQeXIBzOyLPzIxSQwA+FSq/Lu+TcRUv9znbiuJj0wpahJDA=
X-Gm-Gg: ASbGnctC4Tg1McARcgwv5vXnwfQLU0zV8+vgYXuvajFu9RUyUQf54Wu0RSq5J+yKmLH
	kYFus6Yz43t9hlY8DZOgla+1Zs/g0m/5xa/QEKObGO/9OiZNnMY978raEfHLGp8xuUCLccKV1ly
	DKKzwQQoJfsNb012hhmv7fH/aphC91Nkv1qFY25XGSCw6b+Rr2lSSwQJP846EFQwlkeOeFNt5hu
	qIt+fjocbtF/7isUAwQzkMVLkbi/hCuIhTuK/sUUa1//3wgX9HrUf7HAuxm9eY5vu7Fdnx1PbbR
	1LQxSGnw/y1Plnukp55VUp1MMyxlapxFrEeellEnfEfqC9CxNKZU
X-Received: by 2002:a17:902:d4d0:b0:22e:68c4:2602 with SMTP id d9443c01a7336-231981a85c1mr28934425ad.33.1747200049502;
        Tue, 13 May 2025 22:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlx6APVjppTpKolovlnJP7aetqZfQVG8S4gkZTYEsgBJ0KT5TH/IvUnaGF4AlKDpj3hN7dsw==
X-Received: by 2002:a17:902:d4d0:b0:22e:68c4:2602 with SMTP id d9443c01a7336-231981a85c1mr28934185ad.33.1747200049163;
        Tue, 13 May 2025 22:20:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271d98sm89427225ad.154.2025.05.13.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:20:48 -0700 (PDT)
Date: Wed, 14 May 2025 13:20:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 2/3] new: Replace "status=0; exit 0" with _exit 0
Message-ID: <20250514052043.o7as5lxhkzklungz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
 <96ea8b7bb8dcaa397ade82611d56482d79f28598.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ea8b7bb8dcaa397ade82611d56482d79f28598.1747123422.git.nirjhar.roy.lists@gmail.com>

On Tue, May 13, 2025 at 08:10:11AM +0000, Nirjhar Roy (IBM) wrote:
> We should now start using _exit 0 for every new test
> that we add.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/new b/new
> index 139715bf..e55830ce 100755
> --- a/new
> +++ b/new
> @@ -176,8 +176,7 @@ exit
>  #echo "If failure, check \$seqres.full (this) and \$seqres.full.ok (reference)"
>  
>  # success, all done
> -status=0
> -exit
> +_exit 0

Hmm, this makes sense after we have:

  744623644 common: Move exit related functions to a common/exit

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  End-of-File
>  
>  sleep 2		# latency to read messages to this point
> -- 
> 2.34.1
> 
> 



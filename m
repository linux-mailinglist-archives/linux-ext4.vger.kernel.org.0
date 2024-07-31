Return-Path: <linux-ext4+bounces-3577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D9943454
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 18:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B7D1F21D07
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAD1BC09E;
	Wed, 31 Jul 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJHtM0RG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0917BA3
	for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444415; cv=none; b=qYSZbIDdCgBswgfJpV3NSVYvnQkhgnjRYKFAMtBQ63GJyQU0AyH+e+hGT0x99uGkANfaLkk74fLJV5NNAcjkrUKCG2pVguNmqavHI+1nuTzGcRIm5qVSg3/i6iDsT8tbhYDHK0EVYg71M+FPvnYohMq2+359oeTT826E5bSOZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444415; c=relaxed/simple;
	bh=DPC7a/ItVVS/ZUsDBa3A34Cag7H61CGwBsA/cvnuO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duBFs+OJj2fH3kvIci+359tffZepk0d2VJYRAEzTBQ3ZTgd4n2f+Y9q42VcNOpHIISA8aJBZcL7vc4Qwau/LWPHNUut5GIGdSVGUDMcn6F+h8Qr2H1h83E5wC8nyCoyPVNiJbfc/LMmlq3j0PvF0eVDQZ1KS9w1v7EONUcXmw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJHtM0RG; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260e6dfc701so3732363fac.3
        for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722444413; x=1723049213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y17BSh/uyhoM7VykjQAyLacxqXElZzql32CV9WyQ20=;
        b=pJHtM0RGdLn5+O28CzkMS+62BASSYNGIjbh3LTlIWM+rmVD4m/sy+flHKKJvMWNNdR
         0JyVBE0aA0oDIZute/5Wo+kOyfhU9UUVxmUUqI2+ThmVNwo5JrJkXZ0/pNx1Th+AYeSU
         oKvYKE4izz4lL789eHTT2PRLUFu41SB9wAIyIakwXMxVOORt+gBfZz/2FTGs/W2HYGDb
         +RnVS/3jzVGKEpjtcuEmNmzDVlwCiFmAd7YMCBegauOBOB61ojDwvOPvkA/UWETvGCCw
         1dMEVsYnYYc7GLHfoTSsbv3P8OSCKA7tIoAkuijcvoxMrZ/quL4eu8lopXXM+Ro20z2z
         Ui6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722444413; x=1723049213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y17BSh/uyhoM7VykjQAyLacxqXElZzql32CV9WyQ20=;
        b=X8uLI+TzKWAEd+RkcGcEAyKGPvwEQ/RKectga0qFO47NrY6S+r4+90GkECULLxvJXW
         gJ8BUFdB2CxD+A2EpIilL5Lx9KsEPMRtPz4QJnHjtygF2on9FqvhxOSwZwWaNMdOv6wK
         IHdwhqsVytSr4Fai7zj8asO+OW4jX25+xZjmhOi6RAVDeXiGOxI5TwcHFfpRjIim7OXa
         HGgZ3sDO0m4pB0FlnNEax6h45nHfKuCSw4atW01FZNVIcA4ZKflcldKvz0B2aNVHwfz6
         L5s3+RnKlC0fjHtjhG/2mJ8n2JketlSKIJsb3V+iVeYufFpmutjlOBx06ayNHux0MVxM
         UtxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXipuj7TbIrF8lseJvsjapfPgn9cqJOGjI73zM1Ex38fzJOA+7rBKj8ESE799OSsRUdFP5kg9BUWmr7wvHLbW1YPEkT4Ur2InfSjA==
X-Gm-Message-State: AOJu0YzuWlg3uJdUYwqn801b50sok21ItO8sOK+z8C6GEqmbFj/WfMlf
	fLIyLWJQWx/e4XV9XpySjOoAUxIfRnUT7PcS3KEipz8PE7sjoLgF0q95Wn9FEpc=
X-Google-Smtp-Source: AGHT+IFRqHHmQ3zAhsmwrlSOV1mFp0GjcMDmn6Si4PesAAvwXnlJVIJpEu0YlsAaasZvPrDHo57arg==
X-Received: by 2002:a05:6871:aa06:b0:267:e2b2:ec52 with SMTP id 586e51a60fabf-267e2b304ffmr14807007fac.49.1722444413477;
        Wed, 31 Jul 2024 09:46:53 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:c572:4680:6997:45a1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-26577239eccsm2721257fac.53.2024.07.31.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 09:46:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:46:51 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
Message-ID: <ea202d37-7460-4e45-9e19-6a2b23ada0a0@suswa.mountain>
References: <20240730151615.753688326@linuxfoundation.org>
 <CA+G9fYuGGbhKgt6dD2pBCK1y4M3-KUhPZcw21gYtUFzQ32KLdg@mail.gmail.com>
 <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4543e3-53bf-4e2c-8a3c-1e21b9cfa246@kernel.dk>

On Wed, Jul 31, 2024 at 10:13:26AM -0600, Jens Axboe wrote:
> > ----------
> >   ## Build
> > * kernel: 6.1.103-rc1
> > * git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > * git commit: a90fe3a941868870c281a880358b14d42f530b07
> > * git describe: v6.1.102-441-ga90fe3a94186
> > * test details:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.102-441-ga90fe3a94186
> 
> I built and booted 6.1.103-rc3 and didn't hit anything. Does it still
> trigger with that one? If yes, how do I reproduce this?
> 
> There are no deadline changes since 6.1.102, and the block side is just
> some integrity bits, which don't look suspicious. The other part this
> could potentially be is the sbitmap changes, but...
> 

I believe these were fixed in -rc2.  We're on -rc3 now.

regards,
dan carpenter


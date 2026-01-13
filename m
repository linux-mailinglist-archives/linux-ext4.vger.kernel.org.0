Return-Path: <linux-ext4+bounces-12797-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40785D1ADAB
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92ECD3036B89
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EC2342CB1;
	Tue, 13 Jan 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpXDyFTc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB018313E30
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329238; cv=none; b=fcRWqSISn4YQQpQjN9xJFVuCnWaxyZZNj62MTgiaYeuuFhQmSyezTh1U253sgCPX3OxlWMH3eRnt2yVUMKsFqVXqNBwdygZdO3A7CbLgrKeIrF6KpBTzcSRP8xgjVpCbokB7c9e29yR5kD5/KiyNikcaR+OdX+lMCFTJ75VgrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329238; c=relaxed/simple;
	bh=6wclnzskG/ZNUGRCGnmIpcaafQeAFLYeRrSPFRj2hqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieI7OQrCDPUZq9m3IuhaIcpQxA+OgtfSdKQ0JuHl7eLujqZYN8wBA/DQQjBBjdb38mwhh+VeO/rl5Iy7HxfJApRKA+ypjvIsKv8TXS08Sj4ehOv5U++WQmz24qtezoYVXOT8hn333UZYUFVNSWeyAS2vJ0JjshP4ZQQArQi3jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpXDyFTc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso67175275e9.2
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768329235; x=1768934035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vD1n4fofwsxFZx8Y9vmmRRviFzIkQGtDaZlhVkXmiq0=;
        b=fpXDyFTc8V6sAVOSDINivucVs1f4NXdjVYCAxga1I5uBIi1ZWxwLWNjyILra1ili7g
         xvlgd2n76SMKRu6tg2+xoWJ4UbTVsY27n1hae/ziMsk5z3zVif2stqQQe2+HTy3sONEt
         AmXX3HGBbrrKwaDrpkFGYrmj1LziZmAXi/HsB5OhBpEPtRDandzpixZ1tG8qr260Tnrq
         bS9H01/oRXM4bN7F3ZxfM6dS6gu4UA5eZsUJXZ4AoxAWf9zqGZ+QkcT6ucC41b4YnDnS
         f228iaceH9Rc3GrlUcIQCKOycY3pSqBijd9+B43GrASJbFhhq3Kck4GS/+o7cM569Xh9
         WvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768329235; x=1768934035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vD1n4fofwsxFZx8Y9vmmRRviFzIkQGtDaZlhVkXmiq0=;
        b=A9RgwnJTuzn/gTdg5cTk0B8EPkMH5p7d70hIPVh0lYMNwX+Fk8pKBagKHEyHFHA2wQ
         syGlfv7Okpem7GuEnhtj0DnK5Bm7n1q3Ut3kESItBjnHdP60HYaPiH8of7Ao//AgSMJ+
         o8lIJ1+bMrBRKjc5bW4Z0JT2O1nNozX24NWC05jQfJunFeHf3pjcj9doPrQGaFmNR89E
         gt8tSM/gr5YMZJ5OaTUOHu2jD2k38Dpzgy7+SZexrOqk50fcL0CeBq4MTbqgAMlghpoC
         iIAJj2Q7LR/H3nyaL7CSUxdgbnKF7Wx2qdqcE7YdfApDR5Dsbf1fNN1ig/m/wiBHcpe5
         K5HA==
X-Forwarded-Encrypted: i=1; AJvYcCWFTnP2EHyiZ3gQu+j+26YXHxJI6/G7+oXdJ496jK56l9G8SjgHxpy+2RjV8gXBRWJvVNaoUdlDmn6S@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nhpXjipq0cg8UTP8zAAH8VilRgQa+7a5HpA17bCCAPhTlsIy
	pK6wgyR9QGswDfzed4ftu8Id2J0uZQwJ2zA/qqqJ0Bdr4bqs19H3RZTW
X-Gm-Gg: AY/fxX7WjXfLE58GWd8wkyro5dLUqr34afWYeaiEfwPJ2Viq4eeaKtegjyp6j7pV2bi
	OtC87eBdJ6C7iWx5MNWRUM2Cn+P1pWVuHq1jjXFhM0ZEbtGQtKLZbv24DGmm/GYI+5Tdwg9J93W
	dkNZ4Qggin/pP2huFQdaSKf9sUv7GjeowuJTLSZF+JMU3N3YiZieHzuWgUurk42On55RsRr9RNF
	ZvSCvdQ4QQAlOT/yH85O4MOn5VU7KLuiAJE56R/7T4f593YSrsfHyLOFBolyUP6pK1N4KIB/X2E
	9BG+C3qL5WUQIpphtIVMs/LEL2zsezDkBL1Df6A/hFAoxQlAZ2sPxluvd12xgtLT2X2NH8FrOC8
	BH4WMuVQxq4EKWRbvd+5k9E8xPplPOb1D7VRQU4EO0yKb5hwaCllJs+HxwxyTKikRSR8pZuDOLZ
	cbqKEoVM3c9XWJA5vnEGD4VAob45TmiLZuv/RDwySI+xUjGfH7tXEcEBc8q0d6VcE=
X-Received: by 2002:a05:600c:6386:b0:47d:403e:90c9 with SMTP id 5b1f17b1804b1-47ee32fc6d8mr1578295e9.11.1768329234806;
        Tue, 13 Jan 2026 10:33:54 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e802sm426004125e9.8.2026.01.13.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 10:33:54 -0800 (PST)
Date: Tue, 13 Jan 2026 18:33:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <20260113183346.18ef7c74@pumpkin>
In-Reply-To: <62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-31-david.laight.linux@gmail.com>
	<62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 16:56:56 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > and so cannot discard significant bits.  
> 
> This breaks an arm imx_v6_v7_defconfig build:

I hadn't tested 32bit when I sent the patch.
It was noticed ages ago and I thought there was a patch (to fuse/file.c) that
changed the code to avoid the 64bit signed maths on 32bit.

	David

> 
> In file included from <command-line>:
> In function 'fuse_wr_pages',
>     inlined from 'fuse_perform_write' at /home/broonie/git/bisect/fs/fuse/file.c:1347:27:
> /home/broonie/git/bisect/include/linux/compiler_types.h:630:45: error: call to '__compiletime_assert_434' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
>   630 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> /home/broonie/git/bisect/include/linux/compiler_types.h:611:25: note: in definition of macro '__compiletime_assert'
>   611 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> /home/broonie/git/bisect/include/linux/compiler_types.h:630:9: note: in expansion of macro '_compiletime_assert'
>   630 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
>       |         ^~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
>    98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>       |         ^~~~~~~~~~~~~~~~~~
> /home/broonie/git/bisect/include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
>   105 | #define min(x, y)       __careful_cmp(min, x, y)
>       |                         ^~~~~~~~~~~~~
> /home/broonie/git/bisect/fs/fuse/file.c:1326:16: note: in expansion of macro 'min'
>  1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
>       |                ^~~



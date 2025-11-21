Return-Path: <linux-ext4+bounces-11995-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741BC78EC4
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56A614EA4D7
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7E3176E1;
	Fri, 21 Nov 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVAlzrvq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366082DF6F4
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726376; cv=none; b=M4sZaub93IMvu6+a7nk96WDkqfcxeEUIhF/0JHgz+bq6cRcegKyyJOCwmnKx9PGI4XA+sY8aoCQipOj+xAnOymRdjWD3w64DBxfBLbeAZ/iSoHsN7eTpoM4Qt2JtuuX4UYur8aq5A/Rp5QXs8fUo/gZv7Z6TgO2E+XPLDWN/nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726376; c=relaxed/simple;
	bh=Tge1dpOQNIViRaRkvFrR0hadWsD35vB90mc9bl7lemg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaXP3lez17XIaC5WvIQCtBdjOnGgj8INqpbudG/krlw2YX5oiYR1R6eJCjjg6u6ejQXztt/xQLXTVqCKY+pAts3AWOVOM3kk9Y1bGwsk4lDhCEOoPRl2w2C75G9vGCRwPnkDb26NQE42qc5qVzPuI81oFMyG8B7WP5/BvQw6j8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVAlzrvq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso14018475e9.3
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 03:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763726373; x=1764331173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdAEfCRG7LYbXV3n1fnF3mp3pmfGB4hFtYRv7a4CSFU=;
        b=OVAlzrvqcfAfdND/td2zGFPMqGYO+FoHf4FjoC8ztFVemfkHrHjOErIDz0CThDcayP
         0mNS4kYpgwoFJOgGCVpjebWUqk2oc1rUvV0hczRtmd/+KHZrErf0ZYs4H4gFtfW9uISE
         2WK4tBBhIDAgJTKex95z7FnP2Uo0BO+qen2sMPx4+D4DkEv+tDNZvuo+oV41rhyDLzXy
         Q6Db/WPJ5i2AcnQrG9l3tRBKEilOztKnS0vme/0AW/tmD1/pKEOvIH05VMHD67OQPXp8
         aEGghWuh0FrTdmDf4EGGKwDz/z+TMywy8AQEcsLUosMdn4CigMkzFLsORu2CpxR9Luvu
         UZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763726373; x=1764331173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdAEfCRG7LYbXV3n1fnF3mp3pmfGB4hFtYRv7a4CSFU=;
        b=esfEiPdp/dAIY12+eaDERKPHUtVCEQc9gxB89mVrgV17Xta+SH4mXFXc4t2woeOlqg
         Cvg8YvxvW3YgcLfuKGGOtckmsOmNmXWVZBZtgqdSLqrXtovuSE/eu4WGklQojji5xbYp
         9PD8hAeP/XaUHAlTkP9vlc732u0c3NTH/9mKBn9U3DR0TbkyXWhJeRm2tYYUw+aZgQKw
         cc0tqJvlbpZ84Qp01XY3Ovdb67Ea2zgx+JhVFwUVVoLMMax/CNHeiUtM9FeMSCN4mwqT
         7OTZIrbyD2lufhpU9NDAVPEJEYcta6p1P0Ta+32TCiVM15cfW67Z9PKWqU65KX7cCNX3
         pxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9reQLtOfTtclIV8cLoisyu6A8pYqL5K1kEp2/TXsF15aCsOmdE49BTzRgbkO8tMxi8/FwVUqYnaEf@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIBKJrTXue1c6XqaV/uI7zDFbwrVy4EgwAnGpb6lZrF0HNODf
	pNpF+n9+tMx+xdpkrMl4dKFMle8bYDMa1F0HBkHAvUK3CUneK6Bj4s0h
X-Gm-Gg: ASbGnct1Y/0FeV377/di3hLQoGNYYR1S7oQ7+rGSYCmPB0TtGB9DTxYf5mQ+GzangVp
	KUjNdHKaJKcEWwuKQLSra7l9g/LrvSnCgtWgcFKbDukA5i6ssR8+YGHHs+dM2DwgNSA3zHwwlUt
	z9UHxBo8ybmJRBOlWO1Y3/ebls3BBx0DaAZphHqjZIc+Z5cbPjVjolG7V3RFYBp0d/2OY+705FW
	9XpfN73zmszFbrNeRBDEC5MWJYOFr2aurx6r8ZFkbrxR4H0SNMTG4pE7CnifOBzJTwz6RjTyyOC
	uK4Dyl3MHPGTA6MKA3nso5oW9nPqfSkqyNsfS/3NuTE1L4+pf1H4Qa75FBQnabqO537WU5QeaH9
	Sm6Q0atf/CxZjr38IzoIz1g0t/+ElFasrT/a+jBkzzHySdteiBS8aMF++AtNwDKK+k3w8B090l8
	K8neqwkS8rcamvcxqYAKELdZ36IhdAl+0Mz3EVriLQi34OelhOhgRW
X-Google-Smtp-Source: AGHT+IEXB0RB62gXSzOzEV+4sONTX8HwsLR9F+MH0BZ/CexDYl5S87COeJ8BmSIVYwhp+H/hd0GvZA==
X-Received: by 2002:a05:600c:1f8f:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-477c01eba39mr18354365e9.32.1763726373122;
        Fri, 21 Nov 2025 03:59:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3b4c13sm39025065e9.13.2025.11.21.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:59:32 -0800 (PST)
Date: Fri, 21 Nov 2025 11:59:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: "Theodore Tso" <tytso@mit.edu>, Guan-Chun Wu <409411716@gms.tku.edu.tw>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, visitorckw@gmail.com
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Message-ID: <20251121115931.411ab538@pumpkin>
In-Reply-To: <87a50flko1.fsf@igel.home>
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
	<20251116193513.0f90712a@pumpkin>
	<20251120155816.GB13687@macsyma-3.local>
	<87a50flko1.fsf@igel.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 11:55:26 +0100
Andreas Schwab <schwab@linux-m68k.org> wrote:

> On Nov 20 2025, Theodore Tso wrote:
> 
> > Secondly, it's not that a promotion happens before "any" arithmetic.
> > If we add two 8-bit values together, promotion doesn't happen.  
> 
> That is not true.  Integer promotion is applied individually to each
> operand independent of context.

True.

You can think of the promotion happening every time a 'variable' is
read into a cpu register for any operation (including an assignment).

Similarly every write to a variable discards the high bits.

	David


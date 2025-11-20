Return-Path: <linux-ext4+bounces-11945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B95C75896
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 18:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EEEF4E2164
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA033D6D2;
	Thu, 20 Nov 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljfSpvoe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300333EAE5
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657909; cv=none; b=uiE69aivzfr2q5UWq63QRPx/k+XT5K0MhLDacRY/DHLBrgD9rbGiI42QkwW37z0MML8NxPahXmND5zozWzys26wH+T+/9VF2u1uxDwW4yja6dtfsB/l0lnrYpsiCb/LK5o554VQ9e8EI4uom4/AHkPpVw2x2C/S4Nzbkz9TJpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657909; c=relaxed/simple;
	bh=WFzUcNhfWCsgFc0gJ5dxP4YdAHlkxA9RtbOQ+OA7tsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1jhtitRsSjdTE4cEdaqAyjr/LKRuJemggDGKshu8stJNL67byVGNT2HNyM2jxxQtwdWVD9hOe8yJeBYVJB0uWzhKWusHUgmKojVkhwu53Q1qlxBADcT5Bj27ADH85+pZ+rFLNvKXGosbudZndlRsXvlN8a4BwvE9CBaQvlP8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljfSpvoe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297f35be2ffso17087185ad.2
        for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763657907; x=1764262707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pAUx4lPAAt5hhocIlS3eO4JgrnznXmHn7pMUp71lriA=;
        b=ljfSpvoe0N3NQ8erW40poK901HjpCCTGcn8R5o6kBMJFFETqN+jfrgFJ9rtxLQ6RJD
         uTb6E9AOnoT0JWpm5HZVzD9uU5QZs9FI4nJa1ONfqhgzHO++WEtxh4TyGvLRG1i+c+Gm
         wI1XKyv4WTrQHTSzELx56/BG0Dj5MqJiEF2e1ukEV/buQPEYWUcEZ0/myC/+U6kKV+61
         duJHiLqz9HdReM+m9iyHeslDzwfyQhNEurRqFIYG+lEF8wNUzSiyqqsIOOtf/gIZYq0Y
         0gZlN4DsH2fcMDGPlWUc9t9ef5xJcK8+1twIUNBFoAyd4yFB8HQLX+8k/NJI1Mbcp3EV
         UykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763657907; x=1764262707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAUx4lPAAt5hhocIlS3eO4JgrnznXmHn7pMUp71lriA=;
        b=rx3bSOSsSJvGohCllFSYmTy6memsw2mbngCrUcE10oXC1VJTbe+jgFy2uX+YLBzMUn
         0MHDW9aCtUW1Hq2YF33OHnW9D1djIOJv2gAa7aosAs+69hCDDOsDl0W6dqa7Rxx1PJir
         5TAUHvSMstxUDl4tUPx8AX904razVp3wCZAhlL0I8eEsiutVbPJRJiFHf8ofocWlzMRE
         TonulBoQc8EnTOFGxwfr4She38pNNteY2XZxpKjjhwaAmyS3q6PMoNqed7Ig28FzXjjx
         d8bsJPHIqO0ezSfy3cYpj2Ww+yFjX8Mjvy5JXCkGvkO2w4h3h9UtyOcao6HTkxR5aZiZ
         KyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1DWoWGiteNtkCF5TwZtAczzumkYgJmCkoyw8SrKDVraNZWzt9lTdGkOVAHQBxvnjbQes9y4ujuJSt@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQ4DNNxqa7I8xISEIcRugACRs6St1mbwKbdXHQDqxGcnoa6RE
	NvrhUAw8TdEp3Sw5qcMTZImoNVq7P8Ix8SUVyLJUkl/Q/eSwYOX1QD+D
X-Gm-Gg: ASbGncsLsDZdrmVvIbYykxaaXn8R+ZY20n/OTk/yKAfSpqynavBsCOwuxsxOgKdPqBZ
	RkMW8aMJxjv56lLgIMWiLYrTbOA3M/g2rEUkGnez/DCcOXbwyfMuNvaUtSmYKiPNDLXq0+Kk5bL
	QCQ0vJNf6Mn99CMST1jkPsSlxtY4iqgTtgAgo0Dl1t0oeb4XKnMyOTQO28hw4lLJqmUgZcujAPA
	R8LTHITaRyIxo7bTSSzoMsDDge6K8+J1kFg7y5Q8WDgMR4KzyMBxWbTo7nceSuBOP+iIppLd2Dl
	oh3QboJLwLqDsaifCMDRfMGr4vVW/p+BfNNXtHX6HhSHn79G0sdM+G0SIZ53n/IIoF8vcSrGbiJ
	K8KySWVkVFbpOTZ11AHRwftPa01oZqKBKjYATT+PbF5bxaq6Ye3e2VnmzH5qRv6DT2cTDFs1Lvu
	dn68xX99yl3FV51SM4piH1BnYA
X-Google-Smtp-Source: AGHT+IFVjZ8EjTx36K9+Rzy4uZeI4ftPjrsBQ93SSXpRihhu3ckrFsUsfnJvIRLZA67Vz2mAIT3qHA==
X-Received: by 2002:a17:902:db09:b0:298:595d:3d3a with SMTP id d9443c01a7336-29b5b11bed8mr45616265ad.50.1763657907052;
        Thu, 20 Nov 2025 08:58:27 -0800 (PST)
Received: from google.com ([2402:7500:499:ceaa:a749:91bb:2939:6694])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274d39sm31879535ad.77.2025.11.20.08.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 08:58:26 -0800 (PST)
Date: Fri, 21 Nov 2025 00:58:23 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Theodore Tso <tytso@mit.edu>
Cc: David Laight <david.laight.linux@gmail.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Message-ID: <aR9Ir6fdzD5_0Pkn@google.com>
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
 <20251116193513.0f90712a@pumpkin>
 <20251120155816.GB13687@macsyma-3.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120155816.GB13687@macsyma-3.local>

Hi Ted,

On Thu, Nov 20, 2025 at 10:58:16AM -0500, Theodore Tso wrote:
> On Sun, Nov 16, 2025 at 07:35:13PM +0000, David Laight wrote:
> > 
> > The (int) casts are unnecessary (throughout), 'char' is always promoted to
> > 'signed int' before any arithmetic.
> 
> nit: in this case the casts aren't necessary, but your comment is not
> correct in general, so I just wanted to make sure it's corrected in
> case someone later looks at the mail archive.
> 
> "char" is not always signed.  It can be signed or unsigned; the C
> specification allows either.  In this particular case, scp is a
> "signed char", not "char".
> 
> Secondly, it's not that a promotion happens before "any" arithmetic.
> If we add two 8-bit values together, promotion doesn't happen.  In
> this case, we are adding a signed char to an int, so the promotion
> will happen.
> 
I believe David was referring to the C11 spec 6.3.1.1:

If an int can represent all values of the original type (as restricted
by the width, for a bit-field), the value is converted to an int;
otherwise, it is converted to an unsigned int. These are called the
integer promotions. All other types are unchanged by the integer
promotions.

The spec explicitly mentions char + char in 5.1.2.3 example:

EXAMPLE 2 In executing the fragment
char c1, c2;
/* ... */
c1 = c1 + c2;
the ‘‘integer promotions’’ require that the abstract machine promote
the value of each variable to int size and then add the two ints and
truncate the sum. Provided the addition of two chars can be done
without overflow, or with overflow wrapping silently to produce the
correct result, the actual execution need only produce the same result,
possibly omitting the promotions.

So IIUC conceptually the promotion happens, even if the compiler
optimizes it out in the actual execution.

Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf

Regards,
Kuan-Wei


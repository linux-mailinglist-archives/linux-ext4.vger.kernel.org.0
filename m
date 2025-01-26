Return-Path: <linux-ext4+bounces-6243-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C8A1CEFC
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 23:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C241886323
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC913C689;
	Sun, 26 Jan 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FULQ9gT8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CB28691
	for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929013; cv=none; b=gu5myYebMslAORvGrYk99r6RxUB4RgIZn+wcFrH097ZKyEV8P2FYPbPct8s9AnLw8BgX6DPHR4I8I8+IVFxBIBhe7Va276Diqbm5WVQj/AmYPx0FneIpdUllUKSb91byWhRv3MM+wjrvG+gQSdUg0RFqRZSPdDZ5igpC5cyJXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929013; c=relaxed/simple;
	bh=q/ufU6l2hUFdP5eNKcLpkhRfcKNKm7m6TnU5RDxpY/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amDIsklhPEpnRUGhsoLAeuzA6BmYhIf936vFecxPW5FP/C91ACDURkq7NbsIKpw33X2RYROy4MN2I8G3Z/Bc8rDeMQg+5m6qJ1xhf2U/oJWR5i/juF98f/ceaDYfmNH7VHudKYAjuNSGiqmB7dRdE2gcGd5KIBVrK8tBNjQWjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FULQ9gT8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaedd529ba1so553950066b.1
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737929009; x=1738533809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ftAl2E4jhQVnt+zxNTCeWVpoj8xxkdI7zBdq0Uw0aUw=;
        b=FULQ9gT8Jh/2YKK2siEiE5gmcRa4ziDn0gRX1cXiKky27dPXBv6zTokFFw5DbSyWcs
         46MovO1iVLbr6DpED/+UDaVPey0VX2SxBm0d5l5HuzYZgkmsnUMv9DmNap5T3yyFZ9zm
         BBe1EVcdZz1OlUxn1Siev2mcNY3VAuxZy/PFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737929009; x=1738533809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftAl2E4jhQVnt+zxNTCeWVpoj8xxkdI7zBdq0Uw0aUw=;
        b=uDdVROdLtW3ssCD64EpA5k6onR4VsNWYtkW9cUgFNC2iaT2959rw3dNysAvieswpGi
         lIHJx7WltqU3DQbTs7spVTcg4LOyV8KrVYZJpvI6QCnisFIgW0mNfVnCcYHmf60BHDdv
         G5tWospWE30vE0zajan6gSXVJcadhRCv1LcRWwrKp7l4lQqv5J3CL+IBhLDqI/Bjj9Et
         uF5zfeH0AnXlCdwcUfbp97i1hz4TRfZISKCqORv8+49kBsqEYfvv9rOMcEL64relJtPJ
         kugoctKaxxGHX9T4NluqjBHe2rKTLHx7sbyxlrMj8W4Q9doP+ZShXvEYH18UFI1jTarW
         Hiow==
X-Forwarded-Encrypted: i=1; AJvYcCVIB4mnX6TXbrb7RzMafJR9q38rE3BscQ38Gme6i6cNt9qLwXGz+OaqzxhQHD5iv4oLl6plEaNkp0Pa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Y0s6Oez9lkl3yXFmp2uJnr+fzMHn89eDsfXyeQG/XDUv9Au1
	gDGxnCN9gDD1ji0YyVR0ksq94nDnvukVU5VJQmYkag4UbO+9vysO8xLsQvnrrZLzsWlnBLXtuP3
	p1SQ=
X-Gm-Gg: ASbGncupG9WakXzhPvJOOnRmBZ0We2gaqf8sfiAYNCHfpk6kLskOijxQGX60RAd3uBh
	SiQ+53kwQdZoddR1eQ7W2csWJXpezElyK8aGWYqVMBw8EaoJpqiEwgHD03ZRmxhJoiJWUaKlteS
	4tjqTVxRM2Fb2ArX2zvLV8rqfx6mPmSG8MTrEP41xGKJAzgvG+yYQ9ZK+He2LZxCw2SfSX1DpWT
	L1rFlPPr79YDwWNb7rZX4rsuWLqL6fUs6zoKY8Yz10n5qUfBF9nxheM48y/nt0w29IrSo2xTOhd
	GobNROV7eOgxNec8X03tkFfw9aKS1/PljWhO7PkP0uEU2mdhXlXWOS22/PU1pUJ4pw==
X-Google-Smtp-Source: AGHT+IEPdEVmYljBB0GHaeXcG2Ye5uZvq34g5wIiuLzg22qrsFzuPusNBwmo0A+/u0oqEyWQz5Vb1w==
X-Received: by 2002:a05:6402:1ed4:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5db7d30092amr84401475a12.17.1737929009528;
        Sun, 26 Jan 2025 14:03:29 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186191f6sm4486470a12.13.2025.01.26.14.03.27
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:03:28 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaedd529ba1so553947666b.1
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 14:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtlLE6matGpGWghzpjbXiVab7Hg4xQe8P7ROuxhdRN2RvJfh4Q5+IQxhYC7/+Kl9QwM2fC9R8ho8Jr@vger.kernel.org
X-Received: by 2002:a05:6402:5106:b0:5d0:ced8:d22d with SMTP id
 4fb4d7f45d1cf-5db7db07334mr87191980a12.22.1737929007310; Sun, 26 Jan 2025
 14:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20151007154303.GC24678@thunk.org> <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
 <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com> <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
In-Reply-To: <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Jan 2025 14:03:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
X-Gm-Features: AWEUYZkT1zJPUOsJDklhxmCnOi9qrGHPGP5lqGBukO5SJTzO9erJAZyCyaIHD94
Message-ID: <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>, dave.hansen@intel.com, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jan 2025 at 11:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> This being your revert I was lowkey hoping you would do the honors.

If it had been a plain revert, I would have - but while the general
layout of the code is similar, the code around this area has changed
enough that it really needs to be pretty much entirely "fix up by
hand" and wants some care and testing.

Which I am unlikely to have time for during this merge window.

So if you don't get around to it, and _if_ I remember this when the
merge window is open, I might do it in my local tree, but then it will
end up being too late for this merge window.

             Linus


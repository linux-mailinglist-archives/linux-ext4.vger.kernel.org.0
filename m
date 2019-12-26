Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242FB12AFC3
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 00:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLZX3Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 18:29:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41276 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZX3Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 18:29:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so13554044pgk.8
        for <linux-ext4@vger.kernel.org>; Thu, 26 Dec 2019 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=TQuMyWny8hWtt1MLws74+aMtByUKKMivFY0g2eakkkM=;
        b=Z1hFH9rKZoZVwN3HFABEulLkhJJQHdiQ9hXRKpwuucZ8oG4skzgbM1MInEaAM2oNf+
         Js5I7My4bwh77VhB1FOv4YRNewAKZBDq83zP6m5WXz9Gz9op6r1zchEnoHBIU3/KOXku
         S5hPxMZ9EpYLYmGPFg3/4umrLgkYcFRiQK2tlvvVPAc3oVRzHjN9OOnxrFqtVcIshTqq
         jSf0Dt13GHR605MmbOGp0lYTSrdB7dsYwjmOGmLPh5UWKl2uob+KPehVM0r50uzAuJc8
         VKPPmoyBnPXN7sPihO7YiI3kCULqFDwq8UXURIpE0nwwpCSG6cgjKsbBgfdymzC1Z1Ay
         arEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=TQuMyWny8hWtt1MLws74+aMtByUKKMivFY0g2eakkkM=;
        b=YfgNPeFOx3CfgOJBmqcsvFvO5qR2WIu18wGZHiRm1B58reR/GQsNB4jgrn0KA46YFx
         pxfYSjeD0QSp3lMgIcfFPzpiW3qNAjvfyDEhy29DoeE/b82uaIizp8aNBDMC2RtsbDfN
         /ULRolaghRYYYoYzUKC4zF+3SFYCeyavnseaexzFVsQIByBIqb+XM9rlI2sLTSuOyR7h
         zASTakN02d0LXQx0MJza2Js7Hw3pZiCV1mgb3cd2S3yPl6+cdvMDAljhztUCeU0mH6UC
         64dTXhWF/c3YUoWpbMWecEcxeUXRUjlF+WpOZsfSNsBKIooXHpCpc3BH9zm7udTdgxaD
         LgkA==
X-Gm-Message-State: APjAAAWL12I8051J4HZ29+cxTtj/CIeaUKutdghtNQcANLYFi19iNLGU
        uh2Dvjap9N//ojYBhqISJ/SYIw==
X-Google-Smtp-Source: APXvYqw168U7pDuIAoJqCk32EI3yv82F+VAtM7+4RMaW9dlE9+1qYIzcTdTB4z9/E6MkxcZHX7Joiw==
X-Received: by 2002:a63:1a19:: with SMTP id a25mr52030190pga.447.1577402963260;
        Thu, 26 Dec 2019 15:29:23 -0800 (PST)
Received: from [192.168.0.9] (114-27-11-154.dynamic-ip.hinet.net. [114.27.11.154])
        by smtp.gmail.com with ESMTPSA id l2sm11776754pjt.31.2019.12.26.15.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 15:29:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/8] Rework random blocking
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20191226140423.GB3158@mit.edu>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Date:   Fri, 27 Dec 2019 07:29:20 +0800
Message-Id: <26B7EEAE-1166-4B45-9534-E00C5B2767C1@amacapital.net>
References: <20191226140423.GB3158@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


>> On Dec 26, 2019, at 10:04 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>=20
>> =EF=BB=BFOn Thu, Dec 26, 2019 at 01:03:34PM +0100, Stephan Mueller wrote:=

>> Agreed. I was just trying to outline that the removal of the blocking_poo=
l is
>> a good thing. Even when we decide that random.c should receive a TRNG, we=
 do
>> not need to re-add a blocking pool, but can easily use the existing ChaCh=
a20
>> DRNG (most likely with its own instance).
>=20
> Well, it depends on what you mean by "TRNG" --- the ChaCha20 DRNG only
> has a state of 256 bits.  So if you want to only depend on "true
> entropy" you can't extract more than 256 bits without violating that
> assumption, at least if you're using a very strict definition of TRNG.
>=20
> By getting rid of the blocking pool, and making /dev/random work like
> getrandom with flags set to 0, we're effectively abandoning any kind
> of assertion that /dev/random is some kind of TRNG.  This is not
> insane; this is what the *BSD's have always done.
>=20
> But once we do this, and /dev/random takes on the semantics of "block
> until the CRNG has been initialized, and then it won't block after
> that", if we change it so that it now has some different semantics,
> such as "one you extract a 256-bit key, the read from /dev/random will
> block until we can refill it, which might take seconds, minutes or
> hours", will be considered a regression, and we can't do that.

I don=E2=80=99t think Stephan was proposing that. He was proposing a way to i=
mplement a new interface that blocks.

>=20
> Of course, we can hope that people will be using getrandom() and there
> will be very few new users of the /dev/random pathname.  But nothing
> is ever guaranteed..
>=20
>                       - Ted

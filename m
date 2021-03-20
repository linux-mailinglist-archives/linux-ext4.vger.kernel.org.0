Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38857342C1B
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Mar 2021 12:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCTLYs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Mar 2021 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCTLYd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Mar 2021 07:24:33 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6875EC0613B1
        for <linux-ext4@vger.kernel.org>; Sat, 20 Mar 2021 03:44:50 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id z9so10345210ilb.4
        for <linux-ext4@vger.kernel.org>; Sat, 20 Mar 2021 03:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=L6Kgc3tRVFF2let9OqOhKw0hCmNshZRwLOFUvp7Qklc=;
        b=GT13xEPHnei7z6CNdIriw9WTKtoVFo6sPJMjxQeIfIZGIcz4IQ9pziHiISTqH0TvwN
         bO/0ddm4xi5/9q55PTusqtS7MKP1PNe09la5tR86DhPBWWVStuJBe1TnOKgLhyXAlG9B
         TakdOyPBq1q5xHJY0sV5xTJeMlsJOBZVAEqKyfPDh7cTGFQjHdmVGinuluo/SVdzflJ9
         IWdBz3a/pZGdaUEhkBhZn8znYXkw0NzowqaBP/wn8KMxNmNM+t9qrOV/PXymxEyDRKrR
         GreIJSclqBgkDo4U03GJZY/Z3PulbjCAgEbG7PJ2tztW3ARTZHT8k+M6NS94IvjQiEaV
         sHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=L6Kgc3tRVFF2let9OqOhKw0hCmNshZRwLOFUvp7Qklc=;
        b=EkWZfrwSkHuP3f/xgX46n5cpPjSYOxqO5Ng/AfXmKz0S+vtXPhCB/7VVHpm5Zw8+20
         MbeT4bQQ3cCwiFnD5098NMyxnQHRvoIPesKmV6eTXIIFYJfbLnzOpnc1aSomQPdpJe02
         J+CNXpyG8MsHHmKXylXszem7/2h3CFV4kqn8cVw/IAufxmklq2ps7nsGdwCbdLYPDWHI
         ygm/ahThdX414dAAD5+yBStMqtmCnqZpNKmIYITPiZFg6orhtOYwatyalO8471EoWD9V
         GBTCqRdMW3CG1dN21EQAPlNxj37T8oAllUz3LxLnE9/1bjNtmD2n2Ojf17+T9ph4aG8x
         NLHg==
X-Gm-Message-State: AOAM532VJ5cYH06uFFzT9T4opEvqmH7kDBJIxFMHVcePeaeZQ5vXVQ86
        7Czgc/xGSzV342uG1rKII0JpMmC3jgT/rAGs
X-Google-Smtp-Source: ABdhPJx74/Nh31ry6a74bwVBXC+iK9bBl7ifRcY+2msZrjZmEIXcV2+vzyBc4g1SUo4e0zgd087QxA==
X-Received: by 2002:a65:68d6:: with SMTP id k22mr756097pgt.114.1616231158930;
        Sat, 20 Mar 2021 02:05:58 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j10sm7443564pjs.11.2021.03.20.02.05.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Mar 2021 02:05:58 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0399B7C7-D6A1-4A92-ABDD-1EA13C80007E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_18E6BF6C-9AA5-4C4D-A623-B79DF40D07C7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/2] ext4: Handle casefolding with encryption
Date:   Sat, 20 Mar 2021 03:05:54 -0600
In-Reply-To: <20210319073414.1381041-2-drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
To:     Daniel Rosenberg <drosen@google.com>
References: <20210319073414.1381041-1-drosen@google.com>
 <20210319073414.1381041-2-drosen@google.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_18E6BF6C-9AA5-4C4D-A623-B79DF40D07C7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Mar 19, 2021, at 1:34 AM, Daniel Rosenberg <drosen@google.com> wrote:
> 
> This adds support for encryption with casefolding.
> 
> Since the name on disk is case preserving, and also encrypted, we can no
> longer just recompute the hash on the fly. Additionally, to avoid
> leaking extra information from the hash of the unencrypted name, we use
> siphash via an fscrypt v2 policy.
> 
> The hash is stored at the end of the directory entry for all entries
> inside of an encrypted and casefolded directory apart from those that
> deal with '.' and '..'. This way, the change is backwards compatible
> with existing ext4 filesystems.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_18E6BF6C-9AA5-4C4D-A623-B79DF40D07C7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBVuvIACgkQcqXauRfM
H+CgSQ//TQ7/Yghzj7rHH0WAVnnYsTzF+puQeZV1rw/Uxa5I7oo/ldzng2TGjtrh
dcNuJ42WRwCulz2qqmZB9UQSiU5KjlCMXsm2ELtCabY8XwRLvaLb+YsZRfnTB4nS
IC/MBwAZy2u1j5nYuS0jZGE9o1WG/cgMTsb4ob5HH4nHhgRveRqnK7ts7bGJ0lZZ
RMAWc+eUa1bE2vP0sDZqCoKL/1fBfuEEY3dCXigz/CpyTU46FeYT/Wjkm7qWkB2d
txYZWKgUfVdXAIIWJI0jXExgsUDM5qyNvX+HKXMoxld5RQp1sN2tB2Wt9w62Jle7
BnVOsIXDqSTmQVOJrmwEut2H+jaF9K+HZtx+43J/KPdkczpY+GPg/S4DIVkTWTVH
10xnItp08XL46+8bHLjq9YDVWf+PP08UFu41UQx6wZtXmWlpOfUxH/wCvw3+lJEy
/OM/bFoaJPx2UMGUCeaXibFnTTsq1w2bia2pWOcn55AITEV2EFRs5HPM7s6pjtCf
yHCwbWiB+qIqS2Brc4kTm7l+HTbN43yUhC4zwnjror4w07OvVbK/OHvyJ2ET4HEJ
lyvz0M+2yS9iu90VbwnpBcTU3gHCmZyjNRM76AEUiu3NSKZk02Sc7wd2U+vvmU4z
IsumbcZeDZAhE4j+/aBBtebBgiLu6xeK+cy6rtE+/NSNkfoWH+8=
=n6Sd
-----END PGP SIGNATURE-----

--Apple-Mail=_18E6BF6C-9AA5-4C4D-A623-B79DF40D07C7--

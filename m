Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705D6325CA7
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 05:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZEnk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 23:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBZEnh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 23:43:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71904C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 20:42:57 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so5484957pgm.9
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 20:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Vg5Ge/fhoRhy0cB5P4HNRQIg6qvbg/nQEzH6z4qr+Kc=;
        b=e9kXv5MD9FaRC43+3dpAnRuuYA6S7FmXFDu99A5dHpkz3n7ohlqcYiyLgc+dZkkTZq
         jrL+LQGf8u5qKoujPb7JETaS4/m2zk3BdrrN3MRCt0AenjrilmDxZXGu+lcPzpdMDEdC
         wj7xA7tQSoYnRyEghDAAWJwAY6ccrMoMl11nAknKIRx+M3mM9J2uR0hbiYUjvJMugjGv
         I+zdUWmjAymcqof+8hmMMAQg1/jiFaP3Wp+B3cO8k1nDCwcXOyK7DsW46hbgwS412p4U
         dtp+IDvHCDOno7qc7QmYd0Y2de65no9VJB8eFstHJ1P0spUbXRDiMapWG4/RL1QncTL5
         Qw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Vg5Ge/fhoRhy0cB5P4HNRQIg6qvbg/nQEzH6z4qr+Kc=;
        b=t95B0v6si32aLAIBeRLqg8dMmwZMgw+mlgqPdPHpSSP3wE62yrOwQmUIjK9YrZXPcR
         L/lY5y0WFEQiUqk7DT8MA+8X4/0LA2WR+e5suDdRcl5ZpKI6/qpP1185FefdBFAn+iL+
         IcnByZ+IQ/QJE4WgPl7Zga746u/4TZjEa8foPuXJ+bgKc6i31RoXvOqYqh4+3S9s8Q0S
         DEpbf8kJor/ECiB67b25Pjvlm2Fk5Q2uSUuTH11fs5J8jjqBY24LnsaZYoAP8RzRheax
         gvacVOLKPrTVnCJxSMawdzxFDzYN1qCS3nxJIA3HlGYXzIHhrutJ9hO6u+cxLD7a5KpA
         pIJg==
X-Gm-Message-State: AOAM533AQzz0v032MZ3lc4M04XueuqpI4LgUXWsHbzwYp363uNPnSETl
        ncF3kmTJh0DkbHU4//jnG17fxg==
X-Google-Smtp-Source: ABdhPJwnJAzO4HYP9Sucw0QaR7xEZpiWKMHjF6mZGwgTn+y7bXK38EMhJV7BY3jqLU6v1YZKpYYNzg==
X-Received: by 2002:a63:5853:: with SMTP id i19mr1236885pgm.27.1614314576882;
        Thu, 25 Feb 2021 20:42:56 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u3sm8536047pfm.144.2021.02.25.20.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 20:42:56 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <17F9C9F8-9800-4455-9033-1A7FD712E828@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5A766CE1-41C6-4FAB-B764-79FDFF4A4E3E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Thu, 25 Feb 2021 21:42:54 -0700
In-Reply-To: <CAD+ocbyV24pFH1xAacjOUXb6jnuDtxFNDXVp7CwB0hRMebQLVQ@mail.gmail.com>
Cc:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
 <BF6E7BBD-794A-4C02-9219-A302956F7BFA@gmail.com>
 <7659F518-07CD-4F37-BB6D-FE53458985D6@dilger.ca>
 <CAD+ocbwCEKjrSAuv8EKWRwq-tXva+w4=VxDwFJ2N3-VLaevp9Q@mail.gmail.com>
 <E51E6ECE-469D-45A6-8255-2474CCF0A734@dilger.ca>
 <CAD+ocbyV24pFH1xAacjOUXb6jnuDtxFNDXVp7CwB0hRMebQLVQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5A766CE1-41C6-4FAB-B764-79FDFF4A4E3E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 25, 2021, at 9:06 PM, harshad shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Hi Andreas,
>=20
> On Thu, Feb 25, 2021 at 7:43 PM Andreas Dilger <adilger@dilger.ca> =
wrote:
>>=20
>> Yes, modulo using the existing "mb_min_to_scan" parameter for this.
>> I think 4 or 8 or 10 groups is reasonable (512MB, 1GB, 1.25GB),
>> since if it needs a seek anyway then we may as well find a good
>> group for this.
> If I understand it right, the meaning of mb_min_to_scan is the number
> of *extents* that the allocator should try to find before choosing the
> best one. However, what we want here is the number of *groups* that
> the allocator should travel linearly before trying to optimize the
> search. So, even if mb_min_to_scan is set to 1, by the current
> definition of it, it means that the allocator may still traverse the
> entire file system if it doesn't find a match. Is my understanding
> right?

Sorry, you are right.  It is the number of extents to scan and not
the number of groups.

Cheers, Andreas






--Apple-Mail=_5A766CE1-41C6-4FAB-B764-79FDFF4A4E3E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA4fE4ACgkQcqXauRfM
H+CDYxAArcdTPqPgRbVmCnxgJWaPYjhuOQOYRsT18X177MfLcq/bRmjgl8nq7jI4
B0Z9QvTFqTSM7FEicV0XxKOsmV5iN50mxhfajZyk8ulgFIPcWpvnZUpIcH8jNh6x
TKqOpUMwTVMFMGtwiDb8Ou3hmObA3PcwTVR0fxZzNl9jczghVh59oQ6kKuGea5Ke
DiInU6okTiTA1NDKp0WmoWhY4kCjqGvVpnxO/6PMwrbZPEVNv0c/+gdkSVI1l4O7
u56djVIG75YgQiEldrL5kct9LNSpfnmlSgGBYQl8UnrIBEREjzJlFxtcWRqDERMA
4iJVv27feh6bSBbkEYQjAHUrQScWF2pdx5w8hufr4nwOcZ71EuwutSp5KvER4VRL
9czgglgLAXtZ3y4n/9G5xRlNRJtlM1UwLFGZRruNT6JOwaFJxro9ssuXTtP+4GRw
Mj3wWMDfNhcBn9wZWtWJUgNjuqz/PA5lUPK790HbEVv7U5lXaCDupYvENhn09bAH
WQxMAuY8Q7cPnpJwnIVzrL0Z13/ndXYFwo1zCGLX/69ZWYAMz4o8BO8i7kD59WVT
PhIH0hJb/0/OVK+7OO3TttJZ//uQIEVOziuR72yYhpM+lqGzA9b0TWTkRNpmFLMR
0aoxYt8lJ+L2d5CfR9pXVW3fK5a9SJZQRWVY45zxubDus/u3+AY=
=BMcX
-----END PGP SIGNATURE-----

--Apple-Mail=_5A766CE1-41C6-4FAB-B764-79FDFF4A4E3E--

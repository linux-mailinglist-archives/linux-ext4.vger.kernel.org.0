Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830C013377C
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 00:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgAGXhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 18:37:16 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:41780 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAGXhP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 18:37:15 -0500
Received: by mail-pl1-f178.google.com with SMTP id bd4so325699plb.8
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jan 2020 15:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=zd7gpdlnNIMoarOO2+DzIj7zRweKUzSaFQmZSzdoyWg=;
        b=MI4kRtbFA99fLQrWTTA947oN4YDzaZaMPSVK4n29ddc9dGilBhp560jXZlsRnoj2rZ
         UCNErl1vTXLVFPPPNFJmfF45F7BScz9A/Pnn6jW5xT8FxTmtNvEmXgWRXagcqOWl7MyW
         eNtFLAe/+rBtlniCtiUn76DSDXbTUe/DndQ6HlNdufs6Ksy4QdMjxCnimzmIajR2J5yi
         RElP+sFXVsd09oD9UtrPa29rFfKJq5+i4dFTf0jfJLsgGfBqTrAhncYzhnlERrkUVTdG
         8cPoDcSkoswl7WG28x0HpWaKWKafKq/39eKTskCuU64pHxsZxcpvI7SbshZgJVb9DIkx
         urxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=zd7gpdlnNIMoarOO2+DzIj7zRweKUzSaFQmZSzdoyWg=;
        b=P4esHb0B2veLorXeQhmnn6EizzG0PyBFnuII4krrW7l4G16Pza2FSUvKra5demwjyC
         XhR4BD5RrqUORTDHKryOwm16f5uOUfIlWBAdPXnZ+5oaiRxrIWLAFfEKMSn94rSJthT6
         BTUED7kbMi2CiFDKwJbmxcQqIEDRu+NEzmdhPQZMj+aLR8r1IJKLpjef49AoyRIpe/2U
         4yJ7QnbQSoZ8/qgOPxDx5GkWdeW/+v16fjWYeSFVyMMvtuv8l9TcUUIOH1uYF6nL3s9o
         hjDFFJFY2AKVFeVSAhph6PWs3XIzHPh9YM1ebM96gtNhGgG8Y08tHvw51FhYauGfllXD
         TiXw==
X-Gm-Message-State: APjAAAWLDxV4baT4QxQjrWNFNgVgT0NIOyqL+aPBHpZewQJB68cjnoLz
        ywlYOqQFA9c6UpO5S5NrhxCsxA==
X-Google-Smtp-Source: APXvYqxe8Oxb59KpQ5zyOi+hRLC4dGxHO3v6qRruS7WyH3ZSTPN8XJxsCeunt2L6/PiwFnBXIyqS8w==
X-Received: by 2002:a17:90a:98d:: with SMTP id 13mr1145597pjo.102.1578440234658;
        Tue, 07 Jan 2020 15:37:14 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f23sm818409pgj.76.2020.01.07.15.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 15:37:13 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <486029E2-906B-4EB3-8F4C-E8E12C842175@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_46D4C8AC-1CC0-4C9E-9E56-197EB7E2A780";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Inconsistent use of string/non_strings in mmp_struct
Date:   Tue, 7 Jan 2020 16:35:59 -0700
In-Reply-To: <20191231220724.GA118765@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20191231220724.GA118765@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_46D4C8AC-1CC0-4C9E-9E56-197EB7E2A780
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 31, 2019, at 3:07 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> While clearing some compiler in e2fsprogs, I noticed that we are a bit
> inconsistent about the mmp_nodename and mmp_bdevname fields, and
> whether they are guaranteed to be null terminated or not.  The kernel
> is using them in some printf contexts where it's assumed they are null
> terminated; but in other places, we have been filling them such that
> if the string is exactly 64 or 32 bytes, they will *not* necessarily
> be null terminated.
> 
> This is potentially a problem both in the kernel as well as in
> e2fsprogs.  I propose that we solve this problem by assuming that they
> *are* null terminated.  But that means that if there are node names
> which are exactly 64 bytes long, or block device names which are
> exactly 32 bytes long, badness could happen.
> 
> On the other hand, we kind of have this problem already, since in the
> kernel, we are using memcmp when comparing mmp_nodename, but in
> e2fsprogs userspace, we are using gethostbyname and there is no
> guarantee that bytes beyond the terminating NULL have been cleared.
> As a result I'm not sure the interlock between e2fsprogs and the
> kernel works in all cases anyway.
> 
> Or we could go the other way, and try to fix all of the locations
> which are accessing and writing mmp_nodename and mmp_bdevname so that
> they are considered non-strings which are NULL padded.

Hi Ted,
it is worthwhile to note that mmp_nodename is not really a critical part
of the correctness of the MMP checking, but mostly so that admins have a
chance to figure out which other node is accessing the filesystem in a
complex SAN environment.  The one place that it is checked in the kernel
with memcmp() it should only ever be "the same" as it was before the MMP
thread slept for longer than it should have, so consistency between user
and kernel versions or old and new versions do not really matter.

My thinking is that since some of the strings _may_ not be NUL terminated
(e.g. from an earlier version of the kernel or user tools) that the safest
approach is to assume there is no trailing NUL, and use a printf string
format like:

        "%.*s", sizeof(mmp->mmp_nodename), mmp->mmp_nodename,

to ensure it doesn't overflow the string buffer.  Fortunately, there are
a lot of '\0' values immediately following those strings, so in the worst
case, "mmp_nodename" may also print out "mmp_bdevname" (which is likely
NUL terminated, or the (likely) 0 high byte of mmp_check_interval, or
mmp_pad1, ... so there is very little risk of a very bad string access
causing an access beyond the end of the buffer.

I will send patches for both.

Cheers, Andreas






--Apple-Mail=_46D4C8AC-1CC0-4C9E-9E56-197EB7E2A780
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4VFiEACgkQcqXauRfM
H+AtbA//VWjaLNd0Hhr3BN5nXo4WBsBQxLjmbMfEc/ehxHFv1sAB7d3ylY3PyaeW
i/Ki/UIRfXvxAEhsnQgiL1qTAVYOzM5UvJivnpN9UScfhB1hPl8Sf363KTZy+M9D
j6uyB6Hp+emmKHk+dufKm8J4SWY+fqVOsvMmbIJg5rGhfTvpTkAl4kHF5aCEoA/e
C/E1zwUEIJM1xCVsbu7evPxYMf9uYUjZHw/qRUFgtjWdCkHBJCUMC1XH+cniv8jQ
JzRAoS9vnAG16fBZAGjICw6T4O7sJ/3o5jAfK2Nc3srf+6rVcd1a2YS0XWeOwe9C
j9WHWoMfU6Gj1vjL2IKsJremS2BcKpdOKQz8nvCzCTjZdqX4nGpcDazMpkN0Q0FM
JfZtZyOs5rXNmPRSUTYYtHrv95hgeN17oBd3QnRhDcmwPEZTwlf1JAA2XCUnkZSU
cZC7PPXhIX0ZYc4d0+RPQj5tS/k6HWm25RjZG3xwqLTpqET46CesAzVel1dgy9zH
MSVKR7Ybbpz7voYWNi3asfuMQvw/VWR3GPYQdYHuVQzNgld5k47Wz4+UMWU2IcFM
x8ewzxF8BDSKnUdUGDLivpXEoySpvzpegSPrL2B0J5BiZg1e3/Yd1NY+RPZUbN6E
u4tEpqaCITj32pmXPp1Q+bwPFYImlldF4/GCS/PF4rI905NyS4I=
=tgV8
-----END PGP SIGNATURE-----

--Apple-Mail=_46D4C8AC-1CC0-4C9E-9E56-197EB7E2A780--

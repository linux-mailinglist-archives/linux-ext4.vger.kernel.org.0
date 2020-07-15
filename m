Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF8221377
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jul 2020 19:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgGOR0J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jul 2020 13:26:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgGOR0H (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Jul 2020 13:26:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3814AB55;
        Wed, 15 Jul 2020 17:26:08 +0000 (UTC)
Subject: Re: [PATCH] ext4: catch integer overflow in ext4_cache_extents
To:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
References: <20200713125818.21918-1-jack@suse.cz>
 <20200713134448.4CFA3A4051@d06av23.portsmouth.uk.ibm.com>
 <20200714123122.GG23073@quack2.suse.cz>
From:   Wolfgang Frisch <wolfgang.frisch@suse.com>
Autocrypt: addr=wolfgang.frisch@suse.com; keydata=
 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
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <8bfb84e8-8699-0206-bf31-8ad9877d1986@suse.com>
Date:   Wed, 15 Jul 2020 19:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714123122.GG23073@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a8GA3HdFqUL0BF7gU5q7m1724DI18jmb2"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a8GA3HdFqUL0BF7gU5q7m1724DI18jmb2
Content-Type: multipart/mixed; boundary="dtw2YA0r4cX0RYOIRqH0MP8IfOOLowNUx"

--dtw2YA0r4cX0RYOIRqH0MP8IfOOLowNUx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14/07/2020 14.31, Jan Kara wrote:
> On Mon 13-07-20 19:14:47, Ritesh Harjani wrote:
>> On 7/13/20 6:28 PM, Jan Kara wrote:
>>> From: Wolfgang Frisch <wolfgang.frisch@suse.com>
>>>
>>> When extent tree is corrupted we can hit BUG_ON in
>>> ext4_es_cache_extent(). Check for this and abort caching instead of
>>> crashing the machine.
>>
>> Was it intentionally made corrupted by crafting a corrupted disk image=
?
>=20
> I'm not sure how Wolfgang hit the issue. I'd expect some fs image
> fuzzing... Wolfgang?The bug was discovered accidentally when we tried t=
o use a physically
defective USB flash drive. It was possible to partition and format the
device but the subsequent mount operation unearthed this problem.

As it was impossible to image the defective drive entirely, I used
blktrace(8) to gather a minimal list of read operations executed by
mount . A script then copied just the necessary blocks from the device
into a sparse QCOW2 image that is attached to the original bug report [1]=
=2E

>> Are there more such logic in place which checks for such corruption at=
 other
>> places?
>=20
> That's a good question. But now that I'm looking at it ext4_ext_check()=

> should actually catch a corruption like this. It is only the path in
> ext4_find_extent()->ext4_cache_extents() that can face the issue so
> probably instead of a fix in ext4_cache_extents() we should rather add =
more
> careful extent info checks for the extents contained directly in the in=
ode.
> I'll look into it.

That sounds very reasonable. I see you already implemented it!

Best regards
Wolfgang

[1] https://bugzilla.suse.com/show_bug.cgi?id=3D1173485

--=20
Wolfgang Frisch <wolfgang.frisch@suse.com>
Security Engineer
OpenPGP fingerprint: A2E6 B7D4 53E9 544F BC13  D26B D9B3 56BD 4D4A 2D15
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nuremberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Managing Director: Felix Imend=C3=B6rffer


--dtw2YA0r4cX0RYOIRqH0MP8IfOOLowNUx--

--a8GA3HdFqUL0BF7gU5q7m1724DI18jmb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYqBDpiSp/H/7pxro7t22gcnlyyMFAl8PPCwACgkQ7t22gcnl
yyNSBxAAl5bysSvJGnor6CO4m9W2CjHBrDgeQ09lAQ+yI9P5o1oOk9NbuwZ4f3t9
sYGJXyuARSSrvDvwJja3Ur/JPa05rmqid8oZZUJnSVr0HASGu9Sm7Ygssa1EFrbg
z05c/AK8nR5DHIirpesU9eQkfXoIT/y40LZTVEIKSQrgmJqf+/XNfMljR4g2nLEi
1pSvST6fkTA0Fc7td0J78bP+vZctgXHOQ/CqLBwIo8ZJPrXnlH48HI25UZJivBtO
url9gn7AJ+SCC1huhD0PPHKLMJnRed7GoUe/l2/WgfbKqfnT8ZtDGZkfUL/No3Yu
Zgx6BYprHBSCHdTg0F3MtblUayJ42uf3Yz+G0frHOvhp88DEJ08HI7EcbIKyP2ym
S5wtCBJvttMP96YRyZ2ZsekoZWudDTvxpHuhAp+rNtfe1elhTrDNnYCX1zkLi8/p
jrtSIpuQcRZYMfSceJao8vTydnXAyh5440EJJXUKr6WZv8WjLPw4YycKzQAm44rX
52JHLIsxrv+V5u/EZBAQ8QK1nA8bygcYP/Nl7UCTwyhDgU3DYLTM2DCwkOykTL+3
nSZShWFwV5NamQGo/FN+50o0RshwFOlRxSuzLNz4FAigyxcqPD1obDpMssDxAa2H
iHgYVQTFdFjfM2U6gGv20q7tOq9KfZ2hhIcjAM7tfHB03RbYE5o=
=cIpu
-----END PGP SIGNATURE-----

--a8GA3HdFqUL0BF7gU5q7m1724DI18jmb2--

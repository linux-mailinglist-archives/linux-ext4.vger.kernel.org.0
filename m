Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676CEC9327
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2019 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfJBU7z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Oct 2019 16:59:55 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:52452 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJBU7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Oct 2019 16:59:55 -0400
Received: (qmail 22434 invoked from network); 2 Oct 2019 20:59:52 -0000
Received: from localhost (HELO ?IPv6:2600:1702:2a80:1b9f:5bbc:af4c:5dd1:a183?) (awilcox@wilcox-tech.com@127.0.0.1)
  by localhost with ESMTPA; 2 Oct 2019 20:59:52 -0000
Subject: Re: t_ext_jnl_rm test takes 96 seconds to finish
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <6f6b5895-12f3-bc3d-f50c-1de0886f41c3@adelielinux.org>
 <20191002195955.GC777@mit.edu>
From:   "A. Wilcox" <awilfox@adelielinux.org>
Autocrypt: addr=awilfox@adelielinux.org; prefer-encrypt=mutual; keydata=
 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
 N7qhRF0UHQZkMW1rGbU=
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <433847ea-0ffd-bb35-6b8f-c10fb96bda34@adelielinux.org>
Date:   Wed, 2 Oct 2019 15:59:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20191002195955.GC777@mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EX03HK69c0RqJYRvgm3tW40w4gkfO7gsW"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EX03HK69c0RqJYRvgm3tW40w4gkfO7gsW
Content-Type: multipart/mixed; boundary="TRPe9kcL5GVbjgRkS3VznEQj72LkXFRQG"

--TRPe9kcL5GVbjgRkS3VznEQj72LkXFRQG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/10/2019 14:59, Theodore Y. Ts'o wrote:
> On Wed, Oct 02, 2019 at 01:16:51PM -0500, A. Wilcox wrote:
>> While building e2fsprogs 1.45.4, I noticed the following output during=

>> testing:
>>
>> t_ext_jnl_rm: remove missing external journal device: ok
>> t_ext_jnl_rm:  *** took 96 seconds to finish ***
>> t_ext_jnl_rm:  consider adding t_ext_jnl_rm/is_slow_test
>>
>> I didn't see any mention of this in the list archives, and I'm not
>> entirely sure if it should really be marked as a slow test.
>=20
> The first time I ran this test, it took 20 seconds.  (And that was
> only because I had a WDC external SSD attached to my laptop and it
> took time to spin it up; more on that below.)  The next time, it was
> nearly instaneous:
>=20
> % time ./test_script t_ext_jnl_rm
> t_ext_jnl_rm: remove missing external journal device: ok
> 356 tests succeeded  0 tests failed
>=20
> real	  0m0.242s
> user	  0m0.053s
> sys	  0m0.114s
>=20
> If you look at the test script, you'll see that we are creating a file
> system, setting up an external journal which doesn't exist:
>=20
>=20
> ... and then we ask tune2fs to remove the journal:
>=20
>=20
> So the time that it takes is based on how long it takes to search all
> of the disks attached to the system looking for an external journal
> with the uuid 1db3f677-6832-4adb-bafc-8e4059c30a33.
>=20
> On most systems, this is fast.  If you happen to have a slow device
> attached to your system, then this can take a while --- but there's
> really not much we can do about this.  I suppose we could try to add a
> test mock which disables the external journal search, if there isn't
> any way you can speed things up on your end now that you know what's
> causing the delay?
>=20
> 						- Ted


Ah, okay.  This machine happened to have backup devices still connected
which are external USB spinning rust drives.  They could easily take 30+
seconds to spin up, each, and there were two.  Additionally it has a
caching HDD internally that may have been spun down.  That explains it.

Thank you for making sense of this, and doing so promptly.  I really
appreciate it!

Best,
--arw


--=20
A. Wilcox (awilfox)
Project Lead, Ad=C3=A9lie Linux
https://www.adelielinux.org


--TRPe9kcL5GVbjgRkS3VznEQj72LkXFRQG--

--EX03HK69c0RqJYRvgm3tW40w4gkfO7gsW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEjNyWOYPU1SaTSMHHyynLUZIrnRQFAl2VD8QACgkQyynLUZIr
nRRXbw/8DHEHgwKcE0N4sW0C6lA+4llVZavJ/YZtOpt/ye/e9EgwMjCcBWSNJknN
zS/FeXTKiHkTd7eIXqSOwNoRX6KZm80GiKn8akhb7xj85Eq8BPp+Oz56qTmSJO1T
Qd+BNwY1AF2kLW+WXKtgHKOTpWPW54Ok3+CWU9wHR2PK/93iqtJBSK4WWY4RP61Y
YRlP28sw1PURyyOpgGP26Jr1Non6VN5qAQWW+QuWCNdU6zRlzccolPxceKJU/jvQ
2qBFdHrcxHNHeN25qZ8heCbEQqlQ6tfwm5j0sEV9l8Em6L/wmdrxwdkSzHuf+7SN
Ww175ffhL6eEP712jzy5NEafyMeqGCWXaTtsmAdxmo3H4zfmFiDQYgpbfhjGF1zo
QLs4CqdxGdL9pyNNTfVhRYqDtX4ha3AHWWJQxzi5IbTE0rxd8tOFsPRDEBYOs+R+
f+d6c56cRA6aXonAQHE0h0Air9rjn4+xUs6wL33KzBHewKNRDKsyLxJpB26Ab70Q
kxlbFb2YJRa5ERYeFwf202NGxzyI9YP0eDexRkX+NxksgMg0fCPVgde9fqJLmYot
4zEvUq3cVMiTdPdoRc6actRy5AQQDxe5AmW2iwUHaSdwGIKVsVDwK2fYOdEMn81Q
r5SXTRV7eypWzJEAh4gQrQq4HxXc+7+thVEg9cY335hOAeLLYA0=
=93kQ
-----END PGP SIGNATURE-----

--EX03HK69c0RqJYRvgm3tW40w4gkfO7gsW--

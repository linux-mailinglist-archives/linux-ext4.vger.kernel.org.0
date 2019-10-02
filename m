Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1699FC90C6
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2019 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJBSXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Oct 2019 14:23:40 -0400
Received: from mail.wilcox-tech.com ([45.32.83.9]:49340 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfJBSXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Oct 2019 14:23:39 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 14:23:39 EDT
Received: (qmail 18036 invoked from network); 2 Oct 2019 18:16:55 -0000
Received: from localhost (HELO ?IPv6:2600:1702:2a80:1b9f:5bbc:af4c:5dd1:a183?) (awilcox@wilcox-tech.com@127.0.0.1)
  by localhost with ESMTPA; 2 Oct 2019 18:16:55 -0000
To:     linux-ext4@vger.kernel.org
From:   "A. Wilcox" <awilfox@adelielinux.org>
Subject: t_ext_jnl_rm test takes 96 seconds to finish
Autocrypt: addr=awilfox@adelielinux.org; prefer-encrypt=mutual; keydata=
 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
 N7qhRF0UHQZkMW1rGbU=
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <6f6b5895-12f3-bc3d-f50c-1de0886f41c3@adelielinux.org>
Date:   Wed, 2 Oct 2019 13:16:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7VHsheLm9DXJcMZcpOTeldPxLB6vY8728"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7VHsheLm9DXJcMZcpOTeldPxLB6vY8728
Content-Type: multipart/mixed; boundary="x1BISfACZac2xVr4Icrr0alRFYJuWgndb"

--x1BISfACZac2xVr4Icrr0alRFYJuWgndb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello there,

While building e2fsprogs 1.45.4, I noticed the following output during
testing:

t_ext_jnl_rm: remove missing external journal device: ok
t_ext_jnl_rm:  *** took 96 seconds to finish ***
t_ext_jnl_rm:  consider adding t_ext_jnl_rm/is_slow_test

I didn't see any mention of this in the list archives, and I'm not
entirely sure if it should really be marked as a slow test.

System is a 64-thread POWER9 @ 3.8 GHz with DDR4-2400 RAM, so it isn't
exactly a "low end" machine.

Let me know if you need any further detail from my end; I'll be happy to
provide it.  Thank you.

Best to you and yours,
--arw

--=20
A. Wilcox (awilfox)
Project Lead, Ad=C3=A9lie Linux
https://www.adelielinux.org


--x1BISfACZac2xVr4Icrr0alRFYJuWgndb--

--7VHsheLm9DXJcMZcpOTeldPxLB6vY8728
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEjNyWOYPU1SaTSMHHyynLUZIrnRQFAl2U6ZYACgkQyynLUZIr
nRSX6BAAjCbOpQ5o4UcopulU+SMqz3lmkvThr1LrJB1zsgadJFGeTa+goUG4myH6
XcaEzvIwpFmBpNs0ulvIFfwkLMKA+UWjSgf0PEHl+tEuw1UEcGMDLN6LbhUqD0nN
82EyD90xhd7BN9HvbzREGSkO48b4/sJ8X7dsPkM0hsLUUiyzUiUySJhY2+eaZUVa
+QgN0mxVLad9f9kMWr/MIpnpUXszoamz+/kQ6e3KJx+f9229IbG09BfWabT/i2T7
oSlNHIe1pTBGxiahzQP8b+1lZWr1CtR7ginxuI6anhXUw1QcD/r/CmRxtt4+bvl1
aOeUqWhhEaOcyGq5M+EDXRDQXTLm8AFTWq+Wb7E9cyPfY6NA5bWNNZFcRZXP+NZj
0AAnOhyS7JA+P2w6kXi8lMY/YVV4YajOJSE5uhor97sO4Z4ur9Tw6rQonDohfs7Q
o5HJ9GkYAkUOLZxs+j6CaEE7Rud4hK6VU4RQhIqnVi18RXgGgvmc/Xkt1DE3AlWt
tndRnmTgC98eG4fjPfx8mkidq6u7wa7YXGRsT28qU65nl2Y+XWlZFuLgfnhNinis
imQYw0wJoOqFl2URBIuBjB+63VOviWp8wSrNXWFtbpDrvxlIZ9//FrHO2UFOhZSK
NccBNhvJJUYj4EcsWG45wywnxWPRkyRGpZK/NI1jVLiXv2ZarRg=
=V0Ft
-----END PGP SIGNATURE-----

--7VHsheLm9DXJcMZcpOTeldPxLB6vY8728--

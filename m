Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0099600AA
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jul 2019 07:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGEFfI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jul 2019 01:35:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:43989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfGEFfI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jul 2019 01:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562304907;
        bh=q+upXtoDKWAafgAygSsjZhLobm4fhgszI1IhuproTzs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=VPVhEFJXt3y6tBujHTigv/9v3V9jwOMzvPYStDVaLK17WjnV61kbORGV054Q2oUvt
         gXB/XHgfgx6+XcUXcUuZywoY3oC0ZlLPecnAflrim6X5Z3ViOP77gwV6SZ2TuFQJ9+
         9ZuPhBBV8RIgjAtwVuEf8SONq49aKUi20XNeVKBU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MJjUO-1hiAwf3sY8-0017xO; Fri, 05
 Jul 2019 07:35:06 +0200
To:     linux-ext4@vger.kernel.org
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: mke2fs accepts block size not mentioned in its man page
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <ce9edecb-6f04-77d3-32f1-2b9de6cd3d7e@gmx.com>
Date:   Fri, 5 Jul 2019 13:35:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lfZJoZCPRYDoYTEwzYP8xtj9QfdVl9SxZ"
X-Provags-ID: V03:K1:OYwE119fPogEpRzMvTVPfLn5sJZ3rLTxh+0C4Of2Jss42TkjatC
 /FqtcQoKO4CpBrBIWXSIZDjzlUmpTkO83wk82yh2/ksLWrSmD6elY7Xdfnyt/radCVZ79Rm
 l7a6aLpV5vPQds2pnrwfpjeQ6zQGNGTTdPcWcy+HI2bSUL5ai34fsF/8cVNqu7zjCBJmbhb
 PZPMSM+NM1BHnqfnVbUyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qW3735Nl0bQ=:8EXN84aCgnl0ZFC860CGL3
 A2I/tyZ13PvL4+D23Bnkv/7iTtITnoin1FuWAR5GgiYX1m54iHo+r4uKlike8WDu8Xyb90j2X
 gSmbpHFRFLN8p+M658RQ1MGWwj6y1xSGZT1sxWAQOwKnSTHbkHzxrPlhQQq58xWqBmHr9slFs
 oorX9IejOkdL66ScdUPwbP8TvtcZ0tjBCz2GqsKuz0THTQ57j7TOYjPQXdgjW2OaLiIkbKp2N
 NwPSqUA4BHeYktnQwM35AxU5t98NPSZCH8by/w92DjApYcpgrkHSPHhzpbIDKSo6IsQQdth4M
 iBm9JD9rgD478G0RSVFVCEmdU0+USFlrhooWU94F4hC7Y8LSjc8YcQDRmdlAw/NSdzgPqFTS8
 wGgCRtiU4WOZOrZ9ARKo+8AbPCrRoswqE8PorPaemPZIs7PEa7zdmuaXb2qNom7AEA7a9dKrK
 jxDiKwjiNfq2c0r+jH0vBOrgrAALZoZuXrb6O0D5Ee9XL2XnIitiX+xPEUdtiIUztTIflGBRl
 qCHcYKFNLCQbhSGeaA/bo7dZNKbZH2osJB4JaFOEgN8UCra0OFaGfK0pfNaOUp58bisqdTEua
 WB2sK4AnnqD+GfBHan7kZh0qilgFMcY9OjiM8tgLYg4GXyEpTXBQiSiOlZHLXImeGyiDCp8/F
 4PM4oQoVqNw9281bZTJlRWfU3fssZ2druFaP9EX91yTsX1FQZuUBEqFSF+0ev3GCLBWZLIM6t
 xHqzKt0QMCkPmLIGgrZhk6OWkC9oS3Hh/V+0zw5oOP1DVUCGYXnUqx0Clxp70G9todKT8C6fP
 LHxCv39bjGlI0XRRJrvnbcvYXq5fG8cU00Uw3uAcWx8O3k2A1ASwFLuunFjTydlyO4XihRnCJ
 la2b5/9nddndHQ2RRlm81aDSQEAL4e+jZkCoOjStObgPjB2LmXY/LBKSJNBNu4/DDA5NF17NC
 ik9ogDbeaB1/lYIJHBOO2LEyKvS+O550h5ccc0c5TNyQf3HLsM42rDfiZGL6lK1H1luEa2msC
 gQ+K4AT8Li5hdVHqPJFj9CPnwNw8RhVRs6LBN+CEYfg4jLbntMMnw+MGEgGYbnBUK3C+aHlsB
 AdW9zI9uKGcn+A=
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lfZJoZCPRYDoYTEwzYP8xtj9QfdVl9SxZ
Content-Type: multipart/mixed; boundary="ZO9s4Sft2yVHXfC5Nym17WH9jvJ54JfPp";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: linux-ext4@vger.kernel.org
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <ce9edecb-6f04-77d3-32f1-2b9de6cd3d7e@gmx.com>
Subject: mke2fs accepts block size not mentioned in its man page

--ZO9s4Sft2yVHXfC5Nym17WH9jvJ54JfPp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Just doing some tests on aarch64 with 64K page size.

Man page of mke2fs only mentions 3 valid block size: 1k, 2k, 4k.
But in real world, we can pass 64K as block size for it without any probl=
em:

  $mke2fs -F -t ext3 -b 65536 /dev/loop1
  Warning: blocksize 65536 not usable on most systems.
  mke2fs 1.45.2 (27-May-2019)
  /dev/loop1 contains a btrfs file system
  Discarding device blocks: done
  Creating filesystem with 81920 64k blocks and 81920 inodes
  Filesystem UUID: 311bb224-6d2d-44a7-9790-92c4878d6549
  [...]

It's great to see mke2fs accepts 64K as nodesize, which allows
btrfs-convert to work.
(If blocksize is default to 4K or doesn't accept 64K page size,
btrfs-convert can work but can't be mounted on system with 64K page size)=


Shouldn't the man page mention all valid values?

Thanks,
Qu


--ZO9s4Sft2yVHXfC5Nym17WH9jvJ54JfPp--

--lfZJoZCPRYDoYTEwzYP8xtj9QfdVl9SxZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0e4YYACgkQwj2R86El
/qheSwf8DPxd2eOlBmMHFJC3Ike9CwhGE0kg8LTnNWVi9PIsrnytwVU4LlTVB7mt
qVt6SqrFpdBo7jp7xWAQbuV2zX0kKXwzNLiCogy2GsMixy6og/RGpz/gvVh7ZluK
jtJ0WDNxN5ZZkjiPBJ+ydLv36BQ4JhYv0Etat1tj/2piQ8wyiMerovB+Qiz+LOzo
YugFsA9LiJkwjeR9JMDhLnhMpvhpysiYhkAQ+pCXKfDZnaVFWYJz6TUptI8QlhK1
B8IY7p6jsLHhl3h3XKkZ1buxFqtgB7MDdW88a2DIvKHrGoMJBNxA+H1HUaBGO2lJ
v+cKeCLbq5yi2HkJr2pQ/XKQo9qQ2g==
=i33W
-----END PGP SIGNATURE-----

--lfZJoZCPRYDoYTEwzYP8xtj9QfdVl9SxZ--

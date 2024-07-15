Return-Path: <linux-ext4+bounces-3260-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E115930F3F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 10:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32B61F217D0
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 08:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DCB184110;
	Mon, 15 Jul 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZEDPyHFJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48776184131
	for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030527; cv=none; b=ISrKfLTrJwSg/tzTPMEY2PdA96a/VjL1cg+iOLyddYoNxkpQOvr/iKHbtjJ8cW3e7t7bofJ73i3BFW6uNxX2kViLHRzJx634xEgODEUTxEsG5fm87jemnWR0wK4AlANoeNKMA8ciRhyAWrS++QIJiTc0WNNwKx70LqKKyxyy00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030527; c=relaxed/simple;
	bh=lswOZfQXDyMGg4u+y/G5V9sTLMt/eNMNjFexqxM+OIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=AHlPiVALA0VksC+vQZFb01GWlYVRY5SvFnWcJEZ1Yx/H7Yv3fogZH9CGSujLNA8rg/HDEkrtEpQhEz479SPFlFOFSoAeKLim4YK2tOZAVVXA0c2X0Bcz0qRMdY6tZOMxxRdde70p62uYzXWG+eM1c+w2O3fLjucJ3lo1E6TV6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZEDPyHFJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240715080157euoutp013ca0bbb356a8a4a8bf1650ae0dca791d~iVCMLqKQh0404304043euoutp01f
	for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 08:01:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240715080157euoutp013ca0bbb356a8a4a8bf1650ae0dca791d~iVCMLqKQh0404304043euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721030517;
	bh=lALA+nUhuiIHO80S6N/3iDguMtB6uxy1MQ+RhNfnOho=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZEDPyHFJ7G2EK0MR67n+ybvgySzYxv0oSeRbudqidTwNgbS0uhJ8bJtKxRsZYXMK4
	 V2iYZZOWXK1qbzXZo1rqjSFIvgmMlrBIQqJNvAEpecjh2Quj+zClyIPpW+gREuUxMA
	 sqkdVTCNVyKDM85r/+cXXtJxPq4/A2M9YKJhDNVo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240715080156eucas1p1ec93a034c9ef128aa892d0338805a0e0~iVCL9Sacd3253732537eucas1p1y;
	Mon, 15 Jul 2024 08:01:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0A.09.09620.477D4966; Mon, 15
	Jul 2024 09:01:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240715080156eucas1p16acd9999f00ee7662bcf74905c4a81da~iVCLeA2Fh3254132541eucas1p1k;
	Mon, 15 Jul 2024 08:01:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240715080156eusmtrp142fe39f97ca17dd444672524ac93672b~iVCLdcU1w1531815318eusmtrp13;
	Mon, 15 Jul 2024 08:01:56 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-17-6694d7747645
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.FE.08810.477D4966; Mon, 15
	Jul 2024 09:01:56 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240715080156eusmtip1cd6b97fec90c4d6da5b3bd971e4b88b0~iVCLNl4sF2532525325eusmtip1E;
	Mon, 15 Jul 2024 08:01:56 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 15 Jul 2024 09:01:55 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 15 Jul
	2024 09:01:55 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: Zorro Lang <zlang@redhat.com>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
 pointer dereference, address: 0000000000000000
Thread-Topic: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
	pointer dereference, address: 0000000000000000
Thread-Index: AQHa1aCD6X/z3snJnkO9kuIi2wM2gLH3Ir6AgAA7wAA=
Date: Mon, 15 Jul 2024 08:01:54 +0000
Message-ID: <ejaxnieh5h6bfeocb7gwtonirthjvpgoveqvmfnb5ebqk33uxs@4lvgdocvt55c>
In-Reply-To: <20240715042803.GM10452@mit.edu>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E419AECE8888C49AA648AC7FE5730F7@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUyMcRzA/Z63e+5Se7qO+2LCWYZSZ8wuM8WMm5eN+cPLJt30iNRdu+fi
	mLWyGCeLMXFNeblS9MKpROdqDefqlMUxecu5ImfsulJh4e6J3X+f78vv+/n+fvvRuLiYnEzv
	VutYrVqVLqNERP3DkfZ5uhdndsrtBXLFU3eYoi3vnkBxvvg1pTicPyJQ3LPfIRNJpfnaMUp5
	yPEAV36zOimlzxy5ntgqWpLCpu/ey2rjliaLdrk+1uGZA5P0H29Pz0EeiQEJaWAWwo0zBsqA
	RLSYKUdQeaGX4IMBBMO5vYgPfAhqh5+RBkQHjpSaN/L5qwi6TZ3U/6bWBivJBw4Eo7YjY5UK
	BFbvK+Q3UswcsNrNAj9LmBnQlTeA+5twxoLglu8t6S9EMPvhRIGF5JsOQGl1H8bzYmjwGnE/
	E0wU9BwppvwcyqyDjlxTYKiQmQdFbxwBGWKmgqviRyCPM1Locpdg/LXD4XKRBed5IozefU/x
	HAOPX7gRz3KoK7USPM+Aow9fUvycGLjY2D/G8dD/6hzOczSUXfLg/D7hYD/vDrwkME1C6PlQ
	PSZYAT1ltWOCCPhsqxWcRDHGoP2MQQ5jkMMY5DAGOS4i8hqSsllcRirLLVCz+2I5VQaXpU6N
	3aHJMKO/X6ht1DbYgMo/e2NbEEajFgQ0LpOEVhCndopDU1T7D7BazXZtVjrLtaApNCGThkal
	TGPFTKpKx+5h2UxW+6+K0cLJOZg8sbhX8Vt5S9iUJP0li8zsH45cP58qyG20rK5Kq3ynb3u+
	vKxDndLt8a0iuk3auLUT1OM7CrMHZfpsSc5v58JPHpHTYjhr2bRlYp+Dfdx32rvDInmpJkOi
	K+e4mh3treJtX6S+DS2MvP+UJdHquZMViw0df538BE8wzeoKW1wTdrBx2JaJYfWzOlOPVQ+V
	Y1+jRpqXr4mJ0G+0zS1ZET/uIBfX9OZDfu1zF+1rnd0wIYfQfP3pPrQo4cr1zW+3mLy5ca6Q
	K3n26psC7su7GtXKoZnfwzl7D1ql356/rLyqKG/ZyULDzeRHTq4uqT7ptk7U6dRsOLpudWFC
	mkZ3X0Zwu1Tz5+JaTvUHKegOpbEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsVy+t/xu7ol16ekGRy8w21x+QmfxemWvewW
	M+fdYbNo7fnJbrH35E5WB1aPTas62Tyazhxl9ni/7yqbx+dNcgEsUXo2RfmlJakKGfnFJbZK
	0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZj55vZS74IlnxfLtCA+NrkS5G
	Dg4JAROJpZuCuxi5OIQEljJKPFxxhLGLkRMoLiOx8ctVVghbWOLPtS42iKKPjBI7pj9ngnDO
	MEq8eDWFHcJZySjxsv8TO0gLm4CmxL6Tm8BsEQFFiVstX5hBipgF9jBKbP58D2yusEClRG//
	HlaQO0QEqiSubHCEqLeS2PFxFjOIzSKgKvG0bR4biM0r4CtxvnEJ1LJLjBJbJs9gAUlwCuhK
	zL57BuxuRgFZiUcrf4EtZhYQl7j1ZD4TxA8CEkv2nGeGsEUlXj7+B/WbjsTZ60+gfjaQ2Lp0
	HwuErSjRcewmG8QcHYkFuz9B2ZYSn27PYIawtSWWLXzNDHGcoMTJmU9YJjDKzEKyehaS9llI
	2mchaZ+FpH0BI+sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwPSy7djPzTsY5736qHeIkYmD
	8RCjBAezkgjvSpaJaUK8KYmVValF+fFFpTmpxYcYTYGBN5FZSjQ5H5jg8kriDc0MTA1NzCwN
	TC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamDTbHiokPnL023/OVDYjKdbFVs6A/9DD
	hTPPPHU7cSWN/37l+f8rCyu++tpVXDFxUL/2zbu2fH79eraDS8WaOvoe7gqwyZp12Db35s7O
	OyncUZc8Fi6JO3VXZaXtjbS0SqfnYX/FGr7zB6ztf/O617Zv8bPerTbhesWKF52dZk7dlFY8
	g9HVz6bl57EPrKr2FeLJ7XtPPJvswFRb3vc5PVvXxiZWYIHtxs0hJqE8m9ZFukS/lTsw+e3c
	NZdXPQmy82pd+eWzTXrsp5KwxcqBKgobFD5u+5V25UppzctUvov1D38y12aKhDx0DNZeL6kZ
	Mn3GzmNB/UZdvDtCtLOCfD7wSH+RvtFXydGbk2+pxFKckWioxVxUnAgAojnc5rgDAAA=
X-CMS-MailID: 20240715080156eucas1p16acd9999f00ee7662bcf74905c4a81da
X-Msg-Generator: CA
X-RootMTR: 20240715042825eucas1p2f409955112396d2777f3f2a5ef3764c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240715042825eucas1p2f409955112396d2777f3f2a5ef3764c8
References: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
	<CGME20240715042825eucas1p2f409955112396d2777f3f2a5ef3764c8@eucas1p2.samsung.com>
	<20240715042803.GM10452@mit.edu>

On Mon, Jul 15, 2024 at 12:28:03AM GMT, Theodore Ts'o wrote:
> On Sun, Jul 14, 2024 at 11:46:24AM +0800, Zorro Lang wrote:
> >=20
> > A weird kernel panic on ext4 happened when I tried to test a
> > fstests patchset:
> > https://lore.kernel.org/fstests/20240712093341.ftesijixy2yrjlxx@dell-pe=
r750-06-vm-08.rhts.eng.pek2.redhat.com/T/#med4b8d2fe14ef627519d84474b4cd1a2=
5d386f75
>=20
> I'm confused; this patch set:
>=20
> Daniel Gomez (5):
>       common/config: fix RECREATE_TEST_DEV initialization
>       common/rc: add recreation support for tmpfs
>       common/config: enable section parsing when recreation
>       common/rc: read config section mount options for scratch devs
>       common/rc: print test mount options
>=20
> seems to be mostly about how xfstest config section handling
> especially for tmpfs.  Is this realy the right patch set?  If so, I'm

Just to clarify, the changes in the patch set above will not only affect tm=
pfs
(I renamed the header in v2 because of that). Mainly because the common mou=
nt
options for both scratch and test devices were not properly handled in the =
cases
described.

> guessing that the reproducer would be very specific to the xfstests
> config.

I agree with this. Can you share Zorro your config?

My guess is that '-o acl,user_xattr' [1] options are now included in the sc=
ratch
device and they were not before. This is what patch 4 fixes. f2fs, tmpfs,
reiserfs, gfs2 and ext* will be affected as well with their respective defa=
ult
mount options.

Also, the test device will now include the default mount options if
RECREATE_TEST_DEV is enabled.

[1] From _common_mount_opts(). Snippet:

	ext2|ext3|ext4|ext4dev)
		# acls & xattrs aren't turned on by default on ext$FOO
		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
		;;

>=20
> My {kvm,gce}-xfstest setup doesn't use the config sections at
> all, but instead uses shell script fragments, since it predates config
> sections by three years --- and I need something that works well with
> sharding separate configs to run on separate cloud VM's.

Similar to the fragments, my workaround for tmpfs has been to export
TMPFS_MOUNT_OPTIONS so it had the default mount options + the config sectio=
n
mount option I was testing.

>=20
> So I'm not sure I'm going to be able to reprduce this easily using my
> test setup.  Can you translate the stack trace to source file names /

Can you confirm if you are including '-o acl,user_xattr' in all your fragme=
nts?

> line numbers?  Maybe that will give me a hint what's going on:
>=20
> > [35346.372867] Call Trace:
> > [35346.375319]  <TASK>
> > [35346.377426]  ? __die+0x20/0x70
> > [35346.380493]  ? page_fault_oops+0x116/0x230
> > [35346.384602]  ? __pfx_page_fault_oops+0x10/0x10
> > [35346.389048]  ? _raw_spin_unlock+0x29/0x50
> > [35346.393072]  ? rcu_is_watching+0x11/0xb0
> > [35346.397006]  ? exc_page_fault+0x59/0xe0
> > [35346.400854]  ? asm_exc_page_fault+0x22/0x30
> > [35346.405049]  ? folio_mark_dirty+0x2a/0xf0
> > [35346.409072]  __ext4_block_zero_page_range+0x50c/0x7b0 [ext4]
> > [35346.414809]  ext4_truncate+0xcd3/0x1210 [ext4]
>=20
> Getting line numbers for these two functions would be especially
> helpful.
>=20
> Thanks,
>=20
> 					- Ted=


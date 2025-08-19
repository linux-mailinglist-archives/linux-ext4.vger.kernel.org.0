Return-Path: <linux-ext4+bounces-9397-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08656B2CE43
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 22:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653665A1717
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C8343216;
	Tue, 19 Aug 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Y7CvcekA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0E3431F8;
	Tue, 19 Aug 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636495; cv=none; b=ndmBljaIZz0oPvHomTUPo+fs1YlqE2wb6NW+sVyU4vulk+CzNyW609RxZ0euBxMt7IRXzVAgmWVqUwgc4jJ12wvo96lPK0OZfeGpVVRyJsWkK7DJw2iJHN6BB2rD2xXjDU8olXZmlGcs7IzYEwkNfZFrNg5HEWLebeT/42p1gv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636495; c=relaxed/simple;
	bh=XsXedyb+e0/0ymR+mDGL9+ZLIljFU7NhmtueqTDLaVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V6Kw34Q4XPnvyc/zIcAUVJwpg87ISRUOzmMmK2IAJTSaL6QUolVOxLboRcutIIwZD2KSdVxeiH/aA+oy8Cy6eJxDeO0gv87p8Or0qbr0leuTVpjixAycqJXLeaQFEDFs9EcOE7RF6Dc2jB9k9MWevVMwbUnihXf58TT6S0dIxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Y7CvcekA; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1755636453; x=1756241253; i=christian@heusel.eu;
	bh=/Wr44AgFXoaYBlyvs6YRu/M5zut+USayl6NmpH4xK7s=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y7CvcekAlH5n0MGNJzDNuRXUOyA8sH9R5b3L41u4WHsof8MONhvdzk/Z3Rwudrni
	 dNMeLUXF4GRlg6buJz2IxmXB7K0FgbDMN7vqyPbHt22I8sfbAQ8cHjTfc88IjblzX
	 +E7BeG9WtDBoXIPpsHK6S2Jv12RWem4Qij+jMJww5FAr8fNwJ1nRxrZkYfH94/BST
	 76tEsMyazfuVBOOlKnDtUoj+fhzpGkymJITxGGtWn0FimekoqX06HzZnurFfpUsU2
	 OXi8bFfABhbP3BDCvTbyL8asV/X3eR2NfRwHz5BNTMJciVOgIvngX95S+ZD/fcQQt
	 Fk5xYLNm7X/cYJ/XTw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.62]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N3sZs-1uNpZN0wCG-01245y; Tue, 19 Aug 2025 22:47:33 +0200
Date: Tue, 19 Aug 2025 22:47:30 +0200
From: Christian Heusel <christian@heusel.eu>
To: Zhang Yi <yi.zhang@huawei.com>, Sasha Levin <sashal@kernel.org>, 
	Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, heftig@archlinux.org, 
	Luca Boccassi <bluca@debian.org>
Subject: [REGRESSION][STABLE] ext4: too many credits wanted / file system
 issue in v6.16.1
Message-ID: <3d7f77d2-b1f8-4d49-b36a-927a943efc2f@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ggdsov66otjwqq3"
Content-Disposition: inline
X-Provags-ID: V03:K1:Uw7gUbrUQjWaal6EjkNl1HPn2esgkeMvDfBkwkrNWrTt++PozPA
 KTW10OrXJs63BG43uVaEHcrqAVlJAHBWRVWfR4e9H22mh8WebiPwiCrl9z+YKzGu1HkDIEm
 /Yk4kWUSQslC9S+W2Thczjlmsw4X5zHHLw0Wds9SyEgT/2vTqLdc53lzl7q5yXfp+zwXluH
 ++SDeIJ/3Ce0aOe8GI7yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MmtXFU/+tGk=;AsxyEngQwZZlXbykvWvvvlF8luH
 +fQBPSedR+pvNm/6e2CuFWjhG8qbjQDkFAk5HJVrD/14+lT6oXtlfmjGOKACzwCjSOjvuE4g3
 Woc7HzKG1AvgmuGbpacv+ESeArmdI7zgxpU0cUH/meB9geepWm7wzhKgmFsN1HOogDl/0mXAi
 Ho7WIAMyMF5rrNkasziXsZrbrXnXzqPxUqet1BNFWm8x6lETfN9L9HHw5NrKVcFTEiwbOtztK
 t/QMYJWqvicCAmiGWXPHTbXpz4g9OXz5EJthyyMRMPE2TO9gY7MO7kcNIa5Qc7rEa3jaQ3HBp
 z4/ZyCRTCpzvbM1aZgTDOqvy0xG9d94kIC4679ulzVQVdI5NN7MwQpkB9E1hNxrLMqVRUr5dP
 iuPvzA2jCEtaMnT6fu59o87wgSyIOLpr02V3MoYdgo8Uut64sMmyv6BtcB+N1t0TPTwRM0KUJ
 xj9tkY5SvhRcxKNF0v7yj+rrkR2mDxrVLZcNE2qAPpwsGX6WEgPT8bcJ+V/ZRvyvFZPYrgl/f
 bLfeP55Rnfe0fq7aDI+Dhi31xBGJ5riQ+HR4zCNDWtzbbDmMnmB5lLR9ymOqYTKp/HqYIwwKV
 OX8IOqcrSPXErcSkwkgH+taIVdUX7MX1D9OI9oe2TDH6jYlOx9q5PF7mIH/k/AERNpLjXxnaA
 nx9gUs/E7miu8/D3Gd2gfxJnZg/734T65qgqGNeLnhQC0m4RR0Uo1Dt7DYOPy+jCI424dfgr/
 +TswUMOUziAhP/mK6OtBTriQ8krzjMAuSC4rSDEiEXFqlkjJNzd6GWYDIwuib4iuz4OscNQTr
 eHsbWBvBhaikb21+eEcy77qvyuN5Ey8Vy1pbIsh2iwAkNJ3xAn6qif3anYTcNWS8R2lnxK5o3
 Jt2YnvdGn5qtFGLQjJZHlSYyyk4eSGuIUsnWVeuQma8O1oYOnWdhIPg9wso6yeFZZVYDpka8w
 fXQEb0x3rMnvlT1kKlXs4gsxfJjJFqr/cfEANKoItoRfuJQVv7/7/Y81jDdLL3Z5kYAPf6I0D
 M1HCDilr4roeXiVnP8YgPhVH1KUayPPfClLVg5/LCdqYXi9g7rgIRM5ijmt+RspGvJ+0NyX1r
 z94mHNYi06NggNzaTh+/gcPEW0RvigdVM6jAALswrsD8OfsV3VpvB02j8k5+J3+1/NEOO3QX4
 QLlWTfALZ7YFNVrfXQXeqWjUIXGsdPLG2WH3Q/BJ72ouWJEpoUptB7eMHxM9ZRIQplVCwMeS3
 HLQaKlavJ1c5TDL+aEwo/6tnC/+nz8Yp5128n3B2Rhc7zfHN4VubpjQ0xzCuXyM3/TuZL7Hws
 l8T/GQY8L7FkOJHgXxQsimmZvb2uZUwGLNHA2aZhc1PK0lARkfuxCHq9j++2kCZ2I6DBBQwu+
 IuRMUjG57ZupBoYSa6FddLEvclmeWwvVDqtIGf/JQ7crrB2FMSwomcnmFnuWh5cdF9xQpWEHL
 ZY9V2VNiAqqIlZMXajZmCE0N2QXeWEy1XGDsfaTpCibFRTvQyMXJ+KOHmfonupm0uKxltsydr
 PhhAzUxCXVoTaobW38yZc7QXiWgFYpEZUQBr2w9bmESOIoXNyUui2ge1UhsUhM3hT/idSF159
 6RhjofjATyDtxK2bHk3f8hWBq43q4Xh1n+ur0Noq6/P2z9zwaXMDawO4vWDmVzzsK7SUHyjwO
 ktvC+dmFeOaVehcMbAJzXr


--5ggdsov66otjwqq3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [REGRESSION][STABLE] ext4: too many credits wanted / file system
 issue in v6.16.1
MIME-Version: 1.0

Hello everyone,

the systemd CI has [recently noticed][0] an issue within the ext4 file
system after the Arch Linux kernel was upgraded to 6.16.1. The issue is
exclusive to the stable tree and does not occur on 6.16 and not on
6.17-rc2. I have also tested 6.16.2-rc1 and it still contains the bug.

I was able to bisect the issue between 6.16 and 6.16.1 to the following
commit:

    b9c561f3f29c2 ("ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()")

The issue can be reproduced by running the tests from
[TEST-58-REPART.sh][1] by running the [systemd integration tests][2].
But if there are any suggestions I can also test myself as the initial
setup for the integration tests is a bit involved.

It is not yet clear to me whether this has real-world impact besides the
test, but the systemd devs said that it's not a particularily demanding
workflow, so I guess it is expected to work and could cause issues on
other systems too.

Also does anybody have an idea which backport could be missing?

Cheers,
Chris

[0]: https://github.com/systemd/systemd/actions/runs/17053272497/job/48345703316#step:14:233
[1]: https://github.com/systemd/systemd/blob/main/test/units/TEST-58-REPART.sh
[2]: https://github.com/systemd/systemd/blob/main/test/integration-tests/README.md

---

#regzbot introduced: b9c561f3f29c2
#regzbot title: [STABLE] ext4: too many credits wanted / file system issue in v6.16.1
#regzbot link: https://github.com/systemd/systemd/actions/runs/17053272497/job/48345703316#step:14:233

---

git bisect start
# status: waiting for both good and bad commits
# good: [038d61fd642278bab63ee8ef722c50d10ab01e8f] Linux 6.16
git bisect good 038d61fd642278bab63ee8ef722c50d10ab01e8f
# status: waiting for bad commit, 1 good commit known
# bad: [3e0969c9a8c57ff3c6139c084673ebedfc1cf14f] Linux 6.16.1
git bisect bad 3e0969c9a8c57ff3c6139c084673ebedfc1cf14f
# good: [288f1562e3f6af6d9b461eba49e75c84afa1b92c] media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check
git bisect good 288f1562e3f6af6d9b461eba49e75c84afa1b92c
# bad: [f427460a1586c2e0865f9326b71ed6e5a0f404f2] f2fs: turn off one_time when forcibly set to foreground GC
git bisect bad f427460a1586c2e0865f9326b71ed6e5a0f404f2
# bad: [5f57327f41a5bbb85ea382bc389126dd7b8f2d7b] scsi: elx: efct: Fix dma_unmap_sg() nents value
git bisect bad 5f57327f41a5bbb85ea382bc389126dd7b8f2d7b
# good: [9143c604415328d5dcd4d37b8adab8417afcdd21] leds: pca955x: Avoid potential overflow when filling default_label (take 2)
git bisect good 9143c604415328d5dcd4d37b8adab8417afcdd21
# good: [9c4f20b7ac700e4b4377f85e36165a4f6ca85995] RDMA/hns: Fix accessing uninitialized resources
git bisect good 9c4f20b7ac700e4b4377f85e36165a4f6ca85995
# good: [0b21d1962bec2e660c22c4c4231430f97163dcf8] perf tests bp_account: Fix leaked file descriptor
git bisect good 0b21d1962bec2e660c22c4c4231430f97163dcf8
# good: [3dbe96d5481acd40d6090f174d2be8433d88716d] clk: thead: th1520-ap: Correctly refer the parent of osc_12m
git bisect good 3dbe96d5481acd40d6090f174d2be8433d88716d
# bad: [c6714f30ef88096a8da9fcafb6034dc4e9aa467d] clk: sunxi-ng: v3s: Fix de clock definition
git bisect bad c6714f30ef88096a8da9fcafb6034dc4e9aa467d
# bad: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
git bisect bad b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8
# first bad commit: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()

--5ggdsov66otjwqq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmik4uIACgkQwEfU8yi1
JYXsfw/+LeRYCYO/JU/3jmVbTwwTFJPSblF7NedBQTMkouUQcQqjYIZPUHw4Y9co
dI94iPBhTd4zoWKTXQU40GkeV5wHrNO+PJSUFTTLXhjtFdPDosX9CLVSYNOAf4Hg
/bI9hqjOtzSXyHme+sa4hczPuqWBgK8FNtpHp41f3epeCftWE5EV9Hfa4Gu8gD8+
6pgewpn04k1FnOW+27eH+wDmclGiGLohY1qk6lI0ljTntshRpk8T2vGbCxv6KWLc
M4qDlQ3k6KJgifGFiOjNaOScxhmlE0f2zUxQB6jDlbR1uiO1baThuxs2FHtAQOZL
ANg6H5IgJRkiOk4rAE7N5AA3oMi7EMkMh3zo8a5E08x8adZFM5S7jPttSAnyqib2
M4voJh6yDMj4fNSyNQkwtmDg9RkQeBY4bXN9eYpHK3fTuS8D7CfRegDPrGxCI3Jf
WQKGWyUipo+IYG9nmei9jsGqIg7lh2qzsH9jPuip+PeOVIrdjzvHbgUvOZKWbUuL
h1Sj4R+4H9PkUdv8/TEUMEeriew+MtfPb0Bd4PIT8RAMo42tjsBBGj0lUMzfw3bp
6uCfjOVo/IsCvdk0msdxzpOYbUTHk4VZRWOhU9fpcW03PINaRNGBzt9d/WDSssab
PvImIYOOQoJJFjSI+Jw8vVxK3d9TnZRW6r496U7UK64dNr0fG3k=
=2G9b
-----END PGP SIGNATURE-----

--5ggdsov66otjwqq3--


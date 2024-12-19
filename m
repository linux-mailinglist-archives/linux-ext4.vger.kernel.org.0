Return-Path: <linux-ext4+bounces-5756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2949F7144
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 01:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AD916B264
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 00:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953629A5;
	Thu, 19 Dec 2024 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L4rXy5XF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4922111;
	Thu, 19 Dec 2024 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567281; cv=none; b=kNVz5c1h+Hrdk6GT+ZV0lPBvbcHUT7dKJ1ztuWvL9aCoIFa51fooTt2AAdcIGw5rdAGadd9AM7et8260wiaSRNiY1/UzSFTmMv493nBxDT/j/Iiyc77im2tkfvhMcZcrnImPMw6K7vevDKt0n/TxRmZx5czsDlYgdhIuBz00jss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567281; c=relaxed/simple;
	bh=h6S25o0SG3gLgUs9UKXGIThIKIMebvLTP4yLOaVadJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR4pgVVsGzrF46hdn7lAaOHWSEX+uyEmf6BjZm/h9v6Qo3ebiJRlwVpVmCCZaB8cXldBhV81AGpvLxY974VIWpVTuPVlG7Z0K0mzQZwcOIODyAPmheIW2znYOLV0CYORn0wty+jZ2w6YGDxmzBw3BPg8KIZRp/lzPJGCJvMy5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L4rXy5XF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734567262; x=1735172062; i=quwenruo.btrfs@gmx.com;
	bh=h6S25o0SG3gLgUs9UKXGIThIKIMebvLTP4yLOaVadJg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L4rXy5XFI5hjndZaaiFL7w3Pkr29nwXy4BvoeKovKxHqRybOgVNM/YbVarf0aZWn
	 7Hul7rQ44gmM6Lkw7ELl404+g8aTuHetrQrMnPrIJ1mfemOr5EKoYc3o6CY+BZBfG
	 Fvq/Xu2ITpeWRkLQ1nw6GGpgxMElnw15jnkUcsKzHjZmYriCEN0EiKXrZprtFo7bz
	 SGo9z3/bfj4hTw3BSsvxbZJavgcn08VoIsEDi++UYK9MNnptMZoKeFJeV+NPITx4r
	 QGXmBqIotXTO0z2ImUEs0au7oVX78Kendwf9KF4LfNrgUyiaNcJIE2Q4p7mCOKw0E
	 /Gz/fQb8oTLMWA7LsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1tWtu11jc0-013rLl; Thu, 19
 Dec 2024 01:14:22 +0100
Message-ID: <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
Date: Thu, 19 Dec 2024 10:44:12 +1030
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
To: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
 open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Linux btrfs <linux-btrfs@vger.kernel.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Qu Wenruo <wqu@suse.com>,
 David Sterba <dsterba@suse.com>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+JbeeomNhzPg8OZb8M16BCzk9xOZoJH2uPFDDgAW4KWakGxhun1
 wPB7N3r7xe9QR1S6W4tGytMSw5Mm5p6RYZjXj020cIn6EtuAcHrnvQk9xWTfBmcNV5A2hIo
 0408csR7XUIvhVdAiY4z6wZHcJWJT2G9raCm+eg50r4QZsOxEsRh5e0uUntdLxtiFZLOAjm
 6VsIKNpH9/jKBufWn26Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W6Yuc5pK2zY=;mV0vuKijF+Z7hN91CV8XMPnhOR7
 1mswzh/6W1uldFAIdeXjk0npE5A6r0Nsk/RNekQG44ySQM72w11/XhlI7XNpeDnc802WungpR
 S2EiKwNxtJpYQNs4Mt7ORxzRAwjnH/c87W3ni8aufzE6BgLvUaQWnrZaRE/Ub7Zx6moXUdFFH
 wHqVWIOIVZ7bT6r5dFjpNP3m4JO8g0/Yk6/SQfzd4WlmVl9zQBB8TcwETBPLSiGygQF0XPU8m
 o6FAVpGYuJnsspTwwH1LXhuqn6xG1xW7BXn4V9PTxCHEsRbVByjXfok6Vjmze3eff6c65CvVz
 YzZtXmlMh1W/6qtnPbcg+y8WYfGHqUfTuGO1nvi9K14b+7J5T4433h9ScHtoCIR9gOoq6Vmpi
 NDIcaCaRK1iRFevDahAKh/6a1DqZkCkTVyIfsWAhsEkSXFy9zK1u1ZvG5HZxVM38a9ApcujsR
 WjLBb4IG6oelWYPAcz+FcXB0h3VMWJHBly4u0+8sW6WbcNXh7weR5KUqczbiybpphET1eN6e5
 ohWdvLV0iVxg+Bti0sPP7A5CPOziP0+rWw4AvDtGMyB6dYGomTGnLCg47GDgRYLrDqToDraBM
 krscW+F4HEPBOfr/M4lIEcqLX5vvoIo0sSbigtpQbLaQ+PR889JzmVP4KIGcI6Hwzl6cRvDVk
 IKBvAXJny74kx+0jZhyshmnF2rfPYmPWXzd4KEdj7ooFfLSvaBhQm+v6qFNnIaEKNAoBi/UH5
 sMHwIYvepA9Yli3GFP80iKQYbASEY/EchLacvwwSko9iqk0rxrkeO4119YbaghAl9YlL+qMkv
 1hlYGRBSPfM8iWOy1yk5j9dRO0dp2U43X4jW8qwK7p66vGn4NdtWdZVMvyDIjOcK9Uqpky8MB
 qXhjqHoef4Zr0YR9muMfhTwVM4OiIgDOU2J/T18WFeiwLAUVCxLyz1IymG78wt3+vNO76mq+e
 f7yVLVIfh0nHx00cMIpjD9hm1pvLifPpZMueB2O61MOV2bN8KCCJSX/Ne4DF07Vtf/SfG7Sto
 5dJ7uQJIQoTKHsuJmm1bNuLELX6Kqt/WkEZ8X5Do1bon6GfE/D/6ObrefqYtHnkNkkZudSttF
 uBjOW4bt8vLxoJ4lTLgIrYiNFV7RIt



=E5=9C=A8 2024/12/19 06:37, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/12/19 02:22, Naresh Kamboju =E5=86=99=E9=81=93:
>> On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju
>> <naresh.kamboju@linaro.org> wrote:
>>>
>>> The following kernel crash noticed on qemu-arm64 while running the
>>> Linux next-20241210 tag (to next-20241218) kernel built with
>>> =C2=A0 - CONFIG_ARM64_64K_PAGES=3Dy
>>> =C2=A0 - CONFIG_ARM64_16K_PAGES=3Dy
>>> and running LTP smoke tests.
>>>
>>> First seen on Linux next-20241210.
>>> =C2=A0=C2=A0 Good: next-20241209
>>> =C2=A0=C2=A0 Bad:=C2=A0 next-20241210 and next-20241218
>>>
>>> qemu-arm64: 9.1.2
>>>
>>> Anyone noticed this ?
>>>
>>
>> Anders bisected this reported regression and found,
>> # first bad commit:
>> =C2=A0=C2=A0 [9c1d66793b6faa00106ae4c866359578bfc012d2]
>> =C2=A0=C2=A0 btrfs: validate system chunk array at btrfs_validate_super=
()
>
> Weird, I run daily fstests with 64K page sized aarch64 VM.
>
> But never hit a crash on this.
>
> And the original crash call trace only points back to ext4, not btrfs.
>
> Mind to test it with KASAN enabled?

Another thing is, how do you enable both 16K and 64K page size at the
same time?

The Kconfig should only select one page size IIRC.

And for the bisection, does it focus on the test failure or the crash?

For the test failure it looks like some older btrfs-progs, causing
invalid system chunk items, which got caught by the newer and more
strict sanity checks.

For the crash, unfortunately I'm not able to reproduce using fstests.
Will try LTP soon.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>>
>>> Test log:
>>> ---------
>>> tst_test.c:1799: TINFO: =3D=3D=3D Testing on btrfs =3D=3D=3D
>>> tst_test.c:1158: TINFO: Formatting /dev/loop0 with btrfs opts=3D''
>>> extra opts=3D''
>>> <6>[=C2=A0=C2=A0 71.880167] BTRFS: device fsid
>>> d492b571-012c-40a9-b8e1-efc97408d3bc devid 1 transid 6 /dev/loop0
>>> (7:0) scanned by chdir01 (476)
>>> tst_test.c:1170: TINFO: Mounting /dev/loop0 to
>>> /tmp/LTP_chdJeywxF/mntpoint fstyp=3Dbtrfs flags=3D0
>>> <6>[=C2=A0=C2=A0 71.960245] BTRFS info (device loop0): first mount of =
filesystem
>>> d492b571-012c-40a9-b8e1-efc97408d3bc
>>> <6>[=C2=A0=C2=A0 71.970667] BTRFS info (device loop0): using crc32c
>>> (crc32c-arm64) checksum algorithm
>>> <2>[=C2=A0=C2=A0 71.993486] BTRFS critical (device loop0): corrupt sup=
erblock
>>> syschunk array: chunk_start=3D22020096, invalid chunk sectorsize, have
>>> 65536 expect 4096
>>> <3>[=C2=A0=C2=A0 71.995802] BTRFS error (device loop0): superblock con=
tains
>>> fatal errors
>>> <3>[=C2=A0=C2=A0 72.014538] BTRFS error (device loop0): open_ctree fai=
led: -22
>>> tst_test.c:1170: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil))
>>> failed: EINVAL (22)
>>>
>>> Summary:
>>> passed=C2=A0=C2=A0 48
>>> failed=C2=A0=C2=A0 0
>>> broken=C2=A0=C2=A0 1
>>> skipped=C2=A0 0
>>> warnings 0
>>>
>>> Duration: 7.002s
>>>
>>>
>>> =3D=3D=3D=3D=3D symlink01 =3D=3D=3D=3D=3D
>>> command: symlink01
>>> <12>[=C2=A0=C2=A0 72.494428] /usr/local/bin/kirk[253]: starting test s=
ymlink01
>>> (symlink01)
>>> symlink01=C2=A0=C2=A0=C2=A0 0=C2=A0 TINFO=C2=A0 :=C2=A0 Using /tmp/LTP=
_symmsYXet as tmpdir (tmpfs
>>> filesystem)
>>> symlink01=C2=A0=C2=A0=C2=A0 1=C2=A0 TPASS=C2=A0 :=C2=A0 Creation of sy=
mbolic link file to no object
>>> file is ok
>>> symlink01=C2=A0=C2=A0=C2=A0 2=C2=A0 TPASS=C2=A0 :=C2=A0 Creation of sy=
mbolic link file to no object
>>> file is ok
>>> symlink01=C2=A0=C2=A0=C2=A0 3=C2=A0 TPASS=C2=A0 :=C2=A0 Creation of sy=
mbolic link file and object
>>> file via symbolic link is ok
>>> symlink01=C2=A0=C2=A0=C2=A0 4=C2=A0 TPASS=C2=A0 :=C2=A0 Creating an ex=
isting symbolic link file
>>> error is caught
>>> symlink01=C2=A0=C2=A0=C2=A0 5=C2=A0 TPASS=C2=A0 :=C2=A0 Creating a sym=
bolic link which exceeds
>>> maximum pathname error is caught
>>>
>>> Summary:
>>> passed=C2=A0=C2=A0=C2=A0 5
>>> failed=C2=A0=C2=A0=C2=A0 0
>>> broken=C2=A0=C2=A0=C2=A0 0
>>> skipped=C2=A0=C2=A0 0
>>> warnings=C2=A0 0
>>>
>>> Duration: 0.052s
>>>
>>>
>>> =3D=3D=3D=3D=3D stat04 =3D=3D=3D=3D=3D
>>> command: stat04
>>> <12>[=C2=A0=C2=A0 72.966706] /usr/local/bin/kirk[253]: starting test s=
tat04
>>> (stat04)
>>> tst_buffers.c:57: TINFO: Test is using guarded buffers
>>> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staEABwgV as tmpdir (tmpfs
>>> filesystem)
>>> <6>[=C2=A0=C2=A0 73.447708] loop0: detected capacity change from 0 to =
614400
>>> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
>>> tst_test.c:1860: TINFO: LTP version: 20240930
>>> tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc3-next-20241218 #1 SMP
>>> PREEMPT @1734498806 aarch64
>>> tst_test.c:1703: TINFO: Timeout per run is 0h 05m 24s
>>> stat04.c:60: TINFO: Formatting /dev/loop0 with ext2 opts=3D'-b 4096'
>>> extra opts=3D''
>>> mke2fs 1.47.1 (20-May-2024)
>>> <3>[=C2=A0=C2=A0 73.859753] operation not supported error, dev loop0, =
sector
>>> 614272 op 0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
>>> stat04.c:61: TINFO: Mounting /dev/loop0 to /tmp/LTP_staEABwgV/mntpoint
>>> fstyp=3Dext2 flags=3D0
>>> <6>[=C2=A0=C2=A0 73.939263] EXT4-fs (loop0): mounting ext2 file system=
 using the
>>> ext4 subsystem
>>> <1>[=C2=A0=C2=A0 73.946378] Unable to handle kernel paging request at =
virtual
>>> address a8fff00000c0c224
>>> <1>[=C2=A0=C2=A0 73.947878] Mem abort info:
>>> <1>[=C2=A0=C2=A0 73.949153]=C2=A0=C2=A0 ESR =3D 0x0000000096000005
>>> <1>[=C2=A0=C2=A0 73.959105]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL)=
, IL =3D 32 bits
>>> <1>[=C2=A0=C2=A0 73.960031]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
>>> <1>[=C2=A0=C2=A0 73.960349]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
>>> <1>[=C2=A0=C2=A0 73.960638]=C2=A0=C2=A0 FSC =3D 0x05: level 1 translat=
ion fault
>>> <1>[=C2=A0=C2=A0 73.961005] Data abort info:
>>> <1>[=C2=A0=C2=A0 73.961293]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000005,=
 ISS2 =3D 0x00000000
>>> <1>[=C2=A0=C2=A0 73.963739]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0, TnD =3D 0=
, TagAccess =3D 0
>>> <1>[=C2=A0=C2=A0 73.964980]=C2=A0=C2=A0 GCS =3D 0, Overlay =3D 0, Dirt=
yBit =3D 0, Xs =3D 0
>>> <1>[=C2=A0=C2=A0 73.967132] [a8fff00000c0c224] address between user an=
d kernel
>>> address ranges
>>> <0>[=C2=A0=C2=A0 73.968923] Internal error: Oops: 0000000096000005 [#1=
] PREEMPT
>>> SMP
>>> <4>[=C2=A0=C2=A0 73.970516] Modules linked in: btrfs blake2b_generic x=
or
>>> xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
>>> sha512_arm64 fuse drm backlight ip_tables x_tables
>>> <4>[=C2=A0=C2=A0 73.974237] CPU: 1 UID: 0 PID: 529 Comm: stat04 Not ta=
inted
>>> 6.13.0-rc3-next-20241218 #1
>>> <4>[=C2=A0=C2=A0 73.975359] Hardware name: linux,dummy-virt (DT)
>>> <4>[=C2=A0=C2=A0 73.977170] pstate: 62402009 (nZCv daif +PAN -UAO +TCO=
 -DIT
>>> -SSBS BTYPE=3D--)
>>> <4>[ 73.978295] pc : __kmalloc_node_noprof (mm/slub.c:492
>>> mm/slub.c:505 mm/slub.c:532 mm/slub.c:3993 mm/slub.c:4152
>>> mm/slub.c:4293 mm/slub.c:4300)
>>> <4>[ 73.980200] lr : alloc_cpumask_var_node (lib/cpumask.c:62
>>> (discriminator 2))
>>> <4>[=C2=A0=C2=A0 73.981466] sp : ffff80008258f950
>>> <4>[=C2=A0=C2=A0 73.982228] x29: ffff80008258f970 x28: ffffa9338939800=
0 x27:
>>> 0000000000000001
>>> <4>[=C2=A0=C2=A0 73.983875] x26: fffffc1fc0303080 x25: 00000000fffffff=
f x24:
>>> a8fff00000c0c224
>>> <4>[=C2=A0=C2=A0 73.985649] x23: 0000000000000cc0 x22: ffffa93387f51d0=
c x21:
>>> 00000000ffffffff
>>> <4>[=C2=A0=C2=A0 73.986188] x20: fff00000c0010400 x19: 000000000000000=
8 x18:
>>> 0000000000000000
>>> <4>[=C2=A0=C2=A0 73.988686] x17: fff056cd748b0000 x16: ffff80008002000=
0 x15:
>>> 0000000000000000
>>> <4>[=C2=A0=C2=A0 73.990276] x14: 0000000000002a66 x13: 000000000000400=
0 x12:
>>> 0000000000000001
>>> <4>[=C2=A0=C2=A0 73.992401] x11: 0000000000000002 x10: 000000000000400=
1 x9 :
>>> ffffa93387f51d0c
>>> <4>[=C2=A0=C2=A0 73.993108] x8 : fff00000c2c99240 x7 : 000000000000000=
1 x6 :
>>> 0000000000000001
>>> <4>[=C2=A0=C2=A0 73.993886] x5 : fff00000c4879800 x4 : 000000000000000=
0 x3 :
>>> 000000000033a401
>>> <4>[=C2=A0=C2=A0 73.995550] x2 : 0000000000000000 x1 : a8fff00000c0c22=
4 x0 :
>>> fff00000c0010400
>>> <4>[=C2=A0=C2=A0 73.997017] Call trace:
>>> <4>[ 73.998266] __kmalloc_node_noprof+0x100/0x4a0 P
>>> <4>[ 73.999716] alloc_cpumask_var_node (lib/cpumask.c:62
>>> (discriminator 2))
>>> <4>[ 74.000942] alloc_workqueue_attrs (kernel/workqueue.c:4624
>>> (discriminator 1))
>>> <4>[ 74.001327] apply_wqattrs_prepare (kernel/workqueue.c:5263)
>>> <4>[ 74.003095] apply_workqueue_attrs_locked (kernel/workqueue.c:5351)
>>> <4>[ 74.003855] alloc_workqueue (kernel/workqueue.c:5722
>>> (discriminator 1) kernel/workqueue.c:5772 (discriminator 1))
>>> <4>[ 74.005398] ext4_fill_super (fs/ext4/super.c:5484 fs/ext4/
>>> super.c:5722)
>>> <4>[ 74.006132] get_tree_bdev_flags (fs/super.c:1636)
>>> <4>[ 74.007624] get_tree_bdev (fs/super.c:1660)
>>> <4>[ 74.008664] ext4_get_tree (fs/ext4/super.c:5755)
>>> <4>[ 74.009423] vfs_get_tree (fs/super.c:1814)
>>> <4>[ 74.009703] path_mount (fs/namespace.c:3556 fs/namespace.c:3883)
>>> <4>[ 74.010608] __arm64_sys_mount (fs/namespace.c:3896
>>> fs/namespace.c:4107 fs/namespace.c:4084 fs/namespace.c:4084)
>>> <4>[ 74.011527] invoke_syscall.constprop.0
>>> (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
>>> <4>[ 74.012798] do_el0_svc (include/linux/thread_info.h:135
>>> (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
>>> arch/arm64/kernel/syscall.c:151 (discriminator 2))
>>> <4>[ 74.014042] el0_svc (arch/arm64/include/asm/irqflags.h:82
>>> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
>>> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
>>> arch/arm64/kernel/entry-common.c:165 (discriminator 1)
>>> arch/arm64/kernel/entry-common.c:178 (discriminator 1)
>>> arch/arm64/kernel/entry-common.c:745 (discriminator 1))
>>> <4>[ 74.014942] el0t_64_sync_handler (arch/arm64/kernel/entry-
>>> common.c:763)
>>> <4>[ 74.015917] el0t_64_sync (arch/arm64/kernel/entry.S:600)
>>> <0>[ 74.017042] Code: 12800019 b9402a82 aa1803e1 aa1403e0 (f8626b1a)
>>> All code
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0=C2=A0 0: 12800019 mov w25, #0xffffffff=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // #-1
>>> =C2=A0=C2=A0=C2=A0 4: b9402a82 ldr w2, [x20, #40]
>>> =C2=A0=C2=A0=C2=A0 8: aa1803e1 mov x1, x24
>>> =C2=A0=C2=A0=C2=A0 c: aa1403e0 mov x0, x20
>>> =C2=A0=C2=A0 10:* f8626b1a ldr x26, [x24, x2] <-- trapping instruction
>>>
>>> Code starting with the faulting instruction
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0=C2=A0 0: f8626b1a ldr x26, [x24, x2]
>>> <4>[=C2=A0=C2=A0 74.019014] ---[ end trace 0000000000000000 ]---
>>> tst_test.c:1763: TBROK: Test killed by SIGSEGV!
>>>
>>> Summary:
>>> passed=C2=A0=C2=A0 0
>>> failed=C2=A0=C2=A0 0
>>> broken=C2=A0=C2=A0 1
>>> skipped=C2=A0 0
>>> warnings 0
>>> tst_device.c:269: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO
>>> for too long
>>> Tainted kernel: kernel died recently, i.e. there was an OOPS or BUG[0m
>>> Tainted kernel: ['kernel died recently, i.e. there was an OOPS or
>>> BUG'][0m
>>> Restarting SUT: host
>>>
>>> =3D=3D=3D=3D=3D df01_sh =3D=3D=3D=3D=3D
>>> command: df01.sh
>>> <12>[=C2=A0=C2=A0 76.370093] /usr/local/bin/kirk[253]: starting test d=
f01_sh
>>> (df01.sh)
>>> Tainted kernel: kernel died recently, i.e. there was an OOPS or BUG[0m
>>> <1>[=C2=A0=C2=A0 76.603065] Unable to handle kernel paging request at =
virtual
>>> address a8fff00000c0c224
>>> <1>[=C2=A0=C2=A0 76.603922] Mem abort info:
>>> <1>[=C2=A0=C2=A0 76.604197]=C2=A0=C2=A0 ESR =3D 0x0000000096000005
>>> <1>[=C2=A0=C2=A0 76.604638]=C2=A0=C2=A0 EC =3D 0x25: DABT (current EL)=
, IL =3D 32 bits
>>> <1>[=C2=A0=C2=A0 76.605128]=C2=A0=C2=A0 SET =3D 0, FnV =3D 0
>>> <1>[=C2=A0=C2=A0 76.606996]=C2=A0=C2=A0 EA =3D 0, S1PTW =3D 0
>>> <1>[=C2=A0=C2=A0 76.607274]=C2=A0=C2=A0 FSC =3D 0x05: level 1 translat=
ion fault
>>> <1>[=C2=A0=C2=A0 76.607611] Data abort info:
>>> <1>[=C2=A0=C2=A0 76.607897]=C2=A0=C2=A0 ISV =3D 0, ISS =3D 0x00000005,=
 ISS2 =3D 0x00000000
>>> <1>[=C2=A0=C2=A0 76.609765]=C2=A0=C2=A0 CM =3D 0, WnR =3D 0, TnD =3D 0=
, TagAccess =3D 0
>>> <1>[=C2=A0=C2=A0 76.610958]=C2=A0=C2=A0 GCS =3D 0, Overlay =3D 0, Dirt=
yBit =3D 0, Xs =3D 0
>>> <1>[=C2=A0=C2=A0 76.611652] [a8fff00000c0c224] address between user an=
d kernel
>>> address ranges
>>> <0>[=C2=A0=C2=A0 76.612130] Internal error: Oops: 0000000096000005 [#2=
] PREEMPT
>>> SMP
>>> <4>[=C2=A0=C2=A0 76.613305] Modules linked in: btrfs blake2b_generic x=
or
>>> xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
>>> sha512_arm64 fuse drm backlight ip_tables x_tables
>>> <4>[=C2=A0=C2=A0 76.617688] CPU: 1 UID: 0 PID: 553 Comm: df01.sh Taint=
ed: G
>>> D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.=
13.0-rc3-next-20241218 #1
>>> <4>[=C2=A0=C2=A0 76.620869] Tainted: [D]=3DDIE
>>> <4>[=C2=A0=C2=A0 76.621184] Hardware name: linux,dummy-virt (DT)
>>> <4>[=C2=A0=C2=A0 76.622671] pstate: 63402009 (nZCv daif +PAN -UAO +TCO=
 +DIT
>>> -SSBS BTYPE=3D--)
>>> <4>[ 76.623693] pc : __kmalloc_node_noprof (mm/slub.c:492
>>> mm/slub.c:505 mm/slub.c:532 mm/slub.c:3993 mm/slub.c:4152
>>> mm/slub.c:4293 mm/slub.c:4300)
>>> <4>[ 76.624180] lr : __vmalloc_node_range_noprof
>>> (include/linux/slab.h:922 mm/vmalloc.c:3647 mm/vmalloc.c:3846)
>>> <4>[=C2=A0=C2=A0 76.625290] sp : ffff80008258fa90
>>> <4>[=C2=A0=C2=A0 76.626275] x29: ffff80008258fab0 x28: fff00000c2c98e8=
0 x27:
>>> fff00000c48fd100
>>> <4>[=C2=A0=C2=A0 76.626966] x26: fffffc1fc0303080 x25: 00000000fffffff=
f x24:
>>> a8fff00000c0c224
>>> <4>[=C2=A0=C2=A0 76.627599] x23: 0000000000000dc0 x22: ffffa93386d8739=
0 x21:
>>> 00000000ffffffff
>>> <4>[=C2=A0=C2=A0 76.628603] x20: fff00000c0010400 x19: 000000000000000=
8 x18:
>>> 0000000000000000
>>> <4>[=C2=A0=C2=A0 76.629618] x17: 0000000000000000 x16: ffff80008218000=
0 x15:
>>> ffff800080000000
>>> <4>[=C2=A0=C2=A0 76.630999] x14: fff00000c00203f0 x13: 00000ffff800082=
1 x12:
>>> 0000000000000000
>>> <4>[=C2=A0=C2=A0 76.632089] x11: 0000000000000000 x10: 000000000000000=
0 x9 :
>>> ffffa93386d87390
>>> <4>[=C2=A0=C2=A0 76.634293] x8 : ffff80008258f908 x7 : fff00000c2c98e8=
0 x6 :
>>> 0000000000010000
>>> <4>[=C2=A0=C2=A0 76.634816] x5 : ffffa93389379000 x4 : 000000000000000=
0 x3 :
>>> 000000000033b801
>>> <4>[=C2=A0=C2=A0 76.636355] x2 : 0000000000000000 x1 : a8fff00000c0c22=
4 x0 :
>>> fff00000c0010400
>>> <4>[=C2=A0=C2=A0 76.638309] Call trace:
>>> <4>[ 76.639031] __kmalloc_node_noprof+0x100/0x4a0 P
>>> <4>[ 76.640890] __vmalloc_node_range_noprof (include/linux/slab.h:922
>>> mm/vmalloc.c:3647 mm/vmalloc.c:3846)
>>> <4>[ 76.641267] copy_process (kernel/fork.c:314 (discriminator 1)
>>> kernel/fork.c:1061 (discriminator 1) kernel/fork.c:2176 (discriminator
>>> 1))
>>> <4>[ 76.641795] kernel_clone (kernel/fork.c:2758)
>>> <4>[ 76.643003] __do_sys_clone (kernel/fork.c:2902)
>>> <4>[ 76.644078] __arm64_sys_clone (kernel/fork.c:2869)
>>> <4>[ 76.645306] invoke_syscall.constprop.0
>>> (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
>>> <4>[ 76.646337] do_el0_svc (include/linux/thread_info.h:135
>>> (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
>>> arch/arm64/kernel/syscall.c:151 (discriminator 2))
>>> <4>[ 76.646974] el0_svc (arch/arm64/include/asm/irqflags.h:82
>>> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
>>> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
>>> arch/arm64/kernel/entry-common.c:165 (discriminator 1)
>>> arch/arm64/kernel/entry-common.c:178 (discriminator 1)
>>> arch/arm64/kernel/entry-common.c:745 (discriminator 1))
>>> <4>[ 76.647709] el0t_64_sync_handler (arch/arm64/kernel/entry-
>>> common.c:763)
>>> <4>[ 76.649032] el0t_64_sync (arch/arm64/kernel/entry.S:600)
>>> <0>[ 76.649724] Code: 12800019 b9402a82 aa1803e1 aa1403e0 (f8626b1a)
>>>
>>> <trim>
>>>
>>> All code
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0=C2=A0 0: 12800019 mov w25, #0xffffffff=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // #-1
>>> =C2=A0=C2=A0=C2=A0 4: b9402a82 ldr w2, [x20, #40]
>>> =C2=A0=C2=A0=C2=A0 8: aa1803e1 mov x1, x24
>>> =C2=A0=C2=A0=C2=A0 c: aa1403e0 mov x0, x20
>>> =C2=A0=C2=A0 10:* f8626b1a ldr x26, [x24, x2] <-- trapping instruction
>>>
>>> Code starting with the faulting instruction
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =C2=A0=C2=A0=C2=A0 0: f8626b1a ldr x26, [x24, x2]
>>> =C2=A0 <4>[=C2=A0=C2=A0 79.647693] ---[ end trace 0000000000000000 ]--=
-
>>> =C2=A0 <0>[=C2=A0=C2=A0 79.649260] Kernel panic - not syncing: Attempt=
ed to kill init!
>>> exitcode=3D0x0000000b
>>> =C2=A0 <2>[=C2=A0=C2=A0 79.650229] SMP: stopping secondary CPUs
>>> =C2=A0 <0>[=C2=A0=C2=A0 79.651558] Kernel Offset: 0x293306a00000 from
>>> 0xffff800080000000
>>> =C2=A0 <0>[=C2=A0=C2=A0 79.652015] PHYS_OFFSET: 0x40000000
>>> =C2=A0 <0>[=C2=A0=C2=A0 79.652461] CPU features: 0x000,000000d0,60bef2=
d8,cb7e7f3f
>>> =C2=A0 <0>[=C2=A0=C2=A0 79.653039] Memory Limit: none
>>> =C2=A0 <0>[=C2=A0=C2=A0 79.653854] ---[ end Kernel panic - not syncing=
: Attempted to
>>> kill init! exitcode=3D0x0000000b ]---
>>>
>>>
>>> Links:
>>> -------
>>> =C2=A0 - https://qa-reports.linaro.org/lkft/linux-next-master/build/
>>> next-20241218/testrun/26396709/suite/log-parser-test/test/panic-
>>> multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/
>>> history/
>>> =C2=A0 - https://qa-reports.linaro.org/lkft/linux-next-master/build/
>>> next-20241212/testrun/26277241/suite/log-parser-test/test/panic-
>>> multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/log
>>> =C2=A0 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/
>>> tests/2qNMDhPFtR8j185QSvZMn989u84
>>> =C2=A0 - https://storage.tuxsuite.com/public/linaro/lkft/
>>> builds/2qNMCQazNJteQLGCw7MnMtUwzkD/
>>> =C2=A0 - https://qa-reports.linaro.org/lkft/linux-next-master/build/
>>> next-20241211/testrun/26266202/suite/log-parser-test/test/panic-
>>> multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/
>>> details/
>>>
>>>
>>> metadata:
>>> ----
>>> =C2=A0=C2=A0 git describe: next-20241210..next-20241218
>>> =C2=A0=C2=A0 git repo: https://git.kernel.org/pub/scm/linux/kernel/git=
/next/
>>> linux-next.git
>>> =C2=A0=C2=A0 kernel config:
>>> https://storage.tuxsuite.com/public/linaro/lkft/
>>> builds/2qNMCQazNJteQLGCw7MnMtUwzkD/config
>>> =C2=A0=C2=A0 build url: https://storage.tuxsuite.com/public/linaro/lkf=
t/
>>> builds/2qNMCQazNJteQLGCw7MnMtUwzkD/
>>> =C2=A0=C2=A0 toolchain: gcc-13
>>> =C2=A0=C2=A0 config: CONFIG_ARM64_64K_PAGES=3Dy, CONFIG_ARM64_16K_PAGE=
S=3Dy
>>> =C2=A0=C2=A0 arch: arm64
>>> =C2=A0=C2=A0 qemu: qemu-arm64 version 9.1.2
>>>
>>
>> --
>> Linaro LKFT
>> https://lkft.linaro.org
>>
>
>



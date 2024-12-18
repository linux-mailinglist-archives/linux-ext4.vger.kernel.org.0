Return-Path: <linux-ext4+bounces-5752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B19F6EB4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 21:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1641891CAE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 20:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E671FC0F2;
	Wed, 18 Dec 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="d3kOFPu5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ECE15530B;
	Wed, 18 Dec 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552497; cv=none; b=NS4Mpe8AZjEBMqTMXQlXLa4/5F3vi7UxRJzjrRQhH/YF2vLiAYbWiXUD6R+szOYbhVHXzl12z4VghnH55mv3zk7hzyUI0IZxllIDbdgnaUEu52nYmhuvnUZa6XqYkVrKFSgZJAS8xpww65pwSp0MbMA3D59q5p6NP+6wWDc36bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552497; c=relaxed/simple;
	bh=W6kw58QqM49zW3xGF5zrW6y1nlSLM0YfG5QPQe1TTAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+WVs8sj4h9Wsb/O+t2WccyGDur63xzEJ3iWTRTaXUrqs3e2UOfSAwyUUPoFxXgKRs4kgKE7Yg9PPYMgJEEl3Vul7an6tQvopXnrdVurG571lY4vRIFP+gPqf+mAHn6XPlcm+/0YERPsyaAHQ33ywPm7zHvGENA0DZeA96+7k68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=d3kOFPu5; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734552478; x=1735157278; i=quwenruo.btrfs@gmx.com;
	bh=gUnBG/i2F39aL0akHI7/X1bMH41G5hvoZ0PVEd3+wrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d3kOFPu5y7Sfq0lZhEcmnn398/NQrfVQv5kcOsHfRXVUGVaakq81lvf0r8MHgcYl
	 SZhFf4vQm9fkAOfp8kWQzalqmQB9w/AMJDU1glqBRYeJiXO8Qscel4IYltPYvUnRq
	 G0wjmrJ5l3mJJvcksOdlEM9ubHsmkvvx9nDjGhbyJs8ibzLZWPvMuOQ8WHRnjudVW
	 guJX/WOX6UjX0GzGQzd4TszFn04lUnE+GOo8f/Ij8ZQlMO5EZjFQlRrvbw+XRl9+A
	 wfJPXXCJ6AaF1ubU3xMdyrADzgLzHuuGLW72pML6KFXINGHQLKMfK9B6njyT2hmvn
	 CCl373eWoZiM1q+0+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjS54-1tq91b2CEc-00jadX; Wed, 18
 Dec 2024 21:07:58 +0100
Message-ID: <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
Date: Thu, 19 Dec 2024 06:37:50 +1030
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
In-Reply-To: <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zTMN64998KADLlz9cChlVMRGQDoHHhi+fCgtdtynJeYS/dtdSfj
 8NpMKs8SfmxEebvk3nltYsNxyWU8fvtoCHv3mXlL77DmJJolGdd0pETkTupB7pDlU1k2GHO
 kBk0rT1xvift8buO04QMKgeD334sPwvTXJx1RrAgUoRTcspx2wA+nGrPiTM64Ag2HTS1hU1
 MAS+1F6QqyBsCpRgnWDKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hX3W2OCyHRw=;jZM3rhSKUxEA1seHmoIacHUuIi/
 PZh4f3LVNKlKkm58hziRF7iQV+3sfuK+ncieTWfoxP67XaFG70y1Vb/A/vnGA2ZUWv6IExRPs
 oHVglr1e0RCXtFn/IHDjcXRRPPxPhHXd279cQaVKUUVO4y4/hhYYNJu0g2i7fpKjEzeZvA5J8
 GEf/A8oZEot5jR2dSEBQbprz19NyWj4JTrWvs+rbPT4H8gl3OvV2xeEJP2ZLkxwjyLwq2hcU6
 saznFZl+ohJyH/Ly/0SXht3AHcGwbLX5dpMOrsc/RkQUTC1AZoQEe0w4/HHbj+g3WTgkimMZi
 jpbeOWna34tlf5i7oPo+8ccmkCShVbNHvO8RaejX4QJocWxj9CNPsUI6BdbuVNROfs8bD+OBZ
 arFGDaHFnKoFZ2rnSsZDN8HNl8EfIeM64kE2E9tGinZ2TV47ySUl3+GcBGLBrr/A6maj37csx
 UWepxtRFh2t4uffrez8sE13KJpclwjb5r5qT/niYZ0ePaOrvEtYkI57jipraq8i1Ntp82il48
 hziwDSzV/DKMqfT4FUQmuynB3NC7ydrjiLnQKLl/jOuijL7YK2sbIVs/mPF8iQThMjU8/+oVJ
 xN+22qHyREwxUCvQ44aLVhN3jze9ggxYNov5GySWO339CKuH3e0c9k2XQw67YlKA7Vexchfa8
 kbjnz2XuDejxpVKUEuMinyUqdmAWWNzCpWlg1kqxcpjCfXu/uGPuw0gJ9Bn+OsV9fLaXUZsr1
 T9UbAw4h/cqeI12tVwSxl64LyfEtTkCTQr+zgR4OHNef6wF4O07Kd4eruBImS53B6qRmKSCzt
 /xdNo1Gi32riJ7fEcYN5Ek1TWf7rLZuZpW5W2o55IBhtPEEa+wp/Ak/orYi9aaPzE/zitcZga
 05iSVCWHHDwzbfiWvECnPG0lZH+qes3dFS5tCFW6BEumSYxdRl9ChsN2I1JvnlrlmCQOzGGd/
 K7z33ZizvIF+UILBHc3wtk+UqfK0OYcuWoq5dRyfO57k+hgDRlQWMew5EYk6phlZcyQPKvtuL
 qrzuWPz/WKgTYVwk4S1v4nh+/Pk4OKlWEeZWMSGuk6PNk3nkp2JtnQAHPzB0BqfkKHWY4MUHM
 K0cui0IG8dhoR+kwUosyw2NHjwEkf8



=E5=9C=A8 2024/12/19 02:22, Naresh Kamboju =E5=86=99=E9=81=93:
> On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
>>
>> The following kernel crash noticed on qemu-arm64 while running the
>> Linux next-20241210 tag (to next-20241218) kernel built with
>>   - CONFIG_ARM64_64K_PAGES=3Dy
>>   - CONFIG_ARM64_16K_PAGES=3Dy
>> and running LTP smoke tests.
>>
>> First seen on Linux next-20241210.
>>    Good: next-20241209
>>    Bad:  next-20241210 and next-20241218
>>
>> qemu-arm64: 9.1.2
>>
>> Anyone noticed this ?
>>
>
> Anders bisected this reported regression and found,
> # first bad commit:
>    [9c1d66793b6faa00106ae4c866359578bfc012d2]
>    btrfs: validate system chunk array at btrfs_validate_super()

Weird, I run daily fstests with 64K page sized aarch64 VM.

But never hit a crash on this.

And the original crash call trace only points back to ext4, not btrfs.

Mind to test it with KASAN enabled?

Thanks,
Qu
>
>
>> Test log:
>> ---------
>> tst_test.c:1799: TINFO: =3D=3D=3D Testing on btrfs =3D=3D=3D
>> tst_test.c:1158: TINFO: Formatting /dev/loop0 with btrfs opts=3D'' extr=
a opts=3D''
>> <6>[   71.880167] BTRFS: device fsid
>> d492b571-012c-40a9-b8e1-efc97408d3bc devid 1 transid 6 /dev/loop0
>> (7:0) scanned by chdir01 (476)
>> tst_test.c:1170: TINFO: Mounting /dev/loop0 to
>> /tmp/LTP_chdJeywxF/mntpoint fstyp=3Dbtrfs flags=3D0
>> <6>[   71.960245] BTRFS info (device loop0): first mount of filesystem
>> d492b571-012c-40a9-b8e1-efc97408d3bc
>> <6>[   71.970667] BTRFS info (device loop0): using crc32c
>> (crc32c-arm64) checksum algorithm
>> <2>[   71.993486] BTRFS critical (device loop0): corrupt superblock
>> syschunk array: chunk_start=3D22020096, invalid chunk sectorsize, have
>> 65536 expect 4096
>> <3>[   71.995802] BTRFS error (device loop0): superblock contains fatal=
 errors
>> <3>[   72.014538] BTRFS error (device loop0): open_ctree failed: -22
>> tst_test.c:1170: TBROK: mount(/dev/loop0, mntpoint, btrfs, 0, (nil))
>> failed: EINVAL (22)
>>
>> Summary:
>> passed   48
>> failed   0
>> broken   1
>> skipped  0
>> warnings 0
>>
>> Duration: 7.002s
>>
>>
>> =3D=3D=3D=3D=3D symlink01 =3D=3D=3D=3D=3D
>> command: symlink01
>> <12>[   72.494428] /usr/local/bin/kirk[253]: starting test symlink01 (s=
ymlink01)
>> symlink01    0  TINFO  :  Using /tmp/LTP_symmsYXet as tmpdir (tmpfs fil=
esystem)
>> symlink01    1  TPASS  :  Creation of symbolic link file to no object f=
ile is ok
>> symlink01    2  TPASS  :  Creation of symbolic link file to no object f=
ile is ok
>> symlink01    3  TPASS  :  Creation of symbolic link file and object
>> file via symbolic link is ok
>> symlink01    4  TPASS  :  Creating an existing symbolic link file
>> error is caught
>> symlink01    5  TPASS  :  Creating a symbolic link which exceeds
>> maximum pathname error is caught
>>
>> Summary:
>> passed    5
>> failed    0
>> broken    0
>> skipped   0
>> warnings  0
>>
>> Duration: 0.052s
>>
>>
>> =3D=3D=3D=3D=3D stat04 =3D=3D=3D=3D=3D
>> command: stat04
>> <12>[   72.966706] /usr/local/bin/kirk[253]: starting test stat04 (stat=
04)
>> tst_buffers.c:57: TINFO: Test is using guarded buffers
>> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staEABwgV as tmpdir (tmpfs file=
system)
>> <6>[   73.447708] loop0: detected capacity change from 0 to 614400
>> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
>> tst_test.c:1860: TINFO: LTP version: 20240930
>> tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc3-next-20241218 #1 SMP
>> PREEMPT @1734498806 aarch64
>> tst_test.c:1703: TINFO: Timeout per run is 0h 05m 24s
>> stat04.c:60: TINFO: Formatting /dev/loop0 with ext2 opts=3D'-b 4096' ex=
tra opts=3D''
>> mke2fs 1.47.1 (20-May-2024)
>> <3>[   73.859753] operation not supported error, dev loop0, sector
>> 614272 op 0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 0
>> stat04.c:61: TINFO: Mounting /dev/loop0 to /tmp/LTP_staEABwgV/mntpoint
>> fstyp=3Dext2 flags=3D0
>> <6>[   73.939263] EXT4-fs (loop0): mounting ext2 file system using the
>> ext4 subsystem
>> <1>[   73.946378] Unable to handle kernel paging request at virtual
>> address a8fff00000c0c224
>> <1>[   73.947878] Mem abort info:
>> <1>[   73.949153]   ESR =3D 0x0000000096000005
>> <1>[   73.959105]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> <1>[   73.960031]   SET =3D 0, FnV =3D 0
>> <1>[   73.960349]   EA =3D 0, S1PTW =3D 0
>> <1>[   73.960638]   FSC =3D 0x05: level 1 translation fault
>> <1>[   73.961005] Data abort info:
>> <1>[   73.961293]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>> <1>[   73.963739]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>> <1>[   73.964980]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>> <1>[   73.967132] [a8fff00000c0c224] address between user and kernel
>> address ranges
>> <0>[   73.968923] Internal error: Oops: 0000000096000005 [#1] PREEMPT S=
MP
>> <4>[   73.970516] Modules linked in: btrfs blake2b_generic xor
>> xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
>> sha512_arm64 fuse drm backlight ip_tables x_tables
>> <4>[   73.974237] CPU: 1 UID: 0 PID: 529 Comm: stat04 Not tainted
>> 6.13.0-rc3-next-20241218 #1
>> <4>[   73.975359] Hardware name: linux,dummy-virt (DT)
>> <4>[   73.977170] pstate: 62402009 (nZCv daif +PAN -UAO +TCO -DIT
>> -SSBS BTYPE=3D--)
>> <4>[ 73.978295] pc : __kmalloc_node_noprof (mm/slub.c:492
>> mm/slub.c:505 mm/slub.c:532 mm/slub.c:3993 mm/slub.c:4152
>> mm/slub.c:4293 mm/slub.c:4300)
>> <4>[ 73.980200] lr : alloc_cpumask_var_node (lib/cpumask.c:62 (discrimi=
nator 2))
>> <4>[   73.981466] sp : ffff80008258f950
>> <4>[   73.982228] x29: ffff80008258f970 x28: ffffa93389398000 x27:
>> 0000000000000001
>> <4>[   73.983875] x26: fffffc1fc0303080 x25: 00000000ffffffff x24:
>> a8fff00000c0c224
>> <4>[   73.985649] x23: 0000000000000cc0 x22: ffffa93387f51d0c x21:
>> 00000000ffffffff
>> <4>[   73.986188] x20: fff00000c0010400 x19: 0000000000000008 x18:
>> 0000000000000000
>> <4>[   73.988686] x17: fff056cd748b0000 x16: ffff800080020000 x15:
>> 0000000000000000
>> <4>[   73.990276] x14: 0000000000002a66 x13: 0000000000004000 x12:
>> 0000000000000001
>> <4>[   73.992401] x11: 0000000000000002 x10: 0000000000004001 x9 :
>> ffffa93387f51d0c
>> <4>[   73.993108] x8 : fff00000c2c99240 x7 : 0000000000000001 x6 :
>> 0000000000000001
>> <4>[   73.993886] x5 : fff00000c4879800 x4 : 0000000000000000 x3 :
>> 000000000033a401
>> <4>[   73.995550] x2 : 0000000000000000 x1 : a8fff00000c0c224 x0 :
>> fff00000c0010400
>> <4>[   73.997017] Call trace:
>> <4>[ 73.998266] __kmalloc_node_noprof+0x100/0x4a0 P
>> <4>[ 73.999716] alloc_cpumask_var_node (lib/cpumask.c:62 (discriminator=
 2))
>> <4>[ 74.000942] alloc_workqueue_attrs (kernel/workqueue.c:4624
>> (discriminator 1))
>> <4>[ 74.001327] apply_wqattrs_prepare (kernel/workqueue.c:5263)
>> <4>[ 74.003095] apply_workqueue_attrs_locked (kernel/workqueue.c:5351)
>> <4>[ 74.003855] alloc_workqueue (kernel/workqueue.c:5722
>> (discriminator 1) kernel/workqueue.c:5772 (discriminator 1))
>> <4>[ 74.005398] ext4_fill_super (fs/ext4/super.c:5484 fs/ext4/super.c:5=
722)
>> <4>[ 74.006132] get_tree_bdev_flags (fs/super.c:1636)
>> <4>[ 74.007624] get_tree_bdev (fs/super.c:1660)
>> <4>[ 74.008664] ext4_get_tree (fs/ext4/super.c:5755)
>> <4>[ 74.009423] vfs_get_tree (fs/super.c:1814)
>> <4>[ 74.009703] path_mount (fs/namespace.c:3556 fs/namespace.c:3883)
>> <4>[ 74.010608] __arm64_sys_mount (fs/namespace.c:3896
>> fs/namespace.c:4107 fs/namespace.c:4084 fs/namespace.c:4084)
>> <4>[ 74.011527] invoke_syscall.constprop.0
>> (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
>> <4>[ 74.012798] do_el0_svc (include/linux/thread_info.h:135
>> (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
>> arch/arm64/kernel/syscall.c:151 (discriminator 2))
>> <4>[ 74.014042] el0_svc (arch/arm64/include/asm/irqflags.h:82
>> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
>> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
>> arch/arm64/kernel/entry-common.c:165 (discriminator 1)
>> arch/arm64/kernel/entry-common.c:178 (discriminator 1)
>> arch/arm64/kernel/entry-common.c:745 (discriminator 1))
>> <4>[ 74.014942] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:=
763)
>> <4>[ 74.015917] el0t_64_sync (arch/arm64/kernel/entry.S:600)
>> <0>[ 74.017042] Code: 12800019 b9402a82 aa1803e1 aa1403e0 (f8626b1a)
>> All code
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>     0: 12800019 mov w25, #0xffffffff            // #-1
>>     4: b9402a82 ldr w2, [x20, #40]
>>     8: aa1803e1 mov x1, x24
>>     c: aa1403e0 mov x0, x20
>>    10:* f8626b1a ldr x26, [x24, x2] <-- trapping instruction
>>
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     0: f8626b1a ldr x26, [x24, x2]
>> <4>[   74.019014] ---[ end trace 0000000000000000 ]---
>> tst_test.c:1763: TBROK: Test killed by SIGSEGV!
>>
>> Summary:
>> passed   0
>> failed   0
>> broken   1
>> skipped  0
>> warnings 0
>> tst_device.c:269: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for=
 too long
>> Tainted kernel: kernel died recently, i.e. there was an OOPS or BUG[0m
>> Tainted kernel: ['kernel died recently, i.e. there was an OOPS or BUG']=
[0m
>> Restarting SUT: host
>>
>> =3D=3D=3D=3D=3D df01_sh =3D=3D=3D=3D=3D
>> command: df01.sh
>> <12>[   76.370093] /usr/local/bin/kirk[253]: starting test df01_sh (df0=
1.sh)
>> Tainted kernel: kernel died recently, i.e. there was an OOPS or BUG[0m
>> <1>[   76.603065] Unable to handle kernel paging request at virtual
>> address a8fff00000c0c224
>> <1>[   76.603922] Mem abort info:
>> <1>[   76.604197]   ESR =3D 0x0000000096000005
>> <1>[   76.604638]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>> <1>[   76.605128]   SET =3D 0, FnV =3D 0
>> <1>[   76.606996]   EA =3D 0, S1PTW =3D 0
>> <1>[   76.607274]   FSC =3D 0x05: level 1 translation fault
>> <1>[   76.607611] Data abort info:
>> <1>[   76.607897]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>> <1>[   76.609765]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>> <1>[   76.610958]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>> <1>[   76.611652] [a8fff00000c0c224] address between user and kernel
>> address ranges
>> <0>[   76.612130] Internal error: Oops: 0000000096000005 [#2] PREEMPT S=
MP
>> <4>[   76.613305] Modules linked in: btrfs blake2b_generic xor
>> xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
>> sha512_arm64 fuse drm backlight ip_tables x_tables
>> <4>[   76.617688] CPU: 1 UID: 0 PID: 553 Comm: df01.sh Tainted: G
>> D            6.13.0-rc3-next-20241218 #1
>> <4>[   76.620869] Tainted: [D]=3DDIE
>> <4>[   76.621184] Hardware name: linux,dummy-virt (DT)
>> <4>[   76.622671] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT
>> -SSBS BTYPE=3D--)
>> <4>[ 76.623693] pc : __kmalloc_node_noprof (mm/slub.c:492
>> mm/slub.c:505 mm/slub.c:532 mm/slub.c:3993 mm/slub.c:4152
>> mm/slub.c:4293 mm/slub.c:4300)
>> <4>[ 76.624180] lr : __vmalloc_node_range_noprof
>> (include/linux/slab.h:922 mm/vmalloc.c:3647 mm/vmalloc.c:3846)
>> <4>[   76.625290] sp : ffff80008258fa90
>> <4>[   76.626275] x29: ffff80008258fab0 x28: fff00000c2c98e80 x27:
>> fff00000c48fd100
>> <4>[   76.626966] x26: fffffc1fc0303080 x25: 00000000ffffffff x24:
>> a8fff00000c0c224
>> <4>[   76.627599] x23: 0000000000000dc0 x22: ffffa93386d87390 x21:
>> 00000000ffffffff
>> <4>[   76.628603] x20: fff00000c0010400 x19: 0000000000000008 x18:
>> 0000000000000000
>> <4>[   76.629618] x17: 0000000000000000 x16: ffff800082180000 x15:
>> ffff800080000000
>> <4>[   76.630999] x14: fff00000c00203f0 x13: 00000ffff8000821 x12:
>> 0000000000000000
>> <4>[   76.632089] x11: 0000000000000000 x10: 0000000000000000 x9 :
>> ffffa93386d87390
>> <4>[   76.634293] x8 : ffff80008258f908 x7 : fff00000c2c98e80 x6 :
>> 0000000000010000
>> <4>[   76.634816] x5 : ffffa93389379000 x4 : 0000000000000000 x3 :
>> 000000000033b801
>> <4>[   76.636355] x2 : 0000000000000000 x1 : a8fff00000c0c224 x0 :
>> fff00000c0010400
>> <4>[   76.638309] Call trace:
>> <4>[ 76.639031] __kmalloc_node_noprof+0x100/0x4a0 P
>> <4>[ 76.640890] __vmalloc_node_range_noprof (include/linux/slab.h:922
>> mm/vmalloc.c:3647 mm/vmalloc.c:3846)
>> <4>[ 76.641267] copy_process (kernel/fork.c:314 (discriminator 1)
>> kernel/fork.c:1061 (discriminator 1) kernel/fork.c:2176 (discriminator
>> 1))
>> <4>[ 76.641795] kernel_clone (kernel/fork.c:2758)
>> <4>[ 76.643003] __do_sys_clone (kernel/fork.c:2902)
>> <4>[ 76.644078] __arm64_sys_clone (kernel/fork.c:2869)
>> <4>[ 76.645306] invoke_syscall.constprop.0
>> (arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
>> <4>[ 76.646337] do_el0_svc (include/linux/thread_info.h:135
>> (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
>> arch/arm64/kernel/syscall.c:151 (discriminator 2))
>> <4>[ 76.646974] el0_svc (arch/arm64/include/asm/irqflags.h:82
>> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
>> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
>> arch/arm64/kernel/entry-common.c:165 (discriminator 1)
>> arch/arm64/kernel/entry-common.c:178 (discriminator 1)
>> arch/arm64/kernel/entry-common.c:745 (discriminator 1))
>> <4>[ 76.647709] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:=
763)
>> <4>[ 76.649032] el0t_64_sync (arch/arm64/kernel/entry.S:600)
>> <0>[ 76.649724] Code: 12800019 b9402a82 aa1803e1 aa1403e0 (f8626b1a)
>>
>> <trim>
>>
>> All code
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>     0: 12800019 mov w25, #0xffffffff            // #-1
>>     4: b9402a82 ldr w2, [x20, #40]
>>     8: aa1803e1 mov x1, x24
>>     c: aa1403e0 mov x0, x20
>>    10:* f8626b1a ldr x26, [x24, x2] <-- trapping instruction
>>
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     0: f8626b1a ldr x26, [x24, x2]
>>   <4>[   79.647693] ---[ end trace 0000000000000000 ]---
>>   <0>[   79.649260] Kernel panic - not syncing: Attempted to kill init!
>> exitcode=3D0x0000000b
>>   <2>[   79.650229] SMP: stopping secondary CPUs
>>   <0>[   79.651558] Kernel Offset: 0x293306a00000 from 0xffff8000800000=
00
>>   <0>[   79.652015] PHYS_OFFSET: 0x40000000
>>   <0>[   79.652461] CPU features: 0x000,000000d0,60bef2d8,cb7e7f3f
>>   <0>[   79.653039] Memory Limit: none
>>   <0>[   79.653854] ---[ end Kernel panic - not syncing: Attempted to
>> kill init! exitcode=3D0x0000000b ]---
>>
>>
>> Links:
>> -------
>>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202=
41218/testrun/26396709/suite/log-parser-test/test/panic-multiline-kernel-p=
anic-not-syncing-attempted-to-kill-init-exitcode/history/
>>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202=
41212/testrun/26277241/suite/log-parser-test/test/panic-multiline-kernel-p=
anic-not-syncing-attempted-to-kill-init-exitcode/log
>>   - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2q=
NMDhPFtR8j185QSvZMn989u84
>>   - https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCQazNJte=
QLGCw7MnMtUwzkD/
>>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202=
41211/testrun/26266202/suite/log-parser-test/test/panic-multiline-kernel-p=
anic-not-syncing-attempted-to-kill-init-exitcode/details/
>>
>>
>> metadata:
>> ----
>>    git describe: next-20241210..next-20241218
>>    git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux=
-next.git
>>    kernel config:
>> https://storage.tuxsuite.com/public/linaro/lkft/builds/2qNMCQazNJteQLGC=
w7MnMtUwzkD/config
>>    build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2q=
NMCQazNJteQLGCw7MnMtUwzkD/
>>    toolchain: gcc-13
>>    config: CONFIG_ARM64_64K_PAGES=3Dy, CONFIG_ARM64_16K_PAGES=3Dy
>>    arch: arm64
>>    qemu: qemu-arm64 version 9.1.2
>>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>



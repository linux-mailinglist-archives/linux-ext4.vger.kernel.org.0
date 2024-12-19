Return-Path: <linux-ext4+bounces-5781-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F39F8870
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 00:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE9A1894C71
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF21A1EE7DD;
	Thu, 19 Dec 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XyYgYs0S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21791BC9E2;
	Thu, 19 Dec 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734650462; cv=none; b=ouoVYvdZYdMYWZTXJ5lNs07v+rD2bnuL76tdF06eYOlkHw4ahu7yqU05yGHlFcwfxAERU/piKE79mvVS0BvK1nW1+uCD03dQ5bMEniI651+L7AMtY4l+cAtUxngxOMR23D5cMDnTuzR/Z2YB+a1S067pDUgFxGItFc+eIeak6ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734650462; c=relaxed/simple;
	bh=xIqSA5CD/TPDvTioWqMmBpK0lmrI0+3ha+U5hbbHhLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m56RA2xnAEBLVI1Iwm1i/hUNQwhcTFLpM9ys7231NLVNhNTZd76x6XniVR3Yi2vnBUZcmI4dsKYQJs6tWgOGjgOskL6GlqZMqwOE8WVj1VDloSKqXvbBAhtfT0BVwzw/nn+YhnPBglex2Zfh/o/StA47em5Q9M4XuaayBTxWX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XyYgYs0S; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734650451; x=1735255251; i=quwenruo.btrfs@gmx.com;
	bh=95G7uHNvHD21KqOF0kX1P8YJBPPFiYC4Iu84WTTA8BE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XyYgYs0Sod0ALWgJONQKyIX9ae/EJY03zrjzz56buwm8kynBX1RRUq4tUiKFdrXQ
	 GGv4cErxUWd3af/KXCe4XGCRdqs3OgIix3PUF1OQsulJ8zgz7FUpU0MVEt+olrCpM
	 ormmJY+/EgOmOSakMe2hXIcrQelZ4iY46GKFoLmGRFWRazEZnnTQ1/jCaw3A3xWYb
	 ElZ69EYlATbF4yQ0OILVD4o0JRv4dLP+UyrWv2Z2VCH+9TTiYF2kHvb1qHiXDc3im
	 6W/g+CSF2lQXGsTqAuBz/jQPjLsWI8fO6ZdH7MM+J1YxWv44myQGkxuQDHWz46JDh
	 dd4cYWBGRWWuhM307w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1tZ22015Bv-00zmna; Fri, 20
 Dec 2024 00:20:51 +0100
Message-ID: <4ae3fd71-c22e-48b6-bc86-fa494a1841a6@gmx.com>
Date: Fri, 20 Dec 2024 09:50:44 +1030
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
 open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-ext4 <linux-ext4@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-mm <linux-mm@kvack.org>, Linux btrfs <linux-btrfs@vger.kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
 <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
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
In-Reply-To: <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cQlIl5GOqLf2ibS/Z9iRkgOa1VDWVcAAmT2oQVEDXrLgjBCPye1
 d52w58oCwr9zeR0OlUb7bAVTYTHIhPKfJb32puDmEGks00WcH1OlMBxbKTemL+LFSLu/gj9
 iTIIwYtvdK28FX6W+4KeWWh+AdyFmJVxOL9lGn5bs5ldU3+aLYqtYn4JNJYfP2vbTALfHBB
 Qg9Ky93Bf0UwHOVkv5nVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d2UuVHxTIvw=;6T3uBityxrfuSydR5DdpsJvSDtA
 Wx2cRDU5H08Uop6xJUCFZzh71BAMjBwYViboFs2kBG7/HJd8A/hiYOis+Sf7v1SroOJsL5X2N
 ONVpqq7RQ/WA+nyiKFLj/N90akIyiqXU/6ypDaDCz7qOgFup+kvVZuMpbB+P+PN15/LJwHQxJ
 W5I2Gux2mHARJlEeO54jV2ZWsljgnvxYnyb6Com+u3y6JEqimPSSmOtDWQDyNHPPxZDo4TmJl
 dlhnvsqwxHG93Xxm4YojHVRUXOEP30wpNLC3N+7efTAzNMZdQBWFiI23P1AH/JETgHqN9SyD4
 WVho/HaHp98rRsXLkdbxgYI3yF7Zh5j3U2I+1xVzhiJCcRSk3a/6nOaelqhWp2Nt/RPuxyosb
 iEGZrocLNBpvUwI5BGx1h0HBs0Y0zooKKXFKIqCMrnmUFV1GeJaZ1CUWHM6zWNsv3CEtaK92U
 bNPcL1fPsH5ubUOA+t40zwuRTh2Ek9WxhfXosX2C8zQHiu2I+zPAIq7NxbzcG4Lg0gFXlFrAn
 aelhsj5fJN/j+xjgtLA+w2Qi2IUu/dnpKiy9wAz1nmN32v/chJ+AbW6W7qDJwFOJue8JGGulc
 /2MgPYIsKaiHRjLpifm8b0MovjToys7JaMS2ehtS82eHRRrofrLNIJFLZPOkKuAsq8dAES45I
 //q+O++AvGlc5qq9b83zjWNCaCSn6f+NU4oVhT5qz3ptG6zDD5QVQXGYfd6OL1qwlQJuTvQsz
 xE4vtz2HWGme3ss/TZMRvRxxL0JXRgeCIExdNF3h4WjYENVekuh9sjNK/zPcMQmrBS9PEdA4q
 Y3q5UnKDo3LXKVTkhULy66d2KqKixe3SBVZOGnFPbeblkzOaloqHvoA4wcnpafBUdSe5m4Uol
 7o8nJ3nVwG1j7GhO0E46dZfEdKrAs9qdpOij00g+o0P5zw15lmO7pvMrNqD1fP3ux3at4WIHz
 j+o6hynt5gVMIdMPFqhU881m0JsbsgyIEzcr3gptP1fjDwUuSXItLLilWg41XXUShlZ0tbD0o
 6KCHELDMkY5jNzpkSUUuhsjg0Fl0ELZpNQRBfBJuneeVw5Ran8ObcVSat4MsSGU6Vkpsp6nBe
 zndolC/tmhcdOWerT9qHc6AgLKRR43



=E5=9C=A8 2024/12/20 01:40, Dan Carpenter =E5=86=99=E9=81=93:
> On Thu, Dec 19, 2024 at 10:44:12AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/19 06:37, Qu Wenruo =E5=86=99=E9=81=93:
>>>
>>>
>>> =E5=9C=A8 2024/12/19 02:22, Naresh Kamboju =E5=86=99=E9=81=93:
>>>> On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju
>>>> <naresh.kamboju@linaro.org> wrote:
>>>>>
>>>>> The following kernel crash noticed on qemu-arm64 while running the
>>>>> Linux next-20241210 tag (to next-20241218) kernel built with
>>>>>  =C2=A0 - CONFIG_ARM64_64K_PAGES=3Dy
>>>>>  =C2=A0 - CONFIG_ARM64_16K_PAGES=3Dy
>>>>> and running LTP smoke tests.
>>>>>
>>>>> First seen on Linux next-20241210.
>>>>>  =C2=A0=C2=A0 Good: next-20241209
>>>>>  =C2=A0=C2=A0 Bad:=C2=A0 next-20241210 and next-20241218
>>>>>
>>>>> qemu-arm64: 9.1.2
>>>>>
>>>>> Anyone noticed this ?
>>>>>
>>>>
>>>> Anders bisected this reported regression and found,
>>>> # first bad commit:
>>>>  =C2=A0=C2=A0 [9c1d66793b6faa00106ae4c866359578bfc012d2]
>>>>  =C2=A0=C2=A0 btrfs: validate system chunk array at btrfs_validate_su=
per()
>>>
>>> Weird, I run daily fstests with 64K page sized aarch64 VM.
>>>
>>> But never hit a crash on this.
>>>
>>> And the original crash call trace only points back to ext4, not btrfs.
>>>
>
> Yeah.  But it's in the memory allocator so it looks like memory
> corruption.  After the ext4 crash then random other stuff starts
> crashing as well when it allocates memory.
>
>>> Mind to test it with KASAN enabled?
>>
>
> Anders is going to try that later and report back.
>
>> Another thing is, how do you enable both 16K and 64K page size at the
>> same time?
>>
>> The Kconfig should only select one page size IIRC.
>
> Right.  We tested 4k, 16k and 64k.  4k pages worked.
>
>>
>> And for the bisection, does it focus on the test failure or the crash?
>>
>
> The crash.

For the failure part, I got the reason, it's indeed the patch, where we
call btrfs_check_chunk_valid() but fs_info->sectorsize is still in the
default value (4096), not the real one from the superblock.

Thus it will always report false alerts if the on-disk super block is
not using 4K sectorsize.

I'll fix it soon.

But sorry I didn't see why the false alert is related to the crash, the
only new memory allocation done in that patch is for a dummy extent
buffer, which should always be freed.

Anyway in the next version I'll get rid of the memory allocation completel=
y.

Thanks,
Qu
>
> regards,
> dan carpenter
>
>



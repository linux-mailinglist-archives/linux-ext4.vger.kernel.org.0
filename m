Return-Path: <linux-ext4+bounces-6754-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF444A59726
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DDB3AB4F3
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2922CBCC;
	Mon, 10 Mar 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="aZWvHeq3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697022B5B6;
	Mon, 10 Mar 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615879; cv=none; b=Rq6AZ75YM1/mCHFlyNFiRlcviE8jFregM/ftEEF3OeS2N9Gu8RTiA7RBVnrqDuiroemINyjlcq23b/Oh4vftb/8gDYMgEfnF9opA8vAsVuxG8JyaEcxhzJ/Iqj280Gkm+tU3CkA7viySfApn8gyJeC/U5UR6Dg9b1S0OKcwy/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615879; c=relaxed/simple;
	bh=GWunTdHAI7b0cohpCHo+7m0nUPxTlaoYdDjazPPRZc8=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDL3tY5m4BK/o4itNW52eZN2pevvIt5x0ZB45gWZWMzYxGeLZ47oyWPRgBYCe8Vam0CRggbsSM567D9hsT4aiNOcrku5XeY+XdZH1qHtMIljDJaXkV/Go9qZ9GkhGncvre8bgBWePmW/hMspDK/UnHGSXkENqiSBOyeECyDYU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=aZWvHeq3; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741615874; x=1742220674; i=aros@gmx.com;
	bh=VKzQu2+sth8gbYkjl0G2p/5CqDPJ7n6O34m+uH/HSRw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aZWvHeq3ppdZq74zDIhM9YPk6rFiId31DRl9gmH1pJ6E38fo/fAWrWXrJcE/cT5S
	 VQYhNH275Slm1NqgNaHdO1qKdcS5SeFadk3ciOCvxJj0MIwltsnRa+A76lwiWTv7v
	 pmfB/TbkiUE3WN3qkI6Lnk1zFoc742z5rh3uhmuL5FxlbZ9yA2/1Wr36//+VbLboc
	 dVGQ6EFyESuOYHVT/CyBL0Ke3nKKxTjKnDfFPSfMVN5lZDLJEvsrPI0qhAUWJhc4K
	 drKFKeg6H8VDY5huqJMpEYoItHoU7bMa56uAl+uzw18953xlw7Gfa4sCimgeTwJW6
	 o6cFVT3TSRBuaDYBxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.10.12.239] ([156.200.109.2]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N95e9-1tCPhu3Odz-013PxH; Mon, 10
 Mar 2025 15:11:13 +0100
Message-ID: <69d8b100-f65d-470f-a957-2819795e82a4@gmx.com>
Date: Mon, 10 Mar 2025 14:11:13 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: A syscall for changing birth time
Cc: linux-ext4@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <20250310135828.GB8837@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zv5WKVRM0eY4aXjcRUZoARHKfJF3YrMaEWFFgB0PZeZvoQtI07p
 Lp6hbmVHQo3plHZzvJXZwa83LK0/foFcPKFh907NKxJdthGh53Eho6r0hbUeD8bdztDOaKM
 DtjrxjcbidZrtFNtSQc62HD2vmn15IO+/PQn1GQkGVtubLQ3z+mWQIFOvs0lErFfyZFomij
 11Z9z4gQy9itboTMYIZKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OaiH/nlXpyc=;XR4tuCzr6F8CnpozhOwIWHuj7U9
 8V6WuLuy/F30UcwCv53wDOzU2lrUD8jvfVWpcCikdFqFlf2m0pY0/AoE10+IoDu9/22v8X6PW
 2HbatOIHezL71Y4qtuiBtd6sme1h6hvWzcFpY0aBA1gc2MyDTjwtPbeLQhg4fkKsB3/3G+Aol
 yOZ0EjHNSEfNbwppAoiJtGTWjLB82UPyZOIEva/SzaZQ8sMP1OOX/E+V+88G7q+0qieSmMMTv
 il7ucoXVDnryMsC+1+XypvvqLuKRfl4K31fswWP5BZaaOhOSjRGOtAUE8Mo9MbYAuPQWLOiSZ
 CyBRWYF3mHdXPZYz4MjJ7FLIL3T7Kb71M2ClQHgUX9dioLENzpExVIA0thC2hN0A7ILFIAg/Q
 8W+wJLlLHIR8Io5jzxR+MonKKtVrIef/FDgExjT0r5UwBf/QncR9ZJCGtDXVa5UiCud55U7jG
 80KTclLdkrFDOH7YjSfmTb5Cx2Hv/lvhMOBOwI+w1fuyY6aXGTmkxDYLljw8sUxXW4/5abD4V
 D88NNf34CIXaYZPtsAWE+q93uhhuooAekD20DjeGNb2Kz2AUoxjpv+gWl41jF2XdngA6L1CQ5
 k1raBHSNKdrxvH3bxmbOf7YFNDfAZuEv/5KBAJ37VCTHZvuOrEhgFIl1pM/yxrdyard7Cas5T
 7ZPfL6Y84l58eILzjfr+FIXXAdzHeibkbJReD8LyOQw60tYdZwkrXyM0Y+MkwdgfjtSzJnezB
 a6sNOjmxTwkEjnEk6ck4iULHr9phFxKgJf4Ydbnr+cYQjQxpzp2Lv0CiaTnsmrAhItCTaWSPZ
 u4CNOSw1V05mLOIY0hD8zv+YXSdnVYjSZCuaJ14LbBYGXfLUx6dwPVqBen8/Dh0eRSeOkA6Lw
 9l/oiybVFw10JHDFh1ESmK4BvK95cuHbND+5WVzMqztaFVlugM1v8047jqmjwsYWHZ/Nl9qaY
 3RZ6l2qpOjez3UB8XUwRLB0tGGL8kxVwvntBv0HS0D9dKNeu7Bu70BbakXJ3/uFG//wyLmPxa
 xBLI2Hs7JC2h3IZAE/wvKqB67j3NeTQhl3pMQwvx4U1weQaHrrPs1r6Dl9oe/75WcW1Ue7TXC
 8Nn+VOYVU0ibSEFItijk+aBu6mpO1Tv/PecD2j0AjOa62B3xoHGno5+OB3vl+Atif8GBxtlGr
 kCvzzRifDLA+pdM7/thicDCDJSHyhcQ0AYbdnde7+bTBkNNJ0FfOKO/2K0SUYhIaQ8BozB9D8
 FRCiMViuLrOYEY+Sy12LZHkp7PDOy06vRmetIsZyrEE0P5gz8jXnoqKrgQxYKE6ANq4wRvPeD
 tRFfPepLK1O3olsf1uEPhUt/fW+JyIqtpD14Vj7akZmJoiUbFn121z3ryVKiXA/tCnqq6j5de
 CM/Ra8PO+4SrQDLlX5yhs14vV1P2G/zL7ypKvPGD+uAJ6psAqKyr0OQnhy



On 3/10/25 1:58 PM, Theodore Ts'o wrote:
> On Mon, Mar 10, 2025 at 07:26:00AM +0000, Artem S. Tashkinov wrote:
>>
>> Why is it that the Linux kernel supports reading btime, but there's no
>> syscall to change it? At least for ext4 there's the debugfs utility, bu=
t
>> for other filesystems there's just nothing. And even debugfs is not a
>> solution, since it requires root privileges and an unmounted/mounted RO
>> filesystem.
>
> POSIX and Single Unix Specification also doesn't provide a way to
> allow userspace to set ctime (inode change time).  That's because the
> definition of "change time" is defined to include the time to change
> anything about the inode metadata --- including the inode timestamps.
>
> Simply, the definition of "birth time" is about the time that the
> inode was "birthed", and that's not something that you can change.
> The problem is that DOS has a concept of "creation time", which seems
> to mean "the time that the abstract concept of the file was created".
> So if a file was created somewhere in a build farm in Redmond,
> Washington, that's the time that the file should have, according to
> Microsoft.  So Windows allows the "creation time" to be set to any
> arbitrary file, since installers need to be able to set the "abstract
> creation time".
>
> You can debate whether "birth time" (which can't be set) or a
> "abstract creation time" (which can set to any arbitrary value), is
> "better" but that's why Linux doesn't support a way to set the "birth
> time".
>
> Whether you think we should bow to what Microsoft dictates probably
> depends on how much you believe Windows is a legacy operating system
> or not.  :-)  Personally, it's not something I really care about, and
> if someone really wants to add a Windows-compatible "Creation Time",
> my suggestion would be to define an extended attribute where this
> could be stored.
>
> We *could* allocate space in the on-disk inode to store this
> timestamp, but since I would estimate 99.9% of deployed Linux systems
> don't care about Windows compatibility, it's not a good use of
> resources.  We could also add a mount option which changes the
> semantics of birth time, but that adds extra complexity, and again, I
> would estimate that 99.9% of Linux systems (where I include all of the
> Linux deployments in Cloud VM's) don't care about Windows
> compatibility in this way.
>
> Cheers,
>
> 						- Ted

Hello,

I'm not going to argue with your reasoning but being able to set btime
could be beneficial for backup and restore purposes/utilities.

Secondly, I really like having separate modification and creation times
for all my files.

Finally, as for POSIX not offering this feature - doesn't Linux already
have a lot of syscalls that are not found in POSIX?

So, it's not just about Windows compatibility. It's just very useful.

Regards,
Artem


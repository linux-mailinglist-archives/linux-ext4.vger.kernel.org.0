Return-Path: <linux-ext4+bounces-6287-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD87A24A06
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E21F3A6145
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB61BEF6D;
	Sat,  1 Feb 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="OHMRnPqJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0968182
	for <linux-ext4@vger.kernel.org>; Sat,  1 Feb 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424904; cv=none; b=SqDjR6Oy6B+wu8rf1DFoASlqJwYaMfLDwIvdqm1QYfi8mTvdl9rSFzkz7H7IqAxwr7yQDRV7sjSkQkSDDAqmNypY52Ilxg9cS3ikVnFMTqFTSS5NtvTgB6wPq7dOPC0Eq0+nrmO+i4WMgzrwkdHE0EHpYTA6Vz06z/pUz+N13iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424904; c=relaxed/simple;
	bh=Xv1wG7T12bzwSA/1LawgcD0UbW5p98JC5ov1T24AUN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=gQwtRMCgLCKK4AOz33cGh1RG5CJJx3HyHyGCbuik7+yeL9lCLFdw4Ulm2FIxR7uiPH3sjmAvjkrHQEW0mzkNFxnfRvw6HeWxSbUqRuyCoQFIGGoxw+5uOX4LVdzJY3gAliVNDQDrRZkktpY8DCO78YnrOylyfzx2LNV2rxFHCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=OHMRnPqJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738424899; x=1739029699; i=aros@gmx.com;
	bh=Xv1wG7T12bzwSA/1LawgcD0UbW5p98JC5ov1T24AUN0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OHMRnPqJJVRECj5oVL8FfldWjp/HSP1rkwdMt8cJsD7njRvwgNmc3oN+u6sXGv/P
	 uhQXmfqpfTBYHpEWWmwaacsQ92axxLcoAKe79RZaZwZXHb9jSH07gtt88iSEpQXP7
	 2CHrOx/FGEosNFr3HAYgBVpHWvx3vjaHp5kcld6Q5mj0AjYwiNNwSEnrqQc9ilo/5
	 PXGBB9covpsaYFMoa87v0ldeuc09+Dw6TbZ4EcP3yQE6E8pCL6ekno+ngOX7jPY1D
	 WBtGkLVlFj8ztAFtnEivzXYLYeWQtLxymokksRkfzSegwuZQY6lBWyQFuzhtUQOcr
	 OSu3bKwKQvEtIsAUNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.11.19.6] ([98.159.234.94]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1t5T8s1kO1-00mmpG; Sat, 01
 Feb 2025 16:48:19 +0100
Message-ID: <ba25991f-43ff-4412-8978-27ad8198e347@gmx.com>
Date: Sat, 1 Feb 2025 15:48:16 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: A possible way to reduce free space fragmentation?
To: Andreas Dilger <adilger@dilger.ca>
References: <8dcf1b6e-633c-4415-9412-6876efc07b50@gmx.com>
 <8539EF46-5166-47EE-AB26-01ACA68D6DE3@dilger.ca>
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-ext4@vger.kernel.org
In-Reply-To: <8539EF46-5166-47EE-AB26-01ACA68D6DE3@dilger.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yj02ZXICiqaciWhPDWUPDLSfU0JrekLYYwqnWRqnn7DxXZYSxsc
 3iNimx/iitTsce7wOHaEyMD1o18Oj04e7kjN3krUMRgVewj/PYSw6Nlb21JwR+jO/w1pI9a
 LmmQzhFtjM0JVMXPn269/tyit73wZkDxwHOx1LbQaOPv2UQ9Z/bJAPgqE84svzR6a0F3ket
 ubwSRcEE1ZuTOvAFBSN+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MVTLv/Tn7N0=;V3WIp1H7dLB/HZt7br0uR8R9cCW
 RMqUvIM8HWiiri0ptLOFdJecJhXt+Nrs4vvVN5Iyi0Pg9Sodzg43DVj1otAwyELDLJpXdvkHt
 I28Jmrh6d6Sr7VyWyeMOEuL+lG6UPEYneJkT/SxiLzawBT7E9h27TgT9N0OqXMxyxHfkAcbQB
 SSaLL2UHerGR/ZPDj9q4fmCXVNLyioaT5BWdd3oFLNFJPCF51I06Plb1cB8HTddpR1OdEZdjW
 SBJYgU6lDoXaSgFROZJVAutxUlnyN8F4OLpWFi13Ranz+GRuokOCWTOELHeUlODUrYIjjqB7G
 j1CQ0cRooPUe4e0bT/NybPp453OGsG0I7cX5brQi2ZVPEPMBwyBs1lrAFQo48fY8gDCGZhWcT
 ri88Tb3rOxxljTesFpeenLGXXS9iOGf/OyRUvwBakquKbnznlPw4k9jYTDjF8MHxsns6n+GOl
 piA4IlhdsHltfa4TdznEfJL+JKNOD1Q36HWv8ICAQycC1SIhtNXI4KhqIJt0NAsjGDFAHOjSw
 i6bAq6qPt3U06ttthbx9nHalidQDP2pDDbM0Z6yAyqOgzUIy7Zthbv69dJ/xdz60Pf87eFb21
 r0D34xP+m8OgBZMk9kFI3ieELOyufZ5VVFAU5QP2F2cxoSWjhrW/Rz4jB24BbRfqBh/6jxs/+
 4YDqChiECOFINgAfvZEBG0Z27W1asc/5SVcmpAVr3U587v0CEg9/BsT2TR2ai2c4TPjln+Vpa
 0D6Bw9P2AlZjWxQ9+MExg/VQI77PeHWo9ARy4BQ8wEBkoJPhuDfZ/QJNxxGYywW0f/1o5elzP
 t6IWek6vVxEBz2PemMNeAg3Dy05+tfb9klQOb0TZq8YkSeOkZ0xTOYp3dtsXQvroCXmbRvINr
 9lkLjrr80thHPk68DtLsLJlNMNaHVjM/D6IoMAcHRc8zTJGmvMZGB06WM5WzQDZ74QHIMQQ04
 aIX92Ig0pkrP2QAHBvnAkusWzF7iYlbztTHbTbuLtUCu5ZUwuVqlkllPIGVKTGpOsqmbcqk2s
 4qbhq1XHguUnzif2lBmkSiWxRxyXUIMnkNdkxK0V/iy/nOsFBjG5eSMXCkTjfUdi0TEI/mdCK
 LduDQJEdPHON5NIFfSkxluqGeCcS2ZQNVZ3a3yE0mrAeHUJpJVHSP89gfKv/k1bFsLLpC3hEL
 y5ctld1T2cY6jw4KT8nzVWeLmaYWUWZTMc6wt2lUlnDkqUnLDQDnJQdgFwxfYgKA7G8kRLf5m
 7hdVwMRyN7W6UiQxVNIx1E/RtjqW9pf0x1JhHZgxmDxCK/Xi8qxjCWF7ye93Jmq+/oOpY8Sit
 jVX80otaxdCRG90q2+koSXMs5D+eC7R1+0UmcAJaysoM2Qeogo6TymEac3vu4rvoVNw



On 2/1/25 3:38 PM, Andreas Dilger wrote:
> It should be possible to run "find $DIR -type f -size -1M | xargs e4defr=
ag" to only defragment files below 1MB (or whatever you consider "small").

I have smaller files completely defragmented already.

The issue is a dozen of 50-250MB files that span multiple extents (up to
30).

>
> However, I don't recall if e4defrag will move a file if the new file has=
 the same number of fragments as the original (presumably both "1") or lea=
ve it in place. That would be possible add an option to change.
>
> Alternately, just run the "find" above to find small files and then "cp =
$F $F.tmp && mv $F.tmp $F" to rewrite those files into new blocks, and hop=
e mballoc will move them to a better location.

cp doesn't even support posix_fallocate(), rsync does but this process
will be a complete guesswork as I have no idea which files are worth
moving and which are not.

Considering there are holes that can include files in their entity, this
must be done by something that knows what it's doing.

Best regards,
Artem

>
> Cheers, Andreas
>
>> On Jan 31, 2025, at 14:02, Artem S. Tashkinov <aros@gmx.com> wrote:
>>
>> =EF=BB=BFHello,
>>
>> ext4 has no free space defragmentation and at most you can use e4defrag
>> to defragment individual files. I now have a 24GB ext4 filesystem that
>> has only 7GB of space occupied however it has small files scattered all
>> over it and now bigger files occupy more than one extent and I cannot
>> reduce fragmentation to zero. One way to approach that would be to
>> shrink the volume and then defragment it but that will involve a ton of
>> disk writes and unnecessary tear and wear. Is it possible to modify the
>> e4degrag utility to move small defragmented files, so that they were
>> placed consecutively instead of being randomly spread all over the disk=
?
>>
>> Regards,
>> Artem
>>



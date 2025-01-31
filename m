Return-Path: <linux-ext4+bounces-6278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE47A24313
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99887A3981
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0841F03D4;
	Fri, 31 Jan 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="tu/0pYAg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765914AD3F
	for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350123; cv=none; b=NkQFA+KxBIzTnzarFICmJq39btzOGO+8ANUPdKPndOD32paEhqfDXWotXfCei8CXyVpfUEnYZh40bgZ1LoF1A4mQ6eMroTr2ThMbSHcoc/8Hj6a4KhQ5FQyGp0AWwtNqt3cs6AFqP+MO0xV/5xzPbPieVfSlqpSQ/6c4IT9XzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350123; c=relaxed/simple;
	bh=NfkLnR4L2k8/Aax9092eFWuhnj4Bab51bzrhwbfBZ6c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZIyRkx9f1Jyko533SEsCknEME63yUuXq2/6Gt5ZkTzN0qEJa3SJB8SmBfGudCAGpGKFLzZ9CSZtqC3dMDtPf/zfb7uKWjCdMt4k9VO8MBBPGvP6dBivjcV/pBTd3TvGdeJnrJaNBTjaRX+RABGw5Ngxt/KTp806McAblmHpWmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=tu/0pYAg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738350119; x=1738954919; i=aros@gmx.com;
	bh=NfkLnR4L2k8/Aax9092eFWuhnj4Bab51bzrhwbfBZ6c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tu/0pYAgvOR1MzxhCULWGL17G3McmrvzHAA8esBRaGAecrf0dgAot/SqyxHbF43E
	 zT8T1fhRLthf21L3/q4ZHAkniRV5JnpPsahKQWw2WKWK0F4Nha1Inw0kVTs79wtsN
	 vvfWP79zL59hCZk4ubLZFfLztMomZraomOUV7uS0aY3m3VXV9c5x77mrcxfQpZ/at
	 VivcYjyQGhBkUZGr9yrK5gVa8V++Izq0qxRiMEhB+kDcvblxqp0u0exVGg8NIb/qu
	 0JOMNiinr6+Dp2clsosQLkt5yonkSf1G9iiHJ3JQRjaZERyKEIDr6ZiWg3RcsPCRC
	 rNjWabHX6/8+qlS+Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.11.19.12] ([98.159.234.140]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUm7-1tjjYn20Lf-00BZJ3 for
 <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 20:01:58 +0100
Message-ID: <8dcf1b6e-633c-4415-9412-6876efc07b50@gmx.com>
Date: Fri, 31 Jan 2025 19:01:56 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-ext4@vger.kernel.org
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: A possible way to reduce free space fragmentation?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q0sOVJb9W3V9BWTh3gBLAsSMNLfOmA+9GwQmg5WzjZhnYVWDDcT
 9iHt2lIp9AGX0JH2F/LUUri33CozLRO36IRqpcjZm7tiZOZ8W+1vxAqxapoqz5Lja5HysV/
 pKKXK6Rm14Panrz5CvKJtbO7NAnqnPKoBBKFc+OiPijRfCNtUw4BX0LbWP+VZVr9k6aaxYA
 0qi2rZNSW4UdWT+VfPR8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aMuCpPdsg1I=;jvSNp+Z2nLWHBvHmITr7Vx2Y8fO
 aOTgf6BWLsh3V1IyEdYTuCDxEdUsy7sYNTo+LoMZQ7LwfO2YCzKRKcB6VtUntuVR+Ly13pzPQ
 iBLb5w7/KJYDBpjN1esJjdeQCwjcD/k3INadHIZjMpx+v2ccTW2v5jqtm5XqDSFcfT73HkO/s
 E0DdK1/jfrFStFYWJOl1JOh4hxpQOJLRHd8yy2eCkwIUTYfPrTlNi87Pt3wPQ4vx4g+Z4YoAw
 423ggt5lGy0na/V3z8S+/JKVHcgAtpmTmRk8/p4a3bai3wof7Ks+KKu62Gr1enhTe8Ef7P2TL
 VlJvVyNS1CLsZSKQ2eya4NxFmOJMOOoK/25o40d1nQFk2kknIRbbrbxMrkkeNBW8+8tuZKt6i
 chu5yT0N3qDZuWvPo+jgl9iq/+3Tly19Nt0FIT5A4OPpfSfyv42x8byAJWR0ISkazqd35U6Al
 1mbmEK7YROdYF/TH4hGUk1fAUX/qkuTkb7LsrAvee2IacZggl/7YvwEfoK3crzVfadI8P4ePv
 nVNKeYvDAwTeuM/B5FcxWeInfNlE5r46Q+xfzHjobRPj8Vt4qNqVzeEXASmo0hA9jgLUvRQ1A
 gqNhD5pwN2YG+tC5kZkhPGjGLDKxblZi1KXHESz6pZSzfIKEvTsLUXQtl725Zz2DdwvkFkejI
 MNjbnSWxRnzncAU5pf5mTWYHaRFKs9+G7Lbyi2Ep6PC5MCyIJSh2rk+n+8+mrvF9F9yKzK0jH
 sxzDQUlFf2ZZ1/1zNr3cT6xt7ULzi1UPYZKCG892ZSF/hcZobM8EBM5/K+yCW0vQvcmtzYp+p
 RHq4cJgcpfpTW7S2nM723/1+lK6VYdxhJ+fMUQSxpy35Harpw7Kgaj97fmkukEv8xJkwJkP4S
 Wr1FIRXTfGrxrinb1Y3iqWFIVmwYHqSW/H5WSJD7VUU2CiwAkt0kjrXh2nhF2pfGVCUbg8z9K
 0lb2eWZbFT5i1s9GLoLJTrU+FZvclTn6jtHy1xFJfZ2cdz+/ArUAUm/it/FXZC/rNsRyJHPuz
 BgRY0NdSnH7i3Vkrl/4vFqWb72h4IEcNSud42iEHrcGYbpeIyQNzG6Thpk49c0E4nbH0xclyA
 D5zexYfUq8egAPDI1pIYRNWDZIhcUf0VIWGgqYdfLxo7BLnirrRkDRGY+uSesAwSovJPJvxgH
 Hh7JLfCOZLiTw+kuT5Jl4aAMiirXhtEcfc8svLVGk0uWuD9M5vDDajtfjNawTaozkQmIRjs6k
 nkUh3qLhgh5ANfleopMZF37E1UmPxxiHmQ2UhToYlyZGc6Bbk3VnpoTY4wOBGdAG1+xSE8dq8
 IovtGSqVQqLlQwJckTbMeG/jJ1XhluTRD3WjXOYKtOZnUaFBGb6jrLRNrMC5pF2KaeI

Hello,

ext4 has no free space defragmentation and at most you can use e4defrag
to defragment individual files. I now have a 24GB ext4 filesystem that
has only 7GB of space occupied however it has small files scattered all
over it and now bigger files occupy more than one extent and I cannot
reduce fragmentation to zero. One way to approach that would be to
shrink the volume and then defragment it but that will involve a ton of
disk writes and unnecessary tear and wear. Is it possible to modify the
e4degrag utility to move small defragmented files, so that they were
placed consecutively instead of being randomly spread all over the disk?

Regards,
Artem


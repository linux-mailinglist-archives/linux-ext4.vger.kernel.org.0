Return-Path: <linux-ext4+bounces-6740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EAA58CE1
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 08:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CA5188A6DD
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F21D6DA1;
	Mon, 10 Mar 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="UND7lBlx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C351D5AA0;
	Mon, 10 Mar 2025 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591567; cv=none; b=jL7zQwYiDyZ9SYs/QPlDRTuVAwgTWo723oP7abRWjb6omAVIQPUSSZAvLNhfZ+1Q4SZIt3l/dtjMWs4TeoFMOH5GblQlCDRRHccoD6LyGHwz10CE9C1/RcKNx93RNPQ1vR/LZX/GQOPZYrZx6nvg+0+mrnxyYXnY/Rz3ojYBzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591567; c=relaxed/simple;
	bh=kQOLy3c+kJxUC9iEU5qpaeaptXfIDafn604QRTV5Iz8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XmnKslZd4yyCIRc8GYkp6F4YL69kmTURV8/qcyuH2DNNnJI+AmFDdpOrQdmXEyNdvNPA18CyAXReK5q4D0X4aOhYv/dc/TkgikQGIUw5rBRdjYLT2c7ZIqrSIAKsYsh7dMj/TkItxc2bo9BcDCeFWnvy+4q24DrW+Xhy8prW6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=UND7lBlx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741591561; x=1742196361; i=aros@gmx.com;
	bh=kQOLy3c+kJxUC9iEU5qpaeaptXfIDafn604QRTV5Iz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UND7lBlxvWFdQq6PPIRQQ/NAeb9XJBobhnmqS2u1C1dJPDuOKcsHlPV/Vbp6VeMt
	 QXTmXHjYHo//9Ukl2fMQGwPGjIMN7+YRXoQoChf7HrLmJwsC8o6FkS1V32IyxDmPo
	 j22eG8NXMay4SCTWQiMkshccyPRrMM1S8bhQeueKTGf9FzQZ0DWI8AIWGBHOlw1vW
	 zh6Q0OjhKjYTXtWfiqGGkQpD9lVxQq5caTGyVU6Vzfw11RHtyfPhZ51CI/5IzykoW
	 k5AEndazlZdJYXDU6uhhSns1MfgNg7AlobTpFQPocxg4ZL0Sz2o44e4zRHNM+Pudn
	 DVq8oFZrbuYJd81qUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.10.12.239] ([156.200.109.2]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTABT-1tfHCo1pdv-00QM5B; Mon, 10
 Mar 2025 08:26:01 +0100
Message-ID: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
Date: Mon, 10 Mar 2025 07:26:00 +0000
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-ext4@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: A syscall for changing birth time
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8gFaD7N23b8Pf6p8d79ynv+PB2t8EstQuP9/VyRhPk6hQ/LjJ5O
 NpGOT9+N9dsYR9EUGZVwjmD8wVH3muhU0R/aqSg4/ert6Y4LOS9LM7iTrVXTJoAiwJCPcNx
 NxXKOltRpZhGoYE32yznlmppd/hLSvw3eUmpch1FEeL1kpYzf5ykr3XPPheCuw+LtGQo+SJ
 qveNyAHvh86TG9f3Mn5BQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sg9bfIL8f+U=;qXR6csuNLyav8KCo3Xs5A3cB97G
 oYTa8hTst/OcnhdZg6Y8KT8aGEd6fyOUhdNgD63YBetgbi+TpswyIDGqRKokXsD4uL19ZFg2n
 V6L1H2HSa4SIritAXDHXgwRIIZJLcRhhcmKx73MOYXetQIrwUk7GnsDXcatc3sjgNlXdkc2RL
 95Sa8k9RRBQ2yDKviAihhK7vw8jKLYj7EvpXhCSWrzpuuLZ3RT+CWUFj+kq3GigOyz1YSDAkS
 oEE0W1aNJkLcohzyzgHyEfHuJLdHOHgpEZ6j2MG54OOu94DVtBEdYUVArnrSNnGL4nRUSKXVB
 Ff02NuR4Jk36XrXDsVWEE4bB+8Ssx4Vy7O2lralfOR+p5DUIZyTIG16iIHCAr1oEQSjuPn37l
 +QuDyb3YI2vxB8a2BCBQuI3/HLd4pRKSgY/J4xlEUPNoa8PuwUdkhF+LaWp35nZ2QSB8plIWv
 u+ZzsRN3HCb2vFcNQ9KB3/lFvd52p5Ea4Sz4Nd4BOXxu024B8aCw6ZzuQL/iTIgFlvBj01qWc
 XbApMFSRxfkZeN4dk4aG1dEbFUKw4g2BDmv7meVtRHjJVwwtIk1jO6hQcn6TKaW9lnOoBbkAz
 bjNVSBDCfdB9gWF9SSoRzgXO7iBXXbZIX1zKJ167ELsj4wYZufpZNKIHGoH1WbchbUlOq4xy8
 FpFlVYey3Qrl++fO7Ug5UdahqLPeBPQmStafctNLZ+iL8sak2VU5Sln2y6nXru1Q/2EG0sA1f
 ReeWkM+Cao/OAhK1N7mixVfzV2uDNZ6EfdfBWQ1tmESzojaTHYbrkwlya0s4qYiNs1Jc3dhBg
 GqfSvIm3yYztE6w91vjiRkukUT/Csf+CbHGo8D7YgS7jHnG0XN16qxk5nNDUwwyilciO1MUfN
 B36/r45UIqjg9ATCvGul3M4NFSRjxqlJ68HvAMC+kAhqMrNeXkzhubGSsSxXowqbOfhIq1lon
 ezSFzDuxTbWYSIBJffeZdyOJIFWpV6GMJKU9cMISUTgIbkc2n1ljrzfg2OY5co3fRegQMox5h
 Dz2bGbxZFbyaPFkYAFPhm5M2PITFg0MxCUgDRfKV15at62BSt9K83ASKgPRuaFZezTgdgixCf
 lWVpg5s9E1cP37dFnVQWhzu2Svp+k422BXmLH9vV1gwkZVdrW5wwj55VkC2uuttXFRRX5b1t3
 Xmxmq+Ux20iNpLKMy2Pf2MxVPz43gCY8/4ChdY/e5/jOedeh/WgPifQzPu77pC4cfZMolnUWB
 Fd7VK5YuARs3gpLd7LqE+JKFTUs4o6Pvh5Hz70gQEqqspinMdHuayHlPSbiBy5jsmGJeFV794
 VhZqn3FYPlPpz9ZaCgbpfG+RROvLTVAQTn2iHmiJxcmm/hZ/Z4h6vBXsTKDuA0aevvqO3DRln
 +/7hG/x010uDONPbcG82xoLRxlhuY9VkcZizueYTsJHv8bfoZt5VO82OaN

Hello,

Why is it that the Linux kernel supports reading btime, but there's no
syscall to change it? At least for ext4 there's the debugfs utility, but
for other filesystems there's just nothing. And even debugfs is not a
solution, since it requires root privileges and an unmounted/mounted RO
filesystem.

Having it allows for better compatibility with Windows and BSD operating
systems and could improve backup/restore.

Best regards,
Artem


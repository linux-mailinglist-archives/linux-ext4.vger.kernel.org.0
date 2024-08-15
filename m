Return-Path: <linux-ext4+bounces-3730-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E381A952C7D
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E04B29321
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46F1BBBDE;
	Thu, 15 Aug 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mkC3OrQH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3F1714C4;
	Thu, 15 Aug 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716179; cv=none; b=Luh7Hk6gxjLMD8sasOmjkyvfOCggzo17lEirF3p4T+jPKpx1Fs5iLq2wPboEzLL+/vxVrT4cphKLc5UBYyzasEEL/BSsZkpuRs9nHw4/4zmOg2PGMx9kBmRJKQdR923tnJnJvYngwaG9Dl3NiPc0qzZNoZeEYTZ80frPbGYU4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716179; c=relaxed/simple;
	bh=opaTHF0FYquU0QR4xUtGcrbqwy7XWU7cBuztM5O7ykc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qQ0EZ+GGAM+QzHhXZgFRG4M67O+ZLfg9vYGqFqx/CJAknmEAfTGivJyU4y8a1+oqV4GQPNGq2yZWa/+O79tOYnJOfQJMZXhVHkYDJl0PZRp2IcfB/BB5LzwG57Iv5TofDg8/rNeU+NYbCW1qFMiG3uY8yQJp9Mifc0nepoSTLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mkC3OrQH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723715747; x=1724320547; i=markus.elfring@web.de;
	bh=BIDHjq8/nt0EFcVBhNoN0ffl/t4bxwEOm7k3+GMz6u8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mkC3OrQHkwJcun+hPynZi7SLyYyskwSBuJ0NSiBy3xrHEOlhjITJ0IJUAtu+TjRF
	 BqjE7wrchV3/1K0/M7/jJCEe6HEg3uBhLPIECQ2uhmVwodgOiG75nulQC3dGxzHOr
	 94pO0XXFuR/lch1juwaZHwpuvoFv3xc3NY2pL0D0Mr3IQBYadNu6CBeMJfer/oqe5
	 SlLX2fdG3rwwzqRnfN7Zc0wiMfq1vvnC5aOvEiYdWXN4WuL76CSTSraCbAAcTquBc
	 2CRDgwYAql+0+x7WCUxddV1CXILow+XR4+sFOdGTs9ozuzKvzq59pTIrXuKYsanYY
	 a43kK6wVhvXq2RGEGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5fd-1sfK2Q3JLp-00L6ro; Thu, 15
 Aug 2024 11:55:47 +0200
Message-ID: <fec59d4d-898d-447c-b4fb-e9d055550f96@web.de>
Date: Thu, 15 Aug 2024 11:55:44 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
Subject: Re: [PATCH 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+0NXfX4/vDLKQ4u7wJLI4kMdp9uPckouU58ypuB3SkAqOKGl5Y6
 5e1VJzGQcG7fPUasPdyMr8tlBgwdZsZqjrLEKuKP2DhMIhHDVKsiw35xq/cQxx4vrdBOTAR
 GKNqdpiuAyvQjlOrvpg5dlVCwlMgFMlnxmPi2bjANmhy23RVw1iZ4UNwjjrzrRfMigRU/nL
 eIluLu1cpUrxVfTEXFehw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y7aQx5hplRU=;qJaoSJWo8kLYI0a1F7qdKLQzS+G
 GRSc0KDPCGvlcmaW9EJ/RRzN6BWJqi+Q7IHQDvOflVT3nBqd0wrHGahvw8YdJyS5+aUlvRSkS
 MrpNrmyDuuClj6BqDu1HBnwXPmBDmO4g33sflpom2MZ/C2vORZTdWZtg/1Z97zRjBHTirE7B5
 dx2e/fGbJnhpKU+d194mXeYGgOCxsGD/OFWIBVc/WDYaQr8OB85AplQg0++tZAITHujiqic5B
 /YJionorQzxetpnhG1rd8pa8t+UvtApV9MwKme6yA8vZCvQMOoW2T3ZdXQUAdzrH6Glfcdn7X
 uz275ND0Z1im8V7wgjU9nyTpcA5thZ7TNoGK6tssxDN5ykW+cozTvnNwLKpRj9DB1oesT05Kn
 iGhzF+7ZAIi7toaDuMkQ/jGAWFKGGsfSbXjTHDJzops0fz6caorzT5ICrBopS1/KrTWFrrLCS
 M+ARG4qWu0K5R00MwRpDzhmBM/gKxRnza59HSSQjrYKM0QyS0id09VPjLetEiF8p/Ngv5U0Bf
 YZ/EI00d1SRjxyhOq1RwDTeY1vc0zInaQyTgyjc1AAwqJl82bIJe5MqEcw2tr5OoEvXWWzI37
 Krv1AIiHPxFqiAG2pCo0V7zdo1Qd8eMY0gtCV2acaekV2wTTOSmJl42uYMs/WOpJn1sHTKb4v
 YDc8XvVZA10hH+lbDlN46hmGPgx1XTTUwv0558U/boRCcFlnyZILMxzbk16iNSUxhHy9Qiuu1
 WtpCHbg+gbdQzzZHzOH71kCH5ZzKMGa0bW8GeAupAmkSvdimaxuHRDQMpiEjhdLC/dg6YO7zb
 jsPJNIWVpQJvgrQvKUaqvpOQ==

> Release inode_bitmap_bh from ext4_read_inode_bitmap in
> ext4_mark_inode_used to avoid buffer_head leak.
> By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
> is NULL.

1. I suggest to split such changes into separate update steps.
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.11-rc3#n81

2. How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?

3. Would you like to append parentheses to any function names?

Regards,
Markus


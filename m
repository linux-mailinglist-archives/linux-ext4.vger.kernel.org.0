Return-Path: <linux-ext4+bounces-3738-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6995422B
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 08:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E82280DC4
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 06:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F91839E3;
	Fri, 16 Aug 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IxhtdRzx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FBA957;
	Fri, 16 Aug 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791444; cv=none; b=bhREP7K44E2xnOqe3Tot79jQ6w5rjOSCwUMbkAuJA51QTjTb4vVj4M9l0yLLNbbd7so3bZITPWfOf/0BD0SXmB+sXoY8YuUKD+SJhZYnxWM26vUJwpOrqfoOVN5BY0ZA5rBtIwHBgBqqEb9ueOvfX9ovRNMuqnArjQhR/Hkwfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791444; c=relaxed/simple;
	bh=doGtiHWmuHqLydKCejNH1cXGePY5NvRfvrboR9U1uwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaggeGkeIZpHul/AegFCTduAs5Ivyhp2SbsE/wxpCD5Ofzcy4ABNtnBIL6UIAKTYnWdoUCxcFI7Dxjaox+4PfAeAtDjiZQ7iKeRfvzWK4o3uTnBtXYnlWdhkIsLiMuDzIly4Y3vqrIWKu5bbyuCHKvJ10k0Ht13RNyAhGP7w6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IxhtdRzx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723791415; x=1724396215; i=markus.elfring@web.de;
	bh=sXZGKtgHt4xO3zzHCeQ1DsiA0tuxUX50+rTWb0LloXg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IxhtdRzxWKs+CEmbYSHSuSsFKy98PQUTxA+1GRotMp+lyIXWVpADMf/+s9XGgS9n
	 Et4KbRdEEZiOg0LB7mB8GYNiDZpC/jy2Sm2onrJ3Re+DPl1UbRFOddRcHctfwXSIT
	 8zWxAO4uEf5AyYvvgZbAa6Rwg3jGTev1Hy6JlGo3TflwQcBSP5YLrJIh7yAjcjA1t
	 KuA5d6TaSjWGvtKYUVjn/5Mw2rHN+67qfKS/VPtKPG82yIEM5as4Jhfi5M9QbXRVf
	 gTrb6QUP269RcZLNVEmmQQrhPRQ/83k6sD8ZQJG3AVqSrkDJ0y/LwFmx2OfQpVRSH
	 x3zdlWmEeo0pYmu0wQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0PR-1sSzRy0Gzd-007rev; Fri, 16
 Aug 2024 08:56:55 +0200
Message-ID: <a5ddf25d-3bd3-4323-8649-c75b65070d01@web.de>
Date: Fri, 16 Aug 2024 08:56:45 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used
To: "Darrick J. Wong" <djwong@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
 <fec59d4d-898d-447c-b4fb-e9d055550f96@web.de>
 <5d75ab7f-0fad-07ef-bbcb-3fed16a5170e@huaweicloud.com>
 <20240815144905.GA6039@frogsfrogsfrogs>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240815144905.GA6039@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ouAnwVhmWtZjMF7oBv4PLEmQ9qXprd4QdyQHwL2EXL0vFdFav8v
 BarhXGykkw3cLBDKezbykJHTRtjvA2S1ZUYh+UENrinB995qEdwxkcIU1muCeSox7b18u1p
 xgSLaCrmfc3Cnp5mmqoe3ou9hExxtFFLQDKNpCw5rcM3NHjwxQeBWX+7l6vo89XjKtcEEAU
 /GUZKx+Qz7RJchZW0Pmlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IgB2jrAHMDk=;S20QDkvMH447NUHlRjXkfHQhJjK
 4Sbvnzmim5bBJheZfzRzP7pHR3AgCUkKFSpRMf19RMRjlL9ZGb6+iMqQKRNKJQy+Hf6ruDzPh
 5VyIUB7xCqMGEchc/NPqdIyVfdI+JogMvesBmiCojJpzoUWFqVKL1aHBWDjq7BIZO0E33O9pg
 v4uh9dc0oSFHt/pM4r82cnDWwgBTjo4m/BHNwVVXftvn9SlA5eC+vtnP8dqVM8z0jgO9WwhoS
 IQzfXeMksnzsVDO/RTPpsV/SGX5baWPfFDQ0jToUpJm41UYL7bqTTZ6AYE8xFt7XK7T257U6b
 FMw8hn8V92+m3LVR8FpFZHzDfponLvk49hXTgQBeoKeYifWj9Moi9W72irhBVyWtBopfQ4xMv
 KGtqzyPugSQCX48EDkld54bidrTDgw27oMbG9uLe5Nh2OjDQ3fOLsTo656lJOh1tzg869DrFD
 C03GMMk0LMSyVi3hese8NwmOfCZNL45w+PgvTkVrX4g31HVn2wnRiQmubqMPg1lVAQv2GnvTK
 poDQekS9eg2yc4GtJPhCFhId+KxOw4+JO84twPAFfbqt/arLCS5q9YIj4Mot8MF/Sj5T3k+fV
 oEAmgK+TqZnIFbBxaqT9g1OjEg/5t/n4jfEtmKIzAfF7EZ2JUcUiV62XWxHfpSH5yYlD/HZ09
 kBMVtrozHrbWU61UW8dtW7kzDVwpbAHmET8xc+jtISi7fjeDAVK+LCmqWw/yNRLqHRu9292UF
 hnJrKli5z07m5SyX1y/yN6b8VtieZr4DTOb9YN+8AmC/LzJEwxi4XkduVekQz4rrmo1tjQBlt
 8OzoTTiK2uIuGC/zf6/2Q7vA==

>>>> Release inode_bitmap_bh from ext4_read_inode_bitmap in
>>>> ext4_mark_inode_used to avoid buffer_head leak.
>>>> By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
>>>> is NULL.
>>>
>>> 1. I suggest to split such changes into separate update steps.
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/process/submitting-patches.rst?h=3Dv6.11-rc3#n81
>> It's acceptable to me, but I'm not sure if it worth separate patches
>> to others. I will do separate in next version if no person is against
>> this.
>
> No, that suggestion is stupid.

Please reconsider such a view a bit more.



>                                 There's no reason to generate even more
> patches for a three line fix, it's very obvious that you're fixing a
> missing resource release and rearranging the first error out
> accordingly.

You would probably like to distinguish the severity for two changes,
wouldn't you?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11-rc3#n168

Under which circumstances can you accept the separation of development con=
cerns better?

Regards,
Markus


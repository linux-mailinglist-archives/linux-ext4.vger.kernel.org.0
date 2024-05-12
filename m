Return-Path: <linux-ext4+bounces-2469-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40828C379F
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2024 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF98B20C37
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021DD4AEE0;
	Sun, 12 May 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hiv8+BDC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C036122;
	Sun, 12 May 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715532314; cv=none; b=Pe+ayQGIlGyXSqsnlr1ngroLwGwGJXqGJrcTpPpj78qp+l/TYxeK/DRXbqDgoHhT3uFKZY0rA5Of78y8w1xq+ZpDhP40NhHiIvYl5avQCx5saLjQOuRmoH6Rl71XdJnlJAlWiNwyoaGI6Ej3vKjbu8c044FCqTzI3vO/a/PTRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715532314; c=relaxed/simple;
	bh=2pMCaI4MkXE4JujOu1FunSQxYYUR19dMTcOI+61p814=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WKB1GpQx6jb233+6kwT54mIqOai9JctF81+Sak9wIrjFv5qcg994iyPC++kovkWFPdlO+bXhjz0OO6dJ+oDagnrCi4j+7h8zq9wrDauGQ4gy2Z5ein++LDIZ2R6xcOoWp4K+quEfiY+MxvQ4/CIUxnmLAK+dx3S9Ihs96oVNLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hiv8+BDC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715532276; x=1716137076; i=markus.elfring@web.de;
	bh=2pMCaI4MkXE4JujOu1FunSQxYYUR19dMTcOI+61p814=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hiv8+BDCho8eaerxrk9gbUBGrwfpk1OgAKwZsI3SSn047xHfEEVLL4TzTgc1nYgq
	 yJRzgLJ/Die/9xA/On08WM9R65UjtOcHTmo9LTj5oAKcPsj44norIkRR24X9zqco4
	 0w4ZGbT6+U9zXgz3kWUNPl2PEuXqg1LtZ2AjNXZRB5QOVBZFBldp6VwvDCWrWuWhc
	 mCAziTOkmvI27hiEDwODTbrVq8aXU5h89+b9q3cFw9QlgfWF3Zze75IDCPOqrIBiV
	 3ToNqBUxjF7kcojt5qe9Zl0QKzL8OChHv+AZCYcwo6QFT2ID/5gqNAmu96syfTgHM
	 I0tiJ8mrEI4azA7+IQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1s4zQe2Sfk-00YD9h; Sun, 12
 May 2024 18:44:36 +0200
Message-ID: <749dde9d-d4a2-46f7-ae37-638b4cc95249@web.de>
Date: Sun, 12 May 2024 18:44:32 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luis Henriques <luis.henriques@linux.dev>, linux-ext4@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
 Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240510115252.11850-1-luis.henriques@linux.dev>
Subject: Re: [PATCH] ext4: fix infinite loop when replaying fast_commit
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240510115252.11850-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:enKyVoKCLTS3efop8Am9z49VzDdZsucJ+BPKQEBksbAMFQSZopr
 8uZrRg5d70Cy4jxlquea/yhjH/yxxmhBAQs2YDiKqjWHXkLKUh4eeoNBo6vO+6Nntf5q6Au
 VxdECCUrvtSdXXXfdrHYyo5/lDvfU4bs64ty9H8ODkNGvLJtJa4D1tnTfRdp4Sp6BlL5gKS
 TmM8uekIaaF2XL7t3rleQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eEZG2u069MY=;RSI28NTcb9VOEAnjioPKJ5VYxBh
 VSHAEavQgSsL33KeM1Arhv5I+HhbLth9QE8OPyw8tjDsdZee9uotWIhkIcjTidFM8ifUJErfT
 vO9FcdC1Hz2E5US1u/mB2LEDBZSaqjNdux0ddE1bk4Cb0jyL1+h3zNRqqXJWswD+eqso+zInc
 6pEW8n44ApF/O+u0J4m4JG2cFSGWpdfBNibLy9qx1C9IqSwHvW8rBZ1M2kVApLeOmZgtry8fN
 4PM4j3nRN5x6+Y1goyBK3qLyGsOfqwRx/HVcPuD7loLaPwlpln7kR+UzFbqvkH5cKG9EppIV4
 VNa3rov9LW5VfxtHntx1WqtkJkoiK7pwnYGTHj2jUktF0B97cBNVOh6totCy+dELruTFelWY3
 d1iHAGWD7yCDlqCodT3ddF3lurbFEFlnnZMfLjriLwjPCfeuXR15WJp/gMFp/GwJcJWWz7CgK
 wxWEleVNpkAfPxf/XGYfhlQ6PK9CpdNiwSZu5OaL6RP6eYGj4dwhHWQSEOjhBJYvF6l7AfWqC
 UpjiCJ5thtHiIg8kLL9bEWn+WB5Hz7YctP1TZIyheB2/RuFl0LKpia0MB0E2l/X6NbkRVNmj6
 qUaPMmiPmi98lI+B26IQByrIAC+vmYz8XYu9IGcv4aa2ukwmMeLOfkpgrfr+iMsA8g7SzV9ef
 cH6AsU1UHKWfUduR2/no5fa3Uvjw9Xa63YhG48iwgYp4vKA/DwQrobxaKGzcOElF7BC5pK9Sg
 LYReB9Jph+PMxjGRnWklF7iDFA2rRfQ//1znFEMaFK6cidEN+xFAP8z/71o9PHZMkbBZvagZt
 q0CAznhK5+q5H5nA6X//inb6nR5cXf3FZp+Twrq9lHxBA=

=E2=80=A6
> This commit fixes this issue by detecting the replay =E2=80=A6

Would corresponding imperative wordings be more desirable for such a chang=
e description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94


> Thanks to Zhang Yi, for figuring out the real problem!
=E2=80=A6

Will another tag become relevant here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n527

Regards,
Markus


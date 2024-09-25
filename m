Return-Path: <linux-ext4+bounces-4322-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE76D986739
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 21:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6941D1F2666C
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08CB1474AF;
	Wed, 25 Sep 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WZlV1OKt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149C145B26;
	Wed, 25 Sep 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294077; cv=none; b=VkOPWqLbjYwyrqzCYlDbwPh9RAW9QHKTZAqKCRJnOEw0NuX16Brr15jFpT3CrU2GvEEBSyOKTeAmlhlkQ2WU85+uctNyTJs6oMVLPUWTykktf+mJbv70vDn1xZ5vug9GwEDg0uUXQ2AjMn5FhoJUXhPyXbx19qxE6885tNxqYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294077; c=relaxed/simple;
	bh=MHYemQ4iLJxEt+SBHZ8DDhtdDBmysgd2m8HWLVTbcLk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nrRnRTBxZ83ZmJGp/mPeZ72lYSoKmqtlexdVw2cB2+htMWNDcJ31OJC3BFQJ3gywcH2k1LMgCyQfo1Toy0+KxWcZU8IhMqENgK5RLVoY+81qzRwd6YEjVW1EvS7Vc6hTayD2R9tQZooOZN7ZJ5EFn97nULLcV0Y/x13UIxm1xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WZlV1OKt; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727294064; x=1727898864; i=markus.elfring@web.de;
	bh=oZFXgGZpN35Zb33XWrmn6Py5ABUqGOrhRxGCArCoPsQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WZlV1OKt8vJe+eWHvXmXian3WVMAsLdis6oc6rAYeAgIWdG1xCuyf/SAQXqtr+s/
	 F4iFc60CGfBiPHosuHxSLBDaLHDOGOGEprWdxfMmboMVoM5FPs0u8Hp5qeTghNMPY
	 R+Nf2MkmArRMvOpV3DJ50ipKgzQmaNhdNcr4cbeNO4rUyAE77MhWz8wxaYaDR/ceu
	 8/cEWChONkGNknDF6nHfzoYkTkxHehp2HG6nt1nZIsaBYjQlUA9ClogqPKQkBRQyM
	 bLuYFYGZTThnJRGB2HMq4B5fmq/HmzJtZQkB80xGY+ikmLnRHnWPjJBs25c5NrpsV
	 Rf9xT56OR6RACRguCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1sWg9a3le1-00P9Iy; Wed, 25
 Sep 2024 21:54:23 +0200
Message-ID: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
Date: Wed, 25 Sep 2024 21:54:18 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 Ritesh Harjani <riteshh@linux.ibm.com>, Theodore Ts'o <tytso@mit.edu>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ext4: Call ext4_journal_stop(handle) only once in
 ext4_dio_write_iter()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+Rv56bpzb01vFl7kAaSa0ilOzgrnXCwdreS4Meu1k9Ls8DgELx
 MRrsN3KmVbKDIU1FGMitIJoC6nM7t5Cdr3Xe3JT7EVTSwhqeTY/eIrQeRHM7IAHgfd0cQYG
 raRYCIU8166o9UUv/CgiRSEd4ie0/wvJPMudeQFymHzQDQdxmxARo66K05VK4vPhKCXPJYH
 kAQNXGMA/1iQSWYJFNCfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kajW8eoXXRI=;WidS8QTOOMrNRr758M3ooy1P6F4
 G2wZH3SQPlqT4Zh9CLES7uKaC9L2A+lOQA5qk8+ZVvIUUyowkYISsZE9ElJaJRt5pXJM3zB2m
 ETcP2gOzySNsH0D4ej490l04gwHtLQDuz8RL8gQ6LVHqshEzVLvlQGdRoRO1q2QpQyA42CLr6
 Jx0dwCDU7Hv8TvC8qZKTF9yXSx/ZJSLJTowF0aGsFQlrlAZ1sF/5hrtqyo9bkTXvWXmDJ/z9j
 vm7eNtgrgfVI5wD02XN/FGiiAwszZIr4wGSpA26iY/5fA59qalsTZAZDQruC0ucdfdzc/ws1a
 AH8hgETGYm4XYN4dmng3q3eZyOmdf1FMsn39LGO6nCafv2fWviUUkP5MVvGtZz8ux8zITjid9
 AOO9yijvkwk+bEbqt5Bj8+0gkOdhqhejfvjITsVy7HOBGqtiC/6xPpRJR+pORFzrMudI4Of/7
 Arn74bZOLYvprIgq156zOz/jjh7zBLkAaJT+tvfBrj9focTJvakUbUx/3GS36F3wRsvtPW+oD
 pui4BX7rfw/rPjxLOuOsAJ3cI9Goik8DcyRlocERetQvGwI8PzTXIo0+kg+i7YVp1AOEVZg8y
 5cWxVhOO8TASr97fF/FfAAKYP1SLC47sMkeh3GFRhmSrlBNLgSHw+EW8gRQcprqpBrQENHlRO
 jqrmFd83wv2pdU3P3wEiqcf1T/1Y2wWLpgSKWUGcE4C1keyo8twcAjppq6QevHMn5XlL6hnin
 XHEkMeAQZg/c7h4hOePQ+Ymsvc7BFmBrisBIXQrQ/GvsAcS1C5Q898EFpiEleHL8AtbVqc60r
 epB0pNSSbwdPI/a7sCbY1guA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 21:47:39 +0200

An ext4_journal_stop(handle) call was immediately used after a return valu=
e
check for a ext4_orphan_add() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext4/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..23005f1345a8 100644
=2D-- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -564,12 +564,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb=
, struct iov_iter *from)
 		}

 		ret =3D ext4_orphan_add(handle, inode);
-		if (ret) {
-			ext4_journal_stop(handle);
-			goto out;
-		}
-
 		ext4_journal_stop(handle);
+		if (ret)
+			goto out;
 	}

 	if (ilock_shared && !unwritten)
=2D-
2.46.1



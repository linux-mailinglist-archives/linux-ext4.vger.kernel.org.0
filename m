Return-Path: <linux-ext4+bounces-5814-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702989F93E7
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15861642B2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB29A215F7C;
	Fri, 20 Dec 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ud5HoFfx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6641C5488;
	Fri, 20 Dec 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703547; cv=none; b=F5wnBSooCNAMKudC2+dd2uSfx1UQDOX7SRU4aRahURMMnCJUjBCvc2HSgTM4rqHVOrqb5//HA6RPzlurab+O8bknw7MsYfxsREaWqjdwRrOFfgZAbMg3bsoYd4++cCQtP7EtRtoBCbCh9TJcolVNqhFxsLADmdJX6524n6/ankc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703547; c=relaxed/simple;
	bh=jfytMxGv1PAIKtPfDsLLZQPTpAwUMupv7OWy5Gw6pes=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BVV2Jb1YT+YcpqGc7yG7i7ceF8/ktfw5N9VOapLFeTc4EweJiRGWgxy7SXN8UKKfnvJgADLpD1k2/JYSJhgr3K14PdxEGggI0ZfSec9LY59HhaCwv5kxnwCw95/8DUVHMhkh4142gq/juXgSScXOJ+JYe15dmIosHtF+XxBEcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ud5HoFfx; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734703541; x=1735308341; i=markus.elfring@web.de;
	bh=jfytMxGv1PAIKtPfDsLLZQPTpAwUMupv7OWy5Gw6pes=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ud5HoFfx5ojFU7+0uRxj3vlGr2D1xDEtCX0cINx9Y8uwv54s1Atvqv2Swk+3iyt/
	 E/s7O59FWUz6xLsfWY9u1eaKBx/W/A7HpSJSLTUL14cTRzXziTb2aHc7JHZj5xR9r
	 1ud01DRNSktZg8tkfePBP2ciLJPg3mCzWlO0sHl9QbdBYy8qxgdHMBuPMrhu03DsA
	 7QmqrvrYG8jqpmWRNbPKz9f0jBpapRiE2BRH7zVUtmzI1yVUyL9mGLe+RYxmPw+V6
	 lia9IDG707GXVWX92ILpXhnsE7AvbWsSocV6m1CjZ8iyB3YJvNoyBokARLGfm5UX3
	 tHy1mL7Kb9iDME1/jQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzkOL-1tkPXv2VpB-00umOo; Fri, 20
 Dec 2024 14:52:42 +0100
Message-ID: <0fee3433-1255-42ab-80c6-63a1d9f9d47b@web.de>
Date: Fri, 20 Dec 2024 14:52:39 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kemeng Shi <shikemeng@huaweicloud.com>, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20241219110027.1440876-7-shikemeng@huaweicloud.com>
Subject: Re: [PATCH 6/6] ext4: calculate rec_len of ".." with correct name
 length 2
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241219110027.1440876-7-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DYIm1Dw7lEe2k7Zf+ChtIdDozHe+WwbVz4izqK0WNvUYVn0WBnx
 uMzWOO1uNoQzMgK3fyPs+m4Fu6ZxFFK1VqIdzbefSFkEOhNLv6r4J0/riS314XhNEfUaXhb
 QFVdmVihimyCltQTyhHQ/ZPpsiIZcKnWM7wjo1Q2HdIZiV4EoYUcBgsccNohOy3svLlsEtM
 +nq88vBR+Psg6Zey7JHSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a1s76uV4b2A=;N5066Of29qVLpHt8s6HeCZTC7id
 NUo3sQBvk1MQ1pYB8AnozihrzfQWedbIG2jSHDiXZhLFn6YAXEcFHoqufNCsgVUOOEixUYlxe
 TQnPEBSZFDHWKPX4gS5JBrRZOHUsTdEczijCuv2LU3CKgGBGVzwHDcRIWc+hmv4uerQLCuhIw
 3G56DkSg0HVDZHPxPE8C2hx4HHMPn/pxXUzO0w+pADAXb/PQgnTEnDOk63WnS4r6Pjk5JXHUf
 Di5mFE6Jx107wP+Ry7/ss8FU7uG44HtWFAt/Kgiq8f0KADBzpxEHXUdqOt8TF/K9vzBAVgk1/
 AkKbdk1ioom65MUMCDWiHmvuhxfhkn1RDquvt8PPua+WjLhqkROEBTL2j5TJzPwmUR1svXVh9
 A1q/KXoV0QEM8rwvReBVC31u5N59jWcFu1P/wf9oGBoQo7ctFpPq0Wrz7sNqLt+cFQ1hBbZsB
 xhz9VIkujw+W+oORyQCPTem+4Elj3dQNGyJVHvB8lcuaZKw1D4tOvD1W1cJghroN/dmqVfYl9
 P1c6y9H4SoMKw31Nc6KRfpcML5dfU+TqWAuPGPJfWYVKDR+4S92rNgFJpVpIu6tqpA2sFiTeC
 Iq0/YPGSdeX1VCa/mfX0l/g481q9UHr9ZXXqTQfTSEatWVMjRYFJPEW5t36BSNEeMEcvMZg3h
 qmH5ToOq+c8efgK/rkkiiTn62jYm9UMkSfEWgr++HkJGVXbawcOVMH4YVo95S4qLxT4YFoGhR
 C3HLtiYhTNhSQr9oAvX/m8qmnhh9l9toCtEWHbbMucehpsm7yFsZHXSh9tCEpJ3Kc2wZ1jk2N
 q18/ZxELONs3fZ3yJ8V4SDx+8zlziaNmRhPHUur37gMkLyrcfRHDL9BedCrWccRkBI8piG8NT
 a4WF9K4FZxZRE2z/5UbckLpteEFp1aNOVe8xB+66K7k7ZPL16fK2udHDupPAeglbLY8XB+aSw
 dBe20mlrUAdJdXCvHfup8DKwguKQnEnEmftk3PswNdXM7ST8teopFI1Su4x8tOjq7M7zFwGC4
 gby7lENmkpHoJ9U6o1xp3HG29D33fxiCGP+/ebncW+FsDrRqbZmhCq2xyl09pTDuYcRWdLrlq
 nHJx8o7ao=

> The rec_len of directory ".." should be ext4_dir_rec_len(2, NULL) instea=
d
> of ext4_dir_rec_len(1, NULL). Although ext4_dir_rec_len return the same
> number either with name_len 1 or name_len 2, it's better use the right
> name_len to make code more intuitive.

Do you try to point a correctness issue out here?

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc3#n145

Regards,
Markus


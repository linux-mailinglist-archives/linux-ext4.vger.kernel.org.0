Return-Path: <linux-ext4+bounces-6660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB50A4DEFC
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 14:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18BC3A4911
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92164204582;
	Tue,  4 Mar 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="k4iS6DZQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260420371A;
	Tue,  4 Mar 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094079; cv=none; b=qF+JziFTilYMV8OEQ3yuxjIh2R4RbE8+aeXCuziLj9+5+cKTJk0+YAEGytGIjta6a9i5BME6xE01NwFLgktdRodm4CRpZxc9bPmrEZ1RiyFrc7oqlDyLw50ZMsmh/bw+33OYRtEjOtQUVjbF6q5i5UhVy3v2VnpvMN7VzLJEPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094079; c=relaxed/simple;
	bh=YerXjkghjd4gZOl/fHPqYfL+75Cdl2tBf53XKAvwNSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VmV6rPoh9Vg+TrvMbTg2RifMxUfykeYV1ShykNE7mKRhNI/ypE+14CO8x/9aUKvGu5zyURV5GIodCAjAX+m0Ws5lkujuu2HM9OmDIVI0iDCwc5bbeEsutWLZzg0cdt180cSllFRjZ+iAkqFZV2yEkAprhk/uzaryVTziCHMsfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=k4iS6DZQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741094064; x=1741698864; i=markus.elfring@web.de;
	bh=UMMNbqmprEUf/HLWOjYQYKCqdN+GILAnTDEYyfL3pew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k4iS6DZQ8/M15TRZ65pVu59nIeVatpdt31uGFspHEieqUYXIl0Z+N7FHmFPZhyDZ
	 V/QiTDVCKKX4WzY28rlTn9RyjanmosZgh3nY1VpW5Mm8iWO+xqmTODtmP1tlgkMgf
	 xAKlPeP2LRUVfR8csxkKx2TQJFjAEQ9OukbxLAEeaYzo/rwyN6oC4noSyCvuAVXOp
	 kkNtMsqrHUB5UJ5KgfisFh3dOeZSV2QiSYX71CtTzBWlxfgpMj6UndWvOGLjMsj6V
	 AQoXeQl78DbqGRUrAIeYf7Rsd41SiLzHRtWmoWCujtFjFwlFj8nK4vZghKk6DG8J5
	 8oSTRSbYfUiTbp5nqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QUJ-1tCxYw3epR-016ZhD; Tue, 04
 Mar 2025 14:14:23 +0100
Message-ID: <81165091-3dcf-4693-8e8f-658cb95dbbb7@web.de>
Date: Tue, 4 Mar 2025 14:14:23 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] ext4: Fix exception handling in
 parse_apply_sb_mount_options()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Carlos Maiolino <cmaiolino@redhat.com>, Eric Biggers <ebiggers@google.com>,
 Theodore Ts'o <tytso@mit.edu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <7214c986-4d0e-ad78-6312-c84515dc9abf@web.de>
Content-Language: en-GB
In-Reply-To: <7214c986-4d0e-ad78-6312-c84515dc9abf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5kv+niPk+2Rgm08pXEtLMbHHQnvn5ILOYRpqiTaXLnnlYAhqjj
 GBoPmLWu+eHxJk3tVh6KBsVIEcJb86QMkysVG5p8vK6giss/7dfoAK+WczhPNmgWmWiSVDM
 vl2X3J8+Z0wTg11ycHOmqNpJr6xc/HUI6a8/9wMHc8vLPbaEK5GYzEIDw5K1SNeYFWRTdFi
 awo7grstEiuQ+av0enmWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cWF7ctUm6do=;l9kjC10cYUQOgJH5/7DPwXKZZg+
 e8kTUx40Y9u2VbSiu+UG5ma2q5LPl8u7igzHcRvoTshP5VnUN7djIRGF1JLZT/ojGIlwY4V7J
 OlbGfZkFpDqcoAkfLoXZaun1IcyOcPCzK19ap4AVQwzweGyGRHopTMuPwhtptJz8mRPuQ6FYv
 3UFryxssmNvrrn7A131YPnpJZbngY8C1ITn8fgH65OjidoYUNNqLD6eezHYWX6edtHFT7HbpN
 YkQJk2fsmsPiBUM9Q7kvlh4oCdup3+JCucnHGRMGmfJMCbf15LL4yU5ZBrzGrmDXVvg/0XABf
 WhfaCm782WzcrfmJPRUy6NI3K+wH732abRxIrcLMf69DVx/uy4TRcmLsyEnWXGjStRIOmeT2z
 cekaMJZ1qqyfbR6X5rTj9kDK2cLpZSc2r6GgBGR7fLc4DNH+ZcXeUW8kSeOkCTxovDrCJecQm
 WqcFYDrHUDBZhv9FZsbQI66k57bdrK6kzQCKMmirmRfHy1LWVdT9ynZEMbAsgKV8OsXiZX4Hy
 dXhkowFSbxJo9mQu7+zjBYCAwtj71pgEuLAi7WYSQ7sMgsAvBZrjoUzNrFiZ5ReiibepO4zF0
 uAq/i60lNCGIs6XO5ZCNznigyEhnraeRIcmvkGKJ5uczQCQnO829OjlzaCg6AE7Pz0uOj1TuG
 kLJ7a+HHwxg2iMBrQdbfrnCcTe0g9iSXU3z4XaiybAZV44s8+hHBaCwBC0sb9Afx+D27RphUO
 c0Sk7dOaxwAMdOTlVTxAgz8yixSpdtdArrHjIMz0xGr3DaRK6PnsB7+EXzlGoRqd4QAcYVbwq
 mFZCtO5G0N3/pSuxLkVHmYeh0tuN3zWdb1UHbD/8shKZveRtY5nAOi36DIqS4fq6ruvMaY3ya
 bb4cO3fYPnUI/gQlfPA6c4sdTkLxfmm7nLO5Vprq3920h1jFG7t8W7wpEzOB3fxMx25DIs4dr
 h9VtweZHStOcKMQhX5MUpW6LCPHM8sWIiubV4vsKSB8d7TzM01jk0I9RyH3Hhg1gpO9UZFSQI
 7JCEUG8PjxbfttGNA3ZVURansxspTuIL/TisdTncVM80XHCyFENEdUhTc6Jt30jFxf102oMAr
 XZ+Bv2g2WJ2aYIrKxa8DZKO+QyVV9vFHx8DI1AM608ZVoPvDF/0atiVArT1j/+tAT06MSxKOu
 5hZ5CGkCC0Zn++2BdiC3yMWCTuGuAq/B3uM8HwUkGy670SLxo/BnJKCp2sKxLIy0836mEMGJ7
 PaoRkSWEafmXOAtSaO/t5d4+16opBwR2VHmxTr8lvtD7VWqvQ1d6gojl8tJbRCmqptdFFJQTQ
 xjiK7rXRK6SZAi06FmtUFWQaYW7VhUXBwnybRDUHcyQUOmEDxxk/rBNhAFb0MYG58KanH+frc
 4IpmMwFV2iv9KcfkRRAjqlEzIXlqJUxX31VUC91JvUZHcZd3gPgvV12qHEUqbHyGycgOJ+JOL
 pvh5s9lJVX/eDKPPi4mko7UWIVIg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 21 Mar 2023 22:33:06 +0100

The label =E2=80=9Cout_free=E2=80=9D was used to jump to another pointer c=
heck
despite of the detail in the implementation of the function
=E2=80=9Cparse_apply_sb_mount_options=E2=80=9D that it was determined alre=
ady
that a corresponding variable contained a null pointer.

* Thus use an additional label.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 7edfd85b1ffd ("ext4: Completely separate options parsing and sb set=
up")
Fixes: c069db76ed7b ("ext4: fix memory leak in parse_apply_sb_mount_option=
s()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext4/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e6d84c1e34a4..c0bc46956353 100644
=2D-- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2435,7 +2435,7 @@ static int parse_apply_sb_mount_options(struct super=
_block *sb,

 	fc =3D kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		goto free_mount_opts;

 	s_ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2467,10 +2467,9 @@ static int parse_apply_sb_mount_options(struct supe=
r_block *sb,
 	ret =3D 0;

 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
+	ext4_fc_free(fc);
+	kfree(fc);
+free_mount_opts:
 	kfree(s_mount_opts);
 	return ret;
 }
=2D-
2.40.0



Return-Path: <linux-ext4+bounces-4659-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F69A59D9
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 07:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16E51C21042
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 05:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C21940B1;
	Mon, 21 Oct 2024 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HPcn7zig"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196907462
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489521; cv=none; b=mw1iKbKNebDpGwbP4TI4hGIXOs05IOzU5dB/XqOBxY+i8Z0bR9K1dff3xMDotVYOJVCKXDGXn26ijnasL5qheeEDVkIKKq6bYsH/YOUAbMzffVzkwnZhuaJruJOkkaGBPztyxBesF7xwd1G3qzxyjof/HBazjUsgvHnc1RYQ2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489521; c=relaxed/simple;
	bh=Wg+nl8YU07IlaQ52PQM5HGMXMWcU0BJ+OlGaHdMHiwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=uC8iwMyHGMCMns/o01ynUvY+bdkuw/8Xs22FELkn9aLdz6OgUzlqnvzOwrX4mIowwUc08qCfBXiAt8QNKzp6EdZQ9C22s4Vy1OEZTulIMiVmMMB6XfYR3eOq78iMiy+pxXW2egZBLsUjGhG9nDlFOoHxK8v04g0rZIzhRrDNu0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HPcn7zig; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241021053734epoutp047634cd158ea12dd9f121079eb101f79f~AYSGt-Qb41135111351epoutp04t
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 05:37:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241021053734epoutp047634cd158ea12dd9f121079eb101f79f~AYSGt-Qb41135111351epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729489054;
	bh=QXU9gDyNBN4EWQQxJlqme6K6E2ZsVOSpEjVEcfHGv+k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HPcn7zigUCMwWMgagdlQ0G77JXeqS2AwZparSEnWXZ0pyVL+EUTFSUJ5hljzXSGPb
	 kKI+zKJHSmMbn3T8R2mhH4YL0g+8ay4GUZJbTypP2633zKlD652G4cNKTYXtsFcs1X
	 CMcGXVZSgmjzLk9kU6yJEYhI7tGH1fSXvXwCynlc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241021053733epcas5p37c2c9af50b2cede687d586e2a95608c8~AYSGMiS8l1549215492epcas5p3j;
	Mon, 21 Oct 2024 05:37:33 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XX3wr1n12z4x9Q8; Mon, 21 Oct
	2024 05:37:32 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.39.18935.A98E5176; Mon, 21 Oct 2024 14:37:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241021053619epcas5p1c1bc064fffd4d9c59ad125478f5b3fb7~AYRBOHSRW2436324363epcas5p1K;
	Mon, 21 Oct 2024 05:36:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241021053619epsmtrp2b6443b22dc74b7ca7398b1133045ef9c~AYRBNbHIW1925119251epsmtrp2a;
	Mon, 21 Oct 2024 05:36:19 +0000 (GMT)
X-AuditID: b6c32a50-a99ff700000049f7-04-6715e89aee56
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.8F.18937.358E5176; Mon, 21 Oct 2024 14:36:19 +0900 (KST)
Received: from dpss52-OptiPlex-9020.. (unknown [109.105.118.52]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241021053618epsmtip1975d1449100c5f7194fcf520736cc541~AYRAMZtH21815018150epsmtip1j;
	Mon, 21 Oct 2024 05:36:18 +0000 (GMT)
From: Jing Xia <j.xia@samsung.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, Jing Xia <j.xia@samsung.com>
Subject: [PATCH RESEND] ext4: Pass write-hint for buffered IO
Date: Mon, 21 Oct 2024 13:37:20 +0800
Message-Id: <20241021053720.546045-1-j.xia@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTS3fWC9F0gwUXlCy+fulgsbh5YCeT
	xc5la9ktPu5ZzWRx9P9bNouZ8+6wWZyd8IHVorXnJ7sDh0fL5nKPpjNHmT36tqxi9Pi8SS6A
	JSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
	ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
	dsa050dYC+ZwVFy7OYO1gfEzWxcjJ4eEgInE04m/WboYuTiEBPYwSjx7spodwvnEKNF18QAz
	SBWYc2N3WBcjB1jHz8uxEDU7GSX2b9nOBOF8ZZTYffshK0gDm4CSxJ1FZ8CaRQS0JV6uucQO
	YjML2EjcXviZBcQWFrCVeH99N1gNi4CqxOd1d5lAbF4Bc4nGGU8ZIc6Tl9h/8CwzRFxQ4uTM
	JywQc+QlmrfOZgZZLCFwil1i4tZGVogGF4np62exQ9jCEq+Ob4GypSQ+v9sL9XOxRPPU1ywQ
	zQ2MEg2nf0Fts5bYtn4dE8ibzAKaEut36UOEZSWmnlrHBLGYT6L39xMmiDivxI55MLa8xKO1
	M5ghISQq8XeVJETYQ+LR9HWMkECMldg3fzXbBEb5WUjemYXknVkIixcwMq9ilEotKM5NT002
	LTDUzUsth0dscn7uJkZwYtQK2MG4esNfvUOMTByMhxglOJiVRHiVSkTThXhTEiurUovy44tK
	c1KLDzGaAgN5IrOUaHI+MDXnlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTT
	x8TBKdXApHT1yp+m34oT5/QuEfgf+CG/pMCK8VPCLoHiBKutlx5+uWFVtHGf6j5Fp4JvkVUX
	8y5FVs8vPXbOxOhLsHWrnFAk00P7fM5GLwPR3YnzFkf/cdyyfe/O2AUZwvcrXP4eiDCd2nb+
	96Fzq/pFm3rqUwM3pyjbyO8UTDbqEkiab9ZfsebPS8nP8S6HZ25v+rrMtEXs0G+xdw5MW3bZ
	O2+ctdF/4RcbqcyL83p+r979I7SnQEtq5v0uXh5VSRlBs02H18tnexWwZDxtyXkVrtbAduO9
	9/SfO2vP7Jq+3zVTwU6GdaM/Z/+KgIcreLdXlLDrxv4r2qUnPH91Ze29ihh5bb1QubvFX1iZ
	p6T0/NuqxFKckWioxVxUnAgADyGL0RUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnG7wC9F0gxvfpCy+fulgsbh5YCeT
	xc5la9ktPu5ZzWRx9P9bNouZ8+6wWZyd8IHVorXnJ7sDh0fL5nKPpjNHmT36tqxi9Pi8SS6A
	JYrLJiU1J7MstUjfLoErY9rzI6wFczgqrt2cwdrA+Jmti5GDQ0LAROLn5dguRk4OIYHtjBKr
	9oSA2BICohJXzh5mg7CFJVb+e87excgFVPOZUeL4xA+MIAk2ASWJO4vOMIPMERHQlWid4w4S
	Zhawk5jceZYFxBYWsJV4f303M4jNIqAq8XndXSYQm1fAXKJxxlNGiPnyEvsPnmWGiAtKnJz5
	hAVijrxE89bZzBMY+WYhSc1CklrAyLSKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzgstYJ2
	MC5b/1fvECMTB+MhRgkOZiURXqUS0XQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJ
	JanZqakFqUUwWSYOTqkGJqWlCTvPK8aL6n8NKbwrr+s2wWaJw7YyMfZYb+lJUxLVvubpf65b
	8MboyMdLVycETJmjyaSWrCkgr5P92DSy+Gcir9fsINUwE9HqF1/Kd2uz3DC9K3W8t7Lq6+aZ
	Duv6PKcsjfWNvGLZW35SWCX0SvvqRG2GRZvTnXULj7yKnfgr3Hzjjxksm5i5dULUKiU/GQSv
	v153uFx6qsKWpk/7mTtUV36u7Z384PS+2cob3EIXvtGVfRK/Il2iaslsaQEW+Tv/DlS4vr1b
	J7Lu2ELO7AsXXor//pvg+HVKzfu5K98v/hb93Gnbfgn/g6+4dh+K+qZZI3tF38HevW6+gV3Q
	0pmfOU4y2sf12np28r/PVWIpzkg01GIuKk4EAHxqL326AgAA
X-CMS-MailID: 20241021053619epcas5p1c1bc064fffd4d9c59ad125478f5b3fb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241021053619epcas5p1c1bc064fffd4d9c59ad125478f5b3fb7
References: <CGME20241021053619epcas5p1c1bc064fffd4d9c59ad125478f5b3fb7@epcas5p1.samsung.com>

Commit 449813515d3e ("block, fs: Restore the per-bio/request data
lifetime fields") restored write-hint support in ext4. But that is
applicable only for direct IO. This patch supports passing
write-hint for buffered IO from ext4 file system to block layer
by filling bi_write_hint of struct bio in io_submit_add_bh().

Signed-off-by: Jing Xia <j.xia@samsung.com>
---
 fs/ext4/page-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index ad5543866d21..bb8b17c394d4 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -417,8 +417,10 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 submit_and_retry:
 		ext4_io_submit(io);
 	}
-	if (io->io_bio == NULL)
+	if (io->io_bio == NULL) {
 		io_submit_init_bio(io, bh);
+		io->io_bio->bi_write_hint = inode->i_write_hint;
+	}
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
-- 
2.34.1



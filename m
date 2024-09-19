Return-Path: <linux-ext4+bounces-4215-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B264097C2C2
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 04:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CCA1C2167E
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2024 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7E14A82;
	Thu, 19 Sep 2024 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rzW7CgXs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DB3C0B
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726711505; cv=none; b=l9MQntD4okTyfxVI8YOTcpg1myWr97do90O0Kpdz1aSKIRY0yUIa4g6mGcjEx2LBEa6PQao/fLKv9Wuav1gR1bM7a/iuomIo345EEk+HwOKavr4XCo/P2RaNX776cSQFMgNKtefwFzPZGZcw5c/WZ0nvSUhCvhzGB8Y+XwmPCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726711505; c=relaxed/simple;
	bh=mpMXhDcSAIDyO3ocxj3ssq+p3rvBWTOLZET63TT8CR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=OgJuQ6ZSeUy5xiExDuizmyk8YjGleDNjPC7+NTS5PTh1Kv94hD9EUND1GPDDadZVUmPiaFyH4bDXS8nZ3Xlkdai/fiI67/eVpvt72tuDhf07h4YicKvHaxaFQUkNCdC5YNivuDDy91iE4EX/eGqaNXuIdi8yF1FQAKdhxdZ57/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rzW7CgXs; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240919020453epoutp015146b20b97f038168e9023a14bf3c439~2gvSHMQ2b0182901829epoutp01c
	for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2024 02:04:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240919020453epoutp015146b20b97f038168e9023a14bf3c439~2gvSHMQ2b0182901829epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726711493;
	bh=aDgNHjfhZVmCnVL4luf8ciqUacOY+cI7rzICDXUhuAw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rzW7CgXske9z89swgfum+H+Yy0LHUllvB1kK7M8nrgXzicIzAPFcAPdkBLPBmO4xV
	 4FrIiCVOqrNAFDzrdZFlILJsJry9OjQPsMvJvRAdkupJK8xIDF4K25Rbp/ayy9sXu9
	 n1O8Ym8lSD46rT6wtxE5BEapl9rAn0u2KA/x4XJc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240919020453epcas5p37cd62098356ff63ba564da6d4ede56d5~2gvR2RvQE2844728447epcas5p34;
	Thu, 19 Sep 2024 02:04:53 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X8JkD3pwJz4x9Q1; Thu, 19 Sep
	2024 02:04:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C5.AB.08855.4C68BE66; Thu, 19 Sep 2024 11:04:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240919020429epcas5p3ebeff9323bcd95005ce70714bd18421a~2gu7DcVhN2159221592epcas5p3_;
	Thu, 19 Sep 2024 02:04:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240919020429epsmtrp2e9af58409c9e8b06d2ddb7645d4663ae~2gu7C00y71668916689epsmtrp2H;
	Thu, 19 Sep 2024 02:04:29 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-2a-66eb86c4229e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.A9.08964.DA68BE66; Thu, 19 Sep 2024 11:04:29 +0900 (KST)
Received: from dpss52-OptiPlex-9020.. (unknown [109.105.118.52]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240919020428epsmtip1b87575a43766e277f0b3943537496965~2gu6IqJnp1541015410epsmtip1w;
	Thu, 19 Sep 2024 02:04:28 +0000 (GMT)
From: "j.xia" <j.xia@samsung.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, "j.xia" <j.xia@samsung.com>
Subject: [PATCH] ext4: Pass write-hint for buffered IO
Date: Thu, 19 Sep 2024 10:03:41 +0800
Message-Id: <20240919020341.2657646-1-j.xia@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTU/dI2+s0gy/7pC2+fulgsbh5YCeT
	xc5la9ktPu5ZzWRx9P9bNouZ8+6wWZyd8IHVorXnJ7sDh0fL5nKPpjNHmT36tqxi9Pi8SS6A
	JSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
	ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
	dkbjouPMBTM5KmZdYW1g/MjWxcjJISFgIjFj7W/GLkYuDiGB3YwSX1buY4NwPjFK/Ph6mQnC
	+cYo0bLuMCNMy88FzcwQib2MEkeWbmWHcL4ySpx9PBesik1AUeLczD/sILaIgLbEyzWXwGxm
	AWuJX5u2s4DYwgJmEsd+rWYFsVkEVCXeL9jDDGLzClhI9B27zgSxTV5i/8GzUHFBiZMzn7BA
	zJGXaN46G+wKCYFT7BKzlvWzQDS4SOzZ8YwZwhaWeHV8CzuELSXx+d1eqK+LJZqnvmaBaG5g
	lGg4/QvqN2uJbevXAW3mANqgKbF+lz5EWFZi6ql1TBCL+SR6fz+BOo5XYse8J3CHPlo7gxmk
	VUJAVOLvKkmIsIfE5sO3wH4UEoiVODy3lXUCo/wsJO/MQvLOLITFCxiZVzFKphYU56anJpsW
	GOallsMjNjk/dxMjODFquexgvDH/n94hRiYOxkOMEhzMSiK84h9epgnxpiRWVqUW5ccXleak
	Fh9iNAWG8URmKdHkfGBqziuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+J
	g1OqgUn3/7KNCdZv7qQ8PX1b1PNLjUeQNk8fS+lLzTT+TeYcB+cXmUv+93jhYXT/ksZyhgMp
	WZfWc1l22rots51S/ec5u8fbSZObXmZsVZ7966KHlN/6z3Jf59767ne6yqksZ+W/j08aXh0J
	ODf5bOuK2DVXZ3jGlz6yfdnT+Kg3feHft/55x3+uudTr9WrFx+dTSl73P9oygbHyAus3xupb
	1SI/qpft1uQKWb3O/cvqksfCc1nqMiX1kldFRVnkmNz1fHd2/2Om3cKzhHO2MS+/MpHd8tC+
	uxqGBg4v1aN3PN3S96lj2e250lJ7V5U+2au/MWPLqcnuKyY+9J34Zs9G1Vy36lcTaz+pbivp
	ezrf6v1tOyWW4oxEQy3mouJEABfjtbwVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnO7attdpBjcbWCy+fulgsbh5YCeT
	xc5la9ktPu5ZzWRx9P9bNouZ8+6wWZyd8IHVorXnJ7sDh0fL5nKPpjNHmT36tqxi9Pi8SS6A
	JYrLJiU1J7MstUjfLoEro3HRceaCmRwVs66wNjB+ZOti5OSQEDCR+LmgmbmLkYtDSGA3o8Sl
	h//ZIRKiElfOHoYqEpZY+e85O0TRZ0aJq9++M4Ik2AQUJc7N/AOU4OAQEdCVaJ3jDhJmFrCV
	aNp6H6xEWMBM4tiv1awgNouAqsT7BXuYQWxeAQuJvmPXmSDmy0vsP3gWKi4ocXLmExaIOfIS
	zVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgANXS3MG4
	fdUHvUOMTByMhxglOJiVRHjFP7xME+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEk
	NTs1tSC1CCbLxMEp1cAUd3b/H7/ZdZk1gT4JHw+YLtjBxr3kYpu5zbvE9TevqvUf/nvYrGWF
	2gG+pElLl8xICUudd9hZ3sB/YrbGzbZjfTM0S7wYdxW+3q+UIr8zf2lw4gGmKax+2dp2c/+8
	/3369I2Ipm/MW04b67zkl41J3yv7L1B1wo7iva3TjsauDH3xrOldAseubLdbfRfMOTk7bPqP
	fFBfzTdht0nEf+sQ2XT/gOsFNkfW1Xf4f97Ewtt7PD28eU9a2qyA4rdOBtWLjqU7XO7iePfG
	gS/ubkrWwo/5fTPnLr5+eILCdJfQ4so1yavSv97KcFbYu2CmX/NjYbvftqsEem3PeKwXXvXb
	I3vzuSsTtZn6meb3i4kqsRRnJBpqMRcVJwIAy06Gi78CAAA=
X-CMS-MailID: 20240919020429epcas5p3ebeff9323bcd95005ce70714bd18421a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240919020429epcas5p3ebeff9323bcd95005ce70714bd18421a
References: <CGME20240919020429epcas5p3ebeff9323bcd95005ce70714bd18421a@epcas5p3.samsung.com>

Commit 449813515d3e ("block, fs: Restore the per-bio/request data
lifetime fields") restored write-hint support in ext4. But that is
applicable only for direct IO. This patch supports passing
write-hint for buffered IO from ext4 file system to block layer
by filling bi_write_hint of struct bio in io_submit_add_bh().

Signed-off-by: j.xia <j.xia@samsung.com>
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



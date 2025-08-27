Return-Path: <linux-ext4+bounces-9697-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C035BB38492
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C01684051
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192D35AAC1;
	Wed, 27 Aug 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="sh3b5UYX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191335A2AE
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303997; cv=none; b=dUqDcKmM41IDyUNFByoxYFxzOqV+l65F8/qkwVXJqYFxBn91/HbaIjlyVpNjBLk439xoDxFMYAo8kz91cmVDgywBYsMt3kItPlLa3BMM2K43myE2sEdbJ6hE5i693Axo6Vm4tWL3vSbZ/441Tz0uhMDML9SfXE2KFKNY+3SNKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303997; c=relaxed/simple;
	bh=4EuDcwVcgg4XYUbwMBGRKkF0194+qMOR8Fxoz5uvsPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8lJP4lm11RBngN+ITXg1z/KXNHJA51IBOANC5LphtM2+3V6kbPF7nVckhgfoLRZoGqjr83vIhCJRl0SYfOOMs0Vo/HlQpBLK8Ol/yFDihUAm7FgQwSYrOrAWkVvAqsy/hLjdY+Va7TY4fJGxIjGFZnoHUiKlrn/4emghRKm/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=sh3b5UYX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R7vwck1426096
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 07:13:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=A7mQgPp2sl5oTNiddVPCjxxlfAI/+hp6HiDsqOExGuM=; b=sh3b5UYXbRqg
	vB+bUFV+rda/OsKGndrDaLFknkCQ3aauQicBfSWWQPCjCDGqIXyj95LJeczT4UGF
	+jY7w+m2kbAC7E+f5nRtMVDkmyXTKEt5u2eqS4y01jKAdnDu9y/XtkOsNTWDyOoS
	iDJKPDSHdbxrn2uobUnpodpp99wIWjGXbBWsWRiOZRbym3R2N16eKdjwqSyd/jos
	1hvIS8ChVZ5XZ4l3pdY7kyKGCOHluN879gzER6NqtBPxfRYHkYWIfZtErx/s+q5h
	O+ABay6zdk9jP9eF1sv0PpFW6eHlyuPLQWc2BvTdMfjD84roU85Y51/YYrMg7+WB
	7nV+qjqLLA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sx3bhvgy-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 07:13:15 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:07 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CC92310CF623; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 5/8] iomap: simplify direct io validity check
Date: Wed, 27 Aug 2025 07:12:55 -0700
Message-ID: <20250827141258.63501-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827141258.63501-1-kbusch@meta.com>
References: <20250827141258.63501-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RxFz0XShowqSxCbNjwHHdWbLivcTCqd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX/t3v1ZqhXa//
 cpfsgqd2DNXgWXuvODvI4JoSt8YOTsH7076rKgHJtY2dazqSxKffkU/NewMIsyJO0LNc0jK+eHB
 e0N8CcCESl4Kz8GMLOOgsy09BpIIXIISH+MEfGtZPUI0prfNlInBildYxUy26RBCFzKh0m6UZTy
 in8RIZxzOWxXlF+0xhR8bPcEBWP8L3UZGltwDOsr2MvyCMXUp6FFkUlWDReWWPbxVyj6KFGi2eS
 fZ4hc9Nf8OjwjKf8KY9jWVDdUmqavMmySDuvOAuSWnVP0svpP5X/MI4E96SgtUL5V/3iG+3MaWw
 /NpYdWIodfY+OmpL4oTkQLqY0Uf1r2L7kyNGWVfBGnmjGXGvZLILB7jxVPOlgo=
X-Authority-Analysis: v=2.4 cv=B6u50PtM c=1 sm=1 tr=0 ts=68af127b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yYvhBQMpDZKDIMWT91YA:9
X-Proofpoint-ORIG-GUID: RxFz0XShowqSxCbNjwHHdWbLivcTCqd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
check, and defer the more invasive segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index fea23fa6a402f..c06e41fd4d0af 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -337,8 +337,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter=
, struct iomap_dio *dio)
 	u64 copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
=20
 	if (dio->flags & IOMAP_DIO_WRITE) {
--=20
2.47.3



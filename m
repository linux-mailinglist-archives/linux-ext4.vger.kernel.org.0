Return-Path: <linux-ext4+bounces-9702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E36B384A3
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17066851FB
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2535E4DE;
	Wed, 27 Aug 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aGeA7xjh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998DF35CEA6
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304005; cv=none; b=CxugUU4Ip0qVCMZy/InIRD2PdQMRw5ryx41Y13FCsl/cajC/UAtQizvrfgA4dHzLIx5YJEJ5m6yJ20lF+v7SY0owYElfmj+apfx38YXnvkQXL1euJOH7+uOvOZ2EcrGw+yHJGljL1mK3049l88kqSQxnOiHVcH7TSU1rwvXiojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304005; c=relaxed/simple;
	bh=ninOjM1MQ4tM9muoBz2+WRG73bpJGvheL2RNP5oKp2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRlBu8fue83nJgyTs09fcrSSmaoRnqL9DnT0TYo7xcbNmCW5kgN6+Mwp/wvchsO8WrlU/IqYt25ibEgSPzTtplmMReCXEwIwzjhiXg7NuCeEz/PXrnHkR8fUGY4H49PFwQ94DbniaViDyvmcqPBIbul24/wKeCZHATIHGyiw2E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aGeA7xjh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R9lsdn1665081
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 07:13:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=b49CrMrY1HUy4eAHENr0tp0XBojJ1jNrZOXvPvEc61s=; b=aGeA7xjh3nVq
	hMsUkEgcn23itFnFReq4jQqrwX/9QZuNOOKnWtB1jgV8rOBPKkMY3lwwTV5KLbmd
	bSNj1MuJFbo4QQpQhEWTlF/be7x/vO1AfTu0acWo7OT8KFh3S+DRRgaAwZn9QtxU
	bwFhim2ObYMk/44fzfcvcRlBS5S5HmsWk+RKYMDUvopHvpchAF79i//Fx6ihqOek
	TDQZ1J4ZkRIbokX+Pwjqrk9yeJ4gdeVB8hvSQM9LK7Nm+SZeWK9NHMSYBQ6LhG5a
	PKykMEjn9CDmbtYcIca9o+ty5QlPw5kl2Nx5VE1JGrIB2X+RJxf1XBGyQDkvkD+E
	QeycavkEHw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48sypx9cjr-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 07:13:21 -0700 (PDT)
Received: from twshared7571.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E18E210CF627; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 6/8] block: remove bdev_iter_is_aligned
Date: Wed, 27 Aug 2025 07:12:56 -0700
Message-ID: <20250827141258.63501-7-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=V9F90fni c=1 sm=1 tr=0 ts=68af1281 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=xM7hJ6YyiNa3_SwsFokA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX3xxSCOuUkLPy
 fiPfsgaR+HaeeTLIuF4RXjDJqY9p+xNHgsv+JJds+QVHpw60kZ6IOmc2ZT0jkOsRdvVfnvp1JPc
 pLlBcOhaZRBKgOiYjyF1LN78lWdSZb+rFG72RFLpIN06VWnSeS0IURUoxBxaMfhugj0cTG5S0al
 /wJvar1UkGcPP9MNIg/GnGswG32aGlx2Kf8vxrPJGuLVCancMquyC6vnALYtC/HqDTO55OI4rLr
 UnAyjBMMIybkplN7GsTi1i+zhAjb1aqWZGqONWdqJUKwludWBuxOIOv4I+78up2CUgHPKx+ZU6b
 YeC+Wgp2wf7fA7cn8oBJhaa8yWVh4f9a3C42YVCM5a7JAlga/8MDLbCUzCToSI=
X-Proofpoint-GUID: AHx2np047yCMEE7TsdrZJKDphKknR2pv
X-Proofpoint-ORIG-GUID: AHx2np047yCMEE7TsdrZJKDphKknR2pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 36500d576d7e9..221f6d7c0beb1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1590,13 +1590,6 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
-static inline bool bdev_iter_is_aligned(struct block_device *bdev,
-					struct iov_iter *iter)
-{
-	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
-				   bdev_logical_block_size(bdev) - 1);
-}
-
 static inline unsigned int
 blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
--=20
2.47.3



Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007E1196F7F
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgC2Swy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Mar 2020 14:52:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54423 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2Swy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Mar 2020 14:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585507974; x=1617043974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=giL3znufZBqTUKEmS0Eqej/2qqCEotn0u9ShJNUdiKo=;
  b=CXxX+IoxdT7bbsBydypKgKxp9VDWK9lMd5vd06sD/SAKqe2KK2CMG6P6
   MHDFq9hRBVAhW59FoucpebXbM3dciUoPZ5hFucc1yknMu8TdFom40JklC
   FU6EcBNDlzkgDwiOiTgf8HdAu1b4sDI7NUyGc8xNqxaUjmn2cQAWjcG6g
   jBhK7rJ14MKMtRQiRlY5qAakavqJF7XEaIpCkEcSjuOac9jMzgvnol7bM
   PPUWxZ54JffRg/Ddym0pfSnq1rVsCT6HyTdGz53kfQXtNCGR2LGwaoenP
   ugXYGzcEF+rWlcUkwojEuv6uXSF7t7utErC0FfFvBHXsP/HtAD2vLmudZ
   g==;
IronPort-SDR: SEoHohdhqXBXxVy8CfBziBQ7A7pFmrFSo59Mpy3Vs+RSh2EAxl3lAsiZs/4v+f2yBHmcP7c2EG
 LYocYX8awmNG+pbunHCow+lTrTUuY+bsfKyN6Yiy3R+sxpuy/aaYIQ6+def3wz+f98bZGIZ5hH
 ilDzHrm0tsWIjnCjmivgpwoVBM7FMUpA98M5MBbWrgdX+FzEnR2MkF4HyFnZfPIcVu3tkyW5w2
 SNCq8roQrpVlPz/x+Re75ruThMqXM30IpOK2i3RFSP0AyEUF/6PNMO2BUdmN1M7fAKla4u6gfh
 TaE=
X-IronPort-AV: E=Sophos;i="5.72,321,1580745600"; 
   d="scan'208";a="138193358"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 02:52:54 +0800
IronPort-SDR: zxj4y/korKgzGLbaRlxNPQheQhNuRDOPzZPLffiYGMck4aEeIKnMgr+sMs5ljCe6IaYxIxNt8e
 AjpeUSK0CW15zYHfsV8dbeq5tkbdZSXXiJd/NwzkyO3rgEZsWizpKM5ueFUcE2L/sFhMXLgqVT
 LtPl9AFYxyW9YFXyz1ljbvtMRiG+FUFWEhdCr4XE0YgvYF4TyE6phStvdY+9/zGZ6bTN4mnGyM
 j7nQk0zNxe9sm8kSJrCNGbtlHJRmwle/fjRSt1sL44ijNNcOaiH2r0/icRSyXlpGitV1anwOKY
 MY2+WrNtO+m5uUMaQCF7a4TU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 11:44:24 -0700
IronPort-SDR: W/geha5KtR/mm/WfmoZHzdBGNSU3ao4X3r+S+RWZREsiyPyYEhfeb7k8HNFSBLUlRt0J/c4j3F
 ogpaf10WysKwUJ51/naEJHBUAbz8dAiP/EZaSVHYJuc0Sri7jhdn/cWdzI5WyQOcjB9HTZBrWH
 dAcrTP1ma8G8FGTaEWhxyCT3UtHc8VO3oqLUCSs/oVJwYzdFkm8Ucyb20IzMjx+cPGBamcPBUJ
 4Z1s0dSMSInnEsYAk18Lgh3Mzhnn8J3kNF0OOg0XyM1+dl8Jg6j/sGHB5jjsyy93wm4TXoSTm0
 Bfg=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 11:52:53 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH 3/4] loop: Forward REQ_OP_ASSIGN_RANGE into fallocate(0)
Date:   Sun, 29 Mar 2020 10:47:13 -0700
Message-Id: <20200329174714.32416-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

From: Kirill Tkhai <ktkhai@virtuozzo.com>

Send fallocate(0) request into underlining filesystem after upper
filesystem sent REQ_OP_ASSIGN_RANGE request to block device.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
[Use blk_queue_max_assign_range_sectors() from newly updated previous
 patch.]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..0a28db66c485 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -609,6 +609,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_ASSIGN_RANGE:
+		return lo_fallocate(lo, rq, pos, 0);
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
@@ -876,6 +878,7 @@ static void loop_config_discard(struct loop_device *lo)
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_max_assign_range_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 		return;
@@ -886,6 +889,7 @@ static void loop_config_discard(struct loop_device *lo)
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
 	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	blk_queue_max_assign_range_sectors(q, UINT_MAX >> 9);
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 
@@ -1917,6 +1921,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.22.0


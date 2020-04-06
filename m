Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FF11A01AF
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFX1j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 19:27:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37884 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFX1j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 19:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586215659; x=1617751659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/tzLAnfDjCCdTrNnhnVObOCHHyxEUgiRXtXZmfilZqc=;
  b=UOrSUdQ0C8x0TmLG1res2bIPa2GpJl4KCDfMFDl7CEK00IfHMJ43elhC
   A5t91bz+HvLNgRjitVEaxtWh+wLRvlManhaeAg82v0kx2PKJ/3d0I4t6V
   TSUX3YBaDn6OyTp4cBEDAbCKvQ6R2wVd8RVSPhiailgMcFoVIZeIzKwnR
   ztVAG3QEKVpSMKw6YV2WvLUWfeTo++KkwEQ24rbFAqZwIxOmmrIpBGlh1
   FbBatzcLA31DyLESuwTk6Z27IcYzrPLIkM8mUIgwfLUIEyBbagIf4jc0E
   wr9G+0sfTrbA4258ry/eJHpkUeNXUi82Spl2PJCaBtERwQBf7CrW8Q0fb
   Q==;
IronPort-SDR: FzC7VD2UkN5AosxIMip//lFgauLCG2eS3r0+xTVwuS3ZHnjfXLpyWtSrTKjANoRjIKh6d9xB9a
 GmKMcG4f4p6pYstixXgsaMRUeYI1TZQdOfK53peRMv/yL+SMxr4gx28qBqJcoE3RSPuetR1uZM
 evECsKWavSMq7w9yEE1CByysO4SqMCqwumTYkdqzwzXfaUtrSE447l66M8wqKt6NWU7iDyHfTc
 ECqFCR8LzKOqDUW3Wk2DsjAg4iaqvAJh7skEmCFqFIXSeJ/JP++lJ5NQ/wnne6V4zkTycWj227
 b7M=
X-IronPort-AV: E=Sophos;i="5.72,352,1580745600"; 
   d="scan'208";a="135040152"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2020 07:27:39 +0800
IronPort-SDR: aop2K1en6ieU0gcjcWDI98YnMoMijy83n71vwoGtQQxdCKMvb9bAjMXwCa588F1E35Bqw1fjYv
 cCWM0TKjBmXoB4HyfSBBh//uxdWggQgRdV3g4CuHQ4E2GuvSCJQEYx5OcPlPmLf0CvPIb7i3IT
 9CsJoFNSaBEDBkHnndKLnhA2eQT9Dd/BRKE65axeky214VQwfE3Wttd32x77EHY3JigswBFzDd
 DpaAI93x/I/+/pr0KmmprGeKsEoW6aXJgVU8bwGpOUiz+D+vwJeoNARo5WVbq6ea1yJmrc44NP
 BssiFrgo+iNdH5bO5As9obF8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 16:18:55 -0700
IronPort-SDR: 0LnIfTB40kdM0K899Czty+Ge6S6R4zVgKtCmEDlJ7mnGMXdubIZ/OlByjeTlfLGxF321RpowG6
 9DA99FbG97TdWC7LlSx2McQsN+G8yFIZaARMfqbX8SyovxkYFGUDUdSiRYILZfVddhSa7A1X2C
 9LrKxDpa4WpmiPy+E3/ZtkLmmUS+p4Ll2Z38vj6v3q2FH2mW05fGuNI9uyLpXPao4yhA9hDs0R
 ths8VmK25Kwp4ntyuhGk6JWRO41XQsgSJvCVcKXwOqpm2k4jVTZtsLZAIACrFbIOnMkFPTjpxC
 rNA=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Apr 2020 16:27:39 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        ktkhai@virtuozzo.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH V2 3/4] loop: Forward REQ_OP_ALLOCATE into fallocate(0)
Date:   Mon,  6 Apr 2020 15:21:47 -0700
Message-Id: <20200406222148.28365-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
References: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

Send fallocate(0) request into underlining filesystem after upper
filesystem sent REQ_OP_ALLOCATE request to block device.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
[Use blk_queue_max_allocate_sectors() from newly updated previous
 patch.]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a42c49e04954..26ff16e34f5a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -611,6 +611,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_ALLOCATE:
+		return lo_fallocate(lo, rq, pos, 0);
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
@@ -878,6 +880,7 @@ static void loop_config_discard(struct loop_device *lo)
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_max_allocate_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 		return;
@@ -888,6 +891,7 @@ static void loop_config_discard(struct loop_device *lo)
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
 	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	blk_queue_max_allocate_sectors(q, UINT_MAX >> 9);
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 
@@ -1919,6 +1923,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ALLOCATE:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.22.0


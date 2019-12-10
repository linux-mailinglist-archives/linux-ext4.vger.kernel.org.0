Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FF118E54
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfLJQ5G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Dec 2019 11:57:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:36454 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfLJQ5F (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Dec 2019 11:57:05 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ieio2-0006yu-9G; Tue, 10 Dec 2019 19:56:14 +0300
Subject: [PATCH RFC 2/3] loop: Forward REQ_OP_ASSIGN_RANGE into fallocate(0)
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        ktkhai@virtuozzo.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, ajay.joshi@wdc.com, sagi@grimberg.me,
        dsterba@suse.com, chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Date:   Tue, 10 Dec 2019 19:56:13 +0300
Message-ID: <157599697369.12112.10138136904533871162.stgit@localhost.localdomain>
In-Reply-To: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Send fallocate(0) request into underlining filesystem
after upper filesystem sent REQ_OP_ASSIGN_RANGE request
to block device.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/block/loop.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..d99d9193de7a 100644
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
@@ -875,6 +877,7 @@ static void loop_config_discard(struct loop_device *lo)
 	    lo->lo_encrypt_key_size) {
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
+		q->limits.max_assign_range_sectors = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
@@ -883,6 +886,7 @@ static void loop_config_discard(struct loop_device *lo)
 
 	q->limits.discard_granularity = inode->i_sb->s_blocksize;
 	q->limits.discard_alignment = 0;
+	q->limits.max_assign_range_sectors = UINT_MAX >> 9;
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
 	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
@@ -1917,6 +1921,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 		cmd->use_aio = false;
 		break;
 	default:



Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B615B9FE6
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIOQtA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiIOQs5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 12:48:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440B7C1D7
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 09:48:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a80so10058483pfa.4
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8dGdE7yXwxpNJrtc0jzeOng2rxu8z4FK39IlQ5rLaw4=;
        b=EbErGLA/VINLfRbp4zcUbZBx85wcqmWWZ+b0wvu85Q2UUUeZQBQzI+ibcnOvQrL1/1
         SpTBeWGXbbH7aJQQssASqOwJ392q4ULOBRqDM6uMUsq9W98Jxjsk1XvASOhF/X7whgnI
         cQc9io4mtSftKYU7SXF5cXqbt8EGpd2/X9S3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8dGdE7yXwxpNJrtc0jzeOng2rxu8z4FK39IlQ5rLaw4=;
        b=oPQFYqsu4AsbBvQxqseHATNjhkpX2ft9xIylL+mCQHwKno/F9YNY8AQHSvUzwR4F0D
         8Cn9s6Cvo6tp2JWeh3BJLrcgeuD0+vMZw3U/qPjjbCvzdVdI84SMajfZNQCSeqL9CLLn
         4/VkPS+P5n0v3l6r0+yWexu+nVypT2sdcQvNtqQUs4ZwKMc44SaOnKXRE5h7gP3Hj/fQ
         6Tscxr2V0p5QJHO+Fd6pGKhKdY5hrfjQefuT2LuDFhV2wfHpvD/bmRdBdfrg9GrIbNZS
         dpyvsw6cFOU5Ju376LDYm/UhGaUDP3ZhrUpe42j+rKHu4Si7pOicymC+XcI01GQxLWmy
         hS1A==
X-Gm-Message-State: ACrzQf3KOgNjL1Pjz/kh/SyoXND/0pXIZezkLOIolT+VY0YsimM3lHbj
        os3AdPo/94y7BeQ0ycFVn6Bxrw==
X-Google-Smtp-Source: AMsMyM4ZjbUOIq/Q41w/OvvKUkmXpRr0bP+C56mI+0JSOF5eLhseKC9OgxfT03jMUgCb5sBQJ9O12g==
X-Received: by 2002:a63:1d25:0:b0:437:ec38:bd0e with SMTP id d37-20020a631d25000000b00437ec38bd0emr675973pgd.478.1663260525220;
        Thu, 15 Sep 2022 09:48:45 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:44 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 3/8] virtio_blk: Add support for provision requests
Date:   Thu, 15 Sep 2022 09:48:21 -0700
Message-Id: <20220915164826.1396245-4-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Adds support for provision requests. Provision requests act like
the inverse of discards.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/block/virtio_blk.c      | 48 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_blk.h |  9 +++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..eacc2bffe1d1 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -178,6 +178,39 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 	return 0;
 }
 
+static int virtblk_setup_provision(struct request *req)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+	unsigned short n = 0;
+
+	struct virtio_blk_discard_write_zeroes *range;
+	struct bio *bio;
+	u32 flags = 0;
+
+	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
+	if (!range)
+		return -ENOMEM;
+
+	__rq_for_each_bio(bio, req) {
+		u64 sector = bio->bi_iter.bi_sector;
+		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+
+		range[n].flags = cpu_to_le32(flags);
+		range[n].num_sectors = cpu_to_le32(num_sectors);
+		range[n].sector = cpu_to_le64(sector);
+		n++;
+	}
+
+	WARN_ON_ONCE(n != segments);
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * segments;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	return 0;
+}
+
 static void virtblk_unmap_data(struct request *req, struct virtblk_req *vbr)
 {
 	if (blk_rq_nr_phys_segments(req))
@@ -243,6 +276,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	case REQ_OP_DRV_IN:
 		type = VIRTIO_BLK_T_GET_ID;
 		break;
+	case REQ_OP_PROVISION:
+		type = VIRTIO_BLK_T_PROVISION;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
@@ -256,6 +292,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 			return BLK_STS_RESOURCE;
 	}
 
+	if (type == VIRTIO_BLK_T_PROVISION) {
+		if (virtblk_setup_provision(req))
+			return BLK_STS_RESOURCE;
+	}
+
 	return 0;
 }
 
@@ -1075,6 +1116,12 @@ static int virtblk_probe(struct virtio_device *vdev)
 		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_PROVISION)) {
+		virtio_cread(vdev, struct virtio_blk_config,
+			     max_provision_sectors, &v);
+		q->limits.max_provision_sectors = v ? v : UINT_MAX;
+	}
+
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
@@ -1177,6 +1224,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
+	VIRTIO_BLK_F_PROVISION,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index d888f013d9ff..184f8cf6d185 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -40,6 +40,7 @@
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
 #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
+#define VIRTIO_BLK_F_PROVISION	15	/* provision is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -120,6 +121,11 @@ struct virtio_blk_config {
 	 */
 	__u8 write_zeroes_may_unmap;
 
+	/*
+	 * The maximum number of sectors in a provision request.
+	 */
+	__virtio32 max_provision_sectors;
+
 	__u8 unused1[3];
 } __attribute__((packed));
 
@@ -155,6 +161,9 @@ struct virtio_blk_config {
 /* Write zeroes command */
 #define VIRTIO_BLK_T_WRITE_ZEROES	13
 
+/* Provision command */
+#define VIRTIO_BLK_T_PROVISION	14
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
-- 
2.31.0


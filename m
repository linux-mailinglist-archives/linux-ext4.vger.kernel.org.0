Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7387F5B9FE8
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIOQtC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 12:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIOQs6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 12:48:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3994EE2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 09:48:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 9so7538964pfz.12
        for <linux-ext4@vger.kernel.org>; Thu, 15 Sep 2022 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8C9PF5fV/n/yVA3OaBrI0F0iBecyk+zvR56xPQZ3IDQ=;
        b=j9UNt0PdafuY8eG1vCRzjZeZim0lhfvAaWOmUVbnBHmUWqdPZZ3auOQ0xlsq4Yg25G
         ssysjc8iJfcpwF872sxTnDKV+At5Lq1lz2NHw7y/c/HRgBxSyb3/AQ8kCSa9CzRaimvX
         fDowBy/9vfz+mH7HubnE6gAWlEVC/vOtMbAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8C9PF5fV/n/yVA3OaBrI0F0iBecyk+zvR56xPQZ3IDQ=;
        b=QhW+1xAZZ1leWyV+LkMMunLnc3rURjJUmTjuE6yBBW3LRe5QC7Yc+G3snlgOfROBbx
         g339EqUQ2f98BDUW1GcXO5IDGUhQsyL4KZnaOesiaf3VM6EEMOUIp/cpeEYveigLoKt9
         eM6xdKS6N5aoO58/L98iYiD0f0N7Ys5t29jeE74oiKp+dhgxeo5eRio59hvMCHEqeDVK
         WkFJaTsnT0n5u9BeDCy5cOh46nC8UGSYQWd74/9FhjW10I1F0AgYpjw9im0DkL6f0VPs
         12BmlA8/+jo9PksjE5wwZRpvNXWkrzNVuZLHfHA4W+EuJcXygmiMIy/zaHVNR9gJ2LbM
         3X7Q==
X-Gm-Message-State: ACrzQf2A1KP8wC/HuFwvycUrSZEyk98+fpdCY1sQV0prl0XDOVVQ58SZ
        DAXCt4G8GMAjbpcOQw7suBJr3g==
X-Google-Smtp-Source: AMsMyM74NUJEGoCBWxXp6ovjj8HVrZVtuoYCAa5cO2wk9AivcidhyvEFeO548cRZFdt3fQKWpEtWLA==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id k17-20020a056a00169100b0053b3f2c3257mr882622pfc.21.1663260527748;
        Thu, 15 Sep 2022 09:48:47 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:46 -0700 (PDT)
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
Subject: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Date:   Thu, 15 Sep 2022 09:48:22 -0700
Message-Id: <20220915164826.1396245-5-sarthakkukreti@google.com>
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

FALLOC_FL_PROVISION is a new fallocate() allocation mode that
sends a hint to (supported) thinly provisioned block devices to
allocate space for the given range of sectors via REQ_OP_PROVISION.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c                | 7 ++++++-
 include/linux/falloc.h      | 3 ++-
 include/uapi/linux/falloc.h | 8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index b90742595317..a436a7596508 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -605,7 +605,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |	\
+		 FALLOC_FL_PROVISION)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -661,6 +662,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
+	case FALLOC_FL_PROVISION:
+		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
+					       len >> SECTOR_SHIFT, GFP_KERNEL);
+		break;
 	default:
 		error = -EOPNOTSUPP;
 	}
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index f3f0b97b1675..a0e506255b20 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -30,7 +30,8 @@ struct space_resv {
 					 FALLOC_FL_COLLAPSE_RANGE |	\
 					 FALLOC_FL_ZERO_RANGE |		\
 					 FALLOC_FL_INSERT_RANGE |	\
-					 FALLOC_FL_UNSHARE_RANGE)
+					 FALLOC_FL_UNSHARE_RANGE |                          \
+					 FALLOC_FL_PROVISION)
 
 /* on ia32 l_start is on a 32-bit boundary */
 #if defined(CONFIG_X86_64)
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 51398fa57f6c..2d323d113eed 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -77,4 +77,12 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
+ * blocks for the range/EOF.
+ *
+ * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
+ */
+#define FALLOC_FL_PROVISION		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
-- 
2.31.0


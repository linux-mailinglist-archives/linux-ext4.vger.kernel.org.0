Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152AD6D6665
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjDDO5f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjDDO4u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6A49D4
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
        b=f9rMXOWxDNdUIdaQPJxskMpRHn4rHA4effDRVSxw5JqaJsTzZeh8LcunplFQYKjeULRSn6
        8Zl3oVGyx7+D+Y9U1bnE+OB0z7n85uKG6W9oSJjfHEJDNjQ4UuNTcZsLY/6RoBwAbqXcHG
        1lODMnl891BqZYpkGIjHJ7otVvEmXRQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-8RJGVCp9OpaVLqBuCaf-TQ-1; Tue, 04 Apr 2023 10:55:57 -0400
X-MC-Unique: 8RJGVCp9OpaVLqBuCaf-TQ-1
Received: by mail-qt1-f197.google.com with SMTP id m7-20020a05622a118700b003e4e203bc30so19945965qtk.7
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wyXRFn15U7YuTtccu17S72kQxdrsvbnQJV5citpTBw=;
        b=FQTZnZj5TUxF6q2ZA+83GVLTMEKdfYhq0F2kCYkhRx6NkEHI/ILe0o4yTDPeAxpG2H
         DCGVHm43bbblWVTZehgYYT+r/0kxDcdTaIHu1E8CKIKZbvIlzAmVNQ1UJWcABOUy7GzY
         Du8cFC0Br/jowrx4o4Ri5YSHF3qZA7AfLcHrRFXVTEDBrV9r5OyqChB1NN+PQRxpp/mq
         g+C51Gj1WlCbWaOdUevxtdiwRLz/Rh98GUtAg6ATjES1Puk/jvSHem6cEAcBAqJ9M1ba
         4P+/6Oj6rDOBuribd5QutuEWhuh1uFnjAHwLSCqU8aLvK1PIYC4skZSxkspIQ+2MapIi
         EG/g==
X-Gm-Message-State: AAQBX9eu70OOUX33p213YI3rUZ8/wbMqPu9K3i7LtysuFc3X9APIFQoz
        egqI7CG6ut04wBr4iGi1z/QpNXSkMKtv6xoReoRSNqCpBSvFA4XqdUTIS1sX1/Z6ECakNy4/Od8
        YWi8iNcJCU94s+dN0Eyxg
X-Received: by 2002:a05:6214:202b:b0:57e:67c2:b9cd with SMTP id 11-20020a056214202b00b0057e67c2b9cdmr4447874qvf.27.1680620156127;
        Tue, 04 Apr 2023 07:55:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJb0tNOFsr5rCdSnciXn4UvwnouNwwbFSTjZxZAVItCMscXXWD/V0CsYzmlqPKXH2vmnAZgg==
X-Received: by 2002:a05:6214:202b:b0:57e:67c2:b9cd with SMTP id 11-20020a056214202b00b0057e67c2b9cdmr4447836qvf.27.1680620155884;
        Tue, 04 Apr 2023 07:55:55 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:55 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 22/23] xfs: add fs-verity ioctls
Date:   Tue,  4 Apr 2023 16:53:18 +0200
Message-Id: <20230404145319.2057051-23-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_ioctl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3d6d680b6cf3..ffa04f0aed4a 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -42,6 +42,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2154,6 +2155,22 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.38.4


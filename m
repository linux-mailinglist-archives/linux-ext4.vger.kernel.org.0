Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6AD6D6669
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjDDO5i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjDDO4x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 10:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC644ED6
        for <linux-ext4@vger.kernel.org>; Tue,  4 Apr 2023 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6TxF2wDPSZ8VkfH+UnP0K94pMIAUpQJ5kpEzKyPwfU=;
        b=EHFKVi5xXoNkzn/oiLx6xtGQnH+etGnzzIE/zp2JgixTtNZCv39ZbDlZ4Hv0qiJrm4M+0u
        0pzi4TPBDSiFm6e0Vb0VME2fPTpfw9EWI6ZVmHSRoQjT5Zja1R4syu+R/h4irAXsNOJCPh
        M4jQwAg2uw8HkeuUJMRqpZSVg3wZLgs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Ck31GpYwMtSndIviYp-O6A-1; Tue, 04 Apr 2023 10:56:00 -0400
X-MC-Unique: Ck31GpYwMtSndIviYp-O6A-1
Received: by mail-qv1-f69.google.com with SMTP id dg8-20020a056214084800b005acc280bf19so14726319qvb.22
        for <linux-ext4@vger.kernel.org>; Tue, 04 Apr 2023 07:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6TxF2wDPSZ8VkfH+UnP0K94pMIAUpQJ5kpEzKyPwfU=;
        b=BGE/hjBbrOOi4FTtGVfmsXgJs3RvWh/rKK5KmHkoe+IebRV3mdMFvl04+vaLHfKzxM
         IKxdPMK4UgW1FlAIp5YclQa0w9m//9dKidsfjelcypce8iInyVmRvCoOAnbRTT7wF9WR
         N/qsn3sa/17gYaQPoS8YzT7MoBvv77og0cZZ5nzeWMgLhejSPBZBb9klMJs1ktxrrSma
         RsprHfYvds2vBYqFoAMCf99wNcqDkln4j7y7S/G0+jH7nhiHJDhsxWnn9XS/nrnAeQSk
         UYP/5OSRDMoHUoHRDRxU+nbtatBXqUO161izYEe/8jvtZqFfJ5vcmVoHMRwSIw8pri/x
         Yinw==
X-Gm-Message-State: AAQBX9dYUaqLiG3ARcsEXzFzh2/gaMGs1oVZtNib6JU3eyUBYFt0dIZS
        snIUTupx5tsqKp6JJg5m1Ud9HijfwD2NDotkEAD6ueGmjnbCz4sRLPhiDgh332Tl4hDPXyGDVRS
        wKXUEm7MeSAyFCqWzcTou
X-Received: by 2002:ac8:5b8f:0:b0:3e3:9502:8dfc with SMTP id a15-20020ac85b8f000000b003e395028dfcmr4467469qta.9.1680620159966;
        Tue, 04 Apr 2023 07:55:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350a7eyzBLFAVwLtkZzZp5jojS6UQc2rD1+xfGSjK6d6WcBELJ7jmQgpE+gezZ7mdNPw1AFtdEg==
X-Received: by 2002:ac8:5b8f:0:b0:3e3:9502:8dfc with SMTP id a15-20020ac85b8f000000b003e395028dfcmr4467424qta.9.1680620159602;
        Tue, 04 Apr 2023 07:55:59 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:59 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 23/23] xfs: enable ro-compat fs-verity flag
Date:   Tue,  4 Apr 2023 16:53:19 +0200
Message-Id: <20230404145319.2057051-24-aalbersh@redhat.com>
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

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_format.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index ccb2ae5c2c93..a21612319765 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -355,10 +355,11 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
 #define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
-		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
-		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		(XFS_SB_FEAT_RO_COMPAT_FINOBT  | \
+		 XFS_SB_FEAT_RO_COMPAT_RMAPBT  | \
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT| \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.38.4


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255CB5101C8
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Apr 2022 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbiDZPZE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Apr 2022 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345302AbiDZPZD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Apr 2022 11:25:03 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693A65D0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Apr 2022 08:21:56 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e9027efe6aso12399442fac.10
        for <linux-ext4@vger.kernel.org>; Tue, 26 Apr 2022 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlydFFbtuvEUyExH2Zgk+EX4f4C7HNRLoshbb/lU9+E=;
        b=Me00n4XTkzexCVNraS2+HsT6sbagBaFALSed/H0VQZwq4DD+AYP/NfAcW+IeEpLqYW
         V6HscpV/+0sAR57Xr6bNz55SOLP38u8NCTKV8M4BBN5Pi6zGw78NFdw+UgyvqdJ4mcnp
         EVbM6EOMQgdbfK+qaMnE0myaVBRr/P6PbD2y1ssC8tDI6yMLslNttsUwv3pdoo4ns+G7
         pZqTlYAQOWvso/B2Gf1+k8SvaWF+mqnO5ChEjYRTG1d5TMGqyksAxlJVdoD6J94+kVr5
         Fd/ZVSvXv/57bw13hkdnAD2DCx+wrb/p+Xg/F4clyn4+jHdh10CrkBI77Dxe6wc0Tq4I
         qhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlydFFbtuvEUyExH2Zgk+EX4f4C7HNRLoshbb/lU9+E=;
        b=c88je0HPelWpLjkZzKQ8eR+5nz4xn2ewarB7vlJuSTjEXTlMiFxJq9d9YJ0H260UtA
         Lq44LgQcmDCMDcFHZKgSgpF4z/OU0BQ8gei+KD4PXY1+6WlPCyd0sXkBNWSpgrnA3khe
         IYu1fke2kksw1TwGFiDDWNoua3q202EnLjDokrtm2mdk/X3cFfVCwIlPDocF9U1lFPtW
         rQgA1Ag1EhzeH5k0oxROR6Hd+FSaQWPZIWPMXXKyBoIbbI1BkbG2k8xp0aroKvmwCZ5O
         CgnZ2pXMK8s3xwN+4THV8WQxzDbPcQzkxwctRbEJ0jn9Dn2rqosqbHQoqZcAOoPuGO68
         D5qw==
X-Gm-Message-State: AOAM531b19ay/V9dNOEM1G6m6ukjjzWZ+MiTEKXWm08iMsjugSVb4/lh
        h0BVy17jfUHUu1wr04rOT0UW4wCEI+wjPZpLu/A=
X-Google-Smtp-Source: ABdhPJw67xReTAU4AwUuY7HCGguDtve8pCmnmDVW4M5Md6PrglQHeY2lBGqoqk2tr42lGWwb/5VliQ==
X-Received: by 2002:a05:6870:b427:b0:d3:5044:db1b with SMTP id x39-20020a056870b42700b000d35044db1bmr13130563oap.2.1650986515099;
        Tue, 26 Apr 2022 08:21:55 -0700 (PDT)
Received: from daa0ed34aef8.hpecorp.net ([83.234.50.195])
        by smtp.gmail.com with ESMTPSA id e26-20020a056820061a00b0035e46250f56sm4996872oow.13.2022.04.26.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:21:54 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Subject: [RFC] LUS-10810 e2fsck: use bitmaps for in-use block map
Date:   Sat, 23 Apr 2022 01:42:16 +0000
Message-Id: <20220423014216.34032-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Artem Blagodarenko <artem.blagodarenko@hpe.com>

EXT2FS_BMAP64_RBTREE is too expensive for fragmented prtition,
that can lead to situation than e2fsck use swapfile.

This patch change EXT2FS_BMAP64_RBTREE to bimap.

Marked as RFC because it must be descussed whether this flags
should be changed by default or some additional option or
a heuristic is needed to contol this flags.

signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>

Change-Id: I6a906b5e54cf40eaba82624d8e4c2b0f90132813
---
 e2fsck/pass1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 26b9ab71..563dcdc5 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1247,7 +1247,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		return;
 	}
 	pctx.errcode = e2fsck_allocate_subcluster_bitmap(fs,
-			_("in-use block map"), EXT2FS_BMAP64_RBTREE,
+			_("in-use block map"), EXT2FS_BMAP64_BITARRAY,
 			"block_found_map", &ctx->block_found_map);
 	if (pctx.errcode) {
 		pctx.num = 1;
@@ -1256,7 +1256,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		return;
 	}
 	pctx.errcode = e2fsck_allocate_block_bitmap(fs,
-			_("metadata block map"), EXT2FS_BMAP64_RBTREE,
+			_("metadata block map"), EXT2FS_BMAP64_BITARRAY,
 			"block_metadata_map", &ctx->block_metadata_map);
 	if (pctx.errcode) {
 		pctx.num = 1;
@@ -2456,7 +2456,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	if (!ctx->block_ea_map) {
 		pctx->errcode = e2fsck_allocate_block_bitmap(fs,
 					_("ext attr block map"),
-					EXT2FS_BMAP64_RBTREE, "block_ea_map",
+					EXT2FS_BMAP64_BITARRAY, "block_ea_map",
 					&ctx->block_ea_map);
 		if (pctx->errcode) {
 			pctx->num = 2;
-- 
2.27.0


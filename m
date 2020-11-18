Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176392B80C4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgKRPkj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgKRPkj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD8C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b25so2982126ybj.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zJ7+kIvrxgVWJHLbQfy0p/hhFwuLvV16JAIDT0Z5Cng=;
        b=T8phYXG2xonLTx5TMF9inTZrvbMxLAhJr0UJrKq3t5Mw2QmBj2DJySDJrSh08PMgeh
         rBo51bxWO5MNhauWn6BFK3irki/14uK/gCeGdV8fKPQpryHKetNMJx4Hx0NjjXxOV8r+
         Babw9MtpTmaonb34Z3XJ2M/h/pGvxkiVHqMeHkRvzsWTURpEOtplR05AsQgbFtEmcDa3
         LP3Fi6pUZL+l0kzBahsQ973C+iDhzg6+yekvYdyO2VNOxlm69wBlTVffGVCEaGPte5XY
         SDSjlAmljJKV9n/zguMlBEF55AN6FOBvMmMviABY2U1tj8SL5S9RLiLriGSWMPuCGLB+
         j5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zJ7+kIvrxgVWJHLbQfy0p/hhFwuLvV16JAIDT0Z5Cng=;
        b=c7PAqmdYOXfAKyTSBaQYKRCEwBrh04hBuyqow15ZVu67JszvseNDcEKlF8vDLS+eCY
         3FeM80T+CccEhHKye1oEsGdy2fhXjKhWI0YmWGb8KJLuey/uRHU2bSwqeSY7g2oYF9Og
         RTSnyXiGGnNnNVsA1tQfpUtJjwOVttpuik26zbROyu7YHSFWkDTJ3LQhOlz7e+fLGG59
         IsvXFuoEqHSdywzIAaoMC1Cc47zMQiGhaEPC6RA7j8RI5Dzt2Xx3C35KveSzW/tc6QCT
         A1ODRtLRdOzXK2RQgW8tnqpr0pfB/oMNS7AF3XLfaVMp7aXCbT8QoxjDYSlsOt8Vo5Ll
         nDFw==
X-Gm-Message-State: AOAM531OgBfNp1KSDOBuW8HnUtobrvoSGFMWlcg7qqwpMoVWgiBRTAzr
        p3Ho57N22aM7tAZ9RBW89P545kwuvD6NCI1CtCivO2oJ1fgp9MaScgekRIWeK8DgBMr/UHgq1h2
        j06hqOG+wbrOdFCwHk9cI3aY6namIA6iQ89DGuhgy83JSmT03GQplK1FxfmY44oimbiEU6V2G7S
        nHJmGuh+w=
X-Google-Smtp-Source: ABdhPJwpDrma0qg819Jd9HUG6ceiEBSOcZFtvpUS7eD4shWnRNpFl+Dui0W4ntVPnpXBYzam2s4WsZEqKvDrZLjY7Es=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:2482:: with SMTP id
 k124mr5981787ybk.343.1605714038476; Wed, 18 Nov 2020 07:40:38 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:53 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-8-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 07/61] e2fsck: copy badblocks when copying fs
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

This patch copies badblocks when the copying fs.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 3a4286e1..14508dd8 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2123,6 +2123,12 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 			return retval;
 	}
 
+	if (src->badblocks) {
+		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		if (retval)
+			return retval;
+	}
+
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	src->icache = NULL;
 	return 0;
@@ -2155,6 +2161,13 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		src->icache = NULL;
 	}
 
+	if (src->badblocks) {
+		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+
+		ext2fs_badblocks_list_free(src->badblocks);
+		src->badblocks = NULL;
+	}
+
 	return retval;
 }
 
-- 
2.29.2.299.gdc1121823c-goog


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35C72A8DE2
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgKFD7p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:45 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA82C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:45 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so93678pfr.8
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6FGI3TOlVsKIxfi7+OHS1aAeIMzvqwcYjLn7l/BGo8=;
        b=rh+KRaOGkjRXyrooJRvk/PrZSNsQHQ3HXtWENHNZ9pzAu3ElONL/wl08idzyfgmvJp
         v370nGUJeITjsR+Ty0oQ/+gO9m6uRjI7I+qaOo/bDmZt62rNwDMl+qagtMMdV0kkKdoB
         ieqmZK9PigtltgLxBaCgpczPKMTbZ/oz/zeBPMEckxALkYUyuiZzrlBXlk/uSAlgv/zP
         NAm+iIP4uReEOJdLWsYJSBuVIq3/PSRz1enXKHEbXucjZjjfPjTbO/jPwREWGVv4G33s
         PIeN1oXvPo+9VLcL0WWp9XY4ZTicen9/Heb6PO3xMRJU4GQBTvUVCYsY1Jv2HOnu4uaB
         nHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6FGI3TOlVsKIxfi7+OHS1aAeIMzvqwcYjLn7l/BGo8=;
        b=SEo2ZsGARPGY5BwDAkoU1mPniQIS6ly5lywAOxoUvLyKf4anTf7IEcQz8QFk8SDS3r
         XzY/4ddDoBkUeCcc2e6h7NQmlB41OMUq944HltV/Kbezkzt8zbIvJrAtjbUUVzi+C9xQ
         iFRzLCGTe7H0aTD6jDXRbYzn0qj4ZMLGxFUaRXEiyoF2cBXQuFbZsD6HWj2Fsjdc4OVg
         DbsV+Q4JNq4w1jXGW3k+R0caSZNYs3c6u19dr1J1qV8ovW6yeAcNdeW9AXPOsBiTJh1u
         MJU23AHD8v2CV9caVOgOnKmAispniGuggMC0N5XQF5j0kkj6CpsivVY051RvJewzFxsq
         tGOQ==
X-Gm-Message-State: AOAM531345ABJ0zVO8vr27pCO9nX1HOYEINx/vn7dyxc9bRfFbz/ebcz
        XxyNhtsgOkLQUyHE607FTbHMmrA3eMQ=
X-Google-Smtp-Source: ABdhPJxIVh79MYsgPbwgZWsMq1t5EpxH/FRrKrt7adMtuwdP9WBvQp5FDpljEinzWU6bc+RDmiFG6A==
X-Received: by 2002:a63:fe0f:: with SMTP id p15mr35954pgh.343.1604635184607;
        Thu, 05 Nov 2020 19:59:44 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:43 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 16/22] ext4: remove unnecessary fast commit calls from ext4_file_mmap
Date:   Thu,  5 Nov 2020 19:59:05 -0800
Message-Id: <20201106035911.1942128-17-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unnecessary calls to ext4_fc_start_update() and
ext4_fc_stop_update() from ext4_file_mmap().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d85412d12e3a..80ad5ccc0288 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -761,7 +761,6 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!daxdev_mapping_supported(vma, dax_dev))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		vma->vm_ops = &ext4_dax_vm_ops;
@@ -769,7 +768,6 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	} else {
 		vma->vm_ops = &ext4_file_vm_ops;
 	}
-	ext4_fc_stop_update(inode);
 	return 0;
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5470312A402
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 20:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLXTJz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 14:09:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45442 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLXTJz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 14:09:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so11091541pfg.12
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/azddeZDYHtTFeT47JuHvo5bbLivs6cp1kJ+er2eAao=;
        b=LF8kzOXdvcdRfGZl0iONTic1Q8CzxxHe2ktBEQNfjMrHFUoJrkEKtJcxwyDC/EF81p
         +Av1U1nRRLl2Zz7Vp353Z6okN+8GwCcrKk0wkfvzk3XHeqg6CNWWi0PmVvjlDpB4TeDa
         On6tx3hIJ3fj2QmtAlph0pj9/ZC/sAdIsi8b/nr+MSCwybFfo4QTmNBt362/HdcFWGau
         CMHHatv0GEfy9t/kZh+yrjC4aUcXWUfDGz40cZPEVwbFqLfidG1gxTVDlgx7hSKars2T
         NFKHYhZ57pAKuGKIoHcH+o12BWlxI8qbW2gjdXQGsltkZrbdgcvoY9O26D8ssfeTbXaz
         WTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/azddeZDYHtTFeT47JuHvo5bbLivs6cp1kJ+er2eAao=;
        b=NDCOFoczDb8cGvOzZntwFK1Bdw+XKp6Zwn0nbKCRVq5OhJxknglUJGBnt9UKSx4EY9
         Hsvh0e7GeD/K93jfvWhnxLXLDFM4QuIPUfl/jB6Acp/S66+Kv/g39q2G/kKS+TUClzb/
         9say3q/G9Bx9qShT/WcTj0U740pCnGCtpVEOhpNiudIUUsY5B5ekW+iGMuneNA83PMd9
         07/4YyiGJDwkQkKtFWCtNLj2y1VVZYmbJooQVKt3BKjDwWDl4AVqj8c/NdzmnDjJvYnA
         KSt1nLu7RUyFkusbIm6UUX/YmmoVGW7wCGutT+cM9SO7zHrh7q6xNp4Fxi7FGK2OcELW
         wzXQ==
X-Gm-Message-State: APjAAAX0inESB+tRkpuYU9ryyXJz333hPmpCARuDNLRUAarkRy2ZhAJw
        Of97Ty9RCps4EdQ/f3OWHbiY/Ss1
X-Google-Smtp-Source: APXvYqyF7GyoBcGiS5Pv+y0NlzgMU4T7IlY5KhpLTAAOkGul/dSrsZjpDW+guI562mNuYS4gbJKmrA==
X-Received: by 2002:a62:f842:: with SMTP id c2mr39588426pfm.104.1577214594246;
        Tue, 24 Dec 2019 11:09:54 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id o19sm4931227pjr.2.2019.12.24.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 11:09:53 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: force buffer up-to-date while marking it dirty
Date:   Tue, 24 Dec 2019 11:09:40 -0800
Message-Id: <20191224190940.157952-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Writeback errors can leave buffer in not up-to-date state when there
are errors during background writes. Force buffer up-to-date while
marking it dirty.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c70b08d104c..ac50bd4e1f2f 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -292,6 +292,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 					 handle->h_buffer_credits, err);
 		}
 	} else {
+		set_buffer_uptodate(bh);
 		if (inode)
 			mark_buffer_dirty_inode(bh, inode);
 		else
-- 
2.24.1.735.g03f4e72817-goog


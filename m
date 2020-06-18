Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B955E1FF6A0
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgFRP2T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbgFRP2S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E08C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so2570130plo.6
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hF0w/LOdvI97L8RJkXqIv8fPgHjV1dEM8tYh9tOvYzI=;
        b=XSCxysRA/boarp8FwOVSUL6zlm32FiFcbpF6K+uc1vsch35SVrVrKw5IEkEN6x679Y
         6tPtLDXrKfdAoHBsfHQ3D/9tDLzClhusZ9He62DhKZZ1+9w4ytZL54nHUVmF7chS30wO
         wBjzo2ERY65E0aqCBqQZKtRwfvSFgURgJ7zToUQdyzGd6RqyN6fafB7j/vOMSRi6Xc3e
         RW/MEnzYPYgG4VEphn+QmxSvU+Ir+RiOPlLM0edB3FOAUH4jfAmyVYeJS0Vrz39oxXAU
         V4IeV6+v69vRrDJHorUUYTnSMkVnXaatbN0eB8+xhbbqeAeM8hoUluGiXtuoOTGuT07t
         xChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hF0w/LOdvI97L8RJkXqIv8fPgHjV1dEM8tYh9tOvYzI=;
        b=lYZ706Zl7RmTRgE/9Q1baKAQBTW4J8UAkF5tG4NHUReiPGsHtpF2wgOHx7l/F0vv0L
         1gbDOJWazHDU9h1R6lTaZyy4OVo79kly2d6E48V2L6NGM3YV7G+BuOqrPyXGlWf9HzeM
         j9Qd2nyUeHPzQ5sPD9XLuFW6NEXm7e2yURr+rHWCmDXdNBFzjTHFlJBUcPO4XvllbcfX
         HnkOMzqjhALo/U3S+v4gv9Y1HAqyXmhLH4x8U/v7K/z1tWhc3vjGOp/dWZcOPz2i2A05
         Qja0OBXycH8iSbA4TToMYuzi2OfQTKGd/cwE7cHtK2VYoaiXoGjhhuPeHYfRqrOAjfza
         +dpA==
X-Gm-Message-State: AOAM530pSywvXxRBCPvGMIShgKK2vOeAsJ+lJjKiZV8IyGhpMi6xadai
        ig9N7wBPFSXL7cKt2JDNfjDKIoeXpA0=
X-Google-Smtp-Source: ABdhPJzhoqq/0CquWcdz1XWrvPP68RvqsgXnhqX/QXmRtuc/DygDY/0ESdk1tmDd6fuCJJlUa9SGtg==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3mr3885943plt.276.1592494097840;
        Thu, 18 Jun 2020 08:28:17 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:17 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 02/51] e2fsck: remove unused fs_ext_attr_inodes/blocks
Date:   Fri, 19 Jun 2020 00:27:05 +0900
Message-Id: <1592494074-28991-3-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Only define but not used, remove them.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index f403360e..b9e2f06e 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -419,8 +419,6 @@ struct e2fsck_struct {
 	__u32			fs_fragmented;
 	__u32			fs_fragmented_dir;
 	__u32			large_files;
-	__u32			fs_ext_attr_inodes;
-	__u32			fs_ext_attr_blocks;
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 };
 
-- 
2.25.4


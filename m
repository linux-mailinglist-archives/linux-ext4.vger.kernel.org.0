Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273F248777C
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 13:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiAGMMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 07:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiAGMMr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 07:12:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0DC061245
        for <linux-ext4@vger.kernel.org>; Fri,  7 Jan 2022 04:12:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso10314608pjm.4
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jan 2022 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JH+rLYSlJ8WYeLk9ubntyaN9ZeQzzuznIoWrQdFG93c=;
        b=WBX+6ycom5E2aN595ka3qpbcOKnYJisf2VKHekYsdQbw2sFl6q5ibnAWlk3SpjK3VF
         lj0BIB5N+5TbAH3pDht2npVHCX/s+a5fdt6BOWBp/7RUVvcCP1CfCWh1s8ny/AEdLHlz
         jOfW+pPKheW5AiI6l24nnbbvx1IeuILoaZRiyFXCz/yi2Yk3eSN3zMxxCOgy0c0QcQBf
         wdAluiG//AYUZ/Fc/f4y+rTSlvjd10qQwRI4HxqcaJRrc2GXY5zpiynwHmArgP2i2zbn
         ttdEZeuRojAkaPqbbhUM/qDE0650QiDaituVDCpOQ30WeqpQ19Bza9qhKRdXOBHd9/jf
         YFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JH+rLYSlJ8WYeLk9ubntyaN9ZeQzzuznIoWrQdFG93c=;
        b=DeD0fiKwD2b2av8rbElVXVshqyC72t4KmXqAI8iE8fupx0O1OvkOq31yWxK4Sy88JF
         7DRkNqVbXX3yc609QjRsQey/K2asO7+YZEjYv2iP6Iea4JuXWr6GYG/wd0g6hjhv23q2
         NvKKlwn2tzc0jukg9E9PXrehEdW6XiBIS+snt7ewQeTMvb4NsneA5OOLt2U5gOnjwUqt
         rZTzQatr2QluIa8kEzvuM/GxWInBglaUkyoC3MPjIzRqVsMDaQJnPYrro4VszsuQ5vl7
         cyfJIXaUcxLeVlkLaaUuNGfwWXQou8SzkgMKCLNris3Uw6IFkQXYPFXRvCvSvqv+C1G1
         TYKw==
X-Gm-Message-State: AOAM532twgEw53Wn1hnt/vhSPmkCwsmkSaAklqzo6tDJ6Jn5HG/iej+c
        D092TdqM2pUf+N3CzLdtwh5S/Q==
X-Google-Smtp-Source: ABdhPJyg2aKvo2l2rQIhpKOfWbZEJxO/H54bF+b1MVjcMT/eOIVVPPMq8lt5iVBWd3LtmizXVLQSWw==
X-Received: by 2002:a17:90b:1651:: with SMTP id il17mr15592489pjb.10.1641557567033;
        Fri, 07 Jan 2022 04:12:47 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id h1sm5888137pfi.109.2022.01.07.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 04:12:46 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 0/2] ext4: fix issues when fast commit work with jbd
Date:   Fri,  7 Jan 2022 20:12:13 +0800
Message-Id: <20220107121215.1912-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When test fast commit with xfstests generic/455, some logic issues were
found. When a full commit is ongonig, the logic of fast commit tracking seems
not correct. The first patch fix the ineligible commit case , and the
second patch fix the common fast commit case.

After testing this patch set with xfstests log and quick group, no 
regressions were found, and the generic/455 can pass now.

Xin Yin (2):
  ext4: fast commit may not fallback for ineligible commit
  ext4: fast commit may miss file actions

 fs/ext4/ext4.h        |  3 ++-
 fs/ext4/extents.c     |  4 ++--
 fs/ext4/fast_commit.c | 28 +++++++++++++++++++---------
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/ioctl.c       |  4 ++--
 fs/ext4/namei.c       |  4 ++--
 fs/ext4/super.c       |  1 +
 fs/ext4/xattr.c       |  6 +++---
 fs/jbd2/commit.c      |  2 +-
 fs/jbd2/journal.c     |  2 +-
 include/linux/jbd2.h  |  2 +-
 11 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.20.1


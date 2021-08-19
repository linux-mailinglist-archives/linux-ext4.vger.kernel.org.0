Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA83F1BE5
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhHSOuO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhHSOuO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 10:50:14 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB57C061756
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 07:49:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t190so7409133qke.7
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D51JZlx0wH0ApNyP+urp4YXYUwXJRfaGsNiBJhXijME=;
        b=HxILlM/YaS0BM1qcUqpGuPqp5FprSVIOFM8DqL+qo8SQe6jsNkQ2EBItFBtvdyjrvA
         6H6ksU80VsbPy9+kmOWRRAmo/eB/18UnVCP6jTJdXWSZuRZaY3ua5U+mDumpXgOiS+oB
         WSTR75+43aI6Lt38ZaC/z5g3ifP1oZw3oofBcCmBdD+wUqWdvVDhD91DVQmrEHIX3psZ
         EcO7I/CWNADbha5jZ5fAITOCiROTzYogg71ktGARVHETKWdC5KBgBIkplcAdcjotfSHb
         KRW62pj3I66he19z8KWJsBHmx/SRYFh/TS1LYfL/5xuU2V90NkokcRsqa7RDE/20n5G9
         1iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D51JZlx0wH0ApNyP+urp4YXYUwXJRfaGsNiBJhXijME=;
        b=nBIHL3jSgH5cXc8cumAbBeh0SUtw8IejgwQH0sPMOZ5+dwSE7h6i0N3rwKMknNUANt
         Bdki+wHa6ub8NLHwYQrIVz8jetqttImf6MYipogglwfa9/kowEtL5GQ/EiBCSsCtHnl8
         51pdgX0OBMhR1gXMzz9PKxrM95UXcSaNrTG5rBVcgDimu6h8GKx/Q4BcBAvaCXJsIhhn
         +n+jQNF+GtbCOGd+T9T3uwt/SxjDXt1iD4WmhmH2DgkANMNWq0OWUy4TNlzvle7LPOO9
         eK7hTbN0ez4uwmaiMwNofcg/4lis6eZMaVqT3EFLHEooxGz/z6sNEW07iQl4nPx2Zh9l
         xu2w==
X-Gm-Message-State: AOAM533DjJhn0zLxzfydlMNzHbFEJpW3NG1Lxyy/OyAH/IBEVz5Lj6KR
        OxAO2MIloXJPlrgsCXxgrFGRcm/0G40=
X-Google-Smtp-Source: ABdhPJxhiNwxosiysHYklj9m1PoqxsM4ZvbFNWMSAt+gjqEK6sxO7N/AzO/SZBKDSj3v/9eoWaHHlg==
X-Received: by 2002:a05:620a:165a:: with SMTP id c26mr3926970qko.498.1629384576885;
        Thu, 19 Aug 2021 07:49:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id x21sm1684292qkf.76.2021.08.19.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 07:49:36 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 0/2] ext4: fix inline data / extent status truncation bug
Date:   Thu, 19 Aug 2021 10:49:25 -0400
Message-Id: <20210819144927.25163-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If ext4 converts an inline file to extents when applying writes under
delayed allocation that exceed the available inline storage, one or
more delayed allocated extents may be stored in the extent status cache
with an accompanying increase in the reserved block count.  If the file
is subsequently truncated before writeback occurs, that inode's delayed
allocated extents will not be removed from the extent status cache and
the reserved block count will not be reduced as required after
truncation. At minimum, unexpected ENOSPC conditions can occur.

Eric Whitney (2):
  ext4: remove extent cache entries when truncating inline data
  ext4: enforce buffer head state assertion in ext4_da_map_blocks

 fs/ext4/inline.c | 19 +++++++++++++++++++
 fs/ext4/inode.c  | 15 +++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.20.1


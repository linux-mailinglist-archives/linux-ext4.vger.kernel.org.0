Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9329A485EE8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 03:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344938AbiAFCph (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 21:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344937AbiAFCph (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 21:45:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA5C061245
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jan 2022 18:45:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so1731884pjp.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jan 2022 18:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jn+S9BAI1OCc7CICvkheWrMxG/LQav/G3Nl3L/CdSmM=;
        b=WWPWZz+hAaAOW388U+TlnhsHQDTCJz2O/5Bnv9uleUbfp/SlCZWtwjmPGRxSkK8HXk
         0xHOu2OeEhDR82/wzo+dvwMYGID1RK+N0b9+4lh6TZAFpZeNUdtIXIykl6+ztcI+DopP
         JG3YfgRQPDc/c8GrPL539LA7OAQp4baSiO0Wdm4/kh6rbGLVxTunjcvL+mLTl2rVuIRw
         59ReI6ScjCC8wsTFX3w7WqcAXrOMBHZ9TJYVEcVMSEjeF1d5+YvzfR81IgCaA5sKFhJL
         TNIYIQG0PHV0EuRhiTMVydm1BC0HDgZkzzXZtkd+jM7xD2/kxLP2Mj0Dy3brgp3OMN3u
         U94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jn+S9BAI1OCc7CICvkheWrMxG/LQav/G3Nl3L/CdSmM=;
        b=ElHD/PSpALo86FWhbCHnWUa95vKcdG93UEGU3LW9rJ2wTpVKcVF1QJKZwn4qZP2FtK
         gm3DRxP6ujqIoZKuaTBRp7bPBYasqGlxB8Wlc1ae+FSkvZS6KD8qORzx8fW0rsAjGIRi
         7cSe5QXWMkxkVDUI/8vLwMJjDrGfI0TNSvoxMY8l4x8XjqoKFBKZKcNffh/bzI8l2dYd
         2F1crHQjB8fuVqqdBnrHwepVHe5nBjK9385HjS4E28ZewuNnSAk024jhbT2Nrq7OTgAO
         TNOvx0uUu6h1ZOJvGYjtjUKxP3122EYXP6BDvHA9hRgIa4VK5HuFYuyBRnzucFLPJCRl
         KXaA==
X-Gm-Message-State: AOAM531/koFBSOoRzIiQW02D1HUcBEX7uZ+/mvw8cSBB6IFWv+vvnUHK
        /YBblZjMkOmmL+0zGJ4i+e1cdw==
X-Google-Smtp-Source: ABdhPJx5YJWOeTZpLWTFL3XTGe/k9q0J56HQoDLk1X9Sir76u93Z5EiiDnRAaNOq74FvP6yKVAYeEA==
X-Received: by 2002:a17:903:246:b0:149:e881:9e36 with SMTP id j6-20020a170903024600b00149e8819e36mr2893311plh.26.1641437136510;
        Wed, 05 Jan 2022 18:45:36 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id p12sm414244pfo.95.2022.01.05.18.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:45:36 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 0/2] fix blocks allocate issue during fast commit replay
Date:   Thu,  6 Jan 2022 10:45:16 +0800
Message-Id: <20220106024518.8161-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

when test fast_commit with xfstests generic/455, one failed case is 
after fast commit replay, fsck raise ’multiply-claimed blocks‘ issue.
one inode's etb block may share with other file.

fast commit replay procedure may allocate etb blocks for inodes, but
it may allocate blocks in use. This patch set fix this issue.

Xin Yin (2):
  ext4: prevent used blocks from being allocated during fast commit
    replay
  ext4: modify the logic of ext4_mb_new_blocks_simple

 fs/ext4/ext4.h        |  2 ++
 fs/ext4/extents.c     |  4 ++++
 fs/ext4/fast_commit.c | 11 ++++++++---
 fs/ext4/mballoc.c     | 26 +++++++++++++++++---------
 4 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.20.1


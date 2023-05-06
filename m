Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15F96F8F0D
	for <lists+linux-ext4@lfdr.de>; Sat,  6 May 2023 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEFG3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 6 May 2023 02:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEFG3W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 6 May 2023 02:29:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA40900D
        for <linux-ext4@vger.kernel.org>; Fri,  5 May 2023 23:29:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52cbd7e73d2so385851a12.3
        for <linux-ext4@vger.kernel.org>; Fri, 05 May 2023 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683354560; x=1685946560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzUNeo8AaNnB2TIGkih7468jv3ib2GmUiAAiulb8HSg=;
        b=BZEtsQk1eDY6hs4GRnP5P6GOQk3ymlCkXhW6QzXu6GIPp1ZShDBnC8dv3S7B4jbB37
         wLqPTd1a8Knjh04tv6w3Ce54uaFFtxUEqwA+v6hbIeWchc/pG5cHcJf87mGORpe2D9bk
         CPI4Bh73qYzNmgnoqy6/e4ivE75pIdcQaVYN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354560; x=1685946560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzUNeo8AaNnB2TIGkih7468jv3ib2GmUiAAiulb8HSg=;
        b=DRFUzD6f1jnCviIZg8bieWjzNTUi/JqjK3JYUYnuEjNOtEeB9OPOZygnDpCAuYP/MJ
         7VkIuiS99L5IoF/QPZv+EB87fOKZsMhDQ4bvyhDaLUh97lOy9L5Bgly3PcZToe6X1Dmr
         uzxLrkAEIH6wRfXwKfuGVQ9i6uf/TwHVdeXlv4hzQWATkl3pa/pwfZ6pOxLCytJxBZOk
         2KsHkEcvlKbW/L5oVDrIPek6e9yCH3qsQ/CS92bNcwB+Qo5XqTABhGIa7tirWPbO99dq
         r7lTRzVgPbDRi9Z5Yx4n+o9J2cCL7JZ8zovbYmx4tWxEc5DgZruHTtEDlWgdcu7NDXJ5
         r0nw==
X-Gm-Message-State: AC+VfDxdpQMYi298UHipqh8tVJBEXcM9maRfJwc6eoReGbzXbvi3N2Z8
        3JFVxU3WF8XIm1ijzcahcxe3Tw==
X-Google-Smtp-Source: ACHHUZ6jokL+0JA0+CBbmC7mx4pCawIF14Bio4r2MNA9EuX2SoeIteB8Nzv9VY3ha0KGEbV0N1b/Qg==
X-Received: by 2002:a17:902:ea0f:b0:1ab:13bd:5f96 with SMTP id s15-20020a170902ea0f00b001ab13bd5f96mr4894008plg.4.1683354560544;
        Fri, 05 May 2023 23:29:20 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:f19c:a713:5517:ed4])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ac381f1ce9sm2793598plx.185.2023.05.05.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:29:20 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v6 0/5] Introduce block provisioning primitives
Date:   Fri,  5 May 2023 23:29:04 -0700
Message-ID: <20230506062909.74601-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230420004850.297045-1-sarthakkukreti@chromium.org>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This patch series covers iteration 6 of adding support for block
provisioning requests.

Changes from v5:
- Remove explicit supports_provision from dm devices.
- Move provision sectors io hint to pool_io_hint. Other devices
  will derive the provisioning limits from the stack.
- Remove artifact from v4 to omit cell_defer_no_holder for
  REQ_OP_PROVISION.
- Fix blkdev_fallocate() called with invalid fallocate
  modes to propagate errors correctly.

Sarthak Kukreti (5):
  block: Don't invalidate pagecache for invalid falloc modes
  block: Introduce provisioning primitives
  dm: Add block provisioning support
  dm-thin: Add REQ_OP_PROVISION support
  loop: Add support for provision requests

 block/blk-core.c              |  5 +++
 block/blk-lib.c               | 53 ++++++++++++++++++++++++++
 block/blk-merge.c             | 18 +++++++++
 block/blk-settings.c          | 19 ++++++++++
 block/blk-sysfs.c             |  9 +++++
 block/bounce.c                |  1 +
 block/fops.c                  | 31 +++++++++++++---
 drivers/block/loop.c          | 42 +++++++++++++++++++++
 drivers/md/dm-crypt.c         |  4 +-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-snap.c          |  7 ++++
 drivers/md/dm-table.c         | 23 ++++++++++++
 drivers/md/dm-thin.c          | 70 +++++++++++++++++++++++++++++++++--
 drivers/md/dm.c               |  6 +++
 include/linux/bio.h           |  6 ++-
 include/linux/blk_types.h     |  5 ++-
 include/linux/blkdev.h        | 16 ++++++++
 include/linux/device-mapper.h | 17 +++++++++
 18 files changed, 319 insertions(+), 14 deletions(-)

-- 
2.40.1.521.gf1e218fcd8-goog


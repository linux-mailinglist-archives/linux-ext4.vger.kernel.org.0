Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1FD572DA2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 07:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiGMFxj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGMFxi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 01:53:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E597135;
        Tue, 12 Jul 2022 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KrpjvwUcHbQf2YuRp2OWaODTDZci6DgQG3eP4OSBmUI=; b=YRBK/+Qzhe+1221YOQ4iqzLn/5
        4Vwf1PyNclwthcoNXZ8KOoB+GAm/JBggQtmauR03xvzEJ6HJrky94ioJYu/id13gc3E8Vp3eEjaPZ
        4/U7tIzjiBG7yOAf5AudMpRTfWM/glZnmH0Q5KsdHn9yGpUBaGPrRgAqZ84jMYIXbbDNEzhIhaeXE
        HPqbGv7ZwbHz+9nAFWGg1NsiY6L75v7smtXveUpmZ+cLceuQWo6JUhgy4Vj3ymFqb/j70IVLdScfi
        nMcJLQNaBI3D7FKAwYGd4Ir2YoBbRsfjJA6+RJnMFwO2T37jlyn5qeZ+yBeFjFD20xwQM/46VSp4+
        +bC9PZdw==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVJH-000NMY-Jw; Wed, 13 Jul 2022 05:53:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: remove bdevname
Date:   Wed, 13 Jul 2022 07:53:08 +0200
Message-Id: <20220713055317.1888500-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jens,

this series removes the final uses and the implementation of the bdevname()
function.

Diffstat:
 block/bdev.c                        |   10 ++---
 block/blk-lib.c                     |    6 +--
 block/genhd.c                       |   23 ------------
 drivers/block/drbd/drbd_req.c       |    6 +--
 drivers/block/pktcdvd.c             |   10 +----
 drivers/block/rnbd/rnbd-srv-dev.c   |    1 
 drivers/block/rnbd/rnbd-srv-dev.h   |    1 
 drivers/block/rnbd/rnbd-srv-sysfs.c |    5 +-
 drivers/block/rnbd/rnbd-srv.c       |    9 ++---
 drivers/block/rnbd/rnbd-srv.h       |    3 -
 drivers/md/md.c                     |    2 -
 drivers/md/raid1.c                  |    2 -
 drivers/md/raid10.c                 |    2 -
 fs/ext4/mmp.c                       |    9 ++---
 fs/jbd2/journal.c                   |    6 ++-
 fs/ocfs2/cluster/heartbeat.c        |   64 ++++++++++++++++--------------------
 include/linux/blkdev.h              |    1 
 kernel/trace/blktrace.c             |    4 +-
 18 files changed, 62 insertions(+), 102 deletions(-)

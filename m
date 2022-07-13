Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB766572DAD
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 07:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiGMFxv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 01:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiGMFxl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 01:53:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDCC5587;
        Tue, 12 Jul 2022 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8YLN5GyijiVg1xTPNRS23c3gn76G2WVZ1KXJAfwp4Qo=; b=Ou3+wvbNsv98hQqKd4y7/c19rt
        xdHI8z47Si0TC49QMc0agJf1vT2jU2957dZe04c+E5LEYTE9hZn43J4bU1sgRBp+Yru61IHNToAgP
        wNlhnxrlwpxieWN9K7b1b/b3ggsLDPF5AGRyQdH19Yuty5r8srGsCVtZppYULVTujwJknrm4094Zc
        +LMIObRqzZIe2vFGhZ9gfmYiS3+HYlITQnotYk7yvb8MkhqPGd5cH+9n0EU5VXuEv/ChqLKrD/4zB
        lFkp5Fx8F9J7vhdPljqggq2dboCOI2gUoklE1cu2z93wEWY6Zsskwph6aZYgfx7pK2XQG3JGCE2Ua
        OKJTANDg==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVJT-000NS0-J3; Wed, 13 Jul 2022 05:53:32 +0000
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
Subject: [PATCH 4/9] pktcdvd: stop using bdevname in pkt_seq_show
Date:   Wed, 13 Jul 2022 07:53:12 +0200
Message-Id: <20220713055317.1888500-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
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

Just use the %pg format specifier instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 653d242314830..a7016ffce9a43 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2460,11 +2460,9 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 {
 	struct pktcdvd_device *pd = m->private;
 	char *msg;
-	char bdev_buf[BDEVNAME_SIZE];
 	int states[PACKET_NUM_STATES];
 
-	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   bdevname(pd->bdev, bdev_buf));
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->name, pd->bdev);
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
-- 
2.30.2


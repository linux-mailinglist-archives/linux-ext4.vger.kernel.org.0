Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5904CDB85
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiCDSCA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiCDSCA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E41B989D;
        Fri,  4 Mar 2022 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QA+5HjTUvBW6aKkA+AsxS9GpmbL0RCZ853javjBOR6w=; b=yS3xRFXJPZrGGrYg3Z8bCryvrV
        9TwsX5m/FP03k73d+H7QFFPPmSI15Goqi4F7IT9t8pBr2bXFW+l1r4QogOmR2hSE15pqODpD5A4y/
        zzLSI1gvvgXJM9ROzrUcq6lwVo+iA5zT05fO0BavxzSTm2t06bXSMn7vS36ynT3R5XRgZQxiJzxfX
        fPcl9gd4q3+zVvAAaUbco9ACxnWR/3lfXeKB6TIutzcwbZHL7/ruam5PfW8eIXONcYSRzIxZitvK5
        v0a7bcuqOhD+jGftouj6/nqZor0uDBsSCW3c4eVlX2xCF6eOp7HpEUzl2lGSM/BB06qKdkFcHWmmB
        8RLxjp/A==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCEl-00BUgO-51; Fri, 04 Mar 2022 18:01:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: remove bio_devname
Date:   Fri,  4 Mar 2022 19:00:55 +0100
Message-Id: <20220304180105.409765-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jens,

this series removes the bio_devname helper and just switches all users
to use the %pg format string directly.

Diffstat
 block/bio.c               |    6 ------
 block/blk-core.c          |   25 +++++++------------------
 drivers/block/pktcdvd.c   |    9 +--------
 drivers/md/dm-crypt.c     |   10 ++++------
 drivers/md/dm-integrity.c |    5 ++---
 drivers/md/md-multipath.c |    9 ++++-----
 drivers/md/raid1.c        |    5 ++---
 drivers/md/raid5-ppl.c    |   13 ++++---------
 fs/ext4/page-io.c         |    5 ++---
 include/linux/bio.h       |    2 --
 10 files changed, 26 insertions(+), 63 deletions(-)

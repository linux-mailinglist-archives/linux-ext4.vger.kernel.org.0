Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E95771352
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Aug 2023 05:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHFDNN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Aug 2023 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHFDNM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Aug 2023 23:13:12 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB681FE4;
        Sat,  5 Aug 2023 20:13:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vp4wN7H_1691291537;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0Vp4wN7H_1691291537)
          by smtp.aliyun-inc.com;
          Sun, 06 Aug 2023 11:13:08 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     adilger.kernel@dilger.ca, tytso@mit.edu, jack@suse.cz
Cc:     liusong@linux.alibaba.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] ext4: do not mark inode dirty which is already dirtied under append-write scenario
Date:   Sun,  6 Aug 2023 11:12:17 +0800
Message-Id: <20230806031217.13962-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230711034256.72651-1-liusong@linux.alibaba.com>
References: <20230711034256.72651-1-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Any comments on this? Considering the most extreme scenario
where a file is appended with only one byte each time,
"jbd2_journal_dirty_metadata" will be executed because i_size
has changed. Therefore, it is better to update raw_inode's size
after the writeback is completed, which can also ensure the
consistency of metadata and data, and obtain better performance
benefits in high-frequency append write scenarios.

Thanks

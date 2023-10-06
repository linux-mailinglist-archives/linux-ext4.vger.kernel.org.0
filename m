Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F97BBE6F
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjJFSHu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjJFSHj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:07:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA891BB
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:07:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6XEG008026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615596; bh=m+yB3jScn5m6LC2cflCigiOrKZ4dD+EbkukH0p8nn6w=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=BXUZgtuH6KL1RXh3XwE4N9ibCHLOVbF2A59Qq6YTYf0DOKrEpyahzpsOvzf5FSgo4
         YLHRzAImLY3DTH4r9WN87Zz805jw/r6wxApSM7wHPdd9z3bEO0jPLqy2mp8I3P9AwF
         1qkKQuBbXZsyktX/Pzrla9R4TV0f/MmLTyhfEASPLaK5rw0wRl8wGw8s1jdJOENtQL
         jTgMzVmL//QkRnubiHWK+piE9WvRz88/dxGN8gIY3olf8NAs6aseRDTr3f8mDM4F9I
         hpCkwVOLXElSZkRVcMb/XeKulmNsqGiJDGcC1AyIeliYbBbBCAq2XZBdeXAUjkCsMC
         /DAk3I7JDxvPg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 20EE515C0259; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] ext4: fix race between writepages and remount
Date:   Fri,  6 Oct 2023 14:06:20 -0400
Message-Id: <169661554694.173366.12709933957063678175.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230524072538.2883391-1-libaokun1@huawei.com>
References: <20230524072538.2883391-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Wed, 24 May 2023 15:25:38 +0800, Baokun Li wrote:
> We got a WARNING in ext4_add_complete_io:
> ==================================================================
>  WARNING: at fs/ext4/page-io.c:231 ext4_put_io_end_defer+0x182/0x250
>  CPU: 10 PID: 77 Comm: ksoftirqd/10 Tainted: 6.3.0-rc2 #85
>  RIP: 0010:ext4_put_io_end_defer+0x182/0x250 [ext4]
>  [...]
>  Call Trace:
>   <TASK>
>   ext4_end_bio+0xa8/0x240 [ext4]
>   bio_endio+0x195/0x310
>   blk_update_request+0x184/0x770
>   scsi_end_request+0x2f/0x240
>   scsi_io_completion+0x75/0x450
>   scsi_finish_command+0xef/0x160
>   scsi_complete+0xa3/0x180
>   blk_complete_reqs+0x60/0x80
>   blk_done_softirq+0x25/0x40
>   __do_softirq+0x119/0x4c8
>   run_ksoftirqd+0x42/0x70
>   smpboot_thread_fn+0x136/0x3c0
>   kthread+0x140/0x1a0
>   ret_from_fork+0x2c/0x50
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix race between writepages and remount
      commit: 745f17a4166e79315e4b7f33ce89d03e75a76983

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

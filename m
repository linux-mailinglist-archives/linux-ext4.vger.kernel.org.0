Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32797BBE69
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjJFSH2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJFSHS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:07:18 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216A125
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6Xvx008025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615595; bh=VGRWUwHRgP91PReilTCylthGnxI5CCHvzxny0Mq8Kmk=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=aMyDpXd5znTt4uu54VYHVDfl8yg9MxcN1BPhH3+Q0LJOcreEc4UfIKJuM2/qOSOjC
         dQONlN20VCHV9pTERKdwBHdRbODiRYcP1nYbHxaMgwxvtXJHxX+0aM2T/wBSQEt1ve
         k751ddNbe1L1eDpy1sarQZOGnIIIfaCmZuYbOq6TZcgmVnVMXSrXSbkXJBLtYZm7qd
         3HcYVqi2tfnRHCD/gT5KvCjpx5JySGwT4STKjiiDvlasmnaLaIRs7pOeSwzSCnff4c
         Pj67qH3kDRxYjhesIrOSIxiWRmg/QVoik28ZD2ICapJwpBfptbtDM5OqLLf0w+M4ta
         dCN/cOFUOBM9Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1B43915C0251; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.com, Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3] jbd2: Fix potential data lost in recovering journal raced with synchronizing fs bdev
Date:   Fri,  6 Oct 2023 14:06:17 -0400
Message-Id: <169661554697.173366.17984924984447813917.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230919012525.1783108-1-chengzhihao1@huawei.com>
References: <20230919012525.1783108-1-chengzhihao1@huawei.com>
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


On Tue, 19 Sep 2023 09:25:25 +0800, Zhihao Cheng wrote:
> JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
> however, other process could intercept the EIO information from bdev's
> mapping, which leads journal recovering successful even EIO occurs during
> data written back to fs device.
> 
> We found this problem in our product, iscsi + multipath is chosen for block
> device of ext4. Unstable network may trigger kpartx to rescan partitions in
> device mapper layer. Detailed process is shown as following:
> 
> [...]

Applied, thanks!

[1/1] jbd2: Fix potential data lost in recovering journal raced with synchronizing fs bdev
      commit: 61187fce8600e8ef90e601be84f9d0f3222c1206

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

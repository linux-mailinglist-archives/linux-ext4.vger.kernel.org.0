Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B073A7866F3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 06:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbjHXEy5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 00:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbjHXEy0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 00:54:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6901110EF
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 21:54:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37O4rke1029637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 00:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692852829; bh=9QSCOMklcgFgtS1l7ccQprq6cBd5+EQwquI3FVug++E=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=C36JHmFmQFsYKEv9n0NxVY19IRUOW7utki/MfmUA+TyUsR7cHoni04NeZCB3zmNyl
         YelkqtV6m+JEnCRbxSXlg3H1Y2eBc012fMU/gjCYwzsmSPO6aZk/J7dM44NAhQ6TYc
         iwd5N0rlCBFUeIvbdBBdDy4KTZIYN+jWOVXfuaiST5TkHCgsXD6Y9ewtgk18C/nWve
         8OQx55VLBbuKOoYwdfK7JhbrjQIHMhbMPnqyfDQJTSfOVOFjTtC7jv29AOYE7cLm/0
         2QyEaYDQsFrggVGFPWqoONohfXF+xSnGag72NyeQjz2PrNTwfnMGF+3DOSOu81cy2Y
         eqZ1lf8owfGpA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5DD3715C04D6; Thu, 24 Aug 2023 00:53:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        Yikebaer Aizezi <yikebaer61@gmail.com>
Subject: Re: [PATCH v2] ext4: fix slab-use-after-free in ext4_es_insert_extent()
Date:   Thu, 24 Aug 2023 00:53:41 -0400
Message-Id: <169285281339.4146427.8917376304564037982.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230815070808.3377171-1-libaokun1@huawei.com>
References: <20230815070808.3377171-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Tue, 15 Aug 2023 15:08:08 +0800, Baokun Li wrote:
> Yikebaer reported an issue:
> ==================================================================
> BUG: KASAN: slab-use-after-free in ext4_es_insert_extent+0xc68/0xcb0
> fs/ext4/extents_status.c:894
> Read of size 4 at addr ffff888112ecc1a4 by task syz-executor/8438
> 
> CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
> Call Trace:
>  [...]
>  kasan_report+0xba/0xf0 mm/kasan/report.c:588
>  ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
>  ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>  ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>  ext4_zero_range fs/ext4/extents.c:4622 [inline]
>  ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>  [...]
> 
> [...]

Applied, thanks!

[1/1] ext4: fix slab-use-after-free in ext4_es_insert_extent()
      commit: 91c66ddfd2dfa4c622c45a3ed0908b36c1adfa28

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

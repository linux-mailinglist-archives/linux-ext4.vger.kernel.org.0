Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2576ECD4
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjHCOjO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjHCOjA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:39:00 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F346A3
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:37:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 373Eb5dY009286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691073428; bh=W8SUgXDLLlTFk03tcAZjWg6lqd7hRvz3S6L8+svShwc=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=JtvTd1BrEmsXatwBKVro5ge9zQ+lRbLXB6waZ8YNvn6KsLWT8B0A/mgewYVHWARcr
         arcYJgXFqo7bsZSAV2WTU+wxVOQdPNPA6GvpYgvhiCg1BksVbysU84RVRJgEgtrgcu
         Ljt9rkB17CqshbPv7/yTLguw3jmt+M1mYbRjeyI5xtS1UCRVzvPC6CF6aJRYd1l1cY
         DZQL3aBFfRro8VgwwO88UOc3m2OOpfYyKgi6Xx8sr0qgHXYT32t/g/bkmC+dEagfmg
         KOesqlEskYn91vJey/G/LXnbKMU8DhsdWtZ9I6gq2L5oIRMFlllkd4HR1lZ/TAP1Bq
         mRVAr3DKtLYrQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ADFF715C04F2; Thu,  3 Aug 2023 10:37:05 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 0/3] ext4: fix some ext4_lblk_t overflow issues
Date:   Thu,  3 Aug 2023 10:37:02 -0400
Message-Id: <169107341681.1086009.9943740447336382710.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230724121059.11834-1-libaokun1@huawei.com>
References: <20230724121059.11834-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Mon, 24 Jul 2023 20:10:56 +0800, Baokun Li wrote:
> Changes since v1:
> * Rename fex_end() and pa_end() to extent_logical_end() and pa_logical_end()
>   to make the code more readable.
> * Refactor the logic for adjusting the best extent in ext4_mb_new_inode_pa()
>   to simplify the code and remove redundant parameter for helper function.
> * Merged patch 4 to patch 1 as mainline commit 9d3de7ee192a fixed the issue.
> 
> [...]

Applied, thanks!

[1/3] ext4: add two helper functions extent_logical_end() and pa_logical_end()
      commit: 43bbddc067883d94de7a43d5756a295439fbe37d
[2/3] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
      commit: bc056e7163ac7db945366de219745cf94f32a3e6
[3/3] ext4: avoid overlapping preallocations due to overflow
      commit: bedc5d34632c21b5adb8ca7143d4c1f794507e4c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

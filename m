Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF15F033A
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiI3DVB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiI3DUi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F044564;
        Thu, 29 Sep 2022 20:20:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JlQq002399
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507989; bh=R8ciZ9UyEKbtxR2xmm1YUdV3bB4grlkkZiHKo2b8fzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GPaEIpmjApmiOeNcscRLjyqIoYSHCRf+pT9VmTOL3jO72gxr1gdMc2/Rf+uO5UpQD
         A9eBXo3+F5RDKsCutlzmfJPbtcHMxOPtV6PZvzzL86Ro54hwMy3m8T2tYCwzPYwPuC
         al6qWwOU9ZMzbOPcOx10QF7uX4zV5vN1SS3a8YkQ7ERTX/gmbeNelu9lmaJ23ulghQ
         gwAKB3K32E8zm6kSJh0TeiUZj8zFatjPmhKLOq/oA2f3pQQpkaQb+meGCsP6NOv0r/
         yiUoSNUZvIu7Ub8zAVvCY1AB2Om/PlMKQZ4AMhXtnge0patgsN7iiy8r5IxFhkXeS9
         rlfHjU2mPadAg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9020815C3444; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, hanjinke.666@bytedance.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2] ext4: place buffer head allocation before handle start
Date:   Thu, 29 Sep 2022 23:19:35 -0400
Message-Id: <166450797714.256913.16618397949640055168.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220903012429.22555-1-hanjinke.666@bytedance.com>
References: <20220903012429.22555-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 3 Sep 2022 09:24:29 +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our product environment, we encounter some jbd hung waiting handles to
> stop while several writters were doing memory reclaim for buffer head
> allocation in delay alloc write path. Ext4 do buffer head allocation with
> holding transaction handle which may be blocked too long if the reclaim
> works not so smooth. According to our bcc trace, the reclaim time in
> buffer head allocation can reach 258s and the jbd transaction commit also
> take almost the same time meanwhile. Except for these extreme cases,
> we often see several seconds delays for cgroup memory reclaim on our
> servers. This is more likely to happen considering docker environment.
> 
> [...]

Applied, thanks!

[1/1] ext4: place buffer head allocation before handle start
      commit: 843b6ee4b8d0d9e7507dad491920db1fbde12439

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

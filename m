Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14991770F96
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Aug 2023 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHEMV0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Aug 2023 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjHEMVZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Aug 2023 08:21:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB94684
        for <linux-ext4@vger.kernel.org>; Sat,  5 Aug 2023 05:21:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 375CKVdD027550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Aug 2023 08:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691238034; bh=1bGXm8gvH4V2sfyFgzqDNNlK6DqK9uVlqmWS8762+14=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=PdPj1eY358x/1E/0HsJMV2YBcKqozc1wPOY1JoZtJIdxgeduTGeC0hLfvqhnY7s2M
         fWzFieJq0rlXGKV/t/+03bVPU4zviP5+78cfQMNxhbWNLWTWAlzorrSLCj85hbI0i6
         oi111GDUhNOcAMp3uCPLQbTCh3AfKikO3/DkYluaweO9eoeMSpx+bsXDp/pRqcb495
         aMNcoUPIa6pUt9mallbTjkAa+WWuo6xGERxXNvM2hPeo4Nf6ux7atwWuTOhzGsYgQz
         X4+tp9bYA+to+jxZeeuvqo/W8idoNl2Obq9+dLW37Y46MCEWUCSsMkmWBA4KDw56FD
         H/vzZa4StiTWw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5938215C04F5; Sat,  5 Aug 2023 08:20:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yang.lee@linux.alibaba.com, yukuai3@huawei.com
Subject: Re: [PATCH 0/3] jbd2: some fixes and cleanup about "jbd2: fix several checkpoint inconsistent issues"
Date:   Sat,  5 Aug 2023 08:20:28 -0400
Message-Id: <169123801880.1434487.18031026925968851100.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
References: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
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


On Fri, 14 Jul 2023 10:55:25 +0800, Zhang Yi wrote:
> These patch set includes 2 fixes and 1 cleanup about "jbd2: fix several
> checkpoint inconsistent issues" patch set[1] recently applied in dev
> branch. The first patch fix a performance regression introduced while
> merging journal_shrink_one_cp_list(). The second one add a missing
> check before dropping checkpoint buffer that could lead to filesystem
> inconsistent. The last patch which is from Yang Li, remove the unused
> __cp_buffer_busy() helper. Please see the corresponding patch for
> details.
> 
> [...]

Applied, thanks!

[1/3] jbd2: fix checkpoint cleanup performance regression
      commit: 373ac521799d9e97061515aca6ec6621789036bb
[2/3] jbd2: Check 'jh->b_transaction' before remove it from checkpoint
      commit: 590a809ff743e7bd890ba5fb36bc38e20a36de53
[3/3] jbd2: remove unused function '__cp_buffer_busy'
      commit: 5f02a30eac5cc1c081cbdb42d19fd0ded00b0618

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E752D780554
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357979AbjHRFGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357945AbjHRFFp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:05:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D403AA7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:05:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55F4q026958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335120; bh=pWdnLuG4Y2whhIRpKLlXWkti6XtHB5EMydPw1ofl5Z8=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Jp+jtVJEOhKIGB2MtuyvC3RbCXVnoTjpCS7CONS8d+ghxWCyTyE3iFMqV7K8vI979
         RbDO9IL1R7NjwjJkfLVVbvJgjdIsL4fejYymb4WZFjVO9gCbp8ZpS+NPeFvXVrq6yX
         OL5cZlucbBsdqcbZhMVmN1P9geD6whEewLA/bk8A5LbHyuXDqSlBmNEc9rUqWFoEyi
         sow8nd1wB1n1L6qi2XSqO4RvGrn3tpHfB1OA8hC4rh6SMDEVtK+yAz0bFqLopJqEEP
         l7g/44uFWRLcn84pP+N4/d2wkh/W0V4WAfG8XrD+ZAn4IIWHM2oBxfBeQC7arsT3/j
         LuC/8i8NWmt8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 37F8115C0506; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        Su Hui <suhui@nfschina.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] ext4: mballoc: avoid garbage value from err
Date:   Fri, 18 Aug 2023 01:05:11 -0400
Message-Id: <169233503392.3504102.15591922902240482750.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230725043310.1227621-1-suhui@nfschina.com>
References: <20230725043310.1227621-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Tue, 25 Jul 2023 12:33:11 +0800, Su Hui wrote:
> clang's static analysis warning: fs/ext4/mballoc.c
> line 4178, column 6, Branch condition evaluates to a garbage value.
> 
> err is uninitialized and will be judged when 'len <= 0' or
> it first enters the loop while the condition "!ext4_sb_block_valid()"
> is true. Although this can't make problems now, it's better to
> correct it.
> 
> [...]

Applied, thanks!

[1/1] ext4: mballoc: avoid garbage value from err
      commit: f2060a35e10fc3db2950e98f5b7f6f55ad4e4079

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

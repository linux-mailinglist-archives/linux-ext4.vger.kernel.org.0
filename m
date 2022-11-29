Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636163CA3E
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiK2VNW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiK2VMo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 16:12:44 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FA22BF7;
        Tue, 29 Nov 2022 13:12:43 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCJwj029735
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756341; bh=Xc6ScPsRePfO/+1EPTpMGxHkSC8xvx2I060fXoCkgis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c9/gQZFfACBuLjbXBQcLfOm8bLZ9TVJ2+WOXYCKn7j7iCUvJIQqOileznQtW221In
         B8kwm49gmgZ2hKWn7ef3R0mMec/rqbENbSpF2s2eYBmTaXKpK26HqEuFraKnJLLXGC
         s8ek/VmWjS1LA05FN5Uh1KT7G/LNNPZ3FnmbgP/F/pO2EABzCOsimIj53/yAptS7LQ
         JY36DE1LAk3d2kVkx9D8T2mM8b5BO/YW/BlScu6jD4tWwH6IUWeUC9ZcHAOBVFUbAp
         PbX5cW6vhOkYIU7QXzaNBwVLZzR3N7sPN6oVw7fk6GIZihwsmvEMXBI7Im9NDvIfbV
         m+BCRk+pfbQvg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6473015C3AA6; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Bixuan Cui <cuibixuan@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, bvanassche@acm.org,
        rostedt@goodmis.org, axboe@kernel.dk, mhiramat@kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH -next v2] jbd2: use the correct print format
Date:   Tue, 29 Nov 2022 16:12:10 -0500
Message-Id: <166975630695.2135297.11708030511108233612.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1665488024-95172-1-git-send-email-cuibixuan@linux.alibaba.com>
References: <1665488024-95172-1-git-send-email-cuibixuan@linux.alibaba.com>
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

On Tue, 11 Oct 2022 19:33:44 +0800, Bixuan Cui wrote:
> The print format error was found when using ftrace event:
>     <...>-1406 [000] .... 23599442.895823: jbd2_end_commit: dev 252,8 transaction -1866216965 sync 0 head -1866217368
>     <...>-1406 [000] .... 23599442.896299: jbd2_start_commit: dev 252,8 transaction -1866216964 sync 0
> 
> Use the correct print format for transaction, head and tid.
> 
> 
> [...]

Applied, thanks!

[1/1] jbd2: use the correct print format
      commit: 62734ac752c2f1b8b143a99e19342a5327def328

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

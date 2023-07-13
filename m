Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCA7525B8
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jul 2023 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjGMOzh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jul 2023 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGMOza (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jul 2023 10:55:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2182709
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jul 2023 07:55:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36DEtBcK026892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 10:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689260113; bh=UJWy1cJBt8WV8O+26w7+MTqpUJ0ekhnSvAQI1QTfMlY=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=anjY9VCTZW3+AXCSyowRaLCmFRaKLUFxm6RBiVitAx252A7Z34u1YLVgdwWyVBZQ3
         gRUl/uedaw2cDFjn/eGCa4Gz+6+VJ2CPzX6JumPekQwC50akg5PhHv8x2kl9IUwHD4
         1NfS3B/WfN/sIWk3Bd3vunHjANC+OaO9Fp3cNaFD9APWIuYmdXj9gHjSAT0g1c2Drn
         xk213nBeISn33i+0Sk3CsdLT3+kPmlw/qfcn5Yxtw8SBdTuw5W0q7q1fUhx6ANYWLt
         4pU9ZYW8XxtpxI587pNbMizL1PY7is+K4ldMzhoIIqlwLTYWoob4Q7D7BzTF+pxRhm
         Qkdbdr+BTxo0A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B9B6915C0281; Thu, 13 Jul 2023 10:55:11 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH] ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()
Date:   Thu, 13 Jul 2023 10:55:07 -0400
Message-Id: <168926009830.3728471.10772472098260314138.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230609103403.112807-1-ojaswin@linux.ibm.com>
References: <20230609103403.112807-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 09 Jun 2023 16:04:03 +0530, Ojaswin Mujoo wrote:
> In ext4_mb_choose_next_group_best_avail(), we want the start order to be
> 1 less than goal length and the min_order to be, at max, 1 more than the
> original length. This commit fixes an off by one issue that arose due to
> the fact that 1 << fls(n) > (n).
> 
> After all the processing:
> 
> [...]

Applied, thanks!

[1/1] ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()
      commit: 7c79210b15ef69a5702d1fb817bad9a30bffb097

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

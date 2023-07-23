Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1175E1E7
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jul 2023 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjGWMiM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jul 2023 08:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWMiL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jul 2023 08:38:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CAC1AA
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jul 2023 05:38:10 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36NCW71a012921
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 08:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690115529; bh=f8fJOKa5Ro/KTo0xGIv7OJI2g/dAB3fdmH+CiwAC2JU=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=XNrTNTk8wBPdKBf9wmt2tnUtBDKj4iu6UiYvx9fr+vvACCMnN02GZaERBLTmkTQdQ
         fW17KcNmnOp+TIb2UmYU/hj54/zQBJc+BemNHpVcKPb0FvgOWEsRMzsjxmIPShhZVk
         Y6+ZA7vgN3qr2ekBi4dvbz/CNZw7zoEkRZj99/1nEHHNSLqxOg4wbW4+noQsyDYfFp
         tQG24a7iU7u2ldNhRcGQEbsoeFq5oMOYetqDII1eP1plJb0xGIpsvN+XqMFC6CIDHo
         E6RkqPQDi/tcg5W52FWJf81qgzJpipPvrUI1Et4NIVuYcqT6/AhGJ4uu+XWK9PEKpi
         BD0GP/XT+rkWw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D94515C04D7; Sun, 23 Jul 2023 08:32:07 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 0/1] ext4: Fix regression in mballoc due to deleted inode PAs in rbtree
Date:   Sun, 23 Jul 2023 08:32:00 -0400
Message-Id: <169011551315.10885.4411764690665517539.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1690045963.git.ojaswin@linux.ibm.com>
References: <cover.1690045963.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Sat, 22 Jul 2023 22:45:23 +0530, Ojaswin Mujoo wrote:
> Recently there was a regression found in the mballoc [1] due the existence
> of deleted preallocations(PAs) in the per inode preallocation rbtree.
> Such deleted PAs can occur because ext4_mb_discard_group_preallocations
> traverses the grp->bb_prealloc_list and marks the PAs as deleted without
> taking any inode specific locks like i_data_sem.
> 
> Due to presence of such PAs, we were sometimes missing some of the pa
> entries when traversing the per node rbtree in ext4_mb_use_preallocated.
> Due to this, in some rare conditions we ended up missing a PA that did
> overlap with our original request start. when this happens, we exit
> ext4_mb_use_preallocated and proceed with the allocation. However,
> during ext4_mb_normalize_request() we were hitting a bug on as
> a PA that could satisfy our request already existed. Since normalize
> request was already fixed earlier to account for the deleted PAs we
> actually able to catch it there.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix rbtree traversal bug in ext4_mb_use_preallocated
      commit: 9d3de7ee192a6a253f475197fe4d2e2af10a731f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

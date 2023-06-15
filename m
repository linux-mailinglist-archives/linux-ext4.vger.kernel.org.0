Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B38731C15
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjFOPA6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbjFOPAe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 11:00:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0812960
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 08:00:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FF00hu026909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686841202; bh=4/TATINxJcGIc+5Qft9NYQhj4JIYqsumuVH6M49lT8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I/42DkFibUOu0eh9CCMUihY4OoOiLw/kUUN28hHtH2nNIZBt+y7B+VTob009nunpw
         D7PbXOt3IMf6CGp2oFHKzyQtLd4Jll77dWmzb8xNU2lPaty6BmwDiPnz4wLofQaT4+
         NrKvt6oB10jU7c5clkqkbn8yClNZfqF/cABQWchMcc46sV4bWu13SYe4uiJP9lG0zI
         HVAKq34/9c0fDQfnWlGhlkqrUf1ItRErbBc5LeKpo+oqQeAn35CP0IIqDg2Pj74WFN
         KHfVDZRKwJxojn+CXLRBfGBeapep/LwxdWG6JS++cm2EgDvOw9WCb55CzJD0h70nxw
         H970Vfi6opgDQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D703C15C02E1; Thu, 15 Jun 2023 10:59:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 0/3] ext4, jbd2: journal cycled record transactions between each mount
Date:   Thu, 15 Jun 2023 10:59:57 -0400
Message-Id: <168683994076.282246.11277662662888331081.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
References: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
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


On Wed, 22 Mar 2023 09:33:50 +0800, Zhang Yi wrote:
> v4->v5:
>  - Update doc about journal superblock in journal.rst.
> v3->v4:
>  - Remove journal_cycle_record mount option, always enable it on ext4.
> v2->v3:
>  - Prevent warning if mount old image with journal_cycle_record enabled.
>  - Limit this mount option into ext4 iamge only.
> v1->v2:
>  - Fix the format type warning.
>  - Add more check of journal_cycle_record mount options in remount.
> 
> [...]

Applied, thanks!

[1/3] jbd2: continue to record log between each mount
      commit: 0311c8729c0a35114d64a64f8977e7d9bec926df
[2/3] ext4: add journal cycled recording support
      commit: b956fe38a26861bfe13e7e83fbeadf9d2e159366
[3/3] ext4: update doc about journal superblock description
      commit: ecdae6e9d63414b263ab2848ba3835e727eef2f9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

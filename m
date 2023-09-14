Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11097A085B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Sep 2023 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbjINPBY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Sep 2023 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjINPBY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Sep 2023 11:01:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0260A8
        for <linux-ext4@vger.kernel.org>; Thu, 14 Sep 2023 08:01:19 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38EF0jMH000408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694703647; bh=6S1k2iDH9GNe9lxLjjxLjWHxbt1hlMrzeY5YzEQzWsE=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=a8pECaKTx75qjuee90vCO6bWSmHlMex5dpQ4Q6jd/50H3ABDvroPEFDNFqkYm1g8o
         eqKtcuVcLoXROG6sub7EBRpz5CU3eBAsiuFwltIswcQO6PaWYeAvILowGsbehwpjlk
         F2W1Kkdy4m6jdhuXqwviMhDxyEZRUigFK2PwivsEPmuFkC/cQnEjhLhN9mu1qOYjkS
         6dkwsvWnPMisNqOrZux0RILp/RWPOTM3Lf2WgvfuEBlCctlPB/Va0jXe4/Bm/wKMWb
         mmThF6B/WaDJuZoz2oSuoPATx1Z4VzYErSDX+Eq+uAVi8arAxZJ7oJang3ldowYPgG
         EhmE+lAn1H3Ng==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E94A415C0269; Thu, 14 Sep 2023 11:00:44 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.com, yi.zhang@huawei.com, Li Zetao <lizetao1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: Fix memory leak in journal_init_common()
Date:   Thu, 14 Sep 2023 11:00:43 -0400
Message-Id: <169470363118.1407074.7189148436884246673.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230911025138.983101-1-lizetao1@huawei.com>
References: <20230911025138.983101-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Mon, 11 Sep 2023 10:51:38 +0800, Li Zetao wrote:
> There is a memory leak reported by kmemleak:
> 
>   unreferenced object 0xff11000105903b80 (size 64):
>     comm "mount", pid 3382, jiffies 4295032021 (age 27.826s)
>     hex dump (first 32 bytes):
>       04 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>       ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace:
>       [<ffffffffae86ac40>] __kmalloc_node+0x50/0x160
>       [<ffffffffaf2486d8>] crypto_alloc_tfmmem.isra.0+0x38/0x110
>       [<ffffffffaf2498e5>] crypto_create_tfm_node+0x85/0x2f0
>       [<ffffffffaf24a92c>] crypto_alloc_tfm_node+0xfc/0x210
>       [<ffffffffaedde777>] journal_init_common+0x727/0x1ad0
>       [<ffffffffaede1715>] jbd2_journal_init_inode+0x2b5/0x500
>       [<ffffffffaed786b5>] ext4_load_and_init_journal+0x255/0x2440
>       [<ffffffffaed8b423>] ext4_fill_super+0x8823/0xa330
>       ...
> 
> [...]

Applied, thanks!

[1/1] jbd2: Fix memory leak in journal_init_common()
      commit: 414f73db6ce825b7264cacb9407581b87da60aeb

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

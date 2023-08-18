Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB54780559
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357995AbjHRFG1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357978AbjHRFGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:06:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830CD35BD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:06:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I55FuO026963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335117; bh=c+Hm9K5IMSBb7Vt3ehaoZkaicDQcEdE0xWVUdcUiVn8=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=Fag0LIoqsK1+6qJnTHt+5WzoVA6tvVNJ+EbWdcfhH+j+gxFmR2egBBbqU2609I5XT
         JZwymeF2p+VytzhAfKuCuQLCcW16Zc8UxbXnAYNfrsuReGo61X8xcrnLOW+l1Vbvfh
         T4T5w/G7jbuQ4EhH+BZZu9I6gU8eVMGm1eA829kyfUvojYOn08EH0djazdI9BzbHq0
         miD1NHv5zc20eKNmQcKqCpkZjNavd4a34XNzDjO3FJdU7H/facVVgl1IH0mbgZ0y25
         PEbmBW1zRcCPKtazspcwPutG23JPVXcTLFjzMKRXpEk7WUPTCMKJ+ahb+KbUbK/o3l
         DAbpVc1+elnMw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 39AF815C0507; Fri, 18 Aug 2023 01:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] jbd2: correct the end of the journal recovery scan range
Date:   Fri, 18 Aug 2023 01:05:12 -0400
Message-Id: <169233503392.3504102.921645801804891970.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230626073322.3956567-1-yi.zhang@huaweicloud.com>
References: <20230626073322.3956567-1-yi.zhang@huaweicloud.com>
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


On Mon, 26 Jun 2023 15:33:22 +0800, Zhang Yi wrote:
> We got a filesystem inconsistency issue below while running generic/475
> I/O failure pressure test with fast_commit feature enabled.
> 
>  Symlink /p3/d3/d1c/d6c/dd6/dce/l101 (inode #132605) is invalid.
> 
> If fast_commit feature is enabled, a special fast_commit journal area is
> appended to the end of the normal journal area. The journal->j_last
> point to the first unused block behind the normal journal area instead
> of the whole log area, and the journal->j_fc_last point to the first
> unused block behind the fast_commit journal area. While doing journal
> recovery, do_one_pass(PASS_SCAN) should first scan the normal journal
> area and turn around to the first block once it meet journal->j_last,
> but the wrap() macro misuse the journal->j_fc_last, so the recovering
> could not read the next magic block (commit block perhaps) and would end
> early mistakenly and missing tN and every transaction after it in the
> following example. Finally, it could lead to filesystem inconsistency.
> 
> [...]

Applied, thanks!

[1/1] jbd2: correct the end of the journal recovery scan range
      commit: 3aab2c3d9ef0b30dd41e20c336377c43b4ca513e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

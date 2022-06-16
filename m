Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544D54E653
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiFPPpR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFPPpQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 11:45:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C024F26;
        Thu, 16 Jun 2022 08:45:15 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25GFj1g5013025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 11:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655394303; bh=r44lkTrMqAG05PntDRjsplMZ+4Xyw9+0ssvaJ2TXeuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XUZNkhpiVnBtxqD2apDrKao8ZjQzxe+69Kig4klgFcP0K83UCs64OzeEfsTFM05+b
         0zm8eKbmEZyJ1MdXZm3mlnfZIssoxuKGsgAco4BwfxOpnwdsz8etUo7utafKmsu+iV
         YTsCJa8UKEI0EiFYq1etJDmqH0SxceZuIdEqe+q7AtB4OStZlsQubYtqkG/7At+MYP
         z6NdoCm+Brzvv9C2kJJ2sxlP4OQK6tg+NWCLgEQ1TlRJnkq+uJ4UGNLw8F6wir7Mfe
         pWqiL2xABWZe6B7m70flkpMuPt1rOf5glB1XTwNuD+xQr4+J66FbkPpKZu4cn2V4CA
         /SDkljm7mObcw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5F66A15C3F35; Thu, 16 Jun 2022 11:45:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-doc@vger.kernel.org,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: Fix incorrect comment
Date:   Thu, 16 Jun 2022 11:44:56 -0400
Message-Id: <165539423848.63953.14194697142129914542.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220520022255.2120576-1-wangjianjian3@huawei.com>
References: <20220520022255.2120576-1-wangjianjian3@huawei.com>
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

On Fri, 20 May 2022 10:22:54 +0800, Wang Jianjian wrote:
> 


Applied, thanks!

[1/2] ext4: Fix incorrect comment
      commit: 48e02e6113825db81e4aacc035933c0d0e4e68ce
[2/2] ext4, doc: Remove unnecessary escaping
      commit: 3103084afcf2341e12b0ee2c7b2ed570164f44a2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

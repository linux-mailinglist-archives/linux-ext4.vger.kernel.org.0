Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050B87866F0
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 06:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjHXEya (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 00:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbjHXEyJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 00:54:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2610EF
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 21:54:07 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37O4rkeV029648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 00:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692852828; bh=wyOx33KBTUhOxu1vKjOBW4BATOsnZinp9E9t9Rbr+E8=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=P2HXpc2KwrBbJ262xzn7HOF64V5dVtnJDln5KQHsJ9qWdH8YciGe2XshQCo0f6Xdo
         rXfWCNLp0Lk++XNF9iQ7iMAyben4rCB7l/N4ugQy3mnrCH8HWjiLmdAEdANisoJBUl
         BnT/ZFQgbDnAaglH0ADt6XO9ufZsAaPkhssRed1spPhI04RR4AJH4Kfjw8vubTrIpF
         BkqN77w5eppmZIWdO1oiMs7g7IwQyBTd4v4MjiHyTLbXdYnt4D4m/uCqsnUYOKM7wj
         vwoGgXsA927CV8zq2i9ek783uxJ5KxxVhw64cIScK5qlOm2OyTdiSgy1yekt9qliGy
         2NIptnLFSb4SA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6142A15C04F1; Thu, 24 Aug 2023 00:53:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH -next] ext4: mballoc: Use LIST_HEAD() to initialize the list_head
Date:   Thu, 24 Aug 2023 00:53:43 -0400
Message-Id: <169285281340.4146427.9749917688010174226.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230812071839.3481909-1-ruanjinjie@huawei.com>
References: <20230812071839.3481909-1-ruanjinjie@huawei.com>
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


On Sat, 12 Aug 2023 15:18:39 +0800, Ruan Jinjie wrote:
> Use LIST_HEAD() to initialize the list_head instead of open-coding it.
> 
> 

Applied, thanks!

[1/1] ext4: mballoc: Use LIST_HEAD() to initialize the list_head
      commit: 78a83061cbfac4f3abb471c57ed2302f85926447

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7EF6F2A19
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjD3R7g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjD3R7g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 13:59:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B61992
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 10:59:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UHx8C5016289
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 13:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682877551; bh=fQoDw9Lx8Q2yffx7+iFh3/aPhT6B99JNicwJBnAe1mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fClBy0CQ0dpIQRu89v7OA5LG7OkA54kN4+lmS1p+tuCHTDab5AA/UMLNAA92l0+lg
         p5S6DnOJPjSwUtRVHlB+/v7394xcR/s+9z8+u6oOJ2nZNkO0S/NEycGh09Z/88m+t9
         V3kc+cb3p3HlQ7b3MoGKynUMN+IbVuj4k3rkPhXmyUtQ0LPwEBUhghK70sLfF7a6bL
         T4oAIltTqLXiYuEZBZZcbaMakGNJ6ZFM5+H141l2lMHgE6R+1OMKZwTuWopGXw4EHr
         R4tgu/mapfZjGF0RqcUQHnuWYO7AoavVwuIPF0D1cBWmeroB5eJnEIoQHjmHJPpcJq
         eXYMvB+Drb9qQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 86FD515C02E3; Sun, 30 Apr 2023 13:59:08 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Nathan Chancellor <nathan@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yanaijie@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix unused iterator variable warnings
Date:   Sun, 30 Apr 2023 13:59:06 -0400
Message-Id: <168287753833.584010.6362113120710816488.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
References: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
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


On Thu, 20 Apr 2023 09:51:24 -0700, Nathan Chancellor wrote:
> When CONFIG_QUOTA is disabled, there are warnings around unused iterator
> variables:
> 
>   fs/ext4/super.c: In function 'ext4_put_super':
>   fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
>    1262 |         int i, err;
>         |             ^
>   fs/ext4/super.c: In function '__ext4_fill_super':
>   fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
>    5200 |         unsigned int i;
>         |                      ^
>   cc1: all warnings being treated as errors
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix unused iterator variable warnings
      commit: 856dd6c5981260b4d1aa84b78373ad54a203db48

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

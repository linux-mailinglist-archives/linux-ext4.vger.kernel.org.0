Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122767866ED
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 06:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHXEy1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 00:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbjHXEyE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 00:54:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220210EF
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 21:54:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37O4rkT2029636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 00:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692852829; bh=kvoN+3YJOl1TeKxLM4dCwghZZyomFfwZlX8kVct6Ioc=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=G6oDtSFqvdv4/Br4Zlx6hG+3SG2ZLsBtmCRzgpg4sQtA960Ajm1Vni8xj0ll+RvhO
         kzwZHwSJvsFQs3AfZ3OhiNDWqh286FPSrZ/UOTCJA9ah9Zj5DapgsQlDVvC6Gnq9VD
         WDGoIVx3A9690TorvwEB48K6xH6+g+HOpaITiy1IyvdNG1SRoOh2le+ZBGCUzOr3hk
         6NaoZEseJ6KoVGD6Fsp2G0vKi0XgDQKRgcnoqp6VZBaFp/RJLuIxr10fJOhahxxlzc
         qDyvvTh73LYCneqh8sqjrWiwa0sPpS9SXTZzwSxuqbAfFOIR6GWdb8R2JOYwxEfqj0
         6ouhoQNe5EJHg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5F5AB15C04D7; Thu, 24 Aug 2023 00:53:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, jack@suse.cz,
        Liu Song <liusong@linux.alibaba.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] ext4: do not mark inode dirty every time in delalloc append write scenario
Date:   Thu, 24 Aug 2023 00:53:42 -0400
Message-Id: <169285281339.4146427.13867368474882584364.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230810154333.84921-1-liusong@linux.alibaba.com>
References: <20230810154333.84921-1-liusong@linux.alibaba.com>
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


On Thu, 10 Aug 2023 23:43:33 +0800, Liu Song wrote:
> In the delalloc append write scenario, if inode's i_size is extended due
> to buffer write, there are delalloc writes pending in the range up to
> i_size, and no need to touch i_disksize since writeback will push
> i_disksize up to i_size eventually. Offers significant performance
> improvement in high-frequency append write scenarios.
> 
> I conducted tests in my 32-core environment by launching 32 concurrent
> threads to append write to the same file. Each write operation had a
> length of 1024 bytes and was repeated 100000 times. Without using this
> patch, the test was completed in 7705 ms. However, with this patch, the
> test was completed in 5066 ms, resulting in a performance improvement of
> 34%.
> 
> [...]

Applied, thanks!

[1/1] ext4: do not mark inode dirty every time in delalloc append write scenario
      commit: 40b14c55e3d0496c5db7dd60b90a5c30933ac033

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

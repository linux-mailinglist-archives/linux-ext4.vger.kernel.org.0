Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35252C98F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 04:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiESCFa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 22:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiESCFa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 22:05:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CDF51315;
        Wed, 18 May 2022 19:05:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24J25D0R018585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 22:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652925915; bh=pcjxFOhySjekWfGdUnbaIeFGicbs/FvtrliG44D1WJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Sjpyetr7C/w1KXTsWYgZ+LbKFIHW8eY6kDOulUtIEPGnxDJ4L22/fYNx2aDUCEg2D
         dtGBxF/CrN2KnW3ZYWueiKIsmaE9dzTnfrHdtDCi+eTV0m/2MM1450LqSQ00AsA3s9
         tzRZDP6WYb+GlWoSPyli5xbr7OY9MM4dS3ChD9VbLEMZf/Axj7xViJbhIu24CoKl8k
         pFUxKaAwx5mWOGDfoNun1/Y9zFXao++mBMo3HeIDSYf8slHwJoyVN1eBPbvvDOWXVX
         0hsxdBEvyOm/4wKqguvyj6eI09Sq8lYnQJnsZSS14Lf1geeilW9gRa0yPrh3oiJSst
         U5jdk0WDjD1Mw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9EC2115C3EC0; Wed, 18 May 2022 22:05:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, fstests@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH] ext4: reject the 'commit' option on ext2 filesystems
Date:   Wed, 18 May 2022 22:05:13 -0400
Message-Id: <165292590335.1201976.332165676131707881.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220510183232.172615-1-ebiggers@kernel.org>
References: <20220510183232.172615-1-ebiggers@kernel.org>
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

On Tue, 10 May 2022 11:32:32 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'commit' option is only applicable for ext3 and ext4 filesystems,
> and has never been accepted by the ext2 filesystem driver, so the ext4
> driver shouldn't allow it on ext2 filesystems.
> 
> This fixes a failure in xfstest ext4/053.
> 
> [...]

Applied, thanks!

[1/1] ext4: reject the 'commit' option on ext2 filesystems
      commit: cb8435dc8ba33bcafa41cf2aa253794320a3b8df

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

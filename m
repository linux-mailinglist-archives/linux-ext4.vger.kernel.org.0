Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705461E081
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Nov 2022 07:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKFGRZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 01:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFGRX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 01:17:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25702DED9
        for <linux-ext4@vger.kernel.org>; Sat,  5 Nov 2022 23:17:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A66Gx6l032694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Nov 2022 01:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667715421; bh=G0KOdVg6nQhQj8K0UFn+P2wmja22lRI3kEB47D96Emo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DPvyj8Zb3c7LrFYIjJPDh8zSlegsqZnqAi8Sqf2VkuM5KjIQ0XjkqmVjGamehVCiS
         Fi/KYI1vQnMlkGJTt+TrokR7Ke4hUjNEDE/5CAGgGqNFB8EXC6J4sMFlMRfvH8uyhR
         55hKWX+5J/mpIGJ9KtRjJ3yv8K9FYQ+1jfIjG9eBVkrwx5NJ2P/0a5X6+SeNGGHV2H
         VzyE7EyqVmrVtf/XcAERodMLOWIBRU6Kxa1ycOmvLuL3UL8v7vx6bHCGYsRV1UfkZC
         lnvYaHrY/XhWKDdV+SGrMrf5mLJbIqGpkrTYKgJ1iCClNCsHKqMnL7bI9kQV478bjB
         lLFXYU67Sz5Mg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1935F15C45BA; Sun,  6 Nov 2022 01:16:59 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.cz, lczerner@redhat.com, linux-ext4@vger.kernel.org,
        ritesh.list@gmail.com, Jason Yan <yanaijie@huawei.com>,
        adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] ext4: fix wrong return err in ext4_load_and_init_journal()
Date:   Sun,  6 Nov 2022 01:16:52 -0500
Message-Id: <166771539910.127460.2313968809841911803.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221025040206.3134773-1-yanaijie@huawei.com>
References: <20221025040206.3134773-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 25 Oct 2022 12:02:06 +0800, Jason Yan wrote:
> The return value is wrong in ext4_load_and_init_journal(). The local
> variable 'err' need to be initialized before goto out. The original code
> in __ext4_fill_super() is fine because it has two return values 'ret'
> and 'err' and 'ret' is initialized as -EINVAL. After we factor out
> ext4_load_and_init_journal(), this code is broken. So fix it by directly
> returning -EINVAL in the error handler path.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix wrong return err in ext4_load_and_init_journal()
      commit: 9f2a1d9fb33a2129a9ba29bc61d3f14adb28ddc2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

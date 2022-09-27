Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9D5ECF9A
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 23:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiI0VyD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiI0Vx7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 17:53:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5A1114D0
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 14:53:55 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RLrdaT032630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 17:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664315620; bh=6Zw/wV8jKoJPOnEXomcMNIZEhDil6t0J1qW1Cwj97/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RYG3+sQjA5p3zWcOGUXgYIQ2GmMGS6jrkGbj6PfrXEmIljx08wuNYtl1hhpHhWQFn
         4VAyFunO2Disnr+pEHwUADrpS0Wn+KsSo0F8JziP9d0vyQ33woHXsdjPAXnLaA8xVb
         K1FuWnEJ566eIswt1zfFmzKcs55jQPYr6Xg0qyKVIAFVuukEd9bPGksAdwrR51JcdR
         gZimjCL7h0KNtNgZ2NBcYrCtyvyIwhXGScvv5O6amo+bm/0HQuynMt+HIHySoPw8ip
         fm8CDcSvz4zyT2Zqp+FDIdow/siugWtSdxElerF17cSTCGg4AValXWXfyEwG+JzMTH
         l84SdxFqEfa/Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A697015C528E; Tue, 27 Sep 2022 17:53:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, xuyang2018.jy@fujitsu.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, lczerner@redhat.com,
        jlayton@kernel.org, djwong@kernel.org, jack@suse.cz
Subject: Re: [PATCH v1] ext4: Remove deprecated noacl/nouser_xattr options
Date:   Tue, 27 Sep 2022 17:53:36 -0400
Message-Id: <166431556706.3511882.843791619431401636.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

On Thu, 28 Jul 2022 11:02:49 +0800, Yang Xu wrote:
> These two options should have been removed since 3.5, but none notices it.
> Recently, I and Darrick found this. Also, have some discussion for this[1][2][3].
> 
> So now, let's remove them.
> 
> 

Applied, thanks!

[1/1] ext4: Remove deprecated noacl/nouser_xattr options
      commit: 134435d6d0be21d567a95007323def8d0ebea27e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

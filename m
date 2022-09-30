Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6284D5F0337
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiI3DUz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiI3DUh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B784151F;
        Thu, 29 Sep 2022 20:20:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3JnGH002454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507991; bh=P/tgbf7KCmi98p5dYaRwG22NUJ/yBxwwMYrnaxucbtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WEcVcazK35sQI0KJL/Whf0bEz7mKjne5q85XfnfR1xdNKDOkPBORp2RDRm8O2RDDT
         kw7muAuuqce0jziwEfNhBUnXgzjuNB7GbeJTsg4yzk2NSQ5krp5PoWCtnLtEvsecOl
         AzdCFmFR3bSJG/04+rLBWDQtJZxDEcS0BYwn6kxBvxeVSoc6ynSAPn/CGjCVvyihKL
         bt5HjJ0bmm+l3sL8eLjUeye7ewlbjEKJ7Jx+CDsVJY2pOzSSqxrHOQXv7J+iPTvRDI
         9r4UCkV/ZvwvyAbIIRlqNA3J6pbq3X+y1enWWined9o9MGHS0VqVWC84eq0SAH1zDV
         cn2d1CjkKNhTQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 97EB415C34E2; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next 0/2] Fix two issue in jbd2_fc_wait_bufs
Date:   Thu, 29 Sep 2022 23:19:39 -0400
Message-Id: <166450797716.256913.2463365477003955215.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220914100812.1414768-1-yebin10@huawei.com>
References: <20220914100812.1414768-1-yebin10@huawei.com>
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

On Wed, 14 Sep 2022 18:08:10 +0800, Ye Bin wrote:
> Ye Bin (2):
>   jbd2: fix potential buffer head reference count leak
>   jbd2: fix potential use-after-free in jbd2_fc_wait_bufs
> 
> fs/jbd2/journal.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] jbd2: fix potential buffer head reference count leak
      commit: 53dee029ec341f5c985b880de34f64de60072688
[2/2] jbd2: fix potential use-after-free in jbd2_fc_wait_bufs
      commit: 6e16a2d9ff8f3ea4a53e10ae4607feb446cf5c90

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

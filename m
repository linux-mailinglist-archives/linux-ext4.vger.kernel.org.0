Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00035F0332
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiI3DUm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiI3DU3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689403F1CC;
        Thu, 29 Sep 2022 20:20:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3Joqn002482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507991; bh=igDPtMFvx/5vdIk3HGmOyfUrdR4q3uAx0wglBKbPx24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h0AmrLKMimnXDpTWKYLCaZRQNvvl7S6KfaM2QkE2143qhBQp5BSFuM++TMA0K1rm1
         pYqIWezDrmALOTcfPJxhBvaPmsoFNgRsipfYfYCpXptiLq6ARbY9/Wo9Rvl8YU0V1h
         /Q3sOj6tUlVrdlSjnOvvdljdvPFKMVph93u/1Z1qMi8WSwvqo+LXRSEhFAYCnqoJvv
         qmIyEOW4OSIdMwlBUVrg/LoZ1cAk4mT85VfMUCypOYz0fSYe1EhQg6FjwCh1TImxcv
         x0zSV7RGW21HAHrlA258q0OzFVfq/+GbeoGFXs8gzGpm3NQRnRHGOzmwHGj18T26ws
         fcD5jaKZ5ly9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9D21515C353C; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        yebin10@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] jbd2: add miss release buffer head in fc_do_one_pass()
Date:   Thu, 29 Sep 2022 23:19:42 -0400
Message-Id: <166450797717.256913.1507967656320330189.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220917093805.1782845-1-yebin10@huawei.com>
References: <20220917093805.1782845-1-yebin10@huawei.com>
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

On Sat, 17 Sep 2022 17:38:05 +0800, Ye Bin wrote:
> In fc_do_one_pass() miss release buffer head after use which will lead
> to reference count leak.
> 
> 

Applied, thanks!

[1/1] jbd2: add miss release buffer head in fc_do_one_pass()
      commit: 0f04cd3834a988a9c725fd396e3f88fe334f9f29

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

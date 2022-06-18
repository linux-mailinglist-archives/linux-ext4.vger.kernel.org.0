Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B835501E7
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383858AbiFRCMi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383839AbiFRCMe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:12:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1240DFA
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 19:12:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2CDkn005813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655518336; bh=e+frCT0LyVlsSxBJ/92XR1E40gsV5ICy5oEeOMWfxnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lwzKX58fPT+F3PjgrtxMWfCqrI2S0y0h9nXe+psRzpmGf1Ttt/mWFJKMCSRCw3SM0
         HeCk7tKTT4GgAHGMntftETpxK7jTYPBrg/4Lv6WO84iOyfRBKQ34gdmNEwLT+a/DxD
         ZAifp3KMWjEYfoFsmEarTYg3EGniV7EivwC+XOTYobwtaB5VKIo86kpCOKFxkVZ5Sg
         ue236GAwgNAhEV1nQkQBLaOYoPHkXIEuW+zPiL50DqMxEaI2Y0T9dOvof/cbn8hpSq
         xwoGQmpDRmUMwAj4eY8r9803ApvDmQu+hZ1exkFFdtfPbvL0ow1Y1iZZDAzGejRuPS
         sK/UbbgNtllxg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BAC9115C430C; Fri, 17 Jun 2022 22:12:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: fix warning when submitting superblock in ext4_commit_super()
Date:   Fri, 17 Jun 2022 22:12:08 -0400
Message-Id: <165551818831.612215.4879369937917679508.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220520023216.3065073-1-yi.zhang@huawei.com>
References: <20220520023216.3065073-1-yi.zhang@huawei.com>
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

On Fri, 20 May 2022 10:32:16 +0800, Zhang Yi wrote:
> We have already check the io_error and uptodate flag before submitting
> the superblock buffer, and re-set the uptodate flag if it has been
> failed to write out. But it was lockless and could be raced by another
> ext4_commit_super(), and finally trigger '!uptodate' WARNING when
> marking buffer dirty. Fix it by submit buffer directly.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: fix warning when submitting superblock in ext4_commit_super()
      commit: 15baa7dcadf1c4f0b4f752dc054191855ff2d78e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

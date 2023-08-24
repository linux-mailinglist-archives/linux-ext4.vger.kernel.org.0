Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F37866EC
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 06:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjHXEyZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 00:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjHXEx6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 00:53:58 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767D10EF
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 21:53:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37O4rkrG029646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 00:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692852829; bh=yd4dqAi9qFwXWg6tkqg+BJwtxEqBBXGpUvP06zKPFEo=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=e+l7UO9ds/FIPkj+j58veUPlVIbjbszPWv+kuhd3sudrKzt4+b4Z4Qwuq8o0aYVzY
         gMwdDRhrJgtxJacpu4HkmKWwLfAa15rEjO4rqG7Thr40cjequXumfxE9Xj1rOwG4V+
         WkQLY2w3+NjajSCsrtEApJxUt8l1AnstJczXkb8YRozQLhgk3WrES/yytC9RE0MwPF
         d01mAoF1jkAbf5t+NA1c1VcdvdkMLe3mfB7D+j7m2GERqBYMyq3/1BdNzb1JnYS+EU
         F3ErnSc8FgYIOzTLtCUMyMPfU0MeKVWD5UEq8XPVqcKm+VS7CosyJCO+UbRNWcqYZ9
         I2DmWrUSyAg5A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 62EA615C04F3; Thu, 24 Aug 2023 00:53:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Vitaliy Kuznetsov <vk.en.mail@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH v2] ext4: Add periodic superblock update check
Date:   Thu, 24 Aug 2023 00:53:44 -0400
Message-Id: <169285281338.4146427.4994363470834118959.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230810143852.40228-1-vk.en.mail@gmail.com>
References: <20230731122526.30158-1-vk.en.mail@gmail.com> <20230810143852.40228-1-vk.en.mail@gmail.com>
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


On Thu, 10 Aug 2023 18:38:52 +0400, Vitaliy Kuznetsov wrote:
> This patch introduces a mechanism to periodically check and update
> the superblock within the ext4 file system. The main purpose of this
> patch is to keep the disk superblock up to date. The update will be
> performed if more than one hour has passed since the last update, and
> if more than 16MB of data have been written to disk.
> 
> This check and update is performed within the ext4_journal_commit_callback
> function, ensuring that the superblock is written while the disk is
> active, rather than based on a timer that may trigger during disk idle
> periods.
> 
> [...]

Applied, thanks!

[1/1] ext4: Add periodic superblock update check
      commit: 58d85f2e88c97c69c869cae6c6bdd1af32936146

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998C526C28
	for <lists+linux-ext4@lfdr.de>; Fri, 13 May 2022 23:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384632AbiEMVPm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 May 2022 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384633AbiEMVPl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 May 2022 17:15:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3B2A728
        for <linux-ext4@vger.kernel.org>; Fri, 13 May 2022 14:15:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24DLFIDK028123
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 17:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652476520; bh=3p8EQcQQc+B05o9FlxRuCLia0op/2BMXn+GHRw5FKOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pq0h7OgyQ7thLluKzy1juJ3x53csv8xXdTj44YFA/E/yFqCRkzKQ1SAkyr0symXJj
         7E84hQs5UI4fRV3QD2GvJUByvkA2p+4j/sObyYS4Ip0IFPTaYVUm2nEVsxIcbiu12p
         XzR4BpardSmxIHdVVfyIq428185NWcjVvSRDci6mOMa271WH+I52dVmNhP6VyRDrpi
         LBDosv6hkUC9p0RemUqmZiAq9Ona6WthV3GQ0dvR+p2IYq0Trob9H8eT7l8oLowszj
         Y3kBUUG+iogzyZLg8AUUO/ZAnj/hUCgd2y8exYv1eUF/MSYOKvsI/OQ5rbHzKYkKWL
         PhGAsdfipwDbA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 204F015C3F2B; Fri, 13 May 2022 17:15:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, liuzhiqiang26@huawei.com,
        liangyun2@huawei.com, jack@suse.cz, adilger.kernel@dilger.ca,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
Date:   Fri, 13 May 2022 17:15:16 -0400
Message-Id: <165247650913.591780.6175539260604740270.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220412145320.2669897-1-yi.zhang@huawei.com>
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
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

On Tue, 12 Apr 2022 22:53:20 +0800, Zhang Yi wrote:
> Now that we have kernel message at mount time, system administrator
> could acquire the mount time, device and options easily. But we don't
> have corresponding unmounting message at umount time, so we cannot know
> if someone umount a filesystem easily. Some of the modern filesystems
> (e.g. xfs) have the umounting kernel message, so add one for ext4
> filesystem for convenience.
> 
> [...]

Applied, thanks!

[1/1] ext4: add unmount filesystem message
      commit: 4808cb5b98b436f1110d83c65541dd43beb45f63

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

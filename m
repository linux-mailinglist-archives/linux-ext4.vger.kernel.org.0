Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6F63CA3D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiK2VNV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 16:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiK2VMl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 16:12:41 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FD13DDF
        for <linux-ext4@vger.kernel.org>; Tue, 29 Nov 2022 13:12:40 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCLJ9029771
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756342; bh=S7Jnx1qYVJ2q71fG9wc61THNDckCab0vrYwdOiW5SP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Algx5VgoSbxV5UHZf9WEpV8cEt1Bhb3UdGd3OHb5YtknKjUBQ8xsD81wtrqul4522
         LHtgrGSOvaQxS2mYUd/EzseKt98C+/uII2BgamWRTFphdrZF3IE23uBU4WB+ebzMLK
         hz5dL0TjYOcBMau9TWm8MDKkZ1IgsYirXanplKQ/MQSpyTLOYv3l3MXbCO1L/Pekf6
         tYL/FZFZRk09QXLLc7PiSwZACeQ4eMjMct0nCl1RJiKBYfWodKF4W3KlygAjEHCzMA
         R+bwe1RbUeQA5ExoyqSmwQ8MXSunQ7Ww/2phfJqxhYPiiz5QmAzCawgjxZz4H0sRku
         C8rJm5yAqtmzA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6D96E15C3AD1; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz, yukuai3@huawei.com,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH v3 1/2] ext4: silence the warning when evicting inode with dioread_nolock
Date:   Tue, 29 Nov 2022 16:12:15 -0500
Message-Id: <166975630697.2135297.10209303433796955869.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629112647.4141034-1-yi.zhang@huawei.com>
References: <20220629112647.4141034-1-yi.zhang@huawei.com>
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

On Wed, 29 Jun 2022 19:26:46 +0800, Zhang Yi wrote:
> When evicting an inode with default dioread_nolock, it could be raced by
> the unwritten extents converting kworker after writeback some new
> allocated dirty blocks. It convert unwritten extents to written, the
> extents could be merged to upper level and free extent blocks, so it
> could mark the inode dirty again even this inode has been marked
> I_FREEING. But the inode->i_io_list check and warning in
> ext4_evict_inode() missing this corner case. Fortunately,
> ext4_evict_inode() will wait all extents converting finished before this
> check, so it will not lead to inode use-after-free problem, every thing
> is OK besides this warning. The WARN_ON_ONCE was originally designed
> for finding inode use-after-free issues in advance, but if we add
> current dioread_nolock case in, it will become not quite useful, so fix
> this warning by just remove this check.
> 
> [...]

Applied, thanks!

[1/2] ext4: silence the warning when evicting inode with dioread_nolock
      commit: bc12ac98ea2e1b70adc6478c8b473a0003b659d3
[2/2] ext4: check and assert if marking an no_delete evicting inode dirty
      commit: 318cdc822c63b6e2befcfdc2088378ae6fa18def

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

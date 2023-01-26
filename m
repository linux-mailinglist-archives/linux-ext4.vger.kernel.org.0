Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533C367C3B3
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 04:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjAZDvM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 22:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZDvL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 22:51:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A85F457EA
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 19:51:07 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30Q3ovHb017569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674705061; bh=8Pse/D0QKLTWEoBiKExaoap5b0godIZGPBF4LHnL/98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YZIcgncjmZ9PqroaZPduNIG36r1PGv4nwDb5XfA+e9T39LoGbAZKHpCH/iqcV/MCD
         zXMTTilsNEZ7MvDlkEjZu8SB0Q0laRfo0WhdJ00vHYLtDM48ANR55YQviPoVGY5a82
         8r38WHca1rs3sM7mwbcEIfxlQYfQkf7IbRdsaf383B1sWhGsmMpR2lxUxG9kBrvf75
         gt6zJfbKFzRLWwNcVSJ+GfjelilVbn9qPY6GVBC22SRvgL0MqhOTQCi/IxeG5PFaBV
         BHd6cnPQEaQLRu2opPiFC6fQvOVVWW3pTcxZ/adMOlIN1arj0VC+6ovnD4SmjhYkD4
         UEQWC1CXhSwHQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6E9E015C3589; Wed, 25 Jan 2023 22:50:57 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Li Dongyang <dongyangli@ddn.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger@dilger.ca
Subject: Re: [PATCH] e2fsck: optimize clone_file on large devices
Date:   Wed, 25 Jan 2023 22:50:55 -0500
Message-Id: <167470504132.8995.9766202525673034373.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221219130544.259410-1-dongyangli@ddn.com>
References: <20221219130544.259410-1-dongyangli@ddn.com>
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

On Tue, 20 Dec 2022 00:05:44 +1100, Li Dongyang wrote:
> When cloning multiply-claimed blocks for an inode,
> clone_file() uses ext2fs_block_iterate3() to iterate
> every block calling clone_file_block().
> clone_file_block() calls check_if_fs_cluster(), even
> the block is not on the block_dup_map, which could take
> a long time on a large device.
> 
> [...]

Applied, thanks!

[1/1] e2fsck: optimize clone_file on large devices
      commit: 6cae615a47dfe37fe5fd096accb82579813a6366

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

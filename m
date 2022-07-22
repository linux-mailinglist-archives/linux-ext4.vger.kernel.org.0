Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9B57E2AE
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiGVN6l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiGVN6g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A508FD74
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 06:58:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwTce016737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498310; bh=on4p+ieFk5hDGlmkfp6dO2xVenNn9kwjnm98l8K+wKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f1AxNUnd11g3gDx/JT9azeP9lRLgr0dOUtoVQ/UbR3rbdPPIO+pfMDJslkUzdQ3y4
         s+6mnaCJYLIu0hIFzYQWliyERPiforWGfoCQFC38kMmBPrPa/CVCZaFWOICeHk1wS8
         y6CnLT+8zzUkyc1DR8RRCUwfra7/zYcH/E0wMvKGGXrqzw0Ny7l/gmm79JU86QEWmY
         SLdFUMKfh5ZsgIMUAEw/Z1r4FNYzWW79mcPPniu7PPCTONJ0Dy3ctdoyDEwlxDVTWe
         y6Mi+ZhWo289/aKAPntdk29cmilOYTYxX4BDv1SP2Z28AfEx0C3ATqhiFzhPVOlJEm
         oOUjYOOFpRJ2A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 70B5515C3F03; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com,
        tadeusz.struk@linaro.org
Subject: Re: [PATCH] ext4: block range must be validated before use in ext4_mb_clear_bb()
Date:   Fri, 22 Jul 2022 09:58:17 -0400
Message-Id: <165849767595.303416.2399065700843216204.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220714165903.58260-1-lczerner@redhat.com>
References: <20220714095300.ffij7re6l5n6ixlg@fedora> <20220714165903.58260-1-lczerner@redhat.com>
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

On Thu, 14 Jul 2022 18:59:03 +0200, Lukas Czerner wrote:
> Block range to free is validated in ext4_free_blocks() using
> ext4_inode_block_valid() and then it's passed to ext4_mb_clear_bb().
> However in some situations on bigalloc file system the range might be
> adjusted after the validation in ext4_free_blocks() which can lead to
> troubles on corrupted file systems such as one found by syzkaller that
> resulted in the following BUG
> 
> [...]

Applied, thanks!

[1/1] ext4: block range must be validated before use in ext4_mb_clear_bb()
      commit: 91e204c46741b198693dd88bd7b03a5b5fe0ce17

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

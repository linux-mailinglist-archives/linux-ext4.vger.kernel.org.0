Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5E57E2AD
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiGVN6k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 09:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiGVN6h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 09:58:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E189904CF
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 06:58:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MDwTMU016770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 09:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658498311; bh=eUPtkUbR9nSM/4hlqsfrWX/EXs8Pb0BkytPA1RSiQkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KEBvBxdFUYE1Lj2LwkyBQamoon65/TxoPJTfqie18l6OjQFL7/zeOpmHQwdJgP8iQ
         xlKh1eOgoZTXeTfJl7kDNZb81zc0X+sQxRmn77UMjFRf25cF6Izr5LWmG4cFIJ4Ld/
         e33Zn3NfjhBl1YQya8d+Ay46LrREJNWNWWgZkv2df0P3GvxABEiblZcSShR432VzAh
         VkL4insxlPinzLsx3JgsXtFon6yp7hkRnA7F650YHVLSvQxonk2haD9ViC1rHfvn5i
         RLAj4reW3T6MysuJYP0NrXhcHGJeCjAnMfFWBTXdBX/AHO9SBTzhJLqMMNg+2ignMU
         MuLWlQgjCSVzw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7839515C3F07; Fri, 22 Jul 2022 09:58:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, okiselev@amazon.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH -V2 1/2] ext4: reduce computation of overhead during resize
Date:   Fri, 22 Jul 2022 09:58:21 -0400
Message-Id: <165849767596.303416.13460164582488168327.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <CE4F359F-4779-45E6-B6A9-8D67FDFF5AE2@amazon.com>
References: <CE4F359F-4779-45E6-B6A9-8D67FDFF5AE2@amazon.com>
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

On Wed, 20 Jul 2022 04:26:22 +0000, Kiselev, Oleg wrote:
> This patch avoids doing an O(n**2)-complexity walk through every flex group.
> Instead, it uses the already computed overhead information for the newly
> allocated space, and simply adds it to the previously calculated
> overhead stored in the superblock.  This drastically reduces the time
> taken to resize very large bigalloc filesystems (from 3+ hours for a
> 64TB fs down to milliseconds).
> 
> [...]

Applied, thanks!  (Some slight adjustments were needed to resolve a
merge conflict.)

[1/2] ext4: reduce computation of overhead during resize
      commit: d985f3d81c0be1c673ac0462b26727b2a1aeb0d6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

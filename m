Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDC791C1F
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjIDRsz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbjIDRsy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 13:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32024CE5
        for <linux-ext4@vger.kernel.org>; Mon,  4 Sep 2023 10:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4BBE6148B
        for <linux-ext4@vger.kernel.org>; Mon,  4 Sep 2023 17:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A16C433C8;
        Mon,  4 Sep 2023 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693849730;
        bh=ke+ediaALrZcLjZfiWCTaLJwxCVHpVfn4vEs1M0IyM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2HsG1zVK+MZqCbBmfer7qEG3Em/73/XOdnGAuoqsy2FRh+tXrw0H3WPADG9B7vtM
         0LD3WVaVxcOD4oj5rK4Nww75p3YrgrbUBeyhAWmfLCk38NMotQYq4efofNrhUbaA83
         0KZyr+mnYqtD45rBvEdBT1dQ7fZ0rCzER47lmd9Dq+WXihaHwsjNEPZq/hN+oqgyNl
         SrMPeLMAYRMLWNBR+8mPBVwBMIKOuXStT9ywCRQs1GNTCsPW01Hi6KAZEm5iRTFfxq
         n+TEXz/uFKLhLfGeJTx0RLfTV2aoAdvOWYP85Icc8PDfM0DFouwjrAGW1wuJZboYII
         LLw1kiNy2FT1w==
Date:   Mon, 4 Sep 2023 10:48:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: Re: [e2fsprogs PATCH] libext2fs: fix ext2fs_get_device_size2()
 return value on Windows
Message-ID: <20230904174848.GA30774@sol.localdomain>
References: <20230301034518.373859-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301034518.373859-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 28, 2023 at 07:45:18PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Creating a file system on Windows without a pre-existing file stopped
> working because the Windows version of ext2fs_get_device_size2() doesn't
> return ENOENT if the file doesn't exist.  Fix this.
> 
> Fixes: 53464654bd33 ("mke2fs: fix creating a file system image w/o a pre-existing file")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  .github/workflows/ci.yml |  1 -
>  lib/ext2fs/getsize.c     | 31 +++++++++++--------------------
>  lib/ext2fs/windows_io.c  | 11 -----------
>  3 files changed, 11 insertions(+), 32 deletions(-)

Ping.

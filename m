Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278016AFE01
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCHE4a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHE43 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:56:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BA5F6E1
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 711F461617
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 04:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF27C433EF;
        Wed,  8 Mar 2023 04:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678251387;
        bh=sEoDFlU6ygjVkObRN3oZKHbetlxhmHX0ZhumG+HuncQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ao2gYROUBq+1DCQm5a7JcWKfYilmbAtS03pL4Lb7Wx5jkGVtogBtyvIwdubmmVpFb
         X0q0+fUR2Ll3lW1III7o5wkehl0FYiMkKbG1uON3pbHX983Mo1wTPvSma2aWUH5gZM
         ehdzj5VtiieqfpXVc/xsMMYbZRHSiLQZS+WjY1JLuv0TBwduOPzNnjCNQZPimiROQE
         qRbWYO0mGGio/NhjXhD8JT1Gvk127sovg+kzNyTUasTAeHrFLIEEm20g3eo1YLACyj
         Po1AwZv50Db+qqF5RgqXYlCScX05h3qH/DoJBzNU0er6nIvziivZDfYeE9rBnWsOuG
         cbt5qLPYYRjyQ==
Date:   Tue, 7 Mar 2023 20:56:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4, jbd2: add an optimized bmap for the journal inode
Message-ID: <ZAgVej4bnMLfHKpf@sol.localdomain>
References: <20230308041615.2121699-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308041615.2121699-1-tytso@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 07, 2023 at 11:16:15PM -0500, Theodore Ts'o wrote:
> The generic bmap() function exported by the VFS takes locks and does
> checks that are not necessary for the journal inode.  So allow the
> file system to set a journal-optimized bmap function in
> journal->j_bmap.
> 
> The also has the benefit of avoiding some false positives by DEPT.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c      | 23 +++++++++++++++++++++++
>  fs/jbd2/journal.c    |  9 ++++++---
>  include/linux/jbd2.h |  8 ++++++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
> 

Should this also be marked as a fix for the syzbot report
https://syzkaller.appspot.com/bug?id=e4aaa78795e490421c79f76ec3679006c8ff4cf0 ?

- Eric

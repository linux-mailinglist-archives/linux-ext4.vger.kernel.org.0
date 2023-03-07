Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18B6AF5B9
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 20:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjCGTdO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjCGTc6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 14:32:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD884836
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 11:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC186153F
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 19:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87837C4339B;
        Tue,  7 Mar 2023 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678216741;
        bh=pVMhxVOCVu2wKjBsyLDQxo6s0xpMulCIJpHvwyK1wSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJkY32B/ZotLTQlfVbiTWqHl9qdu19evq/b4e3oKgJJzmji1mE73OgQT2dPsstU4Z
         WTW3LbsB3eNPFBdpEGJLtB3jwqByB22A00R2ve2b0HAPvfJLgu89KfG5xScD2mx7kG
         A/QWtIylishFKm1fla7CN05vPUiOtaRDSIn8mGzEokbUXLOduU+O4Y9zikuDTdugfu
         uNNcMlVjDTGNiqWMsVLpIkDOquM5sTd9Ia0MCi7snrbXdHsZ6QH/0n5CkZh4dGaSb6
         7X7XzB9iPAz0oV0GMK6Q44pEJRQ/ags5gtHITdwn0FDIquoo55yh1sLGgdVyZ7D7vC
         SuxxuWo1l58Zg==
Date:   Tue, 7 Mar 2023 19:18:47 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Fix possible corruption when moving a
 directory
Message-ID: <ZAeOFzbhCNvskQ6b@gmail.com>
References: <5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 07, 2023 at 06:56:28PM +0300, Dan Carpenter wrote:
> Hello Jan Kara,
> 
> The patch 0813299c586b: "ext4: Fix possible corruption when moving a
> directory" from Jan 26, 2023, leads to the following Smatch static
> checker warning:
> 
> 	fs/ext4/namei.c:4017 ext4_rename()
> 	error: double unlocked '&old.inode->i_rwsem' (orig line 3882)
> 
[...]
>     3875                 /*
>     3876                  * We need to protect against old.inode directory getting
>     3877                  * converted from inline directory format into a normal one.
>     3878                  */
>     3879                 inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
>     3880                 retval = ext4_rename_dir_prepare(handle, &old);
>     3881                 if (retval) {
>     3882                         inode_unlock(old.inode);
> 
> The issue here is that ext4_rename_dir_prepare() sets old.dir_bh and
> then returns -EFSCORRUPTED.  It results in an unlock here and then again
> after the goto.

That analysis looks correct.  FYI, I think this is the same as the syzbot report
"[ext4?] WARNING: bad unlock balance in ext4_rename2"
(https://lore.kernel.org/linux-ext4/000000000000435c6905f639ae8e@google.com).

- Eric

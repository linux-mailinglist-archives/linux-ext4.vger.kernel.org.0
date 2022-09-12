Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0468A5B59B2
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiILLzi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiILLzh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 07:55:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E981921815
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 04:55:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28CBtHaf031208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662983719; bh=31BOOnO/GW1+Xq5GxheeNxQGeYpx2dHT2PclO+FF8UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FxkzeA/mNEJ4nuIp6u2oWm5vf2zblZjpaDmeoPF6QoKKzCUKwkSMIDOMHxMW+S6a4
         2RRCwk6tGS6H/A7PyHY2qVklndfAdGlZFci/nEGhPFcMe03XCSrYIWH8cOsuTieHQ7
         Zwe+GIxX/zU6oR7p/rWK3ABwpy0nk/i+qVWdnkmRkQ+RLDA22NmiPFJQL/TyN0rpIq
         fRHxGMEKRPbvYXslgphBB9l7AqJQrqRBtUzXtEr8CKrXijIR+r8SLVv0pc0+8DjNsZ
         l6psHY7pLKy0u2e94AZx8s1XK6/GE3poTAvMAqn+b8WhhENfShUclnCAdB+NBq2NyD
         u6kYC1WZshFrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 99B6515C526C; Mon, 12 Sep 2022 07:55:17 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     liuzhiqiang26@huawei.com, linux-ext4@vger.kernel.org,
        adilger@whamcloud.com, zhanchengbin1@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, wuguanghao3@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] tune2fs: fix tune2fs segfault when ext2fs_run_ext3_journal() fails
Date:   Mon, 12 Sep 2022 07:55:14 -0400
Message-Id: <166298370796.2551439.6275034691916615030.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <8e87fbc3-674a-af30-1234-54b36eb5ca5d@huawei.com>
References: <8e87fbc3-674a-af30-1234-54b36eb5ca5d@huawei.com>
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

On Mon, 5 Sep 2022 19:16:03 +0800, Zhiqiang Liu wrote:
> When ext2fs_run_ext3_journal() fails, tune2fs cmd will occur one
> segfault problem as follows.
> (gdb) bt
> #0  0x00007fdadad69917 in ext2fs_mmp_stop (fs=0x0) at mmp.c:405
> #1  0x0000558fa5a9365a in main (argc=<optimized out>, argv=<optimized out>) at tune2fs.c:3440
> 
> misc/tune2fs.c:
> main()
>   -> ext2fs_open2(&fs)
>     -> ext2fs_mmp_start
>   ......
>   -> retval = ext2fs_run_ext3_journal(&fs)
>   -> if (retval)
>     // if ext2fs_run_ext3_journal fails, close and free fs.
>     -> ext2fs_close_free(&fs)
>     -> rc = 1
>     -> goto closefs
>   ......
> closefs:
>   -> if (rc)
>     -> ext2fs_mmp_stop(fs)     // fs has been set to NULL, boom!!
>   -> (ext2fs_close_free(&fs) ? 1 : 0); // close and free fs
> 
> [...]

Applied, thanks!

[1/1] tune2fs: fix tune2fs segfault when ext2fs_run_ext3_journal() fails
      commit: 66ecb6abe5d2c74191bb4bc24f3da036e5fa1213

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

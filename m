Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C666F2A1C
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjD3R7k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 13:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjD3R7h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 13:59:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B681992
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 10:59:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UHx88U016290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 13:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682877551; bh=Cfo6Mtxwx/YQNd6YUF27EOglHQTP1AmdHtP9GnLOOJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nN08k/BXDa+DS88AQwRyryJAIJiF88ubrp1BDzvjNbm+d8R7m4nmdHwSALh/fGCLT
         OUgf/8l5tB3xTZCbh6tPmZBFITHEmUO93JUlMKe6j4v0syXNppbHgg7kJE3nbzWNDl
         Qa63ELp+POI7ksQyV6W1bGDXjlCO/O2HhFX9tkFmrbjtssklFqqU7KlQaYYUT8F+F4
         PiAVeXaWqDzWN4edQ4Wh1ik3mUWSrSWjH9giFL1o41yTiLlDnmIUzcjxweDzihSDFG
         uBoIkskpNaQhoqPgMnTFQ8ad5pXHDfuuiZRWVXSFap9izDKlulRepVJK2/o8vgnzB+
         70Au+gov1ikjw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 855AA15C02E2; Sun, 30 Apr 2023 13:59:08 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, jack@suse.com, tudor.ambarus@linaro.org,
        Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2] ext4: Fix i_disksize exceeding i_size problem in paritally written case
Date:   Sun, 30 Apr 2023 13:59:05 -0400
Message-Id: <168287753833.584010.2522737520636014795.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230321013721.89818-1-chengzhihao1@huawei.com>
References: <20230321013721.89818-1-chengzhihao1@huawei.com>
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


On Tue, 21 Mar 2023 09:37:21 +0800, Zhihao Cheng wrote:
> Following process makes i_disksize exceed i_size:
> 
> generic_perform_write
>  copied = iov_iter_copy_from_user_atomic(len) // copied < len
>  ext4_da_write_end
>  | ext4_update_i_disksize
>  |  new_i_size = pos + copied;
>  |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
>  | generic_write_end
>  |  copied = block_write_end(copied, len) // copied = 0
>  |   if (unlikely(copied < len))
>  |    if (!PageUptodate(page))
>  |     copied = 0;
>  |  if (pos + copied > inode->i_size) // return false
>  if (unlikely(copied == 0))
>   goto again;
>  if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
>   status = -EFAULT;
>   break;
>  }
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix i_disksize exceeding i_size problem in paritally written case
      commit: 1dedde690303c05ef732b7c5c8356fdf60a4ade3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

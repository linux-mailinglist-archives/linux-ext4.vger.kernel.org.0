Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3141E67B
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 06:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhJAEIU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 00:08:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44036 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237049AbhJAEIS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 00:08:18 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19146MYp023241
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 00:06:23 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB7B615C34A8; Fri,  1 Oct 2021 00:06:22 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.cz, yangerkun <yangerkun@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: update last_pos for the case ext4_htree_fill_tree return fail
Date:   Fri,  1 Oct 2021 00:06:21 -0400
Message-Id: <163306112497.261665.422355129148748890.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210914111415.3921954-1-yangerkun@huawei.com>
References: <20210914111415.3921954-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 14 Sep 2021 19:14:15 +0800, yangerkun wrote:
> Or the ls for ext4 dir can run into a deadloop since info->last_pos !=
> ctx->pos which will reset the world and start read the entry which has
> already got before. Details see below:
> 
> 1. a dx_dir which has 3 block, block 0 as dx_root block, block 1/2 as
>    leaf block which own the ext4_dir_entry_2
> 2. block 1 read ok and call_filldir which will fill the dirent and update
>    the ctx->pos
> 3. block 2 read fail, but we has already fill some dirent, so we will
>    return back to userspace will a positive return val(see ksys_getdents64)
> 4. the second ext4_dx_readdir will reset the world since info->last_pos
>    != ctx->pos, and will also init the curr_hash which pos to block 1
> 5. So we will read block1 too, and once block2 still read fail, we can
>    only fill one dirent because the hash of the entry in block1(besides
>    the last one) won't greater than curr_hash
> 6. this time, we forget update last_pos too since the read for block2
>    will fail, and since we has got the one entry, ksys_getdents64 can
>    return success
> 7. Latter we will trapped in a loop with step 4~6
> 
> [...]

I rewrote the patch summary and the first paragraph to improve the
English:

    ext4: fix potential infinite loop in ext4_dx_readdir()
    
    When ext4_htree_fill_tree() fails, ext4_dx_readdir() can run into an
    infinite loop since if info->last_pos != ctx->pos this will reset the
    directory scan and reread the failing entry.  For example:

Applied, thanks!

[1/1] ext4: update last_pos for the case ext4_htree_fill_tree return fail
      commit: 42cb447410d024e9d54139ae9c21ea132a8c384c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7470B405BC9
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Sep 2021 19:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhIIRLj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Sep 2021 13:11:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59253 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237002AbhIIRLi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Sep 2021 13:11:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 189HAIdM030914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Sep 2021 13:10:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 241D415C33EC; Thu,  9 Sep 2021 13:10:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Hou Tao <houtao1@huawei.com>,
        harshadshirwadkar@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: limit the number of blocks in one ADD_RANGE TLV
Date:   Thu,  9 Sep 2021 13:10:16 -0400
Message-Id: <163120740355.1583335.70349130473503343.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210820044505.474318-1-houtao1@huawei.com>
References: <20210820044505.474318-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 20 Aug 2021 12:45:05 +0800, Hou Tao wrote:
> Now EXT4_FC_TAG_ADD_RANGE uses ext4_extent to track the
> newly-added blocks, but the limit on the max value of
> ee_len field is ignored, and it can lead to BUG_ON as
> shown below when running command "fallocate -l 128M file"
> on a fast_commit-enabled fs:
> 
>   kernel BUG at fs/ext4/ext4_extents.h:199!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 3 PID: 624 Comm: fallocate Not tainted 5.14.0-rc6+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   RIP: 0010:ext4_fc_write_inode_data+0x1f3/0x200
>   Call Trace:
>    ? ext4_fc_write_inode+0xf2/0x150
>    ext4_fc_commit+0x93b/0xa00
>    ? ext4_fallocate+0x1ad/0x10d0
>    ext4_sync_file+0x157/0x340
>    ? ext4_sync_file+0x157/0x340
>    vfs_fsync_range+0x49/0x80
>    do_fsync+0x3d/0x70
>    __x64_sys_fsync+0x14/0x20
>    do_syscall_64+0x3b/0xc0
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [...]

Applied, thanks!

[1/1] ext4: limit the number of blocks in one ADD_RANGE TLV
      commit: af8137dff33d975ac84c8a5f63e057b2d0405fc3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

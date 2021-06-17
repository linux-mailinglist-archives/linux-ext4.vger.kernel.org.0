Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664773AB67A
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhFQOw0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 10:52:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48344 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231303AbhFQOw0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 10:52:26 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15HEo3d3005520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 10:50:03 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DB47C15C3CB8; Thu, 17 Jun 2021 10:50:02 -0400 (EDT)
Date:   Thu, 17 Jun 2021 10:50:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: cleanup in-core orphan list if ext4_truncate()
 failed to get a transaction handle
Message-ID: <YMthGuTCuRlZ/zL0@mit.edu>
References: <20210507071904.160808-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507071904.160808-1-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 07, 2021 at 03:19:04PM +0800, Zhang Yi wrote:
> In ext4_orphan_cleanup(), if ext4_truncate() failed to get a transaction
> handle, it didn't remove the inode from the in-core orphan list, which
> may probably trigger below error dump in ext4_destroy_inode() during the
> final iput() and could lead to memory corruption on the later orphan
> list changes.
> 
>  EXT4-fs (sda): Inode 6291467 (00000000b8247c67): orphan list check failed!
>  00000000b8247c67: 0001f30a 00000004 00000000 00000023  ............#...
>  00000000e24cde71: 00000006 014082a3 00000000 00000000  ......@.........
>  0000000072c6a5ee: 00000000 00000000 00000000 00000000  ................
>  ...
> 
> This patch fix this by cleanup in-core orphan list manually if
> ext4_truncate() return error.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Applied, thanks.

					- Ted

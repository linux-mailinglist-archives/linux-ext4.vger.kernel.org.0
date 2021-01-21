Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1C2FF06B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 17:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbhAUQeX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 11:34:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59095 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732591AbhAUP7A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 10:59:00 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LFw3Vb004705
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 10:58:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 37B4B15C35F5; Thu, 21 Jan 2021 10:58:03 -0500 (EST)
Date:   Thu, 21 Jan 2021 10:58:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/15] e2fsprogs: make userspace tools number of fast
 commits blocks aware
Message-ID: <YAmki3FAmXhgK/SH@mit.edu>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
 <20210120212641.526556-6-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212641.526556-6-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 20, 2021 at 01:26:31PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch makes number of fast commit blocks configurable. Also, the
> number of fast commit blocks can now be seen in dumpe2fs output.
> 
> $ ./misc/mke2fs -O fast_commit -t ext4 image
> mke2fs 1.46-WIP (20-Mar-2020)
> Discarding device blocks: done
> Creating filesystem with 5120 1k blocks and 1280 inodes
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (1040 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> $ ./misc/dumpe2fs image
> dumpe2fs 1.46-WIP (20-Mar-2020)
> ...
> Journal features:         (none)
> Total journal size:       1040k
> Total journal blocks:     1040
> Max transaction length:   1024
> Fast commit length:       16
> Journal sequence:         0x00000001
> Journal start:            0
> 
> $ ./misc/mke2fs -O fast_commit -t ext4 image -J fast_commit_size=256,size=1
> mke2fs 1.46-WIP (20-Mar-2020)
> Creating filesystem with 5120 1k blocks and 1280 inodes
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (1280 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> $ ./misc/dumpe2fs image
> dumpe2fs 1.46-WIP (20-Mar-2020)
> ...
> Journal features:         (none)
> Total journal size:       1280k
> Total journal blocks:     1280
> Max transaction length:   1024
> Fast commit length:       256
> Journal sequence:         0x00000001
> Journal start:            0
> 
> This patch also adds information about fast commit feature in mke2fs
> and tune2fs man pages.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

						- Ted

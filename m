Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1423ED8C4
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhHPORD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 10:17:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39880 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230094AbhHPORC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 10:17:02 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17GEGGSQ005364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 10:16:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 83F9D15C3DB9; Mon, 16 Aug 2021 10:16:16 -0400 (EDT)
Date:   Mon, 16 Aug 2021 10:16:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yangerkun <yangerkun@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: stop return ENOSPC from ext4_issue_zeroout
Message-ID: <YRpzMK6tj0BBlDK8@mit.edu>
References: <20210804125044.2480435-1-yangerkun@huawei.com>
 <20210804133529.GE4578@quack2.suse.cz>
 <YRaNKc2PvM+Eyzmp@mit.edu>
 <20210816100545.GF24793@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816100545.GF24793@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 16, 2021 at 12:05:45PM +0200, Jan Kara wrote:
> 
> Yes, that looks indeed better. I'd note that even splitting extent may fail
> due to ENOSPC on thin-provisioned storage but the chances are *much* lower.

Indeed, any kind of metadata update (updating an inode atime, creating
a new inode, deleting a directory entry, etc.) can fail due to ENOSPC
on thin-provision storage, leading to a potentially corrupted file
system since some writes will succeed, while others won't --- and
that's not a scenario that's super well tested, nor is there much we
can do other than remounting the file system read/only or forcing a
reboot.

But at least we won't throw the kernel into an infinite loop, which is
what yangerkun was reporting...

					- Ted

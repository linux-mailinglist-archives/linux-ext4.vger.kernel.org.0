Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599603ED174
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhHPJ7P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 05:59:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45430 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbhHPJ7O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 05:59:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B6241FEB2;
        Mon, 16 Aug 2021 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629107922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lDKlKWynmBimGUwPu9TDHZsttA777QT2DlXQTzT2IcY=;
        b=zQpefJyU4bMfnXrOIp77Rv4QbiWR76k3wlQgbRGKc3nARGPn8rEg6nP3Wz4861agJZpL7y
        qnfL0k4xcFvZxGQKy5GXSoZtQvSlReiA98f6V/uiljB/ViJ6gJKhL8YVMWKqxfVRe4M3YH
        6eNievjoQoRvk5RcFA9pl+T52PXm4ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629107922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lDKlKWynmBimGUwPu9TDHZsttA777QT2DlXQTzT2IcY=;
        b=A5VHHBf/KE62mbXMNMF0zWV5wCb4svdavL49ErhVd3v+OfYpbID3RH2vWT5K+ug4hK89Hz
        HqVabgSTVA5rzcBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 3DDA8A3B87;
        Mon, 16 Aug 2021 09:58:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 14C001E0426; Mon, 16 Aug 2021 11:58:42 +0200 (CEST)
Date:   Mon, 16 Aug 2021 11:58:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/5 v6] ext4: Speedup orphan file handling
Message-ID: <20210816095842.GE24793@quack2.suse.cz>
References: <20210816091810.16994-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816091810.16994-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

please disregard this version. I forgot to include a fix we talked about at
the last ext4 call, namely to check that orphan file is not linked from
directory hierarchy. I've submitted v7 now with that fix included.

								Honza

On Mon 16-08-21 11:22:58, Jan Kara wrote:
>   Hello,
> 
> Here is a fourth version of my series to speed up orphan inode handling in
> ext4.
> 
> Orphan inode handling in ext4 is a bottleneck for workloads which heavily
> excercise truncate / unlink of small files as they contend on global
> s_orphan_mutex (when you have fast enough storage). This patch set implements
> new way of handling orphan inodes - instead of using a linked list, we store
> inode numbers of orphaned inodes in a file which is possible to implement in a
> more scalable manner than linked list manipulations. See description of patch
> 3/5 for more details.
> 
> The patch set achieves significant gains both for a micro benchmark stressing
> orphan inode handling (truncating file byte-by-byte, several threads in
> parallel) and for reaim creat_clo workload. I'm happy for any review, thoughts,
> ideas about the patches. I have also implemented full support in e2fsprogs
> which I'll send separately.
> 
> 								Honza
> 
> [1] https://lore.kernel.org/lkml/20210227120804.GB22871@xsang-OptiPlex-9020/
> 
> Changes since v5:
> * Added Reviewed-by tags from Ted
> * Fixed up sparse warning spotted by 0-day
> * Fixed error handling path in ext4_orphan_add() to not leak orphan entry
> 
> Changes since v4:
> * Rebased on top of v5.14-rc5
> * Updated commit message of patch 1/5
> * Added Reviewed-by tags from Ted
> 
> Changes since v3:
> * Added documentation about on-disk format changes
> * Add physical block number into orphan block checksum
> * Improve some sanity checks, handling of corrupted orphan file
> * Improved some changelogs
> 
> Changes since v2:
> * Updated some comments
> * Rebased onto 5.13-rc5
> * Change orphan file inode from a fixed inode number to inode number stored
>   in the superblock
> 
> Changes since v1:
> * orphan blocks have now magic numbers
> * split out orphan handling to a separate source file
> * some smaller updates according to review
> 
> Previous versions:
> Link: http://lore.kernel.org/r/20210811101006.2033-1-jack@suse.cz # v5
> Link: https://lore.kernel.org/linux-ext4/20210712154009.9290-1-jack@suse.cz/ #v4
> Link: https://lore.kernel.org/linux-ext4/20210616105655.5129-1-jack@suse.cz/ #v3
> Link: https://lore.kernel.org/linux-ext4/1432293717-24010-1-git-send-email-jack@suse.cz/ #v2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

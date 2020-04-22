Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77901B4951
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDVQAs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 12:00:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgDVQAr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 12:00:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C067EAC52;
        Wed, 22 Apr 2020 16:00:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F3FB41E0E56; Wed, 22 Apr 2020 18:00:45 +0200 (CEST)
Date:   Wed, 22 Apr 2020 18:00:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Inline data with 128-byte inodes?
Message-ID: <20200422160045.GC20756@quack2.suse.cz>
References: <20200414070207.GA170659@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414070207.GA170659@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-04-20 00:02:07, Josh Triplett wrote:
> Is there a fundamental reason that ext4 *can't* or *shouldn't* support
> inline data with 128-byte inodes?

Well, where would we put it on disk? ext4 on-disk inode fills 128-bytes
with 'osd2' union...

Or do you mean we should put inline data in an external xattr block?

								Honza

> As far as I can tell, the kernel ext4 implementation only allows inline
> data with 256-byte or larger inodes, because it requires the system.data
> xattr to exist, even if the actual data requires 60 bytes or less. (The
> implementation in debugfs, on the other hand, handles inline data in
> 128-byte inodes just fine. And it seems like it'd be fairly
> straightforward to change the kernel implementation to support it as
> well.)
> 
> For filesystems that don't need to store xattrs in general, and can live
> with the other limitations of 128-byte inodes, using a 128-byte inode
> can save substantial space compared to a 256-byte inode (many megabytes
> worth of inode tables, versus 4k for each file between 61-160 bytes),
> and many small files or small directories would still fit in 60 bytes.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

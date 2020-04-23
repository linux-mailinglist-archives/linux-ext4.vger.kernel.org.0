Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDA1B5AE2
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgDWL4h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 07:56:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgDWL4g (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 07:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB138AD2A;
        Thu, 23 Apr 2020 11:56:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A6081E1293; Thu, 23 Apr 2020 13:56:34 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:56:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Inline data with 128-byte inodes?
Message-ID: <20200423115634.GN3737@quack2.suse.cz>
References: <20200414070207.GA170659@localhost>
 <20200422160045.GC20756@quack2.suse.cz>
 <331CEA49-83E0-462C-A70D-479F17A4FAB2@dilger.ca>
 <20200423004033.GA161058@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423004033.GA161058@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-04-20 17:40:33, Josh Triplett wrote:
> On Wed, Apr 22, 2020 at 02:15:28PM -0600, Andreas Dilger wrote:
> > On Apr 22, 2020, at 10:00 AM, Jan Kara <jack@suse.cz> wrote:
> > > On Tue 14-04-20 00:02:07, Josh Triplett wrote:
> > >> Is there a fundamental reason that ext4 *can't* or *shouldn't* support
> > >> inline data with 128-byte inodes?
> > > 
> > > Well, where would we put it on disk? ext4 on-disk inode fills 128-bytes
> > > with 'osd2' union...
> > 
> > There are 60 bytes in the "i_block" field that can be used by inline_data.
> 
> Exactly. But the Linux ext4 implementation doesn't accept inline data
> unless the system.data xattr exists, even if the file's data fits in 60
> bytes (in which case system.data must exist and have 0 length).

I see now I understand what you meant. Thanks for explanation.

> > Maybe there is a bigger win for small directories avoiding 4KB leaf blocks?
> >
> > That said, I'd be happy to see some numbers to show this is a win, and
> > I'm definitely not _against_ allowing this to work if there is a use for it.
> 
> Some statistics, for ext4 with 4k blocks and 128-byte inodes, if 60-byte
> inline data worked with 128-byte inodes:
> 
> A filesystem containing the source code of the Linux kernel would
> save about 1508 disk blocks, or around 6032k.
> 
> A filesystem containing only my /etc directory would save about 650
> blocks, or 2600k, a substantial fraction of the entire directory (which
> takes up 9004k total without inline data).

I guess few people care about a few megabytes these days... For really
space sensitive applications, people don't pick ext4 as a base filesystem
I'd guess (I'd expect squashfs, erofs, or ubifs if you need write access).
So the benefit is relatively small, the question about the cost is - how
complicated it gets to support inline data without xattrs?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

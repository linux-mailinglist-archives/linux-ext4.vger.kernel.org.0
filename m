Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F61B5172
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWAkl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 20:40:41 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59541 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDWAkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Apr 2020 20:40:41 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 331BEFF802;
        Thu, 23 Apr 2020 00:40:37 +0000 (UTC)
Date:   Wed, 22 Apr 2020 17:40:33 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Inline data with 128-byte inodes?
Message-ID: <20200423004033.GA161058@localhost>
References: <20200414070207.GA170659@localhost>
 <20200422160045.GC20756@quack2.suse.cz>
 <331CEA49-83E0-462C-A70D-479F17A4FAB2@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <331CEA49-83E0-462C-A70D-479F17A4FAB2@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 22, 2020 at 02:15:28PM -0600, Andreas Dilger wrote:
> On Apr 22, 2020, at 10:00 AM, Jan Kara <jack@suse.cz> wrote:
> > On Tue 14-04-20 00:02:07, Josh Triplett wrote:
> >> Is there a fundamental reason that ext4 *can't* or *shouldn't* support
> >> inline data with 128-byte inodes?
> > 
> > Well, where would we put it on disk? ext4 on-disk inode fills 128-bytes
> > with 'osd2' union...
> 
> There are 60 bytes in the "i_block" field that can be used by inline_data.

Exactly. But the Linux ext4 implementation doesn't accept inline data
unless the system.data xattr exists, even if the file's data fits in 60
bytes (in which case system.data must exist and have 0 length).

> > Or do you mean we should put inline data in an external xattr block?

Definitely not, no. That seems much more complex to deal with.

I'm only talking about the case of files or directories <= 60 bytes
fitting in the inode with 128-byte inodes. Effectively, this would mean
accepting inodes with the inline data flag set, whether they have the
system.data xattr or not.

> Maybe there is a bigger win for small directories avoiding 4KB leaf blocks?
>
> That said, I'd be happy to see some numbers to show this is a win, and
> I'm definitely not _against_ allowing this to work if there is a use for it.

Some statistics, for ext4 with 4k blocks and 128-byte inodes, if 60-byte
inline data worked with 128-byte inodes:

A filesystem containing the source code of the Linux kernel would
save about 1508 disk blocks, or around 6032k.

A filesystem containing only my /etc directory would save about 650
blocks, or 2600k, a substantial fraction of the entire directory (which
takes up 9004k total without inline data).

- Josh Triplett

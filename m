Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5834EF27
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhC3RP2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 13:15:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42803 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231808AbhC3RPN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Mar 2021 13:15:13 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12UHF8Rl016621
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:15:08 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3B01A15C39CD; Tue, 30 Mar 2021 13:15:08 -0400 (EDT)
Date:   Tue, 30 Mar 2021 13:15:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: add ioctl EXT4_FLUSH_JOURNAL
Message-ID: <YGNcnJpqUqrwbMAH@mit.edu>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <20210325181220.1118705-2-leah.rumancik@gmail.com>
 <20210326012146.GB22091@magnolia>
 <YGHtC4vEWcRervi1@google.com>
 <CAD+ocbx-DZprEvzSQ2+rVFz6CPJy0iYbG60SGZHpi+ZX8ecqhg@mail.gmail.com>
 <20210330163223.GD22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330163223.GD22091@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 30, 2021 at 09:32:23AM -0700, Darrick J. Wong wrote:
> Why not make discarding the journal part of FITRIM then?

Unfortunately, the fstrim_range structure doesn't have a place for a
flags field, and FITRIM works by specifying a range of LBA's:

struct fstrim_range {
	__u64 start;
	__u64 len;
	__u64 minlen;
};

I suppose we could do something where some combination of start/len
means "also checkpoint and discard the journal", but that seems rather
kludgy.

> It occurred to me overnight that another way to look at this ioctl
> proposal is that it checkpoints the filesystem and has a flag to discard
> the journal blocks too.  Given that we're now only two days away from
> my traditional bootfs[1] drum-banging day, and there's real user
> demand[2] for bootloaders to be able to force a journal checkpoint,

How about if we have an ioctl which is "checkpoint journal", which can
be file system independent (e.g., defined in include/uapi/linux/fs.h)
which takes a u32 flags field, where we define a flag bit to mean
"also discard the unused part of the journal after the checkpoint"?

It seems that would also solve your bootfs() use case.

      	      	  	      	     - Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6B3DF439
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhHCR6K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 13:58:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49533 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233446AbhHCR6J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 13:58:09 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 173HvroX027891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 13:57:53 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3F5DF15C37C1; Tue,  3 Aug 2021 13:57:53 -0400 (EDT)
Date:   Tue, 3 Aug 2021 13:57:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] libext2fs: Support for orphan file feature
Message-ID: <YQmDoXZSPjY7xq12@mit.edu>
References: <20210616105735.5424-1-jack@suse.cz>
 <20210616105735.5424-5-jack@suse.cz>
 <YQl+u2HwLV3f6cUE@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQl+u2HwLV3f6cUE@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 03, 2021 at 01:36:59PM -0400, Theodore Ts'o wrote:
> On Mon, Jul 12, 2021 at 05:43:10PM +0200, Jan Kara wrote:
> > @@ -825,6 +826,7 @@ struct ext2_super_block {
> >  #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM		0x0010
> >  #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK	0x0020
> >  #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE	0x0040
> > +#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x0080
> >  #define EXT4_FEATURE_RO_COMPAT_QUOTA		0x0100
> >  #define EXT4_FEATURE_RO_COMPAT_BIGALLOC		0x0200
> 
> (This isn't a full review of the patch, but just a quick feedback of
> what I've noticed so far.)
> 
> Since Andreas has requested that we not get rid of the
> RO_COMPAT_SNAPSHOT, I'm using 0x10000 for
> EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT in my testing.
> 
> I also noted a number of new GCC warnings when running "make gcc-wall"
> on lib/ext2fs after applying this commit.

Sorry, I just realized I had used b4 to grab the v3 instead of the v4
of the patch series.  Fortunately it looks like the 2nd and 3rd
patches hadn't changed between the two patch series, so I'll regroup
and try again this time with the v4 patches.

					- Ted

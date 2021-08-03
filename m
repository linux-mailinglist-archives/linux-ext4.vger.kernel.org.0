Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D963DF406
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 19:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhHCRkx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 13:40:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47080 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238286AbhHCRkw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 13:40:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 173HebQc022166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 13:40:37 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A3CF15C37C1; Tue,  3 Aug 2021 13:40:37 -0400 (EDT)
Date:   Tue, 3 Aug 2021 13:40:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] libext2fs: Support for orphan file feature
Message-ID: <YQl/lYKtH747bMJd@mit.edu>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-5-jack@suse.cz>
 <YQl1gGwVSB5+IMCW@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQl1gGwVSB5+IMCW@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 03, 2021 at 12:57:36PM -0400, Theodore Ts'o wrote:
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
> RO_COMPAT_SNAPSHOT, I'm using 0x0400 for
> EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT in my testing.

Correction, this should have been 0x10000.

					- Ted

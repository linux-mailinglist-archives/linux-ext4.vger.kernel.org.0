Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4121641AA
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSKXG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 05:23:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:53182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSKXF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Feb 2020 05:23:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9E9BB296;
        Wed, 19 Feb 2020 10:23:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D4D371E0EB5; Wed, 19 Feb 2020 11:23:03 +0100 (CET)
Date:   Wed, 19 Feb 2020 11:23:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] tune2fs: Update dir checksums when clearing
 dir_index feature
Message-ID: <20200219102303.GL16121@quack2.suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-8-jack@suse.cz>
 <7BA5024A-9600-4D2E-8D23-7A0F900BFE7F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7BA5024A-9600-4D2E-8D23-7A0F900BFE7F@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 18-02-20 13:50:33, Andreas Dilger wrote:
> On Feb 13, 2020, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > When clearing dir_index feature while metadata_csum is enabled, we have
> > to rewrite checksums of all indexed directories to update checksums of
> > internal tree nodes.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > 
> > +#define REWRITE_EA_FL		0x01	/* Rewrite EA inodes */
> > +#define REWRITE_DIR_FL		0x02	/* Rewrite directories */
> > +#define REWRITE_NONDIR_FL	0x04	/* Rewrite other inodes */
> > +#define REWRITE_ALL (REWRITE_EA_FL | REWRITE_DIR_FL | REWRITE_NONDIR_FL)
> > +
> > +static void rewrite_inodes_pass(struct rewrite_context *ctx, unsigned int flags)
> > {
> 
> My preference these days is to put constants like the above into a named
> enum, and then use the enum as the argument to the function rather than
> a very generic "int flags" argument.  That makes it clear to the reader
> what values the flags may hold, and can immediately tag to the enum, like:
> 
> enum rewrite_inodes_flags {
> 	REWRITE_EA_FL	  = 0x01	/* Rewrite EA inodes */
> 	REWRITE_DIR_FL	  = 0x02	/* Rewrite directories */
> 	REWRITE_NONDIR_FL = 0x04	/* Rewrite other inodes */
> 	REWRITE_ALL	  = REWRITE_EA_FL | REWRITE_DIR_FL | REWRITE_NONDIR_FL
> };
> 
> static void rewrite_inodes_pass(struct rewrite_context *ctx,
> 				enum rewrite_inodes_flags rif_flags)
> static void rewrite_inodes(ext2_filsys fs, enum rewrite_inodes_flags rif_flags)
> static void rewrite_metadata_checksums(ext2_filsys fs,
> 				       enum rewrite_inodes_flags rif_flags)
> 
> Otherwise, when looking at a function that takes "int flags" as an argument,
> you have to dig through the code to see what kind of flags these are, and
> what possible values they might have.  This is often even more confusing when
> there are multiple different kinds of flags accessed within a single function
> (not the case here, but happens often enough).
> 
> I'm not _against_ the patch, just thought I'd suggest an improvement and see
> what people think about it.

Yeah, the documentation with enum type is nice. What I somewhat dislike is
that enum suggests 'enumeration' but we actually use values (like say
REWRITE_EA_FL | REWRITE_DIR_FL) which are not really enumerated in the type
definitition. So your scheme works only because enum in C is just an int
with a lipstick on it. So I'm somewhat undecided. Ted, what's your opinion
on this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

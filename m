Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1C375E8E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 03:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhEGBvz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 21:51:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41950 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231288AbhEGBvz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 21:51:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1471olt9020269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 May 2021 21:50:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ABF1115C39BD; Thu,  6 May 2021 21:50:47 -0400 (EDT)
Date:   Thu, 6 May 2021 21:50:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH -v2] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJSc94McB5ls4OGl@mit.edu>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <20210506183017.208802-1-tytso@mit.edu>
 <CAD+ocbzOq6kSihnMSEEz4fFu2fMHwy7-aViBk_V2AC36=NAHJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzOq6kSihnMSEEz4fFu2fMHwy7-aViBk_V2AC36=NAHJQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 06, 2021 at 04:30:39PM -0700, harshad shirwadkar wrote:
> > -static inline void tl_to_darg(struct dentry_info_args *darg,
> > +static inline int tl_to_darg(struct dentry_info_args *darg,
> >                                 struct  ext4_fc_tl *tl)
> >  {
> > -       struct ext4_fc_dentry_info *fcd;
> > +       struct ext4_fc_dentry_info fcd;
> >         int tag = le16_to_cpu(tl->fc_tag);
> The above line where we dereference tl, this can also result in
> unaligned accesses. So, we need to do memcpy stuff for "tl" too.
> Changing all access of tl to a memcpy-ed local variable is itself a
> big change which I'll send along with your patch.

Ah, I didn't realize that 16-bit shorts could be misaligned.  With the
jbd2 checksum v2, that wasn't an issue, since the entries were always
an even number of bytes, so it was only the 32-bit accesses that were
problematic.  But yeah, if the dentry is an odd number of bytes, we're
not padding that out.

> >
> > -       fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
> > +       memcpy(&fcd, ext4_fc_tag_val(tl), sizeof(fcd));
> 
> If we do the memcpy fix here, ext4_fc_tag_val macro becomes unusable -
> since at this point that macro just does (tl + 1), which will fail on
> a memcpy-ed version of "tl".

Well, we can make define them as:

/* Get length of a particular tlv */
static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
{
	__u8 *p = (__u8 *) tl;
	
	return *cp + (*(cp+1) << 8);
}

/* Get a pointer to "value" of a tlv */
static inline __u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
{
	__u8 *p = ((__u8 *) tl) + 2;

	return *cp + (*(cp+1) << 8);
}

> Interesting bit is that even the kernel does these kinds of accesses
> in the recovery code. I have a suspicion that these unaligned accesses
> are the reason why you see failures on sparc?

Yeah, it could be that arm allows unaligned 16-bit dereferences, which
is why this isn't blowing up on armhf and armel.

But at least with this patch, armhf and armel builds aren't blowing
up, and UBSAN is happy.  (Although I wonder why UBSAN isn't
complaining about the unaligned 16-bit dereferences.)

					- Ted

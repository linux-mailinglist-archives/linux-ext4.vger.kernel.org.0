Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8F88726
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Aug 2019 02:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfHJAMw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 20:12:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49111 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725985AbfHJAMw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 20:12:52 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-107.corp.google.com [104.133.0.107] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7A0ClWo011033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Aug 2019 20:12:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 843814218EF; Fri,  9 Aug 2019 20:12:47 -0400 (EDT)
Date:   Fri, 9 Aug 2019 20:12:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: add a new ioctl EXT4_IOC_GETSTATE
Message-ID: <20190810001247.GA8368@mit.edu>
References: <20190809181831.10618-1-tytso@mit.edu>
 <20190809181831.10618-3-tytso@mit.edu>
 <20190809191810.GA100971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809191810.GA100971@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 09, 2019 at 12:18:12PM -0700, Eric Biggers wrote:
> On Fri, Aug 09, 2019 at 02:18:31PM -0400, Theodore Ts'o wrote:
> > The new ioctl EXT4_IOC_GETSTATE returns some of the dynamic state of
> > an ext4 inode for debugging purposes.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  fs/ext4/ext4.h  | 11 +++++++++++
> >  fs/ext4/ioctl.c | 17 +++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index f6c305b43ffa..58b7a0905186 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -651,6 +651,7 @@ enum {
> >  #define EXT4_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
> >  /* ioctl codes 19--2F are reserved for fscrypt */
> >  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 30)
> > +#define EXT4_IOC_GETSTATE		_IOW('f', 30, __u32)
> 
> 30 == 0x1e overlaps with the range claimed to be reserved for fscrypt.
> 
> Also, these two new ioctls are both number 30, which means they can't be
> controlled separately by SELinux, which only looks at the number.

Yeah, that was my screw up.  The range reservation for fscrypt was
intended to be in decimal starting with 19 decimal
(FSIOC_SET_ENCRYPTION_POLICY), and I believe with the new key
management we were up to 26?  So If I reserve up to 39, that should be
more than enough, do you agree?

I'll then make EXT4_IOC_CLEAR_ES_CACHE 40 and EXT4_IOC_GETSTATE 41.

If we're in agreement, then I'll add an update to
Documentation/ioctl/ioctl-number.rst, which is badly out of date with
respect to the ioctl's used in ext2 and ext4 (and of course ext3 has
since been removed from the kernel tree).

						- Ted

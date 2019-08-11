Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF08948B
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Aug 2019 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHKVij (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Aug 2019 17:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfHKVij (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 11 Aug 2019 17:38:39 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F97D20818;
        Sun, 11 Aug 2019 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565559518;
        bh=Xt0zOe7IEW2PG4s/iWXi34aido9GQCA7atTCsk9jdUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPrOx+oTrgHzpMMpiuuFx/k5RJaQzNUFjzCl8z00hmwqWobKn1JgRGaXD8KQgpbc/
         EMDD25u7SOEqr3af1TiKXcsVvjtGDBduPvIbgTu+5NmvobBPyAmInkhxVTSnRah7AX
         NieshBvWevxQVSPwyfADO2fvHrLuoaOTtjzSZEM4=
Date:   Sun, 11 Aug 2019 14:38:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] ext4: add a new ioctl EXT4_IOC_GETSTATE
Message-ID: <20190811213836.GA17882@sol.localdomain>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20190809181831.10618-1-tytso@mit.edu>
 <20190809181831.10618-3-tytso@mit.edu>
 <20190809191810.GA100971@gmail.com>
 <20190810001247.GA8368@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810001247.GA8368@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 09, 2019 at 08:12:47PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Aug 09, 2019 at 12:18:12PM -0700, Eric Biggers wrote:
> > On Fri, Aug 09, 2019 at 02:18:31PM -0400, Theodore Ts'o wrote:
> > > The new ioctl EXT4_IOC_GETSTATE returns some of the dynamic state of
> > > an ext4 inode for debugging purposes.
> > > 
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > > ---
> > >  fs/ext4/ext4.h  | 11 +++++++++++
> > >  fs/ext4/ioctl.c | 17 +++++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > > 
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index f6c305b43ffa..58b7a0905186 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -651,6 +651,7 @@ enum {
> > >  #define EXT4_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
> > >  /* ioctl codes 19--2F are reserved for fscrypt */
> > >  #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 30)
> > > +#define EXT4_IOC_GETSTATE		_IOW('f', 30, __u32)
> > 
> > 30 == 0x1e overlaps with the range claimed to be reserved for fscrypt.
> > 
> > Also, these two new ioctls are both number 30, which means they can't be
> > controlled separately by SELinux, which only looks at the number.
> 
> Yeah, that was my screw up.  The range reservation for fscrypt was
> intended to be in decimal starting with 19 decimal
> (FSIOC_SET_ENCRYPTION_POLICY), and I believe with the new key
> management we were up to 26?  So If I reserve up to 39, that should be
> more than enough, do you agree?
> 
> I'll then make EXT4_IOC_CLEAR_ES_CACHE 40 and EXT4_IOC_GETSTATE 41.
> 
> If we're in agreement, then I'll add an update to
> Documentation/ioctl/ioctl-number.rst, which is badly out of date with
> respect to the ioctl's used in ext2 and ext4 (and of course ext3 has
> since been removed from the kernel tree).
> 

Sounds good to me.

- Eric

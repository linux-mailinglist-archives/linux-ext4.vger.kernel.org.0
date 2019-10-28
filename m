Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902C1E7A33
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2019 21:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbfJ1Ugy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Oct 2019 16:36:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42975 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfJ1Ugy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Oct 2019 16:36:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id f14so7721194pgi.9
        for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2019 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6PsAZcqr3oYV/o2k3hxPPelLIbfYqfer30lzZ2BFcY=;
        b=f3VmmWddgpdgU1E2UCNM6eeKOTtiJc5S/WhchNMLI5+X2wZnW9VV7dIuMrLtVqgbCp
         3BgMn1u5QY7aawnMiX4U2V3+csgO1ddnLgMGs45jvCPBhTUYdLws5/INzy0HXDlnfXzs
         cCecLkqEbQog15uiini90A1DiwZwB6YEsntBIWrvC8Z+JOxiDDMI4s/xaZwf2/VRisSP
         g1XL9Cs7hrDb9GXQtGrAHu5wTlTR8H7Uby5nTi4fWqesFvXbqLywvWw8fh4Kd9XteNgB
         rbVEl0TKeDnR3C69L9uYHObsb29GV6b2XZgyHuIaYInOIEAFh7Yd5Z9uHavd4omQm3nZ
         aIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6PsAZcqr3oYV/o2k3hxPPelLIbfYqfer30lzZ2BFcY=;
        b=jpfHjKxmeRJSUW/Evgvu8BLFhq809g2W4qtoaJOGJ+bAcBXZyVgl5lgVc0LymWBN1x
         nhSmhEGM8rG/rGHhNUpP5p90Vot+mgmEuyTduMLlX4TCkAFAplOpLo6VrbWdB0LwNdMr
         kLMVOxJV1oZEyY9/rpWlzaDrW9cIgMBaqPiE+o3lvO4RnoJohBB83Y0oxk7lKwj3cyfP
         gck7ZoXmdo66E4jVIVPlzJCoJULHa/jMI+8/rUQkEwKVHETn9bOCH5zg2A7ztJaiZ6mc
         ekTUUanuC+YuGhUfgsRpdw8qpzlPiTmeTI6wsZ6jxyxmgNudse/ohS4BPqh1fJyHeWLo
         iO7w==
X-Gm-Message-State: APjAAAXD70zo9UpYoV0XfTCDiro6Mg7fG36fIee6DidnYZ+Et02v75TR
        nSSxhhpIu2/Srk3oyzsApdmc
X-Google-Smtp-Source: APXvYqy9yZPBfvOSWcmpa0LDyHMOrbfsD6MZFeQ64kJK2fev3biiGJx2YcU9F+nJP8Q8l8tAG03+ow==
X-Received: by 2002:a62:7c91:: with SMTP id x139mr13910960pfc.119.1572295008612;
        Mon, 28 Oct 2019 13:36:48 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id c14sm12887423pfm.179.2019.10.28.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:36:47 -0700 (PDT)
Date:   Tue, 29 Oct 2019 07:36:41 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
Subject: Re: [PATCH v6 04/11] ext4: move set iomap routines into a separate
 helper ext4_set_iomap()
Message-ID: <20191028203641.GA25021@bobrowski>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <36c0b0028215ed0a39697512054f3fa4799b0701.1572255425.git.mbobrowski@mbobrowski.org>
 <20191028170348.GA15203@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028170348.GA15203@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 28, 2019 at 10:03:48AM -0700, Darrick J. Wong wrote:
> On Mon, Oct 28, 2019 at 09:51:31PM +1100, Matthew Bobrowski wrote:
> > +static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
> > +			   struct ext4_map_blocks *map, loff_t offset,
> > +			   loff_t length)
> > +{
> > +	u8 blkbits = inode->i_blkbits;
> > +
> > +	/*
> > +	 * Writes that span EOF might trigger an I/O size update on completion,
> > +	 * so consider them to be dirty for the purpose of O_DSYNC, even if
> > +	 * there is no other metadata changes being made or are pending.
> > +	 */
> > +	iomap->flags = 0;
> > +	if (ext4_inode_datasync_dirty(inode) ||
> > +	    offset + length > i_size_read(inode))
> > +		iomap->flags |= IOMAP_F_DIRTY;
> > +
> > +	if (map->m_flags & EXT4_MAP_NEW)
> > +		iomap->flags |= IOMAP_F_NEW;
> > +
> > +	iomap->bdev = inode->i_sb->s_bdev;
> > +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> > +	iomap->offset = (u64) map->m_lblk << blkbits;
> > +	iomap->length = (u64) map->m_len << blkbits;
> > +
> > +	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> 
> /me wonders if this would be easier to follow if it was less indenty:
> 
> /*
>  * <giant comment from below>
>  */
> if (m_flags & EXT4_MAP_UNWRITTEN) {
> 	iomap->type = IOMAP_UNWRITTEN;
> 	iomap->addr = ...
> } else if (m_flags & EXT4_MAP_MAPPED) {
> 	iomap->type = IOAMP_MAPPED;
> 	iomap->addr = ...
> } else {
> 	iomap->type = IOMAP_HOLE;
> 	iomap->addr = IOMAP_NULL_ADDR;
> }
> 
> Rather than double-checking m_flags?

Yeah, you're right. The extra checks and levels of indentation aren't really
necessary and can be simplified further, as you've suggested above.

Thanks for looking over this for me.

/me adds this to the TODO for v7.

--<M>--

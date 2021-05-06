Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8358637563C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhEFPJP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 11:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234901AbhEFPJP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 May 2021 11:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25C656102A;
        Thu,  6 May 2021 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620313697;
        bh=oyr+XBP7Bz+PMsRDON0jst54egtaEfqr+lGI+69AiYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGY0k99JiiPP7xYFNfEY/3qNoTW4VBLOTXA/X1PCDXSyXcEHYcfpZ9aXUa8V89Gst
         WkaSvqpAcvHt66WvdszAKUUq4R925OmqjsbQvnTm5oa8kncy38c2+1ECnyvNun1qUc
         3ge7bwIpnCgM0Ad6IyenMguu6JOgoVZQWoAxF5hN1GmooK2gPJ8msmScnDZVDUiLkI
         k45jla5rddaXWeNPlR2d7QehBPjvb2m0K+3/frRFXtg5+4szdpUnZxLKZsGwVd2Ovq
         rGF1dgJFqfGLBnUp4M4ywpBZfuayvimoKsgTnxMENtUk1iGEIQVu4a8nPkbYA46wNN
         bUFlSyjV+F/Xw==
Date:   Thu, 6 May 2021 08:08:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Message-ID: <20210506150816.GE8532@magnolia>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210504163550.1486337-2-leah.rumancik@gmail.com>
 <20210505212711.GA8532@magnolia>
 <20210506071836.GA337144@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506071836.GA337144@infradead.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 06, 2021 at 08:18:36AM +0100, Christoph Hellwig wrote:
> On Wed, May 05, 2021 at 02:27:11PM -0700, Darrick J. Wong wrote:
> > Er... what specifically does "data" mean?  File data, or just the dirent
> > blocks?
> > 
> > I think this is only true if discard_zeroes_data == 1, right?  The last
> > I looked, ext4 was calling REQ_OP_DISCARD, not REQ_OP_WRITE_ZEROES.
> > 
> > Also, there are some SSDs that "implement" discard as nop, which means
> > that the old contents can still be read by re-reading the LBAs.  What
> > about those?
> 
> Not just some, but most at least for corner cases.  ATA TRIM, SCSI UNMAP
> and NVMe Deallocate all explicitly allow for keeping some of the old
> data, and devices make use of that when the discard requests does not
> map to their internal granularities.

Heh, so that's a "stable" behavior. :)

> > (Also wondering if this is where FS_SECRM_FL files should get their
> > freed file blocks erased with REQ_OP_SECURE_ERASE...)
> 
> Only implemented for mmc..

<shrug> If the wording got tweaked to "...not readable via LBA interface
after delete" then you could also REQ_OP_WRITE_ZEROES, which would work
on a broader range of hardware.

--D

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC52D8234
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 23:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436714AbgLKWgl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Dec 2020 17:36:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49242 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727605AbgLKWgG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Dec 2020 17:36:06 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BBMZD2s019961
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 17:35:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D558F420136; Fri, 11 Dec 2020 17:35:12 -0500 (EST)
Date:   Fri, 11 Dec 2020 17:35:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH RFC 4/5] ext2fs: parallel bitmap loading
Message-ID: <20201211223512.GC575698@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
 <20201205045856.895342-5-tytso@mit.edu>
 <4F169AE8-BFD2-4EE3-8741-7C75B8764583@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F169AE8-BFD2-4EE3-8741-7C75B8764583@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 05:12:09PM -0700, Andreas Dilger wrote:
> > @@ -329,12 +369,20 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
> > 				}
> > 				if (!bitmap_tail_verify((unsigned char *) block_bitmap,
> > 							block_nbytes, fs->blocksize - 1))
> > -					tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
> > +					*tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
> > 			} else
> > 				memset(block_bitmap, 0, block_nbytes);
> > 			cnt = block_nbytes << 3;
> > +#ifdef HAVE_PTHREAD
> > +			if (mutex)
> > +				pthread_mutex_lock(mutex);
> > +#endif
> > 			retval = ext2fs_set_block_bitmap_range2(fs->block_map,
> > 					       blk_itr, cnt, block_bitmap);
> > +#ifdef HAVE_PTHREAD
> > +			if (mutex)
> > +				pthread_mutex_unlock(mutex);
> > +#endif
> 
> (style) It wouldn't be terrible to have wrappers around these functions
> instead of inline #ifdef in the few places they are used, like:
> 
> #ifdef HAVE_PTHREAD
> static void unix_pthread_mutex_lock(pthread_mutex_t *mutex)
> {
> 	if (mutex)
> 		pthread_mutex_lock(mutex);
> }
> static void unix_pthread_mutex_unlock(pthread_mutex_t *mutex)
> {
> 	if (mutex)
> 		pthread_mutex_unlock(mutex);
> }
> #else
> #define unix_pthread_mutex_lock(mutex) do {} while (0)
> #define unix_pthread_mutex_unlock(mutex) do {} while (0)
> #endif

We'd also need to have a typedef for mutex_t which is either
pthreads_mutex_t if pthreads are available, or an int (or some other
placeholder type) if it isn't.

I had tried to make sure that rw_bitmaps.c will correctly compile with
HAVE_PTHREAD and HAVE_PTHREAD_H are undefined.  It looks like I didn't
quite get it completely working since there's at leasts one function
signature where we have an unprotected use of pthread_mutex_t, so
that's something we should check before finalizing the patch --- in
addition to the unprotected use of pthread_mutex_{lock,unlock} that
you pointed out.

      		    	   	 		   - Ted

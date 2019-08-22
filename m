Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE7C98FF8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbfHVJsm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 05:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfHVJsm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 05:48:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB51A3082A6C
        for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2019 09:48:41 +0000 (UTC)
Received: from work (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF7B15DC1E;
        Thu, 22 Aug 2019 09:48:38 +0000 (UTC)
Date:   Thu, 22 Aug 2019 11:48:33 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     sandeen@redhat.com
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] tune2fs: Warn if page size != blocksize when
 enabling encrypt
Message-ID: <20190822094833.zyijtboimxy6jvd2@work>
References: <20190821131813.9456-1-lczerner@redhat.com>
 <20190821131813.9456-2-lczerner@redhat.com>
 <c790aa59-7686-09e2-1066-92bec97704cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c790aa59-7686-09e2-1066-92bec97704cd@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 09:48:41 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 21, 2019 at 10:17:09AM -0500, Eric Sandeen wrote:
> 
> 
> On 8/21/19 8:18 AM, Lukas Czerner wrote:
> > With encrypt feature enabled the file system block size must match
> > system page size. Currently tune2fs will not complain at all when we try
> > to enable encrypt on a file system that does not satisfy this
> > requirement for the system. Add a warning for this case.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  misc/tune2fs.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> > index 7d2d38d7..26b1b1d0 100644
> > --- a/misc/tune2fs.c
> > +++ b/misc/tune2fs.c
> > @@ -130,6 +130,8 @@ void do_findfs(int argc, char **argv);
> >  int journal_enable_debug = -1;
> >  #endif
> >  
> > +static int sys_page_size = 4096;
> > +
> >  static void usage(void)
> >  {
> >  	fprintf(stderr,
> > @@ -1407,6 +1409,29 @@ mmp_error:
> >  			      stderr);
> >  			return 1;
> >  		}
> > +
> > +		/*
> > +		 * When encrypt feature is enabled, the file system blocksize
> > +		 * needs to match system page size otherwise the file system
> > +		 * won't mount.
> > +		 */
> > +		if (fs->blocksize != sys_page_size) {
> > +			if (!f_flag) {
> > +				com_err(program_name, 0,
> > +					_("Block size (%dB) does not match "
> > +					  "system page size (%dB). File "
> > +					  "system won't be usable on this "
> > +					  "system"),
> 
> I wonder if this message should explicitly mention the encryption option, right
> now it doesn't give a lot of context as to why this is being printed.

Ah right, I suppose people can change more things at once. I'll get it
fixed.

Thanks!
-Lukas

> 
> Perhaps "Encryption feature requested, but block size (%dB) does not match ...?"
> 
> -Eric
> 
> > +					fs->blocksize, sys_page_size);
> > +				proceed_question(-1);
> > +			}
> > +			fprintf(stderr,_("Warning: Encrypt feature enabled, "
> > +					 "but block size (%dB) does not match "
> > +					 "system page size (%dB), forced to "
> > +					 "cointinue\n"),
> > +				fs->blocksize, sys_page_size);
> > +		}
> > +
> >  		fs->super->s_encrypt_algos[0] =
> >  			EXT4_ENCRYPTION_MODE_AES_256_XTS;
> >  		fs->super->s_encrypt_algos[1] =
> > @@ -2844,6 +2869,7 @@ int main(int argc, char **argv)
> >  int tune2fs_main(int argc, char **argv)
> >  #endif  /* BUILD_AS_LIB */
> >  {
> > +	long sysval;
> >  	errcode_t retval;
> >  	ext2_filsys fs;
> >  	struct ext2_super_block *sb;
> > @@ -2879,6 +2905,18 @@ int tune2fs_main(int argc, char **argv)
> >  #endif
> >  		io_ptr = unix_io_manager;
> >  
> > +	/* Determine the system page size if possible */
> > +#ifdef HAVE_SYSCONF
> > +#if (!defined(_SC_PAGESIZE) && defined(_SC_PAGE_SIZE))
> > +#define _SC_PAGESIZE _SC_PAGE_SIZE
> > +#endif
> > +#ifdef _SC_PAGESIZE
> > +	sysval = sysconf(_SC_PAGESIZE);
> > +	if (sysval > 0)
> > +		sys_page_size = sysval;
> > +#endif /* _SC_PAGESIZE */
> > +#endif /* HAVE_SYSCONF */
> > +
> >  retry_open:
> >  	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
> >  		open_flag |= EXT2_FLAG_SKIP_MMP;
> > 

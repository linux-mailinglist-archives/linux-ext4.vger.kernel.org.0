Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354A7429522
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhJKRFx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 13:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhJKRFx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Oct 2021 13:05:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BB82606A5;
        Mon, 11 Oct 2021 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971833;
        bh=Kn9Tb86CDtbThUGIqRgs2PhefFSsAmUZNW41dfTH9dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1OTXCb9VnyZmpbewcOqGbQPyOj4AgW+ILpl0dtB0nZdnoa5PMcqQJQi27CSWcUSn
         cohvZYRTpgZjoJgzNIzNn19Z5unlVNlU3Ae1q7sVtf8PrqsVRthwQqFgP3+IuTroem
         3g7dMR3FEIEhMvzN6oPenf6W/5i02R1UBGN3ik5vcOprsyCdpCvcFQq9fDdpnJHfnT
         /Gv6vM6MhNmPBpFRfoG7q4ctp5Exz346yAtVi7cKsPWimchxeNTkddOMz0JKBlbRe7
         gRXqSDxkXq3iyJjJ2Lz01somweshHagAJ83PXEBdtZs1BIx7tMTIy1+5aEbmf40N9M
         ojCvnJC/a66dQ==
Date:   Mon, 11 Oct 2021 10:03:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Subject: Re: [PATCH v6] e2image: add option to ignore fs errors
Message-ID: <20211011170352.GA24255@magnolia>
References: <20211009142300.107262-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009142300.107262-1-artem.blagodarenko@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 09, 2021 at 10:23:00AM -0400, Artem Blagodarenko wrote:
> From: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> 
> Add extended "-E ignore_errors" option to be more tolerant
> to fs errors while scanning inode extents.
> 
> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
> Cray-bug-id: LUS-1922
> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> ---
> 
> Changes since preveious version:
> - The option is called ignore_error now
> - Fixed typos
> 
>  lib/support/Makefile.in          |  4 +++
>  lib/support/mvstring.c           | 25 +++++++++++++++
>  lib/support/mvstring.h           |  1 +
>  misc/e2image.8.in                | 15 ++++++++-
>  misc/e2image.c                   | 53 +++++++++++++++++++++++++++++---
>  misc/e2initrd_helper.c           | 16 +---------
>  tests/i_error_tolerance/expect.1 | 23 ++++++++++++++
>  tests/i_error_tolerance/expect.2 |  7 +++++
>  tests/i_error_tolerance/script   | 47 ++++++++++++++++++++++++++++
>  9 files changed, 171 insertions(+), 20 deletions(-)
>  create mode 100644 lib/support/mvstring.c
>  create mode 100644 lib/support/mvstring.h
>  create mode 100644 tests/i_error_tolerance/expect.1
>  create mode 100644 tests/i_error_tolerance/expect.2
>  create mode 100644 tests/i_error_tolerance/script
> 
> diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
> index f3c7981e..c29b0a71 100644
> --- a/lib/support/Makefile.in
> +++ b/lib/support/Makefile.in
> @@ -14,6 +14,7 @@ MKDIR_P = @MKDIR_P@
>  all::
>  
>  OBJS=		cstring.o \
> +		mvstring.o \
>  		mkquota.o \
>  		plausible.o \
>  		profile.o \
> @@ -27,6 +28,7 @@ OBJS=		cstring.o \
>  
>  SRCS=		$(srcdir)/argv_parse.c \
>  		$(srcdir)/cstring.c \
> +		$(srcdir)/mvstring.c \
>  		$(srcdir)/mkquota.c \
>  		$(srcdir)/parse_qtype.c \
>  		$(srcdir)/plausible.c \
> @@ -106,6 +108,8 @@ argv_parse.o: $(srcdir)/argv_parse.c $(top_builddir)/lib/config.h \
>   $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
>  cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
>   $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
> +mvstring.o: $(srcdir)/mvstring.c $(top_builddir)/lib/config.h \
> + $(srcdir)/mvstring.h
>  mkquota.o: $(srcdir)/mkquota.c $(top_builddir)/lib/config.h \
>   $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>   $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
> diff --git a/lib/support/mvstring.c b/lib/support/mvstring.c
> new file mode 100644
> index 00000000..1ed2fd67
> --- /dev/null
> +++ b/lib/support/mvstring.c
> @@ -0,0 +1,25 @@
> +#include "config.h"
> +#ifdef HAVE_STDLIB_H
> +#include <stdlib.h>
> +#endif
> +#include <ctype.h>
> +#include <string.h>
> +#include "mvstring.h"
> +
> +
> +/*
> + * fstab parsing code
> + */
> +char *string_copy(const char *s)
> +{
> +	char	*ret;
> +
> +	if (!s)
> +		return 0;
> +	ret = malloc(strlen(s)+1);
> +	if (ret)
> +		strcpy(ret, s);
> +	return ret;

Why is it necessary to reimplement strdup?

> +}
> +
> +
> diff --git a/lib/support/mvstring.h b/lib/support/mvstring.h
> new file mode 100644
> index 00000000..94590d56
> --- /dev/null
> +++ b/lib/support/mvstring.h
> @@ -0,0 +1 @@
> +extern char *string_copy(const char *s);
> diff --git a/misc/e2image.8.in b/misc/e2image.8.in
> index 90ea0c27..dfe53bc7 100644
> --- a/misc/e2image.8.in
> +++ b/misc/e2image.8.in
> @@ -50,7 +50,10 @@ and
>  by using the
>  .B \-i
>  option to those programs.  This can assist an expert in recovering
> -catastrophically corrupted file systems.
> +catastrophically corrupted file systems. If you going to grab an
> +image from a corrupted FS
> +.B \-E ignore_errors
> +option to ignore fs errors, allows to grab fs image from a corrupted fs.

Don't restate things in manual pages.

"If you know the filesystem is corrupt, see the -E ignore_errors option
below for information about how to tell e2image to deal with that."

>  .PP
>  It is a very good idea to create image files for all file systems on a
>  system and save the partition layout (which can be generated using the
> @@ -137,6 +140,16 @@ useful if the file system is being cloned to a flash-based storage device
>  (where reads are very fast and where it is desirable to avoid unnecessary
>  writes to reduce write wear on the device).
>  .TP
> +.BI \-E " extended_options"
> +Set e2image extended options.  Extended options are comma separated, and
> +may take an argument using the equals ('=') sign.  The following options
> +are supported:
> +.RS 1.2i
> +.TP
> +.BI ignore_error

But you said it was -E ignore_errors above.  Which is it?

> +Grab an image from a corrupted FS and ignore fs errors.
> +.RE
> +.TP
>  .B \-f
>  Override the read-only requirement for the source file system when saving
>  the image file using the
> diff --git a/misc/e2image.c b/misc/e2image.c
> index 2c1f3db3..45b8c2d5 100644
> --- a/misc/e2image.c
> +++ b/misc/e2image.c
> @@ -53,6 +53,7 @@ extern int optind;
>  #include "support/nls-enable.h"
>  #include "support/plausible.h"
>  #include "support/quotaio.h"
> +#include "support/mvstring.h"
>  #include "../version.h"
>  
>  #define QCOW_OFLAG_COPIED     (1ULL << 63)
> @@ -79,6 +80,7 @@ static char move_mode;
>  static char show_progress;
>  static char *check_buf;
>  static int skipped_blocks;
> +static int ignore_errors = 0;
>  
>  static blk64_t align_offset(blk64_t offset, unsigned int n)
>  {
> @@ -106,7 +108,7 @@ static int get_bits_from_size(size_t size)
>  static void usage(void)
>  {
>  	fprintf(stderr, _("Usage: %s [ -r|-Q ] [ -f ] [ -b superblock ] [ -B blocksize ] "
> -			  "device image-file\n"),
> +			  "[-E extended-options] device image-file\n"),
>  		program_name);
>  	fprintf(stderr, _("       %s -I device image-file\n"), program_name);
>  	fprintf(stderr, _("       %s -ra [ -cfnp ] [ -o src_offset ] "
> @@ -1379,7 +1381,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
>  				com_err(program_name, retval,
>  					_("while iterating over inode %u"),
>  					ino);
> -				exit(1);
> +				if (ignore_errors == 0)
> +					exit(1);
>  			}
>  		} else {
>  			if ((inode.i_flags & EXT4_EXTENTS_FL) ||
> @@ -1392,7 +1395,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
>  				if (retval) {
>  					com_err(program_name, retval,
>  					_("while iterating over inode %u"), ino);
> -					exit(1);
> +					if (ignore_errors == 0)
> +						exit(1);
>  				}
>  			}
>  		}
> @@ -1486,6 +1490,40 @@ static struct ext2_qcow2_hdr *check_qcow2_image(int *fd, char *name)
>  	return qcow2_read_header(*fd);
>  }
>  
> +static void parse_extended_opts(const char *opts)
> +{
> +	char	*buf, *token, *next, *p;
> +	int	ea_ver;
> +	int	extended_usage = 0;
> +	unsigned long long reada_kb;
> +
> +	buf = string_copy(opts);
> +	for (token = buf; token && *token; token = next) {
> +		p = strchr(token, ',');
> +		next = 0;
> +		if (p) {
> +			*p = 0;
> +			next = p+1;
> +		}
> +		if (strcmp(token, "ignore_errors") == 0) {

getsubopt() ?

> +			ignore_errors = 1;
> +			continue;
> +		} else {
> +			fprintf(stderr, _("Unknown extended option: %s\n"),
> +				token);
> +			extended_usage++;
> +		}
> +	}
> +	free(buf);
> +
> +	if (extended_usage) {
> +		fputs(_("\nExtended options are separated by commas. "
> +		       "Valid extended options are:\n\n"), stderr);
> +		fputs("\tignore_errors\n", stderr);
> +		exit(1);
> +	}
> +}
> +
>  int main (int argc, char ** argv)
>  {
>  	int c;
> @@ -1506,6 +1544,7 @@ int main (int argc, char ** argv)
>  	struct stat st;
>  	blk64_t superblock = 0;
>  	int blocksize = 0;
> +	char	*extended_opts = 0;
>  
>  #ifdef ENABLE_NLS
>  	setlocale(LC_MESSAGES, "");
> @@ -1519,7 +1558,7 @@ int main (int argc, char ** argv)
>  	if (argc && *argv)
>  		program_name = *argv;
>  	add_error_table(&et_ext2_error_table);
> -	while ((c = getopt(argc, argv, "b:B:nrsIQafo:O:pc")) != EOF)
> +	while ((c = getopt(argc, argv, "b:B:E:nrsIQafo:O:pc")) != EOF)
>  		switch (c) {
>  		case 'b':
>  			superblock = strtoull(optarg, NULL, 0);
> @@ -1527,6 +1566,9 @@ int main (int argc, char ** argv)
>  		case 'B':
>  			blocksize = strtoul(optarg, NULL, 0);
>  			break;
> +		case 'E':
> +			extended_opts = optarg;
> +			break;
>  		case 'I':
>  			flags |= E2IMAGE_INSTALL_FLAG;
>  			break;
> @@ -1609,6 +1651,9 @@ int main (int argc, char ** argv)
>  		exit(1);
>  	}
>  
> +	if (extended_opts)
> +		parse_extended_opts(extended_opts);
> +
>  	if (img_type && !ignore_rw_mount &&
>  	    (mount_flags & EXT2_MF_MOUNTED) &&
>  	   !(mount_flags & EXT2_MF_READONLY)) {
> diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
> index 436aab8c..ab5991a4 100644
> --- a/misc/e2initrd_helper.c
> +++ b/misc/e2initrd_helper.c
> @@ -36,6 +36,7 @@ extern char *optarg;
>  #include "ext2fs/ext2fs.h"
>  #include "blkid/blkid.h"
>  #include "support/nls-enable.h"
> +#include "support/mvstring.h"
>  
>  #include "../version.h"
>  
> @@ -151,21 +152,6 @@ static int mem_file_eof(struct mem_file *file)
>  	return (file->ptr >= file->size);
>  }
>  
> -/*
> - * fstab parsing code
> - */
> -static char *string_copy(const char *s)
> -{
> -	char	*ret;
> -
> -	if (!s)
> -		return 0;
> -	ret = malloc(strlen(s)+1);
> -	if (ret)
> -		strcpy(ret, s);
> -	return ret;
> -}
> -
>  static char *skip_over_blank(char *cp)
>  {
>  	while (*cp && isspace(*cp))
> diff --git a/tests/i_error_tolerance/expect.1 b/tests/i_error_tolerance/expect.1
> new file mode 100644
> index 00000000..e8d64954
> --- /dev/null
> +++ b/tests/i_error_tolerance/expect.1
> @@ -0,0 +1,23 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Inode 12 has illegal block(s).  Clear? yes
> +
> +Illegal indirect block (1000000) in inode 12.  CLEARED.
> +Inode 12, i_blocks is 34, should be 24.  Fix? yes
> +
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Block bitmap differences:  -(31--34) -41
> +Fix? yes
> +
> +Free blocks count wrong for group #0 (158, counted=163).
> +Fix? yes
> +
> +Free blocks count wrong (158, counted=163).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 12/24 files (8.3% non-contiguous), 37/200 blocks
> +Exit status is 1
> diff --git a/tests/i_error_tolerance/expect.2 b/tests/i_error_tolerance/expect.2
> new file mode 100644
> index 00000000..d9fcc327
> --- /dev/null
> +++ b/tests/i_error_tolerance/expect.2
> @@ -0,0 +1,7 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test_filesys: 12/24 files (8.3% non-contiguous), 37/200 blocks
> +Exit status is 0
> diff --git a/tests/i_error_tolerance/script b/tests/i_error_tolerance/script
> new file mode 100644
> index 00000000..315569c7
> --- /dev/null
> +++ b/tests/i_error_tolerance/script
> @@ -0,0 +1,47 @@
> +if ! test -x $E2IMAGE_EXE; then
> +	echo "$test_name: $test_description: skipped (no e2image)"
> +	return 0
> +fi
> +if ! test -x $DEBUGFS_EXE; then
> +	echo "$test_name: $test_description: skipped (no debugfs)"
> +	return 0
> +fi
> +
> +SKIP_GUNZIP="true"
> +
> +TEST_DATA="$test_name.tmp"
> +dd if=/dev/urandom of=$TEST_DATA bs=1k count=16 > /dev/null 2>&1 
> +
> +dd if=/dev/zero of=$TMPFILE bs=1k count=200 > /dev/null 2>&1
> +$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
> +$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
> +write $TEST_DATA testfile
> +set_inode_field testfile block[IND] 1000000
> +q
> +EOF
> +
> +$E2IMAGE -r $TMPFILE $TMPFILE.back
> +
> +if [ $? = 0 ] ; then
> +	echo "Image expected to be broken"
> +	echo "$test_name: $test_description: fail"
> +	touch $test_name.failed
> +	return 0
> +fi
> +
> +$E2IMAGE -r -E ignore_errors $TMPFILE $TMPFILE.back
> +
> +if [ $? = 1 ] ; then
> +	echo "Can not get image even with ignore_errors"
> +	echo "$test_name: $test_description: fail"
> +	touch $test_name.failed
> +	return 0
> +fi
> +
> +mv $TMPFILE.back $TMPFILE
> +
> +. $cmd_dir/run_e2fsck
> +
> +rm -f $TEST_DATA
> +
> +unset E2FSCK_TIME TEST_DATA
> -- 
> 2.18.4
> 

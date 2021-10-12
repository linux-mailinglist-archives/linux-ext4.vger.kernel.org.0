Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6354642A7AB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbhJLOzT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 10:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbhJLOzR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 10:55:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D6C061570
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 07:53:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c16so33677694lfb.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UwNE9lxuSazho00FjdKbiiVRjLp+07UTrt0p7yIKhRg=;
        b=eSCeEZopv6FZpmm7BOAzIrJaC1IaNp/dUQGocOCj+cWto9ykMqt3vfzl+SCXr1wUdL
         hwHQ9Niw4fQkTb8MlvR05W7l/8jCAq8dPPrQBOaVLfFpLI0dTqRSaFgZibyU8M6l1wLm
         7h3/nMXaZiCWrgdPschDCFrbGm3HFMBGxyAr+J+EJd+AJLOQ9CyJgkBA+IDI3ep3J3UH
         LnQT3gnMi8SHB5Jr1kmXvD2fwlBF/U3VRNtKzVWYvcCcrpKm8ev5T+cI4IbZIZ09IqmA
         N7xtaIIA62HILwLL1wuu3NUna/9WAvP0767AqSFxOsWlVg9kRW4wfX5gHeE55en8mGeb
         VcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UwNE9lxuSazho00FjdKbiiVRjLp+07UTrt0p7yIKhRg=;
        b=BG1B8nuchQTU+viEamhZdw1+r4gDH7Efio4FIqXa3D8B9y+lz+UoeGzlGyR9fRS4q5
         3SMVYqIvCeY3CV13orS10GrSC/R5xyePqPjkudcXgoWKP61CEDvEmR8E3iIzMsF/VFC2
         os8huP68N+6z8kLi1dihxNdpYxFQP6w0Pw8DSBN0VU6CHRPg4HvqsLnchEhWzfiGJRRP
         YZwEYkv9CqqO0/bjPHHALA6XCeYN21yeuclXIlIEfS32n4Dv0IEj6D02grxYN8ucilpU
         NrMOmlnWqRpAG5sQEhUMjtpqt44ZsYbGJeG6MDzSD9bBYcbzOyEwOhJk+cQZZGPisA8r
         IREg==
X-Gm-Message-State: AOAM530C/tRTthAAoevtb7IWNSSkWpllycTf5Bo+6oMcGXloAfQqTCWm
        L8UGyX535fWucCRXIsNzuwM=
X-Google-Smtp-Source: ABdhPJyfcz3MR4Q9E2SJTwNTrvpDlXSeFhXZnN9K9NeqW+waUaXMjVvE5yxKRZbcQZcZLYyOkDO1Sg==
X-Received: by 2002:a05:6512:2025:: with SMTP id s5mr4302998lfs.30.1634050389690;
        Tue, 12 Oct 2021 07:53:09 -0700 (PDT)
Received: from [192.168.2.192] ([62.33.81.195])
        by smtp.gmail.com with ESMTPSA id v7sm234928lji.81.2021.10.12.07.53.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:53:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v6] e2image: add option to ignore fs errors
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
In-Reply-To: <20211011170352.GA24255@magnolia>
Date:   Tue, 12 Oct 2021 17:53:06 +0300
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41163FE5-F5F3-4AB0-A9B8-5B80C0975D27@gmail.com>
References: <20211009142300.107262-1-artem.blagodarenko@gmail.com>
 <20211011170352.GA24255@magnolia>
To:     "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Derrick,

Thank you for the inspection.


> Why not use "strdup()" for this?  It isn't really a problem with
> this patch, since it was in e2initrd_helper.c previously and just
> moved into the helper library, but seems strange.  The strdup()
> function has existed for a very long time already, so there should
> not be any compatibility issues, but Ted added a patch using this
> function only a year ago, so maybe I'm missing something?  It dates
> back to:
>=20
>  2001-01-05 Use string_copy() instead of strdup() for portability's =
sake
>=20
> It would probably make sense to remove the duplicate copies that
> still exist in e2fsck/util.c and misc/fsck.c, and add a comment
> why it is better than strdup()?


I see a commit=20

commit 8820c79f75c37a3bc85cea7f56e7277025e157ef
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Jan 6 04:20:03 2001 +0000

That says
"Use string_copy() instead of strdup() for
            portability's sake.=E2=80=9D
=20
Probably something is changed already, but I prefer use string_copy(),
that was implemented already. I just made it public.

> On 11 Oct 2021, at 20:03, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Sat, Oct 09, 2021 at 10:23:00AM -0400, Artem Blagodarenko wrote:
>> From: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>>=20
>> Add extended "-E ignore_errors" option to be more tolerant
>> to fs errors while scanning inode extents.
>>=20
>> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
>> Cray-bug-id: LUS-1922
>> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>> ---
>>=20
>> Changes since preveious version:
>> - The option is called ignore_error now
>> - Fixed typos
>>=20
>> lib/support/Makefile.in          |  4 +++
>> lib/support/mvstring.c           | 25 +++++++++++++++
>> lib/support/mvstring.h           |  1 +
>> misc/e2image.8.in                | 15 ++++++++-
>> misc/e2image.c                   | 53 =
+++++++++++++++++++++++++++++---
>> misc/e2initrd_helper.c           | 16 +---------
>> tests/i_error_tolerance/expect.1 | 23 ++++++++++++++
>> tests/i_error_tolerance/expect.2 |  7 +++++
>> tests/i_error_tolerance/script   | 47 ++++++++++++++++++++++++++++
>> 9 files changed, 171 insertions(+), 20 deletions(-)
>> create mode 100644 lib/support/mvstring.c
>> create mode 100644 lib/support/mvstring.h
>> create mode 100644 tests/i_error_tolerance/expect.1
>> create mode 100644 tests/i_error_tolerance/expect.2
>> create mode 100644 tests/i_error_tolerance/script
>>=20
>> diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
>> index f3c7981e..c29b0a71 100644
>> --- a/lib/support/Makefile.in
>> +++ b/lib/support/Makefile.in
>> @@ -14,6 +14,7 @@ MKDIR_P =3D @MKDIR_P@
>> all::
>>=20
>> OBJS=3D		cstring.o \
>> +		mvstring.o \
>> 		mkquota.o \
>> 		plausible.o \
>> 		profile.o \
>> @@ -27,6 +28,7 @@ OBJS=3D		cstring.o \
>>=20
>> SRCS=3D		$(srcdir)/argv_parse.c \
>> 		$(srcdir)/cstring.c \
>> +		$(srcdir)/mvstring.c \
>> 		$(srcdir)/mkquota.c \
>> 		$(srcdir)/parse_qtype.c \
>> 		$(srcdir)/plausible.c \
>> @@ -106,6 +108,8 @@ argv_parse.o: $(srcdir)/argv_parse.c =
$(top_builddir)/lib/config.h \
>>  $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
>> cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
>>  $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
>> +mvstring.o: $(srcdir)/mvstring.c $(top_builddir)/lib/config.h \
>> + $(srcdir)/mvstring.h
>> mkquota.o: $(srcdir)/mkquota.c $(top_builddir)/lib/config.h \
>>  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
>> diff --git a/lib/support/mvstring.c b/lib/support/mvstring.c
>> new file mode 100644
>> index 00000000..1ed2fd67
>> --- /dev/null
>> +++ b/lib/support/mvstring.c
>> @@ -0,0 +1,25 @@
>> +#include "config.h"
>> +#ifdef HAVE_STDLIB_H
>> +#include <stdlib.h>
>> +#endif
>> +#include <ctype.h>
>> +#include <string.h>
>> +#include "mvstring.h"
>> +
>> +
>> +/*
>> + * fstab parsing code
>> + */
>> +char *string_copy(const char *s)
>> +{
>> +	char	*ret;
>> +
>> +	if (!s)
>> +		return 0;
>> +	ret =3D malloc(strlen(s)+1);
>> +	if (ret)
>> +		strcpy(ret, s);
>> +	return ret;
>=20
> Why is it necessary to reimplement strdup?

Please, see my comment above.

>=20
>> +}
>> +
>> +
>> diff --git a/lib/support/mvstring.h b/lib/support/mvstring.h
>> new file mode 100644
>> index 00000000..94590d56
>> --- /dev/null
>> +++ b/lib/support/mvstring.h
>> @@ -0,0 +1 @@
>> +extern char *string_copy(const char *s);
>> diff --git a/misc/e2image.8.in b/misc/e2image.8.in
>> index 90ea0c27..dfe53bc7 100644
>> --- a/misc/e2image.8.in
>> +++ b/misc/e2image.8.in
>> @@ -50,7 +50,10 @@ and
>> by using the
>> .B \-i
>> option to those programs.  This can assist an expert in recovering
>> -catastrophically corrupted file systems.
>> +catastrophically corrupted file systems. If you going to grab an
>> +image from a corrupted FS
>> +.B \-E ignore_errors
>> +option to ignore fs errors, allows to grab fs image from a corrupted =
fs.
>=20
> Don't restate things in manual pages.
>=20
> "If you know the filesystem is corrupt, see the -E ignore_errors =
option
> below for information about how to tell e2image to deal with that.=E2=80=
=9D
>=20

I will fix it in the next version, thanks.

>> .PP
>> It is a very good idea to create image files for all file systems on =
a
>> system and save the partition layout (which can be generated using =
the
>> @@ -137,6 +140,16 @@ useful if the file system is being cloned to a =
flash-based storage device
>> (where reads are very fast and where it is desirable to avoid =
unnecessary
>> writes to reduce write wear on the device).
>> .TP
>> +.BI \-E " extended_options"
>> +Set e2image extended options.  Extended options are comma separated, =
and
>> +may take an argument using the equals ('=3D') sign.  The following =
options
>> +are supported:
>> +.RS 1.2i
>> +.TP
>> +.BI ignore_error
>=20
> But you said it was -E ignore_errors above.  Which is it?

I will fix it in the next version, thanks.

>=20
>> +Grab an image from a corrupted FS and ignore fs errors.
>> +.RE
>> +.TP
>> .B \-f
>> Override the read-only requirement for the source file system when =
saving
>> the image file using the
>> diff --git a/misc/e2image.c b/misc/e2image.c
>> index 2c1f3db3..45b8c2d5 100644
>> --- a/misc/e2image.c
>> +++ b/misc/e2image.c
>> @@ -53,6 +53,7 @@ extern int optind;
>> #include "support/nls-enable.h"
>> #include "support/plausible.h"
>> #include "support/quotaio.h"
>> +#include "support/mvstring.h"
>> #include "../version.h"
>>=20
>> #define QCOW_OFLAG_COPIED     (1ULL << 63)
>> @@ -79,6 +80,7 @@ static char move_mode;
>> static char show_progress;
>> static char *check_buf;
>> static int skipped_blocks;
>> +static int ignore_errors =3D 0;
>>=20
>> static blk64_t align_offset(blk64_t offset, unsigned int n)
>> {
>> @@ -106,7 +108,7 @@ static int get_bits_from_size(size_t size)
>> static void usage(void)
>> {
>> 	fprintf(stderr, _("Usage: %s [ -r|-Q ] [ -f ] [ -b superblock ] =
[ -B blocksize ] "
>> -			  "device image-file\n"),
>> +			  "[-E extended-options] device image-file\n"),
>> 		program_name);
>> 	fprintf(stderr, _("       %s -I device image-file\n"), =
program_name);
>> 	fprintf(stderr, _("       %s -ra [ -cfnp ] [ -o src_offset ] "
>> @@ -1379,7 +1381,8 @@ static void write_raw_image_file(ext2_filsys =
fs, int fd, int type, int flags,
>> 				com_err(program_name, retval,
>> 					_("while iterating over inode =
%u"),
>> 					ino);
>> -				exit(1);
>> +				if (ignore_errors =3D=3D 0)
>> +					exit(1);
>> 			}
>> 		} else {
>> 			if ((inode.i_flags & EXT4_EXTENTS_FL) ||
>> @@ -1392,7 +1395,8 @@ static void write_raw_image_file(ext2_filsys =
fs, int fd, int type, int flags,
>> 				if (retval) {
>> 					com_err(program_name, retval,
>> 					_("while iterating over inode =
%u"), ino);
>> -					exit(1);
>> +					if (ignore_errors =3D=3D 0)
>> +						exit(1);
>> 				}
>> 			}
>> 		}
>> @@ -1486,6 +1490,40 @@ static struct ext2_qcow2_hdr =
*check_qcow2_image(int *fd, char *name)
>> 	return qcow2_read_header(*fd);
>> }
>>=20
>> +static void parse_extended_opts(const char *opts)
>> +{
>> +	char	*buf, *token, *next, *p;
>> +	int	ea_ver;
>> +	int	extended_usage =3D 0;
>> +	unsigned long long reada_kb;
>> +
>> +	buf =3D string_copy(opts);
>> +	for (token =3D buf; token && *token; token =3D next) {
>> +		p =3D strchr(token, ',');
>> +		next =3D 0;
>> +		if (p) {
>> +			*p =3D 0;
>> +			next =3D p+1;
>> +		}
>> +		if (strcmp(token, "ignore_errors") =3D=3D 0) {
>=20
> getsubopt() ?
>=20
>> +			ignore_errors =3D 1;
>> +			continue;
>> +		} else {
>> +			fprintf(stderr, _("Unknown extended option: =
%s\n"),
>> +				token);
>> +			extended_usage++;
>> +		}
>> +	}
>> +	free(buf);
>> +
>> +	if (extended_usage) {
>> +		fputs(_("\nExtended options are separated by commas. "
>> +		       "Valid extended options are:\n\n"), stderr);
>> +		fputs("\tignore_errors\n", stderr);
>> +		exit(1);
>> +	}
>> +}
>> +
>> int main (int argc, char ** argv)
>> {
>> 	int c;
>> @@ -1506,6 +1544,7 @@ int main (int argc, char ** argv)
>> 	struct stat st;
>> 	blk64_t superblock =3D 0;
>> 	int blocksize =3D 0;
>> +	char	*extended_opts =3D 0;
>>=20
>> #ifdef ENABLE_NLS
>> 	setlocale(LC_MESSAGES, "");
>> @@ -1519,7 +1558,7 @@ int main (int argc, char ** argv)
>> 	if (argc && *argv)
>> 		program_name =3D *argv;
>> 	add_error_table(&et_ext2_error_table);
>> -	while ((c =3D getopt(argc, argv, "b:B:nrsIQafo:O:pc")) !=3D EOF)
>> +	while ((c =3D getopt(argc, argv, "b:B:E:nrsIQafo:O:pc")) !=3D =
EOF)
>> 		switch (c) {
>> 		case 'b':
>> 			superblock =3D strtoull(optarg, NULL, 0);
>> @@ -1527,6 +1566,9 @@ int main (int argc, char ** argv)
>> 		case 'B':
>> 			blocksize =3D strtoul(optarg, NULL, 0);
>> 			break;
>> +		case 'E':
>> +			extended_opts =3D optarg;
>> +			break;
>> 		case 'I':
>> 			flags |=3D E2IMAGE_INSTALL_FLAG;
>> 			break;
>> @@ -1609,6 +1651,9 @@ int main (int argc, char ** argv)
>> 		exit(1);
>> 	}
>>=20
>> +	if (extended_opts)
>> +		parse_extended_opts(extended_opts);
>> +
>> 	if (img_type && !ignore_rw_mount &&
>> 	    (mount_flags & EXT2_MF_MOUNTED) &&
>> 	   !(mount_flags & EXT2_MF_READONLY)) {
>> diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
>> index 436aab8c..ab5991a4 100644
>> --- a/misc/e2initrd_helper.c
>> +++ b/misc/e2initrd_helper.c
>> @@ -36,6 +36,7 @@ extern char *optarg;
>> #include "ext2fs/ext2fs.h"
>> #include "blkid/blkid.h"
>> #include "support/nls-enable.h"
>> +#include "support/mvstring.h"
>>=20
>> #include "../version.h"
>>=20
>> @@ -151,21 +152,6 @@ static int mem_file_eof(struct mem_file *file)
>> 	return (file->ptr >=3D file->size);
>> }
>>=20
>> -/*
>> - * fstab parsing code
>> - */
>> -static char *string_copy(const char *s)
>> -{
>> -	char	*ret;
>> -
>> -	if (!s)
>> -		return 0;
>> -	ret =3D malloc(strlen(s)+1);
>> -	if (ret)
>> -		strcpy(ret, s);
>> -	return ret;
>> -}
>> -
>> static char *skip_over_blank(char *cp)
>> {
>> 	while (*cp && isspace(*cp))
>> diff --git a/tests/i_error_tolerance/expect.1 =
b/tests/i_error_tolerance/expect.1
>> new file mode 100644
>> index 00000000..e8d64954
>> --- /dev/null
>> +++ b/tests/i_error_tolerance/expect.1
>> @@ -0,0 +1,23 @@
>> +Pass 1: Checking inodes, blocks, and sizes
>> +Inode 12 has illegal block(s).  Clear? yes
>> +
>> +Illegal indirect block (1000000) in inode 12.  CLEARED.
>> +Inode 12, i_blocks is 34, should be 24.  Fix? yes
>> +
>> +Pass 2: Checking directory structure
>> +Pass 3: Checking directory connectivity
>> +Pass 4: Checking reference counts
>> +Pass 5: Checking group summary information
>> +Block bitmap differences:  -(31--34) -41
>> +Fix? yes
>> +
>> +Free blocks count wrong for group #0 (158, counted=3D163).
>> +Fix? yes
>> +
>> +Free blocks count wrong (158, counted=3D163).
>> +Fix? yes
>> +
>> +
>> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>> +test_filesys: 12/24 files (8.3% non-contiguous), 37/200 blocks
>> +Exit status is 1
>> diff --git a/tests/i_error_tolerance/expect.2 =
b/tests/i_error_tolerance/expect.2
>> new file mode 100644
>> index 00000000..d9fcc327
>> --- /dev/null
>> +++ b/tests/i_error_tolerance/expect.2
>> @@ -0,0 +1,7 @@
>> +Pass 1: Checking inodes, blocks, and sizes
>> +Pass 2: Checking directory structure
>> +Pass 3: Checking directory connectivity
>> +Pass 4: Checking reference counts
>> +Pass 5: Checking group summary information
>> +test_filesys: 12/24 files (8.3% non-contiguous), 37/200 blocks
>> +Exit status is 0
>> diff --git a/tests/i_error_tolerance/script =
b/tests/i_error_tolerance/script
>> new file mode 100644
>> index 00000000..315569c7
>> --- /dev/null
>> +++ b/tests/i_error_tolerance/script
>> @@ -0,0 +1,47 @@
>> +if ! test -x $E2IMAGE_EXE; then
>> +	echo "$test_name: $test_description: skipped (no e2image)"
>> +	return 0
>> +fi
>> +if ! test -x $DEBUGFS_EXE; then
>> +	echo "$test_name: $test_description: skipped (no debugfs)"
>> +	return 0
>> +fi
>> +
>> +SKIP_GUNZIP=3D"true"
>> +
>> +TEST_DATA=3D"$test_name.tmp"
>> +dd if=3D/dev/urandom of=3D$TEST_DATA bs=3D1k count=3D16 > /dev/null =
2>&1=20
>> +
>> +dd if=3D/dev/zero of=3D$TMPFILE bs=3D1k count=3D200 > /dev/null 2>&1
>> +$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
>> +$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
>> +write $TEST_DATA testfile
>> +set_inode_field testfile block[IND] 1000000
>> +q
>> +EOF
>> +
>> +$E2IMAGE -r $TMPFILE $TMPFILE.back
>> +
>> +if [ $? =3D 0 ] ; then
>> +	echo "Image expected to be broken"
>> +	echo "$test_name: $test_description: fail"
>> +	touch $test_name.failed
>> +	return 0
>> +fi
>> +
>> +$E2IMAGE -r -E ignore_errors $TMPFILE $TMPFILE.back
>> +
>> +if [ $? =3D 1 ] ; then
>> +	echo "Can not get image even with ignore_errors"
>> +	echo "$test_name: $test_description: fail"
>> +	touch $test_name.failed
>> +	return 0
>> +fi
>> +
>> +mv $TMPFILE.back $TMPFILE
>> +
>> +. $cmd_dir/run_e2fsck
>> +
>> +rm -f $TEST_DATA
>> +
>> +unset E2FSCK_TIME TEST_DATA
>> --=20
>> 2.18.4

Best regards,
Artem Blagodarenko.=20


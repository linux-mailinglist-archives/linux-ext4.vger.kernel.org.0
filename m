Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CB02691C7
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgINPbt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgINPbI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Sep 2020 11:31:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA1C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 08:31:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so17166486ilp.7
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TCpeLdw8ZoWFDQ66h8Wa6XXcpn4IgrFVfAHg7dhW8jc=;
        b=HoUOedtf3q/HE16JohlDREQn60qmnhB1O+s+Dg42XeRFQughuydsWBru7NqnUI5v1q
         3VB1//scqkb6fPhjT00zTf4TUEUQczYE0n/ziJXiWMVTojk0SicwqFzEmxQT9gfzfBGm
         W0n4ZKDVugfnjdBmHoMB8Y4dXZ0IDKsceuDCPBgTigSnbJhFHPJHDevSDTUJ132IFV9V
         euPlOQdN3TugpCm64l1t3rjaf0iSieJ3FvZKQDqZo3f3MVuN4yIylxjVbvBZMQHVfMAP
         DZ9C8ne2Z9JFlyhEV1dR7VbPz3cNSS5QfGAWsK2DLNCqOJ9bpmOwW6ClmJcbgS7hzyqj
         fnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TCpeLdw8ZoWFDQ66h8Wa6XXcpn4IgrFVfAHg7dhW8jc=;
        b=fKF6ZijL91W4pPGXd9MQsVfk67P71Xme2VL/E8s2R2ihviQlZfQ1bNkdne473vQxW0
         x2+QzFvb7LIytwUBqTug3dVcyY4R8htw+pWlFZFISjR2AB9d95FEZEWtAW2MCwAC7kUa
         4egQlPfVlyJW6DjlcvslbY8aBk5eg/EOcwMOaH52hcgtIaosTZRr4Oc0LqazSX18NvCm
         nOk4GqWYE3IYItoUnbZHY+byB0xq9lSxwA5YUyg5Rg24aHCzBPqgQnO9B1hhPq4iJ3ON
         ifz039W/XkrC5Xf6iRxr/9oGDzXew66oIwu8TN5U9rI2S3tanAtaaCd+mde8aWL292t3
         AqYg==
X-Gm-Message-State: AOAM532c7rynTkiIz+NGBfx8WJBchDzhuEjubj0MKCD5KVYq2+cbrdcL
        I62zOl27mGwWeb46iTTsKPIcM0OkN0rYorQ3
X-Google-Smtp-Source: ABdhPJzly5cBjF8Y6SPd6r03seE0WVzmSnVt2uJ7uXZ5V0D4Bb7pMked5uJ3bWzPkNT+t8Mbq8lDkQ==
X-Received: by 2002:a05:6e02:d93:: with SMTP id i19mr7058979ilj.21.1600097467110;
        Mon, 14 Sep 2020 08:31:07 -0700 (PDT)
Received: from [172.25.17.149] ([136.162.66.1])
        by smtp.gmail.com with ESMTPSA id s17sm7253926ilb.24.2020.09.14.08.31.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2020 08:31:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH v3] e2image: add option to ignore fs errors
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20200818071703.33484-1-artem.blagodarenko@gmail.com>
Date:   Mon, 14 Sep 2020 18:30:58 +0300
Cc:     adilger.kernel@dilger.ca, alexey.lyashkov@gmail.com,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7804F015-CF5B-4AAE-86FD-82331C558DA5@gmail.com>
References: <20200818071703.33484-1-artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Should I fix something in this patch?

Thanks,

Artem Blagodarenko.

> On 18 Aug 2020, at 10:17, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>=20
> From: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>=20
> Add extended "-E ignore_error" option to be more tolerant
> to fs errors while scanning inode extents.
>=20
> This is 6th version of the patch set. Changes:
>=20
> *more obvious binaries existence check in test
> *finish test if e2image can't capture an image
>=20
> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
> Cray-bug-id: LUS-1922
> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> ---
> lib/support/Makefile.in          |  4 +++
> lib/support/mvstring.c           | 25 +++++++++++++++
> lib/support/mvstring.h           |  1 +
> misc/e2image.8.in                |  3 ++
> misc/e2image.c                   | 53 +++++++++++++++++++++++++++++---
> misc/e2initrd_helper.c           | 16 +---------
> tests/i_error_tolerance/expect.1 | 23 ++++++++++++++
> tests/i_error_tolerance/expect.2 |  7 +++++
> tests/i_error_tolerance/script   | 47 ++++++++++++++++++++++++++++
> 9 files changed, 160 insertions(+), 19 deletions(-)
> create mode 100644 lib/support/mvstring.c
> create mode 100644 lib/support/mvstring.h
> create mode 100644 tests/i_error_tolerance/expect.1
> create mode 100644 tests/i_error_tolerance/expect.2
> create mode 100644 tests/i_error_tolerance/script
>=20
> diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
> index 1d278642..4d04eef0 100644
> --- a/lib/support/Makefile.in
> +++ b/lib/support/Makefile.in
> @@ -13,6 +13,7 @@ INSTALL =3D @INSTALL@
> all::
>=20
> OBJS=3D		cstring.o \
> +		mvstring.o \
> 		mkquota.o \
> 		plausible.o \
> 		profile.o \
> @@ -26,6 +27,7 @@ OBJS=3D		cstring.o \
>=20
> SRCS=3D		$(srcdir)/argv_parse.c \
> 		$(srcdir)/cstring.c \
> +		$(srcdir)/mvstring.c \
> 		$(srcdir)/mkquota.c \
> 		$(srcdir)/parse_qtype.c \
> 		$(srcdir)/plausible.c \
> @@ -105,6 +107,8 @@ argv_parse.o: $(srcdir)/argv_parse.c =
$(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
> cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
> +mvstring.o: $(srcdir)/mvstring.c $(top_builddir)/lib/config.h \
> + $(srcdir)/mvstring.h
> mkquota.o: $(srcdir)/mkquota.c $(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h =
$(top_srcdir)/lib/ext2fs/ext2fs.h \
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
> +	ret =3D malloc(strlen(s)+1);
> +	if (ret)
> +		strcpy(ret, s);
> +	return ret;
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
> index ef124867..3816b682 100644
> --- a/misc/e2image.8.in
> +++ b/misc/e2image.8.in
> @@ -73,6 +73,9 @@ for the image file to be in a consistent state.  =
This requirement can be
> overridden using the
> .B \-f
> option, but the resulting image file is very likely not going to be =
useful.
> +If you going to grab an image from a corrupted FS
> +.B \-E ignore_error
> +option to ignore fs errors, allows to grab fs image from a corrupted =
fs.
> .PP
> If
> .I image-file
> diff --git a/misc/e2image.c b/misc/e2image.c
> index 892c5371..887c38f2 100644
> --- a/misc/e2image.c
> +++ b/misc/e2image.c
> @@ -52,6 +52,7 @@ extern int optind;
>=20
> #include "support/nls-enable.h"
> #include "support/plausible.h"
> +#include "support/mvstring.h"
> #include "../version.h"
>=20
> #define QCOW_OFLAG_COPIED     (1ULL << 63)
> @@ -78,6 +79,7 @@ static char move_mode;
> static char show_progress;
> static char *check_buf;
> static int skipped_blocks;
> +static int ignore_error =3D 0;
>=20
> static blk64_t align_offset(blk64_t offset, unsigned int n)
> {
> @@ -105,7 +107,7 @@ static int get_bits_from_size(size_t size)
> static void usage(void)
> {
> 	fprintf(stderr, _("Usage: %s [ -r|-Q ] [ -f ] [ -b superblock ] =
[ -B blocksize ] "
> -			  "device image-file\n"),
> +			  "[-E extended-options] device image-file\n"),
> 		program_name);
> 	fprintf(stderr, _("       %s -I device image-file\n"), =
program_name);
> 	fprintf(stderr, _("       %s -ra [ -cfnp ] [ -o src_offset ] "
> @@ -1368,7 +1370,8 @@ static void write_raw_image_file(ext2_filsys fs, =
int fd, int type, int flags,
> 				com_err(program_name, retval,
> 					_("while iterating over inode =
%u"),
> 					ino);
> -				exit(1);
> +				if (ignore_error =3D=3D 0)
> +					exit(1);
> 			}
> 		} else {
> 			if ((inode.i_flags & EXT4_EXTENTS_FL) ||
> @@ -1381,7 +1384,8 @@ static void write_raw_image_file(ext2_filsys fs, =
int fd, int type, int flags,
> 				if (retval) {
> 					com_err(program_name, retval,
> 					_("while iterating over inode =
%u"), ino);
> -					exit(1);
> +					if (ignore_error =3D=3D 0)
> +						exit(1);
> 				}
> 			}
> 		}
> @@ -1475,6 +1479,40 @@ static struct ext2_qcow2_hdr =
*check_qcow2_image(int *fd, char *name)
> 	return qcow2_read_header(*fd);
> }
>=20
> +static void parse_extended_opts(const char *opts)
> +{
> +	char	*buf, *token, *next, *p;
> +	int	ea_ver;
> +	int	extended_usage =3D 0;
> +	unsigned long long reada_kb;
> +
> +	buf =3D string_copy(opts);
> +	for (token =3D buf; token && *token; token =3D next) {
> +		p =3D strchr(token, ',');
> +		next =3D 0;
> +		if (p) {
> +			*p =3D 0;
> +			next =3D p+1;
> +		}
> +		if (strcmp(token, "ignore_error") =3D=3D 0) {
> +			ignore_error =3D 1;
> +			continue;
> +		} else {
> +			fprintf(stderr, _("Unknown extended option: =
%s\n"),
> +				token);
> +			extended_usage++;
> +		}
> +	}
> +	free(buf);
> +
> +	if (extended_usage) {
> +		fputs(_("\nExtended options are separated by commas. "
> +		       "Valid extended options are:\n\n"), stderr);
> +		fputs("\tignore_error\n", stderr);
> +		exit(1);
> +	}
> +}
> +
> int main (int argc, char ** argv)
> {
> 	int c;
> @@ -1494,6 +1532,7 @@ int main (int argc, char ** argv)
> 	struct stat st;
> 	blk64_t superblock =3D 0;
> 	int blocksize =3D 0;
> +	char	*extended_opts =3D 0;
>=20
> #ifdef ENABLE_NLS
> 	setlocale(LC_MESSAGES, "");
> @@ -1507,7 +1546,7 @@ int main (int argc, char ** argv)
> 	if (argc && *argv)
> 		program_name =3D *argv;
> 	add_error_table(&et_ext2_error_table);
> -	while ((c =3D getopt(argc, argv, "b:B:nrsIQafo:O:pc")) !=3D EOF)
> +	while ((c =3D getopt(argc, argv, "b:B:E:nrsIQafo:O:pc")) !=3D =
EOF)
> 		switch (c) {
> 		case 'b':
> 			superblock =3D strtoull(optarg, NULL, 0);
> @@ -1515,6 +1554,9 @@ int main (int argc, char ** argv)
> 		case 'B':
> 			blocksize =3D strtoul(optarg, NULL, 0);
> 			break;
> +		case 'E':
> +			extended_opts =3D optarg;
> +			break;
> 		case 'I':
> 			flags |=3D E2IMAGE_INSTALL_FLAG;
> 			break;
> @@ -1597,6 +1639,9 @@ int main (int argc, char ** argv)
> 		exit(1);
> 	}
>=20
> +	if (extended_opts)
> +		parse_extended_opts(extended_opts);
> +
> 	if (img_type && !ignore_rw_mount &&
> 	    (mount_flags & EXT2_MF_MOUNTED) &&
> 	   !(mount_flags & EXT2_MF_READONLY)) {
> diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
> index 436aab8c..ab5991a4 100644
> --- a/misc/e2initrd_helper.c
> +++ b/misc/e2initrd_helper.c
> @@ -36,6 +36,7 @@ extern char *optarg;
> #include "ext2fs/ext2fs.h"
> #include "blkid/blkid.h"
> #include "support/nls-enable.h"
> +#include "support/mvstring.h"
>=20
> #include "../version.h"
>=20
> @@ -151,21 +152,6 @@ static int mem_file_eof(struct mem_file *file)
> 	return (file->ptr >=3D file->size);
> }
>=20
> -/*
> - * fstab parsing code
> - */
> -static char *string_copy(const char *s)
> -{
> -	char	*ret;
> -
> -	if (!s)
> -		return 0;
> -	ret =3D malloc(strlen(s)+1);
> -	if (ret)
> -		strcpy(ret, s);
> -	return ret;
> -}
> -
> static char *skip_over_blank(char *cp)
> {
> 	while (*cp && isspace(*cp))
> diff --git a/tests/i_error_tolerance/expect.1 =
b/tests/i_error_tolerance/expect.1
> new file mode 100644
> index 00000000..8d5ffa2c
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
> +Block bitmap differences:  -(31--34) -37
> +Fix? yes
> +
> +Free blocks count wrong for group #0 (62, counted=3D67).
> +Fix? yes
> +
> +Free blocks count wrong (62, counted=3D67).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
> +Exit status is 1
> diff --git a/tests/i_error_tolerance/expect.2 =
b/tests/i_error_tolerance/expect.2
> new file mode 100644
> index 00000000..7fd42318
> --- /dev/null
> +++ b/tests/i_error_tolerance/expect.2
> @@ -0,0 +1,7 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
> +Exit status is 0
> diff --git a/tests/i_error_tolerance/script =
b/tests/i_error_tolerance/script
> new file mode 100644
> index 00000000..6503de97
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
> +SKIP_GUNZIP=3D"true"
> +
> +TEST_DATA=3D"$test_name.tmp"
> +dd if=3D/dev/urandom of=3D$TEST_DATA bs=3D1k count=3D16 > /dev/null =
2>&1=20
> +
> +dd if=3D/dev/zero of=3D$TMPFILE bs=3D1k count=3D100 > /dev/null 2>&1
> +$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
> +$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
> +write $TEST_DATA testfile
> +set_inode_field testfile block[IND] 1000000
> +q
> +EOF
> +
> +$E2IMAGE -r $TMPFILE $TMPFILE.back
> +
> +if [ $? =3D 0 ] ; then
> +	echo "Image expected to be broken"
> +	echo "$test_name: $test_description: fail"
> +	touch $test_name.failed
> +	return 0
> +fi
> +
> +$E2IMAGE -r -E ignore_error $TMPFILE $TMPFILE.back
> +
> +if [ $? =3D 1 ] ; then
> +	echo "Can not get image even with ignore_error"
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
> --=20
> 2.18.4
>=20


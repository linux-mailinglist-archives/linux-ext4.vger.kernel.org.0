Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9450512F685
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2020 11:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgACKFq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jan 2020 05:05:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44659 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACKFp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Jan 2020 05:05:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so18878538plb.11;
        Fri, 03 Jan 2020 02:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nm3SdbzHAq0cNm0cfuBrOKlJo6c23EeMatT9yVUIkGc=;
        b=EjpbMHWuEgUtc+FKbstMbqyLYF4XPZxs4s96RL5fpNalK9Pw0oZX1J+NqLeIQe3TPz
         pHM3VXluajf9IKcwtgv2oRIWLl9D8gvb0TvM48tPE4TKxZPj4V0t+FaGVbhCskXYA49b
         barEU5E2EaeCYuHKPhxfKLJ90mWPmRDtMgJVQ1bZDXtxives+VDH343s2oZY80sZGEhn
         tOPfGHb0ekmLvYKNrBphf3wkYSSMUjt3wFIcbOUI/lYieqW/biYKdaSD0byQJFCzuFHL
         /dfc/pLNQ3Jxyq9OkPphr06nReDas4nDSuPH6qlUT12P9vHcciyur/T1XDPmuOzDgsJS
         0sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nm3SdbzHAq0cNm0cfuBrOKlJo6c23EeMatT9yVUIkGc=;
        b=sQUlze3yw7MpDW8vQ/u9Ve04YYVj9RBHO/69S9LicTLY5ehFzJQK1kvwXKch0y4hZD
         rmENQfxUBdHpSoo1Pfjh94ESifB/TQ9tUF8XfXKyVg0TEcZu3D4YaGEvthkk61UxDDI0
         kk8HB7gGDUzfnjs7DC14N+yJVqtfzJV4zk2+kKp9C7WONKUQwi7peJAIn/nJLGKoRko0
         VINpqVnCVGQnO1tP+EQ0OObDOMLg9cOmiVgikyFD1+n/csq9Fjg+OX/uY6C9pMuZXzHW
         kE6YRHGl6CWA5bCIG1e6Dv6uO4Ce7z046JNLWGnhCiOzKioTwTix1HCigEWb8+DvSRby
         32sQ==
X-Gm-Message-State: APjAAAWsSqTXOwky9pn7aHR/kZHiQc/1RzrQ2AjpOHs7i4XG2J5ZIEX4
        LBATrJuvgxUn9wdOtWxqEY0=
X-Google-Smtp-Source: APXvYqwv8RRVVzAlrMYk5nxUpzNZZjTNkPyGgSprmxF67ww+GniYD3H0/7MkJRjj4VAS/wtmtSVCpA==
X-Received: by 2002:a17:90a:2645:: with SMTP id l63mr25697208pje.88.1578045944271;
        Fri, 03 Jan 2020 02:05:44 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id l21sm47582490pff.100.2020.01.03.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 02:05:43 -0800 (PST)
Date:   Fri, 3 Jan 2020 18:05:38 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Yong Sun <sunyong0511@gmail.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com,
        Yong Sun <yosun@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5] fstests: transport two ext4 tests from LTP
Message-ID: <20200103100532.GC893866@desktop>
References: <20191213093936.9286-1-yosun@suse.com>
 <20200103100319.GB893866@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103100319.GB893866@desktop>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[cc ext4 list for the corruption issue at the end of the mail.]

On Fri, Jan 03, 2020 at 06:03:27PM +0800, Eryu Guan wrote:
> On Fri, Dec 13, 2019 at 05:39:37PM +0800, Yong Sun wrote:
> > Recently LTP upstream removed some ext4 tests[1].
> > And two of them is still valid to keep. So I transport those two tests here.
> > ext4-nsec-timestamps, which is used to test nanosec timestamps of ext4, rewrite into ext4/043 and 044.
> > ext4-subdir-limit, which is used to test subdirectory limit of ext4, rewrite into ext4/045.
> > 
> > [1] https://marc.info/?l=linux-fsdevel&m=157190623919681&w=2
> > 
> > Signed-off-by: Sun Yong <yosun@suse.com>
> > ---
> > v2: Correct copyright information
> > v3: Correct white-space damage
> > v4: Add a missing file
> > v5: Fix several issue reviewed by Darrick
> > ---
> >  src/Makefile              |   3 +-
> >  src/t_create_long_dirs.c  | 139 +++++++++++++++++++++++++++++++++++++
> >  src/t_create_short_dirs.c | 142 ++++++++++++++++++++++++++++++++++++++
> >  src/t_ext4_file_time.c    |  53 ++++++++++++++
> 
> Need .gitignore entries for new binaries.
> 
> And I think t_ext4_file_time is generic enough, we could rename it to
> something like t_get_file_time.
> 
> >  tests/ext4/043            |  56 +++++++++++++++
> >  tests/ext4/043.out        |   2 +
> >  tests/ext4/044            |  87 +++++++++++++++++++++++
> >  tests/ext4/044.out        |   2 +
> >  tests/ext4/045            | 134 +++++++++++++++++++++++++++++++++++
> >  tests/ext4/045.out        |   2 +
> >  tests/ext4/group          |   3 +
> >  11 files changed, 622 insertions(+), 1 deletion(-)
> >  create mode 100644 src/t_create_long_dirs.c
> >  create mode 100644 src/t_create_short_dirs.c
> >  create mode 100644 src/t_ext4_file_time.c
> >  create mode 100755 tests/ext4/043
> >  create mode 100644 tests/ext4/043.out
> >  create mode 100755 tests/ext4/044
> >  create mode 100644 tests/ext4/044.out
> >  create mode 100755 tests/ext4/045
> >  create mode 100644 tests/ext4/045.out
> > 
> > diff --git a/src/Makefile b/src/Makefile
> > index ce6d8610..387293d1 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -16,7 +16,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> >  	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
> >  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
> >  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> > -	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
> > +	t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent \
> > +    t_ext4_file_time t_create_short_dirs t_create_long_dirs
> 
> Use tab for indention.
> 
> >  
> >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/t_create_long_dirs.c b/src/t_create_long_dirs.c
> > new file mode 100644
> > index 00000000..fe5b4b64
> > --- /dev/null
> > +++ b/src/t_create_long_dirs.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2009 FUJITSU LIMITED
> > + * Author: Li Zefan <lizf@cn.fujitsu.com>
> > + */
> > +
> > +#define _POSIX_C_SOURCE 200809L
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <time.h>
> > +#include <fcntl.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include "config.h"
> > +
> > +/* NCHARS = 10 + 26 + 26 = 62 */
> > +#define NAME_LEN	255
> > +#define NCHARS		62
> > +#define MAX_LEN1	62
> > +#define MAX_LEN2	(62 * 62)
> > +#define MAX_LEN3	(62 * 62 * 62)
> > +
> > +/* valid characters for the directory name */
> > +char chars[NCHARS + 1] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> > +
> > +/* to store the generated directory name */
> > +char name[NAME_LEN + 1];
> > +int names;
> > +int parent_fd;
> > +
> > +/*
> > + * init_name - initialize the directory name
> > + *
> > + * Generate a randomized directory name, and then we generate more
> > + * directory names based on it.
> > + */
> > +void init_name(void)
> > +{
> > +	int i;
> > +
> > +	srand(time(NULL));
> > +
> > +	for (i = 0; i < NAME_LEN; i++)
> > +		name[i] = chars[rand() % 62];
> > +}
> > +
> > +void create_dir(void)
> > +{
> > +	if (mkdirat(parent_fd, name, S_IRWXU)) {
> > +		perror("mkdir");
> > +		exit(1);
> > +	}
> > +}
> > +
> > +/*
> > + * create_dirs - create @names directory names
> > + * @n: how many names to be created
> > + *
> > + * if n <= 62,       we need to modify 1 char of the name
> > + * if n <= 62*62,    we need to modify 2 chars
> > + * if n <= 62*62*62, we need to modify 3 chars
> > + */
> > +void create_dirs(int n)
> > +{
> > +	int i, j, k;
> > +	int depth;
> > +
> > +	if (n <= MAX_LEN1)
> > +		depth = 1;
> > +	else if (n <= MAX_LEN2)
> > +		depth = 2;
> > +	else
> > +		depth = 3;
> > +
> > +	for (i = 0; i < NCHARS; i++) {
> > +		name[0] = chars[i];
> > +		if (depth == 1) {
> > +			create_dir();
> > +			if (--n == 0)
> > +				return;
> > +			continue;
> > +		}
> > +
> > +		for (j = 0; j < NCHARS; j++) {
> > +			name[1] = chars[j];
> > +			if (depth == 2) {
> > +				create_dir();
> > +				if (--n == 0)
> > +					return;
> > +				continue;
> > +			}
> > +
> > +			for (k = 0; k < NCHARS; k++) {
> > +				name[2] = chars[k];
> > +				create_dir();
> > +				if (--n == 0)
> > +					return;
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +void usage()
> > +{
> > +	fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
> > +}
> > +
> > +/*
> > + * Create long-name directories
> > + * @argv[1]: directory number
> > + * @argv[2]: parent directory
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +	if (argc != 3) {
> > +		usage();
> > +		return 1;
> > +	}
> > +
> > +	names = atoi(argv[1]);
> > +	if (names > MAX_LEN3 || names <= 0) {
> > +		usage();
> > +		return 1;
> > +	}
> > +
> > +	parent_fd = open(argv[2], O_RDONLY);
> > +	if (parent_fd == -1) {
> > +		perror("open parent dir failed");
> > +		return 1;
> > +	}
> > +
> > +	init_name();
> > +
> > +	create_dirs(names);
> > +
> > +	return 0;
> > +}
> > diff --git a/src/t_create_short_dirs.c b/src/t_create_short_dirs.c
> > new file mode 100644
> > index 00000000..778506e1
> > --- /dev/null
> > +++ b/src/t_create_short_dirs.c
> > @@ -0,0 +1,142 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2009 FUJITSU LIMITED
> > + * Author: Li Zefan <lizf@cn.fujitsu.com>
> > + */
> > +
> > +#define _POSIX_C_SOURCE 200809L
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include "config.h"
> > +
> > +/* NCHARS = 10 + 26 + 26 = 62 */
> > +#define NCHARS      62
> > +#define MAX_LEN1    62
> > +#define MAX_LEN2    (62 * 62)
> > +#define MAX_LEN3    (62 * 62 * 62)
> > +#define MAX_NAMES   (MAX_LEN1 + MAX_LEN2 + MAX_LEN3)
> > +
> > +/* valid characters for a directory name */
> > +char chars[] = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> > +
> > +/* to store the generated directory name */
> > +char name[10];
> > +int names;
> > +int parent_fd;
> > +
> > +void create_dir(void)
> > +{
> > +	if (mkdirat(parent_fd, name, S_IRWXU)) {
> > +		perror("mkdir");
> > +		exit(1);
> > +	}
> > +}
> > +
> > +/*
> > + * create_1 - create length-1 directory names
> > + * @n: how name names to be created
> > + */
> > +void create_1(int n)
> > +{
> > +	int i;
> > +
> > +	name[1] = '\0';
> > +	for (i = 0; i < NCHARS; i++) {
> > +		name[0] = chars[i];
> > +		create_dir();
> > +		if (--n == 0)
> > +			return;
> > +	}
> > +}
> > +
> > +/*
> > + * create_2 - generate length-2 directory names
> > + * @n: how many names to be created
> > + */
> > +void create_2(int n)
> > +{
> > +	int i, j;
> > +
> > +	name[2] = '\0';
> > +	for (i = 0; i < NCHARS; i++) {
> > +		name[0] = chars[i];
> > +		for (j = 0; j < NCHARS; j++) {
> > +			name[1] = chars[j];
> > +			create_dir();
> > +			if (--n == 0)
> > +				return;
> > +		}
> > +	}
> > +}
> > +
> > +/*
> > + * create_3 - generate length-3 directory names
> > + * @n: how many names to be created
> > + */
> > +void create_3(int n)
> > +{
> > +	int i, j, k;
> > +
> > +	name[3] = '\0';
> > +	for (i = 0; i < NCHARS; i++) {
> > +		name[0] = chars[i];
> > +		for (j = 0; j < NCHARS; j++) {
> > +			name[1] = chars[j];
> > +			for (k = 0; k < NCHARS; k++) {
> > +				name[2] = chars[k];
> > +				create_dir();
> > +				if (--n == 0)
> > +					return;
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +void usage()
> > +{
> > +	fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
> > +}
> > +
> > +/*
> > + * Create short-name directoriess
> > + * @argv[1]: director number
> > + * @argv[2]: the parent directory
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +	if (argc != 3) {
> > +		usage();
> > +		return 1;
> > +	}
> > +
> > +	names = atoi(argv[1]);
> > +	if (names > MAX_NAMES || names <= 0) {
> > +		usage();
> > +		return 1;
> > +	}
> > +
> > +	parent_fd = open(argv[2], O_RDONLY);
> > +	if (parent_fd == -1) {
> > +		perror("open parent dir failed");
> > +		return 1;
> > +	}
> > +
> > +	create_1(names);
> > +	if (names <= MAX_LEN1)
> > +		return 0;
> > +
> > +	names -= MAX_LEN1;
> > +	create_2(names);
> > +	if (names <= MAX_LEN2)
> > +		return 0;
> > +
> > +	names -= MAX_LEN2;
> > +	create_3(names);
> > +
> > +	return 0;
> > +}
> > diff --git a/src/t_ext4_file_time.c b/src/t_ext4_file_time.c
> > new file mode 100644
> > index 00000000..d0184545
> > --- /dev/null
> > +++ b/src/t_ext4_file_time.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2009 FUJITSU LIMITED
> > + * Author: Li Zefan <lizf@cn.fujitsu.com>
> > + */
> > +
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +
> > +/*
> > + * Usage: file_time <filename> <atime|mtime|ctime> <sec|nsec>
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +	time_t t;
> > +	struct stat st;
> > +
> > +	if (argc != 4) {
> > +		fprintf(stderr, "Wrong argument num!\n");
> > +		return 1;
> > +	}
> > +
> > +	if (stat(argv[1], &st) != 0) {
> > +		perror("stat failed");
> > +		return 1;
> > +	}
> > +
> > +	if (strcmp(argv[3], "sec") == 0) {
> > +		if (strcmp(argv[2], "atime") == 0)
> > +			t = st.st_atime;
> > +		else if (strcmp(argv[2], "mtime") == 0)
> > +			t = st.st_mtime;
> > +		else
> > +			t = st.st_ctime;
> > +	} else if (strcmp(argv[3], "nsec") == 0) {
> > +		if (strcmp(argv[2], "atime") == 0)
> > +			t = st.st_atim.tv_nsec;
> > +		else if (strcmp(argv[2], "mtime") == 0)
> > +			t = st.st_mtim.tv_nsec;
> > +		else
> > +			t = st.st_ctim.tv_nsec;
> > +	} else {
> > +		fprintf(stderr, "Wrong argument: %s\n", argv[3]);
> > +		return 1;
> > +	}
> > +
> > +	printf("%lu\n", t);
> > +
> > +	return 0;
> > +}
> > diff --git a/tests/ext4/043 b/tests/ext4/043
> > new file mode 100755
> > index 00000000..8a9f6d45
> > --- /dev/null
> > +++ b/tests/ext4/043
> > @@ -0,0 +1,56 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 043
> > +#
> > +# Test file timestamps are only precise to seconds with 128-byte inodes."
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext3 ext4
> > +_supported_os Linux
> > +
> > +_require_scratch
> > +_require_test_program "t_ext4_file_time"
> > +
> > +echo "Silence is golden"
> > +
> > +echo "Start test timestamps with 128 inode size one device $SCRATCH_DEV" >$seqres.full
> > +_scratch_mkfs_ext4 -I 128 >> $seqres.full 2>&1
> 
> _scratch_mkfs_ext4 uses mkfs.ext4, which creates filesystem could not be
> mounted by ext3 driver, so when testing ext3 mount fails here.
> 
> Just use _scratch_mkfs.
> 
> > +_scratch_mount
> > +
> > +touch "${SCRATCH_MNT}/tmp_file"
> > +
> > +atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> > +mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> > +ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> > +
> > +if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
> > +        echo "nsec should be zero when extended timestamps are disabled"
> > +        echo "atime: $atime, mtime: $mtime, ctime: $ctime"
> > +fi
> > +
> > +status=0
> > +exit
> > diff --git a/tests/ext4/043.out b/tests/ext4/043.out
> > new file mode 100644
> > index 00000000..f90f0a57
> > --- /dev/null
> > +++ b/tests/ext4/043.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 043
> > +Silence is golden
> > diff --git a/tests/ext4/044 b/tests/ext4/044
> > new file mode 100755
> > index 00000000..a1412684
> > --- /dev/null
> > +++ b/tests/ext4/044
> > @@ -0,0 +1,87 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 044
> > +#
> > +# Test file timestamps are precise to nanoseconds with 256-byte inodes
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext3 ext4
> 
> Test first mounts as ext3 then ext4, when testing ext3 the two mounts
> are all mounted with ext3. I think supporting ext4 only should be fine.
> 
> > +_supported_os Linux
> > +_require_scratch
> > +_require_test_program "t_ext4_file_time"
> > +
> > +echo "Silence is golden"
> > +
> > +echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
> > +_scratch_mkfs_ext4 -t ext3 -I 256 >> $seqres.full 2>&1
> 
> _scratch_mkfs
> 
> > +_scratch_mount
> > +
> > +# Create file
> > +touch "${SCRATCH_MNT}/tmp_file"
> > +sleep 1
> > +
> > +# Change atime, ctime and mtime of the file
> > +touch "${SCRATCH_MNT}/tmp_file"
> > +
> > +cur_time=`date '+%s %N'`
> > +sec=`echo $cur_time | awk {'print $1'}`
> > +nsec=`echo $cur_time | awk {'print $2'}`
> > +
> > +sec_atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime sec`
> > +sec_mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime sec`
> > +sec_ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime sec`
> > +nsec_atime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> > +nsec_mtime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> > +nsec_ctime=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> > +
> > +# Test nanosecond
> > +if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
> > +        _fail "The timestamp is not nanosecond(nsec_atime: $nsec_atime, \ 
> > +              nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime, cur_time[ns]: $nsec)"
> 
> Just echo, no need to _fail.
> 
> > +fi
> > +
> > +# Check difference between file time and current time
> > +[ $(( $sec_atime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
> > +[ $(( $sec_mtime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
>                                                                            mtime       mtime
> > +[ $(( $sec_ctime - $sec )) -gt 1 ] && echo "The timestamp is wrong, sec_atime: $sec_atime, cur_time[s]: $sec"
>                                                                            ctime       ctime
> > +
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# Test mount to ext3 then mount back to ext4 and check timestamp again
> > +_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
> > +_scratch_unmount >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +nsec_atime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> > +nsec_mtime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> > +nsec_ctime2=`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> > +
> > +[ $nsec_atime -ne $nsec_atime2 ] && echo "File nanosecond timestamp atime has changed unexpected from $nsec_atime to $nsec_atime2"
> > +[ $nsec_mtime -ne $nsec_mtime2 ] && echo "File nanosecond timestamp mtime has changed unexpected from $nsec_mtime to $nsec_mtime2"
> > +[ $nsec_ctime -ne $nsec_ctime2 ] && echo "File nanosecond timestamp ctime has changed unexpected from $nsec_ctime to $nsec_ctime2"
> > +
> > +status=0
> > +exit
> > diff --git a/tests/ext4/044.out b/tests/ext4/044.out
> > new file mode 100644
> > index 00000000..12a61dc4
> > --- /dev/null
> > +++ b/tests/ext4/044.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 044
> > +Silence is golden
> > diff --git a/tests/ext4/045 b/tests/ext4/045
> > new file mode 100755
> > index 00000000..76cc5067
> > --- /dev/null
> > +++ b/tests/ext4/045
> > @@ -0,0 +1,134 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 045
> > +#
> > +# Test subdirectory limit of ext4. 
> > +# We create more than 32000 subdirectories on the ext4 filesystem.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +SHORT_DIR=1
> > +LONG_DIR=2
> > +FAIL=1
> > +PASS=0
> > +prev_block_size=0
> > +prev_result=$FAIL
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext4
> > +_supported_os Linux
> > +
> > +_require_scratch
> > +_require_test_program "t_create_short_dirs"
> > +_require_test_program "t_create_long_dirs"
> > +_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
> > +
> > +echo "Silence is golden"
> > +
> > +# Run a test case
> > +# $1: Number of directories to create
> > +# $2: create short dir or long dir
> > +# $3: parent directory
> > +# $4: filesystem block size
> > +workout()
> > +{
> > +    local dir_name_len=
> > +    if [ $2 -eq $SHORT_DIR ]; then
> > +        dir_name_len="short name"
> 
> Use tab as indention in this test.
> 
> > +    else
> > +        dir_name_len="long name"
> > +    fi
> > +
> > +    echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
> > +          "Parent dir: $3, Block size: $4" >> $seqres.full 2>&1
> 
> "2>&1" is not needed.
> 
> > +
> > +    # Only mkfs if block size has been changed, or previous case failed
> > +    if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
> > +        _scratch_mkfs -b $4 -I 256 >> $seqres.full 2>&1
> > +        prev_block_size=$4
> > +    fi
> 
> Why skipping mkfs? Save test time? Need some comments.
> 
> > +    prev_result=$FAIL
> > +
> > +    _scratch_mount
> > +
> > +    # create directories
> > +    mkdir -p $3 2> /dev/null
> > +
> > +    if [ $2 -eq $SHORT_DIR ]; then
> > +        $here/src/t_create_short_dirs $1 $3
> > +    else
> > +        $here/src/t_create_long_dirs $1 $3
> > +    fi
> > +
> > +    if [ $? -ne 0 ]; then
> > +        nr_dirs=`ls $3 | wc -l`
> > +        echo "Failed to create directories - $nr_dirs"
> > +        _scratch_unmount
> > +        return
> > +    fi
> > +
> > +    # delete directories
> > +    cd $3
> > +    ls | xargs rmdir
> > +    if [ $? -ne 0 ]; then
> > +        echo "Failed to remove directories in $3"
> > +        cd - > /dev/null
> > +        _scratch_unmount
> > +        return
> > +    fi
> > +    cd - > /dev/null
> > +    _scratch_unmount
> > +
> > +    # check dir_nlink is set
> > +    $DUMPE2FS_PROG $SCRATCH_DEV 2> /dev/null | grep '^Filesystem features' | grep -q dir_nlink
> 
> dumpe2fs -h <dev> should be fine, there's no need to dump all filesystem
> info.
> 
> > +    if [ $? -ne 0 ]; then
> > +        echo "Feature dir_nlink is not set, please check $seqres.full for detail"
> 
> And it's better to dump dumpe2fs output to $seqres.full as well on
> error.
> 
> > +        return
> > +    fi
> > +
> > +    # run fsck to make sure the filesystem has no errors
> > +    _check_scratch_fs
> 
> I noticed the following errors, 1k 2k 4k blocksize ext4 all failed, is
> that a known issue? Does it fail in LTP as well?
> 
> *** fsck.ext4 output ***
> fsck from util-linux 2.34
> e2fsck 1.45.3 (14-Jul-2019)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Inode 2 ref count is 1, should be 2.  Fix? no
> 
> Pass 5: Checking group summary information
> 
> /dev/mapper/testvg-lv2: ********** WARNING: Filesystem still has errors **********
> 
> /dev/mapper/testvg-lv2: 10/983040 files (10.0% non-contiguous), 164028/7864320 blocks
> *** end fsck.ext4 output
> 
> > +    prev_result=$PASS
> > +}
> > +
> > +# main
> > +DIR_LEN=( $SHORT_DIR $LONG_DIR )
> > +PARENT_DIR=( "$SCRATCH_MNT" "$SCRATCH_MNT/sub" )
> > +BLOCK_SIZE=( 1024 2048 4096 )
> > +
> > +for ((i = 0; i < 3; i++)); do
> > +    for ((j = 0; j < 2; j++)); do
> > +        for ((k = 0; k < 2; k++)); do
> > +            if [ ${DIR_LEN[$k]} -eq $LONG_DIR -a \
> > +                    ${BLOCK_SIZE[$i]} -eq 1024 ]; then
> > +                continue
> > +            fi
> > +            workout 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} ${BLOCK_SIZE[$i]}
> > +        done
> > +    done
> > +done
> > +
> > +status=0
> > +exit
> > diff --git a/tests/ext4/045.out b/tests/ext4/045.out
> > new file mode 100644
> > index 00000000..66276cfa
> > --- /dev/null
> > +++ b/tests/ext4/045.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 045
> > +Silence is golden
> > diff --git a/tests/ext4/group b/tests/ext4/group
> > index 9dfc0d35..9c2f600b 100644
> > --- a/tests/ext4/group
> > +++ b/tests/ext4/group
> > @@ -45,6 +45,9 @@
> >  040 dangerous_fuzzers
> >  041 dangerous_fuzzers
> >  042 auto quick
> > +043 auto quick
> > +044 auto quick
> > +045 auto quick dir
> 
> 045 is not quick.
> 
> Thanks,
> Eryu
> 
> >  271 auto rw quick
> >  301 aio auto ioctl rw stress defrag
> >  302 aio auto ioctl rw stress defrag
> > -- 
> > 2.24.0
> > 

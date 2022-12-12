Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633564A8D3
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Dec 2022 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiLLUk5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Dec 2022 15:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiLLUkz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Dec 2022 15:40:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A6018363
        for <linux-ext4@vger.kernel.org>; Mon, 12 Dec 2022 12:40:54 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s7so13339631plk.5
        for <linux-ext4@vger.kernel.org>; Mon, 12 Dec 2022 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TftdlErwvAqVUyxPMHZOxKXP9BDxoXEUOG2rihSbii8=;
        b=ACnBOiLxbGucUETdC4ZGZB8RbW+JDiTnmSP5MlTWkddox2mvBRqIK3YhZQmCyu+X/Y
         WXEgHSqoaF0pX6ASDquA/aBNOPndIUxihaYDbrKNEjgOu0PLYd0hbxd3gFi/tGniTLJw
         qVHdhK0VIgQhhFkV5xbK60JzmT0YPyi2POvhwRf37M62GM6JYu1U+fiEg48jmlRfAj58
         8VbY3ZS65vn46KRthur+Wn2Y057Vmgm9TROoey8Zun7H8ESrYiEUDXd368MxjPVB/nP8
         jjatrdrw7Z9vAZUBAEGYXINRXeBK9dAQUHm50nBO/B05iB6ym0PLV0PEPfb8KycK+llr
         sVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TftdlErwvAqVUyxPMHZOxKXP9BDxoXEUOG2rihSbii8=;
        b=lFmFE7JkzM55Nkqyjm+hcsvteqTr/NMQjawFhGHJgh4uqAq4uwkRCp17OwcpqJvA7I
         N6nzqAMdU3lQuP2U8KKzSsF0VNqYqy8Xxr7M4umXfh5bdiMmnytfhrPyLhn03MMVolya
         +7x0Yhe+0KNKl1f7eC6D5ra7VYPN/YB34fEPfkipD6KTgJTQibkLiZPFCNmo9Cn7hCH3
         d1iD4HA1crZMe/km8FVmT/tni7+0f9b6b7OUkmXXtxixMye3RctM8z3pWdZNzpY2/uUA
         pLMdE77WkfKFhwoXCu9MWDhWFXksD+ErdtEeTWI3A+Lthy1lHKOMLWyU0rDJRC79V+d2
         eL8g==
X-Gm-Message-State: ANoB5pnEeP+Xx+nkv2o8K+1H1q6ld/M6LL3b1a8/REMxjZ86f5y9Y2k8
        932txpwYgyiRggJAy9POwkOL+A==
X-Google-Smtp-Source: AA0mqf7NnEV2i9Z2UUqXDPnVvb4eYN9XwILxGF6OvOWnJeWKTKaRHu24RmWx7VgyDg9waikmbwOiCQ==
X-Received: by 2002:a17:903:2012:b0:189:d3dc:a9c6 with SMTP id s18-20020a170903201200b00189d3dca9c6mr16520303pla.19.1670877653725;
        Mon, 12 Dec 2022 12:40:53 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00189c62eac37sm6833504plx.32.2022.12.12.12.40.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 12:40:52 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <32332C9A-5C17-4346-9139-A144019F9CA0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C66A4366-5AF5-4546-B68A-BDFBD8B7FD18";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 14/72] tst_bitmaps_standalone: Add copy and merge bitmaps
 test
Date:   Mon, 12 Dec 2022 13:40:50 -0700
In-Reply-To: <a3c770546c5bc907826f7d770ebf516f369d76bd.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <a3c770546c5bc907826f7d770ebf516f369d76bd.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C66A4366-5AF5-4546-B68A-BDFBD8B7FD18
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> This adds a basic copy and merge api test for rbtree bitmap type.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for adding this test.  It looks like it is only testing the =
default
rbtree bitmap type.  It would be good to also add a test for regular =
bitmaps.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/Makefile.in              |  25 +++-
> lib/ext2fs/tst_bitmaps_standalone.c | 170 ++++++++++++++++++++++++++++
> 2 files changed, 189 insertions(+), 6 deletions(-)
> create mode 100644 lib/ext2fs/tst_bitmaps_standalone.c
>=20
> diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
> index f6a050a2..1692500e 100644
> --- a/lib/ext2fs/Makefile.in
> +++ b/lib/ext2fs/Makefile.in
> @@ -227,6 +227,7 @@ SRCS=3D ext2_err.c \
> 	$(srcdir)/write_bb_file.c \
> 	$(srcdir)/rbtree.c \
> 	$(srcdir)/tst_libext2fs.c \
> +	$(srcdir)/tst_bitmaps_standalone.c \
> 	$(DEBUG_SRCS)
>=20
> HFILES=3D bitops.h ext2fs.h ext2_io.h ext2_fs.h ext2_ext_attr.h =
ext3_extents.h \
> @@ -328,9 +329,9 @@ tst_getsectsize: tst_getsectsize.o getsectsize.o =
$(STATIC_LIBEXT2FS) \
> 		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) =
\
> 		$(SYSLIBS)
>=20
> -tst_types.o: $(srcdir)/tst_types.c ext2_types.h
> +tst_types.o: $(srcdir)/tst_types.c ext2_types.h
>=20
> -tst_types: tst_types.o ext2_types.h
> +tst_types: tst_types.o ext2_types.h
> 	$(E) "	LD $@"
> 	$(Q) $(CC) -o tst_types tst_types.o $(ALL_LDFLAGS) $(SYSLIBS)
>=20
> @@ -362,6 +363,11 @@ tst_sha512: $(srcdir)/sha512.c =
$(srcdir)/ext2_fs.h
> 	$(Q) $(CC) $(ALL_LDFLAGS) $(ALL_CFLAGS) -o tst_sha512 \
> 		$(srcdir)/sha512.c -DUNITTEST $(SYSLIBS)
>=20
> +tst_bitmaps_standalone: tst_bitmaps_standalone.o $(STATIC_LIBEXT2FS) =
$(DEPSTATIC_LIBCOM_ERR)
> +	$(E) "	LD $@"
> +	$(Q) $(CC) -o tst_bitmaps_standalone tst_bitmaps_standalone.o =
$(ALL_LDFLAGS) \
> +		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
> +
> ext2_tdbtool: tdbtool.o
> 	$(E) "	LD $@"
> 	$(Q) $(CC) -o ext2_tdbtool tdbtool.o tdb.o $(ALL_LDFLAGS) =
$(SYSLIBS)
> @@ -533,7 +539,7 @@ mkjournal: mkjournal.c $(STATIC_LIBEXT2FS) =
$(DEPLIBCOM_ERR)
> fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types =
tst_icount \
>     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c =
tst_bitmaps \
>     tst_inline tst_inline_data tst_libext2fs tst_sha256 tst_sha512 \
> -    tst_digest_encode tst_getsize tst_getsectsize
> +    tst_digest_encode tst_getsize tst_getsectsize =
tst_bitmaps_standalone
> 	$(TESTENV) ./tst_bitops
> 	$(TESTENV) ./tst_badblocks
> 	$(TESTENV) ./tst_iscan
> @@ -556,6 +562,7 @@ fullcheck check:: tst_bitops tst_badblocks =
tst_iscan tst_types tst_icount \
> 	$(TESTENV) ./tst_bitmaps -l -f $(srcdir)/tst_bitmaps_cmds > =
tst_bitmaps_out
> 	diff $(srcdir)/tst_bitmaps_exp tst_bitmaps_out
> 	$(TESTENV) ./tst_digest_encode
> +	$(TESTENV) ./tst_bitmaps_standalone
>=20
> installdirs::
> 	$(E) "	MKDIR_P $(libdir) $(includedir)/ext2fs"
> @@ -581,7 +588,7 @@ install:: all $(HFILES) $(HFILES_IN) installdirs =
ext2fs.pc
> uninstall::
> 	$(RM) -f $(DESTDIR)$(libdir)/libext2fs.a \
> 		$(DESTDIR)$(pkgconfigdir)/ext2fs.pc
> -	$(RM) -rf $(DESTDIR)$(includedir)/ext2fs
> +	$(RM) -rf $(DESTDIR)$(includedir)/ext2fs
>=20
> clean::
> 	$(RM) -f \#* *.s *.o *.a *~ *.bak core profiled/* \
> @@ -590,7 +597,7 @@ clean::
> 		tst_bitops tst_types tst_icount tst_super_size tst_csum =
\
> 		tst_bitmaps tst_bitmaps_out tst_extents tst_inline \
> 		tst_inline_data tst_inode_size tst_bitmaps_cmd.c \
> -		tst_digest_encode tst_sha256 tst_sha512 \
> +		tst_digest_encode tst_sha256 tst_sha512  =
tst_bitmaps_standalone \
> 		ext2_tdbtool mkjournal debug_cmds.c tst_cmds.c =
extent_cmds.c \
> 		../libext2fs.a ../libext2fs_p.a ../libext2fs_chk.a \
> 		crc32c_table.h gen_crc32ctable tst_crc32c tst_libext2fs =
\
> @@ -646,7 +653,7 @@ windows_io.o: $(srcdir)/windows_io.c =
$(top_builddir)/lib/config.h \
>  $(srcdir)/ext2_ext_attr.h $(srcdir)/bitops.h $(srcdir)/ext2fsP.h
>=20
> # +++ Dependency line eater +++
> -#
> +#
> # Makefile dependencies follow.  This must be the last section in
> # the Makefile.in file
> #
> @@ -1156,6 +1163,12 @@ tst_iscan.o: $(srcdir)/tst_iscan.c =
$(top_builddir)/lib/config.h \
>  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
>  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
>  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
> +tst_bitmaps_standalone.o: $(srcdir)/tst_bitmaps_standalone.c =
$(top_builddir)/lib/config.h \
> + $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
> + $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
> + $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h =
$(top_srcdir)/lib/et/com_err.h \
> + $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
> + $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
> undo_io.o: $(srcdir)/undo_io.c $(top_builddir)/lib/config.h \
>  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
>  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
> diff --git a/lib/ext2fs/tst_bitmaps_standalone.c =
b/lib/ext2fs/tst_bitmaps_standalone.c
> new file mode 100644
> index 00000000..68b598a8
> --- /dev/null
> +++ b/lib/ext2fs/tst_bitmaps_standalone.c
> @@ -0,0 +1,170 @@
> +#include "config.h"
> +#include <stdio.h>
> +#include <string.h>
> +#include <assert.h>
> +#if HAVE_UNISTD_H
> +#include <unistd.h>
> +#endif
> +#include <fcntl.h>
> +#include <time.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#if HAVE_ERRNO_H
> +#include <errno.h>
> +#endif
> +
> +#include "ext2_fs.h"
> +#include "ext2fs.h"
> +#include "bmap64.h"
> +
> +ext2_filsys test_fs;
> +ext2fs_block_bitmap block_map_1;
> +ext2fs_block_bitmap block_map_2;
> +ext2fs_block_bitmap block_map;
> +
> +static int test_fail =3D 0;
> +
> +void dump_bitmap(ext2fs_generic_bitmap bmap, unsigned int start, =
unsigned num)
> +{
> +	unsigned char	*buf;
> +	errcode_t	retval;
> +	int	i, len =3D (num - start + 7) / 8;
> +
> +	buf =3D malloc(len);
> +	if (!buf) {
> +		com_err("dump_bitmap", 0, "couldn't allocate buffer");
> +		return;
> +	}
> +	memset(buf, 0, len);
> +	retval =3D ext2fs_get_generic_bmap_range(bmap, (__u64) start, =
num, buf);
> +	if (retval) {
> +		com_err("dump_bitmap", retval,
> +			"while calling ext2fs_generic_bmap_range");
> +		free(buf);
> +		return;
> +	}
> +	for (i=3Dlen-1; i >=3D 0; i--)
> +		printf("%02x ", buf[i]);
> +	printf("\n");
> +	printf("bits set: %u\n", ext2fs_bitcount(buf, len));
> +	free(buf);
> +}
> +
> +static void test_copy_run()
> +{
> +	int blocks[] =3D {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 23, 26, 29, =
33, 37, 38};
> +	errcode_t ret;
> +	char *buf_map =3D NULL;
> +	char *buf_copy_map =3D NULL;
> +
> +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap", =
&block_map_1) =3D=3D 0);
> +
> +	for (int i =3D 0; i < sizeof(blocks)/sizeof(blocks[0]); i++) {
> +		ext2fs_mark_block_bitmap2(block_map_1, blocks[i]);
> +	}
> +
> +	assert(ext2fs_copy_bitmap(block_map_1, &block_map) =3D=3D 0);
> +
> +	if (ext2fs_compare_block_bitmap(block_map_1, block_map) !=3D 0) =
{
> +		printf("block bitmap copy test failed\n");
> +		test_fail++;
> +
> +		dump_bitmap(block_map_1, =
test_fs->super->s_first_data_block,
> +				test_fs->super->s_blocks_count);
> +
> +		dump_bitmap(block_map, =
test_fs->super->s_first_data_block,
> +				test_fs->super->s_blocks_count);
> +	}
> +
> +	ext2fs_free_block_bitmap(block_map_1);
> +	ext2fs_free_block_bitmap(block_map);
> +}
> +
> +void test_merge_run()
> +{
> +	int blocks_odd[] =3D {1, 3, 5, 7, 9, 21, 23, 29, 33, 37};
> +	int blocks_even[] =3D {2, 4, 6, 8, 10, 26, 38};
> +	ext2fs_generic_bitmap_64 tmp_map;
> +
> +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 1", =
&block_map_1) =3D=3D 0);
> +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 2", =
&block_map_2) =3D=3D 0);
> +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 2", =
&block_map) =3D=3D 0);
> +
> +	for (int i =3D 0; i < sizeof(blocks_odd) / =
sizeof(blocks_odd[0]); i++) {
> +		ext2fs_mark_block_bitmap2(block_map_1, blocks_odd[i]);
> +		ext2fs_mark_block_bitmap2(block_map, blocks_odd[i]);
> +	}
> +
> +	for (int i =3D 0; i < sizeof(blocks_even) / =
sizeof(blocks_even[0]); i++) {
> +		ext2fs_mark_block_bitmap2(block_map_2, blocks_even[i]);
> +		ext2fs_mark_block_bitmap2(block_map, blocks_even[i]);
> +	}
> +
> +	assert(ext2fs_merge_bitmap(block_map_2, block_map_1, NULL, NULL) =
=3D=3D 0);
> +	if (ext2fs_compare_block_bitmap(block_map_1, block_map) !=3D 0) =
{
> +		printf("block bitmap merge test failed\n");
> +		test_fail++;
> +
> +		dump_bitmap(block_map_1, =
test_fs->super->s_first_data_block,
> +				test_fs->super->s_blocks_count);
> +
> +		dump_bitmap(block_map, =
test_fs->super->s_first_data_block,
> +				test_fs->super->s_blocks_count);
> +	}
> +
> +	ext2fs_free_block_bitmap(block_map_1);
> +	ext2fs_free_block_bitmap(block_map_2);
> +	ext2fs_free_block_bitmap(block_map);
> +}
> +
> +static void setup_filesystem(const char *name, unsigned int blocks,
> +							 unsigned int =
inodes, unsigned int type,
> +							 unsigned int =
flags)
> +{
> +	struct ext2_super_block param;
> +	errcode_t ret;
> +
> +	memset(&param, 0, sizeof(param));
> +	ext2fs_blocks_count_set(&param, blocks);
> +	param.s_inodes_count =3D inodes;
> +
> +	ret =3D ext2fs_initialize(name, flags, &param, test_io_manager,
> +							&test_fs);
> +	if (ret) {
> +		com_err(name, ret, "while initializing filesystem");
> +		return;
> +	}
> +
> +	test_fs->default_bitmap_type =3D type;
> +
> +	ext2fs_free_block_bitmap(test_fs->block_map);
> +	ext2fs_free_block_bitmap(test_fs->inode_map);
> +
> +	return;
> +errout:
> +	ext2fs_close_free(&test_fs);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned int blocks =3D 127;
> +	unsigned int inodes =3D 0;
> +	unsigned int type =3D EXT2FS_BMAP64_RBTREE;
> +	unsigned int flags =3D EXT2_FLAG_64BITS;
> +	char *buf =3D NULL;
> +
> +	setup_filesystem(argv[0], blocks, inodes, type, flags);
> +
> +	/* test for EXT2FS_BMAP64_RBTREE */
> +	test_copy_run();
> +	test_merge_run();
> +
> +	/* TODO: test for EXT2FS_BMAP64_BITARRAY */
> +
> +	if (test_fail)
> +		printf("%s: Test copy & merge bitmaps -- NOT OK\n", =
argv[0]);
> +	else
> +		printf("%s: Test copy & merge bitmaps -- OK\n", =
argv[0]);
> +
> +	return test_fail;
> +}
> --
> 2.37.3
>=20


Cheers, Andreas






--Apple-Mail=_C66A4366-5AF5-4546-B68A-BDFBD8B7FD18
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOXkdIACgkQcqXauRfM
H+CXqw/9GRTl5lRcH9IX4sw5Ilsy3+J6KTx85BLHfY8jiZ/6l7NNznMYpRftYUXb
qg9bq1SwU/dYNLlHZzcruP31amP8q7MJKS0/6H3iv6q4PnD0JeeiH1DtJ/CNB5Yj
BRsEmP7oClFZnlGI80bo5Kvdo33hjInWzd+kMOilf9zHLGqcxMD31caQKCHEHOyc
W1i2omY1MmxOh+Az9lbnD9GA/br3AVLtIxSvQjOO5+sKQbzpKblx4UD4mV9bSu1P
iQ5oNlBsfdevYeDQAHO9bd9PUbBnhwicKt0XNx+nFZEZ/h5z/KuDjxEi2aBhI7/y
jnf706Rp5IgvJAUWJeBk2DTD/aCX/eDlYI8O8TbL3G5t8h/JIh8uKPWRuymd0PE5
KGWy0mTjOqYWVBusMsSgPO0QETUEpV7i7j17Fpfe+2TlMizk+tsuBl7G6w+Owmxf
dxpkM9vo1H8wdlj4jgCjLtsiRmCv8ckTX9ebuDo17hv+9TEGmsNje5VodRXpGnks
aRfZJHfqT+DgpOlk0fL+4bqJcqk/eSgCnov0PgZbwSkJaFT0/a1GXAwNDAdkWmwz
4MQOB9Z4HvhIGi1uCTr5F6VKRg3ayRvsa0bziI9YR8Y6Jgh41tJa6CcmY4/nTY/B
kU6hVwiqVnlM5pl+FuP58zKYyIngBcYpwX6TXs0ajKbYrikEnHk=
=mlYW
-----END PGP SIGNATURE-----

--Apple-Mail=_C66A4366-5AF5-4546-B68A-BDFBD8B7FD18--

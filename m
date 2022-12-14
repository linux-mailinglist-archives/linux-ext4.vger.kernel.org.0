Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA70F64C374
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 06:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiLNFNC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 00:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNFM6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 00:12:58 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62962EE
        for <linux-ext4@vger.kernel.org>; Tue, 13 Dec 2022 21:12:54 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h33so1259677pgm.9
        for <linux-ext4@vger.kernel.org>; Tue, 13 Dec 2022 21:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAbE69SNDvB/4CRYM77QQjapMYpPFS9n7pRyTEL6fFs=;
        b=L5gdfghuvczi0a89evYZJ0sFRdl6zQ7vdqMKYER4hIwSfEqVyFn/pyqdPlgWe6GqZ4
         jnKUYL7tiUr68dQUEeDrxOuKi7FCkG1veL2j8bJ7g/KH2+SczUBNKh1BPPjrjIIAluBB
         t8rDW+4CixoG45RsrcoGJIEihCKQ9EJunHij8DzP5L8ILFHP+5rI6jo3TPVaSuMozjon
         1G6dbTl+b8tnri233fAiLehmtiZUsDu2mYfPThnBXgy/5/53uItmZuRzIv9P7pb8A+aP
         G+VS3apElzRZz6nBwS/qQWddPqVPI0vatSUFW4bamHvaRBU/o/ssitfVMQ19E+v4o/16
         rmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAbE69SNDvB/4CRYM77QQjapMYpPFS9n7pRyTEL6fFs=;
        b=W0c3y2hdSODIDNB6zZOUKoLnz8Rmwl/wXsyM9yBVXj0+yifFtnPzkOebl099Yalqix
         UOlBEww6LGMc+nMAtv5frwhuPRVToBx9UyqVFnAlTHQy5qY3GWu0A74xMCtW0ialmuk5
         4ThNTwcZL4/B/APjiTAI8VwGeIJ1zhppC3QGIkcW9zW9dNx1Aj08UUCBOdm3C/m4L0Xc
         fC8f8n6vdXobM0zxQFIh83DUnKa2erZBb/eMQ+URjSMIULVfxyVqbB3z969JQDz1V4d5
         RKmx/8bunaw5KnzQsGkuiuVUjoMFW7hU+fDSut0kYwmH11AzBPyB5OImOdJz/SynEU0y
         +jaA==
X-Gm-Message-State: ANoB5pnwWA7Vi87tojwTjbpb3i35EOdHuidIPrwjnsVqI1eZYdW8K05t
        mZgYfko2vc5SGSMVkH1d5Tw=
X-Google-Smtp-Source: AA0mqf4wTMmLb5ijLLq7ywLA6Sx5deBe5kshaWH8Ot8XOkTxsRQW/6LGahshm3QC5o5CQNnXKUL3KQ==
X-Received: by 2002:a05:6a00:213b:b0:576:f322:419f with SMTP id n27-20020a056a00213b00b00576f322419fmr26731287pfj.28.1670994774091;
        Tue, 13 Dec 2022 21:12:54 -0800 (PST)
Received: from localhost ([2406:7400:63:8d45:3ef0:997c:274b:175a])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79891000000b00576f7bd92cdsm8737906pfl.14.2022.12.13.21.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 21:12:53 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:42:48 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>
Subject: Re: [RFCv1 14/72] tst_bitmaps_standalone: Add copy and merge bitmaps
 test
Message-ID: <20221214051248.lq7uamorf7hx6h7j@riteshh-domain>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <a3c770546c5bc907826f7d770ebf516f369d76bd.1667822611.git.ritesh.list@gmail.com>
 <32332C9A-5C17-4346-9139-A144019F9CA0@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32332C9A-5C17-4346-9139-A144019F9CA0@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/12 01:40PM, Andreas Dilger wrote:
> On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> >
> > This adds a basic copy and merge api test for rbtree bitmap type.
> >
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> Thanks for adding this test.  It looks like it is only testing the default
> rbtree bitmap type.  It would be good to also add a test for regular bitmaps.

sure, the test will also requires merge logic for regular bitmap.
I had added some basic support earlier (non-aligned was remaining to be added).
In the next iteration, I will keep a note about this.

>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks for the review!

>
> > ---
> > lib/ext2fs/Makefile.in              |  25 +++-
> > lib/ext2fs/tst_bitmaps_standalone.c | 170 ++++++++++++++++++++++++++++
> > 2 files changed, 189 insertions(+), 6 deletions(-)
> > create mode 100644 lib/ext2fs/tst_bitmaps_standalone.c
> >
> > diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
> > index f6a050a2..1692500e 100644
> > --- a/lib/ext2fs/Makefile.in
> > +++ b/lib/ext2fs/Makefile.in
> > @@ -227,6 +227,7 @@ SRCS= ext2_err.c \
> > 	$(srcdir)/write_bb_file.c \
> > 	$(srcdir)/rbtree.c \
> > 	$(srcdir)/tst_libext2fs.c \
> > +	$(srcdir)/tst_bitmaps_standalone.c \
> > 	$(DEBUG_SRCS)
> >
> > HFILES= bitops.h ext2fs.h ext2_io.h ext2_fs.h ext2_ext_attr.h ext3_extents.h \
> > @@ -328,9 +329,9 @@ tst_getsectsize: tst_getsectsize.o getsectsize.o $(STATIC_LIBEXT2FS) \
> > 		$(ALL_LDFLAGS) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
> > 		$(SYSLIBS)
> >
> > -tst_types.o: $(srcdir)/tst_types.c ext2_types.h
> > +tst_types.o: $(srcdir)/tst_types.c ext2_types.h
> >
> > -tst_types: tst_types.o ext2_types.h
> > +tst_types: tst_types.o ext2_types.h
> > 	$(E) "	LD $@"
> > 	$(Q) $(CC) -o tst_types tst_types.o $(ALL_LDFLAGS) $(SYSLIBS)
> >
> > @@ -362,6 +363,11 @@ tst_sha512: $(srcdir)/sha512.c $(srcdir)/ext2_fs.h
> > 	$(Q) $(CC) $(ALL_LDFLAGS) $(ALL_CFLAGS) -o tst_sha512 \
> > 		$(srcdir)/sha512.c -DUNITTEST $(SYSLIBS)
> >
> > +tst_bitmaps_standalone: tst_bitmaps_standalone.o $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBCOM_ERR)
> > +	$(E) "	LD $@"
> > +	$(Q) $(CC) -o tst_bitmaps_standalone tst_bitmaps_standalone.o $(ALL_LDFLAGS) \
> > +		$(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) $(SYSLIBS)
> > +
> > ext2_tdbtool: tdbtool.o
> > 	$(E) "	LD $@"
> > 	$(Q) $(CC) -o ext2_tdbtool tdbtool.o tdb.o $(ALL_LDFLAGS) $(SYSLIBS)
> > @@ -533,7 +539,7 @@ mkjournal: mkjournal.c $(STATIC_LIBEXT2FS) $(DEPLIBCOM_ERR)
> > fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
> >     tst_super_size tst_types tst_inode_size tst_csum tst_crc32c tst_bitmaps \
> >     tst_inline tst_inline_data tst_libext2fs tst_sha256 tst_sha512 \
> > -    tst_digest_encode tst_getsize tst_getsectsize
> > +    tst_digest_encode tst_getsize tst_getsectsize tst_bitmaps_standalone
> > 	$(TESTENV) ./tst_bitops
> > 	$(TESTENV) ./tst_badblocks
> > 	$(TESTENV) ./tst_iscan
> > @@ -556,6 +562,7 @@ fullcheck check:: tst_bitops tst_badblocks tst_iscan tst_types tst_icount \
> > 	$(TESTENV) ./tst_bitmaps -l -f $(srcdir)/tst_bitmaps_cmds > tst_bitmaps_out
> > 	diff $(srcdir)/tst_bitmaps_exp tst_bitmaps_out
> > 	$(TESTENV) ./tst_digest_encode
> > +	$(TESTENV) ./tst_bitmaps_standalone
> >
> > installdirs::
> > 	$(E) "	MKDIR_P $(libdir) $(includedir)/ext2fs"
> > @@ -581,7 +588,7 @@ install:: all $(HFILES) $(HFILES_IN) installdirs ext2fs.pc
> > uninstall::
> > 	$(RM) -f $(DESTDIR)$(libdir)/libext2fs.a \
> > 		$(DESTDIR)$(pkgconfigdir)/ext2fs.pc
> > -	$(RM) -rf $(DESTDIR)$(includedir)/ext2fs
> > +	$(RM) -rf $(DESTDIR)$(includedir)/ext2fs
> >
> > clean::
> > 	$(RM) -f \#* *.s *.o *.a *~ *.bak core profiled/* \
> > @@ -590,7 +597,7 @@ clean::
> > 		tst_bitops tst_types tst_icount tst_super_size tst_csum \
> > 		tst_bitmaps tst_bitmaps_out tst_extents tst_inline \
> > 		tst_inline_data tst_inode_size tst_bitmaps_cmd.c \
> > -		tst_digest_encode tst_sha256 tst_sha512 \
> > +		tst_digest_encode tst_sha256 tst_sha512  tst_bitmaps_standalone \
> > 		ext2_tdbtool mkjournal debug_cmds.c tst_cmds.c extent_cmds.c \
> > 		../libext2fs.a ../libext2fs_p.a ../libext2fs_chk.a \
> > 		crc32c_table.h gen_crc32ctable tst_crc32c tst_libext2fs \
> > @@ -646,7 +653,7 @@ windows_io.o: $(srcdir)/windows_io.c $(top_builddir)/lib/config.h \
> >  $(srcdir)/ext2_ext_attr.h $(srcdir)/bitops.h $(srcdir)/ext2fsP.h
> >
> > # +++ Dependency line eater +++
> > -#
> > +#
> > # Makefile dependencies follow.  This must be the last section in
> > # the Makefile.in file
> > #
> > @@ -1156,6 +1163,12 @@ tst_iscan.o: $(srcdir)/tst_iscan.c $(top_builddir)/lib/config.h \
> >  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
> >  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
> >  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
> > +tst_bitmaps_standalone.o: $(srcdir)/tst_bitmaps_standalone.c $(top_builddir)/lib/config.h \
> > + $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
> > + $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
> > + $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
> > + $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
> > + $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h
> > undo_io.o: $(srcdir)/undo_io.c $(top_builddir)/lib/config.h \
> >  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
> >  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
> > diff --git a/lib/ext2fs/tst_bitmaps_standalone.c b/lib/ext2fs/tst_bitmaps_standalone.c
> > new file mode 100644
> > index 00000000..68b598a8
> > --- /dev/null
> > +++ b/lib/ext2fs/tst_bitmaps_standalone.c
> > @@ -0,0 +1,170 @@
> > +#include "config.h"
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <assert.h>
> > +#if HAVE_UNISTD_H
> > +#include <unistd.h>
> > +#endif
> > +#include <fcntl.h>
> > +#include <time.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#if HAVE_ERRNO_H
> > +#include <errno.h>
> > +#endif
> > +
> > +#include "ext2_fs.h"
> > +#include "ext2fs.h"
> > +#include "bmap64.h"
> > +
> > +ext2_filsys test_fs;
> > +ext2fs_block_bitmap block_map_1;
> > +ext2fs_block_bitmap block_map_2;
> > +ext2fs_block_bitmap block_map;
> > +
> > +static int test_fail = 0;
> > +
> > +void dump_bitmap(ext2fs_generic_bitmap bmap, unsigned int start, unsigned num)
> > +{
> > +	unsigned char	*buf;
> > +	errcode_t	retval;
> > +	int	i, len = (num - start + 7) / 8;
> > +
> > +	buf = malloc(len);
> > +	if (!buf) {
> > +		com_err("dump_bitmap", 0, "couldn't allocate buffer");
> > +		return;
> > +	}
> > +	memset(buf, 0, len);
> > +	retval = ext2fs_get_generic_bmap_range(bmap, (__u64) start, num, buf);
> > +	if (retval) {
> > +		com_err("dump_bitmap", retval,
> > +			"while calling ext2fs_generic_bmap_range");
> > +		free(buf);
> > +		return;
> > +	}
> > +	for (i=len-1; i >= 0; i--)
> > +		printf("%02x ", buf[i]);
> > +	printf("\n");
> > +	printf("bits set: %u\n", ext2fs_bitcount(buf, len));
> > +	free(buf);
> > +}
> > +
> > +static void test_copy_run()
> > +{
> > +	int blocks[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 21, 23, 26, 29, 33, 37, 38};
> > +	errcode_t ret;
> > +	char *buf_map = NULL;
> > +	char *buf_copy_map = NULL;
> > +
> > +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap", &block_map_1) == 0);
> > +
> > +	for (int i = 0; i < sizeof(blocks)/sizeof(blocks[0]); i++) {
> > +		ext2fs_mark_block_bitmap2(block_map_1, blocks[i]);
> > +	}
> > +
> > +	assert(ext2fs_copy_bitmap(block_map_1, &block_map) == 0);
> > +
> > +	if (ext2fs_compare_block_bitmap(block_map_1, block_map) != 0) {
> > +		printf("block bitmap copy test failed\n");
> > +		test_fail++;
> > +
> > +		dump_bitmap(block_map_1, test_fs->super->s_first_data_block,
> > +				test_fs->super->s_blocks_count);
> > +
> > +		dump_bitmap(block_map, test_fs->super->s_first_data_block,
> > +				test_fs->super->s_blocks_count);
> > +	}
> > +
> > +	ext2fs_free_block_bitmap(block_map_1);
> > +	ext2fs_free_block_bitmap(block_map);
> > +}
> > +
> > +void test_merge_run()
> > +{
> > +	int blocks_odd[] = {1, 3, 5, 7, 9, 21, 23, 29, 33, 37};
> > +	int blocks_even[] = {2, 4, 6, 8, 10, 26, 38};
> > +	ext2fs_generic_bitmap_64 tmp_map;
> > +
> > +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 1", &block_map_1) == 0);
> > +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 2", &block_map_2) == 0);
> > +	assert(ext2fs_allocate_block_bitmap(test_fs, "block bitmap 2", &block_map) == 0);
> > +
> > +	for (int i = 0; i < sizeof(blocks_odd) / sizeof(blocks_odd[0]); i++) {
> > +		ext2fs_mark_block_bitmap2(block_map_1, blocks_odd[i]);
> > +		ext2fs_mark_block_bitmap2(block_map, blocks_odd[i]);
> > +	}
> > +
> > +	for (int i = 0; i < sizeof(blocks_even) / sizeof(blocks_even[0]); i++) {
> > +		ext2fs_mark_block_bitmap2(block_map_2, blocks_even[i]);
> > +		ext2fs_mark_block_bitmap2(block_map, blocks_even[i]);
> > +	}
> > +
> > +	assert(ext2fs_merge_bitmap(block_map_2, block_map_1, NULL, NULL) == 0);
> > +	if (ext2fs_compare_block_bitmap(block_map_1, block_map) != 0) {
> > +		printf("block bitmap merge test failed\n");
> > +		test_fail++;
> > +
> > +		dump_bitmap(block_map_1, test_fs->super->s_first_data_block,
> > +				test_fs->super->s_blocks_count);
> > +
> > +		dump_bitmap(block_map, test_fs->super->s_first_data_block,
> > +				test_fs->super->s_blocks_count);
> > +	}
> > +
> > +	ext2fs_free_block_bitmap(block_map_1);
> > +	ext2fs_free_block_bitmap(block_map_2);
> > +	ext2fs_free_block_bitmap(block_map);
> > +}
> > +
> > +static void setup_filesystem(const char *name, unsigned int blocks,
> > +							 unsigned int inodes, unsigned int type,
> > +							 unsigned int flags)
> > +{
> > +	struct ext2_super_block param;
> > +	errcode_t ret;
> > +
> > +	memset(&param, 0, sizeof(param));
> > +	ext2fs_blocks_count_set(&param, blocks);
> > +	param.s_inodes_count = inodes;
> > +
> > +	ret = ext2fs_initialize(name, flags, &param, test_io_manager,
> > +							&test_fs);
> > +	if (ret) {
> > +		com_err(name, ret, "while initializing filesystem");
> > +		return;
> > +	}
> > +
> > +	test_fs->default_bitmap_type = type;
> > +
> > +	ext2fs_free_block_bitmap(test_fs->block_map);
> > +	ext2fs_free_block_bitmap(test_fs->inode_map);
> > +
> > +	return;
> > +errout:
> > +	ext2fs_close_free(&test_fs);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	unsigned int blocks = 127;
> > +	unsigned int inodes = 0;
> > +	unsigned int type = EXT2FS_BMAP64_RBTREE;
> > +	unsigned int flags = EXT2_FLAG_64BITS;
> > +	char *buf = NULL;
> > +
> > +	setup_filesystem(argv[0], blocks, inodes, type, flags);
> > +
> > +	/* test for EXT2FS_BMAP64_RBTREE */
> > +	test_copy_run();
> > +	test_merge_run();
> > +
> > +	/* TODO: test for EXT2FS_BMAP64_BITARRAY */
> > +
> > +	if (test_fail)
> > +		printf("%s: Test copy & merge bitmaps -- NOT OK\n", argv[0]);
> > +	else
> > +		printf("%s: Test copy & merge bitmaps -- OK\n", argv[0]);
> > +
> > +	return test_fail;
> > +}
> > --
> > 2.37.3
> >
>
>
> Cheers, Andreas
>
>
>
>
>



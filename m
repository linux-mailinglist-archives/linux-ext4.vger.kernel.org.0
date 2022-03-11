Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB84D5EC1
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Mar 2022 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiCKJuc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Mar 2022 04:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiCKJua (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Mar 2022 04:50:30 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57681B9899
        for <linux-ext4@vger.kernel.org>; Fri, 11 Mar 2022 01:49:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id x4so9471307iom.12
        for <linux-ext4@vger.kernel.org>; Fri, 11 Mar 2022 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOeMBrOT8tm6p8WWBXsKzw6sChHxLXnjsSKfeVY6YUs=;
        b=TeYcGHJMSPRE2oVGNF2EqGS7ZRTFOSf7UMIEbIhWzmjBMr0s7fNB+hKgJF8AJ4Dant
         uqRMTb+H1LULj6R6p31mlA520ZCdgL9NByr7j0Zeg0Zhbda9EynWLHszUnCr+C14vBAo
         UH0IZSDRUUiAni0R4ud47Sqlpk627UkEDBzVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOeMBrOT8tm6p8WWBXsKzw6sChHxLXnjsSKfeVY6YUs=;
        b=GkD8qZylwGVuhnHo6hTMMpNQGGvpNVUgixUfMUGBioZKNZ81EIiDJwIyfGakboSMr0
         BNJTOQo7BdJP6L2End20n+23+cySh78JVjQLw7OfTSitE/47HAbjbsoTtO7KuVPpCYzq
         8IQI4hi6Vv+gBM05Ik+mT3pW6mx21o4xXEnU0rC/T4+1hOXxDtZn200t64VfOSMbvlLu
         kncpFaJ1rHpik9PgT+JTZxQ6iscH7Qy6VyNOdV99HE8nlKoCdcxBbA51AomrC7+AdqjQ
         vvtgS6Vu9FtvmgUBx0ERUn5QUV3w0Z0kk+NF3rF+hknJaVTACxl+fYvQSgt7why0DnQb
         1FUw==
X-Gm-Message-State: AOAM5339MBljcT3HCnBCc8KNfKJ+kcvrkPKPKlRtqgRlSZmp2Qzlsmdc
        b3GjS7gQ5aN9449WKHW5I00JHZMzSEpIWb0Gef/eB40X4NEVLw==
X-Google-Smtp-Source: ABdhPJyXrdrkAKgjo8fXLWkOavv03hqd7XKbupqc1o2UgR27bkCudZemEtbmHALz0z6b79yFeeVqhV0KZHG9CUJiT/g=
X-Received: by 2002:a02:a08c:0:b0:314:ede5:1461 with SMTP id
 g12-20020a02a08c000000b00314ede51461mr7998691jah.103.1646992165993; Fri, 11
 Mar 2022 01:49:25 -0800 (PST)
MIME-Version: 1.0
References: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
 <20210927103910.341417-1-sarthakkukreti@chromium.org> <YXYx0iL8Pn/tbxBP@mit.edu>
In-Reply-To: <YXYx0iL8Pn/tbxBP@mit.edu>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 11 Mar 2022 01:49:13 -0800
Message-ID: <CAPUE2uuNy2A_WZt-np57sByDmU4rqYZzcyeRBAz9u1Zqkaxpsg@mail.gmail.com>
Subject: Re: [PATCH v2] mke2fs: Add extended option for prezeroed storage devices
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-ext4@vger.kernel.org, adilger@dilger.ca, okiselev@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ted,

I noticed Sarthak's patch is not in e2fsprogs-1.46.5 December release.
His patch is in the |master| branch (commit bd2e72c5c552 ("mke2fs: add
extended option for prezeroed storage devices")) since September, but
not in the |maint| branch. Other patches were not included as well -
see below. Is it expected?

git log --cherry-mark --oneline --left-right  origin/master...origin/maint
< 96185e9b (origin/next, origin/master, origin/HEAD) Merge branch
'maint' into next
< f85b4526 tune2fs: implement support for set/get label iocts
< 8adeabee Merge branch 'maint' into next
< 02827d06 ext2fs: avoid re-reading inode multiple times
< bd2e72c5 mke2fs: add extended option for prezeroed storage devices
< a8f52588 dumpe2fs, debugfs, e2image: Add support for orphan file
< 795101dd tune2fs: Add support for orphan_file feature
< d0c52ffb e2fsck: Add support for handling orphan file
< 818da4a9 mke2fs: Add support for orphan_file feature
< 1d551c68 libext2fs: Support for orphan file feature

Gwendal.

On Sun, Oct 24, 2021 at 9:25 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> I tried running the regression test, and it was failing for me; it
> showed that even with -E assume_stoarge_prezeroed, the size of the
> $TMPFILE.1 and $TMPFILE.2 was the same.  Looking into this, it was
> because in lib/ext2fs/unix_io.c, when the file is a plain file
> io_channel_discard_zeroes_data() returns true, since it assumes that
> we can use PUNCH_HOLE to implement unix_io_discard(), which is
> guaranteed to work.
>
> So I had to change the regression test to use losetup, which also
> meant that the test had to run as root....
>
> Anyway, this is what I've checked into e2fsprogs.
>
>                                   - Ted
>
> commit bd2e72c5c5521b561d20a881c843a64a5832721a
> Author: Sarthak Kukreti <sarthakkukreti@chromium.org>
> Date:   Mon Sep 27 03:39:10 2021 -0700
>
>     mke2fs: add extended option for prezeroed storage devices
>
>     This patch adds an extended option "assume_storage_prezeroed" to
>     mke2fs. When enabled, this option acts as a hint to mke2fs that the
>     underlying block device was zeroed before mke2fs was called.  This
>     allows mke2fs to optimize out the zeroing of the inode table and the
>     journal, which speeds up the filesystem creation time.
>
>     Additionally, on thinly provisioned storage devices (like Ceph,
>     dm-thin, newly created sparse loopback files), reads on unmapped
>     extents return zero. This property allows mke2fs (with
>     assume_storage_prezeroed) to avoid pre-allocating metadata space for
>     inode tables for the entire filesystem and saves space that would
>     normally be preallocated for zero inode tables.
>
>     Tests
>     -----
>     1) Running 'mke2fs -t ext4' on 10G sparse files on an ext4
>     filesystem drops the time taken by mke2fs from 0.09s to 0.04s
>     and reduces the initial metadata space allocation (stat on
>     sparse file) from 139736 blocks (545M) to 8672 blocks (34M).
>
>     2) On ChromeOS (running linux kernel 4.19) with dm-thin
>     and 200GB thin logical volumes using 'mke2fs -t ext4 <dev>':
>
>     - Time taken by mke2fs drops from 1.07s to 0.08s.
>     - Avoiding zeroing out the inode table and journal reduces the
>       initial metadata space allocation from 0.48% to 0.01%.
>     - Lazy inode table zeroing results in a further 1.45% of logical
>       volume space getting allocated for inode tables, even if no file
>       data is added to the filesystem. With assume_storage_prezeroed,
>       the metadata allocation remains at 0.01%.
>
>     [ Fixed regression test to work on newer versions of e2fsprogs -- TYT ]
>
>     Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index b378e4d7..30f97bb5 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -365,6 +365,13 @@ small risk if the system crashes before the journal has been overwritten
>  entirely one time.  If the option value is omitted, it defaults to 1 to
>  enable lazy journal inode zeroing.
>  .TP
> +.B assume_storage_prezeroed\fR[\fB= \fI<0 to disable, 1 to enable>\fR]
> +If enabled,
> +.BR mke2fs
> +assumes that the storage device has been prezeroed, skips zeroing the journal
> +and inode tables, and annotates the block group flags to signal that the inode
> +table has been zeroed.
> +.TP
>  .B no_copy_xattrs
>  Normally
>  .B mke2fs
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index c955b318..76b8b8c6 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -96,6 +96,7 @@ int   journal_flags;
>  int    journal_fc_size;
>  static e2_blkcnt_t     orphan_file_blocks;
>  static int     lazy_itable_init;
> +static int     assume_storage_prezeroed;
>  static int     packed_meta_blocks;
>  int            no_copy_xattrs;
>  static char    *bad_blocks_filename = NULL;
> @@ -1013,6 +1014,11 @@ static void parse_extended_opts(struct ext2_super_block *param,
>                                 lazy_itable_init = strtoul(arg, &p, 0);
>                         else
>                                 lazy_itable_init = 1;
> +               } else if (!strcmp(token, "assume_storage_prezeroed")) {
> +                       if (arg)
> +                               assume_storage_prezeroed = strtoul(arg, &p, 0);
> +                       else
> +                               assume_storage_prezeroed = 1;
>                 } else if (!strcmp(token, "lazy_journal_init")) {
>                         if (arg)
>                                 journal_flags |= strtoul(arg, &p, 0) ?
> @@ -1131,7 +1137,8 @@ static void parse_extended_opts(struct ext2_super_block *param,
>                         "\tnodiscard\n"
>                         "\tencoding=<encoding>\n"
>                         "\tencoding_flags=<flags>\n"
> -                       "\tquotatype=<quota type(s) to be enabled>\n\n"),
> +                       "\tquotatype=<quota type(s) to be enabled>\n"
> +                       "\tassume_storage_prezeroed=<0 to disable, 1 to enable>\n\n"),
>                         badopt ? badopt : "");
>                 free(buf);
>                 exit(1);
> @@ -3125,6 +3132,18 @@ int main (int argc, char *argv[])
>                 io_channel_set_options(fs->io, opt_string);
>         }
>
> +       if (assume_storage_prezeroed) {
> +               if (verbose)
> +                       printf("%s",
> +                              _("Assuming the storage device is prezeroed "
> +                              "- skipping inode table and journal wipe\n"));
> +
> +               lazy_itable_init = 1;
> +               itable_zeroed = 1;
> +               zero_hugefile = 0;
> +               journal_flags |= EXT2_MKJOURNAL_LAZYINIT;
> +       }
> +
>         /* Can't undo discard ... */
>         if (!noaction && discard && dev_size && (io_ptr != undo_io_manager)) {
>                 retval = mke2fs_discard_device(fs);
> diff --git a/tests/m_assume_storage_prezeroed/expect b/tests/m_assume_storage_prezeroed/expect
> new file mode 100644
> index 00000000..b735e242
> --- /dev/null
> +++ b/tests/m_assume_storage_prezeroed/expect
> @@ -0,0 +1,2 @@
> +> 10000
> +224
> diff --git a/tests/m_assume_storage_prezeroed/script b/tests/m_assume_storage_prezeroed/script
> new file mode 100644
> index 00000000..1a8d8463
> --- /dev/null
> +++ b/tests/m_assume_storage_prezeroed/script
> @@ -0,0 +1,63 @@
> +test_description="test prezeroed storage metadata allocation"
> +FILE_SIZE=16M
> +
> +LOG=$test_name.log
> +OUT=$test_name.out
> +EXP=$test_dir/expect
> +
> +if test "$(id -u)" -ne 0 ; then
> +    echo "$test_name: $test_description: skipped (not root)"
> +elif ! command -v losetup >/dev/null ; then
> +    echo "$test_name: $test_description: skipped (no losetup)"
> +else
> +    dd if=/dev/zero of=$TMPFILE.1 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
> +    dd if=/dev/zero of=$TMPFILE.2 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
> +
> +    LOOP1=$(losetup --show --sector-size 4096 -f $TMPFILE.1)
> +    if [ ! -b "$LOOP1" ]; then
> +        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
> +        rm -f $TMPFILE.1 $TMPFILE.2
> +        exit 0
> +    fi
> +    LOOP2=$(losetup --show --sector-size 4096 -f $TMPFILE.2)
> +    if [ ! -b "$LOOP2" ]; then
> +        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
> +        rm -f $TMPFILE.1 $TMPFILE.2
> +       losetup -d $LOOP1
> +        exit 0
> +    fi
> +
> +    echo $MKE2FS -o Linux -t ext4 $LOOP1 >> $LOG 2>&1
> +    $MKE2FS -o Linux -t ext4 $LOOP1 >> $LOG 2>&1
> +    sync
> +    stat $TMPFILE.1 >> $LOG 2>&1
> +    SZ=$(stat -c "%b" $TMPFILE.1)
> +    if test $SZ -gt 10000 ; then
> +       echo "> 10000" > $OUT
> +    else
> +       echo "$SZ" > $OUT
> +    fi
> +
> +    echo $MKE2FS -o Linux -t ext4 -E assume_storage_prezeroed=1 $LOOP2 >> $LOG 2>&1
> +    $MKE2FS -o Linux -t ext4 -E assume_storage_prezeroed=1 $LOOP2 >> $LOG 2>&1
> +    sync
> +    stat $TMPFILE.2 >> $LOG 2>&1
> +    stat -c "%b" $TMPFILE.2 >> $OUT
> +
> +    losetup -d $LOOP1
> +    losetup -d $LOOP2
> +    rm -f $TMPFILE.1 $TMPFILE.2
> +
> +    cmp -s $OUT $EXP
> +    status=$?
> +
> +    if [ "$status" = 0 ] ; then
> +       echo "$test_name: $test_description: ok"
> +       touch $test_name.ok
> +    else
> +       echo "$test_name: $test_description: failed"
> +       cat $LOG > $test_name.failed
> +       diff $EXP $OUT >> $test_name.failed
> +    fi
> +fi
> +unset LOG OUT EXP FILE_SIZE LOOP1 LOOP2
>

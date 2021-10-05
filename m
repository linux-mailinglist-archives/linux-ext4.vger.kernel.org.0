Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E71421D0C
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Oct 2021 05:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJEDwA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Oct 2021 23:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJEDv7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Oct 2021 23:51:59 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06370C061745
        for <linux-ext4@vger.kernel.org>; Mon,  4 Oct 2021 20:50:09 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id t200so8711134vkt.0
        for <linux-ext4@vger.kernel.org>; Mon, 04 Oct 2021 20:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaExrgz8s+EP+mM9FFa5hirbFB101N6iVcb+QXFcfSI=;
        b=LlPVWMomaHM67yy9K14TytUoNJXJcFv/HtyY4M5sIpsICmAe1JSWanTbvxBxFRX1zP
         eVz2AnBQFKvvysbqhJ5DVfsqxHoJwDJqNbakakWG/jzSICUW2shoUBS9EQvakViNwZGS
         k2pAH+GlCWCz3AuFP6enBzLM1LQlyrnCMRtKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaExrgz8s+EP+mM9FFa5hirbFB101N6iVcb+QXFcfSI=;
        b=fVumgl+cDNnEQlUlTsngXeyiMC3ckyduVNxD79dxAEAsqmhltMecB5YXUe7YGhdb+f
         NsUxvFTqpgGR0HyH0sdoEUroJKTgPNuhgIb835Qhn9vl3iNbQVv42hAIVvG3zBzR//Hh
         Os6ev/fbyb8Pc/8+iMj10cbJ0zU8xCF6Xfb85LmZMa0EZ6jOsli6NTWBqihnVDHkZWW8
         sPGIiuPaAzNTFmWvwQ2obVOAUEgBg7zDKrqVr9khBBx5c1pJbSLkV6KFrebFdzL8d3y/
         aqDaH3Xio6DvE7+fQGq7BpBMgxBdY42jRnZO/nl8aRRHDGeBNOy/wZGrzuKB/veD0wnc
         57hQ==
X-Gm-Message-State: AOAM533XDy1WpYSuWIV79rntORlp7FsZevvcOFplBaK7ndcAmxdxWoQT
        0WKayDbDUWOWAiDtHp1xLp5rzikFdJUkLQPwY31k8uyRHIE=
X-Google-Smtp-Source: ABdhPJwgNueyjnFe9Z1bbjQTveLY6264xPaYNnJIHD/+zUX7M4vsq4Q4fs8UX5QYDfIC6nPjRc2tiu7vdphLT/IRF5c=
X-Received: by 2002:a05:6122:1150:: with SMTP id p16mr6188369vko.1.1633405808835;
 Mon, 04 Oct 2021 20:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca> <20210927103910.341417-1-sarthakkukreti@chromium.org>
In-Reply-To: <20210927103910.341417-1-sarthakkukreti@chromium.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 4 Oct 2021 20:49:58 -0700
Message-ID: <CAG9=OMN+TLJW5svnG6G+0BGg-jqn5PMZpBsDFoJt_nUZRNdx7g@mail.gmail.com>
Subject: Re: [PATCH v2] mke2fs: Add extended option for prezeroed storage devices
To:     linux-ext4@vger.kernel.org
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Gwendal Grignou <gwendal@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>, okiselev@amazon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Thanks for the discussions on the original patch. I wanted to circle
back and see if you had any further comments/concerns on the second
version of the patchset.

Best
Sarthak

On Mon, Sep 27, 2021 at 3:44 AM Sarthak Kukreti
<sarthakkukreti@chromium.org> wrote:
>
> This patch adds an extended option "assume_storage_prezeroed" to
> mke2fs. When enabled, this option acts as a hint to mke2fs that
> the underlying block device was zeroed before mke2fs was called.
> This allows mke2fs to optimize out the zeroing of the inode
> table and the journal, which speeds up the filesystem creation
> time.
>
> Additionally, on thinly provisioned storage devices (like Ceph,
> dm-thin, newly created sparse loopback files), reads on unmapped extents
> return zero. This property allows mke2fs (with assume_storage_prezeroed)
> to avoid pre-allocating metadata space for inode tables for the entire
> filesystem and saves space that would normally be preallocated
> for zero inode tables.
>
> Tests
> -----
> 1) Running 'mke2fs -t ext4' on 10G sparse files on an ext4
> filesystem drops the time taken by mke2fs from 0.09s to 0.04s
> and reduces the initial metadata space allocation (stat on
> sparse file) from 139736 blocks (545M) to 8672 blocks (34M).
>
> 2) On ChromeOS (running linux kernel 4.19) with dm-thin
> and 200GB thin logical volumes using 'mke2fs -t ext4 <dev>':
>
> - Time taken by mke2fs drops from 1.07s to 0.08s.
> - Avoiding zeroing out the inode table and journal reduces the
>   initial metadata space allocation from 0.48% to 0.01%.
> - Lazy inode table zeroing results in a further 1.45% of logical
>   volume space getting allocated for inode tables, even if no file
>   data is added to the filesystem. With assume_storage_prezeroed,
>   the metadata allocation remains at 0.01%.
>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> --
> Changes in v2: Added regression test, fixed indentation.
> ---
>  misc/mke2fs.8.in                        |  7 ++++++
>  misc/mke2fs.c                           | 21 ++++++++++++++++-
>  tests/m_assume_storage_prezeroed/expect |  2 ++
>  tests/m_assume_storage_prezeroed/script | 31 +++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 tests/m_assume_storage_prezeroed/expect
>  create mode 100644 tests/m_assume_storage_prezeroed/script
>
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index c0b53245..5c6ea5ec 100644
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
> index 04b2fbce..24c69966 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -95,6 +95,7 @@ int   journal_size;
>  int    journal_flags;
>  int    journal_fc_size;
>  static int     lazy_itable_init;
> +static int     assume_storage_prezeroed;
>  static int     packed_meta_blocks;
>  int            no_copy_xattrs;
>  static char    *bad_blocks_filename = NULL;
> @@ -1012,6 +1013,11 @@ static void parse_extended_opts(struct ext2_super_block *param,
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
> @@ -1115,7 +1121,8 @@ static void parse_extended_opts(struct ext2_super_block *param,
>                         "\tnodiscard\n"
>                         "\tencoding=<encoding>\n"
>                         "\tencoding_flags=<flags>\n"
> -                       "\tquotatype=<quota type(s) to be enabled>\n\n"),
> +                       "\tquotatype=<quota type(s) to be enabled>\n"
> +                       "\tassume_storage_prezeroed=<0 to disable, 1 to enable>\n\n"),
>                         badopt ? badopt : "");
>                 free(buf);
>                 exit(1);
> @@ -3095,6 +3102,18 @@ int main (int argc, char *argv[])
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
> index 00000000..2ca3784a
> --- /dev/null
> +++ b/tests/m_assume_storage_prezeroed/expect
> @@ -0,0 +1,2 @@
> +2384
> +336
> diff --git a/tests/m_assume_storage_prezeroed/script b/tests/m_assume_storage_prezeroed/script
> new file mode 100644
> index 00000000..0745fb28
> --- /dev/null
> +++ b/tests/m_assume_storage_prezeroed/script
> @@ -0,0 +1,31 @@
> +test_description="test prezeroed storage metadata allocation"
> +FILE_SIZE=16M
> +
> +LOG=$test_name.log
> +OUT=$test_name.out
> +EXP=$test_dir/expect
> +
> +dd if=/dev/zero of=$TMPFILE.1 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
> +dd if=/dev/zero of=$TMPFILE.2 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
> +
> +$MKE2FS -o Linux -t ext4 -O has_journal $TMPFILE.1 >> $LOG 2>&1
> +stat -c "%b" $TMPFILE.1 > $OUT
> +
> +$MKE2FS -o Linux -t ext4 -O has_journal -E assume_storage_prezeroed=1 $TMPFILE.2 >> $LOG 2>&1
> +stat -c "%b" $TMPFILE.2 >> $OUT
> +
> +rm -f $TMPFILE.1 $TMPFILE.2
> +
> +cmp -s $OUT $EXP
> +status=$?
> +
> +if [ "$status" = 0 ] ; then
> +       echo "$test_name: $test_description: ok"
> +       touch $test_name.ok
> +else
> +       echo "$test_name: $test_description: failed"
> +       cat $LOG > $test_name.failed
> +       diff $EXP $OUT >> $test_name.failed
> +fi
> +
> +unset LOG OUT EXP FILE_SIZE
> \ No newline at end of file
> --
> 2.31.0
>

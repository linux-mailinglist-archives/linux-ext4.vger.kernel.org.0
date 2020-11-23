Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789762C14E0
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 20:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgKWTxn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 14:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgKWTxm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 14:53:42 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB5C0613CF
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 11:53:41 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id i19so25045464ejx.9
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0u9H4Jxb39tQf5kn+0YXtiQUh06tcjAIKfMOKmSff8=;
        b=KkxNote5Dx5FQgKmymi6hk6pHS4lsA4mGkQ2nUP/w5oX2ZPRtcCwVOVP/XX8YJYr/k
         2REsiWq3+CFQ5Wv10lZXaKTQ/j5ajTbd+71PNFWn24FTewz62q65UZjroIsolhQTlanU
         XsFwWJDzpcIqRp4ibOXbsDQHwdhXxfFCaMUeKMU/clOeogY1igpFLoWU2nZwbr8e+jDM
         lKejayoi4FyM9qfSFeZp0an7Ar6wUuC14tCNT/zY5WywbgtlxOwQb4yLde6ttPoXKdMT
         4W0tIkibCGkdoA+Me6hftGDwUrYLD1b40VydQ/7qk6hhyqvtdeIks9J6FvI21nHrmOQz
         dBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0u9H4Jxb39tQf5kn+0YXtiQUh06tcjAIKfMOKmSff8=;
        b=nPr7Mic/yyee7WYWKgCnROew8KgrcMQq+NVyriPwv/9Nd/L+XO1A+TKRYugQYB7nba
         fttd2ArFo46365t73OcAbSLzgB6VWExF6i3heCERAaA9FIJVdN+k+JOv9wiiMu9NRD1h
         mVsF1/6ZrnsCnClmJxoxw/T3AwAEje2azY9aklvtFe32CvGT4Qezli84oZFHRb3CD0gQ
         M7WqsXlte4n/4ZTJcX7K9XSwVNdncVav6mrvIYR/bDiQJSNV8cWbTrQn/R3F2vvl7Rog
         EC705oEFEEarTPdIfnJGQNb51lyneesuzXO+MBY8afxD/qk0VPkxxTs1+42nnTq7h3fG
         kzZQ==
X-Gm-Message-State: AOAM532IcZqCjaxBbiEngQt1Y3ALUEpdXnxl1xVc4A5G7KlZ+qkx4d+O
        1BpsBUbNPZ+6o+NsyDdzzXoz5UsUvAmp8u2G1/YYfJq9jgM=
X-Google-Smtp-Source: ABdhPJyDWVmD3n+hht39m/UUXa3AARMx3wE5queL2fnZviv3kbauMc9VNp4qvr4BD2hCiJSEn7Yva5fLNDmL0s2uuB4=
X-Received: by 2002:a17:906:1317:: with SMTP id w23mr1148918ejb.120.1606161220349;
 Mon, 23 Nov 2020 11:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com> <20201118153947.3394530-2-saranyamohan@google.com>
In-Reply-To: <20201118153947.3394530-2-saranyamohan@google.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 23 Nov 2020 11:53:28 -0800
Message-ID: <CAD+ocbxr=GkMHvzWAWyv5U0N9g_J4hEAx7CgUmaA2Gmx=XupeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/61] e2fsck: add -m option for multithread
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch looks good to me. You can add -

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


On Wed, Nov 18, 2020 at 7:42 AM Saranya Muruganandam
<saranyamohan@google.com> wrote:
>
> From: Li Xi <lixi@ddn.com>
>
> -m option is added but no actual functionality is added. This
> patch only adds the logic that when -m is specified, one of
> -p/-y/-n options should be specified. And when -m is specified,
> -C shouldn't be specified and the completion progress report won't
> be triggered by sending SIGUSR1/SIGUSR2 signals. This simplifies
> the implementation of multi-thread fsck in the future.
>
> Completion progress support with multi-thread fsck will be added
> back after multi-thread fsck implementation is finished. Right
> now, disable it to simplify the implementation of multi-thread fsck.
>
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> ---
>  e2fsck/e2fsck.h                         |  1 +
>  e2fsck/unix.c                           | 31 ++++++++++++++++++++-----
>  tests/f_multithread/expect.1            | 23 ++++++++++++++++++
>  tests/f_multithread/expect.2            |  7 ++++++
>  tests/f_multithread/image.gz            |  1 +
>  tests/f_multithread/name                |  1 +
>  tests/f_multithread/script              |  4 ++++
>  tests/f_multithread_completion/expect.1 |  2 ++
>  tests/f_multithread_completion/expect.2 | 23 ++++++++++++++++++
>  tests/f_multithread_completion/image.gz |  1 +
>  tests/f_multithread_completion/name     |  1 +
>  tests/f_multithread_completion/script   |  4 ++++
>  tests/f_multithread_no/expect.1         | 24 +++++++++++++++++++
>  tests/f_multithread_no/expect.2         | 23 ++++++++++++++++++
>  tests/f_multithread_no/image.gz         |  1 +
>  tests/f_multithread_no/name             |  1 +
>  tests/f_multithread_no/script           |  4 ++++
>  tests/f_multithread_preen/expect.1      | 11 +++++++++
>  tests/f_multithread_preen/expect.2      | 23 ++++++++++++++++++
>  tests/f_multithread_preen/image.gz      |  1 +
>  tests/f_multithread_preen/name          |  1 +
>  tests/f_multithread_preen/script        |  4 ++++
>  tests/f_multithread_yes/expect.1        |  2 ++
>  tests/f_multithread_yes/expect.2        | 23 ++++++++++++++++++
>  tests/f_multithread_yes/image.gz        |  1 +
>  tests/f_multithread_yes/name            |  1 +
>  tests/f_multithread_yes/script          |  4 ++++
>  27 files changed, 217 insertions(+), 6 deletions(-)
>  create mode 100644 tests/f_multithread/expect.1
>  create mode 100644 tests/f_multithread/expect.2
>  create mode 120000 tests/f_multithread/image.gz
>  create mode 100644 tests/f_multithread/name
>  create mode 100644 tests/f_multithread/script
>  create mode 100644 tests/f_multithread_completion/expect.1
>  create mode 100644 tests/f_multithread_completion/expect.2
>  create mode 120000 tests/f_multithread_completion/image.gz
>  create mode 100644 tests/f_multithread_completion/name
>  create mode 100644 tests/f_multithread_completion/script
>  create mode 100644 tests/f_multithread_no/expect.1
>  create mode 100644 tests/f_multithread_no/expect.2
>  create mode 120000 tests/f_multithread_no/image.gz
>  create mode 100644 tests/f_multithread_no/name
>  create mode 100644 tests/f_multithread_no/script
>  create mode 100644 tests/f_multithread_preen/expect.1
>  create mode 100644 tests/f_multithread_preen/expect.2
>  create mode 120000 tests/f_multithread_preen/image.gz
>  create mode 100644 tests/f_multithread_preen/name
>  create mode 100644 tests/f_multithread_preen/script
>  create mode 100644 tests/f_multithread_yes/expect.1
>  create mode 100644 tests/f_multithread_yes/expect.2
>  create mode 120000 tests/f_multithread_yes/image.gz
>  create mode 100644 tests/f_multithread_yes/name
>  create mode 100644 tests/f_multithread_yes/script
>
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 85f953b2..e2784248 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -177,6 +177,7 @@ struct resource_track {
>  #define E2F_OPT_ICOUNT_FULLMAP 0x20000 /* use an array for inode counts */
>  #define E2F_OPT_UNSHARE_BLOCKS  0x40000
>  #define E2F_OPT_CLEAR_UNINIT   0x80000 /* Hack to clear the uninit bit */
> +#define E2F_OPT_MULTITHREAD    0x100000 /* Use multiple threads to speedup */
>
>  /*
>   * E2fsck flags
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index 1cb51672..051b31a5 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -75,13 +75,14 @@ int journal_enable_debug = -1;
>  static void usage(e2fsck_t ctx)
>  {
>         fprintf(stderr,
> -               _("Usage: %s [-panyrcdfktvDFV] [-b superblock] [-B blocksize]\n"
> +               _("Usage: %s [-pamnyrcdfktvDFV] [-b superblock] [-B blocksize]\n"
>                 "\t\t[-l|-L bad_blocks_file] [-C fd] [-j external_journal]\n"
>                 "\t\t[-E extended-options] [-z undo_file] device\n"),
>                 ctx->program_name);
>
>         fprintf(stderr, "%s", _("\nEmergency help:\n"
>                 " -p                   Automatic repair (no questions)\n"
> +               " -m                   multiple threads to speedup fsck\n"
>                 " -n                   Make no changes to the filesystem\n"
>                 " -y                   Assume \"yes\" to all questions\n"
>                 " -c                   Check for bad blocks and add them to the badblock list\n"
> @@ -847,7 +848,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>
>         phys_mem_kb = get_memory_size() / 1024;
>         ctx->readahead_kb = ~0ULL;
> -       while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
> +
> +       while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
>                 switch (c) {
>                 case 'C':
>                         ctx->progress = e2fsck_update_progress;
> @@ -888,6 +890,9 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>                         }
>                         ctx->options |= E2F_OPT_PREEN;
>                         break;
> +               case 'm':
> +                       ctx->options |= E2F_OPT_MULTITHREAD;
> +                       break;
>                 case 'n':
>                         if (ctx->options & (E2F_OPT_YES|E2F_OPT_PREEN))
>                                 goto conflict_opt;
> @@ -1006,6 +1011,18 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>                         _("The -n and -l/-L options are incompatible."));
>                 fatal_error(ctx, 0);
>         }
> +       if (ctx->options & E2F_OPT_MULTITHREAD) {
> +               if ((ctx->options & (E2F_OPT_YES|E2F_OPT_NO|E2F_OPT_PREEN)) == 0) {
> +                       com_err(ctx->program_name, 0, "%s",
> +                               _("The -m option should be used together with one of -p/-y/-n options."));
> +                       fatal_error(ctx, 0);
> +               }
> +               if (ctx->progress) {
> +                       com_err(ctx->program_name, 0, "%s",
> +                               _("Only one of the options -C or -m may be specified."));
> +                       fatal_error(ctx, 0);
> +               }
> +       }
>         if (ctx->options & E2F_OPT_NO)
>                 ctx->options |= E2F_OPT_READONLY;
>
> @@ -1112,10 +1129,12 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>  #ifdef SA_RESTART
>         sa.sa_flags = SA_RESTART;
>  #endif
> -       sa.sa_handler = signal_progress_on;
> -       sigaction(SIGUSR1, &sa, 0);
> -       sa.sa_handler = signal_progress_off;
> -       sigaction(SIGUSR2, &sa, 0);
> +       if ((ctx->options & E2F_OPT_MULTITHREAD) == 0) {
> +               sa.sa_handler = signal_progress_on;
> +               sigaction(SIGUSR1, &sa, 0);
> +               sa.sa_handler = signal_progress_off;
> +               sigaction(SIGUSR2, &sa, 0);
> +       }
>  #endif
>
>         /* Update our PATH to include /sbin if we need to run badblocks  */
> diff --git a/tests/f_multithread/expect.1 b/tests/f_multithread/expect.1
> new file mode 100644
> index 00000000..e2b954d0
> --- /dev/null
> +++ b/tests/f_multithread/expect.1
> @@ -0,0 +1,23 @@
> +ext2fs_open2: Bad magic number in super-block
> +../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Free blocks count wrong for group #0 (7987, counted=7982).
> +Fix? yes
> +
> +Free blocks count wrong (11602, counted=11597).
> +Fix? yes
> +
> +Free inodes count wrong for group #0 (1493, counted=1488).
> +Fix? yes
> +
> +Free inodes count wrong (2997, counted=2992).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
> +Exit status is 1
> diff --git a/tests/f_multithread/expect.2 b/tests/f_multithread/expect.2
> new file mode 100644
> index 00000000..a833aefc
> --- /dev/null
> +++ b/tests/f_multithread/expect.2
> @@ -0,0 +1,7 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
> +Exit status is 0
> diff --git a/tests/f_multithread/image.gz b/tests/f_multithread/image.gz
> new file mode 120000
> index 00000000..0fd40018
> --- /dev/null
> +++ b/tests/f_multithread/image.gz
> @@ -0,0 +1 @@
> +../f_zero_super/image.gz
> \ No newline at end of file
> diff --git a/tests/f_multithread/name b/tests/f_multithread/name
> new file mode 100644
> index 00000000..df838ea6
> --- /dev/null
> +++ b/tests/f_multithread/name
> @@ -0,0 +1 @@
> +test "e2fsck -m" option
> \ No newline at end of file
> diff --git a/tests/f_multithread/script b/tests/f_multithread/script
> new file mode 100644
> index 00000000..0fe96cd0
> --- /dev/null
> +++ b/tests/f_multithread/script
> @@ -0,0 +1,4 @@
> +FSCK_OPT="-fy -m"
> +SECOND_FSCK_OPT=-yf
> +
> +. $cmd_dir/run_e2fsck
> diff --git a/tests/f_multithread_completion/expect.1 b/tests/f_multithread_completion/expect.1
> new file mode 100644
> index 00000000..61cac9bb
> --- /dev/null
> +++ b/tests/f_multithread_completion/expect.1
> @@ -0,0 +1,2 @@
> +../e2fsck/e2fsck: Only one of the options -C or -m may be specified.
> +Exit status is 8
> diff --git a/tests/f_multithread_completion/expect.2 b/tests/f_multithread_completion/expect.2
> new file mode 100644
> index 00000000..e2b954d0
> --- /dev/null
> +++ b/tests/f_multithread_completion/expect.2
> @@ -0,0 +1,23 @@
> +ext2fs_open2: Bad magic number in super-block
> +../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Free blocks count wrong for group #0 (7987, counted=7982).
> +Fix? yes
> +
> +Free blocks count wrong (11602, counted=11597).
> +Fix? yes
> +
> +Free inodes count wrong for group #0 (1493, counted=1488).
> +Fix? yes
> +
> +Free inodes count wrong (2997, counted=2992).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
> +Exit status is 1
> diff --git a/tests/f_multithread_completion/image.gz b/tests/f_multithread_completion/image.gz
> new file mode 120000
> index 00000000..0fd40018
> --- /dev/null
> +++ b/tests/f_multithread_completion/image.gz
> @@ -0,0 +1 @@
> +../f_zero_super/image.gz
> \ No newline at end of file
> diff --git a/tests/f_multithread_completion/name b/tests/f_multithread_completion/name
> new file mode 100644
> index 00000000..a959045d
> --- /dev/null
> +++ b/tests/f_multithread_completion/name
> @@ -0,0 +1 @@
> +test "e2fsck -m" option conflicts with "-C"
> \ No newline at end of file
> diff --git a/tests/f_multithread_completion/script b/tests/f_multithread_completion/script
> new file mode 100644
> index 00000000..bf23cd61
> --- /dev/null
> +++ b/tests/f_multithread_completion/script
> @@ -0,0 +1,4 @@
> +FSCK_OPT="-fy -m -C 1"
> +SECOND_FSCK_OPT=-yf
> +
> +. $cmd_dir/run_e2fsck
> diff --git a/tests/f_multithread_no/expect.1 b/tests/f_multithread_no/expect.1
> new file mode 100644
> index 00000000..d14c4083
> --- /dev/null
> +++ b/tests/f_multithread_no/expect.1
> @@ -0,0 +1,24 @@
> +ext2fs_open2: Bad magic number in super-block
> +../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Free blocks count wrong for group #0 (7987, counted=7982).
> +Fix? no
> +
> +Free blocks count wrong (11602, counted=11597).
> +Fix? no
> +
> +Free inodes count wrong for group #0 (1493, counted=1488).
> +Fix? no
> +
> +Free inodes count wrong (2997, counted=2992).
> +Fix? no
> +
> +
> +test_filesys: ********** WARNING: Filesystem still has errors **********
> +
> +test_filesys: 11/3008 files (0.0% non-contiguous), 398/12000 blocks
> +Exit status is 4
> diff --git a/tests/f_multithread_no/expect.2 b/tests/f_multithread_no/expect.2
> new file mode 100644
> index 00000000..e2b954d0
> --- /dev/null
> +++ b/tests/f_multithread_no/expect.2
> @@ -0,0 +1,23 @@
> +ext2fs_open2: Bad magic number in super-block
> +../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Free blocks count wrong for group #0 (7987, counted=7982).
> +Fix? yes
> +
> +Free blocks count wrong (11602, counted=11597).
> +Fix? yes
> +
> +Free inodes count wrong for group #0 (1493, counted=1488).
> +Fix? yes
> +
> +Free inodes count wrong (2997, counted=2992).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
> +Exit status is 1
> diff --git a/tests/f_multithread_no/image.gz b/tests/f_multithread_no/image.gz
> new file mode 120000
> index 00000000..0fd40018
> --- /dev/null
> +++ b/tests/f_multithread_no/image.gz
> @@ -0,0 +1 @@
> +../f_zero_super/image.gz
> \ No newline at end of file
> diff --git a/tests/f_multithread_no/name b/tests/f_multithread_no/name
> new file mode 100644
> index 00000000..fa49692e
> --- /dev/null
> +++ b/tests/f_multithread_no/name
> @@ -0,0 +1 @@
> +test "e2fsck -m" option works with "-n"
> \ No newline at end of file
> diff --git a/tests/f_multithread_no/script b/tests/f_multithread_no/script
> new file mode 100644
> index 00000000..b93deb3a
> --- /dev/null
> +++ b/tests/f_multithread_no/script
> @@ -0,0 +1,4 @@
> +FSCK_OPT="-fn -m"
> +SECOND_FSCK_OPT=-yf
> +
> +. $cmd_dir/run_e2fsck
> diff --git a/tests/f_multithread_preen/expect.1 b/tests/f_multithread_preen/expect.1
> new file mode 100644
> index 00000000..b4b0cd9a
> --- /dev/null
> +++ b/tests/f_multithread_preen/expect.1
> @@ -0,0 +1,11 @@
> +../e2fsck/e2fsck: Bad magic number in super-block while trying to open test.img
> +test_filesys:
> +The superblock could not be read or does not describe a valid ext2/ext3/ext4
> +filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
> +filesystem (and not swap or ufs or something else), then the superblock
> +is corrupt, and you might try running e2fsck with an alternate superblock:
> +    e2fsck -b 8193 <device>
> + or
> +    e2fsck -b 32768 <device>
> +
> +Exit status is 8
> diff --git a/tests/f_multithread_preen/expect.2 b/tests/f_multithread_preen/expect.2
> new file mode 100644
> index 00000000..e2b954d0
> --- /dev/null
> +++ b/tests/f_multithread_preen/expect.2
> @@ -0,0 +1,23 @@
> +ext2fs_open2: Bad magic number in super-block
> +../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Free blocks count wrong for group #0 (7987, counted=7982).
> +Fix? yes
> +
> +Free blocks count wrong (11602, counted=11597).
> +Fix? yes
> +
> +Free inodes count wrong for group #0 (1493, counted=1488).
> +Fix? yes
> +
> +Free inodes count wrong (2997, counted=2992).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
> +Exit status is 1
> diff --git a/tests/f_multithread_preen/image.gz b/tests/f_multithread_preen/image.gz
> new file mode 120000
> index 00000000..0fd40018
> --- /dev/null
> +++ b/tests/f_multithread_preen/image.gz
> @@ -0,0 +1 @@
> +../f_zero_super/image.gz
> \ No newline at end of file
> diff --git a/tests/f_multithread_preen/name b/tests/f_multithread_preen/name
> new file mode 100644
> index 00000000..90d199df
> --- /dev/null
> +++ b/tests/f_multithread_preen/name
> @@ -0,0 +1 @@
> +test "e2fsck -m" option works with "-p"
> \ No newline at end of file
> diff --git a/tests/f_multithread_preen/script b/tests/f_multithread_preen/script
> new file mode 100644
> index 00000000..ecb79cd6
> --- /dev/null
> +++ b/tests/f_multithread_preen/script
> @@ -0,0 +1,4 @@
> +FSCK_OPT="-fp -m"
> +SECOND_FSCK_OPT=-yf
> +
> +. $cmd_dir/run_e2fsck
> diff --git a/tests/f_multithread_yes/expect.1 b/tests/f_multithread_yes/expect.1
> new file mode 100644
> index 00000000..8b780ecf
> --- /dev/null
> +++ b/tests/f_multithread_yes/expect.1
> @@ -0,0 +1,2 @@
> +../e2fsck/e2fsck: The -m option should be used together with one of -p/-y/-n options.
> +Exit status is 8
> diff --git a/tests/f_multithread_yes/expect.2 b/tests/f_multithread_yes/expect.2
> new file mode 100644
> index 00000000..e2b954d0
> --- /dev/null
> +++ b/tests/f_multithread_yes/expect.2
> @@ -0,0 +1,23 @@
> +ext2fs_open2: Bad magic number in super-block
> +../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Free blocks count wrong for group #0 (7987, counted=7982).
> +Fix? yes
> +
> +Free blocks count wrong (11602, counted=11597).
> +Fix? yes
> +
> +Free inodes count wrong for group #0 (1493, counted=1488).
> +Fix? yes
> +
> +Free inodes count wrong (2997, counted=2992).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
> +Exit status is 1
> diff --git a/tests/f_multithread_yes/image.gz b/tests/f_multithread_yes/image.gz
> new file mode 120000
> index 00000000..0fd40018
> --- /dev/null
> +++ b/tests/f_multithread_yes/image.gz
> @@ -0,0 +1 @@
> +../f_zero_super/image.gz
> \ No newline at end of file
> diff --git a/tests/f_multithread_yes/name b/tests/f_multithread_yes/name
> new file mode 100644
> index 00000000..3a703195
> --- /dev/null
> +++ b/tests/f_multithread_yes/name
> @@ -0,0 +1 @@
> +test "e2fsck -m" option works with "-y"
> \ No newline at end of file
> diff --git a/tests/f_multithread_yes/script b/tests/f_multithread_yes/script
> new file mode 100644
> index 00000000..38891f6a
> --- /dev/null
> +++ b/tests/f_multithread_yes/script
> @@ -0,0 +1,4 @@
> +FSCK_OPT="-f -m"
> +SECOND_FSCK_OPT=-yf
> +
> +. $cmd_dir/run_e2fsck
> --
> 2.29.2.299.gdc1121823c-goog
>

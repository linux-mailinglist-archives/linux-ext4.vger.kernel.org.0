Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7258C1FD
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Aug 2022 05:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiHHDOU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Aug 2022 23:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiHHDOS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Aug 2022 23:14:18 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC6DED8
        for <linux-ext4@vger.kernel.org>; Sun,  7 Aug 2022 20:14:17 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 66so7671930vse.4
        for <linux-ext4@vger.kernel.org>; Sun, 07 Aug 2022 20:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JBaNNGCvW628WcQc5fnXkd66KFwsLo1I7l2/Lrq2jwY=;
        b=n0hrs8BAO6/mMQKBRzYwaZLiXxXTUovrD3I/rKxggepEXiLmLQz837svF3y/MMoqPc
         CiGxPWoo5gcx/dDXzNLgZ3yGaUG0RC86k1C8wKc0hlGr5VxGPXCI+ZrDLNKtcKJ2ruBD
         ME8eor3eRi8yrqarWlYw1OM2lyHbOaLBeL4mMWD4pUtL+ZQs0Su4t/HLbCwXcexmTZVN
         Hg/VxoYQo8vi6xm4MQxVStWLVtIiJhgRlbox4C/bc/aMERk9hqWYrewCPWo1ZGLT+ll3
         vxy5kxS0xNqdyGv3F5vMVXbjd5rFdtU2TAwAzSIDcYb2v61us3/lhlrmmpoHesh1x4v9
         EZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JBaNNGCvW628WcQc5fnXkd66KFwsLo1I7l2/Lrq2jwY=;
        b=HMZfXpbDN2gRx85T9KM+6WQbxMjq2UQDslT1FCvpnO1sTxa9LTy4PRoLqf1BzYeTyu
         mAxWaqWTMXbEP9zfVuHIwwp8dzsqxVcjBLVsmMGGxw/Lk3B+V4LKfUiMOtiudt36vyac
         YNO+TRDOsIawqDpl4Dgnpvo7/es/UC9QIZzQcWNw4RhKUZJ9qNGx/Pwk3SVY/fmMyvU3
         RklNBpv5fplsNhlg7YWlAx4gchop8XWDd92RRrJjXKKNwabJdNQlsccd+JEqYx7NWT6R
         OXOe8gyd1HjcT9pONy5qfGkbMW8b94AZ3OOGEkWl0pn3BGIDCImYPMYLZcHB8rFPL39V
         wlhg==
X-Gm-Message-State: ACgBeo3GsPov9nNsh5WtEpI/IPP7UintqD/SPkZJn+IqYellNR0y6L6Z
        uTq9M+WXo6ViGyVttTcXBwaed8kaWsQWGjBeZy/tfIpMS7Y=
X-Google-Smtp-Source: AA6agR7wySdfHSlKF7tpyKdJTvVDKK5ATEisTXKONDwu3An4W7n5ZmO/g1488IyJKzGqRJ7yH9k+qcJHSAoCBwMwkt4=
X-Received: by 2002:a67:d90e:0:b0:36b:7848:ba99 with SMTP id
 t14-20020a67d90e000000b0036b7848ba99mr6874086vsj.81.1659928456094; Sun, 07
 Aug 2022 20:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220805094703.155967-1-lczerner@redhat.com>
In-Reply-To: <20220805094703.155967-1-lczerner@redhat.com>
From:   Daniel Ng <danielng@google.com>
Date:   Mon, 8 Aug 2022 13:13:39 +1000
Message-ID: <CANFuW3fxUehk7FPTpgesrudYTOX05J6MszyeifRR6VX-cePPOw@mail.gmail.com>
Subject: Re: [PATCH] e2fsprogs: fix device name parsing to resolve names
 containing '='
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Lukas. Thanks for elaborating on your reasoning too - the
ordering makes sense to me. Generally lgtm (though I'm not an
owner/maintainer).


On Fri, Aug 5, 2022 at 7:47 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> Currently in varisous e2fsprogs tools, most notably tune2fs and e2fsck
> we will get the device name by passing the user provided string into
> blkid_get_devname(). This library function however is primarily intended
> for parsing "NAME=value" tokens. It will return the device matching the
> specified token, NULL if nothing is found, or copy of the string if it's
> not in "NAME=value" format.
>
> However in case where we're passing in a file name that contains an
> equal sign blkid_get_devname() will treat it as a token and will attempt
> to find the device with the match. Likely finding nothing.
>
> Fix it by checking existence of the file first and then attempt to call
> blkid_get_devname(). In case of a collision, notify the user and
> automatically prefer the one returned by blkid_get_devname(). Otherwise
> return either the existing file, or NULL.
>
> We do it this way to avoid some existing file in working directory (for
> example LABEL=volume-name) masking an actual device containing the
> matchin LABEL. User can specify full, or relative path (e.g.
> ./LABEL=volume-name) to make sure the file is used instead.
>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reported-by: Daniel Ng <danielng@google.com>
> ---
>  e2fsck/unix.c           |  6 +++---
>  lib/support/plausible.c | 35 ++++++++++++++++++++++++++++++++++-
>  lib/support/plausible.h |  3 +++
>  misc/Makefile.in        |  9 +++++----
>  misc/e2initrd_helper.c  |  5 +++--
>  misc/fsck.c             |  5 +++--
>  misc/tune2fs.c          |  4 ++--
>  misc/util.c             |  3 ++-
>  8 files changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index ae231f93..edd7b9b2 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -939,8 +939,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>                                 goto sscanf_err;
>                         break;
>                 case 'j':
> -                       ctx->journal_name = blkid_get_devname(ctx->blkid,
> -                                                             optarg, NULL);
> +                       ctx->journal_name = get_devname(ctx->blkid,
> +                                                       optarg, NULL);
>                         if (!ctx->journal_name) {
>                                 com_err(ctx->program_name, 0,
>                                         _("Unable to resolve '%s'"),
> @@ -1019,7 +1019,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>         ctx->io_options = strchr(argv[optind], '?');
>         if (ctx->io_options)
>                 *ctx->io_options++ = 0;
> -       ctx->filesystem_name = blkid_get_devname(ctx->blkid, argv[optind], 0);
> +       ctx->filesystem_name = get_devname(ctx->blkid, argv[optind], 0);
>         if (!ctx->filesystem_name) {
>                 com_err(ctx->program_name, 0, _("Unable to resolve '%s'"),
>                         argv[optind]);
> diff --git a/lib/support/plausible.c b/lib/support/plausible.c
> index bbed2a70..864a7a5e 100644
> --- a/lib/support/plausible.c
> +++ b/lib/support/plausible.c
> @@ -35,7 +35,6 @@
>  #include "plausible.h"
>  #include "ext2fs/ext2fs.h"
>  #include "nls-enable.h"
> -#include "blkid/blkid.h"
>
>  #ifdef HAVE_MAGIC_H
>  static magic_t (*dl_magic_open)(int);
> @@ -290,3 +289,37 @@ int check_plausibility(const char *device, int flags, int *ret_is_dev)
>         return 1;
>  }
>
> +
> +char *get_devname(blkid_cache cache, const char *token, const char *value)
> +{
> +       int is_file = 0;
> +       char *ret = NULL;
> +
> +       if (!token)
> +               goto out;
> +
> +       if (value) {
> +               ret = blkid_get_devname(cache, token, value);
> +               goto out;
> +       }
> +
> +       if (access(token, F_OK) == 0)
> +               is_file = 1;
> +
> +       ret = blkid_get_devname(cache, token, NULL);
> +       if (ret) {
> +               if (is_file && (strcmp(ret, token) != 0)) {
> +                       fprintf(stderr,
> +                               _("Collision found: '%s' refers to both '%s' "
> +                                 "and a file '%s'. Using '%s'!\n"),
> +                               token, ret, token, ret);
> +               }
> +               goto out;
> +       }
> +
> +out_strdup:
> +       if (is_file)
> +               ret = strdup(token);
> +out:
> +       return ret;
> +}
> diff --git a/lib/support/plausible.h b/lib/support/plausible.h
> index b85150c7..8eb6817f 100644
> --- a/lib/support/plausible.h
> +++ b/lib/support/plausible.h
> @@ -13,6 +13,8 @@
>  #ifndef PLAUSIBLE_H_
>  #define PLAUSIBLE_H_
>
> +#include "blkid/blkid.h"
> +
>  /*
>   * Flags for check_plausibility()
>   */
> @@ -25,5 +27,6 @@
>
>  extern int check_plausibility(const char *device, int flags,
>                               int *ret_is_dev);
> +char *get_devname(blkid_cache cache, const char *token, const char *value);
>
>  #endif /* PLAUSIBLE_H_ */
> diff --git a/misc/Makefile.in b/misc/Makefile.in
> index 4db59cdf..5187883f 100644
> --- a/misc/Makefile.in
> +++ b/misc/Makefile.in
> @@ -360,12 +360,12 @@ dumpe2fs.static: $(DUMPE2FS_OBJS) $(DEPLIBS) $(DEPLIBS_E2P) $(DEPLIBUUID) $(DEPL
>                 $(STATIC_LIBS) $(STATIC_LIBE2P) $(STATIC_LIBUUID) \
>                 $(LIBINTL) $(SYSLIBS) $(STATIC_LIBBLKID) $(LIBMAGIC)
>
> -fsck: $(FSCK_OBJS) $(DEPLIBBLKID)
> +fsck: $(FSCK_OBJS) $(DEPLIBBLKID) $(DEPLIBS)
>         $(E) "  LD $@"
>         $(Q) $(CC) $(ALL_LDFLAGS) -o fsck $(FSCK_OBJS) $(LIBBLKID) \
> -               $(LIBINTL) $(SYSLIBS)
> +               $(LIBINTL) $(SYSLIBS) $(LIBS) $(LIBEXT2FS) $(LIBCOM_ERR)
>
> -fsck.profiled: $(FSCK_OBJS) $(PROFILED_DEPLIBBLKID)
> +fsck.profiled: $(FSCK_OBJS) $(PROFILED_DEPLIBBLKID) $(PROFILED_DEPLIBS)
>         $(E) "  LD $@"
>         $(Q) $(CC) $(ALL_LDFLAGS) -g -pg -o fsck.profiled $(PROFILED_FSCK_OBJS) \
>                 $(PROFILED_LIBBLKID) $(LIBINTL) $(SYSLIBS)
> @@ -799,7 +799,8 @@ badblocks.o: $(srcdir)/badblocks.c $(top_builddir)/lib/config.h \
>   $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/nls-enable.h
>  fsck.o: $(srcdir)/fsck.c $(top_builddir)/lib/config.h \
>   $(top_builddir)/lib/dirpaths.h $(top_srcdir)/version.h \
> - $(top_srcdir)/lib/support/nls-enable.h $(srcdir)/fsck.h
> + $(top_srcdir)/lib/support/nls-enable.h $(srcdir)/fsck.h \
> + $(top_srcdir)/lib/support/plausible.h
>  util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
>   $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/et/com_err.h \
>   $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
> diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
> index 436aab8c..bfa294fa 100644
> --- a/misc/e2initrd_helper.c
> +++ b/misc/e2initrd_helper.c
> @@ -36,6 +36,7 @@ extern char *optarg;
>  #include "ext2fs/ext2fs.h"
>  #include "blkid/blkid.h"
>  #include "support/nls-enable.h"
> +#include "support/plausible.h"
>
>  #include "../version.h"
>
> @@ -262,7 +263,7 @@ static int parse_fstab_line(char *line, struct fs_info *fs)
>         parse_escape(freq);
>         parse_escape(passno);
>
> -       dev = blkid_get_devname(cache, device, NULL);
> +       dev = get_devname(cache, device, NULL);
>         if (dev)
>                 device = dev;
>
> @@ -325,7 +326,7 @@ static void PRS(int argc, char **argv)
>         }
>         if (optind < argc - 1 || optind == argc)
>                 usage();
> -       device_name = blkid_get_devname(NULL, argv[optind], NULL);
> +       device_name = get_devname(NULL, argv[optind], NULL);
>         if (!device_name) {
>                 com_err(program_name, 0, _("Unable to resolve '%s'"),
>                         argv[optind]);
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 4efe10ec..75c520ee 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -59,6 +59,7 @@
>  #endif
>
>  #include "../version.h"
> +#include "support/plausible.h"
>  #include "support/nls-enable.h"
>  #include "fsck.h"
>  #include "blkid/blkid.h"
> @@ -297,7 +298,7 @@ static int parse_fstab_line(char *line, struct fs_info **ret_fs)
>         parse_escape(freq);
>         parse_escape(passno);
>
> -       dev = blkid_get_devname(cache, device, NULL);
> +       dev = get_devname(cache, device, NULL);
>         if (dev)
>                 device = dev;
>
> @@ -1128,7 +1129,7 @@ static void PRS(int argc, char *argv[])
>                                         progname);
>                                 exit(EXIT_ERROR);
>                         }
> -                       dev = blkid_get_devname(cache, arg, NULL);
> +                       dev = get_devname(cache, arg, NULL);
>                         if (!dev && strchr(arg, '=')) {
>                                 /*
>                                  * Check to see if we failed because
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 6c162ba5..dfa7427b 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -1839,7 +1839,7 @@ static void parse_e2label_options(int argc, char ** argv)
>         io_options = strchr(argv[1], '?');
>         if (io_options)
>                 *io_options++ = 0;
> -       device_name = blkid_get_devname(NULL, argv[1], NULL);
> +       device_name = get_devname(NULL, argv[1], NULL);
>         if (!device_name) {
>                 com_err("e2label", 0, _("Unable to resolve '%s'"),
>                         argv[1]);
> @@ -2139,7 +2139,7 @@ static void parse_tune2fs_options(int argc, char **argv)
>         io_options = strchr(argv[optind], '?');
>         if (io_options)
>                 *io_options++ = 0;
> -       device_name = blkid_get_devname(NULL, argv[optind], NULL);
> +       device_name = get_devname(NULL, argv[optind], NULL);
>         if (!device_name) {
>                 com_err(program_name, 0, _("Unable to resolve '%s'"),
>                         argv[optind]);
> diff --git a/misc/util.c b/misc/util.c
> index 48e623dc..2b2ad07b 100644
> --- a/misc/util.c
> +++ b/misc/util.c
> @@ -45,6 +45,7 @@
>  #include "ext2fs/ext2_fs.h"
>  #include "ext2fs/ext2fs.h"
>  #include "support/nls-enable.h"
> +#include "support/plausible.h"
>  #include "blkid/blkid.h"
>  #include "util.h"
>
> @@ -183,7 +184,7 @@ void parse_journal_opts(const char *opts)
>                        arg ? arg : "NONE");
>  #endif
>                 if (strcmp(token, "device") == 0) {
> -                       journal_device = blkid_get_devname(NULL, arg, NULL);
> +                       journal_device = get_devname(NULL, arg, NULL);
>                         if (!journal_device) {
>                                 if (arg)
>                                         fprintf(stderr, _("\nCould not find "
> --
> 2.37.1
>

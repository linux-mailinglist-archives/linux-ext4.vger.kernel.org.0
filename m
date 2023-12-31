Return-Path: <linux-ext4+bounces-586-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F68820EDB
	for <lists+linux-ext4@lfdr.de>; Sun, 31 Dec 2023 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B411D1C21931
	for <lists+linux-ext4@lfdr.de>; Sun, 31 Dec 2023 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A0BE4A;
	Sun, 31 Dec 2023 21:38:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F5BA22
	for <linux-ext4@vger.kernel.org>; Sun, 31 Dec 2023 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so7693203f8f.2
        for <linux-ext4@vger.kernel.org>; Sun, 31 Dec 2023 13:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704058712; x=1704663512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdIs1O+r7kZjJrH8PQm4fqC+1kfv7ZmjoC9GEn/liLc=;
        b=qaStv/fvuBj7xWoPZ9YC0wHqDMrmk2XNHn9l2mMSW6K1CCwYxzrLsx/X/cjF0MHd7i
         yz5rVpbbM0mzBhf2C0MH5kFd38QTvAhoAB1YkKdbhnGViUT/Fo10XR6SlA13CesC1Ti/
         RN7dvvTHL/i7kQvg0ruY2NxEWaVW0Fz2lpc8t2mWTxZeE1fYoBh0J/TmbGiobs4JNKSS
         Kkl/glPUWWBJ1sxyeL8Tae+Tvevg7qQ8vOAC9ywx+RbBmtMGCOySHOGTWP/+pSwyWrnt
         8jn7lwweV70LXJT5d92VsQ3biUihhckTP9hQiThSjvXVPEGOrGi9EEAR1k5EQKLQlYSw
         WfqQ==
X-Gm-Message-State: AOJu0Yyn80SlY4LAhj9xdO1whrK/rqJmPnd2taJzGw18l49c0QgGKDjD
	q1W/B0UiZgdwB2hNnPbkdW9MGgm7A7Y35A==
X-Google-Smtp-Source: AGHT+IFIO0eRibTvS8pwHOWMO45GrY276zFLk7TNA62c79ing/zmw1XfkJhZftzkM8Rq3lYROaC1yA==
X-Received: by 2002:a05:6000:100d:b0:336:a125:5392 with SMTP id a13-20020a056000100d00b00336a1255392mr3120930wrx.272.1704058712266;
        Sun, 31 Dec 2023 13:38:32 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b005530cb1464bsm13885786edu.15.2023.12.31.13.38.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 13:38:32 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2331e7058aso974211166b.2
        for <linux-ext4@vger.kernel.org>; Sun, 31 Dec 2023 13:38:32 -0800 (PST)
X-Received: by 2002:a17:906:a00b:b0:a27:d914:8fba with SMTP id
 p11-20020a170906a00b00b00a27d9148fbamr391751ejy.114.1704058711759; Sun, 31
 Dec 2023 13:38:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs> <20231231203903.GC36164@frogsfrogsfrogs>
In-Reply-To: <20231231203903.GC36164@frogsfrogsfrogs>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 31 Dec 2023 16:37:54 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9cJU_QH1Yt0m3Ghf34THQC9FtMe-0ahnAdzpRdQndGnw@mail.gmail.com>
Message-ID: <CAEg-Je9cJU_QH1Yt0m3Ghf34THQC9FtMe-0ahnAdzpRdQndGnw@mail.gmail.com>
Subject: Re: [PATCH 3/2] e2scrub_fail: move executable script to /usr/libexec
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 3:39=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Per FHS 3.0, non-PATH executable binaries are supposed to live under
> /usr/libexec, not /usr/lib.  e2scrub_fail is an executable script, so
> move it to libexec in case some distro some day tries to mount /usr/lib
> as noexec or something.  Also, there's no reason why these scripts need
> to be put under an arch-dependent path.
>
> Cc: Neal Gompa <neal@gompa.dev>
> Link: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s07.html
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  MCONFIG.in                     |    2 +-
>  debian/e2fsprogs.install       |    4 ++--
>  scrub/Makefile.in              |   10 +++++-----
>  scrub/e2scrub_all.cron.in      |    2 +-
>  scrub/e2scrub_fail@.service.in |    2 +-
>  util/subst.conf.in             |    2 +-
>  6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/MCONFIG.in b/MCONFIG.in
> index 82c75a28..2b1872fa 100644
> --- a/MCONFIG.in
> +++ b/MCONFIG.in
> @@ -34,7 +34,7 @@ man8dir =3D $(mandir)/man8
>  infodir =3D @infodir@
>  datadir =3D @datadir@
>  pkgconfigdir =3D $(libdir)/pkgconfig
> -pkglibdir =3D $(libdir)/e2fsprogs
> +pkglibexecdir =3D @libexecdir@/e2fsprogs
>
>  HAVE_UDEV =3D @have_udev@
>  UDEV_RULES_DIR =3D @pkg_udev_rules_dir@
> diff --git a/debian/e2fsprogs.install b/debian/e2fsprogs.install
> index 8cf07a6f..b50078d3 100755
> --- a/debian/e2fsprogs.install
> +++ b/debian/e2fsprogs.install
> @@ -16,8 +16,8 @@ sbin/resize2fs
>  sbin/tune2fs
>  usr/bin/chattr
>  usr/bin/lsattr
> -[linux-any] usr/lib/*/e2fsprogs/e2scrub_all_cron
> -[linux-any] usr/lib/*/e2fsprogs/e2scrub_fail
> +[linux-any] usr/libexec/e2fsprogs/e2scrub_all_cron
> +[linux-any] usr/libexec/e2fsprogs/e2scrub_fail
>  usr/sbin/e2freefrag
>  [linux-any] usr/sbin/e4crypt
>  [linux-any] usr/sbin/e4defrag
> diff --git a/scrub/Makefile.in b/scrub/Makefile.in
> index d0c5c11b..c97a1dd5 100644
> --- a/scrub/Makefile.in
> +++ b/scrub/Makefile.in
> @@ -95,8 +95,8 @@ installdirs-crond:
>         $(Q) $(MKDIR_P) $(DESTDIR)$(CROND_DIR)
>
>  installdirs-libprogs:
> -       $(E) "  MKDIR_P $(pkglibdir)"
> -       $(Q) $(MKDIR_P) $(DESTDIR)$(pkglibdir)
> +       $(E) "  MKDIR_P $(pkglibexecdir)"
> +       $(Q) $(MKDIR_P) $(DESTDIR)$(pkglibexecdir)
>
>  installdirs-systemd:
>         $(E) "  MKDIR_P $(SYSTEMD_SYSTEM_UNIT_DIR)"
> @@ -125,8 +125,8 @@ install-crond: installdirs-crond
>
>  install-libprogs: $(LIBPROGS) installdirs-libprogs
>         $(Q) for i in $(LIBPROGS); do \
> -               $(ES) " INSTALL $(pkglibdir)/$$i"; \
> -               $(INSTALL_PROGRAM) $$i $(DESTDIR)$(pkglibdir)/$$i; \
> +               $(ES) " INSTALL $(pkglibexecdir)/$$i"; \
> +               $(INSTALL_PROGRAM) $$i $(DESTDIR)$(pkglibexecdir)/$$i; \
>         done
>
>  install-systemd: $(SERVICE_FILES) installdirs-systemd
> @@ -169,7 +169,7 @@ uninstall-crond:
>
>  uninstall-libprogs:
>         for i in $(LIBPROGS); do \
> -               $(RM) -f $(DESTDIR)$(pkglibdir)/$$i; \
> +               $(RM) -f $(DESTDIR)$(pkglibexecdir)/$$i; \
>         done
>
>  uninstall-systemd:
> diff --git a/scrub/e2scrub_all.cron.in b/scrub/e2scrub_all.cron.in
> index 395fb2ab..8e2640d4 100644
> --- a/scrub/e2scrub_all.cron.in
> +++ b/scrub/e2scrub_all.cron.in
> @@ -1,2 +1,2 @@
> -30 3 * * 0 root test -e /run/systemd/system || SERVICE_MODE=3D1 @pkglibd=
ir@/e2scrub_all_cron
> +30 3 * * 0 root test -e /run/systemd/system || SERVICE_MODE=3D1 @pkglibe=
xecdir@/e2scrub_all_cron
>  10 3 * * * root test -e /run/systemd/system || SERVICE_MODE=3D1 @root_sb=
indir@/e2scrub_all -A -r
> diff --git a/scrub/e2scrub_fail@.service.in b/scrub/e2scrub_fail@.service=
.in
> index ae65a1da..462daee2 100644
> --- a/scrub/e2scrub_fail@.service.in
> +++ b/scrub/e2scrub_fail@.service.in
> @@ -4,7 +4,7 @@ Documentation=3Dman:e2scrub(8)
>
>  [Service]
>  Type=3Doneshot
> -ExecStart=3D@pkglibdir@/e2scrub_fail "%f"
> +ExecStart=3D@pkglibexecdir@/e2scrub_fail "%f"
>  User=3Dmail
>  Group=3Dmail
>  SupplementaryGroups=3Dsystemd-journal
> diff --git a/util/subst.conf.in b/util/subst.conf.in
> index 0da45541..5af5e356 100644
> --- a/util/subst.conf.in
> +++ b/util/subst.conf.in
> @@ -23,4 +23,4 @@ root_sbindir          @root_sbindir@
>  root_bindir            @root_bindir@
>  libdir                 @libdir@
>  $exec_prefix           @exec_prefix@
> -pkglibdir              @libdir@/e2fsprogs
> +pkglibexecdir          @libexecdir@/e2fsprogs

Looks great to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


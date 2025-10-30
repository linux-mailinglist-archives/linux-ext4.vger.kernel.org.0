Return-Path: <linux-ext4+bounces-11355-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12CC1F638
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0C3BE275
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107534D92A;
	Thu, 30 Oct 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYDg0kcJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DB34D92B
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817882; cv=none; b=NSP7YOUnRsFdMLSCG5x/0PxCHpHNBTo4RI02K4cdLiIyuDVFaeh1LDpZ2wCKtMGl2DjZxh/iw5M2ymBKHR1EnKD0uENen6FgOZqQZzrleGwSFRjtTJUKjflYFo7FQigw4D7sQ0sH06CAYNAkBVZdecxvsoPSuFKWYT6rhNYlZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817882; c=relaxed/simple;
	bh=Bdna/k+BaGIX8LkaT6I2ZdXbUrQKJnVTyqDgNR+l4hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi2cToe4zc1VWt0m87KH7cZ72lMT3hh+KiWh5Oxw1Yy4dgb8gSstTRV9C9khqOYaRKnCL+Uj9FQ71hAd+xg8Lsh0PT2/FQHp4RX3QhexUoKA2LcTwR2IQtaQyKTiThVRD+VlRMl8caxjEhLvQNu2fxn3O1w98UBgtTFvO0c0cm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYDg0kcJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d3effe106so166939566b.2
        for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761817878; x=1762422678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5VVNoQwAWyxLpv1h4Yk/Mj6zmb3mSEma5Re6w3inwA=;
        b=MYDg0kcJWLY2+kI9HNpKPEaTQOvLdTAgJwygpyQg71tnZm+yOM7kcr62DpcJAdwjvm
         LcSd8q32sgcRcbX5tp0ZGHU8F8lLRiY1UmndI0dYDDLfSp9L/M73x58rZeh9giXJrixt
         DBrl7NNXrKL69/n2V7SPuNQghJ9Rcar893iMunLrVCX6wpCroZA5ToLBCjshDjZwunDv
         YfZmj58HAAlaYT22/ps3oGptcBK67jOHk+awfV/fuqFrT3ytFuM/sAT9xdNaHJfxywbk
         vvi0L2cooCImXwjDBQJ27ZhnXKOMK0cvFi5hnVee6RQFoctWsKw2LZNW+JAesdCmCSCf
         npVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817878; x=1762422678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5VVNoQwAWyxLpv1h4Yk/Mj6zmb3mSEma5Re6w3inwA=;
        b=D+BbtYW/VZZRxBeNZDoa5tzGB84aSleVUCsHml13FuI3FhlwDPDC4fNGSMRwBHkbkU
         6Oqf7kjPNoJkv4hE6QHLgNAEyxnRhXsV6zZl/3Jkn6tT2gRbYBJWb34wC8hO0Fv8mNdn
         IKHlU4hqVmxJEGKbOCqzU7qkz6joSY5INOwZwDFI5QjFksKbgXtEdkNwz6G3zPK6f3I1
         PVEMm7Ul+/06HTYyWZdlkK25OfGCFsZKDAf3HLgnZK0BU2hDA+gnXpy1efXT/yH4hXaS
         kLB0JGYLTAhHd/QI6TH+qHD5I0FPiKAa5ojZHzUK0BPpb9Jd5qcJLlA2Vn8XE2UZCeLT
         loOg==
X-Forwarded-Encrypted: i=1; AJvYcCXYd05ag/12e8cYgqg0yqVndOQqeIdHFHbYlB2MNmsUs9ScpSMfY0EycnwvPL1I8DfW8gnHEzZoLyZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlscWbiMTK8Sk2UmED8OCPRCZuTyZ12gqU+gYEav3PyzljRez
	gsLOep1yQI5C8q9J7oviM6H8bEIG5uygLQs3QdrN5F7IsM2q91RQ0SN6nCV+hK6qFhMVO2nCwX2
	ayoKDRdS6kNk+r/fKMtZdCD9iuqHmA0s=
X-Gm-Gg: ASbGncti2ajjXqM8Jte+0IjSnHuH9BLLA8aXYBGBfBLq8QF2CBY51bYFVLnYI0teRDk
	O16OY6agcQxAtQpbMqxl0Oh/q1qL2ci8bSTYAYiLAzSUXd1Z2rjNq9Zkvam/cq+1pOGeZjVk0u1
	PM0gIFoAHSy8ruuJblc2POLWsh6kKytaYDxt/gVQtObvCNo92HiNsjvhwupG0BE/CDf0QdgweYL
	hinWPOUQR6jKRKlYpy4Zp1p09rZ6+6zjBR60R3pwkbp1NABo0kXO4IlqcV4NezTHzDLfq644NJE
	FcEkiPQkiuVrR5U6eSQC9uY/RO22kQ==
X-Google-Smtp-Source: AGHT+IELIK29pokw4BqrETi6ux8k4VU44qQ8Wmg/FKWNqv6zxVGH3i0jvrbk20hFfDtK/D19rPcWE0k9BP36i6GETJE=
X-Received: by 2002:a17:906:c150:b0:b6d:825b:828 with SMTP id
 a640c23a62f3a-b703d2fe70amr635701766b.25.1761817877746; Thu, 30 Oct 2025
 02:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 10:51:06 +0100
X-Gm-Features: AWmQ_blB63OMqxUWNdRkp3OOlUR9_IfpMd0IzrnF48FrTNtUADrYcfamedHhE2k
Message-ID: <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:22=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> It would be useful to be able to run fstests against the userspace
> ext[234] driver program fuse2fs.  A convention (at least on Debian)
> seems to be to install fuse drivers as /sbin/mount.fuse.XXX so that
> users can run "mount -t fuse.XXX" to start a fuse driver for a
> disk-based filesystem type XXX.
>
> Therefore, we'll adopt the practice of setting FSTYP=3Dfuse.ext4 to
> test ext4 with fuse2fs.  Change all the library code as needed to handle
> this new type alongside all the existing ext[234] checks, which seems a
> little cleaner than FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4, which also would
> require even more treewide cleanups to work properly because most
> fstests code switches on $FSTYP alone.
>

I agree that FSTYP=3Dfuse.ext4 is cleaner than
FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4
but it is not extendable to future (e.g. fuse.xfs)
and it is still a bit ugly.

Consider:
FSTYP=3Dfuse.ext4
MKFSTYP=3Dext4

I think this is the correct abstraction -
fuse2fs/ext4 are formatted that same and mounted differently

See how some of your patch looks nicer and naturally extends to
the imaginary fuse.xfs...

> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  check             |   24 +++++++++++++++++-------
>  common/casefold   |    4 ++++
>  common/config     |   11 ++++++++---
>  common/defrag     |    2 +-
>  common/encrypt    |   16 ++++++++--------
>  common/log        |   10 +++++-----
>  common/populate   |   14 +++++++-------
>  common/quota      |    9 +++++++++
>  common/rc         |   50 +++++++++++++++++++++++++++++------------------=
---
>  common/report     |    2 +-
>  common/verity     |    8 ++++----
>  tests/generic/020 |    2 +-
>  tests/generic/067 |    2 +-
>  tests/generic/441 |    2 +-
>  tests/generic/496 |    2 +-
>  tests/generic/621 |    2 +-
>  tests/generic/740 |    2 +-
>  tests/generic/746 |    4 ++--
>  tests/generic/765 |    4 ++--
>  19 files changed, 103 insertions(+), 67 deletions(-)
>
>
> diff --git a/check b/check
> index 9bb80a22440f97..81cd03f73ce155 100755
> --- a/check
> +++ b/check
> @@ -140,12 +140,25 @@ get_sub_group_list()
>         echo $grpl
>  }
>
> +get_group_dirs()
> +{
> +       local fsgroup=3D"$FSTYP"
> +
> +       case "$FSTYP" in
> +       ext2|ext3|fuse.ext[234])
> +               fsgroup=3Dext4
> +               ;;
> +       esac
> +
> +       echo $SRC_GROUPS
> +       echo $fsgroup
> +}
> +
>  get_group_list()
>  {
>         local grp=3D$1
>         local grpl=3D""
>         local sub=3D$(dirname $grp)
> -       local fsgroup=3D"$FSTYP"
>
>         if [ -n "$sub" -a "$sub" !=3D "." -a -d "$SRC_DIR/$sub" ]; then
>                 # group is given as <subdir>/<group> (e.g. xfs/quick)
> @@ -154,10 +167,7 @@ get_group_list()
>                 return
>         fi
>
> -       if [ "$FSTYP" =3D ext2 -o "$FSTYP" =3D ext3 ]; then
> -           fsgroup=3Dext4
> -       fi
> -       for d in $SRC_GROUPS $fsgroup; do
> +       for d in $(get_group_dirs); do
>                 if ! test -d "$SRC_DIR/$d" ; then
>                         continue
>                 fi
> @@ -171,7 +181,7 @@ get_group_list()
>  get_all_tests()
>  {
>         touch $tmp.list
> -       for d in $SRC_GROUPS $FSTYP; do
> +       for d in $(get_group_dirs); do
>                 if ! test -d "$SRC_DIR/$d" ; then
>                         continue
>                 fi
> @@ -387,7 +397,7 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
>  fi
>
>  if [ -n "$subdir_xfile" ]; then
> -       for d in $SRC_GROUPS $FSTYP; do
> +       for d in $(get_group_dirs); do
>                 [ -f $SRC_DIR/$d/$subdir_xfile ] || continue
>                 for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
>                         exclude_tests+=3D($d/$f)
> diff --git a/common/casefold b/common/casefold
> index 2aae5e5e6c8925..fcdb4d210028ac 100644
> --- a/common/casefold
> +++ b/common/casefold
> @@ -6,6 +6,10 @@
>  _has_casefold_kernel_support()
>  {
>         case $FSTYP in
> +       fuse.ext[234])
> +               # fuse2fs does not support casefolding
> +               false
> +               ;;

This would not be needed

>         ext4)
>                 test -f '/sys/fs/ext4/features/casefold'
>                 ;;
> diff --git a/common/config b/common/config
> index 7fa97319d7d0ca..0cd2b33c4ade40 100644
> --- a/common/config
> +++ b/common/config
> @@ -386,6 +386,11 @@ _common_mount_opts()
>         overlay)
>                 echo $OVERLAY_MOUNT_OPTIONS
>                 ;;
> +       fuse.ext[234])
> +               # fuse sets up secure defaults, so we must explicitly tel=
l
> +               # fuse2fs to use the more relaxed kernel access behaviors=
.
> +               echo "-o kernel $EXT_MOUNT_OPTIONS"
> +               ;;
>         ext2|ext3|ext4)
>                 # acls & xattrs aren't turned on by default on ext$FOO
>                 echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> @@ -472,7 +477,7 @@ _mkfs_opts()
>  _fsck_opts()
>  {
>         case $FSTYP in

This would obviously be $MKFSTYP with no further changes

> -       ext2|ext3|ext4)
> +       ext2|ext3|fuse.ext[234]|ext4)
>                 export FSCK_OPTIONS=3D"-nf"
>                 ;;
>         reiser*)
> @@ -514,11 +519,11 @@ _source_specific_fs()
>
>                 . ./common/btrfs
>                 ;;
> -       ext4)
> +       fuse.ext4|ext4)
>                 [ "$MKFS_EXT4_PROG" =3D "" ] && _fatal "mkfs.ext4 not fou=
nd"
>                 . ./common/ext4
>                 ;;
> -       ext2|ext3)
> +       ext2|ext3|fuse.ext[23])
>                 . ./common/ext4

same here

>                 ;;
>         f2fs)
> diff --git a/common/defrag b/common/defrag
> index 055d0d0e9182c5..c054e62bde6f4d 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -12,7 +12,7 @@ _require_defrag()
>          _require_xfs_io_command "falloc"
>          DEFRAG_PROG=3D"$XFS_FSR_PROG"
>         ;;
> -    ext4)
> +    fuse.ext4|ext4)
>         testfile=3D"$TEST_DIR/$$-test.defrag"
>         donorfile=3D"$TEST_DIR/$$-donor.defrag"
>         bsize=3D`_get_block_size $TEST_DIR`

and here

> diff --git a/common/encrypt b/common/encrypt
> index f2687631b214cf..4fa7b6853fd461 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -191,7 +191,7 @@ _require_hw_wrapped_key_support()
>  _scratch_mkfs_encrypted()
>  {
>         case $FSTYP in
> -       ext4|f2fs)
> +       fuse.ext4|ext4|f2fs)
>                 _scratch_mkfs -O encrypt
>                 ;;

and here

>         ubifs)
> @@ -210,7 +210,7 @@ _scratch_mkfs_encrypted()
>  _scratch_mkfs_sized_encrypted()
>  {
>         case $FSTYP in
> -       ext4|f2fs)
> +       fuse.ext4|ext4|f2fs)
>                 MKFS_OPTIONS=3D"$MKFS_OPTIONS -O encrypt" _scratch_mkfs_s=
ized $*
>                 ;;

and here... I think you got my point.

Thanks,
Amir.


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BEB67A474
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 21:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjAXU7X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 15:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAXU7W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 15:59:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E75040BF8
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 12:59:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b10so16405799pjo.1
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HtrUlM9IgbcEtwwFZXSMmcKeYNyNr4P+DF1UaRY4C9w=;
        b=mHUU8cI0CGhbYRgAxyqMwYgrQqQyRG5Hy645qYo8OZ9DVdeBvnBVi1V0UiMSwJwese
         hOa/QIab8OtcriZKSO54jWLWpdT07MXCCDNf+enzJPkAtCz1uUnXLuPq6W1JJRupqVSZ
         zCAqDscWjUSA+IL8Uvu9W3jr24StI/JtyRsxP2AsLl1grBZ+n2a7mmiaHeFQ9QSXkElk
         mr6UpanYnrqEvzvP4FTqktmZn+VCPp24pKobg9rSVeWg5QoQRnYOvi2MTWvziZrg4JH0
         xloctZwQqjU4QbOzXnvp54PvJ2Jd/YQwX8v+1OizA59+iQ7+dc93Mc0CnnI/XNS9zIYV
         BO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtrUlM9IgbcEtwwFZXSMmcKeYNyNr4P+DF1UaRY4C9w=;
        b=auhhQyKGOyOcesVjO/041iL+7I8HMNfz6wemOJJCLy1WZCbvi3lqwUopTX1B8WqlZB
         ReLIyuL6iRA9Jvg0wj+3grKtwTOo+1H/UaLNkdeV4p6gc3hEv96S3ObXjsg28sVK2DZR
         Vpjj6Y00lluBoi6M6Q3WGr9bwysDzRE1BkJqm4pI5DsPhUrDAPRUhK6n/e+aBwCpNUS7
         aIiNKJPAyhQRtFdk40EhlX8vOAPvu7bzG1EoLU5euIsNfQp3FkPaeayPSomZscgvQ84t
         1xwJ2QXi6qFXnyeCiIeQ5bvRuKXGpH5k85CJofzDADd9rLqzRC6Awm69lFsZC7rCwwtB
         zjsQ==
X-Gm-Message-State: AFqh2kpZufrqNzXp9XZNj48PK5eHV6h6Hy+YkNhZKGj/l5XH3fPzav5G
        2epHU2nc3WhnCWStHnBqYdDRZw==
X-Google-Smtp-Source: AMrXdXv/znI0GyC6NYsNIIwfgTMXaqE4ULpX22sFkcEdYeyCRCi9xW59UhI9MuuktLc+H60reN5jmw==
X-Received: by 2002:a05:6a20:8355:b0:a3:94cd:1435 with SMTP id z21-20020a056a20835500b000a394cd1435mr28934835pzc.38.1674593958946;
        Tue, 24 Jan 2023 12:59:18 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o6-20020a639206000000b004468cb97c01sm1872516pgd.56.2023.01.24.12.59.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2023 12:59:18 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F8EB3EA0-3563-49FE-BEDC-221B852FE58E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_18344C38-058B-455A-B5EC-A2FD38561D84";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 00/38] e2fsprogs: misc fixes, and add a GitHub Actions
 file
Date:   Tue, 24 Jan 2023 13:59:14 -0700
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_18344C38-058B-455A-B5EC-A2FD38561D84
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 21, 2023, at 1:31 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> 
> The last patch of this series adds a workflow file for GitHub Actions
> that builds and tests e2fsprogs on Ubuntu, macOS, and Windows.  It's
> enforced that the build does not produce warnings with -Wall.
> 
> (For now, the Windows build is much more basic than the others; only
> mke2fs is built, and the unit tests are not run.)
> 
> The workflow will run on pushes to any fork of e2fsprogs that has GitHub
> Actions enabled.  I'm hoping that Ted will enable it for the "official"
> fork at https://github.com/tytso/e2fsprogs, but anyone can use it in
> their own fork too.  The results for this patch series are at
> https://github.com/ebiggers/e2fsprogs/actions/runs/3976382057
> 
> As a prerequisite to actually getting everything to pass, patches 1-37
> of this series fix a large number of miscellaneous issues, mainly
> pertaining to warnings with -Wall or to the Windows build.

Thanks in advance for this patch series.  I have a kick at the cat for
e2fsprogs build/test warnings occasionally, but getting this into a
Github CI setup should keep them out of the woodwork.

I'll try to have a pass through all of the patches, but most of them
seem pretty straight forward.

Cheers, Andreas

> Some patches in this series I've already sent out individually.  This
> series supersedes all my previous patches.
> 
> Eric Biggers (38):
>  configure.ac: only use Windows I/O manager on native Windows
>  configure.ac: disable tdb by default on Windows
>  configure.ac: automatically add include/mingw/ headers
>  configure: regenerate
>  config/install-sh: update to latest version
>  lib, misc: eliminate dependency on Winsock
>  lib/blkid: remove 32-bit x86 byteswap assembly
>  lib/blkid: fix unaligned access to hfs_mdb
>  lib/blkid: fix -Wunused-variable warning in blkid_get_dev_size()
>  lib/blkid: suppress -Wunused-result warning in blkid_flush_cache()
>  lib/blkid: suppress -Wstringop-truncation warning in blkid_strndup()
>  lib/e2p: fix a -Wunused-variable warning in getflags()
>  lib/{e2p,ss}: remove manual declarations of errno
>  lib/et: fix "unused variable" warnings when !HAVE_FCNTL
>  lib/ext2fs: remove 32-bit x86 bitops assembly
>  lib/ext2fs: consistently use #ifdefs in ext2fs_print_bmap_statistics()
>  lib/ext2fs: remove unused variable in ext2fs_xattrs_read_inode()
>  lib/ext2fs: fix a printf format specifier in file_test()
>  lib/ext2fs: fix two compiler warnings in windows_io.c
>  lib/ext2fs: fix a -Wpointer-sign warning in ext2fs_mmp_start()
>  lib/{ext2fs,support}: fix 32-bit Windows build
>  lib/ss: fix 'make install' by creating man1dir
>  lib/support: remove unused label in get_devname()
>  lib/support: clean up definition of flags_array
>  lib/uuid: remove conflicting Windows implementation of gettimeofday()
>  e2fsck: use real functions for kernel slab functions
>  misc/create_inode: fix -Wunused-variable warnings in __populate_fs()
>  misc/create_inode: simplify logic in scandir()
>  misc/e4defrag: fix -Wstringop-truncation warnings
>  misc/fuse2fs: avoid error-prone strncpy() pattern
>  misc/mk_hugefiles: simplify get_partition_start()
>  misc/mke2fs: fix Windows build
>  misc/mke2fs: fix a -Wunused-variable warning in PRS()
>  misc/tune2fs: fix setting fsuuid::fsu_len
>  misc/tune2fs: fix -Wunused-variable warnings in handle_fslabel()
>  misc/util.c: enable MinGW alarm() when building for Windows
>  resize2fs: remove unused variable from adjust_superblock()
>  Add a configuration file for GitHub Actions
> 
> .github/workflows/ci.yml      | 116 ++++++
> aclocal.m4                    | 180 +++++----
> config/install-sh             | 683 ++++++++++++++++++++++++----------
> configure                     | 105 ++++--
> configure.ac                  |  50 ++-
> e2fsck/jfs_user.h             |  62 ++-
> include/mingw/arpa/inet.h     |   5 +
> include/mingw/sys/sysmacros.h |   8 +-
> lib/blkid/Android.bp          |   1 -
> lib/blkid/devno.c             |  10 +
> lib/blkid/getsize.c           |   2 +-
> lib/blkid/probe.c             |  10 +-
> lib/blkid/probe.h             |  43 ---
> lib/blkid/save.c              |   8 +
> lib/config.h.in               | 100 ++++-
> lib/e2p/Android.bp            |   4 -
> lib/e2p/fgetversion.c         |   2 -
> lib/e2p/fsetversion.c         |   1 -
> lib/e2p/getflags.c            |   3 +-
> lib/e2p/getversion.c          |   1 -
> lib/e2p/setversion.c          |   1 -
> lib/et/Android.bp             |   3 -
> lib/et/error_message.c        |  10 +-
> lib/ext2fs/Android.bp         |   2 -
> lib/ext2fs/bitops.c           |  14 +-
> lib/ext2fs/bitops.h           |  97 -----
> lib/ext2fs/ext2_io.h          |   2 +
> lib/ext2fs/ext_attr.c         |   2 -
> lib/ext2fs/gen_bitmap64.c     |   6 +-
> lib/ext2fs/getsectsize.c      |  12 +-
> lib/ext2fs/inline_data.c      |   2 +-
> lib/ext2fs/jfs_compat.h       |   4 -
> lib/ext2fs/mmp.c              |   2 +-
> lib/ext2fs/windows_io.c       |  12 +-
> lib/ss/Makefile.in            |   5 +-
> lib/ss/execute_cmd.c          |   2 -
> lib/ss/help.c                 |   2 -
> lib/ss/pager.c                |   2 -
> lib/support/devname.c         |   1 -
> lib/support/plausible.c       |   7 +-
> lib/support/print_fs_flags.c  |  60 +--
> lib/uuid/gen_uuid.c           |  21 --
> misc/Android.bp               |   3 -
> misc/create_inode.c           |  36 +-
> misc/e4defrag.c               |  30 +-
> misc/fuse2fs.c                |   5 +-
> misc/mk_hugefiles.c           | 134 +------
> misc/mke2fs.c                 |  22 +-
> misc/tune2fs.c                |   7 +-
> misc/util.c                   |   5 +
> resize/resize2fs.c            |   4 -
> util/android_config.h         |   1 -
> util/subst.c                  |   4 +-
> 53 files changed, 1102 insertions(+), 812 deletions(-)
> create mode 100644 .github/workflows/ci.yml
> create mode 100644 include/mingw/arpa/inet.h
> 
> 
> base-commit: aad34909b6648579f42dade5af5b46821aa4d845
> --
> 2.39.0
> 


Cheers, Andreas






--Apple-Mail=_18344C38-058B-455A-B5EC-A2FD38561D84
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPQRqMACgkQcqXauRfM
H+Az5A//U+zS99mKJG6PwzyXQzKENAsrZPwKDZuJRf5raEjlDPjd3XAYHJDoDzUF
UDN1+A6VET7n6Mx9MfZasEuQYLQUG3LnJkTVYRXQWnxJbSTL7y4lar5+0gregtb/
DYtIkGXDTQ/E57L5lrQA+PoXIiqJcUlsPZAEVKExLGWd1LNyJi6SLczd0y2UzktY
EZ8iK/JnkT8BcwowtmUOaYJn2CM3+m1CkomBUEpMgrRPVldfxOLxBvmZC7oensgW
3Am6jq3aDpG8Zu+9V1IRF9CJdGhQs2ZfL+oxAm3b293eTBmOsmmkyUIS+blZq5le
2vHwYV3dmaD2xkzWgdbP79959hRqg6N4ROd8OtF+UvZAP3WdFwZVM8tIimsKYZYB
vnWNl4ZHbbEnbXYrt1AVAAJd861JljSF/g5cRzUPrbutxFXQTaB4HOXJ2pFElW2U
Wdzn8jNzPS8LwtAexvyAS1Fg98iS2KtNAIlR/bNTCPKCRTTSBdI118klq9oTe2T+
sYXE5g1hI/1gVEvmRrG1TsuCdYRom5k5e+X+m7uW/U1pzZwkLPvdnJKVdE1WYfbK
Gf1Sfygl7LmgM5SzrSzcfHxuxPGvZsVtJTZl+JxjZ2DjcX7NviHWgK9yGipuKpha
1TYJxI1z88E8pBmVFQIu3GB6ZjRdheUGTUzlKc4m8nx7tDa6edo=
=Qm38
-----END PGP SIGNATURE-----

--Apple-Mail=_18344C38-058B-455A-B5EC-A2FD38561D84--

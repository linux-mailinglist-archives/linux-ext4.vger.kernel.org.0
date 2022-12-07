Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB66454DE
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLGHvR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLGHvN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:51:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34673056E;
        Tue,  6 Dec 2022 23:51:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u5so7444128pjy.5;
        Tue, 06 Dec 2022 23:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5PHeRraBhQYSKRsmRVyn7+22gbtfjmPBgVFxWHkEUQ=;
        b=GsyAEhlgqaWyf57vBQ5b3Z8afdf32YWhvzvBTJQFzXvywwypkz6W3fjaw98GarN8pS
         UqUy9QzRewby51d6QW6I10R2XOxXi/2Zv4Q64nl8rTElRhjIH4fL52BwF8MD0hcZF+kI
         s9y4aVLbfyxbdsW7rDBBjPklzsoqzMuG/fLDJ8xVMQLOPgWxTShm3uG5V3xcSjnZpyIQ
         T16GRJVsfygowNRubZFCMzcYUDBpYstb7OcV78DB4qQaur8kOZyp327dUonTg+nW2WAp
         amDdGQ2Nh7DWq0ELl2qPPZHtRLCWHu+BRFub3qn2306huD/YLd9ZVJqA/UGbu7JWAK1p
         s6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5PHeRraBhQYSKRsmRVyn7+22gbtfjmPBgVFxWHkEUQ=;
        b=4C6aAGrsfzGh7DgTSObtHBl6LMmmQzs9hB/RlUwlYZpLOZ+z/pYWRLzHaBS0i5KWKg
         lJN6s6w/7ouwqP7xRWH4Tlzg4E6icqfy78GlvviP+Aeaayy3QcmjlOGQ1gE1GNAJaHvb
         S4g5w3YvpAV4dxWimFfu/ISv1PoVAi03lr3xQJikykab7boqaHGLF1QbSzldg9lQGqu+
         fZLHHg8+SA0ztIUWb8FdYL7QQLR5NzqpY1G3d4Mr511odQL6dIdb0E7xDZV0JRmJcGx+
         Jl1s6oQZGRi2BsOiqb8P2a54q0tGfkQ9QjSs/BIUMXH7UhzObCyfeNY60PSfaH1B9RIa
         dpGQ==
X-Gm-Message-State: ANoB5pkeLyre7CXnd0ERiYYRYEoRfdkBEz0cezFzGUrncY465NXx+tYf
        gbkSjafURCXSeVhlUKlli3Q=
X-Google-Smtp-Source: AA0mqf7O/4fsmZxQSq7lHyOPz3OHQn8xy5tlRTMVClaIHdRilWXP6LDdqvtVQi7Cdfc/39iFAeCcNQ==
X-Received: by 2002:a17:902:ee01:b0:189:e089:5d51 with SMTP id z1-20020a170902ee0100b00189e0895d51mr10017547plb.165.1670399471324;
        Tue, 06 Dec 2022 23:51:11 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78f27000000b0057462848b94sm12865703pfr.184.2022.12.06.23.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 23:51:10 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2BC031042C6; Wed,  7 Dec 2022 14:51:08 +0700 (WIB)
Date:   Wed, 7 Dec 2022 14:51:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/6] ext4: fix WARNING in ext4_expand_extra_isize_ea
Message-ID: <Y5BF7HXEwZjeKU+a@debian.me>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7cMIbbkAoBXvbc6K"
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--7cMIbbkAoBXvbc6K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:40:38PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>=20
> Syzbot found the following issue:
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3631 at mm/page_alloc.c:5534 __alloc_pages+0x30a/0x5=
60 mm/page_alloc.c:5534
> Modules linked in:
> CPU: 1 PID: 3631 Comm: syz-executor261 Not tainted 6.1.0-rc6-syzkaller-00=
308-g644e9524388a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/26/2022
> RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
> RSP: 0018:ffffc90003ccf080 EFLAGS: 00010246
> RAX: ffffc90003ccf0e0 RBX: 000000000000000c RCX: 0000000000000000
> RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003ccf108
> RBP: ffffc90003ccf198 R08: dffffc0000000000 R09: ffffc90003ccf0e0
> R10: fffff52000799e21 R11: 1ffff92000799e1c R12: 0000000000040c40
> R13: 1ffff92000799e18 R14: dffffc0000000000 R15: 1ffff92000799e14
> FS:  0000555555c10300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffc36f70000 CR3: 00000000744ad000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __alloc_pages_node include/linux/gfp.h:223 [inline]
>  alloc_pages_node include/linux/gfp.h:246 [inline]
>  __kmalloc_large_node+0x8a/0x1a0 mm/slab_common.c:1096
>  __do_kmalloc_node mm/slab_common.c:943 [inline]
>  __kmalloc+0xfe/0x1a0 mm/slab_common.c:968
>  kmalloc include/linux/slab.h:558 [inline]
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2558 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2673 [inline]
>  ext4_expand_extra_isize_ea+0xe3f/0x1cd0 fs/ext4/xattr.c:2765
>  __ext4_expand_extra_isize+0x2b8/0x3f0 fs/ext4/inode.c:5857
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5900 [inline]
>  __ext4_mark_inode_dirty+0x51a/0x670 fs/ext4/inode.c:5978
>  ext4_inline_data_truncate+0x548/0xd00 fs/ext4/inline.c:2021
>  ext4_truncate+0x341/0xeb0 fs/ext4/inode.c:4221
>  ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
>  ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5515 [inline]
>  ext4_fill_super+0x80ed/0x8610 fs/ext4/super.c:5643
>  get_tree_bdev+0x400/0x620 fs/super.c:1324
>  vfs_get_tree+0x88/0x270 fs/super.c:1531
>  do_new_mount+0x289/0xad0 fs/namespace.c:3040
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  </TASK>
>=20
> Reason is allocate 16M memory by kmalloc, but MAX_ORDER is 11, kmalloc
> can allocate maxium size memory is 4M.
> XATTR_SIZE_MAX is currently 64k, but EXT4_XATTR_SIZE_MAX is '(1 << 24)',
> so 'ext4_xattr_check_entries()' regards this length as legal. Then trigger
> warning in 'ext4_xattr_move_to_block()'.
> To solve above issue, change EXT4_XATTR_SIZE_MAX from '(1 << 24)' to
> XATTR_SIZE_MAX. As VFS limit extended attribute maxium size to XATTR_SIZE=
_MAX.
> So we can assume that there will be no extended attribute with a length g=
reater
> than XATTR_SIZE_MAX.

What is the value of (1 << 24)?

The prose reads a rather confused. kmalloc allocates 16M memory, but the
maximum memory size that kmalloc can allocate is 4M, right?

--=20
An old man doll... just what I always wanted! - Clara

--7cMIbbkAoBXvbc6K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BF6wAKCRD2uYlJVVFO
o8A0AP9l3Vj7w6Y4Ie06x29OS+hsY8JP6mBIJqVtsq6pZ9eKlgEA6zwsAmFhkwlZ
goOzqZHYlHwDD6oxt6A11pgkP4L0UAQ=
=4iFM
-----END PGP SIGNATURE-----

--7cMIbbkAoBXvbc6K--

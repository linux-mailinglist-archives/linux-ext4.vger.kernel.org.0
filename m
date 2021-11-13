Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C410844F2FD
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Nov 2021 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhKMMIB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Nov 2021 07:08:01 -0500
Received: from disco.pogo.org.uk ([93.93.128.62]:61859 "EHLO disco.pogo.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235377AbhKMMIB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 13 Nov 2021 07:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
        ; s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
        Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oNfWyu925PghKORcLrBufS4YQUpCJfsdbchDw92NhyI=; b=Zn6VtbVzuzKt+mpSqhIDM4dnzI
        9Iki6pIgR7yIj6/9PItNrXHydB3mz5v8qw9U97MW0di0NiAkmONXzRYN5whFYPD8wZ7lnUFmGEY6C
        H4CYayga0l6bLb/qP4xBqfX14Od8kwts0JpEdD37+cnTwNQMeKa7+wblqrflxrtHk5TQ=;
Received: from [2001:470:1d21:0:1b49:e745:2847:2811] (helo=tamla)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1mlrmO-000OCp-Ji; Sat, 13 Nov 2021 12:05:07 +0000
Received: from localhost (tamla.localdomain [local])
        by tamla.localdomain (OpenSMTPD) with ESMTPA id 69d84415;
        Sat, 13 Nov 2021 12:05:07 +0000 (GMT)
Date:   Sat, 13 Nov 2021 12:05:07 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     Andreas Dilger <adilger@dilger.ca>
cc:     linux-ext4@vger.kernel.org
Subject: Re: Maildir quickly hitting max htree
In-Reply-To: <36FABD31-B636-4D94-B14D-93F3D2B4C148@dilger.ca>
Message-ID: <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org>
References: <2111121900560.16086@stax.localdomain> <36FABD31-B636-4D94-B14D-93F3D2B4C148@dilger.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2097733802-1636805107=:21837"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2097733802-1636805107=:21837
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Andreas, thanks for such a prompt reply.

On Fri, 12 Nov 2021, Andreas Dilger wrote:

> On Nov 12, 2021, at 11:37, Mark Hills <mark@xwax.org> wrote:
> >=20
> > =EF=BB=BFSurprised to hit a limit when handling a modest Maildir case; =
does=20
> > this reflect a bug?
> >=20
> > rsync'ing to a new mail server, after fewer than 100,000 files there=20
> > are intermittent failures:
>=20
> This is probably because you are using 1KB blocksize instead of 4KB,=20
> which reduces the size of each tree level by the cube of the ratio, so=20
> 64x. I guess that was selected because of very small files in the=20
> maildir?

Interesting! The 1Kb block size was not explicitly chosen. There was no=20
plan other than using the defaults.

However I did forget that this is a VM installed from a base image. The=20
root cause is likely to be that the /home partition has been enlarged from=
=20
a small size to 32Gb.

Is block size the only factor? If so, a patch like below (untested) could=
=20
make it clear it's relevant, and saved the question in this case.

[...]
> If you have a relatively recent kernel, you can enable the "large_dir"=20
> feature to allow 3-level htree, which would be enough for another factor=
=20
> of 1024/8 =3D 128 more entries than now (~12M).

The system is not yet in use, so I think it's better we reformat here, and=
=20
get a block size chosen by the experts :)

These days I think VMs make it more common to enlarge a filesystem from a=
=20
small size. We could have picked this up earlier with a warning from=20
resize2fs; eg. if the block size will no longer match the one that would=20
be chosen by default. That would pick it up before anyone puts 1Kb block=20
size into production.

Thanks for identifying the issue.

--=20
Mark


From=208604c50be77a4bc56a91099598c409d5a3c1fdbe Mon Sep 17 00:00:00 2001
From: Mark Hills <mark@xwax.org>
Date: Sat, 13 Nov 2021 11:46:50 +0000
Subject: [PATCH] Block size has an effect on the index size

---
 fs/ext4/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index f3bbcd4efb56..8965bed4d7ff 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2454,8 +2454,9 @@ static int ext4_dx_add_entry(handle_t *handle, struct=
 ext4_filename *fname,
 =09=09}
 =09=09if (add_level && levels =3D=3D ext4_dir_htree_level(sb)) {
 =09=09=09ext4_warning(sb, "Directory (ino: %lu) index full, "
-=09=09=09=09=09 "reach max htree level :%d",
-=09=09=09=09=09 dir->i_ino, levels);
+=09=09=09=09=09 "reach max htree level :%d"
+=09=09=09=09=09 "with block size %lu",
+=09=09=09=09=09 dir->i_ino, levels, sb->s_blocksize);
 =09=09=09if (ext4_dir_htree_level(sb) < EXT4_HTREE_LEVEL) {
 =09=09=09=09ext4_warning(sb, "Large directory feature is "
 =09=09=09=09=09=09 "not enabled on this "
--=20
2.33.1

--0-2097733802-1636805107=:21837--

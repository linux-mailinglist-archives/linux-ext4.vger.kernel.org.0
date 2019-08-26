Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CD9C896
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfHZFHu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 01:07:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45873 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHZFHu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 01:07:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so9406735plr.12
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Xmihh81w3U6cpqDunTSNiKgrFgCkfaddfnQQPuPGejA=;
        b=So4vBQD0JAeoZlB4H9X2AOzjC0xv6BV2XoiFf8YEI/uqdaZJJtyi6A0hFyHWpBvfJb
         uZz0zUprYwxvGgSJuA5te3gRowIbI5dIYjhdBgInSkLrU4gbhwpeev1KWwHfJ0AjyFHU
         oKIL2ZUpzF3M43hq0fmNkyUy9LxqG1mdzFqwl3LUa7kJg929KJPkF8rpdehjsoiN4la6
         8+9R4jSbmrL6krsu4EFOob3/4bIsm2+Ay4JrvNaY+8yy5b0eQFBJ4dVUHpx/SZopwBYO
         SBxp22PboTuJxmi8pZmgNJRsTmMNuIYz1+L3Uf8RTXn501cMxgZ8/wo2CdXgmf+wKfR6
         y4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Xmihh81w3U6cpqDunTSNiKgrFgCkfaddfnQQPuPGejA=;
        b=MSxDqZr4yZtxk02i5L+kH0H+66klROWa4kLC4yJevF/7KGyyFO7NN+Mt9N5hKeozm0
         +PjZwDfilavoEBA2wBo8iDfzC9580K9fcDorEsugjbr2mwQRFnv3yBzrZNBd1Vw2hTAo
         wSjgxSnaHGs20HCW2WzMlF8EDa+zvzKq6xwZnrmpTm5uWKtdOuJrZ3OD6Pib3JlBXRoF
         cgggcHFyzG7K05+bmOrxfY7S/vkpd2h7aWGNwpBp/QwJbTpTwkb6XittuTfROWFu3gN4
         51pyqvq+aeavH3w7iiOjugEndQPp07GRdWPDHsq2mPqBxWRmR/K2iIo32XwFru2R0SOg
         cvNg==
X-Gm-Message-State: APjAAAXObgj3ZBgAAedYJa2/VWu0M4wkMKaOscy36+b7CpfD9xUc08SG
        Lb2k7YSi2vunubonlI1k1AVnAA==
X-Google-Smtp-Source: APXvYqxmzVoebW/P178FKOomDFgkVVbD0MV/U44t0ix5irTWfBcOLIs6FlJs+8pMZcbVhmSDWHTBMw==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr17561895plb.58.1566796069246;
        Sun, 25 Aug 2019 22:07:49 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id s13sm5042568pfm.12.2019.08.25.22.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 22:07:48 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0C4A5CBD-E6D7-4AD4-A1DF-E72829DB7298";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
Date:   Sun, 25 Aug 2019 23:07:46 -0600
In-Reply-To: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0C4A5CBD-E6D7-4AD4-A1DF-E72829DB7298
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 21, 2019, at 12:27 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> On every dentry deletion, this patch traverses directory inode in
> reverse direction and frees up empty dirent blocks until it finds a
> non-empty dirent block. We leverage the fact that we never clear
> dentry name when we delete dentrys by merging them with the previous
> one. So, even though the dirent block has only fake dentry which spans
> across the entire block, we can use the name in this dead entry to
> perform dx lookup and find intermediate dx node blocks as well as
> offset inside these blocks.


One high-level limitation with this implementation is that it is =
unlikely
to remove any directory blocks until the directory is almost entirely
empty since "rm -r" will return entries in hash order, which does not
match the order that the leaf blocks are allocated in the file.  Even
worse, if files in the directory are not deleted in hash order, no leaf
block will be completely empty until about 99% of the files have been
deleted - assume 24-byte filenames in 4096-byte blocks means up to 128
entries per block, typically 3/4 full, or 1/96 entries will be left in
each block before it becomes empty.

One option that was discussed in the past is to use the high 4 bits
of dx_entry->block (i.e. the opposite of dx_get_block()) to store the
"fullness" of each block (in 1/16th of a block, or 256-byte increments
for 4096-byte blocks) and try to merge entries into an adjacent block
if it becomes mostly empty (e.g. if the current block plus the neighbour
are below 50% full).  That allows removing blocks much earlier as the
directory shrinks, rather than waiting until each block is completely
empty.  A fullness of "0" would mean "unset", since we don't set it
yet, and once this feature is available there would never be a block
that is entirely empty.

> As of now, we only support non-indexed directories and indexed
> directories with no intermediate dx nodes. This technique can also be
> used to remove intermediate dx nodes. But it needs a little more
> interesting logic to make that happen since we don't store directory
> entry name in intermediate nodes.
>=20
> Ran kvm-xfstests smoke test-suite and verified that there are no
> failures. Also, verified that when all the files are deleted in a
> directory, directory shrinks to either 4k for non-indexed directories
> or 8k for indexed directories with 1 level.
>=20
> This patch is an improvement over previous patch that I sent out
> earlier this month. So, if this patch looks alright, then we can drop
> the other shrinking patch.
>=20

> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> ---
> This patch supersedes the other directory shrinking patch sent in Aug
> 2019 ("ext4: shrink directory when last block is empty").
>=20
> fs/ext4/namei.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 176 insertions(+)
>=20
>=20
>=20
> +static inline bool is_empty_dirent_block(struct inode *dir,
> +					 struct buffer_head *bh)
> +{
> +	struct ext4_dir_entry_2 *de =3D (struct ext4_dir_entry_2 =
*)bh->b_data;
> +	int	csum_size =3D 0;
> +
> +	if (ext4_has_metadata_csum(dir->i_sb))
> +		csum_size =3D sizeof(struct ext4_dir_entry_tail);
> +
> +	return ext4_rec_len_from_disk(de->rec_len, =
dir->i_sb->s_blocksize) =3D=3D
> +			dir->i_sb->s_blocksize - csum_size && de->inode =
=3D=3D 0;
> +}

This may not always detect empty directory blocks properly, because
ext4_generic_delete_entry() will only merge deleted entries with the
previous entry.  It at least appears possible that if entries are not
deleted in the proper order (e.g. in reverse of the order they are
listed in the directory) there may be multiple empty entries in a block,
and the above check will fail.

Instead, this checks should walk all entries in a block and return false
if any one of them has a non-zero de->inode.  In the common case there
may be only a single entry, or the first entry will be used, so it
should be fairly quick to decide that the block cannot be removed.

Another option is to change ext4_generic_delete_entry() to also try
to merge with the immediately following entry to ensure that an empty
block always has rec_len of the full blocksize.  However, I think this
is probably not a worthwhile effort since it would be better to support
removing blocks that are partly empty rather than entirely empty.

> @@ -2510,6 +2684,8 @@ static int ext4_delete_entry(handle_t *handle,
> 	if (unlikely(err))
> 		goto out;
>=20
> +	ext4_try_dir_shrink(handle, dir);
> +
> 	return 0;

I think it would be inefficient to try shrinking the directory after
_every_ directory entry is removed.  Instead, there should be some
way to determine here if ext4_generic_delete_entry() removed the last
entry from the directory block, and only shrink in that case.

Cheers, Andreas






--Apple-Mail=_0C4A5CBD-E6D7-4AD4-A1DF-E72829DB7298
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1jaSIACgkQcqXauRfM
H+CADBAApQ0nfqCcRzZ8Aaf7XQJkO6erU/GZmdGCUdXByVyMuwYsUstGEXhM0vRT
72iHl6lqg8HlJ9lZq+DchhRps6K3pES5H4pmYazwWogYmI/F1aGntizqMwPBvMhl
ZyLFlfyTzc9GWQxvARe625DX7XPDaiCT7Ul5L5lXMJyMdn4AXhJw2wSEAg8eqW8q
CIolld1Ifk0ACE2irFGXhaH2YRzC0gTdt8lbHUXCc6J7ZWOmjIYz9oXN0fHHeMvl
dAcnBouTsEVUyUMDkhKrw889hMm1xL1GEsweOLbRCdFZExGnXJOoQ93heoRTl+Q+
aoV87odYqxhb6JJic4P0uzGr/Y4vC1Buz7IbKVO1qd+7HvLK5MHEsJzOgQPp9exN
H7VZ4uNtb8JFfiwGGMRFDOvajv2BRwGHlGLaN3BBXLIUIQpDlgmzJjkDBSdaUSmW
xeXJtVGpCmZG7FCUw1v1B8anhXujXnInhsuixI6XIdgcxgc09YveLVPXVm8TANTi
6psQ32Ams7ztzamTwwvIyAgkaPVuS3iqJWVHH0gIm8jdgVXOkwZhZ9P+4FLBg4bs
0fNnRCteE0ryCCtVlbIef2kE+xIGEjgQSaB/Qo4KR7n6NNk57CDz4OoDTX8vVA6q
YfBkLCqPwQoxjDrLm1MP5oB+724e8gWPOzWVOxGi6sqnPs/irBY=
=AMXd
-----END PGP SIGNATURE-----

--Apple-Mail=_0C4A5CBD-E6D7-4AD4-A1DF-E72829DB7298--

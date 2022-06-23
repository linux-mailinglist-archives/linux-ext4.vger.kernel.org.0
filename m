Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76C5582B1
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jun 2022 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiFWRSt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jun 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiFWRQH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jun 2022 13:16:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8075A1E20
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 09:59:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s185so25004pgs.3
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XifvPJ1Nc5wTvQmDrogFTjXSsV1Ojqu7Q6fFg3uH/jA=;
        b=q5RLujA0+9fMCfJz0To45Dyw8wdHyT+Lrmd6CbOBoo5F5niFTUu3RojhrODDloj/O9
         lAFexXHVD/bbFaV+eOS5dVaNVZKHVmeKzotmYuCnNszhdWw7kymM23dPhucUFZ1DwZY+
         7wgrIjx2VQij/daNWnl5CpTeFyWgOgeSW25pxlSHpDVOoIafWLqmqJCk5XIC3NFDWVu6
         1d5kdTsRqak7MfSpywyfsa57JY4bwl9/K6EuU+HNmR7RJ4k7BzlEohGyKrzHD3VDowty
         F0Nik0ix6zRDaKzNqphwf31VPkWlluVk+4GHH1c/fIuiIayB6zCXgDU5rPhVeiQJy+ZM
         6m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XifvPJ1Nc5wTvQmDrogFTjXSsV1Ojqu7Q6fFg3uH/jA=;
        b=l2FH6gIxAjj9Ex0mPx+pzQjwP0Xci+Ar2e75BM1xHsVKU1lcuMBCQ43qEKfo+vk1ww
         ECDRZDHEKAv1mj31QBnxdG44d0nX5K4sYupanM15PLiFBD33hOu+To51jXfwIkHSVM8j
         q07J9ksNSYw1M+e9gvlncqavL7iZK0crew2gngOn4jH03aDfFSrMa4Y4dpwBk/Ql0cVO
         E4QeuazFWj0eflMX6qK6y2Q6ydYWQb+5a5VP2MZ7Luh3WLxPcBCrTpVy5nyH3Q6lXVR3
         fVGctpUezeBGoAQp9DBNzOw8505NwzJNfFqhd04QTKfn3S1k7Xb8mkl62NqDZjJFioRs
         +/bQ==
X-Gm-Message-State: AJIora8xBlsBQsDJRgwTyKNwoAdvmW19UufxRld5/ZdPDfJJixkseMvF
        4k9LWHmAaueA6plzWeAc/nBY4w==
X-Google-Smtp-Source: AGRyM1sKHaMpvSp24dsIDBTMJ+SrdeQgXQcqgVaERZydQQbSWxJBzUwZpHNuG6evgByf1xBZirwB/w==
X-Received: by 2002:a63:7443:0:b0:40c:5a6e:3acf with SMTP id e3-20020a637443000000b0040c5a6e3acfmr8198245pgn.557.1656003573024;
        Thu, 23 Jun 2022 09:59:33 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090331cb00b00161ac982b52sm36548ple.95.2022.06.23.09.59.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 09:59:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <508F1BF9-1F80-4F7D-92A3-D44F82533C61@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6A3DB49C-9404-4A67-B82D-AB7583D75DC8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -next] ext4: avoid remove directory when directory is
 corrupted
Date:   Thu, 23 Jun 2022 11:01:58 -0600
In-Reply-To: <20220622090223.682234-1-yebin10@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
References: <20220622090223.682234-1-yebin10@huawei.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6A3DB49C-9404-4A67-B82D-AB7583D75DC8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 22, 2022, at 3:02 AM, Ye Bin <yebin10@huawei.com> wrote:
>=20
> Now if check directoy entry is corrupted, ext4_empty_dir may return =
true
> then directory will be removed when file system mounted with =
"errors=3Dcontinue".
> In order not to make things worse just return false when directory is =
corrupted.

This will make corrupted directories undeletable, which might cause =
problems
for applications also (e.g. tar or rsync always hitting errors when =
walking
the tree) and the user may prefer to delete the directory and recreate =
it
rather than having a permanent error in the filesystem.

With your patch it would always return "false" if a directory block hits =
a
corrupted entry instead of checking the rest of the blocks in the =
directory.
Since e2fsck would put the entries from the broken block into =
lost+found,
it isn't clear that the full/empty decision should be made by the =
presence
of a corrupted leaf block either way.

Looking at the ext4_empty_dir() code, it looks like there are a few =
cases
where it might return "true" when the directory actually has entries in =
it,
but your patch doesn't address those.  IMHO, errors like the absence of =
"."
and ".." should *NOT* cause the directory to be marked "empty", but it =
should
continue checking blocks to see if there are valid entries.  However, =
Jan
added these checks in 64d4ce8923 ("ext4: fix ext4_empty_dir() for =
directories
with holes") to avoid looping forever when i_size is large and there are =
no
allocated blocks in the directory, so they shouldn't just be removed, =
but
they also do not fix the problem if i_size is corrupt but the first =
block of
the inode is valid.


It might make sense to change ext4_empty_dir() to iterate only leaf =
blocks
actually allocated in the inode, rather than walking the whole of i_size =
by
offset?  That would avoid the "spin forever on a huge sparse inode" =
problem
that was the original reason for the addition of "." and ".." checks, =
and
give a better determination of whether the directory is actually empty.

If there are only corrupt blocks or holes in the directory there is no =
reason
*not* to delete it, but if there *are* valid entries (even if "." or =
".." are
missing) then the directory should not be deletable, since e2fsck will =
repair
missing "." and ".." without clobbering the whole directory.

Cheers, Andreas


>=20
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
> fs/ext4/namei.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 47d0ca4c795b..bc503e3275db 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3066,11 +3066,8 @@ bool ext4_empty_dir(struct inode *inode)
> 		de =3D (struct ext4_dir_entry_2 *) (bh->b_data +
> 					(offset & (sb->s_blocksize - =
1)));
> 		if (ext4_check_dir_entry(inode, NULL, de, bh,
> -					 bh->b_data, bh->b_size, =
offset)) {
> -			offset =3D (offset | (sb->s_blocksize - 1)) + 1;
> -			continue;
> -		}
> -		if (le32_to_cpu(de->inode)) {
> +					 bh->b_data, bh->b_size, offset) =
||
> +		    le32_to_cpu(de->inode)) {
> 			brelse(bh);
> 			return false;
> 		}
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_6A3DB49C-9404-4A67-B82D-AB7583D75DC8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmK0nIYACgkQcqXauRfM
H+Am9A//aA6+GM1kAfrE+ORLq/lMSUhaZhFLww2JNaeHCEXH9yoYapEEvl5EQgVu
f5hsmNyB9dUoVV2tYuSBAlYt6WK4tVkXHv07+A6L965IKUsV6gjOKSutsG2sJQmR
ezT0GuTE9NHCLt7MVsxKYQQimq2ZaZVEu5NtyJS7qxZYSlEAjmoEBk5ojD/djvIr
R/TcadHwuszuEBhZPnmvQJoornL6VdHx1Ff/m3C6CMJ5bRVbduqJP+eH2U2iQIZT
j09jpXv3hmu8IORpGJ5OOTYhlOorI6StEHfzqN47xMwJiSBZ34l2u24iLGZq+LEm
3JA5R3AP0uCKBJA/o06A+/3K8mzYWn8I2bEOYz+KZnNoiW97eAlgUIRxb+L6Xs2U
V+Hy2RaX5HKzB74b68zTMjx29pwcledJ14XlQi36U9wG0dG19WarPp4mJI/+VplR
W6gkby5jKmyI1Byqt26Dgqgon+agGW7zD8pUJelO7of9+dnb/U4NXnr0DGkiuzy8
o/WEO78jmWrbJQZMMFU3u4AwYOetKpaAToRubhis1VDhQOHYuYAfYBdsSWJuxVgp
a1fshexRbvYdMr7DSo5G7DgClkndvQlIto8MGxCEKjnto9/fel5q2DVVt6v1S3Gk
tkI8JMR7KiAbyBGa6f56+zRWXQoFNZ/xvQfTu/mtWhfZAtNV6I0=
=uLHG
-----END PGP SIGNATURE-----

--Apple-Mail=_6A3DB49C-9404-4A67-B82D-AB7583D75DC8--

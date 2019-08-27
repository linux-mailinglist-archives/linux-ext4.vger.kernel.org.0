Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22E9F490
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfH0Uxx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 16:53:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35892 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0Uxx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Aug 2019 16:53:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so137951plr.3
        for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2019 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=eot/cOwUdnrZRMSFUFDdhefzpY/UFG2BqwtE11YrWC4=;
        b=PdHupIggASP2zKeIwGqxUN7t3C9Iyo6quUN8zTbI5WM4FHz/Q4ZKcoGLuaLKdGTXU7
         H0kLYzrCkvPmrUVSnGGablStjS+dczTkRZd728Frtz5ZoynJQshwqxTkejZ69NYtH+RV
         AA5Bp/MY00iEXXYDISaQq6V57bdMTECNPMBfPjc/0AAOkg7GhLKeuZORPYesE8GQjkAn
         pV8SciFAOIEtiIqK7lCn/Fa+aEe10ZzfVWPCAw6oMSRbhRLDV7puc0AMdqKNnqYZ/RdI
         uKWOwhlJs0v+V5ADenR52sc9qxWn3qnU+KB6pVmWQhyq+U2O5zzUNwJMn0BzJ2QEaqe3
         sBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=eot/cOwUdnrZRMSFUFDdhefzpY/UFG2BqwtE11YrWC4=;
        b=Nhd2KOCwhUjN+jzb+J76y29M+Bc87ScNI+caW47r3K7yKI2DJWIQUrxi1Q1Ig1Y7BJ
         MkWnUEwcXsWzfqIPr+ZT2NS7TK4OUifchKX5p80keypCCiONGbq/RF3m5YIJVuj7r8Io
         y8vWK/iv0ngmcomRGEoH/dxSy5s43YPIfdlCs2P0053nLtW/Ietp/SUXdPIQiTauelsl
         B/FopNFfr7jYEt+5ODNilBmd+z/U5m4OS2N7dq6MxUxrk2A6sGRJIrWoOYwhGYNQeSui
         rXEwKTCzNLh/G3duZ/nJdUrE3ANR/8I8jnaHNQsRayWfgM9dEZifxb6ggDRitktcID5j
         b3fA==
X-Gm-Message-State: APjAAAVrJ/JKIizfYv9TL432YxyHU3WpSdvDvFYxEn2WyX6MezJwHzZN
        OcuGQEsKdziUMruwn764AumvckEON2I4jQ==
X-Google-Smtp-Source: APXvYqyrej3EUuCdkoDjncUgwr1fZjlBVBajMHyfka+jX+yfR+i5ViHiWScihgbmqwqMi+Dbpn2p4g==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr931239plp.14.1566939232014;
        Tue, 27 Aug 2019 13:53:52 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h20sm200311pfq.156.2019.08.27.13.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:53:51 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <680C3979-C9CA-453C-A973-585E9B880263@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B4984FDB-E9D6-4330-93BF-28D6AC0DE705";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
Date:   Tue, 27 Aug 2019 14:53:48 -0600
In-Reply-To: <CAD+ocbzT=A4LW7CYBC_mxh2cf3ZxUhvffhtpO0LnfkXAJDy0Kw@mail.gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
 <7303B125-6C0E-41C2-A71E-4AF8C9776468@dilger.ca>
 <CAD+ocbzT=A4LW7CYBC_mxh2cf3ZxUhvffhtpO0LnfkXAJDy0Kw@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B4984FDB-E9D6-4330-93BF-28D6AC0DE705
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 26, 2019, at 3:46 PM, harshad shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> I see, this is an interesting approach. I think we can do this without
> modifying on-disk format and by bearing the cost of 2 extra reads per
> merge. Whenever dentry deletion results in a dirent block that is
> _sufficiently_ empty, we can look at its parent dx block and and find
> its neighbors that can be merged. We can be aggressive and do this for
> every dentry deletion or we could do this whenever the current dirent
> block is half empty or something.

The point of storing the "leaf block fullness" into the high bits of
dx_entry->block is that this information would always be available
during htree traversal, even if the leaf blocks are not in memory.
That would allow the unlink code to make a decision in advance whether
shrinking is going to happen (e.g. leaf block plus one neighbour are
under 50% full).

The overhead would be to keep the "leaf block fullness" value updated
enough to be useful.  In this regard, a lower-resolution field (maybe
1 or 2 bits is enough, representing { unset, <=3D 25% full }, or { =
unset,
<=3D 20% full, <=3D 40% full, > 40% full }.  Anything above this =
threshold
isn't interesting to consider merging, so there is no need to track it.

> By this method we end up reading up to 2 extra blocks (one previous
> and one next) that are not going to be merged. That's the trade-off we
> have to make in order to avoid any changes to on-disk structure (If we
> modify the on-disk structure and store the fullness in the dx block,
> we would read only the blocks that need to be merged).

Right.  As Ted wrote, we could do the shrinking optimistically if the
dx_entry field is "unset", but the blocks are in memory.  However, in
when the leaf block is first read into memory, we could also update the
dx_entry fullness when it is sanity checked, so that we don't need to
keep checking whether the leaf block is empty or not.  The dx_entry
update could be done only in memory and written opportunistically to
disk if the htree index block is modified.  At worst, if the dx_entry
fullness is incorrect the merge could fail and the block is not freed.

> The same logic can also be applied to intermediate dx nodes as well.
> After every merge operation, we'll have a set of blocks that need to
> be freed. Once we know what blocks we can free, we can use Ted's idea
> of swapping them with the last block, one by one.
>=20
> Since merging approach also requires a way to free up directory
> blocks, I think we could first get a patch in that can free up
> directory blocks by swapping with the last block. Once we have that
> then we could implement merging.

Yes, definitely.  I'm not suggesting that we don't need the ability
to free leaf/index blocks first.  I just wanted to point out that we
will not see any blocks being freed until the directory is almost
completely (99%) empty.  For testing purposes you could use 1KB blocks
and 250-character names (which means at most 3 entries per block), and
we would start seeing blocks being freed once the directory was below
about 30% full, but this does not represent a common use case.

Cheers, Andreas

> On Sun, Aug 25, 2019 at 10:07 PM Andreas Dilger <adilger@dilger.ca> =
wrote:
>>=20
>> On Aug 21, 2019, at 12:27 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>>>=20
>>> On every dentry deletion, this patch traverses directory inode in
>>> reverse direction and frees up empty dirent blocks until it finds a
>>> non-empty dirent block. We leverage the fact that we never clear
>>> dentry name when we delete dentrys by merging them with the previous
>>> one. So, even though the dirent block has only fake dentry which =
spans
>>> across the entire block, we can use the name in this dead entry to
>>> perform dx lookup and find intermediate dx node blocks as well as
>>> offset inside these blocks.
>>=20
>>=20
>> One high-level limitation with this implementation is that it is =
unlikely
>> to remove any directory blocks until the directory is almost entirely
>> empty since "rm -r" will return entries in hash order, which does not
>> match the order that the leaf blocks are allocated in the file.  Even
>> worse, if files in the directory are not deleted in hash order, no =
leaf
>> block will be completely empty until about 99% of the files have been
>> deleted - assume 24-byte filenames in 4096-byte blocks means up to =
128
>> entries per block, typically 3/4 full, or 1/96 entries will be left =
in
>> each block before it becomes empty.
>>=20
>> One option that was discussed in the past is to use the high 4 bits
>> of dx_entry->block (i.e. the opposite of dx_get_block()) to store the
>> "fullness" of each block (in 1/16th of a block, or 256-byte =
increments
>> for 4096-byte blocks) and try to merge entries into an adjacent block
>> if it becomes mostly empty (e.g. if the current block plus the =
neighbour
>> are below 50% full).  That allows removing blocks much earlier as the
>> directory shrinks, rather than waiting until each block is completely
>> empty.  A fullness of "0" would mean "unset", since we don't set it
>> yet, and once this feature is available there would never be a block
>> that is entirely empty.
>>=20
>>> As of now, we only support non-indexed directories and indexed
>>> directories with no intermediate dx nodes. This technique can also =
be
>>> used to remove intermediate dx nodes. But it needs a little more
>>> interesting logic to make that happen since we don't store directory
>>> entry name in intermediate nodes.
>>>=20
>>> Ran kvm-xfstests smoke test-suite and verified that there are no
>>> failures. Also, verified that when all the files are deleted in a
>>> directory, directory shrinks to either 4k for non-indexed =
directories
>>> or 8k for indexed directories with 1 level.
>>>=20
>>> This patch is an improvement over previous patch that I sent out
>>> earlier this month. So, if this patch looks alright, then we can =
drop
>>> the other shrinking patch.
>>>=20
>>=20
>>> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>>>=20
>>> ---
>>> This patch supersedes the other directory shrinking patch sent in =
Aug
>>> 2019 ("ext4: shrink directory when last block is empty").
>>>=20
>>> fs/ext4/namei.c | 176 =
++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 file changed, 176 insertions(+)
>>>=20
>>>=20
>>>=20
>>> +static inline bool is_empty_dirent_block(struct inode *dir,
>>> +                                      struct buffer_head *bh)
>>> +{
>>> +     struct ext4_dir_entry_2 *de =3D (struct ext4_dir_entry_2 =
*)bh->b_data;
>>> +     int     csum_size =3D 0;
>>> +
>>> +     if (ext4_has_metadata_csum(dir->i_sb))
>>> +             csum_size =3D sizeof(struct ext4_dir_entry_tail);
>>> +
>>> +     return ext4_rec_len_from_disk(de->rec_len, =
dir->i_sb->s_blocksize) =3D=3D
>>> +                     dir->i_sb->s_blocksize - csum_size && =
de->inode =3D=3D 0;
>>> +}
>>=20
>> This may not always detect empty directory blocks properly, because
>> ext4_generic_delete_entry() will only merge deleted entries with the
>> previous entry.  It at least appears possible that if entries are not
>> deleted in the proper order (e.g. in reverse of the order they are
>> listed in the directory) there may be multiple empty entries in a =
block,
>> and the above check will fail.
>>=20
>> Instead, this checks should walk all entries in a block and return =
false
>> if any one of them has a non-zero de->inode.  In the common case =
there
>> may be only a single entry, or the first entry will be used, so it
>> should be fairly quick to decide that the block cannot be removed.
>>=20
>> Another option is to change ext4_generic_delete_entry() to also try
>> to merge with the immediately following entry to ensure that an empty
>> block always has rec_len of the full blocksize.  However, I think =
this
>> is probably not a worthwhile effort since it would be better to =
support
>> removing blocks that are partly empty rather than entirely empty.
>>=20
>>> @@ -2510,6 +2684,8 @@ static int ext4_delete_entry(handle_t *handle,
>>>      if (unlikely(err))
>>>              goto out;
>>>=20
>>> +     ext4_try_dir_shrink(handle, dir);
>>> +
>>>      return 0;
>>=20
>> I think it would be inefficient to try shrinking the directory after
>> _every_ directory entry is removed.  Instead, there should be some
>> way to determine here if ext4_generic_delete_entry() removed the last
>> entry from the directory block, and only shrink in that case.
>>=20
>> Cheers, Andreas
>>=20
>>=20
>>=20
>>=20
>>=20


Cheers, Andreas






--Apple-Mail=_B4984FDB-E9D6-4330-93BF-28D6AC0DE705
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1lmF0ACgkQcqXauRfM
H+BmnA//YPUUuq3j8IKilsRH0EF1lEGTEWFa3Gu4cLrFbVgLoxExSDeX64SGZY9u
vCzVrbwvACdjec2we9QFVXeWWTy7ZZgQE86KKwgwuEP/tyg/WgjuLL9XnFfv/2uq
QKrh/vB0XgFHGQFDZ/Fkc2acvU+s6T8tCL/nWjk/W5v1iKuyW5jEhwnFav5I/ru3
p3/lsjPu45oTYpyhfCupH7JAmpFFlwGB/5oZ9SuytNjErmkkTi6QNWZi51V1pi+l
7RhLoXBqtwgmN5rg4Wi94S084LYSYKSjyC4npRsLP77raJyJiPPwCGeZSEWqAkYx
eUNJjVwbjt2BcK6VXGclsFFAFBdo4BdMsM1PNM1iOmlpkgL6SNkjYPwFKIRsWmJ5
cqLUeYlkm7k5gnBPBpd9HO4FzdKQTwAOzbjbSbtk2iExzhNLCrl1ly+4NELqIVaO
Gkm8inq6Kq7RqVMJz3yqDRjNFgj5VKWJzjntdjgd2SwhBL4Lg2zf46X0ClnXC0XY
+XFizKoG5h6HMVOkyN8SlfoLv2rcKIDYXa+kglj9/ItnJ8AJ7xKypEfZavyyPIB9
Kt8FEmCVNc5MtXq5PGWgYNsjsPZeBj0cUayM6QoLYyW93zfgrdKahTC5/fX8stWJ
ihMqZjFPsr8zLTvm47Nocbz2gYy2AIq/47MouWZT6kCoklKP8Hs=
=3S1e
-----END PGP SIGNATURE-----

--Apple-Mail=_B4984FDB-E9D6-4330-93BF-28D6AC0DE705--

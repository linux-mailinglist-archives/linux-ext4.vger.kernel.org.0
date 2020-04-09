Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4541A3C32
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Apr 2020 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDIWBo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Apr 2020 18:01:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38151 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDIWBo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Apr 2020 18:01:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id c21so163223pfo.5
        for <linux-ext4@vger.kernel.org>; Thu, 09 Apr 2020 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2X1pIr2XTqbSDVLRNjtDXEcARl32FgN3mKHtYuK4vv8=;
        b=b+8s+SMkwN2CeQoFTRp5JvnVApXsnr4jvHQ/oNZB9aGhNuq/0Qn53VFZqrBk8SCVSL
         XSqVm16gkrK+GSKPyVvv7NqYvjYPzMFjPs8xSX2VGECHLBqyPJp1hg6C5yzG8IVcaSjU
         Zaj/Jk9lwgQExRNAnbKbmMMjj+UeDcB1ZVmdJ27LGQx+KbAeVTkMzZ042RjIg/+PJssX
         ITtV6QI7yYMGDbZtnmELiF5FzECNmMzChXGumDLgGfZ//Bh3qq3Q82FRO1SridqvTSn/
         Us8ceyLktKh/i3IT0w6jTMeqSpWkGBuIOclCp7YR7X4D2Vsr+Mq37B3jPq3HVdZcmYwC
         s7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2X1pIr2XTqbSDVLRNjtDXEcARl32FgN3mKHtYuK4vv8=;
        b=eKqsxiNOST/cHCdPvvUQxMaHRjFSEuDOUml+uiMtbf4enVSTep5HaBbuWd7bqKOIo5
         E0ygY8gjt6QPBum9MphjJWshx7wExobWfuQ5JahkCGYr6gzbfU/9zFEFfotu+BxwKvYU
         gOpN/ow/LhRg4jytdVBh0vkIaXlqFvJG18tjb1pYyu95WiGC66yogSxm8wwYbeFuYsZn
         bEKJK2BO1wf6GhnPsWT/P4G0/QlNtC9SRlgrmEE2CPUiRC5HJrI13zAOqH231QfdP6BM
         Lao4sBQfTJMz+eyuoFS5aZcDFNsW0Yuac39kf2ZHGCDu/1RKFC5TQ8YTO2q+mMD/5X8A
         VV/Q==
X-Gm-Message-State: AGi0PuZI/lpHiSOdmldsatzZ5k+U1kb87vxApr7egRBxzBNuYpRJ/42A
        S/3LrtOQY97fLnuUZtvY3MzaS0yPgaQ=
X-Google-Smtp-Source: APiQypL1Jh30SUj0dT3cJc/lfTcppzc6CQ5nT7fSpZRZX0OqeJJ2MSO+8l9Zrj9iAmFlsFej494yqw==
X-Received: by 2002:a65:4504:: with SMTP id n4mr1572987pgq.374.1586469702985;
        Thu, 09 Apr 2020 15:01:42 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id t188sm77325pfb.102.2020.04.09.15.01.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 15:01:42 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <CD498493-5353-4518-9D7E-529861159011@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C94A0C6B-AC34-4EB9-8705-871D61FC3BE1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6 01/20] ext4: update docs for fast commit feature
Date:   Thu, 9 Apr 2020 16:01:39 -0600
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200408215530.25649-1-harshads@google.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C94A0C6B-AC34-4EB9-8705-871D61FC3BE1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 8, 2020, at 3:55 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> This patch series adds support for fast commits which is a simplified
> version of the scheme proposed by Park and Shin, in their paper,
> "iJournaling: Fine-Grained Journaling for Improving the Latency of
> Fsync System Call"[1]. The basic idea of fast commits is to make JBD2
> give the client file system an opportunity to perform a faster
> commit. Only if the file system cannot perform such a commit
> operation, then JBD2 should fall back to traditional commits.
>=20
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

It's not clear if all of this was intended to be in a 00/20 email,
but having it (probably minus full diffstat) in Git is OK as well.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> Documentation/filesystems/ext4/journal.rst | 127 ++++++++++++++++++++-
> Documentation/filesystems/journalling.rst  |  18 +++
> 2 files changed, 139 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/filesystems/ext4/journal.rst =
b/Documentation/filesystems/ext4/journal.rst
> index ea613ee701f5..f94e66f2f8c4 100644
> --- a/Documentation/filesystems/ext4/journal.rst
> +++ b/Documentation/filesystems/ext4/journal.rst
> @@ -29,10 +29,10 @@ safest. If ``data=3Dwriteback``, dirty data blocks =
are not flushed to the
> disk before the metadata are written to disk through the journal.
>=20
> The journal inode is typically inode 8. The first 68 bytes of the
> -journal inode are replicated in the ext4 superblock. The journal =
itself
> -is normal (but hidden) file within the filesystem. The file usually
> -consumes an entire block group, though mke2fs tries to put it in the
> -middle of the disk.
> +journal inode are replicated in the ext4 superblock. The journal
> +itself is normal (but hidden) file within the filesystem. The file
> +usually consumes an entire block group, though mke2fs tries to put it
> +in the middle of the disk.
>=20
> All fields in jbd2 are written to disk in big-endian order. This is =
the
> opposite of ext4.
> @@ -42,22 +42,74 @@ NOTE: Both ext4 and ocfs2 use jbd2.
> The maximum size of a journal embedded in an ext4 filesystem is 2^32
> blocks. jbd2 itself does not seem to care.
>=20
> +Fast Commits
> +~~~~~~~~~~~~
> +
> +Ext4 also implements fast commits and integrates it with JBD2 =
journalling.
> +Fast commits store metadata changes made to the file system as inode =
level
> +diff. In other words, each fast commit block identifies updates made =
to
> +a particular inode and collectively they represent total changes made =
to
> +the file system.
> +
> +A fast commit is valid only if there is no full commit after that =
particular
> +fast commit. Because of this feature, fast commit blocks can be =
reused by
> +the following transactions.
> +
> +Each fast commit block stores updates to 1 particular inode. Updates =
in each
> +fast commit block are one of the 2 types:
> +- Data updates (add range / delete range)
> +- Directory entry updates (Add / remove links)
> +
> +Fast commit blocks must be replayed in the order in which they appear =
on disk.
> +That's because directory entry updates are written in fast commit =
blocks
> +in the order in which they are applied on the file system before =
crash.
> +Changing the order of replaying for directory entry updates may =
result
> +in inconsistent file system. Note that only directory entry updates =
need
> +ordering, data updates, since they apply to only one inode, do not =
require
> +ordered replay. Also, fast commits guarantee that file system is in =
consistent
> +state after replay of each fast commit block as long as order of =
replay has
> +been followed.
> +
> +Note that directory inode updates are never directly recorded in fast =
commits.
> +Just like other file system level metaata, updates to directories are =
always
> +implied based on directory entry updates stored in fast commit =
blocks.
> +
> +Based on which directory entry updates are committed with an inode, =
fast
> +commits have two modes of operation:
> +
> +- Hard Consistency (default)
> +- Soft Consistency (can be enabled by setting mount flag =
"fc_soft_consistency")
> +
> +When hard consistency is enabled, fast commit guarantees that all the =
updates
> +will be committed. After a successful replay of fast commits blocks
> +in hard consistency mode, the entire file system would be in the same =
state as
> +that when fsync() returned before crash. This guarantee is similar to =
what
> +jbd2 gives.
> +
> +With soft consistency, file system only guarantees consistency for =
the
> +inode in question. In this mode, file system will try to write as =
less data
> +to the backed as possible during the commit time. To be precise, file =
system
> +records all the data updates for the inode in question and directory =
updates
> +that are required for guaranteeing consistency of the inode in =
question.
> +
> Layout
> ~~~~~~
>=20
> Generally speaking, the journal has this format:
>=20
> .. list-table::
> -   :widths: 16 48 16
> +   :widths: 16 48 16 18
>    :header-rows: 1
>=20
>    * - Superblock
>      - descriptor\_block (data\_blocks or revocation\_block) [more =
data or
>        revocations] commmit\_block
>      - [more transactions...]
> +     - [Fast commits...]
>    * -
>      - One transaction
>      -
> +     -
>=20
> Notice that a transaction begins with either a descriptor and some =
data,
> or a block revocation list. A finished transaction always ends with a
> @@ -76,7 +128,7 @@ The journal superblock will be in the next full =
block after the
> superblock.
>=20
> .. list-table::
> -   :widths: 12 12 12 32 12
> +   :widths: 12 12 12 32 12 12
>    :header-rows: 1
>=20
>    * - 1024 bytes of padding
> @@ -85,11 +137,13 @@ superblock.
>      - descriptor\_block (data\_blocks or revocation\_block) [more =
data or
>        revocations] commmit\_block
>      - [more transactions...]
> +     - [Fast commits...]
>    * -
>      -
>      -
>      - One transaction
>      -
> +     -
>=20
> Block Header
> ~~~~~~~~~~~~
> @@ -609,3 +663,64 @@ bytes long (but uses a full block):
>      - h\_commit\_nsec
>      - Nanoseconds component of the above timestamp.
>=20
> +Fast Commit Block
> +~~~~~~~~~~~~~~~~~
> +
> +The fast commit block indicates an append to the last commit block
> +that was written to the journal. One fast commit block records =
updates
> +to one inode. So, typically you would find as many fast commit blocks
> +as the number of inodes that got changed since the last commit. A =
fast
> +commit block is valid only if there is no commit block present with
> +transaction ID greater than that of the fast commit block. If such a
> +block a present, then there is no need to replay the fast commit
> +block.
> +
> +.. list-table::
> +   :widths: 8 8 24 40
> +   :header-rows: 1
> +
> +   * - Offset
> +     - Type
> +     - Name
> +     - Descriptor
> +   * - 0x0
> +     - journal\_header\_s
> +     - (open coded)
> +     - Common block header.
> +   * - 0xC
> +     - \_\_le32
> +     - fc\_magic
> +     - Magic value which should be set to 0xE2540090. This identifies
> +       that this block is a fast commit block.
> +   * - 0x10
> +     - \_\_u8
> +     - fc\_features
> +     - Features used by this fast commit block.
> +   * - 0x11
> +     - \_\_le16
> +     - fc_num_tlvs
> +     - Number of TLVs contained in this fast commit block
> +   * - 0x13
> +     - \_\_le32
> +     - \_\_fc\_len
> +     - Length of the fast commit block in terms of number of blocks
> +   * - 0x17
> +     - \_\_le32
> +     - fc\_ino
> +     - Inode number of the inode that will be recovered using this =
fast commit
> +   * - 0x2B
> +     - struct ext4\_inode
> +     - inode
> +     - On-disk copy of the inode at the commit time
> +   * - <Variable based on inode size>
> +     - struct ext4\_fc\_tl
> +     - Array of struct ext4\_fc\_tl
> +     - The actual delta with the last commit. Starting at this =
offset,
> +       there is an array of TLVs that indicates which all extents
> +       should be present in the corresponding inode. Currently,
> +       following tags are supported: EXT4\_FC\_TAG\_EXT (extent that
> +       should be present in the inode), EXT4\_FC\_TAG\_HOLE (extent
> +       that should be removed from the inode), =
EXT4\_FC\_TAG\_ADD\_DENTRY
> +       (dentry that should be linked), EXT4\_FC\_TAG\_DEL\_DENTRY
> +       (dentry that should be unlinked), =
EXT4\_FC\_TAG\_CREATE\_DENTRY
> +       (dentry that for the file that should be created for the first =
time).
> diff --git a/Documentation/filesystems/journalling.rst =
b/Documentation/filesystems/journalling.rst
> index 58ce6b395206..1cb116ab27ab 100644
> --- a/Documentation/filesystems/journalling.rst
> +++ b/Documentation/filesystems/journalling.rst
> @@ -115,6 +115,24 @@ called after each transaction commit. You can =
also use
> ``transaction->t_private_list`` for attaching entries to a transaction
> that need processing when the transaction commits.
>=20
> +JBD2 also allows client file systems to implement file system =
specific
> +commits which are called as ``fast commits``. Fast commits are
> +asynchronous in nature i.e. file systems can call their own commit
> +functions at any time. In order to avoid the race with kjournald
> +thread and other possible fast commits that may be happening in
> +parallel, file systems should first call
> +:c:func:`jbd2_start_async_fc()`. File system can call
> +:c:func:`jbd2_map_fc_buf()` to get buffers reserved for fast
> +commits. Once a fast commit is completed, file system should call
> +:c:func:`jbd2_stop_async_fc()` to indicate and unblock other
> +committers and the kjournald thread.  After performing either a fast
> +or a full commit, JBD2 calls ``journal->j_fc_cleanup_cb`` to allow
> +file systems to perform cleanups for their internal fast commit
> +related data structures. At the replay time, JBD2 passes each and
> +every fast commit block to the file system via
> +``journal->j_fc_replay_cb``. Ext4 effectively uses this fast commit
> +mechanism to improve journal commit performance.
> +
> JBD2 also provides a way to block all transaction updates via
> :c:func:`jbd2_journal_lock_updates()` /
> :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants =
a
> --
> 2.26.0.110.g2183baf09c-goog
>=20


Cheers, Andreas






--Apple-Mail=_C94A0C6B-AC34-4EB9-8705-871D61FC3BE1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6Pm0MACgkQcqXauRfM
H+ByWxAAtvYepAOB6staWMZ82Xw5rUx8H0teueoqpfniba6WArLjPGi21g+yRDx/
BiJKZcUX2wy7tMSgrodUT/VDYDKWvvkH3elS6OMDNiL/sALl2qH1vkfW2sUtGk6E
Vq01YtAReVUsugGSzy3yj9o8/mQskCHifCLltpvq/mnC2MXgUOION92ydieSHzI2
kLY2W27gVy7kpA0emQS2unGxMOlYj5yHkQT6ATRVCcBev3MkwwnIUHM6ro8dHzu/
VnlvwVCthmk+NdciF3mAZB/oGW378RY7AZLQ+t7eecV9WdL1c9swdioV/wq7RH2J
xAfwrX3FfPxbpBBrjjWLwiazIZBUT4hsVekV53DdU9eiTYPM66Syc7+DLF01JaXv
LuI3dKv0rkjtBDGTYghcU3zALem2ddlrGIeAFfHA/fJMG09gK2Plce+xeyNQMbPL
bIIlYSOHCUJiDOqKJpAOapGy08cy1SoOrj3YipXNMJ2Gf96eKPnV+sZYtzmR04MH
OVDVb7QthziBS0qqfUlY+hCFlzbYWAGtth/wonASX0du4FkXFPSeveWjiRfjnpN4
CVJi8yaWu2B+gwlnc1h/HQ7RS6qYX5RCQKSddB9NrUsTSnzjNJw48JcZ5cQ/t1gs
S3HpHc4taAjE1dRUvG2x0ozmakXDQAEkSCoxMLpmpF48KWNmMj0=
=s9nh
-----END PGP SIGNATURE-----

--Apple-Mail=_C94A0C6B-AC34-4EB9-8705-871D61FC3BE1--

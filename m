Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B403E15112B
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2020 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBCUlw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Feb 2020 15:41:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35767 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgBCUlw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Feb 2020 15:41:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so6316332plt.2
        for <linux-ext4@vger.kernel.org>; Mon, 03 Feb 2020 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vxI+2RntT5gDsGiLabZ+KLYzRXng4puLyj4Aj9MBLNs=;
        b=178KK+VjOBbGWUFtpeNU0Bvby7NXsjdhlGxscCaQKCHiK0nVMWJFgw3Plak9cNP1Ad
         R7w7HhzjaFHYNr0gzGWN/83doSWAufed1P+UxxU0liSbA/KXe6OzKs4NZ1s1dNcOB+9d
         HG+84NeY71FJ4riIzsU49ueSKYuKt3PjY6CCa9xjyYjWoUFQahAOmAYKKGW4i5lqr+lg
         mqRzueZzyemCSi9Z0qmO477xlUGge+jys94dwioFJ52duRnddYlS214TwiOYcdySfzW5
         KrkXmLSSGSBzvWs9CYVsuVb4eGQ6JW4iMSdID4c9LoS+3OtI2jAWNgvNszSU+6xh5igj
         UkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vxI+2RntT5gDsGiLabZ+KLYzRXng4puLyj4Aj9MBLNs=;
        b=iC4wmciBfeZPDRGaAA6Vlk426ektI1wzESfypALocjegV9cmXdiBjUfyRby+jRRnSU
         3yWjxYLfwtZXbunxG61DH3luc9zClyzjD0eaEI3CQWf2H7Aw7QJ+XZE3Q9c5GyHxippe
         XYKbdavsk3gT11Jp7mZM+f98TY5SOYnSrh4OXlmhGT47xY7UyJCIu26IH80eo6VVy2Iu
         FogDvVj44Dks8A1FywNOP0elioHbzJgf2/wlopZEWASv5RBQBKDcnT3WGlCATLlSurv9
         6E/uMlu6lHyqPHIxSDHLJfIES8yGN9Zz+8weR5Rj/SAkf+pbqiaQ7VJYAgvB8Lwoq7OQ
         ZMJg==
X-Gm-Message-State: APjAAAUqEFVA5QdiOTrgRj9S7JZNAeyWCzscBMcrih1jgKbTTfpJl/ip
        L1mB73qAJGlqaAgEwAbcsL4+Pw==
X-Google-Smtp-Source: APXvYqwWN/aN6c8rPj6KkLyxJewLsjuuadMmOuOk3l9Zdw85hP8OLPUaM5E21LcWC3B75EPXIQ9ilQ==
X-Received: by 2002:a17:902:6a8c:: with SMTP id n12mr20688649plk.191.1580762509684;
        Mon, 03 Feb 2020 12:41:49 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h26sm22682942pfr.9.2020.02.03.12.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 12:41:48 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D6C97BDC-9378-4BCD-A073-2B5527204306@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_48041C20-5C64-4E2D-A012-FA0009E2C133";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] chattr.1: improve attribute formatting with labels and
 indented paragraphs
Date:   Mon, 3 Feb 2020 13:41:42 -0700
In-Reply-To: <20200203023741.218441-1-jeremyvisser@google.com>
Cc:     linux-ext4@vger.kernel.org
To:     Jeremy Visser <jeremyvisser@google.com>
References: <20200203023741.218441-1-jeremyvisser@google.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_48041C20-5C64-4E2D-A012-FA0009E2C133
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 2, 2020, at 7:37 PM, Jeremy Visser <jeremyvisser@google.com> =
wrote:
>=20
> By convention, lists of options in man pages use a label followed by =
an
> indented description, such as this example from the Options section:
>=20
>     -R     Recursively change attributes of directories and
>            their contents.
>=20
> But the Attributes section places the available attributes =
mid-sentence,
> which makes it visually more difficult to parse:
>=20
>     A file with the 'a' attribute set can only be opened
>     in append mode for writing.  [...]
>=20
>     When a file with the 'A' attribute set is accessed, its
>     atime record is not modified.  [...]
>=20
> This patch places a label beside each attribute description, which (in
> my opinion) improves readability, especially when visually skimming =
the
> list.  For example:
>=20
>     a      A file with the 'a' attribute set can only be
>            opened in append mode for writing.
>=20
>     A      When a file with the 'A' attribute set is accessed,
>            its atime record is not modified.
>=20
> Signed-off-by: Jeremy Visser <jeremyvisser@google.com>

Looks like a good improvement.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/chattr.1.in | 59 ++++++++++++++++++++++++++++++++----------------
> 1 file changed, 40 insertions(+), 19 deletions(-)
>=20
> diff --git a/misc/chattr.1.in b/misc/chattr.1.in
> index 66e791db..71e910c9 100644
> --- a/misc/chattr.1.in
> +++ b/misc/chattr.1.in
> @@ -79,20 +79,25 @@ Set the file's version/generation number.
> .BI \-p " project"
> Set the file's project number.
> .SH ATTRIBUTES
> +.TP
> +.B a
> A file with the 'a' attribute set can only be opened in append mode =
for
> writing.  Only the superuser or a process possessing the
> CAP_LINUX_IMMUTABLE capability can set or clear this attribute.
> -.PP
> +.TP
> +.B A
> When a file with the 'A' attribute set is accessed, its atime record =
is
> not modified.  This avoids a certain amount of disk I/O for laptop
> systems.
> -.PP
> +.TP
> +.B c
> A file with the 'c' attribute set is automatically compressed on the =
disk
> by the kernel.  A read from this file returns uncompressed data.  A =
write to
> this file compresses data before storing them on the disk.  Note: =
please
> make sure to read the bugs and limitations section at the end of this
> document.
> -.PP
> +.TP
> +.B C
> A file with the 'C' attribute set will not be subject to copy-on-write
> updates.  This flag is only supported on file systems which perform
> copy-on-write.  (Note: For btrfs, the 'C' flag should be
> @@ -101,42 +106,50 @@ data blocks, it is undefined when the blocks =
assigned to the file will
> be fully stable.  If the 'C' flag is set on a directory, it will have =
no
> effect on the directory, but new files created in that directory will
> have the No_COW attribute set.)
> -.PP
> +.TP
> +.B d
> A file with the 'd' attribute set is not a candidate for backup when =
the
> .BR dump (8)
> program is run.
> -.PP
> +.TP
> +.B D
> When a directory with the 'D' attribute set is modified,
> the changes are written synchronously to the disk; this is equivalent =
to
> the 'dirsync' mount option applied to a subset of the files.
> -.PP
> +.TP
> +.B e
> The 'e' attribute indicates that the file is using extents for mapping
> the blocks on disk.  It may not be removed using
> .BR chattr (1).
> -.PP
> +.TP
> +.B E
> A file, directory, or symlink with the 'E' attribute set is encrypted =
by the
> filesystem.  This attribute may not be set or cleared using
> .BR chattr (1),
> although it can be displayed by
> .BR lsattr (1).
> -.PP
> +.TP
> +.B F
> A directory with the 'F' attribute set indicates that all the path
> lookups inside that directory are made in a case-insensitive fashion.
> This attribute can only be changed in empty directories on file =
systems
> with the casefold feature enabled.
> -.PP
> +.TP
> +.B i
> A file with the 'i' attribute cannot be modified: it cannot be deleted =
or
> renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write =
mode.
> Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE
> capability can set or clear this attribute.
> -.PP
> +.TP
> +.B I
> The 'I' attribute is used by the htree code to indicate that a =
directory
> is being indexed using hashed trees.  It may not be set or cleared =
using
> .BR chattr (1),
> although it can be displayed by
> .BR lsattr (1).
> -.PP
> +.TP
> +.B j
> A file with the 'j' attribute has all of its data written to the ext3 =
or
> ext4 journal before being written to the file itself, if the file =
system
> is mounted with the "data=3Dordered" or "data=3Dwriteback" options and =
the
> @@ -144,14 +157,16 @@ file system has a journal.  When the filesystem =
is mounted with the
> "data=3Djournal" option all file data is already journalled and this
> attribute has no effect.  Only the superuser or a process possessing =
the
> CAP_SYS_RESOURCE capability can set or clear this attribute.
> -.PP
> +.TP
> +.B N
> A file with the 'N' attribute set indicates that the file has data
> stored inline, within the inode itself. It may not be set or cleared
> using
> .BR chattr (1),
> although it can be displayed by
> .BR lsattr (1).
> -.PP
> +.TP
> +.B P
> A directory with the 'P' attribute set will enforce a hierarchical
> structure for project id's.  This means that files and directory =
created
> in the directory will inherit the project id of the directory, rename
> @@ -159,22 +174,26 @@ operations are constrained so when a file or =
directory is moved into
> another directory, that the project id's much match.  In addition, a
> hard link to file can only be created when the project id for the file
> and the destination directory match.
> -.PP
> +.TP
> +.B s
> When a file with the 's' attribute set is deleted, its blocks are =
zeroed
> and written back to the disk.  Note: please make sure to read the bugs
> and limitations section at the end of this document.
> -.PP
> +.TP
> +.B S
> When a file with the 'S' attribute set is modified,
> the changes are written synchronously to the disk; this is equivalent =
to
> the 'sync' mount option applied to a subset of the files.
> -.PP
> +.TP
> +.B t
> A file with the 't' attribute will not have a partial block fragment =
at
> the end of the file merged with other files (for those filesystems =
which
> support tail-merging).  This is necessary for applications such as =
LILO
> which read the filesystem directly, and which don't understand =
tail-merged
> files.  Note: As of this writing, the ext2, ext3, and ext4 filesystems =
do
> not support tail-merging.
> -.PP
> +.TP
> +.B T
> A directory with the 'T' attribute will be deemed to be the top of
> directory hierarchies for the purposes of the Orlov block allocator.
> This is a hint to the block allocator used by ext3 and ext4 that the
> @@ -184,12 +203,14 @@ idea to set the 'T' attribute on the /home =
directory, so that /home/john
> and /home/mary are placed into separate block groups.  For directories
> where this attribute is not set, the Orlov block allocator will try to
> group subdirectories closer together where possible.
> -.PP
> +.TP
> +.B u
> When a file with the 'u' attribute set is deleted, its contents are
> saved.  This allows the user to ask for its undeletion.  Note: please
> make sure to read the bugs and limitations section at the end of this
> document.
> -.PP
> +.TP
> +.B V
> A file with the 'V' attribute set has fs-verity enabled.  It cannot be
> written to, and the filesystem will automatically verify all data read
> from it against a cryptographic hash that covers the entire file's
> --
> 2.25.0.341.g760bfbb309-goog
>=20


Cheers, Andreas






--Apple-Mail=_48041C20-5C64-4E2D-A012-FA0009E2C133
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl44hYcACgkQcqXauRfM
H+CdjQ//WVln7ALSPsqyYD9Z+l997zdHRzm6RUBK43gbkqiJYcgKEcrP4r8kyOqq
T66z+fXMNcdc4jO21pFnGJCZplLk4GMyB6boz1EFQniW6l0X9tQwcpcRkjdJQv30
CvUcxP3m/cNlqP8VzIeug2MYUpPS6PIXN5CyZQkpn0KYUTxwNUv0baoz8LBRPkK/
HX708zh5l1gXURV50kuOLJILelyCaiQE14mb4UsYxHEu1Ghz5Qso9H0MJmEHgib7
LEJuU0Qy8JFR5Og+RJ2q3XEqCp4xJ1zkjBCEJsGa2quNKqwRLQBzAGgCiRwnmmNG
CWHv959dPzD0Ub79Rm4TsKEqI3/P2xvE+6tHLUtIPrqv5NoEBhxBtnffdK8MaR9P
2/eUkNd4L851F9Xi7y73aYnxaYdeY7b+tqzHRTZaqGemkt05UWpoC5iU/3/0BReC
gD4Z0Qmz9SE9163/EdVYPZKFbajvhlIXQvovP2dI40RGf21mxLw6ELHX4ITSd3e+
MoXjIPg5+zoLuC4y5EXO1pU1Ov+uEodYUQWfssT6WniW697Tzn6H0c0PnPPQdXvr
Y+djY2fTpk82adz8Y914hYMqfhCkwWSb6vNSIYvcmGFZwNPZUkqD0udmWxTCTUq2
oGCl/WXfK0JzUkXCwBKACYSVK0QrjUqtIDpnVFGC3Lcln8OYZ9A=
=O5NW
-----END PGP SIGNATURE-----

--Apple-Mail=_48041C20-5C64-4E2D-A012-FA0009E2C133--

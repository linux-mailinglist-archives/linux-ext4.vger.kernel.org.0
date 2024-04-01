Return-Path: <linux-ext4+bounces-1811-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8B894697
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 23:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B311E1F221D5
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAE54BE8;
	Mon,  1 Apr 2024 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="S0qAEwxG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE12A1BF
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006900; cv=none; b=Z2oxHJV6g6N+xKpDWFr34T2HLHdanGK6cN7U9J5KqeZbS8wa6kk/n0ld+EgoN+H6jc8QHEC6rvQIfNYq1INhWSkLtUdwf+VVEHZlPSv9XI6OEw6KuuBAHcsAere11Cou/3xoqxl1yTVrCLefbYzgYBEa9S433qj9/nH67i7Zt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006900; c=relaxed/simple;
	bh=O6BIddJc5gJvy98E9wE2kfJ7xb6yBQwBdan3w5Rkrhw=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=f5Y0x2cx+oZjVifrL+ViwXk43V2xbGER9L0PcF3DTAdxZLp/eqTLqPRVMwZQKS1urGRtEc1wjWfX9frGB/CaQNaONKVoJDU9an+U7MO4rXRTbc5BOW4wD/uAlwFPmgelhRRFifocxkUsx2KCTmvFkAbOAG702zpLreJ9hkxUD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=S0qAEwxG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso1160222b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 01 Apr 2024 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712006895; x=1712611695; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rji0Xo8wz/hgQr37fWhpjdpsyV1rkWkSx6PZtJc9MWU=;
        b=S0qAEwxGHHDlsPqf9b2XzHO6n4grMDw8yYbjg/XG7sgqJBmNOuecx3cMmVBCbUexbL
         5lZDcEHib6RyiG4NewO2okXeQYBNEsbrnS6jJda3awICVd4AQbf4qJPn8ZJ331DW7fF8
         k9s/uu2+HBsUY/TTBDB79U9geFkZ9NE8VOaYNLF3iccYMnIWWrz/TQg32/Ev9qEZ1O6S
         EvbBFkG4zqS6LnNBg19CQN5k1grZj3q7mDlHOS+d5yyanVm3OdNS0XjiER5sJJxqzGOQ
         W7Gpris7UFUMI8+aZrtRnfFfkYpcPigrPMcLcbel0e7/m7JE3iei5RnNCTw4Oyjk7Dj1
         fshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006895; x=1712611695;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rji0Xo8wz/hgQr37fWhpjdpsyV1rkWkSx6PZtJc9MWU=;
        b=vyErcIVGrfkLS3IDUCgL4Prb++w/RMZYle0D3ccQ9HxlH7d6hA8339tCFA6K11E3QO
         k7saAeYUHeR5wQQTGak9Nc1Ie5I1Znb3EZVVnpU5P56BV0rz9F3nOb3/37nmR8SYz0KE
         zWJqpdTwijlfxAPUi3jFjTICB5whjc81TGsQ7IDnv2sfUbRxND/BpFbYqS4fj18IViCg
         2ecmjCA3uuG4pHDBTze/XZf82PdjkIRsKoq0WL+JwEAg1gyIFlsHmcpOCBJ+Qz407pFp
         NJDYB6R46bMdvYZ29yRxMpnggpdsqUsyywu3rbAbKHzCybPEpU+H1mGsBnKXtvi3UElw
         UwnQ==
X-Gm-Message-State: AOJu0Yy6yVdb/MiZeSQWaGUa+B3dwC05PgMQT04RUVy5JegACzD+WYmI
	6tO25D3pLTSwBD1k3gOgzqI7YieNWck+Y6PBxpiXntgKTQIIxDqhn0PWy2Pqvc0=
X-Google-Smtp-Source: AGHT+IFhWYFoG2bCwE9ZuaLHXLEZYq+rGqejlpR3d0vrV0jEkURtlorICfEZi3B490goo+yCAzK4rQ==
X-Received: by 2002:a05:6a00:993:b0:6eb:3fad:bd19 with SMTP id u19-20020a056a00099300b006eb3fadbd19mr5282715pfg.0.1712006894685;
        Mon, 01 Apr 2024 14:28:14 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id v186-20020a6261c3000000b006e71e3d1172sm8679597pfb.101.2024.04.01.14.28.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 14:28:14 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <EB4554C6-B186-4180-99BF-EA966FCB3D0A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9A5BAB6C-6F73-4707-9F90-165C1A5FA38A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] misc: add 2038 timestamp support
Date: Mon, 1 Apr 2024 15:29:56 -0600
In-Reply-To: <20230927054016.16645-1-adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org
To: tytso@mit.edu
References: <20230927054016.16645-1-adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_9A5BAB6C-6F73-4707-9F90-165C1A5FA38A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 26, 2023, at 11:40 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> The ext4 kernel code implemented support for s_mtime_hi,
> s_wtime_hi, and related timestamp fields to avoid timestamp
> overflow in 2038, but similar handling is not in e2fsprogs.

Hi Ted,
I'm just going through some of my branches in e2fsprogs. and I
see this one is marked as "accepted" in Patchwork, but has not
been landed to a branch (maint, master, next).  Not that it is
urgent, but you know how people keep old e2fsprogs around for
a long time, and 14 years is no longer that the far in the future.

Cheers, Andreas

>=20
> Add helper macros for the superblock _hi timestamp fields
> ext2fs_super_tstamp_get() and ext2fs_super_tstamp_set().
>=20
> Add helper macro for inode _extra timestamp fields
> ext2fs_inode_xtime_get() and ext2fs_inode_xtime_set().
>=20
> Add helper macro ext2fs_actual_inode_size() to avoid open
> coding the i_extra_isize check in multiple places.
>=20
> Remove inode_time_to_string() since this is unused once callers
> change to time_to_string(ext2fs_inode_xtime_get()) directly.
>=20
> Fix inode_includes() macro to properly wrap "inode" parameter,
> and rename to ext2fs_inode_includes() to avoid potential name
> clashes.  Use this to check inode field inclusion in debugfs
> instead of bare constants for inode field offsets.
>=20
> Use these interfaces to access timestamps in debugfs, e2fsck,
> libext2fs, fuse2fs, tune2fs, and e2undo.
>=20
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> ---
> debugfs/debugfs.c       | 69 +++++++++++++++++++++++------------------
> debugfs/debugfs.h       |  1 -
> debugfs/journal.c       |  7 +++--
> debugfs/set_fields.c    | 32 ++++++++++++-------
> debugfs/util.c          |  8 -----
> e2fsck/message.c        |  2 +-
> e2fsck/pass1.c          | 16 +++++-----
> e2fsck/pass3.c          |  8 +++--
> e2fsck/super.c          | 16 +++++-----
> e2fsck/unix.c           |  2 +-
> lib/e2p/ls.c            | 28 +++++++----------
> lib/ext2fs/bb_inode.c   | 11 ++++---
> lib/ext2fs/closefs.c    |  2 +-
> lib/ext2fs/ext2_fs.h    |  6 ++--
> lib/ext2fs/ext2fs.h     | 52 +++++++++++++++++++++++++++++++
> lib/ext2fs/initialize.c |  3 +-
> lib/ext2fs/inode.c      | 16 +++++-----
> lib/ext2fs/mkjournal.c  |  5 ++-
> lib/ext2fs/orphan.c     |  7 +++--
> lib/ext2fs/res_gdt.c    |  5 ++-
> lib/ext2fs/swapfs.c     | 16 +++++-----
> lib/support/mkquota.c   |  2 +-
> lib/support/plausible.c |  9 ++----
> lib/support/quotaio.c   |  7 +++--
> misc/create_inode.c     | 20 +++++++-----
> misc/e2undo.c           |  6 ++--
> misc/findsuper.c        |  7 ++---
> misc/fuse2fs.c          |  8 ++---
> misc/tune2fs.c          |  6 ++--
> 29 files changed, 231 insertions(+), 146 deletions(-)
>=20
> diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
> index 9b6321dc..96551173 100644
> --- a/debugfs/debugfs.c
> +++ b/debugfs/debugfs.c
> @@ -831,11 +831,13 @@ void internal_dump_inode(FILE *out, const char =
*prefix,
> 	char frag, fsize;
> 	int os =3D current_fs->super->s_creator_os;
> 	struct ext2_inode_large *large_inode;
> -	int is_large_inode =3D 0;
> +	size_t inode_size;
>=20
> -	if (EXT2_INODE_SIZE(current_fs->super) > =
EXT2_GOOD_OLD_INODE_SIZE)
> -		is_large_inode =3D 1;
> 	large_inode =3D (struct ext2_inode_large *) inode;
> +	if (EXT2_INODE_SIZE(current_fs->super) > =
EXT2_GOOD_OLD_INODE_SIZE)
> +		inode_size =3D ext2fs_inode_actual_size(large_inode);
> +	else
> +		inode_size =3D EXT2_GOOD_OLD_INODE_SIZE;
>=20
> 	if (LINUX_S_ISDIR(inode->i_mode)) i_type =3D "directory";
> 	else if (LINUX_S_ISREG(inode->i_mode)) i_type =3D "regular";
> @@ -848,7 +850,7 @@ void internal_dump_inode(FILE *out, const char =
*prefix,
> 	fprintf(out, "%sInode: %u   Type: %s    ", prefix, inode_num, =
i_type);
> 	fprintf(out, "%sMode:  0%03o   Flags: 0x%x\n",
> 		prefix, inode->i_mode & 07777, inode->i_flags);
> -	if (is_large_inode && large_inode->i_extra_isize >=3D 24) {
> +	if (ext2fs_inode_includes(inode_size, i_version_hi)) {
> 		fprintf(out, "%sGeneration: %u    Version: =
0x%08x:%08x\n",
> 			prefix, inode->i_generation, =
large_inode->i_version_hi,
> 			inode->osd1.linux1.l_i_version);
> @@ -858,7 +860,7 @@ void internal_dump_inode(FILE *out, const char =
*prefix,
> 	}
> 	fprintf(out, "%sUser: %5d   Group: %5d",
> 		prefix, inode_uid(*inode), inode_gid(*inode));
> -	if (is_large_inode && large_inode->i_extra_isize >=3D 32)
> +	if (ext2fs_inode_includes(inode_size, i_projid))
> 		fprintf(out, "   Project: %5d", large_inode->i_projid);
> 	fputs("   Size: ", out);
> 	if (LINUX_S_ISREG(inode->i_mode) || =
LINUX_S_ISDIR(inode->i_mode))
> @@ -895,39 +897,48 @@ void internal_dump_inode(FILE *out, const char =
*prefix,
> 	}
> 	fprintf(out, "%sFragment:  Address: %u    Number: %u    Size: =
%u\n",
> 		prefix, inode->i_faddr, frag, fsize);
> -	if (is_large_inode && large_inode->i_extra_isize >=3D 24) {
> +	if (ext2fs_inode_includes(inode_size, i_ctime_extra))
> 		fprintf(out, "%s ctime: 0x%08x:%08x -- %s", prefix,
> 			inode->i_ctime, large_inode->i_ctime_extra,
> -			inode_time_to_string(inode->i_ctime,
> -					     =
large_inode->i_ctime_extra));
> +			time_to_string(ext2fs_inode_xtime_get(inode, =
i_ctime)));
> +	else
> +		fprintf(out, "%sctime: 0x%08x -- %s", prefix, =
inode->i_ctime,
> +			time_to_string((__s32) inode->i_ctime));
> +	if (ext2fs_inode_includes(inode_size, i_atime_extra))
> 		fprintf(out, "%s atime: 0x%08x:%08x -- %s", prefix,
> 			inode->i_atime, large_inode->i_atime_extra,
> -			inode_time_to_string(inode->i_atime,
> -					     =
large_inode->i_atime_extra));
> +			time_to_string(ext2fs_inode_xtime_get(inode, =
i_atime)));
> +	else
> +		fprintf(out, "%satime: 0x%08x -- %s", prefix, =
inode->i_atime,
> +			time_to_string((__s32) inode->i_atime));
> +	if (ext2fs_inode_includes(inode_size, i_mtime_extra))
> 		fprintf(out, "%s mtime: 0x%08x:%08x -- %s", prefix,
> 			inode->i_mtime, large_inode->i_mtime_extra,
> -			inode_time_to_string(inode->i_mtime,
> -					     =
large_inode->i_mtime_extra));
> +			time_to_string(ext2fs_inode_xtime_get(inode, =
i_mtime)));
> +	else
> +		fprintf(out, "%smtime: 0x%08x -- %s", prefix, =
inode->i_mtime,
> +			time_to_string((__s32) inode->i_mtime));
> +	if (ext2fs_inode_includes(inode_size, i_crtime_extra))
> 		fprintf(out, "%scrtime: 0x%08x:%08x -- %s", prefix,
> 			large_inode->i_crtime, =
large_inode->i_crtime_extra,
> -			inode_time_to_string(large_inode->i_crtime,
> -					     =
large_inode->i_crtime_extra));
> -		if (inode->i_dtime)
> +			=
time_to_string(ext2fs_inode_xtime_get(large_inode,
> +							      =
i_crtime)));
> +	if (inode->i_dtime) {
> +		if (ext2fs_inode_includes(inode_size, i_ctime_extra)) {
> +			time_t tm;
> +
> +			/* dtime doesn't have its own i_dtime_extra =
field, so
> +			 * approximate this with i_ctime_extra instead. =
*/
> +			tm =3D __decode_extra_sec(inode->i_dtime,
> +						=
large_inode->i_ctime_extra);
> 			fprintf(out, "%s dtime: 0x%08x:(%08x) -- %s", =
prefix,
> -				large_inode->i_dtime, =
large_inode->i_ctime_extra,
> -				inode_time_to_string(inode->i_dtime,
> -						     =
large_inode->i_ctime_extra));
> -	} else {
> -		fprintf(out, "%sctime: 0x%08x -- %s", prefix, =
inode->i_ctime,
> -			time_to_string((__s32) inode->i_ctime));
> -		fprintf(out, "%satime: 0x%08x -- %s", prefix, =
inode->i_atime,
> -			time_to_string((__s32) inode->i_atime));
> -		fprintf(out, "%smtime: 0x%08x -- %s", prefix, =
inode->i_mtime,
> -			time_to_string((__s32) inode->i_mtime));
> -		if (inode->i_dtime)
> +				inode->i_dtime, =
large_inode->i_ctime_extra,
> +				time_to_string(tm));
> +		} else {
> 			fprintf(out, "%sdtime: 0x%08x -- %s", prefix,
> 				inode->i_dtime,
> 				time_to_string((__s32) inode->i_dtime));
> +		}
> 	}
> 	if (EXT2_INODE_SIZE(current_fs->super) > =
EXT2_GOOD_OLD_INODE_SIZE)
> 		internal_dump_inode_extra(out, prefix, inode_num,
> @@ -935,11 +946,7 @@ void internal_dump_inode(FILE *out, const char =
*prefix,
> 	dump_inode_attributes(out, inode_num);
> 	if (ext2fs_has_feature_metadata_csum(current_fs->super)) {
> 		__u32 crc =3D inode->i_checksum_lo;
> -		if (is_large_inode &&
> -		    large_inode->i_extra_isize >=3D
> -				(offsetof(struct ext2_inode_large,
> -					  i_checksum_hi) -
> -				 EXT2_GOOD_OLD_INODE_SIZE))
> +		if (ext2fs_inode_includes(inode_size, i_checksum_hi))
> 			crc |=3D ((__u32)large_inode->i_checksum_hi) << =
16;
> 		fprintf(out, "Inode checksum: 0x%08x\n", crc);
> 	}
> diff --git a/debugfs/debugfs.h b/debugfs/debugfs.h
> index 39bc0247..85c82b95 100644
> --- a/debugfs/debugfs.h
> +++ b/debugfs/debugfs.h
> @@ -36,7 +36,6 @@ extern int check_fs_not_open(char *name);
> extern int check_fs_read_write(char *name);
> extern int check_fs_bitmaps(char *name);
> extern ext2_ino_t string_to_inode(char *str);
> -extern char *inode_time_to_string(__u32 xtime, __u32 xtime_extra);
> extern char *time_to_string(__s64);
> extern __s64 string_to_time(const char *);
> extern unsigned long parse_ulong(const char *str, const char *cmd,
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index 5bac0d3b..454fbcfc 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -245,6 +245,8 @@ void wait_on_buffer(struct buffer_head *bh)
>=20
> static void ext2fs_clear_recover(ext2_filsys fs, int error)
> {
> +	time_t s_mtime;
> +
> 	ext2fs_clear_feature_journal_needs_recovery(fs->super);
>=20
> 	/* if we had an error doing journal recovery, we need a full =
fsck */
> @@ -254,8 +256,9 @@ static void ext2fs_clear_recover(ext2_filsys fs, =
int error)
> 	 * If we replayed the journal by definition the file system
> 	 * was mounted since the last time it was checked
> 	 */
> -	if (fs->super->s_lastcheck >=3D fs->super->s_mtime)
> -		fs->super->s_lastcheck =3D fs->super->s_mtime - 1;
> +	s_mtime =3D ext2fs_get_tstamp(fs->super, s_mtime);
> +	if (ext2fs_get_tstamp(fs->super, s_lastcheck) >=3D s_mtime)
> +		ext2fs_set_tstamp(fs->super, s_lastcheck, s_mtime - 1);
> 	ext2fs_mark_super_dirty(fs);
> }
>=20
> diff --git a/debugfs/set_fields.c b/debugfs/set_fields.c
> index f916deab..ef137b0f 100644
> --- a/debugfs/set_fields.c
> +++ b/debugfs/set_fields.c
> @@ -99,15 +99,16 @@ static struct field_set_info super_fields[] =3D {
> 	{ "blocks_per_group", &set_sb.s_blocks_per_group, NULL, 4, =
parse_uint },
> 	{ "clusters_per_group", &set_sb.s_clusters_per_group, NULL, 4, =
parse_uint },
> 	{ "inodes_per_group", &set_sb.s_inodes_per_group, NULL, 4, =
parse_uint },
> -	{ "mtime", &set_sb.s_mtime, NULL, 4, parse_time },
> -	{ "wtime", &set_sb.s_wtime, NULL, 4, parse_time },
> +	{ "mtime", &set_sb.s_mtime, &set_sb.s_mtime_hi, 5, parse_time },
> +	{ "wtime", &set_sb.s_wtime, &set_sb.s_wtime_hi, 5, parse_time },
> 	{ "mnt_count", &set_sb.s_mnt_count, NULL, 2, parse_uint },
> 	{ "max_mnt_count", &set_sb.s_max_mnt_count, NULL, 2, parse_int =
},
> 	/* s_magic */
> 	{ "state", &set_sb.s_state, NULL, 2, parse_uint },
> 	{ "errors", &set_sb.s_errors, NULL, 2, parse_uint },
> 	{ "minor_rev_level", &set_sb.s_minor_rev_level, NULL, 2, =
parse_uint },
> -	{ "lastcheck", &set_sb.s_lastcheck, NULL, 4, parse_time },
> +	{ "lastcheck", &set_sb.s_lastcheck, &set_sb.s_lastcheck_hi, 5,
> +		parse_time },
> 	{ "checkinterval", &set_sb.s_checkinterval, NULL, 4, parse_uint =
},
> 	{ "creator_os", &set_sb.s_creator_os, NULL, 4, parse_uint },
> 	{ "rev_level", &set_sb.s_rev_level, NULL, 4, parse_uint },
> @@ -139,7 +140,8 @@ static struct field_set_info super_fields[] =3D {
> 	{ "desc_size", &set_sb.s_desc_size, NULL, 2, parse_uint },
> 	{ "default_mount_opts", &set_sb.s_default_mount_opts, NULL, 4, =
parse_uint },
> 	{ "first_meta_bg", &set_sb.s_first_meta_bg, NULL, 4, parse_uint =
},
> -	{ "mkfs_time", &set_sb.s_mkfs_time, NULL, 4, parse_time },
> +	{ "mkfs_time", &set_sb.s_mkfs_time, &set_sb.s_mkfs_time_hi, 5,
> +		parse_time },
> 	{ "jnl_blocks", &set_sb.s_jnl_blocks[0], NULL, 4, parse_uint, =
FLAG_ARRAY,
> 	  17 },
> 	{ "min_extra_isize", &set_sb.s_min_extra_isize, NULL, 2, =
parse_uint },
> @@ -167,12 +169,14 @@ static struct field_set_info super_fields[] =3D =
{
> 	{ "checksum_type", &set_sb.s_checksum_type, NULL, 1, parse_uint =
},
> 	{ "encryption_level", &set_sb.s_encryption_level, NULL, 1, =
parse_uint },
> 	{ "error_count", &set_sb.s_error_count, NULL, 4, parse_uint },
> -	{ "first_error_time", &set_sb.s_first_error_time, NULL, 4, =
parse_time },
> +	{ "first_error_time", &set_sb.s_first_error_time,
> +		&set_sb.s_first_error_time_hi, 5, parse_time },
> 	{ "first_error_ino", &set_sb.s_first_error_ino, NULL, 4, =
parse_uint },
> 	{ "first_error_block", &set_sb.s_first_error_block, NULL, 8, =
parse_uint },
> 	{ "first_error_func", &set_sb.s_first_error_func, NULL, 32, =
parse_string },
> 	{ "first_error_line", &set_sb.s_first_error_line, NULL, 4, =
parse_uint },
> -	{ "last_error_time", &set_sb.s_last_error_time, NULL, 4, =
parse_time },
> +	{ "last_error_time", &set_sb.s_last_error_time,
> +		&set_sb.s_last_error_time_hi, 5, parse_time },
> 	{ "last_error_ino", &set_sb.s_last_error_ino, NULL, 4, =
parse_uint },
> 	{ "last_error_block", &set_sb.s_last_error_block, NULL, 8, =
parse_uint },
> 	{ "last_error_func", &set_sb.s_last_error_func, NULL, 32, =
parse_string },
> @@ -441,6 +445,9 @@ static struct field_set_info *find_field(struct =
field_set_info *fields,
>  * Note: info->size =3D=3D 6 is special; this means a base size 4 =
bytes,
>  * and secondary (high) size of 2 bytes.  This is needed for the
>  * special case of i_blocks_high and i_file_acl_high.
> + *
> + * Similarly, info->size =3D=3D 5 is for superblock timestamps, which =
have
> + * a 4-byte primary field and a 1-byte _hi field.
>  */
> static errcode_t parse_uint(struct field_set_info *info, char *field,
> 			    char *arg)
> @@ -449,7 +456,7 @@ static errcode_t parse_uint(struct field_set_info =
*info, char *field,
> 	int suffix =3D check_suffix(field);
> 	char *tmp;
> 	void *field1 =3D info->ptr, *field2 =3D info->ptr2;
> -	int size =3D (info->size =3D=3D 6) ? 4 : info->size;
> +	int size =3D (info->size =3D=3D 6 || info->size =3D=3D 5) ? 4 : =
info->size;
> 	union {
> 		__u64	*ptr64;
> 		__u32	*ptr32;
> @@ -477,7 +484,7 @@ static errcode_t parse_uint(struct field_set_info =
*info, char *field,
> 	}
> 	mask =3D ~0ULL >> ((8 - size) * 8);
> 	limit =3D ~0ULL >> ((8 - info->size) * 8);
> -	if (field2 && info->size !=3D 6)
> +	if (field2 && (info->size !=3D 6 || info->size !=3D 5))
> 		limit =3D ~0ULL >> ((8 - info->size*2) * 8);
>=20
> 	if (num > limit) {
> @@ -504,13 +511,14 @@ static errcode_t parse_uint(struct =
field_set_info *info, char *field,
> 		return 0;
> 	n =3D (size =3D=3D 8) ? 0 : (num >> (size*8));
> 	u.ptr8 =3D (__u8 *) field2;
> -	if (info->size =3D=3D 6)
> -		size =3D 2;
> +	if (info->size > size)
> +		size =3D info->size - size;
> 	switch (size) {
> 	case 8:
> 		/* Should never get here */
> -		fprintf(stderr, "64-bit field %s has a second 64-bit =
field\n"
> -			"defined; BUG?!?\n", info->name);
> +		fprintf(stderr,
> +			"64-bit field %s has a second 64-bit field =
defined; BUG?!?\n",
> +			info->name);
> 		*u.ptr64 =3D 0;
> 		break;
> 	case 4:
> diff --git a/debugfs/util.c b/debugfs/util.c
> index 9e880548..d3ef63c6 100644
> --- a/debugfs/util.c
> +++ b/debugfs/util.c
> @@ -191,14 +191,6 @@ int check_fs_bitmaps(char *name)
> 	return 0;
> }
>=20
> -char *inode_time_to_string(__u32 xtime, __u32 xtime_extra)
> -{
> -	__s64 t =3D (__s32) xtime;
> -
> -	t +=3D (__s64) (xtime_extra & EXT4_EPOCH_MASK) << 32;
> -	return time_to_string(t);
> -}
> -
> /*
>  * This function takes a __s64 time value and converts it to a string,
>  * using ctime
> diff --git a/e2fsck/message.c b/e2fsck/message.c
> index ba38038c..9c42b13f 100644
> --- a/e2fsck/message.c
> +++ b/e2fsck/message.c
> @@ -301,7 +301,7 @@ static _INLINE_ void expand_inode_expression(FILE =
*f, ext2_filsys fs, char ch,
> 		fprintf(f, "0%o", inode->i_mode);
> 		break;
> 	case 'M':
> -		print_time(f, inode->i_mtime);
> +		print_time(f, ext2fs_inode_xtime_get(inode, i_mtime));
> 		break;
> 	case 'F':
> 		fprintf(f, "%u", inode->i_faddr);
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index a341c72a..078bcb9b 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -1181,6 +1181,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> 	ext2_ino_t	ino_threshold =3D 0;
> 	dgrp_t		ra_group =3D 0;
> 	struct ea_quota	ea_ibody_quota;
> +	time_t		tm;
>=20
> 	init_resource_track(&rtrack, ctx->fs->io);
> 	clear_problem_context(&pctx);
> @@ -1357,12 +1358,13 @@ void e2fsck_pass1(e2fsck_t ctx)
> 	if (ctx->progress && ((ctx->progress)(ctx, 1, 0,
> 					      =
ctx->fs->group_desc_count)))
> 		goto endit;
> -	if ((fs->super->s_wtime &&
> -	     fs->super->s_wtime < fs->super->s_inodes_count) ||
> -	    (fs->super->s_mtime &&
> -	     fs->super->s_mtime < fs->super->s_inodes_count) ||
> -	    (fs->super->s_mkfs_time &&
> -	     fs->super->s_mkfs_time < fs->super->s_inodes_count))
> +
> +	if (((tm =3D ext2fs_get_tstamp(fs->super, s_wtime)) &&
> +	     tm < fs->super->s_inodes_count) ||
> +	    ((tm =3D ext2fs_get_tstamp(fs->super, s_mtime)) &&
> +	     tm < fs->super->s_inodes_count) ||
> +	    ((tm =3D ext2fs_get_tstamp(fs->super, s_mkfs_time)) &&
> +	     tm < fs->super->s_inodes_count))
> 		low_dtime_check =3D 0;
>=20
> 	if (ext2fs_has_feature_mmp(fs->super) &&
> @@ -2076,7 +2078,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> 		if (!pctx.errcode) {
> 			e2fsck_read_inode(ctx, EXT2_RESIZE_INO, inode,
> 					  "recreate inode");
> -			inode->i_mtime =3D ctx->now;
> +			ext2fs_inode_xtime_set(inode, i_mtime, =
ctx->now);
> 			e2fsck_write_inode(ctx, EXT2_RESIZE_INO, inode,
> 					   "recreate inode");
> 		}
> diff --git a/e2fsck/pass3.c b/e2fsck/pass3.c
> index 16d243f6..ba794165 100644
> --- a/e2fsck/pass3.c
> +++ b/e2fsck/pass3.c
> @@ -212,7 +212,9 @@ skip_new_block:
> 	memset(&inode, 0, sizeof(inode));
> 	inode.i_mode =3D 040755;
> 	inode.i_size =3D fs->blocksize;
> -	inode.i_atime =3D inode.i_ctime =3D inode.i_mtime =3D ctx->now;
> +	ext2fs_inode_xtime_set(&inode, i_atime, ctx->now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, ctx->now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, ctx->now);
> 	inode.i_links_count =3D 2;
> 	ext2fs_iblk_set(fs, iptr, 1);
> 	inode.i_block[0] =3D blk;
> @@ -528,7 +530,9 @@ skip_new_block:
> 	memset(&inode, 0, sizeof(inode));
> 	inode.i_mode =3D 040700;
> 	inode.i_size =3D fs->blocksize;
> -	inode.i_atime =3D inode.i_ctime =3D inode.i_mtime =3D ctx->now;
> +	ext2fs_inode_xtime_set(&inode, i_atime, ctx->now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, ctx->now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, ctx->now);
> 	inode.i_links_count =3D 2;
> 	ext2fs_iblk_set(fs, EXT2_INODE(&inode), 1);
> 	inode.i_block[0] =3D blk;
> diff --git a/e2fsck/super.c b/e2fsck/super.c
> index be40dd8f..757a475d 100644
> --- a/e2fsck/super.c
> +++ b/e2fsck/super.c
> @@ -1320,25 +1320,25 @@ void check_super_block(e2fsck_t ctx)
> 	 */
> 	if (((ctx->options & E2F_OPT_FORCE) || =
fs->super->s_checkinterval) &&
> 	    !broken_system_clock && !(ctx->flags & E2F_FLAG_TIME_INSANE) =
&&
> -	    (fs->super->s_mtime > (__u32) ctx->now)) {
> -		pctx.num =3D fs->super->s_mtime;
> +	    (ext2fs_get_tstamp(fs->super, s_mtime) > ctx->now)) {
> +		pctx.num =3D ext2fs_get_tstamp(fs->super, s_mtime);
> 		problem =3D PR_0_FUTURE_SB_LAST_MOUNT;
> -		if (fs->super->s_mtime <=3D (__u32) ctx->now + =
ctx->time_fudge)
> +		if (pctx.num <=3D ctx->now + ctx->time_fudge)
> 			problem =3D PR_0_FUTURE_SB_LAST_MOUNT_FUDGED;
> 		if (fix_problem(ctx, problem, &pctx)) {
> -			fs->super->s_mtime =3D ctx->now;
> +			ext2fs_set_tstamp(fs->super, s_mtime, ctx->now);
> 			fs->flags |=3D EXT2_FLAG_DIRTY;
> 		}
> 	}
> 	if (((ctx->options & E2F_OPT_FORCE) || =
fs->super->s_checkinterval) &&
> 	    !broken_system_clock && !(ctx->flags & E2F_FLAG_TIME_INSANE) =
&&
> -	    (fs->super->s_wtime > (__u32) ctx->now)) {
> -		pctx.num =3D fs->super->s_wtime;
> +	    (ext2fs_get_tstamp(fs->super, s_wtime) > ctx->now)) {
> +		pctx.num =3D ext2fs_get_tstamp(fs->super, s_wtime);
> 		problem =3D PR_0_FUTURE_SB_LAST_WRITE;
> -		if (fs->super->s_wtime <=3D (__u32) ctx->now + =
ctx->time_fudge)
> +		if (pctx.num <=3D ctx->now + ctx->time_fudge)
> 			problem =3D PR_0_FUTURE_SB_LAST_WRITE_FUDGED;
> 		if (fix_problem(ctx, problem, &pctx)) {
> -			fs->super->s_wtime =3D ctx->now;
> +			ext2fs_set_tstamp(fs->super, s_wtime, ctx->now);
> 			fs->flags |=3D EXT2_FLAG_DIRTY;
> 		}
> 	}
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index e5b672a2..bc6b518d 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -2080,7 +2080,7 @@ cleanup:
> 		} else
> 			sb->s_state &=3D ~EXT2_VALID_FS;
> 		if (!(ctx->flags & E2F_FLAG_TIME_INSANE))
> -			sb->s_lastcheck =3D ctx->now;
> +			ext2fs_set_tstamp(sb, s_lastcheck, ctx->now);
> 		sb->s_mnt_count =3D 0;
> 		memset(((char *) sb) + EXT4_S_ERR_START, 0, =
EXT4_S_ERR_LEN);
> 		pctx.errcode =3D ext2fs_set_gdt_csum(ctx->fs);
> diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
> index 0b74aea2..081ef975 100644
> --- a/lib/e2p/ls.c
> +++ b/lib/e2p/ls.c
> @@ -313,27 +313,23 @@ void list_super2(struct ext2_super_block * sb, =
FILE *f)
> 	if (sb->s_log_groups_per_flex)
> 		fprintf(f, "Flex block group size:    %u\n",
> 			1U << sb->s_log_groups_per_flex);
> -	if (sb->s_mkfs_time) {
> -		tm =3D sb->s_mkfs_time;
> +	tm =3D ext2fs_get_tstamp(sb, s_mkfs_time);
> +	if (tm)
> 		fprintf(f, "Filesystem created:       %s", ctime(&tm));
> -	}
> -	tm =3D sb->s_mtime;
> -	fprintf(f, "Last mount time:          %s",
> -		sb->s_mtime ? ctime(&tm) : "n/a\n");
> -	tm =3D sb->s_wtime;
> +	tm =3D ext2fs_get_tstamp(sb, s_mtime);
> +	fprintf(f, "Last mount time:          %s", tm ? ctime(&tm) : =
"n/a\n");
> +	tm =3D ext2fs_get_tstamp(sb, s_wtime);
> 	fprintf(f, "Last write time:          %s", ctime(&tm));
> 	fprintf(f, "Mount count:              %u\n", sb->s_mnt_count);
> 	fprintf(f, "Maximum mount count:      %d\n", =
sb->s_max_mnt_count);
> -	tm =3D sb->s_lastcheck;
> +	tm =3D ext2fs_get_tstamp(sb, s_lastcheck);
> 	fprintf(f, "Last checked:             %s", ctime(&tm));
> 	fprintf(f, "Check interval:           %u (%s)\n", =
sb->s_checkinterval,
> 	       interval_string(sb->s_checkinterval));
> 	if (sb->s_checkinterval)
> 	{
> -		time_t next;
> -
> -		next =3D sb->s_lastcheck + sb->s_checkinterval;
> -		fprintf(f, "Next check after:         %s", =
ctime(&next));
> +		tm +=3D sb->s_checkinterval;
> +		fprintf(f, "Next check after:         %s", ctime(&tm));
> 	}
> #define POW2(x) ((__u64) 1 << (x))
> 	if (sb->s_kbytes_written) {
> @@ -419,8 +415,8 @@ void list_super2(struct ext2_super_block * sb, =
FILE *f)
> 	if (sb->s_error_count)
> 		fprintf(f, "FS Error count:           %u\n",
> 			sb->s_error_count);
> -	if (sb->s_first_error_time) {
> -		tm =3D sb->s_first_error_time;
> +	tm =3D ext2fs_get_tstamp(sb, s_first_error_time);
> +	if (tm) {
> 		fprintf(f, "First error time:         %s", ctime(&tm));
> 		fprintf(f, "First error function:     %.*s\n",
> 			EXT2_LEN_STR(sb->s_first_error_func));
> @@ -436,8 +432,8 @@ void list_super2(struct ext2_super_block * sb, =
FILE *f)
> 			fprintf(f, "First error err:          %s\n",
> 				=
e2p_errcode2str(sb->s_first_error_errcode));
> 	}
> -	if (sb->s_last_error_time) {
> -		tm =3D sb->s_last_error_time;
> +	tm =3D ext2fs_get_tstamp(sb, s_last_error_time);
> +	if (tm) {
> 		fprintf(f, "Last error time:          %s", ctime(&tm));
> 		fprintf(f, "Last error function:      %.*s\n",
> 			EXT2_LEN_STR(sb->s_last_error_func));
> diff --git a/lib/ext2fs/bb_inode.c b/lib/ext2fs/bb_inode.c
> index 11f10ebc..927a4d41 100644
> --- a/lib/ext2fs/bb_inode.c
> +++ b/lib/ext2fs/bb_inode.c
> @@ -58,8 +58,9 @@ static int clear_bad_block_proc(ext2_filsys fs, =
blk_t *block_nr,
> errcode_t ext2fs_update_bb_inode(ext2_filsys fs, ext2_badblocks_list =
bb_list)
> {
> 	errcode_t			retval;
> -	struct set_badblock_record 	rec;
> +	struct set_badblock_record	rec;
> 	struct ext2_inode		inode;
> +	time_t				now;
>=20
> 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
>=20
> @@ -124,9 +125,11 @@ errcode_t ext2fs_update_bb_inode(ext2_filsys fs, =
ext2_badblocks_list bb_list)
> 	if (retval)
> 		goto cleanup;
>=20
> -	inode.i_atime =3D inode.i_mtime =3D fs->now ? fs->now : time(0);
> -	if (!inode.i_ctime)
> -		inode.i_ctime =3D fs->now ? fs->now : time(0);
> +	now =3D fs->now ? fs->now : time(0);
> +	ext2fs_inode_xtime_set(&inode, i_atime, now);
> +	if (!ext2fs_inode_xtime_get(&inode, i_ctime))
> +		ext2fs_inode_xtime_set(&inode, i_ctime, now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, now);
> 	ext2fs_iblk_set(fs, &inode, rec.bad_block_count);
> 	retval =3D ext2fs_inode_size_set(fs, &inode,
> 				       rec.bad_block_count * =
fs->blocksize);
> diff --git a/lib/ext2fs/closefs.c b/lib/ext2fs/closefs.c
> index 69cbdd8c..42bda1fa 100644
> --- a/lib/ext2fs/closefs.c
> +++ b/lib/ext2fs/closefs.c
> @@ -301,7 +301,7 @@ errcode_t ext2fs_flush2(ext2_filsys fs, int flags)
> 	fs_state =3D fs->super->s_state;
> 	feature_incompat =3D fs->super->s_feature_incompat;
>=20
> -	fs->super->s_wtime =3D fs->now ? fs->now : time(NULL);
> +	ext2fs_set_tstamp(fs->super, s_wtime, fs->now ? fs->now : =
time(NULL));
> 	fs->super->s_block_group_nr =3D 0;
>=20
> 	/*
> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> index 0fc9c09a..586141f8 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -512,9 +512,9 @@ struct ext2_inode_large {
>=20
> #define i_checksum_lo	osd2.linux2.l_i_checksum_lo
>=20
> -#define inode_includes(size, field)			\
> -       (size >=3D (sizeof(((struct ext2_inode_large *)0)->field) + \
> -                 offsetof(struct ext2_inode_large, field)))
> +#define ext2fs_inode_includes(size, field)				=
\
> +	((size) >=3D (sizeof(((struct ext2_inode_large *)0)->field) +	=
\
> +		    offsetof(struct ext2_inode_large, field)))
>=20
> #if defined(__KERNEL__) || defined(__linux__)
> #define i_reserved1	osd1.linux1.l_i_reserved1
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 72c60d2b..8953817c 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -579,6 +579,58 @@ typedef struct ext2_struct_inode_scan =
*ext2_inode_scan;
>  */
> #define EXT2_I_SIZE(i)	((i)->i_size | ((__u64) (i)->i_size_high =
<< 32))
>=20
> +static inline __u32 __encode_extra_time(time_t seconds, __u32 nsec)
> +{
> +	__u32 extra =3D ((seconds - (__s32)seconds) >> 32) & =
EXT4_EPOCH_MASK;
> +	return extra | (nsec << EXT4_EPOCH_BITS);
> +}
> +static inline time_t __decode_extra_sec(time_t seconds, __u32 extra)
> +{
> +	if (extra & EXT4_EPOCH_MASK)
> +		seconds +=3D ((time_t)(extra & EXT4_EPOCH_MASK) << 32);
> +	return seconds;
> +}
> +static inline __u32 __decode_extra_nsec(__u32 extra)
> +{
> +	return (extra & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
> +}
> +#define ext2fs_inode_actual_size(inode)				 =
     \
> +	(EXT2_GOOD_OLD_INODE_SIZE +					 =
     \
> +	 (sizeof(*inode) > EXT2_GOOD_OLD_INODE_SIZE ?			 =
     \
> +		((struct ext2_inode_large *)(inode))->i_extra_isize : =
0))
> +#define clamp(val, min, max) ((val) < (min) ? (min) : ((val) > (max) =
?	      \
> +						       (max) : (val)))
> +#define ext2fs_inode_xtime_set(inode, field, sec)			 =
     \
> +do {									 =
     \
> +	if (ext2fs_inode_includes(ext2fs_inode_actual_size(inode),	 =
     \
> +				  field ## _extra)) {			 =
     \
> +		(inode)->field =3D (__s32)sec;				 =
     \
> +		((struct ext2_inode_large *)(inode))->field ## _extra =3D =
      \
> +			__encode_extra_time(sec, 0);			 =
     \
> +	} else {							 =
     \
> +		(inode)->field =3D clamp(sec, INT32_MIN, INT32_MAX);	 =
     \
> +	}								 =
     \
> +} while (0)
> +#define ext2fs_inode_xtime_get(inode, field)				 =
     \
> +(ext2fs_inode_includes(ext2fs_inode_actual_size(inode), field ## =
_extra) ?    \
> +	__decode_extra_sec((inode)->field,				 =
     \
> +		((struct ext2_inode_large *)(inode))->field ## _extra) : =
     \
> +		(time_t)(inode)->field)
> +
> +static inline void __sb_set_tstamp(__u32 *lo, __u8 *hi, time_t =
seconds)
> +{
> +	*lo =3D seconds & 0xffffffff;
> +	*hi =3D seconds >> 32;
> +}
> +static inline time_t __sb_get_tstamp(__u32 *lo, __u8 *hi)
> +{
> +	return ((time_t)(*hi) << 32) | *lo;
> +}
> +#define ext2fs_set_tstamp(sb, field, seconds) \
> +	__sb_set_tstamp(&(sb)->field, &(sb)->field ## _hi, seconds)
> +#define ext2fs_get_tstamp(sb, field) \
> +	__sb_get_tstamp(&(sb)->field, &(sb)->field ## _hi)
> +
> /*
>  * ext2_icount_t abstraction
>  */
> diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
> index edd692bb..32467a29 100644
> --- a/lib/ext2fs/initialize.c
> +++ b/lib/ext2fs/initialize.c
> @@ -218,7 +218,8 @@ errcode_t ext2fs_initialize(const char *name, int =
flags,
> 	}
>=20
> 	set_field(s_checkinterval, 0);
> -	super->s_mkfs_time =3D super->s_lastcheck =3D fs->now ? fs->now =
: time(NULL);
> +	ext2fs_set_tstamp(super, s_mkfs_time, fs->now ? fs->now : =
time(NULL));
> +	ext2fs_set_tstamp(super, s_lastcheck, fs->now ? fs->now : =
time(NULL));
>=20
> 	super->s_creator_os =3D CREATOR_OS;
>=20
> diff --git a/lib/ext2fs/inode.c b/lib/ext2fs/inode.c
> index 957d5aa9..8686f99c 100644
> --- a/lib/ext2fs/inode.c
> +++ b/lib/ext2fs/inode.c
> @@ -1039,17 +1039,17 @@ errcode_t ext2fs_write_new_inode(ext2_filsys =
fs, ext2_ino_t ino,
> 				 struct ext2_inode *inode)
> {
> 	struct ext2_inode	*buf;
> -	int 			size =3D EXT2_INODE_SIZE(fs->super);
> +	int			size =3D EXT2_INODE_SIZE(fs->super);
> 	struct ext2_inode_large	*large_inode;
> 	errcode_t		retval;
> -	__u32 			t =3D fs->now ? fs->now : time(NULL);
> +	time_t			t =3D fs->now ? fs->now : time(NULL);
>=20
> -	if (!inode->i_ctime)
> -		inode->i_ctime =3D t;
> -	if (!inode->i_mtime)
> -		inode->i_mtime =3D t;
> -	if (!inode->i_atime)
> -		inode->i_atime =3D t;
> +	if (!ext2fs_inode_xtime_get(inode, i_atime))
> +		ext2fs_inode_xtime_set(inode, i_atime, t);
> +	if (!ext2fs_inode_xtime_get(inode, i_ctime))
> +		ext2fs_inode_xtime_set(inode, i_ctime, t);
> +	if (!ext2fs_inode_xtime_get(inode, i_mtime))
> +		ext2fs_inode_xtime_set(inode, i_mtime, t);
>=20
> 	if (size =3D=3D sizeof(struct ext2_inode))
> 		return ext2fs_write_inode_full(fs, ino, inode,
> diff --git a/lib/ext2fs/mkjournal.c b/lib/ext2fs/mkjournal.c
> index 54772dd5..4a947b61 100644
> --- a/lib/ext2fs/mkjournal.c
> +++ b/lib/ext2fs/mkjournal.c
> @@ -285,6 +285,7 @@ static errcode_t write_journal_inode(ext2_filsys =
fs, ext2_ino_t journal_ino,
> 	unsigned long long	inode_size;
> 	int			falloc_flags =3D =
EXT2_FALLOCATE_FORCE_INIT;
> 	blk64_t			zblk;
> +	time_t			now;
>=20
> 	if ((retval =3D ext2fs_create_journal_superblock2(fs, jparams, =
flags,
> 						       &buf)))
> @@ -312,7 +313,9 @@ static errcode_t write_journal_inode(ext2_filsys =
fs, ext2_ino_t journal_ino,
>=20
> 	inode_size =3D (unsigned long long)fs->blocksize *
> 			(jparams->num_journal_blocks + =
jparams->num_fc_blocks);
> -	inode.i_mtime =3D inode.i_ctime =3D fs->now ? fs->now : time(0);
> +	now =3D fs->now ? fs->now : time(0);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, now);
> 	inode.i_links_count =3D 1;
> 	inode.i_mode =3D LINUX_S_IFREG | 0600;
> 	retval =3D ext2fs_inode_size_set(fs, &inode, inode_size);
> diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
> index e25f20ca..60f4ea18 100644
> --- a/lib/ext2fs/orphan.c
> +++ b/lib/ext2fs/orphan.c
> @@ -126,6 +126,7 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys =
fs, blk_t num_blocks)
> 	char *buf =3D NULL, *zerobuf =3D NULL;
> 	struct mkorphan_info oi;
> 	struct ext4_orphan_block_tail *ob_tail;
> +	time_t now;
>=20
> 	if (!ino) {
> 		err =3D ext2fs_new_inode(fs, EXT2_ROOT_INO, =
LINUX_S_IFREG | 0600,
> @@ -185,8 +186,10 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys =
fs, blk_t num_blocks)
> 	if (err)
> 		goto out;
> 	ext2fs_iblk_set(fs, &inode, 0);
> -	inode.i_atime =3D inode.i_mtime =3D
> -		inode.i_ctime =3D fs->now ? fs->now : time(0);
> +	now =3D fs->now ? fs->now : time(0);
> +	ext2fs_inode_xtime_set(&inode, i_atime, now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, now);
> 	inode.i_links_count =3D 1;
> 	inode.i_mode =3D LINUX_S_IFREG | 0600;
> 	ext2fs_iblk_add_blocks(fs, &inode, oi.alloc_blocks);
> diff --git a/lib/ext2fs/res_gdt.c b/lib/ext2fs/res_gdt.c
> index fa8d8d6b..9024165d 100644
> --- a/lib/ext2fs/res_gdt.c
> +++ b/lib/ext2fs/res_gdt.c
> @@ -227,7 +227,10 @@ out_inode:
> 	       EXT2_I_SIZE(&inode));
> #endif
> 	if (inode_dirty) {
> -		inode.i_atime =3D inode.i_mtime =3D fs->now ? fs->now : =
time(0);
> +		time_t now =3D fs->now ? fs->now : time(0);
> +
> +		ext2fs_inode_xtime_set(&inode, i_atime, now);
> +		ext2fs_inode_xtime_set(&inode, i_mtime, now);
> 		retval2 =3D ext2fs_write_new_inode(fs, EXT2_RESIZE_INO, =
&inode);
> 		if (!retval)
> 			retval =3D retval2;
> diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
> index fe764b9e..d8d21407 100644
> --- a/lib/ext2fs/swapfs.c
> +++ b/lib/ext2fs/swapfs.c
> @@ -345,21 +345,21 @@ void ext2fs_swap_inode_full(ext2_filsys fs, =
struct ext2_inode_large *t,
> 		return;		/* Illegal inode extra_isize */
>=20
> 	inode_size =3D EXT2_GOOD_OLD_INODE_SIZE + extra_isize;
> -	if (inode_includes(inode_size, i_checksum_hi))
> +	if (ext2fs_inode_includes(inode_size, i_checksum_hi))
> 		t->i_checksum_hi =3D ext2fs_swab16(f->i_checksum_hi);
> -	if (inode_includes(inode_size, i_ctime_extra))
> +	if (ext2fs_inode_includes(inode_size, i_ctime_extra))
> 		t->i_ctime_extra =3D ext2fs_swab32(f->i_ctime_extra);
> -	if (inode_includes(inode_size, i_mtime_extra))
> +	if (ext2fs_inode_includes(inode_size, i_mtime_extra))
> 		t->i_mtime_extra =3D ext2fs_swab32(f->i_mtime_extra);
> -	if (inode_includes(inode_size, i_atime_extra))
> +	if (ext2fs_inode_includes(inode_size, i_atime_extra))
> 		t->i_atime_extra =3D ext2fs_swab32(f->i_atime_extra);
> -	if (inode_includes(inode_size, i_crtime))
> +	if (ext2fs_inode_includes(inode_size, i_crtime))
> 		t->i_crtime =3D ext2fs_swab32(f->i_crtime);
> -	if (inode_includes(inode_size, i_crtime_extra))
> +	if (ext2fs_inode_includes(inode_size, i_crtime_extra))
> 		t->i_crtime_extra =3D ext2fs_swab32(f->i_crtime_extra);
> -	if (inode_includes(inode_size, i_version_hi))
> +	if (ext2fs_inode_includes(inode_size, i_version_hi))
> 		t->i_version_hi =3D ext2fs_swab32(f->i_version_hi);
> -	if (inode_includes(inode_size, i_projid))
> +	if (ext2fs_inode_includes(inode_size, i_projid))
>                 t->i_projid =3D ext2fs_swab32(f->i_projid);
> 	/* catch new static fields added after i_projid */
> 	EXT2FS_BUILD_BUG_ON(sizeof(struct ext2_inode_large) !=3D 160);
> diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
> index 9339c994..81cfbf1f 100644
> --- a/lib/support/mkquota.c
> +++ b/lib/support/mkquota.c
> @@ -269,7 +269,7 @@ static inline qid_t get_qid(struct =
ext2_inode_large *inode, enum quota_type qtyp
> 	case PRJQUOTA:
> 		inode_size =3D EXT2_GOOD_OLD_INODE_SIZE +
> 			inode->i_extra_isize;
> -		if (inode_includes(inode_size, i_projid))
> +		if (ext2fs_inode_includes(inode_size, i_projid))
> 			return inode_projid(*inode);
> 		return 0;
> 	default:
> diff --git a/lib/support/plausible.c b/lib/support/plausible.c
> index 65a6b2e1..eccba22a 100644
> --- a/lib/support/plausible.c
> +++ b/lib/support/plausible.c
> @@ -108,18 +108,15 @@ static void print_ext2_info(const char *device)
> 		return;
> 	sb =3D fs->super;
>=20
> -	if (sb->s_mtime) {
> -		tm =3D sb->s_mtime;
> +	if ((tm =3D ext2fs_get_tstamp(sb, s_mtime))) {
> 		if (sb->s_last_mounted[0])
> 			printf(_("\tlast mounted on %.*s on %s"),
> 			       EXT2_LEN_STR(sb->s_last_mounted), =
ctime(&tm));
> 		else
> 			printf(_("\tlast mounted on %s"), ctime(&tm));
> -	} else if (sb->s_mkfs_time) {
> -		tm =3D sb->s_mkfs_time;
> +	} else if ((tm =3D ext2fs_get_tstamp(sb, s_mkfs_time))) {
> 		printf(_("\tcreated on %s"), ctime(&tm));
> -	} else if (sb->s_wtime) {
> -		tm =3D sb->s_wtime;
> +	} else if ((tm =3D ext2fs_get_tstamp(sb, s_wtime))) {
> 		printf(_("\tlast modified on %s"), ctime(&tm));
> 	}
> 	ext2fs_close_free(&fs);
> diff --git a/lib/support/quotaio.c b/lib/support/quotaio.c
> index b41bb749..916e28cf 100644
> --- a/lib/support/quotaio.c
> +++ b/lib/support/quotaio.c
> @@ -272,6 +272,7 @@ static errcode_t quota_inode_init_new(ext2_filsys =
fs, ext2_ino_t ino)
> {
> 	struct ext2_inode inode;
> 	errcode_t err =3D 0;
> +	time_t now;
>=20
> 	err =3D ext2fs_read_inode(fs, ino, &inode);
> 	if (err) {
> @@ -287,8 +288,10 @@ static errcode_t quota_inode_init_new(ext2_filsys =
fs, ext2_ino_t ino)
>=20
> 	memset(&inode, 0, sizeof(struct ext2_inode));
> 	ext2fs_iblk_set(fs, &inode, 0);
> -	inode.i_atime =3D inode.i_mtime =3D
> -		inode.i_ctime =3D fs->now ? fs->now : time(0);
> +	now =3D fs->now ? fs->now : time(0);
> +	ext2fs_inode_xtime_set(&inode, i_atime, now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, now);
> 	inode.i_links_count =3D 1;
> 	inode.i_mode =3D LINUX_S_IFREG | 0600;
> 	inode.i_flags |=3D EXT2_IMMUTABLE_FL;
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index a3a34cd9..28f478c0 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -125,9 +125,9 @@ static errcode_t set_inode_extra(ext2_filsys fs, =
ext2_ino_t ino,
> 	inode.i_gid =3D st->st_gid;
> 	ext2fs_set_i_gid_high(inode, st->st_gid >> 16);
> 	inode.i_mode =3D (LINUX_S_IFMT & inode.i_mode) | (~S_IFMT & =
st->st_mode);
> -	inode.i_atime =3D st->st_atime;
> -	inode.i_mtime =3D st->st_mtime;
> -	inode.i_ctime =3D st->st_ctime;
> +	ext2fs_inode_xtime_set(&inode, i_atime, st->st_atime);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, st->st_ctime);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, st->st_mtime);
>=20
> 	retval =3D ext2fs_write_inode(fs, ino, &inode);
> 	if (retval)
> @@ -256,6 +256,7 @@ errcode_t do_mknod_internal(ext2_filsys fs, =
ext2_ino_t cwd, const char *name,
> 	struct ext2_inode	inode;
> 	unsigned long		devmajor, devminor, mode;
> 	int			filetype;
> +	time_t			now;
>=20
> 	switch(st_mode & S_IFMT) {
> 	case S_IFCHR:
> @@ -309,8 +310,10 @@ errcode_t do_mknod_internal(ext2_filsys fs, =
ext2_ino_t cwd, const char *name,
> 	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
> 	memset(&inode, 0, sizeof(inode));
> 	inode.i_mode =3D mode;
> -	inode.i_atime =3D inode.i_ctime =3D inode.i_mtime =3D
> -		fs->now ? fs->now : time(0);
> +	now =3D fs->now ? fs->now : time(0);
> +	ext2fs_inode_xtime_set(&inode, i_atime, now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, now);
>=20
> 	if (filetype !=3D S_IFIFO) {
> 		devmajor =3D major(st_rdev);
> @@ -631,6 +634,7 @@ errcode_t do_write_internal(ext2_filsys fs, =
ext2_ino_t cwd, const char *src,
> 	errcode_t	retval;
> 	struct ext2_inode inode;
> 	char		*cp;
> +	time_t		now;
>=20
> 	fd =3D ext2fs_open_file(src, O_RDONLY, 0);
> 	if (fd < 0) {
> @@ -684,8 +688,10 @@ errcode_t do_write_internal(ext2_filsys fs, =
ext2_ino_t cwd, const char *src,
> 	ext2fs_inode_alloc_stats2(fs, newfile, +1, 0);
> 	memset(&inode, 0, sizeof(inode));
> 	inode.i_mode =3D (statbuf.st_mode & ~S_IFMT) | LINUX_S_IFREG;
> -	inode.i_atime =3D inode.i_ctime =3D inode.i_mtime =3D
> -		fs->now ? fs->now : time(0);
> +	now =3D fs->now ? fs->now : time(0);
> +	ext2fs_inode_xtime_set(&inode, i_atime, now);
> +	ext2fs_inode_xtime_set(&inode, i_ctime, now);
> +	ext2fs_inode_xtime_set(&inode, i_mtime, now);
> 	inode.i_links_count =3D 1;
> 	retval =3D ext2fs_inode_size_set(fs, &inode, statbuf.st_size);
> 	if (retval)
> diff --git a/misc/e2undo.c b/misc/e2undo.c
> index bc78fb2e..4cbf8884 100644
> --- a/misc/e2undo.c
> +++ b/misc/e2undo.c
> @@ -154,9 +154,11 @@ static void print_undo_mismatch(struct =
ext2_super_block *fs_super,
> 	if (memcmp(fs_super->s_uuid, undo_super->s_uuid,
> 		   sizeof(fs_super->s_uuid)))
> 		printf("%s", _("UUID does not match.\n"));
> -	if (fs_super->s_mtime !=3D undo_super->s_mtime)
> +	if (ext2fs_get_tstamp(fs_super, s_mtime) !=3D
> +	    ext2fs_get_tstamp(undo_super, s_mtime))
> 		printf("%s", _("Last mount time does not match.\n"));
> -	if (fs_super->s_wtime !=3D undo_super->s_wtime)
> +	if (ext2fs_get_tstamp(fs_super, s_wtime) !=3D
> +	    ext2fs_get_tstamp(undo_super, s_wtime))
> 		printf("%s", _("Last write time does not match.\n"));
> 	if (fs_super->s_kbytes_written !=3D =
undo_super->s_kbytes_written)
> 		printf("%s", _("Lifetime write counter does not =
match.\n"));
> diff --git a/misc/findsuper.c b/misc/findsuper.c
> index 7e78c1fc..1f5c3e72 100644
> --- a/misc/findsuper.c
> +++ b/misc/findsuper.c
> @@ -230,10 +230,9 @@ int main(int argc, char *argv[])
> 			WHY("free_inodes_count > inodes_count (%u > =
%u)\n",
> 			    ext2.s_free_inodes_count, =
ext2.s_inodes_count);
>=20
> -		if (ext2.s_mkfs_time !=3D 0)
> -			tm =3D ext2.s_mkfs_time;
> -		else
> -			tm =3D ext2.s_mtime;
> +		tm =3D ext2fs_get_tstamp(ext2, s_mkfs_time);
> +		if (tm =3D=3D 0)
> +			tm =3D ext2fs_get_tstamp(ext2, s_mtime);
> 		s =3D ctime(&tm);
> 		s[24] =3D 0;
> 		bsize =3D 1 << (ext2.s_log_block_size + 10);
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index 0dc77ead..4133e060 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -746,7 +746,7 @@ static void *op_init(struct fuse_conn_info *conn)
> #endif
> 	if (fs->flags & EXT2_FLAG_RW) {
> 		fs->super->s_mnt_count++;
> -		fs->super->s_mtime =3D time(NULL);
> +		ext2fs_set_tstamp(fs->super, s_mtime, time(NULL));
> 		fs->super->s_state &=3D ~EXT2_VALID_FS;
> 		ext2fs_mark_super_dirty(fs);
> 		err =3D ext2fs_flush2(fs, 0);
> @@ -3984,14 +3984,14 @@ no_translation:
>=20
> 	/* Make a note in the error log */
> 	get_now(&now);
> -	fs->super->s_last_error_time =3D now.tv_sec;
> +	ext2fs_set_tstamp(fs->super, s_last_error_time, now.tv_sec);
> 	fs->super->s_last_error_ino =3D ino;
> 	fs->super->s_last_error_line =3D line;
> 	fs->super->s_last_error_block =3D err; /* Yeah... */
> 	strncpy((char *)fs->super->s_last_error_func, file,
> 		sizeof(fs->super->s_last_error_func));
> -	if (fs->super->s_first_error_time =3D=3D 0) {
> -		fs->super->s_first_error_time =3D now.tv_sec;
> +	if (ext2fs_get_tstamp(fs->super, s_first_error_time) =3D=3D 0) {
> +		ext2fs_set_tstamp(fs->super, s_first_error_time, =
now.tv_sec);
> 		fs->super->s_first_error_ino =3D ino;
> 		fs->super->s_first_error_line =3D line;
> 		fs->super->s_first_error_block =3D err;
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 458f7cf6..52b0aa53 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -466,7 +466,8 @@ static int check_fsck_needed(ext2_filsys fs, const =
char *prompt)
> 	/* Refuse to modify anything but a freshly checked valid =
filesystem. */
> 	if (!(fs->super->s_state & EXT2_VALID_FS) ||
> 	    (fs->super->s_state & EXT2_ERROR_FS) ||
> -	    (fs->super->s_lastcheck < fs->super->s_mtime)) {
> +	    (ext2fs_get_tstamp(fs->super, s_lastcheck) <
> +	     ext2fs_get_tstamp(fs->super, s_mtime))) {
> 		puts(_(fsck_explain));
> 		puts(_(please_fsck));
> 		if (mount_flags & EXT2_MF_READONLY)
> @@ -520,7 +521,8 @@ static void convert_64bit(ext2_filsys fs, int =
direction)
> 	if (!fsck_requested &&
> 	    ((fs->super->s_state & EXT2_ERROR_FS) ||
> 	     !(fs->super->s_state & EXT2_VALID_FS) ||
> -	     fs->super->s_lastcheck < fs->super->s_mtime))
> +	     ext2fs_get_tstamp(fs->super, s_lastcheck) <
> +	     ext2fs_get_tstamp(fs->super, s_mtime)))
> 		request_fsck_afterwards(fs);
> 	if (fsck_requested)
> 		fprintf(stderr, _("After running e2fsck, please run =
`resize2fs %s %s"),
> --
> 2.25.1
>=20


Cheers, Andreas






--Apple-Mail=_9A5BAB6C-6F73-4707-9F90-165C1A5FA38A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYLJ1QACgkQcqXauRfM
H+ArGw//f+XcCSbha3qRuRIviehVekXBrg09Il8yoqRNlZPE9QyPJ6cUlGCcJUPT
kYADe8j7Gis7VIHO5O8pyEZxK/oiceJf3gmbkbQzxl5AwjqiJmraIEES615upBaT
iCjgIRPY85uYUQ4P4LTagxI1GDHiZzf7DTs/IWbHFzS6yHpDkDpP5sMimWcx5H9J
qOKVDDPjgaWg1fb5Fo1hg5ErPXvi5iU250RWtWWyeJXSBXI7QSE2PINHF+cBiEk4
LD70JnUgt0cbXAqT84Xil9ozV/C6Sg2GG/ac+l3CH79+LJVtA7xWoQWcwGOPyjWT
k1kw2aNJLptxw9vcXZD8uYUDfn7Xb1WG7qanbq0AZJRSkbmVOlcyMLHSYZMi9yJX
Le8+kI4L/PT15ATC+b1PbLcZEFCcjV/+3sWTpWiid1MCLDrOyhIrdyEWsMTVoDAz
o92bqvHIxuv92zOXXaOvtuJzC+Sbo0sudWiP85EZK7bWjhZPVNwST/Bar54Fd6nx
MlgSlPEOkBZhfqYdsa8kZ2OVGzLkXZLDmCwJP3JFvUxlbdclwsbbQM4baieZ9+6Q
MN58pTvjZupgUf+Kobm+3g80zDcZIgWOinIK0hT4iO9kQzDXMcvtjqzIE8Raf27f
yyXrp4/a2agW0I0RYvOCN2FOFVzclGI1dp67e07q7/fCi3zLlQc=
=tsw+
-----END PGP SIGNATURE-----

--Apple-Mail=_9A5BAB6C-6F73-4707-9F90-165C1A5FA38A--


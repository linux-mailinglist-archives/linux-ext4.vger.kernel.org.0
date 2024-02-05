Return-Path: <linux-ext4+bounces-1122-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7484A91F
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 23:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C0D1C27CBF
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B071DA52;
	Mon,  5 Feb 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="V8iRoTdT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301A4BAAA
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171484; cv=none; b=B8WQWeK6f3EGpIrNwBTQngI25jQsdDMaULbbF6drGsXE68lhQWxdA/jUATt0mC53yl5Cx4nHzS0kSoBQh/t7AGYji+qyKQmJriv3+SNlcTMGiCGC35U16QuJVsTQAABbv4Hhpry3rltvyqTX+2h2LTCKLQKFjNXvPDObkW763mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171484; c=relaxed/simple;
	bh=WFirQiv/bif0ORcBDskVBLI31abXA7X4de7fsW5AqyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnZu14kVQH/eBKd4AIgN5kCk87ti+0ZoDxoatY4aoqolpPWi0a1MAWy2IYTjyj/HHt/8RKOermrvoj85o9Glbf/2UdaACNEdKOyIqrFI4H16G0HHWNWkeEJBKt3ykJUr2SCkLut9lTgRE02+s4qtMs7LiBe+ApFiwJuL9QBc0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=V8iRoTdT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7881b1843so43923515ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 05 Feb 2024 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707171482; x=1707776282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ2KX6PtmVgxF5myahHQmzeyx34uFsn54JKIPJOPSpQ=;
        b=V8iRoTdTMUO1v76w5YIHp3hWgXPOLsK29pk1c4BMkXiQN2bAdsfgsmtkbQR+mZokXx
         9dcy48l0wmpecdAfa1JPnGt2sdOdbXDnTK/GLxyxor/G3HYrVcbPJF2L43Yn5Cbqw6sq
         FC6VEqFOvOdkZmaZksrEUlNrnULcqL/lBxRSmqKD9nqc1+xcDyeaAJ0OKV3qvC+Y/kyb
         O208mg75XQFaQMJd4QzqSSHptgcy6O0CmZo1zHo1OErnm667MCTzHno2yUcGHxNF3Owi
         MNsOySirEtorWUMCv3ccYgKy9IUfHuZqJdJCuPCBFy45jeFL2OiE8D1Lfcf84t7eDrnq
         CgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171482; x=1707776282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQ2KX6PtmVgxF5myahHQmzeyx34uFsn54JKIPJOPSpQ=;
        b=iZ7T+jRXjhZUMgS2bB1SQpB/3xy3tZmKNKk42UigzekwWmCvX5q+KNk22zH4w2IV18
         QbfGOznDgez9hwZ2Rb7Ndv1zHw04ZCvwfzigIdTKsX0bFht53Wrfdd6402iQ90Wi1MUi
         iLVNG6kD5R2VcseWQc40dIISO7HVRR4+Og2RrRH6oEAYINxOiohwLjVORwSEj5FKZVbK
         AfCPwKUnXFqSI0GmlBbziFNn5MynWinpcEGonFHdTkG6HSIQlC1QTrtifuPAeCCRjYaN
         rFYPjrFMBvg3XzdK8Wm9/HuakgZRblMjULuCVrzoxaE7GqQ7gDkePA2m4HUX71pWTyaG
         fVUg==
X-Gm-Message-State: AOJu0YzlYQxEtVbCZtMlFMNQEklWCuMZWF5MHrxrg0IG4SC7Xweohpve
	LDpflW8QFt5QWc1lNVhrbMCsi7l69Qpf526tkvAAwBRk9ooaHfwThXhz556yPME=
X-Google-Smtp-Source: AGHT+IGukEyR/oTSk6uDnfCM3DsGByrIPzirka2urPJDZhACgRtMbr5HUrwSDj+XoBjd9qAvrwVMBA==
X-Received: by 2002:a17:902:ac88:b0:1d7:428f:50fd with SMTP id h8-20020a170902ac8800b001d7428f50fdmr906434plr.31.1707171482093;
        Mon, 05 Feb 2024 14:18:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU821uwUmfcCx4HStlzYkKkb4zVsnGy/9OCw3fqzMV3pdkmOcH6fejWbcoRuKEJA9x6kHl3OVFRo10vz1oQ8DrabMiV/k2fsF6ZrY3ertY6MX0BBQmKfYZJY1XVKj1F06TdPsTKwO16gabTa8v6wD9gV1799mlzzg0pEGyAltTMq3TX3ohmHxgHVwsTNBSO05Wq5T9BN/+cIjJi4XBn5lOcVfcxrafPv1hl4w9DaMRmdAnuSH7sL8Du1Sq4Nf5aq+I7fABRffRs+Bsj/LLKtv6YnTvg0hqMfeV8565M+4VOdEsP4fY3e97vf2QFc6FNoigP94GZrQs3hjEKCLWIodngZwfwUbcTL9zyaOcZ/dDkWLPn126gMdV+
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id r17-20020a170903015100b001d92f2129dasm369262plc.233.2024.02.05.14.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:18:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rX7Hq-002Z3q-0O;
	Tue, 06 Feb 2024 09:17:58 +1100
Date: Tue, 6 Feb 2024 09:17:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.or
Subject: Re: [PATCH 2/6] fs: FS_IOC_GETUUID
Message-ID: <ZcFelmKPb374aebH@dread.disaster.area>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205200529.546646-3-kent.overstreet@linux.dev>

On Mon, Feb 05, 2024 at 03:05:13PM -0500, Kent Overstreet wrote:
> Add a new generic ioctls for querying the filesystem UUID.
> 
> These are lifted versions of the ext4 ioctls, with one change: we're not
> using a flexible array member, because UUIDs will never be more than 16
> bytes.
> 
> This patch adds a generic implementation of FS_IOC_GETFSUUID, which
> reads from super_block->s_uuid; FS_IOC_SETFSUUID is left for individual
> filesystems to implement.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: linux-fsdevel@vger.kernel.or
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/ioctl.c              | 16 ++++++++++++++++
>  include/uapi/linux/fs.h | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 76cf22ac97d7..858801060408 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -763,6 +763,19 @@ static int ioctl_fssetxattr(struct file *file, void __user *argp)
>  	return err;
>  }
>  
> +static int ioctl_getfsuuid(struct file *file, void __user *argp)
> +{
> +	struct super_block *sb = file_inode(file)->i_sb;
> +
> +	if (WARN_ON(sb->s_uuid_len > sizeof(sb->s_uuid)))
> +		sb->s_uuid_len = sizeof(sb->s_uuid);

A "get"/read only ioctl should not be change superblock fields -
this is not the place for enforcing superblock filed constraints.
Make a helper function super_set_uuid(sb, uuid, uuid_len) for the
filesystems to call that does all the validity checking and then
sets the superblock fields appropriately.

> +
> +	struct fsuuid2 u = { .fsu_len = sb->s_uuid_len, };
> +	memcpy(&u.fsu_uuid[0], &sb->s_uuid, sb->s_uuid_len);

	if (!u.fsu_len)
		return -ENOENT;
	memcpy(&u.fsu_uuid[0], &sb->s_uuid, u.fsu_len);

> +
> +	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
> +}
> +
>  /*
>   * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
>   * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
> @@ -845,6 +858,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  	case FS_IOC_FSSETXATTR:
>  		return ioctl_fssetxattr(filp, argp);
>  
> +	case FS_IOC_GETFSUUID:
> +		return ioctl_getfsuuid(filp, argp);
> +
>  	default:
>  		if (S_ISREG(inode->i_mode))
>  			return file_ioctl(filp, cmd, argp);
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 48ad69f7722e..0389fea87db5 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,20 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/*
> + * We include a length field because some filesystems (vfat) have an identifier
> + * that we do want to expose as a UUID, but doesn't have the standard length.
> + *
> + * We use a fixed size buffer beacuse this interface will, by fiat, never
> + * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
> + * users to have to deal with that.
> + */
> +struct fsuuid2 {
> +	__u32       fsu_len;
> +	__u32       fsu_flags;
> +	__u8        fsu_uuid[16];
> +};

Nobody in userspace will care that this is "version 2" of the ext4
ioctl. I'd just name it "fs_uuid" as though the ext4 version didn't
ever exist.

> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -215,6 +229,8 @@ struct fsxattr {
>  #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
>  #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
> +#define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
> +#define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)

0x94 is the btrfs ioctl space, not the VFS space - why did you
choose that? That said, what is the VFS ioctl space identifier? 'v',
perhaps?

-Dave.

-- 
Dave Chinner
david@fromorbit.com


Return-Path: <linux-ext4+bounces-9939-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C422B53EC1
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 00:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E107E3B6BB1
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33A2F3630;
	Thu, 11 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZsAGazQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F126981E;
	Thu, 11 Sep 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630420; cv=none; b=CpbYluk8hp77caIZyoW1/YowiX+0+pnFlhQDM/QdtTFwkkoOMZC1J0vlnLq+eHOEhcO8Jy6/ksjN+jQBk4AFPOEps7HHfjWwgn1aZc5bvZC7tkRRxSSnh+ceubXDhKvO/fuF56PPuaA2TQn+OLdmqduEYwrRb3CBfIgeXjSqEWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630420; c=relaxed/simple;
	bh=d8nu5ee3Fspe1B47+uyB6cB1jzIuQHMCyMAGzZKpC6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSo0jC8C+/ML3tvz2vCXzVOgxWVRHrC9yqoNGqOqAH43Xi2Jg7N3F32I50j3/Cmg4Qlro0KVLVubPqiESM/oAVk3IMb0RuGLG/Dz+0bH25K94SLuuttceKXKu5lprExRy4GdyrYqzzVwkvbAlyio2LQr5fwo4E43cQm2rTAZlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZsAGazQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB7FC4CEF0;
	Thu, 11 Sep 2025 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757630419;
	bh=d8nu5ee3Fspe1B47+uyB6cB1jzIuQHMCyMAGzZKpC6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZsAGazQvisriDSMxeDFUgx2YLf8/mdc5PNk2z/241wpiOp1WRXP/yJijfZKJeV40
	 gxlzyY0wlglXjZef4P36qaZAgnasTgrjqW+CzQoO3l5YmOrcTeeIxnNs0YA7N/l3/I
	 pgAt+Zl+qkAimUegZGivmEhurid+y5CXoCp8AEiD/BGOEQDiQdlAPoWQ0/kCgL/4aA
	 u7Wv/VlVeVyE/fOrU0MgGv9EvvNZJDJvo6zeJl9HAdCW0yR9WLJwF8lwMd2A56VM/B
	 F9Qml7JA7edZfuKNHe9CFZz2X0UNF8h0dZYvnPNTlgDueF59oGPDqir+dxflPttSjf
	 tm3KPnaLI9SPA==
Date: Thu, 11 Sep 2025 15:40:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: implemet new ioctls to set and get superblock
 parameters
Message-ID: <20250911224019.GE8084@frogsfrogsfrogs>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
 <20250908-tune2fs-v1-3-e3a6929f3355@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-tune2fs-v1-3-e3a6929f3355@mit.edu>

On Mon, Sep 08, 2025 at 11:15:50PM -0400, Theodore Ts'o via B4 Relay wrote:
> From: Theodore Ts'o <tytso@mit.edu>
> 
> Implement the EXT4_IOC_GET_TUNE_SB_PARAM and
> EXT4_IOC_SET_TUNE_SB_PARAM ioctls, which allow certains superblock
> parameters to be set while the file system is mounted, without needing
> write access to the block device.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/ioctl.c           | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/ext4.h |  75 ++++++++++++++++++++++
>  2 files changed, 324 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 84e3c73952d72e436429489f5fc8b7ae1c01c7a1..569c98c962af63130c0119f60788a26a2807bd86 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -27,14 +27,16 @@
>  #include "fsmap.h"
>  #include <trace/events/ext4.h>
>  
> -typedef void ext4_update_sb_callback(struct ext4_super_block *es,
> -				       const void *arg);
> +typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
> +				     struct ext4_super_block *es,
> +				     const void *arg);
>  
>  /*
>   * Superblock modification callback function for changing file system
>   * label
>   */
> -static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
> +static void ext4_sb_setlabel(struct ext4_sb_info *sbi,
> +			     struct ext4_super_block *es, const void *arg)
>  {
>  	/* Sanity check, this should never happen */
>  	BUILD_BUG_ON(sizeof(es->s_volume_name) < EXT4_LABEL_MAX);
> @@ -46,7 +48,8 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
>   * Superblock modification callback function for changing file system
>   * UUID.
>   */
> -static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
> +static void ext4_sb_setuuid(struct ext4_sb_info *sbi,
> +			    struct ext4_super_block *es, const void *arg)
>  {
>  	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
>  }
> @@ -71,7 +74,7 @@ int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
>  		goto out_err;
>  
>  	lock_buffer(bh);
> -	func(es, arg);
> +	func(sbi, es, arg);
>  	ext4_superblock_csum_set(sb);
>  	unlock_buffer(bh);
>  
> @@ -149,7 +152,7 @@ static int ext4_update_backup_sb(struct super_block *sb,
>  		unlock_buffer(bh);
>  		goto out_bh;
>  	}
> -	func(es, arg);
> +	func(EXT4_SB(sb), es, arg);
>  	if (ext4_has_feature_metadata_csum(sb))
>  		es->s_checksum = ext4_superblock_csum(es);
>  	set_buffer_uptodate(bh);
> @@ -1230,6 +1233,239 @@ static int ext4_ioctl_setuuid(struct file *filp,
>  	return ret;
>  }
>  
> +
> +#define TUNE_OPS_SUPPORTED (EXT4_TUNE_FL_ERRORS_BEHAVIOR |    \
> +	EXT4_TUNE_FL_MNT_COUNT | EXT4_TUNE_FL_MAX_MNT_COUNT | \
> +	EXT4_TUNE_FL_CHECKINTRVAL | EXT4_TUNE_FL_LAST_CHECK_TIME | \
> +	EXT4_TUNE_FL_RESERVED_BLOCKS | EXT4_TUNE_FL_RESERVED_UID | \
> +	EXT4_TUNE_FL_RESERVED_GID | EXT4_TUNE_FL_DEFAULT_MNT_OPTS | \
> +	EXT4_TUNE_FL_DEF_HASH_ALG | EXT4_TUNE_FL_RAID_STRIDE | \
> +	EXT4_TUNE_FL_RAID_STRIPE_WIDTH | EXT4_TUNE_FL_MOUNT_OPTS | \
> +	EXT4_TUNE_FL_FEATURES | EXT4_TUNE_FL_EDIT_FEATURES | \
> +	EXT4_TUNE_FL_FORCE_FSCK)
> +
> +static int ext4_ioctl_get_tune_sb(struct ext4_sb_info *sbi,
> +				  struct ext4_tune_sb_params __user *params)
> +{
> +	struct ext4_tune_sb_params ret;
> +	struct ext4_super_block *es = sbi->s_es;
> +
> +	memset(&ret, 0, sizeof(ret));
> +	ret.set_flags = TUNE_OPS_SUPPORTED;
> +	ret.errors_behavior = es->s_errors;
> +	ret.mnt_count = le16_to_cpu(es->s_mnt_count);
> +	ret.max_mnt_count = le16_to_cpu(es->s_max_mnt_count);
> +	ret.checkinterval = le32_to_cpu(es->s_checkinterval);
> +	ret.last_check_time = le32_to_cpu(es->s_lastcheck);
> +	ret.reserved_blocks = ext4_r_blocks_count(es);
> +	ret.blocks_count = ext4_blocks_count(es);
> +	ret.reserved_uid = ext4_get_resuid(es);
> +	ret.reserved_gid = ext4_get_resgid(es);
> +	ret.default_mnt_opts = le32_to_cpu(es->s_default_mount_opts);
> +	ret.def_hash_alg = es->s_def_hash_version;
> +	ret.raid_stride = le16_to_cpu(es->s_raid_stride);
> +	ret.raid_stripe_width = le16_to_cpu(es->s_raid_stripe_width);
> +	strscpy_pad(ret.mount_opts, es->s_mount_opts);
> +	ret.feature_compat = le32_to_cpu(es->s_feature_compat);
> +	ret.feature_incompat = le32_to_cpu(es->s_feature_incompat);
> +	ret.feature_ro_compat = le32_to_cpu(es->s_feature_ro_compat);
> +	ret.set_feature_compat_mask = EXT4_TUNE_SET_COMPAT_SUPP;
> +	ret.set_feature_incompat_mask = EXT4_TUNE_SET_INCOMPAT_SUPP;
> +	ret.set_feature_ro_compat_mask = EXT4_TUNE_SET_RO_COMPAT_SUPP;
> +	ret.clear_feature_compat_mask = EXT4_TUNE_CLEAR_COMPAT_SUPP;
> +	ret.clear_feature_incompat_mask = EXT4_TUNE_CLEAR_INCOMPAT_SUPP;
> +	ret.clear_feature_ro_compat_mask = EXT4_TUNE_CLEAR_RO_COMPAT_SUPP;
> +	if (copy_to_user(params, &ret, sizeof(ret)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static void ext4_sb_setparams(struct ext4_sb_info *sbi,
> +			      struct ext4_super_block *es, const void *arg)
> +{
> +	const struct ext4_tune_sb_params *params = arg;
> +
> +	if (params->set_flags & EXT4_TUNE_FL_ERRORS_BEHAVIOR)
> +		es->s_errors = cpu_to_le16(params->errors_behavior);
> +	if (params->set_flags & EXT4_TUNE_FL_MNT_COUNT)
> +		es->s_mnt_count = cpu_to_le16(params->mnt_count);
> +	if (params->set_flags & EXT4_TUNE_FL_MAX_MNT_COUNT)
> +		es->s_max_mnt_count = cpu_to_le16(params->max_mnt_count);
> +	if (params->set_flags & EXT4_TUNE_FL_CHECKINTRVAL)
> +		es->s_checkinterval = cpu_to_le32(params->checkinterval);
> +	if (params->set_flags & EXT4_TUNE_FL_LAST_CHECK_TIME)
> +		es->s_lastcheck = cpu_to_le32(params->last_check_time);
> +	if (params->set_flags & EXT4_TUNE_FL_RESERVED_BLOCKS) {
> +		ext4_fsblk_t blk = params->reserved_blocks;
> +
> +		es->s_r_blocks_count_lo = cpu_to_le32((u32)blk);
> +		es->s_r_blocks_count_hi = cpu_to_le32(blk >> 32);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_RESERVED_UID) {
> +		int uid = params->reserved_uid;
> +
> +		es->s_def_resuid = cpu_to_le16(uid & 0xFFFF);
> +		es->s_def_resuid_hi = cpu_to_le16(uid >> 16);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_RESERVED_GID) {
> +		int gid = params->reserved_gid;
> +
> +		es->s_def_resgid = cpu_to_le16(gid & 0xFFFF);
> +		es->s_def_resgid_hi = cpu_to_le16(gid >> 16);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_DEFAULT_MNT_OPTS)
> +		es->s_default_mount_opts = cpu_to_le32(params->default_mnt_opts);
> +	if (params->set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
> +		es->s_def_hash_version = params->def_hash_alg;
> +	if (params->set_flags & EXT4_TUNE_FL_RAID_STRIDE)
> +		es->s_raid_stride = cpu_to_le16(params->raid_stride);
> +	if (params->set_flags & EXT4_TUNE_FL_RAID_STRIPE_WIDTH)
> +		es->s_raid_stripe_width =
> +			cpu_to_le16(params->raid_stripe_width);
> +	strscpy_pad(es->s_mount_opts, params->mount_opts);
> +	if (params->set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
> +		es->s_feature_compat |=
> +			cpu_to_le32(params->set_feature_compat_mask);
> +		es->s_feature_incompat |=
> +			cpu_to_le32(params->set_feature_incompat_mask);
> +		es->s_feature_ro_compat |=
> +			cpu_to_le32(params->set_feature_ro_compat_mask);
> +		es->s_feature_compat &=
> +			~cpu_to_le32(params->clear_feature_compat_mask);
> +		es->s_feature_incompat &=
> +			~cpu_to_le32(params->clear_feature_incompat_mask);
> +		es->s_feature_ro_compat &=
> +			~cpu_to_le32(params->clear_feature_ro_compat_mask);
> +		if (params->set_feature_compat_mask &
> +		    EXT4_FEATURE_COMPAT_DIR_INDEX)
> +			es->s_def_hash_version = sbi->s_def_hash_version;
> +		if (params->set_feature_incompat_mask &
> +		    EXT4_FEATURE_INCOMPAT_CSUM_SEED)
> +			es->s_checksum_seed = cpu_to_le32(sbi->s_csum_seed);
> +	}
> +	if (params->set_flags & EXT4_TUNE_FL_FORCE_FSCK)
> +		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> +}
> +
> +static int ext4_ioctl_set_tune_sb(struct file *filp,
> +				  struct ext4_tune_sb_params __user *in)
> +{
> +	struct ext4_tune_sb_params params;
> +	struct super_block *sb = file_inode(filp)->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_super_block *es = sbi->s_es;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&params, in, sizeof(params)))
> +		return -EFAULT;
> +
> +	if ((params.set_flags & ~TUNE_OPS_SUPPORTED) != 0)
> +		return -EOPNOTSUPP;
> +
> +	if ((params.set_flags & EXT4_TUNE_FL_ERRORS_BEHAVIOR) &&
> +	    (params.errors_behavior > EXT4_ERRORS_PANIC))
> +		return -EINVAL;
> +
> +	if ((params.set_flags & EXT4_TUNE_FL_RESERVED_BLOCKS) &&
> +	    (params.reserved_blocks > ext4_blocks_count(sbi->s_es) / 2))
> +		return -EINVAL;
> +	if ((params.set_flags & EXT4_TUNE_FL_DEF_HASH_ALG) &&
> +	    ((params.def_hash_alg > DX_HASH_LAST) ||
> +	     (params.def_hash_alg == DX_HASH_SIPHASH)))
> +		return -EINVAL;
> +	if ((params.set_flags & EXT4_TUNE_FL_FEATURES) &&
> +	    (params.set_flags & EXT4_TUNE_FL_EDIT_FEATURES))
> +		return -EINVAL;

What's the difference between _FL_FEATURES and _FL_EDIT_FEATURES?

> +
> +	if (params.set_flags & EXT4_TUNE_FL_FEATURES) {
> +		params.set_feature_compat_mask =
> +			params.feature_compat &
> +			~le32_to_cpu(es->s_feature_compat);
> +		params.set_feature_incompat_mask =
> +			params.feature_incompat &
> +			~le32_to_cpu(es->s_feature_incompat);
> +		params.set_feature_ro_compat_mask =
> +			params.feature_ro_compat &
> +			~le32_to_cpu(es->s_feature_ro_compat);
> +		params.clear_feature_compat_mask =
> +			~params.feature_compat &
> +			le32_to_cpu(es->s_feature_compat);
> +		params.clear_feature_incompat_mask =
> +			~params.feature_incompat &
> +			le32_to_cpu(es->s_feature_incompat);
> +		params.clear_feature_ro_compat_mask =
> +			~params.feature_ro_compat &
> +			le32_to_cpu(es->s_feature_ro_compat);
> +		params.set_flags |= EXT4_TUNE_FL_EDIT_FEATURES;
> +	}
> +	if (params.set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
> +		if ((params.set_feature_compat_mask &
> +		     ~EXT4_TUNE_SET_COMPAT_SUPP) ||
> +		    (params.set_feature_incompat_mask &
> +		     ~EXT4_TUNE_SET_INCOMPAT_SUPP) ||
> +		    (params.set_feature_ro_compat_mask &
> +		     ~EXT4_TUNE_SET_RO_COMPAT_SUPP) ||
> +		    (params.clear_feature_compat_mask &
> +		     ~EXT4_TUNE_CLEAR_COMPAT_SUPP) ||
> +		    (params.clear_feature_incompat_mask &
> +		     ~EXT4_TUNE_CLEAR_INCOMPAT_SUPP) ||
> +		    (params.clear_feature_ro_compat_mask &
> +		     ~EXT4_TUNE_CLEAR_RO_COMPAT_SUPP))
> +			return -EOPNOTSUPP;
> +
> +		/*
> +		 * Filter out the features that are already set from
> +		 * the set_mask.
> +		 */
> +		params.set_feature_compat_mask &=
> +			~le32_to_cpu(es->s_feature_compat);
> +		params.set_feature_incompat_mask &=
> +			~le32_to_cpu(es->s_feature_incompat);
> +		params.set_feature_ro_compat_mask &=
> +			~le32_to_cpu(es->s_feature_ro_compat);
> +		if ((params.set_feature_compat_mask &
> +		     EXT4_FEATURE_COMPAT_DIR_INDEX) &&
> +		    !ext4_has_feature_dir_index(sb)) {
> +			uuid_t	uu;
> +
> +			memcpy(&uu, sbi->s_hash_seed, UUID_SIZE);
> +			if (uuid_is_null(&uu))
> +				generate_random_uuid((char *)
> +						     &sbi->s_hash_seed);
> +			if (params.set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
> +				sbi->s_def_hash_version = params.def_hash_alg;
> +			else if (sbi->s_def_hash_version == 0)
> +				sbi->s_def_hash_version = DX_HASH_HALF_MD4;
> +			if (!(es->s_flags &
> +			      cpu_to_le32(EXT2_FLAGS_UNSIGNED_HASH)) &&
> +			    !(es->s_flags &
> +			      cpu_to_le32(EXT2_FLAGS_SIGNED_HASH))) {
> +#ifdef __CHAR_UNSIGNED__
> +				sbi->s_hash_unsigned = 3;
> +#else
> +				sbi->s_hash_unsigned = 0;
> +#endif
> +			}
> +		}
> +	}
> +
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	ret = ext4_update_superblocks_fn(sb, ext4_sb_setparams, &params);
> +	mnt_drop_write_file(filp);
> +
> +	if (params.set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
> +		sbi->s_def_hash_version = params.def_hash_alg;
> +
> +	return ret;
> +}
> +
>  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -1616,6 +1852,11 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
>  	case EXT4_IOC_SETFSUUID:
>  		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
> +	case EXT4_IOC_GET_TUNE_SB_PARAM:
> +		return ext4_ioctl_get_tune_sb(EXT4_SB(sb),
> +					      (void __user *)arg);
> +	case EXT4_IOC_SET_TUNE_SB_PARAM:
> +		return ext4_ioctl_set_tune_sb(filp, (void __user *)arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -1703,7 +1944,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  #endif
>  
> -static void set_overhead(struct ext4_super_block *es, const void *arg)
> +static void set_overhead(struct ext4_sb_info *sbi,
> +			 struct ext4_super_block *es, const void *arg)
>  {
>  	es->s_overhead_clusters = cpu_to_le32(*((unsigned long *) arg));
>  }
> diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> index 1c4c2dd29112cda9f7dc91d917492cffc33ee524..145875fd633772e76ce7fd8bc0fef136ff620d2d 100644
> --- a/include/uapi/linux/ext4.h
> +++ b/include/uapi/linux/ext4.h
> @@ -33,6 +33,8 @@
>  #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
>  #define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
>  #define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
> +#define EXT4_IOC_GET_TUNE_SB_PARAM	_IOR('f', 45, struct ext4_tune_sb_params)
> +#define EXT4_IOC_SET_TUNE_SB_PARAM	_IOW('f', 46, struct ext4_tune_sb_params)
>  
>  #define EXT4_IOC_SHUTDOWN _IOR('X', 125, __u32)
>  
> @@ -108,6 +110,79 @@ struct ext4_new_group_input {
>  	__u16 unused;
>  };
>  
> +struct ext4_tune_sb_params {
> +	__u32 set_flags;
> +	__u32 checkinterval;
> +	__u16 errors_behavior;
> +	__u16 mnt_count;
> +	__u16 max_mnt_count;
> +	__u16 raid_stride;
> +	__u64 last_check_time;
> +	__u64 reserved_blocks;
> +	__u64 blocks_count;
> +	__u32 default_mnt_opts;
> +	__u32 reserved_uid;
> +	__u32 reserved_gid;
> +	__u32 raid_stripe_width;
> +	__u8  def_hash_alg;
> +	__u8  pad_1;
> +	__u16 pad_2;
> +	__u32 feature_compat;
> +	__u32 feature_incompat;
> +	__u32 feature_ro_compat;
> +	__u32 set_feature_compat_mask;
> +	__u32 set_feature_incompat_mask;
> +	__u32 set_feature_ro_compat_mask;
> +	__u32 clear_feature_compat_mask;
> +	__u32 clear_feature_incompat_mask;
> +	__u32 clear_feature_ro_compat_mask;
> +	__u8  mount_opts[64];
> +	__u8  pad[64];
> +};
> +
> +#define EXT4_TUNE_FL_ERRORS_BEHAVIOR	0x00000001
> +#define EXT4_TUNE_FL_MNT_COUNT		0x00000002
> +#define EXT4_TUNE_FL_MAX_MNT_COUNT	0x00000004
> +#define EXT4_TUNE_FL_CHECKINTRVAL	0x00000008
> +#define EXT4_TUNE_FL_LAST_CHECK_TIME	0x00000010
> +#define EXT4_TUNE_FL_RESERVED_BLOCKS	0x00000020
> +#define EXT4_TUNE_FL_RESERVED_UID	0x00000040
> +#define EXT4_TUNE_FL_RESERVED_GID	0x00000080
> +#define EXT4_TUNE_FL_DEFAULT_MNT_OPTS	0x00000100
> +#define EXT4_TUNE_FL_DEF_HASH_ALG	0x00000200
> +#define EXT4_TUNE_FL_RAID_STRIDE	0x00000400
> +#define EXT4_TUNE_FL_RAID_STRIPE_WIDTH	0x00000800
> +#define EXT4_TUNE_FL_MOUNT_OPTS		0x00001000
> +#define EXT4_TUNE_FL_FEATURES		0x00002000
> +#define EXT4_TUNE_FL_EDIT_FEATURES	0x00004000
> +#define EXT4_TUNE_FL_FORCE_FSCK		0x00008000
> +
> +#define EXT4_TUNE_SET_COMPAT_SUPP \
> +		(EXT4_FEATURE_COMPAT_DIR_INDEX |	\
> +		 EXT4_FEATURE_COMPAT_STABLE_INODES)
> +#define EXT4_TUNE_SET_INCOMPAT_SUPP \
> +		(EXT4_FEATURE_INCOMPAT_EXTENTS |	\
> +		 EXT4_FEATURE_INCOMPAT_EA_INODE |	\
> +		 EXT4_FEATURE_INCOMPAT_ENCRYPT |	\
> +		 EXT4_FEATURE_INCOMPAT_CSUM_SEED |	\
> +		 EXT4_FEATURE_INCOMPAT_LARGEDIR |	\
> +		 EXT4_FEATURE_INCOMPAT_CASEFOLD)
> +#define EXT4_TUNE_SET_RO_COMPAT_SUPP \
> +		(EXT4_FEATURE_RO_COMPAT_LARGE_FILE |	\
> +		 EXT4_FEATURE_RO_COMPAT_DIR_NLINK |	\
> +		 EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE |	\
> +		 EXT4_FEATURE_RO_COMPAT_READONLY |	\
> +		 EXT4_FEATURE_RO_COMPAT_PROJECT |	\
> +		 EXT4_FEATURE_RO_COMPAT_VERITY)
> +
> +#define EXT4_TUNE_CLEAR_COMPAT_SUPP (0)
> +#define EXT4_TUNE_CLEAR_INCOMPAT_SUPP (0)
> +#define EXT4_TUNE_CLEAR_RO_COMPAT_SUPP \
> +		(EXT4_FEATURE_RO_COMPAT_LARGE_FILE |	\
> +		 EXT4_FEATURE_RO_COMPAT_DIR_NLINK |	\
> +		 EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE |	\
> +		 EXT4_FEATURE_RO_COMPAT_PROJECT)

Is it actually safe to clear these without scanning the filesystem to
make sure nobody's using these features?

--D

> +
>  /*
>   * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
>   * It indicates that the entry in extent status cache is for a hole.
> 
> -- 
> 2.51.0
> 
> 
> 


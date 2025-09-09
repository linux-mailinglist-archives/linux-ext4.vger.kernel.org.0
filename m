Return-Path: <linux-ext4+bounces-9888-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E4EB50843
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 23:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C11C65F7A
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733E25DB12;
	Tue,  9 Sep 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckvViJoz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72725BEE1;
	Tue,  9 Sep 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453757; cv=none; b=pdSDK3tGxEJo/AxKg79MDx54B0/BifQ37KftOjrtoCipZ9gJDnlT4xtON1eVVsz7Kqi/8KRHl02KNpwcrWCTGoJiGyvGlApEwfWPBe15ruPNgq4xnDEILlESJ25ZmKnkFZixH1Pwbm4iPiUZEaLPM8xMp8f8PuM8aCSfpI9pglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453757; c=relaxed/simple;
	bh=2OTS+ua7rMNOu5Df4jtgr4d8L0MqVspsqk5UtTTNm+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqBZXbINO1KEpyIumVXiXInQcDjWAY8IX7YaZYmCqriHNz6K75uZmkmlUVttOUsD9fgxrZYhPOrwfnSRCF8p1+aqlFBKKgPJwNsJd9v9SrVeXvZW4f3hdG6RpZ8ZhAbVN/47fUy84J/96R2eIEYj1f1nk+UJLHE8lplV143hLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckvViJoz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757453756; x=1788989756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2OTS+ua7rMNOu5Df4jtgr4d8L0MqVspsqk5UtTTNm+4=;
  b=ckvViJozYbcXAxxbymDYHxEyFD7r6ZqpD+oKyi0SI+sta26a9+KR/z31
   mbXQYPC1NoXkXCHmLH1E5TpN7bfy/1gAI2qq5Eo5h7qJxzO24SQFuidb5
   gU+u/cRUXLw0Edpam+d/c638/8c1fF7Gv0NwI2S+WLx6egvffmdNLfibZ
   OGtmO+QHpitVgfO1TN0CCPGxporydj/JNKmoEDZRJLgyZoMbfGnqLOXBw
   w8akWXHf4oFIq+tL2R5JFHyTJvt0I8bmy5ryzMRqC8OKAErZx4+HLHycl
   efqsk8+ltdL6J5nmYjh0KQ7Qq/wBiYLaKYcyvhuqXDGB7M32QGj6KfHfv
   Q==;
X-CSE-ConnectionGUID: XtU1UZqtQi2gp5hxka3y1Q==
X-CSE-MsgGUID: +zjgkKdnS2OgMJhjSE8e5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77209122"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="77209122"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 14:35:55 -0700
X-CSE-ConnectionGUID: CapBtIuERgin93rWMG9zLw==
X-CSE-MsgGUID: 28T1J/9MQgywb27lt7SnrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173995438"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2025 14:33:42 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uw5y7-0005Ix-2T;
	Tue, 09 Sep 2025 21:33:39 +0000
Date: Wed, 10 Sep 2025 05:33:07 +0800
From: kernel test robot <lkp@intel.com>
To: Theodore Ts'o via B4 Relay <devnull+tytso.mit.edu@kernel.org>,
	tytso@mit.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: implemet new ioctls to set and get superblock
 parameters
Message-ID: <202509100550.fj5qrPH5-lkp@intel.com>
References: <20250908-tune2fs-v1-3-e3a6929f3355@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-tune2fs-v1-3-e3a6929f3355@mit.edu>

Hi Theodore,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b320789d6883cc00ac78ce83bccbfe7ed58afcf0]

url:    https://github.com/intel-lab-lkp/linux/commits/Theodore-Ts-o-via-B4-Relay/ext4-avoid-potential-buffer-over-read-in-parse_apply_sb_mount_options/20250909-111746
base:   b320789d6883cc00ac78ce83bccbfe7ed58afcf0
patch link:    https://lore.kernel.org/r/20250908-tune2fs-v1-3-e3a6929f3355%40mit.edu
patch subject: [PATCH 3/3] ext4: implemet new ioctls to set and get superblock parameters
config: csky-randconfig-r123-20250910 (https://download.01.org/0day-ci/archive/20250910/202509100550.fj5qrPH5-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250910/202509100550.fj5qrPH5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509100550.fj5qrPH5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ext4/ioctl.c:1255:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] errors_behavior @@     got restricted __le16 [usertype] s_errors @@
   fs/ext4/ioctl.c:1255:29: sparse:     expected unsigned short [addressable] [assigned] [usertype] errors_behavior
   fs/ext4/ioctl.c:1255:29: sparse:     got restricted __le16 [usertype] s_errors
>> fs/ext4/ioctl.c:1267:33: sparse: sparse: cast to restricted __le16
>> fs/ext4/ioctl.c:1267:33: sparse: sparse: cast from restricted __le32
>> fs/ext4/ioctl.c:1323:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] s_raid_stripe_width @@     got restricted __le16 [usertype] @@
   fs/ext4/ioctl.c:1323:41: sparse:     expected restricted __le32 [usertype] s_raid_stripe_width
   fs/ext4/ioctl.c:1323:41: sparse:     got restricted __le16 [usertype]
   fs/ext4/ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: asm output is not an lvalue
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: asm output is not an lvalue
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: cast removes address space '__user' of expression
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: generating address of non-lvalue (11)
   arch/csky/include/asm/uaccess.h:110:17: sparse: sparse: generating address of non-lvalue (11)

vim +1255 fs/ext4/ioctl.c

  1235	
  1236	
  1237	#define TUNE_OPS_SUPPORTED (EXT4_TUNE_FL_ERRORS_BEHAVIOR |    \
  1238		EXT4_TUNE_FL_MNT_COUNT | EXT4_TUNE_FL_MAX_MNT_COUNT | \
  1239		EXT4_TUNE_FL_CHECKINTRVAL | EXT4_TUNE_FL_LAST_CHECK_TIME | \
  1240		EXT4_TUNE_FL_RESERVED_BLOCKS | EXT4_TUNE_FL_RESERVED_UID | \
  1241		EXT4_TUNE_FL_RESERVED_GID | EXT4_TUNE_FL_DEFAULT_MNT_OPTS | \
  1242		EXT4_TUNE_FL_DEF_HASH_ALG | EXT4_TUNE_FL_RAID_STRIDE | \
  1243		EXT4_TUNE_FL_RAID_STRIPE_WIDTH | EXT4_TUNE_FL_MOUNT_OPTS | \
  1244		EXT4_TUNE_FL_FEATURES | EXT4_TUNE_FL_EDIT_FEATURES | \
  1245		EXT4_TUNE_FL_FORCE_FSCK)
  1246	
  1247	static int ext4_ioctl_get_tune_sb(struct ext4_sb_info *sbi,
  1248					  struct ext4_tune_sb_params __user *params)
  1249	{
  1250		struct ext4_tune_sb_params ret;
  1251		struct ext4_super_block *es = sbi->s_es;
  1252	
  1253		memset(&ret, 0, sizeof(ret));
  1254		ret.set_flags = TUNE_OPS_SUPPORTED;
> 1255		ret.errors_behavior = es->s_errors;
  1256		ret.mnt_count = le16_to_cpu(es->s_mnt_count);
  1257		ret.max_mnt_count = le16_to_cpu(es->s_max_mnt_count);
  1258		ret.checkinterval = le32_to_cpu(es->s_checkinterval);
  1259		ret.last_check_time = le32_to_cpu(es->s_lastcheck);
  1260		ret.reserved_blocks = ext4_r_blocks_count(es);
  1261		ret.blocks_count = ext4_blocks_count(es);
  1262		ret.reserved_uid = ext4_get_resuid(es);
  1263		ret.reserved_gid = ext4_get_resgid(es);
  1264		ret.default_mnt_opts = le32_to_cpu(es->s_default_mount_opts);
  1265		ret.def_hash_alg = es->s_def_hash_version;
  1266		ret.raid_stride = le16_to_cpu(es->s_raid_stride);
> 1267		ret.raid_stripe_width = le16_to_cpu(es->s_raid_stripe_width);
  1268		strscpy_pad(ret.mount_opts, es->s_mount_opts);
  1269		ret.feature_compat = le32_to_cpu(es->s_feature_compat);
  1270		ret.feature_incompat = le32_to_cpu(es->s_feature_incompat);
  1271		ret.feature_ro_compat = le32_to_cpu(es->s_feature_ro_compat);
  1272		ret.set_feature_compat_mask = EXT4_TUNE_SET_COMPAT_SUPP;
  1273		ret.set_feature_incompat_mask = EXT4_TUNE_SET_INCOMPAT_SUPP;
  1274		ret.set_feature_ro_compat_mask = EXT4_TUNE_SET_RO_COMPAT_SUPP;
  1275		ret.clear_feature_compat_mask = EXT4_TUNE_CLEAR_COMPAT_SUPP;
  1276		ret.clear_feature_incompat_mask = EXT4_TUNE_CLEAR_INCOMPAT_SUPP;
  1277		ret.clear_feature_ro_compat_mask = EXT4_TUNE_CLEAR_RO_COMPAT_SUPP;
  1278		if (copy_to_user(params, &ret, sizeof(ret)))
  1279			return -EFAULT;
  1280		return 0;
  1281	}
  1282	
  1283	static void ext4_sb_setparams(struct ext4_sb_info *sbi,
  1284				      struct ext4_super_block *es, const void *arg)
  1285	{
  1286		const struct ext4_tune_sb_params *params = arg;
  1287	
  1288		if (params->set_flags & EXT4_TUNE_FL_ERRORS_BEHAVIOR)
  1289			es->s_errors = cpu_to_le16(params->errors_behavior);
  1290		if (params->set_flags & EXT4_TUNE_FL_MNT_COUNT)
  1291			es->s_mnt_count = cpu_to_le16(params->mnt_count);
  1292		if (params->set_flags & EXT4_TUNE_FL_MAX_MNT_COUNT)
  1293			es->s_max_mnt_count = cpu_to_le16(params->max_mnt_count);
  1294		if (params->set_flags & EXT4_TUNE_FL_CHECKINTRVAL)
  1295			es->s_checkinterval = cpu_to_le32(params->checkinterval);
  1296		if (params->set_flags & EXT4_TUNE_FL_LAST_CHECK_TIME)
  1297			es->s_lastcheck = cpu_to_le32(params->last_check_time);
  1298		if (params->set_flags & EXT4_TUNE_FL_RESERVED_BLOCKS) {
  1299			ext4_fsblk_t blk = params->reserved_blocks;
  1300	
  1301			es->s_r_blocks_count_lo = cpu_to_le32((u32)blk);
  1302			es->s_r_blocks_count_hi = cpu_to_le32(blk >> 32);
  1303		}
  1304		if (params->set_flags & EXT4_TUNE_FL_RESERVED_UID) {
  1305			int uid = params->reserved_uid;
  1306	
  1307			es->s_def_resuid = cpu_to_le16(uid & 0xFFFF);
  1308			es->s_def_resuid_hi = cpu_to_le16(uid >> 16);
  1309		}
  1310		if (params->set_flags & EXT4_TUNE_FL_RESERVED_GID) {
  1311			int gid = params->reserved_gid;
  1312	
  1313			es->s_def_resgid = cpu_to_le16(gid & 0xFFFF);
  1314			es->s_def_resgid_hi = cpu_to_le16(gid >> 16);
  1315		}
  1316		if (params->set_flags & EXT4_TUNE_FL_DEFAULT_MNT_OPTS)
  1317			es->s_default_mount_opts = cpu_to_le32(params->default_mnt_opts);
  1318		if (params->set_flags & EXT4_TUNE_FL_DEF_HASH_ALG)
  1319			es->s_def_hash_version = params->def_hash_alg;
  1320		if (params->set_flags & EXT4_TUNE_FL_RAID_STRIDE)
  1321			es->s_raid_stride = cpu_to_le16(params->raid_stride);
  1322		if (params->set_flags & EXT4_TUNE_FL_RAID_STRIPE_WIDTH)
> 1323			es->s_raid_stripe_width =
  1324				cpu_to_le16(params->raid_stripe_width);
  1325		strscpy_pad(es->s_mount_opts, params->mount_opts);
  1326		if (params->set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
  1327			es->s_feature_compat |=
  1328				cpu_to_le32(params->set_feature_compat_mask);
  1329			es->s_feature_incompat |=
  1330				cpu_to_le32(params->set_feature_incompat_mask);
  1331			es->s_feature_ro_compat |=
  1332				cpu_to_le32(params->set_feature_ro_compat_mask);
  1333			es->s_feature_compat &=
  1334				~cpu_to_le32(params->clear_feature_compat_mask);
  1335			es->s_feature_incompat &=
  1336				~cpu_to_le32(params->clear_feature_incompat_mask);
  1337			es->s_feature_ro_compat &=
  1338				~cpu_to_le32(params->clear_feature_ro_compat_mask);
  1339			if (params->set_feature_compat_mask &
  1340			    EXT4_FEATURE_COMPAT_DIR_INDEX)
  1341				es->s_def_hash_version = sbi->s_def_hash_version;
  1342			if (params->set_feature_incompat_mask &
  1343			    EXT4_FEATURE_INCOMPAT_CSUM_SEED)
  1344				es->s_checksum_seed = cpu_to_le32(sbi->s_csum_seed);
  1345		}
  1346		if (params->set_flags & EXT4_TUNE_FL_FORCE_FSCK)
  1347			es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
  1348	}
  1349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


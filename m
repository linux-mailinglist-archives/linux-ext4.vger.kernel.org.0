Return-Path: <linux-ext4+bounces-12205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DDCA6E19
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1373175B7C
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99082329E7D;
	Fri,  5 Dec 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kll9ZZOx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9D32A3CF
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925862; cv=none; b=s84XOenpkOSXBZE/yBMcGmaGaQoHR8Zte0M0zdcqnYQgUsdaxQFDkQmurVP7QRV/PBLl1dOd5X8Vx1IQgnSxX3pXVuddslA5D2tf9djQIgoZsQR8IZ9Gwha7Rg+MrEBHGe6bQBLSsdvJOcn7a2oiVg4bhZK0zVuxU3g7T5p7jLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925862; c=relaxed/simple;
	bh=Skd53DxdHhiPnuL2cuiHMz+NR6hEM5RNHEO0cyvIt6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WXNGwwTy0AcHq6D2Lf6LBYCeA94ojtBgtPkV/ABbzm53Woi2Uzp4RpVE+/bdhzSNdDNGx6Np2AgcXeiC+ZV42sL4h8emSNZ+m0AKbVeinW350O8tZROOXM5p5ZLbNGUqWgMnPkuh46oCdsMGvjsYrd78NJa9n0mJXTQTKu/H5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kll9ZZOx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so23280655e9.2
        for <linux-ext4@vger.kernel.org>; Fri, 05 Dec 2025 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764925853; x=1765530653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhvjhQdtncVGuFWoHbJNotQHQb+6urCBIiQa0SvWTDc=;
        b=kll9ZZOxcgZcGcKnymVACTqISlCn/lMC67z+yOiRa/AmY7Ct4FBpkqpvREjFhAcib8
         r0h8M5VmFYCt/Untuk1h1l7D5u5DbJfl29mf7UZxs9YaOsn5mhBginS6q3JEBEet63A7
         +Y9iPqoMGg0aN94B88b1GdvbogvK+FLz4pIcWypvmffhZ0Bn69ARYhTV7m/3OkXiSZ1b
         WtwzI8bYY9mLvOaCkdNed+48qfRqqel2h1KS6C7PjYlt7RgggPUPr7dVN4t8+zhecyUq
         VC4clkXpmDPgy9SjXPIFPtaZpililx2N5GWQaA9pU/PtpKr2QRYbWXurONq/XTIG1iWL
         ZqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764925853; x=1765530653;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhvjhQdtncVGuFWoHbJNotQHQb+6urCBIiQa0SvWTDc=;
        b=uM4t7ufNknTrEEE5w2fstUDtBe6cWQOLf/cVouyA2YALcDmA1196DzdD2FPhaDm2Ll
         hTnBkBXlj4zMElsnS0cvwx8d83v6wr2UdqTCnJd1kF8OR+lgpu+rLjBsGi6uBSjnAFOw
         5qjBSRzoNNxJDUaYvfRiIf3MWiEVO2sPLSHgd3JGlbHjCcogjYreltbZ+Q+EbTYSY3bJ
         aG+ENMcbuIwHG32R5MbSLbAOaVE6DlSsl+1oSTb8JVibOnwR0YrLTvsiKV2IZxffeZyh
         mY9ajfAer36vSdxIiarrhaRUNsLIOdfJ5SWZEeDxIQixKNFyESwYlfr2NpEqLiQSZYCi
         cQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2EpNUlkmXSfrYZYy5g17O04cDZIcHy0Nilf2QPD960hALOnL3yEHM+dhhcZho4h2XofPS3+WOMhm5@vger.kernel.org
X-Gm-Message-State: AOJu0YxUowHDOUJbvBpLNRfYNrXlDCgf4aMx9jd2hsmIC118TFNsgXgQ
	hmSJ5XC3maVeYe9XOAvpBGg+tZJ6IkfUo6ojhR1XGvpZDcDpU6aa66ned3GowjIU4xqXnsymtF6
	YoWkR
X-Gm-Gg: ASbGncvMuZCZkVBw2AuPZLinpvNQYSgHwTbstFnqewKj61/b3JSxBn0+vl1tE41hXFp
	JVitjfkGxymX9W+MX2/SgBmKqg3yclp1ctkjizH/JA7dP4dKAIyA5KEPFR2pqSTFvwUzA1EH5Nq
	UoXsPpLOVBG+CpU2YmBwDVspb14xhEes7GQFPDDVOvoAsyNPqZs6G6yTfuiGcT/Pe/sNTNQCfWR
	wqQXSOysmXwJW91Vm7/I3zyUCeDkgSOMQf9mtHQ6sDutLBg2WkOe/XOrP6KKbKHMH/SvVOeW04n
	PsRNrDrsr0KtH+BWz07OMw1zj6mpUwl4eR1FT7ajG0y0yf6oVco4IDDVIE17yzrKF2LTUHDzh5s
	LYt0mx75mzb7bRswcFtoHt58/9BguWEAVkAeZtuBZK5aqb/56NHsuYlMsn7RThIKme9eetDWKhc
	rTPz5u0y8jIxmcm7QA
X-Google-Smtp-Source: AGHT+IHcl3I2muWycrQWdLekodvdXpiacXX0Nt+bp9XDm+LnOWNnveSI7lwUbzQak2Uc4F9iFHHbpA==
X-Received: by 2002:a05:600c:35c7:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-4792f24d432mr62721005e9.10.1764925852771;
        Fri, 05 Dec 2025 01:10:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4792afd47b3sm55186105e9.0.2025.12.05.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 01:10:52 -0800 (PST)
Date: Fri, 5 Dec 2025 12:10:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>, jack@suse.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: Re: [PATCH] ext2: factor out ext2_fill_super() teardown path
Message-ID: <202512042321.fuAOlXGn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203045048.2463502-1-vivek.balachandhar@gmail.com>

Hi Vivek,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vivek-BalachandharTN/ext2-factor-out-ext2_fill_super-teardown-path/20251203-125544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
patch link:    https://lore.kernel.org/r/20251203045048.2463502-1-vivek.balachandhar%40gmail.com
patch subject: [PATCH] ext2: factor out ext2_fill_super() teardown path
config: i386-randconfig-141-20251204 (https://download.01.org/0day-ci/archive/20251204/202512042321.fuAOlXGn-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202512042321.fuAOlXGn-lkp@intel.com/

smatch warnings:
fs/ext2/super.c:1268 ext2_fill_super() error: uninitialized symbol 'bh'.
fs/ext2/super.c:1268 ext2_fill_super() error: double free of 'bh' (line 1020)

vim +/bh +1268 fs/ext2/super.c

   890	static int ext2_fill_super(struct super_block *sb, struct fs_context *fc)
   891	{
   892		struct ext2_fs_context *ctx = fc->fs_private;
   893		int silent = fc->sb_flags & SB_SILENT;
   894		struct buffer_head * bh;
   895		struct ext2_sb_info * sbi;
   896		struct ext2_super_block * es;
   897		struct inode *root;
   898		unsigned long block;
   899		unsigned long sb_block = ctx->s_sb_block;
   900		unsigned long logic_sb_block;
   901		unsigned long offset = 0;
   902		long ret = -ENOMEM;
   903		int blocksize = BLOCK_SIZE;
   904		int db_count;
   905		int i, j;
   906		__le32 features;
   907		int err;
   908	
   909		sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
   910		if (!sbi)
   911			return -ENOMEM;
   912	
   913		sbi->s_blockgroup_lock =
   914			kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
   915		if (!sbi->s_blockgroup_lock) {
   916			kfree(sbi);
   917			return -ENOMEM;
   918		}
   919		sb->s_fs_info = sbi;
   920		sbi->s_sb_block = sb_block;
   921		sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
   922						   NULL, NULL);
   923	
   924		spin_lock_init(&sbi->s_lock);
   925		ret = -EINVAL;
   926	
   927		/*
   928		 * See what the current blocksize for the device is, and
   929		 * use that as the blocksize.  Otherwise (or if the blocksize
   930		 * is smaller than the default) use the default.
   931		 * This is important for devices that have a hardware
   932		 * sectorsize that is larger than the default.
   933		 */
   934		blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
   935		if (!blocksize) {
   936			ext2_msg(sb, KERN_ERR, "error: unable to set blocksize");
   937			goto failed_sbi;

bh uninitialized on this path, but the kbuild bot already sent a
Clang warning for that so normally I wouldn't send this but ...

   938		}
   939	
   940		/*
   941		 * If the superblock doesn't start on a hardware sector boundary,
   942		 * calculate the offset.  
   943		 */
   944		if (blocksize != BLOCK_SIZE) {
   945			logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
   946			offset = (sb_block*BLOCK_SIZE) % blocksize;
   947		} else {
   948			logic_sb_block = sb_block;
   949		}
   950	
   951		if (!(bh = sb_bread(sb, logic_sb_block))) {
   952			ext2_msg(sb, KERN_ERR, "error: unable to read superblock");
   953			goto failed_sbi;
   954		}
   955		/*
   956		 * Note: s_es must be initialized as soon as possible because
   957		 *       some ext2 macro-instructions depend on its value
   958		 */
   959		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
   960		sbi->s_es = es;
   961		sb->s_magic = le16_to_cpu(es->s_magic);
   962	
   963		if (sb->s_magic != EXT2_SUPER_MAGIC)
   964			goto cantfind_ext2;
   965	
   966		ext2_set_options(fc, sbi);
   967	
   968		sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
   969			(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
   970		sb->s_iflags |= SB_I_CGROUPWB;
   971	
   972		if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
   973		    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
   974		     EXT2_HAS_RO_COMPAT_FEATURE(sb, ~0U) ||
   975		     EXT2_HAS_INCOMPAT_FEATURE(sb, ~0U)))
   976			ext2_msg(sb, KERN_WARNING,
   977				"warning: feature flags set on rev 0 fs, "
   978				"running e2fsck is recommended");
   979		/*
   980		 * Check feature flags regardless of the revision level, since we
   981		 * previously didn't change the revision level when setting the flags,
   982		 * so there is a chance incompat flags are set on a rev 0 filesystem.
   983		 */
   984		features = EXT2_HAS_INCOMPAT_FEATURE(sb, ~EXT2_FEATURE_INCOMPAT_SUPP);
   985		if (features) {
   986			ext2_msg(sb, KERN_ERR,	"error: couldn't mount because of "
   987			       "unsupported optional features (%x)",
   988				le32_to_cpu(features));
   989			goto failed_mount;
   990		}
   991		if (!sb_rdonly(sb) && (features = EXT2_HAS_RO_COMPAT_FEATURE(sb, ~EXT2_FEATURE_RO_COMPAT_SUPP))){
   992			ext2_msg(sb, KERN_ERR, "error: couldn't mount RDWR because of "
   993			       "unsupported optional features (%x)",
   994			       le32_to_cpu(features));
   995			goto failed_mount;
   996		}
   997	
   998		if (le32_to_cpu(es->s_log_block_size) >
   999		    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
  1000			ext2_msg(sb, KERN_ERR,
  1001				 "Invalid log block size: %u",
  1002				 le32_to_cpu(es->s_log_block_size));
  1003			goto failed_mount;
  1004		}
  1005		blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
  1006	
  1007		if (test_opt(sb, DAX)) {
  1008			if (!sbi->s_daxdev) {
  1009				ext2_msg(sb, KERN_ERR,
  1010					"DAX unsupported by block device. Turning off DAX.");
  1011				clear_opt(sbi->s_mount_opt, DAX);
  1012			} else if (blocksize != PAGE_SIZE) {
  1013				ext2_msg(sb, KERN_ERR, "unsupported blocksize for DAX\n");
  1014				clear_opt(sbi->s_mount_opt, DAX);
  1015			}
  1016		}
  1017	
  1018		/* If the blocksize doesn't match, re-read the thing.. */
  1019		if (sb->s_blocksize != blocksize) {
  1020			brelse(bh);

Smatch complains that this calls brelse()

  1021	
  1022			if (!sb_set_blocksize(sb, blocksize)) {
  1023				ext2_msg(sb, KERN_ERR,
  1024					"error: bad blocksize %d", blocksize);
  1025				goto failed_sbi;

and this goto calls brelse(bh) a second time inside the
ext2_free_sbi() function.

  1026			}
  1027	
  1028			logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
  1029			offset = (sb_block*BLOCK_SIZE) % blocksize;
  1030			bh = sb_bread(sb, logic_sb_block);
  1031			if(!bh) {
  1032				ext2_msg(sb, KERN_ERR, "error: couldn't read"
  1033					"superblock on 2nd try");
  1034				goto failed_sbi;
  1035			}
  1036			es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
  1037			sbi->s_es = es;
  1038			if (es->s_magic != cpu_to_le16(EXT2_SUPER_MAGIC)) {
  1039				ext2_msg(sb, KERN_ERR, "error: magic mismatch");
  1040				goto failed_mount;
  1041			}
  1042		}
  1043	
  1044		sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
  1045		sb->s_max_links = EXT2_LINK_MAX;
  1046		sb->s_time_min = S32_MIN;
  1047		sb->s_time_max = S32_MAX;
  1048	
  1049		if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
  1050			sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
  1051			sbi->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
  1052		} else {
  1053			sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
  1054			sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
  1055			if ((sbi->s_inode_size < EXT2_GOOD_OLD_INODE_SIZE) ||
  1056			    !is_power_of_2(sbi->s_inode_size) ||
  1057			    (sbi->s_inode_size > blocksize)) {
  1058				ext2_msg(sb, KERN_ERR,
  1059					"error: unsupported inode size: %d",
  1060					sbi->s_inode_size);
  1061				goto failed_mount;
  1062			}
  1063		}
  1064	
  1065		sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
  1066		sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
  1067	
  1068		sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
  1069		if (sbi->s_inodes_per_block == 0 || sbi->s_inodes_per_group == 0)
  1070			goto cantfind_ext2;
  1071		sbi->s_itb_per_group = sbi->s_inodes_per_group /
  1072						sbi->s_inodes_per_block;
  1073		sbi->s_desc_per_block = sb->s_blocksize /
  1074						sizeof (struct ext2_group_desc);
  1075		sbi->s_sbh = bh;
  1076		sbi->s_mount_state = le16_to_cpu(es->s_state);
  1077		sbi->s_addr_per_block_bits =
  1078			ilog2 (EXT2_ADDR_PER_BLOCK(sb));
  1079		sbi->s_desc_per_block_bits =
  1080			ilog2 (EXT2_DESC_PER_BLOCK(sb));
  1081	
  1082		if (sb->s_magic != EXT2_SUPER_MAGIC)
  1083			goto cantfind_ext2;
  1084	
  1085		if (sb->s_blocksize != bh->b_size) {
  1086			if (!silent)
  1087				ext2_msg(sb, KERN_ERR, "error: unsupported blocksize");
  1088			goto failed_mount;
  1089		}
  1090	
  1091		if (es->s_log_frag_size != es->s_log_block_size) {
  1092			ext2_msg(sb, KERN_ERR,
  1093				"error: fragsize log %u != blocksize log %u",
  1094				le32_to_cpu(es->s_log_frag_size), sb->s_blocksize_bits);
  1095			goto failed_mount;
  1096		}
  1097	
  1098		if (sbi->s_blocks_per_group > sb->s_blocksize * 8) {
  1099			ext2_msg(sb, KERN_ERR,
  1100				"error: #blocks per group too big: %lu",
  1101				sbi->s_blocks_per_group);
  1102			goto failed_mount;
  1103		}
  1104		/* At least inode table, bitmaps, and sb have to fit in one group */
  1105		if (sbi->s_blocks_per_group <= sbi->s_itb_per_group + 3) {
  1106			ext2_msg(sb, KERN_ERR,
  1107				"error: #blocks per group smaller than metadata size: %lu <= %lu",
  1108				sbi->s_blocks_per_group, sbi->s_inodes_per_group + 3);
  1109			goto failed_mount;
  1110		}
  1111		if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
  1112		    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
  1113			ext2_msg(sb, KERN_ERR,
  1114				"error: invalid #inodes per group: %lu",
  1115				sbi->s_inodes_per_group);
  1116			goto failed_mount;
  1117		}
  1118		if (sb_bdev_nr_blocks(sb) < le32_to_cpu(es->s_blocks_count)) {
  1119			ext2_msg(sb, KERN_ERR,
  1120				 "bad geometry: block count %u exceeds size of device (%u blocks)",
  1121				 le32_to_cpu(es->s_blocks_count),
  1122				 (unsigned)sb_bdev_nr_blocks(sb));
  1123			goto failed_mount;
  1124		}
  1125	
  1126		sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
  1127					le32_to_cpu(es->s_first_data_block) - 1)
  1128						/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
  1129		if ((u64)sbi->s_groups_count * sbi->s_inodes_per_group !=
  1130		    le32_to_cpu(es->s_inodes_count)) {
  1131			ext2_msg(sb, KERN_ERR, "error: invalid #inodes: %u vs computed %llu",
  1132				 le32_to_cpu(es->s_inodes_count),
  1133				 (u64)sbi->s_groups_count * sbi->s_inodes_per_group);
  1134			goto failed_mount;
  1135		}
  1136		db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
  1137			   EXT2_DESC_PER_BLOCK(sb);
  1138		sbi->s_group_desc = kvmalloc_array(db_count,
  1139						   sizeof(struct buffer_head *),
  1140						   GFP_KERNEL);
  1141		if (sbi->s_group_desc == NULL) {
  1142			ret = -ENOMEM;
  1143			ext2_msg(sb, KERN_ERR, "error: not enough memory");
  1144			goto failed_mount;
  1145		}
  1146		bgl_lock_init(sbi->s_blockgroup_lock);
  1147		sbi->s_debts = kcalloc(sbi->s_groups_count, sizeof(*sbi->s_debts), GFP_KERNEL);
  1148		if (!sbi->s_debts) {
  1149			ret = -ENOMEM;
  1150			ext2_msg(sb, KERN_ERR, "error: not enough memory");
  1151			goto failed_mount_group_desc;
  1152		}
  1153		for (i = 0; i < db_count; i++) {
  1154			block = descriptor_loc(sb, logic_sb_block, i);
  1155			sbi->s_group_desc[i] = sb_bread(sb, block);
  1156			if (!sbi->s_group_desc[i]) {
  1157				for (j = 0; j < i; j++)
  1158					brelse (sbi->s_group_desc[j]);
  1159				ext2_msg(sb, KERN_ERR,
  1160					"error: unable to read group descriptors");
  1161				goto failed_mount_group_desc;
  1162			}
  1163		}
  1164		if (!ext2_check_descriptors (sb)) {
  1165			ext2_msg(sb, KERN_ERR, "group descriptors corrupted");
  1166			goto failed_mount2;
  1167		}
  1168		sbi->s_gdb_count = db_count;
  1169		get_random_bytes(&sbi->s_next_generation, sizeof(u32));
  1170		spin_lock_init(&sbi->s_next_gen_lock);
  1171	
  1172		/* per filesystem reservation list head & lock */
  1173		spin_lock_init(&sbi->s_rsv_window_lock);
  1174		sbi->s_rsv_window_root = RB_ROOT;
  1175		/*
  1176		 * Add a single, static dummy reservation to the start of the
  1177		 * reservation window list --- it gives us a placeholder for
  1178		 * append-at-start-of-list which makes the allocation logic
  1179		 * _much_ simpler.
  1180		 */
  1181		sbi->s_rsv_window_head.rsv_start = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
  1182		sbi->s_rsv_window_head.rsv_end = EXT2_RESERVE_WINDOW_NOT_ALLOCATED;
  1183		sbi->s_rsv_window_head.rsv_alloc_hit = 0;
  1184		sbi->s_rsv_window_head.rsv_goal_size = 0;
  1185		ext2_rsv_window_add(sb, &sbi->s_rsv_window_head);
  1186	
  1187		err = percpu_counter_init(&sbi->s_freeblocks_counter,
  1188					ext2_count_free_blocks(sb), GFP_KERNEL);
  1189		if (!err) {
  1190			err = percpu_counter_init(&sbi->s_freeinodes_counter,
  1191					ext2_count_free_inodes(sb), GFP_KERNEL);
  1192		}
  1193		if (!err) {
  1194			err = percpu_counter_init(&sbi->s_dirs_counter,
  1195					ext2_count_dirs(sb), GFP_KERNEL);
  1196		}
  1197		if (err) {
  1198			ret = err;
  1199			ext2_msg(sb, KERN_ERR, "error: insufficient memory");
  1200			goto failed_mount3;
  1201		}
  1202	
  1203	#ifdef CONFIG_EXT2_FS_XATTR
  1204		sbi->s_ea_block_cache = ext2_xattr_create_cache();
  1205		if (!sbi->s_ea_block_cache) {
  1206			ret = -ENOMEM;
  1207			ext2_msg(sb, KERN_ERR, "Failed to create ea_block_cache");
  1208			goto failed_mount3;
  1209		}
  1210	#endif
  1211		/*
  1212		 * set up enough so that it can read an inode
  1213		 */
  1214		sb->s_op = &ext2_sops;
  1215		sb->s_export_op = &ext2_export_ops;
  1216		sb->s_xattr = ext2_xattr_handlers;
  1217	
  1218	#ifdef CONFIG_QUOTA
  1219		sb->dq_op = &dquot_operations;
  1220		sb->s_qcop = &ext2_quotactl_ops;
  1221		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
  1222	#endif
  1223	
  1224		root = ext2_iget(sb, EXT2_ROOT_INO);
  1225		if (IS_ERR(root)) {
  1226			ret = PTR_ERR(root);
  1227			goto failed_mount3;
  1228		}
  1229		if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
  1230			iput(root);
  1231			ext2_msg(sb, KERN_ERR, "error: corrupt root inode, run e2fsck");
  1232			goto failed_mount3;
  1233		}
  1234	
  1235		sb->s_root = d_make_root(root);
  1236		if (!sb->s_root) {
  1237			ext2_msg(sb, KERN_ERR, "error: get root inode failed");
  1238			ret = -ENOMEM;
  1239			goto failed_mount3;
  1240		}
  1241		if (EXT2_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL))
  1242			ext2_msg(sb, KERN_WARNING,
  1243				"warning: mounting ext3 filesystem as ext2");
  1244		if (ext2_setup_super (sb, es, sb_rdonly(sb)))
  1245			sb->s_flags |= SB_RDONLY;
  1246		ext2_write_super(sb);
  1247		return 0;
  1248	
  1249	cantfind_ext2:
  1250		if (!silent)
  1251			ext2_msg(sb, KERN_ERR,
  1252				"error: can't find an ext2 filesystem on dev %s.",
  1253				sb->s_id);
  1254		goto failed_mount;
  1255	failed_mount3:
  1256		ext2_xattr_destroy_cache(sbi->s_ea_block_cache);
  1257		percpu_counter_destroy(&sbi->s_freeblocks_counter);
  1258		percpu_counter_destroy(&sbi->s_freeinodes_counter);
  1259		percpu_counter_destroy(&sbi->s_dirs_counter);
  1260	failed_mount2:
  1261		for (i = 0; i < db_count; i++)
  1262			brelse(sbi->s_group_desc[i]);
  1263	failed_mount_group_desc:
  1264		kvfree(sbi->s_group_desc);
  1265		kfree(sbi->s_debts);
  1266	failed_mount:
  1267	failed_sbi:
  1268		ext2_free_sbi(sb, sbi, bh);
                                       ^^

  1269		return ret;
  1270	}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



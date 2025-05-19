Return-Path: <linux-ext4+bounces-7962-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F3ABB48F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 07:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552E17A569E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 05:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF320C030;
	Mon, 19 May 2025 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mf/ADbis"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD12010EE;
	Mon, 19 May 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634337; cv=none; b=VxPoSknqn8c6Kx4Zfo7AczqZsv/8T1RTklvdpI3Ntl9h2brg10YaJacLbkOnhaXDAg611NFXEcBOQMZeIcyaChpjk9/L1jZdvNs0RMIqo0cu8XfKvAZrqV/sYV1clxU/CztGeYqHcIaK07F8YLLppwaVVoAriEXeTTEKYVgUM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634337; c=relaxed/simple;
	bh=3wasfJW/xX5FRh3O7lZ3XUUxGYvh0e3c3h0KW84orOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azZVPTHUHjIkFw4wOEqtyHKat/HEUIA5rhPzI+Nt0tMj1f0ox5xPhsmL2pExRAI3FII67SMEh16pxYBfV+13M3G+RjMd2i1jYm2geBfTGBcM5wWRIYrbZSM7rbqTdqOnwLQfSbqvTRId2xvYWeCwVrfPyZAlzpCAfyWr9oDl02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mf/ADbis; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747634336; x=1779170336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wasfJW/xX5FRh3O7lZ3XUUxGYvh0e3c3h0KW84orOk=;
  b=mf/ADbisur+or0hhfAl59mPHN+tOIIuMnXLMYrf1vOBpDD9D/G/c/R/E
   McUYCbySDlHwWU0ZR1AsJGsfvXPFi8+zaeUzIKY4w1ydTkYlKosnzlEJu
   7H8GmV4qua58ckerB6HqQv4E71CQbumfWc8Cf+6hSHQNA8pBS3lpNX/UO
   P4ZxNtBPb2J5rO8z8Ixw/oP9aMafsI+XX/Va4WVlAY482pk6sUQyZGl6C
   qdFwio924rwBTqK96p6C5ckNuGNCWjJxGwDpk9wGW0TS1Gu5IhIu3iGMS
   DWctMbbwxDk4Us2oy/smRLBAtA+NZbg/DaHLdhOxNdobTN5BG6DA0aIez
   g==;
X-CSE-ConnectionGUID: QD+1dBm1RBG3pfaAld0jbA==
X-CSE-MsgGUID: UR4vXq3SRUmK/Eiw7RWT8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53336335"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53336335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 22:58:53 -0700
X-CSE-ConnectionGUID: +9soHTPkR4iIHLdsbmCuhw==
X-CSE-MsgGUID: gPgM6GY/QaudTFnlSKFbNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139766797"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 18 May 2025 22:58:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uGtWR-000LB3-0C;
	Mon, 19 May 2025 05:58:47 +0000
Date: Mon, 19 May 2025 13:58:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Ethan Carter Edwards <ethan@ethancedwards.com>
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <202505191316.JJMnPobO-lkp@intel.com>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5723cc3450bccf7f98f227b9723b5c9f6b3af1c5]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Carter-Edwards/ext4-replace-strcpy-with-assignment/20250519-115601
base:   5723cc3450bccf7f98f227b9723b5c9f6b3af1c5
patch link:    https://lore.kernel.org/r/20250518-ext4-strcpy-v2-1-80d316325046%40ethancedwards.com
patch subject: [PATCH v2] ext4: replace strcpy() with '.' assignment
config: csky-randconfig-002-20250519 (https://download.01.org/0day-ci/archive/20250519/202505191316.JJMnPobO-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505191316.JJMnPobO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505191316.JJMnPobO-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ext4/inline.c: In function 'ext4_inlinedir_to_tree':
>> fs/ext4/inline.c:1317:38: error: assignment to 'char' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
    1317 |                         fake.name[0] = ".";
         |                                      ^
   fs/ext4/inline.c:1327:53: error: assignment to 'char' from 'char *' makes integer from pointer without a cast [-Wint-conversion]
    1327 |                         fake.name[0] = fake.name[1] = ".";
         |                                                     ^


vim +1317 fs/ext4/inline.c

  1259	
  1260	/*
  1261	 * This function fills a red-black tree with information from an
  1262	 * inlined dir.  It returns the number directory entries loaded
  1263	 * into the tree.  If there is an error it is returned in err.
  1264	 */
  1265	int ext4_inlinedir_to_tree(struct file *dir_file,
  1266				   struct inode *dir, ext4_lblk_t block,
  1267				   struct dx_hash_info *hinfo,
  1268				   __u32 start_hash, __u32 start_minor_hash,
  1269				   int *has_inline_data)
  1270	{
  1271		int err = 0, count = 0;
  1272		unsigned int parent_ino;
  1273		int pos;
  1274		struct ext4_dir_entry_2 *de;
  1275		struct inode *inode = file_inode(dir_file);
  1276		int ret, inline_size = 0;
  1277		struct ext4_iloc iloc;
  1278		void *dir_buf = NULL;
  1279		struct ext4_dir_entry_2 fake;
  1280		struct fscrypt_str tmp_str;
  1281	
  1282		ret = ext4_get_inode_loc(inode, &iloc);
  1283		if (ret)
  1284			return ret;
  1285	
  1286		down_read(&EXT4_I(inode)->xattr_sem);
  1287		if (!ext4_has_inline_data(inode)) {
  1288			up_read(&EXT4_I(inode)->xattr_sem);
  1289			*has_inline_data = 0;
  1290			goto out;
  1291		}
  1292	
  1293		inline_size = ext4_get_inline_size(inode);
  1294		dir_buf = kmalloc(inline_size, GFP_NOFS);
  1295		if (!dir_buf) {
  1296			ret = -ENOMEM;
  1297			up_read(&EXT4_I(inode)->xattr_sem);
  1298			goto out;
  1299		}
  1300	
  1301		ret = ext4_read_inline_data(inode, dir_buf, inline_size, &iloc);
  1302		up_read(&EXT4_I(inode)->xattr_sem);
  1303		if (ret < 0)
  1304			goto out;
  1305	
  1306		pos = 0;
  1307		parent_ino = le32_to_cpu(((struct ext4_dir_entry_2 *)dir_buf)->inode);
  1308		while (pos < inline_size) {
  1309			/*
  1310			 * As inlined dir doesn't store any information about '.' and
  1311			 * only the inode number of '..' is stored, we have to handle
  1312			 * them differently.
  1313			 */
  1314			if (pos == 0) {
  1315				fake.inode = cpu_to_le32(inode->i_ino);
  1316				fake.name_len = 1;
> 1317				fake.name[0] = ".";
  1318				fake.rec_len = ext4_rec_len_to_disk(
  1319						  ext4_dir_rec_len(fake.name_len, NULL),
  1320						  inline_size);
  1321				ext4_set_de_type(inode->i_sb, &fake, S_IFDIR);
  1322				de = &fake;
  1323				pos = EXT4_INLINE_DOTDOT_OFFSET;
  1324			} else if (pos == EXT4_INLINE_DOTDOT_OFFSET) {
  1325				fake.inode = cpu_to_le32(parent_ino);
  1326				fake.name_len = 2;
  1327				fake.name[0] = fake.name[1] = ".";
  1328				fake.rec_len = ext4_rec_len_to_disk(
  1329						  ext4_dir_rec_len(fake.name_len, NULL),
  1330						  inline_size);
  1331				ext4_set_de_type(inode->i_sb, &fake, S_IFDIR);
  1332				de = &fake;
  1333				pos = EXT4_INLINE_DOTDOT_SIZE;
  1334			} else {
  1335				de = (struct ext4_dir_entry_2 *)(dir_buf + pos);
  1336				pos += ext4_rec_len_from_disk(de->rec_len, inline_size);
  1337				if (ext4_check_dir_entry(inode, dir_file, de,
  1338						 iloc.bh, dir_buf,
  1339						 inline_size, pos)) {
  1340					ret = count;
  1341					goto out;
  1342				}
  1343			}
  1344	
  1345			if (ext4_hash_in_dirent(dir)) {
  1346				hinfo->hash = EXT4_DIRENT_HASH(de);
  1347				hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
  1348			} else {
  1349				err = ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
  1350				if (err) {
  1351					ret = err;
  1352					goto out;
  1353				}
  1354			}
  1355			if ((hinfo->hash < start_hash) ||
  1356			    ((hinfo->hash == start_hash) &&
  1357			     (hinfo->minor_hash < start_minor_hash)))
  1358				continue;
  1359			if (de->inode == 0)
  1360				continue;
  1361			tmp_str.name = de->name;
  1362			tmp_str.len = de->name_len;
  1363			err = ext4_htree_store_dirent(dir_file, hinfo->hash,
  1364						      hinfo->minor_hash, de, &tmp_str);
  1365			if (err) {
  1366				ret = err;
  1367				goto out;
  1368			}
  1369			count++;
  1370		}
  1371		ret = count;
  1372	out:
  1373		kfree(dir_buf);
  1374		brelse(iloc.bh);
  1375		return ret;
  1376	}
  1377	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


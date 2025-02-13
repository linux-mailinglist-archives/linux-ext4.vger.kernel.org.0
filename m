Return-Path: <linux-ext4+bounces-6428-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A86A33A49
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F257A13D9
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA820B20E;
	Thu, 13 Feb 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io/jdjIE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8DD200112
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436729; cv=none; b=MQ13rAH4pUMgJsr4hQ2Ep9YbPWKC4Kt05oV29QrmOluq0At9Yn9XnbnLvPXPbYwQPuzTZHk476XjuEyTHYkk1rH2Tw/qzBXx2DAwZEWwsfllY7G5r43wPvRRLC1Cm24uGyWbXQiJ/nTO+kbjZnKI8Tu9ywUISvua/CI5uTdW9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436729; c=relaxed/simple;
	bh=78XYhWlcpAj0M/0FsxIdSd3CZI0VvsSTmcoDPwXt6sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JELKaiu6/JBLW320ZKEZ0E4A5uuPHILf5xyCN81wn0LL+htY3LS+B/7hn9fwVODTOrk3MWJIOwWL3WKwBLvIq9GGp8W6S38w6IVKxI7oFivzU+Cyn+kOyrT4Jua7WIeuZqSSlQEwtxHbC/vU4j+EsBKXl3W2a3DniltHlJQpwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=io/jdjIE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739436728; x=1770972728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=78XYhWlcpAj0M/0FsxIdSd3CZI0VvsSTmcoDPwXt6sI=;
  b=io/jdjIEY3dx1pwJZvmV6C/2iL4f7rCxM3YV+KrJQKjk7Qby6Qn36vrC
   35pZRLjuC9lAMl+LTcOSu7ZFwMZ6VrefqWn2hUmqKEreFhk2Hy7pRDvar
   6pYyxoKbmM/4sWfV+3lp6THmwv3qEhoXZA6tlEd9AD3OCcgPiBT71q4SY
   6t1AtBbhW1NV8QtdgIpHBRZdTHfsH9svdUsv6Em/oSU6E2sPUD4y+S3gJ
   I5qtNeFDQGnA+9FxEhU2gEXYaDVCuXxYH8996KdWJaJOV/L56qvxyBLdU
   nPOqLBBVQCK3lvN4gKoI5JOOAiDxFAcc+XRTAMsNFlPt32KiyJx8MJKY+
   g==;
X-CSE-ConnectionGUID: hsDf2bp4QQKufWe0kcIlJA==
X-CSE-MsgGUID: nXo63rITTQ2G8GSel1UnEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40389979"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40389979"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:52:07 -0800
X-CSE-ConnectionGUID: c20MvgWKTkCns3a+ogZOVQ==
X-CSE-MsgGUID: 4+FxrO23SSqmln86dUmvZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112922715"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Feb 2025 00:52:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiUx1-0016pz-1k;
	Thu, 13 Feb 2025 08:52:03 +0000
Date: Thu, 13 Feb 2025 16:51:57 +0800
From: kernel test robot <lkp@intel.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-ext4@vger.kernel.org
Subject: [tytso-ext4:test 14/15] fs/ext4/namei.c:1602:13: error: no member
 named 's_encoding_flags' in 'struct super_block'
Message-ID: <202502131631.QY6jPFdz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git test
head:   e5a9a1fce162be14c6f1ac325faac48b1a7dea9e
commit: 9a66196d3bda397030358f6608d3d40a6db18f8f [14/15] ext4: introduce linear search for dentries
config: riscv-randconfig-001-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131631.QY6jPFdz-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131631.QY6jPFdz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131631.QY6jPFdz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/ext4/namei.c:1602:13: error: no member named 's_encoding_flags' in 'struct super_block'
    1602 |                 else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
         |                           ^                              ~~~~~~~~~
   include/linux/fs.h:1268:7: note: expanded from macro 'sb_no_casefold_compat_fallback'
    1268 |         (sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
         |          ~~  ^
   1 error generated.


vim +1602 fs/ext4/namei.c

  1537	
  1538	/*
  1539	 *	__ext4_find_entry()
  1540	 *
  1541	 * finds an entry in the specified directory with the wanted name. It
  1542	 * returns the cache buffer in which the entry was found, and the entry
  1543	 * itself (as a parameter - res_dir). It does NOT read the inode of the
  1544	 * entry - you'll have to do that yourself if you want to.
  1545	 *
  1546	 * The returned buffer_head has ->b_count elevated.  The caller is expected
  1547	 * to brelse() it when appropriate.
  1548	 */
  1549	static struct buffer_head *__ext4_find_entry(struct inode *dir,
  1550						     struct ext4_filename *fname,
  1551						     struct ext4_dir_entry_2 **res_dir,
  1552						     int *inlined)
  1553	{
  1554		struct super_block *sb;
  1555		struct buffer_head *bh_use[NAMEI_RA_SIZE];
  1556		struct buffer_head *bh, *ret = NULL;
  1557		ext4_lblk_t start, block;
  1558		const u8 *name = fname->usr_fname->name;
  1559		size_t ra_max = 0;	/* Number of bh's in the readahead
  1560					   buffer, bh_use[] */
  1561		size_t ra_ptr = 0;	/* Current index into readahead
  1562					   buffer */
  1563		ext4_lblk_t  nblocks;
  1564		int i, namelen, retval;
  1565	
  1566		*res_dir = NULL;
  1567		sb = dir->i_sb;
  1568		namelen = fname->usr_fname->len;
  1569		if (namelen > EXT4_NAME_LEN)
  1570			return NULL;
  1571	
  1572		if (ext4_has_inline_data(dir)) {
  1573			int has_inline_data = 1;
  1574			ret = ext4_find_inline_entry(dir, fname, res_dir,
  1575						     &has_inline_data);
  1576			if (inlined)
  1577				*inlined = has_inline_data;
  1578			if (has_inline_data || IS_ERR(ret))
  1579				goto cleanup_and_exit;
  1580		}
  1581	
  1582		if ((namelen <= 2) && (name[0] == '.') &&
  1583		    (name[1] == '.' || name[1] == '\0')) {
  1584			/*
  1585			 * "." or ".." will only be in the first block
  1586			 * NFS may look up ".."; "." should be handled by the VFS
  1587			 */
  1588			block = start = 0;
  1589			nblocks = 1;
  1590			goto restart;
  1591		}
  1592		if (is_dx(dir)) {
  1593			ret = ext4_dx_find_entry(dir, fname, res_dir);
  1594			/*
  1595			 * On success, or if the error was file not found,
  1596			 * return.  Otherwise, fall back to doing a search the
  1597			 * old fashioned way.
  1598			 */
  1599			if (IS_ERR(ret) && PTR_ERR(ret) == ERR_BAD_DX_DIR)
  1600				dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
  1601					       "falling back\n"));
> 1602			else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
  1603				 *res_dir == NULL && IS_CASEFOLDED(dir))
  1604				dxtrace(printk(KERN_DEBUG "ext4_find_entry: casefold "
  1605					       "failed, falling back\n"));
  1606			else
  1607				goto cleanup_and_exit;
  1608			ret = NULL;
  1609		}
  1610		nblocks = dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
  1611		if (!nblocks) {
  1612			ret = NULL;
  1613			goto cleanup_and_exit;
  1614		}
  1615		start = EXT4_I(dir)->i_dir_start_lookup;
  1616		if (start >= nblocks)
  1617			start = 0;
  1618		block = start;
  1619	restart:
  1620		do {
  1621			/*
  1622			 * We deal with the read-ahead logic here.
  1623			 */
  1624			cond_resched();
  1625			if (ra_ptr >= ra_max) {
  1626				/* Refill the readahead buffer */
  1627				ra_ptr = 0;
  1628				if (block < start)
  1629					ra_max = start - block;
  1630				else
  1631					ra_max = nblocks - block;
  1632				ra_max = min(ra_max, ARRAY_SIZE(bh_use));
  1633				retval = ext4_bread_batch(dir, block, ra_max,
  1634							  false /* wait */, bh_use);
  1635				if (retval) {
  1636					ret = ERR_PTR(retval);
  1637					ra_max = 0;
  1638					goto cleanup_and_exit;
  1639				}
  1640			}
  1641			if ((bh = bh_use[ra_ptr++]) == NULL)
  1642				goto next;
  1643			wait_on_buffer(bh);
  1644			if (!buffer_uptodate(bh)) {
  1645				EXT4_ERROR_INODE_ERR(dir, EIO,
  1646						     "reading directory lblock %lu",
  1647						     (unsigned long) block);
  1648				brelse(bh);
  1649				ret = ERR_PTR(-EIO);
  1650				goto cleanup_and_exit;
  1651			}
  1652			if (!buffer_verified(bh) &&
  1653			    !is_dx_internal_node(dir, block,
  1654						 (struct ext4_dir_entry *)bh->b_data) &&
  1655			    !ext4_dirblock_csum_verify(dir, bh)) {
  1656				EXT4_ERROR_INODE_ERR(dir, EFSBADCRC,
  1657						     "checksumming directory "
  1658						     "block %lu", (unsigned long)block);
  1659				brelse(bh);
  1660				ret = ERR_PTR(-EFSBADCRC);
  1661				goto cleanup_and_exit;
  1662			}
  1663			set_buffer_verified(bh);
  1664			i = search_dirblock(bh, dir, fname,
  1665				    block << EXT4_BLOCK_SIZE_BITS(sb), res_dir);
  1666			if (i == 1) {
  1667				EXT4_I(dir)->i_dir_start_lookup = block;
  1668				ret = bh;
  1669				goto cleanup_and_exit;
  1670			} else {
  1671				brelse(bh);
  1672				if (i < 0) {
  1673					ret = ERR_PTR(i);
  1674					goto cleanup_and_exit;
  1675				}
  1676			}
  1677		next:
  1678			if (++block >= nblocks)
  1679				block = 0;
  1680		} while (block != start);
  1681	
  1682		/*
  1683		 * If the directory has grown while we were searching, then
  1684		 * search the last part of the directory before giving up.
  1685		 */
  1686		block = nblocks;
  1687		nblocks = dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
  1688		if (block < nblocks) {
  1689			start = 0;
  1690			goto restart;
  1691		}
  1692	
  1693	cleanup_and_exit:
  1694		/* Clean up the read-ahead blocks */
  1695		for (; ra_ptr < ra_max; ra_ptr++)
  1696			brelse(bh_use[ra_ptr]);
  1697		return ret;
  1698	}
  1699	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


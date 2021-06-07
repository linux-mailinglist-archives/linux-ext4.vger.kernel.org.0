Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22739D992
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFGK0g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 06:26:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21976 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGK0f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 06:26:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 157AHeil005413;
        Mon, 7 Jun 2021 10:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=u12TmV5uGv81rRznZbzspuuXXc/5c57q0zq4nsWum48=;
 b=jgmKAik5hDJlP2wURcTO9vY7Mr29tTALlGRSSJjnmn9DnbeZssy+SefZdShzJqXr2Vwh
 tH+b9LwlagI0q87FxZHDzp2iE1Esqs9aIKKV7TSvsCdtg730ekW/2HW1q+BbvRXGuqIy
 DjINKygDnBWVxuRHu6y1GpwI3XS239qX6kC65eVj5pnupyGTSGFTjwowo3qzO0nVUb80
 5rN+I5IFznTGyaAKzi3AzTLB4cjGT0klP96sFwnKKFDM7DlfeijPQERjlGCuNSW2rs1t
 ehsgo3WR5sVZXY9+CqCdOBsePYvSrBWj3FC8sVoosmfwjT5UXCDCvgCyVdA45lmKShje Hg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 391g4g814k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 10:24:40 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 157AOdFi053883;
        Mon, 7 Jun 2021 10:24:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3906spaj0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 10:24:39 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 157AOdb2053829;
        Mon, 7 Jun 2021 10:24:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3906spahyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 10:24:39 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 157AOcef011743;
        Mon, 7 Jun 2021 10:24:38 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 03:24:37 -0700
Date:   Mon, 7 Jun 2021 13:24:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Leah Rumancik <leah.rumancik@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [ext4:dev 40/42] fs/jbd2/journal.c:1718 __jbd2_journal_erase() warn:
 maybe use && instead of &
Message-ID: <202106070427.SYkrGwCC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: EP2rIBNpkt1goxg59Sxo5ineu-QRNQY9
X-Proofpoint-ORIG-GUID: EP2rIBNpkt1goxg59Sxo5ineu-QRNQY9
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
head:   a492dedb708d287aac857c6799f6f364f3d914b3
commit: 84ed553af7e5c8f3f3de0160ba7eaabcab8b9f7b [40/42] ext4: add discard/zeroout flags to journal flush
config: arm-randconfig-m031-20210604 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/jbd2/journal.c:1718 __jbd2_journal_erase() warn: maybe use && instead of &

vim +1718 fs/jbd2/journal.c

84ed553af7e5c8 Leah Rumancik 2021-05-18  1701  static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
84ed553af7e5c8 Leah Rumancik 2021-05-18  1702  {
84ed553af7e5c8 Leah Rumancik 2021-05-18  1703  	int err = 0;
84ed553af7e5c8 Leah Rumancik 2021-05-18  1704  	unsigned long block, log_offset; /* logical */
84ed553af7e5c8 Leah Rumancik 2021-05-18  1705  	unsigned long long phys_block, block_start, block_stop; /* physical */
84ed553af7e5c8 Leah Rumancik 2021-05-18  1706  	loff_t byte_start, byte_stop, byte_count;
84ed553af7e5c8 Leah Rumancik 2021-05-18  1707  	struct request_queue *q = bdev_get_queue(journal->j_dev);
84ed553af7e5c8 Leah Rumancik 2021-05-18  1708  
84ed553af7e5c8 Leah Rumancik 2021-05-18  1709  	/* flags must be set to either discard or zeroout */
84ed553af7e5c8 Leah Rumancik 2021-05-18  1710  	if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) || !flags ||
84ed553af7e5c8 Leah Rumancik 2021-05-18  1711  			((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
84ed553af7e5c8 Leah Rumancik 2021-05-18  1712  			(flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
84ed553af7e5c8 Leah Rumancik 2021-05-18  1713  		return -EINVAL;
84ed553af7e5c8 Leah Rumancik 2021-05-18  1714  
84ed553af7e5c8 Leah Rumancik 2021-05-18  1715  	if (!q)
84ed553af7e5c8 Leah Rumancik 2021-05-18  1716  		return -ENXIO;
84ed553af7e5c8 Leah Rumancik 2021-05-18  1717  
84ed553af7e5c8 Leah Rumancik 2021-05-18 @1718  	if (JBD2_JOURNAL_FLUSH_DISCARD & !blk_queue_discard(q))

JBD2_JOURNAL_FLUSH_DISCARD is 1 so this works, but probably && was
intended.

Using && should be a little bit faster.  blk_queue_discard() is just a
wrapper around test_bit() so it doesn't have side effects.

84ed553af7e5c8 Leah Rumancik 2021-05-18  1719  		return -EOPNOTSUPP;
84ed553af7e5c8 Leah Rumancik 2021-05-18  1720  
84ed553af7e5c8 Leah Rumancik 2021-05-18  1721  	/*
84ed553af7e5c8 Leah Rumancik 2021-05-18  1722  	 * lookup block mapping and issue discard/zeroout for each
84ed553af7e5c8 Leah Rumancik 2021-05-18  1723  	 * contiguous region
84ed553af7e5c8 Leah Rumancik 2021-05-18  1724  	 */
84ed553af7e5c8 Leah Rumancik 2021-05-18  1725  	log_offset = be32_to_cpu(journal->j_superblock->s_first);
84ed553af7e5c8 Leah Rumancik 2021-05-18  1726  	block_start =  ~0ULL;
84ed553af7e5c8 Leah Rumancik 2021-05-18  1727  	for (block = log_offset; block < journal->j_total_len; block++) {
84ed553af7e5c8 Leah Rumancik 2021-05-18  1728  		err = jbd2_journal_bmap(journal, block, &phys_block);
84ed553af7e5c8 Leah Rumancik 2021-05-18  1729  		if (err) {
84ed553af7e5c8 Leah Rumancik 2021-05-18  1730  			pr_err("JBD2: bad block at offset %lu", block);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


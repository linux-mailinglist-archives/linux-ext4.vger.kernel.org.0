Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D515629A639
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394648AbgJ0IKG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 04:10:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390550AbgJ0IKE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 04:10:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R89R1B048553;
        Tue, 27 Oct 2020 08:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=sVDZEZm3RA+4j9FG1sRi417xEvsK90qw+uivVTy63/Y=;
 b=RNz4V/yA4Abf6bGW+gpNFxfz5P+TtU+X03QQ1hFxKnWqSoXRQ8I6YGCJ/mHJXBxTf0+m
 aWK+iTiOpkQ5LKTYyTpktPB6hZpnMTzSMCUW2mT1yYYjZpceGSef9wFgppXWWZ/jZ3lR
 MHBu+3csdT8Bhvo+nOzriFT4lSaGoLtHZoOmr4HQrhe613AEldQng1jKQeJoQ9rUTrjs
 8p4iczarUfjoanYCAuZl9D5cLnzeU82Xy2qEVxPfcHniCAjZqcH61OPe6rRcJ9eXnb7T
 0aWPpTS+QSZ5Er+wu2AxFAqn8aYOiUcqszpTAnxh3N4qT8mjXC5JBOittBFjmrKrs1Xz hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kre7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 08:10:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R8A1dK057416;
        Tue, 27 Oct 2020 08:10:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34cx5wtw5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 08:10:01 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09R89xKU004198;
        Tue, 27 Oct 2020 08:09:59 GMT
Received: from mwanda (/10.175.160.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 01:09:59 -0700
Date:   Tue, 27 Oct 2020 11:09:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     harshadshirwadkar@gmail.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: fast commit recovery path
Message-ID: <20201027080954.GA2513442@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=778
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=1 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=3
 priorityscore=1501 impostorscore=0 bulkscore=1 phishscore=0
 mlxlogscore=784 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270054
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Harshad Shirwadkar,

The patch 8016e29f4362: "ext4: fast commit recovery path" from Oct
15, 2020, leads to the following static checker warning:

	fs/ext4/fast_commit.c:1620 ext4_fc_replay_add_range()
	warn: 'path' is an error pointer or valid

fs/ext4/fast_commit.c
  1600          cur = start;
  1601          remaining = len;
  1602          jbd_debug(1, "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
  1603                    start, start_pblk, len, ext4_ext_is_unwritten(ex),
  1604                    inode->i_ino);
  1605  
  1606          while (remaining > 0) {
  1607                  map.m_lblk = cur;
  1608                  map.m_len = remaining;
  1609                  map.m_pblk = 0;
  1610                  ret = ext4_map_blocks(NULL, inode, &map, 0);
  1611  
  1612                  if (ret < 0) {
  1613                          iput(inode);
  1614                          return 0;
  1615                  }
  1616  
  1617                  if (ret == 0) {
  1618                          /* Range is not mapped */
  1619                          path = ext4_find_extent(inode, cur, NULL, 0);
  1620                          if (!path)
  1621                                  continue;
                                ^^^^^^^^^^^^^^^^
"path" can't be NULL, this should be an IS_ERR() test.  It's sort of
surprising to me that we continue here instead of returning an error.

  1622                          memset(&newex, 0, sizeof(newex));
  1623                          newex.ee_block = cpu_to_le32(cur);
  1624                          ext4_ext_store_pblock(
  1625                                  &newex, start_pblk + cur - start);
  1626                          newex.ee_len = cpu_to_le16(map.m_len);
  1627                          if (ext4_ext_is_unwritten(ex))
  1628                                  ext4_ext_mark_unwritten(&newex);
  1629                          down_write(&EXT4_I(inode)->i_data_sem);
  1630                          ret = ext4_ext_insert_extent(
  1631                                  NULL, inode, &path, &newex, 0);
  1632                          up_write((&EXT4_I(inode)->i_data_sem));
  1633                          ext4_ext_drop_refs(path);
  1634                          kfree(path);
  1635                          if (ret) {
  1636                                  iput(inode);
  1637                                  return 0;
  1638                          }
  1639                          goto next;
  1640                  }
  1641  
  1642                  if (start_pblk + cur - start != map.m_pblk) {

regards,
dan carpenter

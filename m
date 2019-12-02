Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72E10E7CD
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2019 10:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfLBJlU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Dec 2019 04:41:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLBJlU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Dec 2019 04:41:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB29dC0K014136;
        Mon, 2 Dec 2019 09:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=XJ+1swFQlzPFeuuedqdeH7XLoacL6Ejor0kTXN2YvT4=;
 b=CozG6if2JyaM7TiuVcABFSnqDR7jC2QLauQewpzyc/gSRdY0jPTzoI9xUKwJ9T6PzFPC
 9hU4hxmWMeZ/gvp6Bonf5PbAv8qMTiqMoMNx/TeUmKMfGJwX5j6ctTMK1WEMXf7fCJh2
 ++23t330zNfs20bNHieItT8co6eck2FO7HQgKt1GepkHnG73+JLvtdTUOv9yK/SOgK0O
 Wf/RELqX4P1KFyoGRNzpQfVdXo5Zrct/YBFqw1ka5DT3Xw5YER3s2sI2j43NOHgCpgDq
 vfdGA1dCLOMSHH0/flzucxsUZQs7BzaCh9J+xcTR0v68/x0l1Z7AebMo4FioCNxIVUyM 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wkgcpxq3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 09:41:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB29XqUO186432;
        Mon, 2 Dec 2019 09:41:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wm1w245s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 09:41:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB29fAtQ019731;
        Mon, 2 Dec 2019 09:41:11 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 01:41:09 -0800
Date:   Mon, 2 Dec 2019 12:41:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     miaoxie@huawei.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4, project: expand inode extra size if possible
Message-ID: <20191202094103.rgqihwzoxxy676fj@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=433
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=495 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020088
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Miao Xie,

The patch c03b45b853f5: "ext4, project: expand inode extra size if
possible" from Aug 6, 2017, leads to the following static checker
warning:

    fs/ext4/inode.c:5708 ext4_expand_extra_isize()
    warn: inconsistent returns 'EXT4_I(inode)->xattr_sem'.
      Locked on  : 5708
      Unlocked on: 5708

fs/ext4/inode.c
  5681          handle = ext4_journal_start(inode, EXT4_HT_INODE,
  5682                                      EXT4_DATA_TRANS_BLOCKS(inode->i_sb));
  5683          if (IS_ERR(handle)) {
  5684                  error = PTR_ERR(handle);
  5685                  brelse(iloc->bh);
  5686                  return error;
  5687          }
  5688  
  5689          ext4_write_lock_xattr(inode, &no_expand);
  5690  
  5691          BUFFER_TRACE(iloc->bh, "get_write_access");
  5692          error = ext4_journal_get_write_access(handle, iloc->bh);
  5693          if (error) {
  5694                  brelse(iloc->bh);
  5695                  goto out_stop;

Shouldn't this goto the ext4_write_unlock_xattr()?

  5696          }
  5697  
  5698          error = __ext4_expand_extra_isize(inode, new_extra_isize, iloc,
  5699                                            handle, &no_expand);
  5700  
  5701          rc = ext4_mark_iloc_dirty(handle, inode, iloc);
  5702          if (!error)
  5703                  error = rc;
  5704  
  5705          ext4_write_unlock_xattr(inode, &no_expand);
  5706  out_stop:
  5707          ext4_journal_stop(handle);
  5708          return error;
  5709  }


regards,
dan carpenter

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF450AAF
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfFXM3S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jun 2019 08:29:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXM3R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jun 2019 08:29:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCO7dZ020665;
        Mon, 24 Jun 2019 12:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=8TbQfYtvNSshTBr0ZvMlZv89p6dCExr2E7LXtartAAk=;
 b=Bq7UkG8GedUeAevBp9S94JysQch+Jh6eNcgIPXrWTUqt/uHaWYHLVAkYObNlKFTLYh26
 VOB87xP8id0qvKEAkD8mjSJtmGtOCANucYG4mNoLA8U6IXRLs0Hpc2Yrf7P2Brnf9xJ7
 +K7bZ5fbZ8g3R0XVfChfns1+eGZiV/tHLaXZ86/wgncPX4EPGvV3k2jEYQloZboAvqr9
 LMTuoK64UoD+xzgJBX0ZKzoMRswZ62ajq9UOFdSnqRgrJZ5tC6nX2uT/ohTIyRWyKHhP
 77Tesf3LEuGtTZWN4miVaOqe+EipIJIjqy2R1p/hE2qe6jueuIlmuCn9z2tQVnLowKRR 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9pe2qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:29:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCRoZW171386;
        Mon, 24 Jun 2019 12:29:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t9acbfswd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:29:13 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5OCTCmx004921;
        Mon, 24 Jun 2019 12:29:13 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:29:11 -0700
Date:   Mon, 24 Jun 2019 15:29:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     krisman@collabora.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: optimize case-insensitive lookups
Message-ID: <20190624122906.GA30836@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=601
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=646 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240102
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Gabriel Krisman Bertazi,

The patch 3ae72562ad91: "ext4: optimize case-insensitive lookups"
from Jun 19, 2019, leads to the following static checker warning:

	fs/ext4/namei.c:1311 ext4_fname_setup_ci_filename()
	warn: 'cf_name->len' unsigned <= 0

fs/ext4/namei.c
  1296  void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
  1297                                    struct fscrypt_str *cf_name)
  1298  {
  1299          if (!IS_CASEFOLDED(dir)) {
  1300                  cf_name->name = NULL;
  1301                  return;
  1302          }
  1303  
  1304          cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
  1305          if (!cf_name->name)
  1306                  return;
  1307  
  1308          cf_name->len = utf8_casefold(EXT4_SB(dir->i_sb)->s_encoding,
  1309                                       iname, cf_name->name,
  1310                                       EXT4_NAME_LEN);

utf8_casefold() returns negative error codes

  1311          if (cf_name->len <= 0) {

but "cf_name->len" is a u32.

  1312                  kfree(cf_name->name);
  1313                  cf_name->name = NULL;
  1314          }
  1315  }


regards,
dan carpenter

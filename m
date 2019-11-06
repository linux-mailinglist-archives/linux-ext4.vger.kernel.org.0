Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20259F10FD
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 09:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfKFIZQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 03:25:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfKFIZQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 03:25:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA68OAYh068300;
        Wed, 6 Nov 2019 08:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=YbvCGM50D19noC6b26GDzY6B6H0xo3nblZ6QUqNP7N4=;
 b=MBL9/Ijml7igTtHsqHCiFpKF8dT4Im3cYfxFDRyW0Kdc3dF1jsbgqZ1CiB4KozzW9GUk
 QlL/xnfaiAEkNoGk9Upd84KJ4p7ZlHRxiy0KaU4lmnksgeVZVvxVPeIlXYMzqmRctKd2
 4hk62JapkuSUWvnrU8t1hW+qHXH7oGQS2jMFfjGigAC7BI52XAGXVg9d/UJ38YrKn+ep
 23QzSE+uKZ9J/wl/QwzXE0uvxi7BF+CCmQiy7mp4qYq2CaGmhYvRyucn+VjX+XuEPlTB
 skuCrG3HpF3xaiUzvEdmo3OLqWUSJa7cPK0zlmwfBjZQJnlxfJgPcfsok1t7Ik1Q3MtH wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w11rq47cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 08:25:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA68OAti121246;
        Wed, 6 Nov 2019 08:25:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w2wcpd426-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 08:25:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA68PBtn011835;
        Wed, 6 Nov 2019 08:25:11 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 00:25:10 -0800
Date:   Wed, 6 Nov 2019 11:25:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     riteshh@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: Add support for blocksize < pagesize in
 dioread_nolock
Message-ID: <20191106082505.GA31923@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=686
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=764 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060088
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ritesh Harjani,

The patch c8cc88163f40: "ext4: Add support for blocksize < pagesize
in dioread_nolock" from Oct 16, 2019, leads to the following static
checker warning:

fs/ext4/inode.c:2390 mpage_process_page() error: 'io_end_vec' dereferencing possible ERR_PTR()
fs/ext4/inode.c:2557 mpage_map_and_submit_extent() error: 'io_end_vec' dereferencing possible ERR_PTR()
fs/ext4/inode.c:3677 ext4_end_io_dio() error: 'io_end_vec' dereferencing possible ERR_PTR()

fs/ext4/inode.c
  2371          bh = head = page_buffers(page);
  2372          do {
  2373                  if (lblk < mpd->map.m_lblk)
  2374                          continue;
  2375                  if (lblk >= mpd->map.m_lblk + mpd->map.m_len) {
  2376                          /*
  2377                           * Buffer after end of mapped extent.
  2378                           * Find next buffer in the page to map.
  2379                           */
  2380                          mpd->map.m_len = 0;
  2381                          mpd->map.m_flags = 0;
  2382                          io_end_vec->size += io_end_size;
  2383                          io_end_size = 0;
  2384  
  2385                          err = mpage_process_page_bufs(mpd, head, bh, lblk);
  2386                          if (err > 0)
  2387                                  err = 0;
  2388                          if (!err && mpd->map.m_len && mpd->map.m_lblk > lblk) {
  2389                                  io_end_vec = ext4_alloc_io_end_vec(io_end);
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This allocation can fail.

  2390                                  io_end_vec->offset = mpd->map.m_lblk << blkbits;
                                        ^^^^^^^^^^^^^^^^^^
Oops

  2391                          }
  2392                          *map_bh = true;
  2393                          goto out;
  2394                  }
  2395                  if (buffer_delay(bh)) {
  2396                          clear_buffer_delay(bh);
  2397                          bh->b_blocknr = pblock++;
  2398                  }
  2399                  clear_buffer_unwritten(bh);
  2400                  io_end_size += (1 << blkbits);
  2401          } while (lblk++, (bh = bh->b_this_page) != head);

regards,
dan carpenter

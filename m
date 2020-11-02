Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FF2A251E
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Nov 2020 08:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKBHXG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Nov 2020 02:23:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33518 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBHXG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Nov 2020 02:23:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A27MRwB187986;
        Mon, 2 Nov 2020 07:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=9qIA6H2LRTfPEGwysSBpivfJSXyQ7DgbiXirFjUjuMs=;
 b=kvmzONFLS5hkuwuiOm7WeXjacTs/EWZNIJ/zBTns3MqKNkZJmroNpjEwmtcWuKJ/iRC8
 6M8TGBtLoEkstlycU37zJvPM6cYRDlrCqdRtHp+zLzJpmNxw81P1umo/16nCIkkv5JRL
 5lZQ9rtMPz1zSzXDzLULA+Ti1UzNqOfYb4cSisSClr8hlPL3yvtQWrr5md6tPy+CcqCe
 vAO0Z22ledQuQ0MiQFnOEPOvMUQQpClknEmjW2BNEqZLC7Het7srm/bddwwJBL/YU2kX
 R61+XogUm5joEa27uCMjC8c1qCDMYF6UMylBN85fxXHY1fC3HZEIN2ip3ii+9CzqfzqH dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34hhw2acn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 07:23:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A27KL6c029801;
        Mon, 2 Nov 2020 07:23:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34hw0enc94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 07:23:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A27N1YT027816;
        Mon, 2 Nov 2020 07:23:01 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Nov 2020 23:23:01 -0800
Date:   Mon, 2 Nov 2020 10:22:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     boyu.mt@taobao.com
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: let ext4_truncate handle inline data correctly
Message-ID: <20201102072255.GA3954239@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=3 spamscore=0 mlxlogscore=461 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=3 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=490 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020057
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[ Ancient warning.  Still looks valid though.  - dan ]

Hello Tao Ma,

The patch aef1c8513c1f: "ext4: let ext4_truncate handle inline data
correctly" from Dec 10, 2012, leads to the following static checker
warning:

fs/ext4/inline.c:1956 ext4_inline_data_truncate()
warn: inconsistent returns 'EXT4_I(inode)->xattr_sem'.
  Locked on  : 1885
  Unlocked on: 1956

fs/ext4/inline.c
  1861  int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
  1862  {
  1863          handle_t *handle;
  1864          int inline_size, value_len, needed_blocks, no_expand, err = 0;
  1865          size_t i_size;
  1866          void *value = NULL;
  1867          struct ext4_xattr_ibody_find is = {
  1868                  .s = { .not_found = -ENODATA, },
  1869          };
  1870          struct ext4_xattr_info i = {
  1871                  .name_index = EXT4_XATTR_INDEX_SYSTEM,
  1872                  .name = EXT4_XATTR_SYSTEM_DATA,
  1873          };
  1874  
  1875  
  1876          needed_blocks = ext4_writepage_trans_blocks(inode);
  1877          handle = ext4_journal_start(inode, EXT4_HT_INODE, needed_blocks);
  1878          if (IS_ERR(handle))
  1879                  return PTR_ERR(handle);
  1880  
  1881          ext4_write_lock_xattr(inode, &no_expand);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Take the lock

  1882          if (!ext4_has_inline_data(inode)) {
  1883                  *has_inline = 0;
  1884                  ext4_journal_stop(handle);
  1885                  return 0;

Not unlocked.

  1886          }
  1887  
  1888          if ((err = ext4_orphan_add(handle, inode)) != 0)
  1889                  goto out;
  1890  
  1891          if ((err = ext4_get_inode_loc(inode, &is.iloc)) != 0)
  1892                  goto out;
  1893  
  1894          down_write(&EXT4_I(inode)->i_data_sem);
  1895          i_size = inode->i_size;
  1896          inline_size = ext4_get_inline_size(inode);
  1897          EXT4_I(inode)->i_disksize = i_size;
  1898  
  1899          if (i_size < inline_size) {
  1900                  /* Clear the content in the xattr space. */
  1901                  if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
  1902                          if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
  1903                                  goto out_error;
  1904  
  1905                          BUG_ON(is.s.not_found);
  1906  
  1907                          value_len = le32_to_cpu(is.s.here->e_value_size);
  1908                          value = kmalloc(value_len, GFP_NOFS);
  1909                          if (!value) {
  1910                                  err = -ENOMEM;
  1911                                  goto out_error;
  1912                          }
  1913  
  1914                          err = ext4_xattr_ibody_get(inode, i.name_index,
  1915                                                     i.name, value, value_len);
  1916                          if (err <= 0)
  1917                                  goto out_error;
  1918  
  1919                          i.value = value;
  1920                          i.value_len = i_size > EXT4_MIN_INLINE_DATA_SIZE ?
  1921                                          i_size - EXT4_MIN_INLINE_DATA_SIZE : 0;
  1922                          err = ext4_xattr_ibody_inline_set(handle, inode,
  1923                                                            &i, &is);
  1924                          if (err)
  1925                                  goto out_error;
  1926                  }
  1927  
  1928                  /* Clear the content within i_blocks. */
  1929                  if (i_size < EXT4_MIN_INLINE_DATA_SIZE) {
  1930                          void *p = (void *) ext4_raw_inode(&is.iloc)->i_block;
  1931                          memset(p + i_size, 0,
  1932                                 EXT4_MIN_INLINE_DATA_SIZE - i_size);
  1933                  }
  1934  
  1935                  EXT4_I(inode)->i_inline_size = i_size <
  1936                                          EXT4_MIN_INLINE_DATA_SIZE ?
  1937                                          EXT4_MIN_INLINE_DATA_SIZE : i_size;
  1938          }
  1939  
  1940  out_error:
  1941          up_write(&EXT4_I(inode)->i_data_sem);
  1942  out:
  1943          brelse(is.iloc.bh);
  1944          ext4_write_unlock_xattr(inode, &no_expand);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unlocked here.

  1945          kfree(value);
  1946          if (inode->i_nlink)
  1947                  ext4_orphan_del(handle, inode);
  1948  
  1949          if (err == 0) {
  1950                  inode->i_mtime = inode->i_ctime = current_time(inode);
  1951                  err = ext4_mark_inode_dirty(handle, inode);
  1952                  if (IS_SYNC(inode))
  1953                          ext4_handle_sync(handle);
  1954          }
  1955          ext4_journal_stop(handle);
  1956          return err;
  1957  }

regards,
dan carpenter

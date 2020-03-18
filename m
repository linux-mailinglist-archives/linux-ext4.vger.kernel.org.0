Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F8189495
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Mar 2020 04:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCRDsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Mar 2020 23:48:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgCRDsD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Mar 2020 23:48:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I3XiMk087156;
        Tue, 17 Mar 2020 23:47:59 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yu9bac713-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 23:47:59 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02I3jKnP031502;
        Wed, 18 Mar 2020 03:47:59 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 2yrpw6mqpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 03:47:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I3lv3L62587384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 03:47:57 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 685336A04D;
        Wed, 18 Mar 2020 03:47:57 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B2D6A047;
        Wed, 18 Mar 2020 03:47:55 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.58.52])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Mar 2020 03:47:55 +0000 (GMT)
X-Mailer: emacs 27.0.90 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Ext4 corruption with VM images as 3 > drop_caches
Date:   Wed, 18 Mar 2020 09:17:51 +0530
Message-ID: <87pndagw7s.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_10:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180015
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

With new vm install I am finding corruption with the vm image if I
follow up the install with echo 3 > /proc/sys/vm/drop_caches 

The file system reports below error.

Begin: Running /scripts/local-bottom ... done.
Begin: Running /scripts/init-bottom ...
[    4.916017] EXT4-fs error (device vda2): ext4_lookup:1700: inode #787185: comm sh: iget: checksum invalid
done.
[    5.244312] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
[    5.257246] EXT4-fs error (device vda2): ext4_lookup:1700: inode #917954: comm init: iget: checksum invalid
/sbin/init: error while loading shared libraries: libc.so.6: cannot open shared object file: Error 74
[    5.271207] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00

And debugfs reports

debugfs:  stat <917954>
Inode: 917954   Type: bad type    Mode:  0000   Flags: 0x0
Generation: 0    Version: 0x00000000
User:     0   Group:     0   Size: 0
File ACL: 0
Links: 0   Blockcount: 0
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x00000000 -- Wed Dec 31 18:00:00 1969
atime: 0x00000000 -- Wed Dec 31 18:00:00 1969
mtime: 0x00000000 -- Wed Dec 31 18:00:00 1969
Size of extra inode fields: 0
Inode checksum: 0x00000000
BLOCKS:
debugfs:  

Bisecting this finds 
Commit 244adf6426ee31a83f397b700d964cff12a247d3("ext4: make dioread_nolock the default")
as bad. If I revert the same on top of linus upstream(fb33c6510d5595144d585aa194d377cf74d31911)
I don't hit the corrupttion anymore.

-aneesh

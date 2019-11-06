Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A2F137E
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKFKMM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:12:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbfKFKMM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:12:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6A63ht051306
        for <linux-ext4@vger.kernel.org>; Wed, 6 Nov 2019 05:12:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3v4d85qe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 06 Nov 2019 05:12:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 6 Nov 2019 10:12:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 10:12:06 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6AC45R42205354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 10:12:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4510A405B;
        Wed,  6 Nov 2019 10:12:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73814A4059;
        Wed,  6 Nov 2019 10:12:03 +0000 (GMT)
Received: from [9.199.158.77] (unknown [9.199.158.77])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 10:12:03 +0000 (GMT)
Subject: Re: [bug report] ext4: Add support for blocksize < pagesize in
 dioread_nolock
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
References: <20191106082505.GA31923@mwanda>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 6 Nov 2019 15:42:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191106082505.GA31923@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110610-4275-0000-0000-0000037B41BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110610-4276-0000-0000-0000388E8EFD
Message-Id: <20191106101203.73814A4059@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911060102
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Dan for reporting this.

On 11/6/19 1:55 PM, Dan Carpenter wrote:
> Hello Ritesh Harjani,
> 
> The patch c8cc88163f40: "ext4: Add support for blocksize < pagesize
> in dioread_nolock" from Oct 16, 2019, leads to the following static
> checker warning:
> 
> fs/ext4/inode.c:2390 mpage_process_page() error: 'io_end_vec' dereferencing possible ERR_PTR()
> fs/ext4/inode.c:2557 mpage_map_and_submit_extent() error: 'io_end_vec' dereferencing possible ERR_PTR()
> fs/ext4/inode.c:3677 ext4_end_io_dio() error: 'io_end_vec' dereferencing possible ERR_PTR()

ext4_end_io_dio func is removed on recent ext4 master branch.
It got removed in ext4 iomap DIO patches. So my patch
(which is based on today's ext4 master branch) does not covers
for ext4_end_io_dio().

-ritesh

